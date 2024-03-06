Return-Path: <linux-kernel+bounces-94197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C15873B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02901F25F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35B1361D3;
	Wed,  6 Mar 2024 15:52:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E97135A72
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740350; cv=none; b=eeoI7xwEgnSKcO1zPHuIs3OnKwWC2O47xT+e3eaoXEN0MfiCoHosOTwAg/buCL1Od6AMrj6GVr19yf3EQwLRjRUG44YJf/MEOn9VhduQJXkaHLjmpEdIH4733U4GNCiG73XQBeStjGvTW5YxDZKA+yKQ01z+WQQP83g0W0HyWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740350; c=relaxed/simple;
	bh=CWhU91WDJ+IUTp7tX3uVK1SsCEBfhsgXGPayXUKkAtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmEGREe3Qcx3B07uYQwGywsiPaO2oRfzm5oeLEVRZZ93kXEmh6Qbd8aEad8JkgM2EAB2IbYHmLAJBrE5ybeF3yYWCLzSMbVI0JvRtG160SKHqGpYcOusWjwV5LVfR8CFnLzGFirijsViq6R+/YIibnxwdnMzkD9bO27kYd/ODnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B865C433C7;
	Wed,  6 Mar 2024 15:52:28 +0000 (UTC)
Date: Wed, 6 Mar 2024 10:54:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 xrivendell7@gmail.com, ardb@kernel.org, jbaron@akamai.com,
 jpoimboe@kernel.org, peterz@infradead.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Message-ID: <20240306105420.6a6bea2c@gandalf.local.home>
In-Reply-To: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 15:54:24 +0800
Sam Sun <samsun1006219@gmail.com> wrote:

> We analyzed the cause of this bug. It seems that in function
> static_key_disable_cpuslocked(), there is a small racing window
> between two atomic_read(&key->enabled) in line 228 & 229, triggering
> the WARN_ON_ONCE macro. This might cause function returned without
> actually disabling the static_key "key". I am not sure if there is any
> other potential threat here.
> 
> I searched on web and found that there was a similar bug reported by
> syzbot several years ago
> (https://groups.google.com/g/syzkaller-bugs/c/_W3lgRCwlb4/m/TqzyQcPpAQAJ).
> At that time the fix was in the net instead of kernel/jump_label.c. So
> I checked the call stack and cc this email to memory management
> maintainers. Hope there is no confusion.
> 
> If you have any questions, please contact us.
> Reported by: Yue Sun <samsun1006219@gmail.com>
> Reported by: xingwei lee <xrivendell7@gmail.com>

Thanks for the report. I wonder if it simply needs to add the tests in the
locking? Like the patch below.

Because I could see:

	CPU 0				CPU 1
	-----				-----

key->enabled = 0
        
 static_key_enable_cpus_locked()
   jump_label_lock();
				  static_key_disable_cpus_locked()
				      if (key->enabled != 1) {

    key->enabled = 1;
				          WARN_ON(key->enabled != 0)

Now I guess the question is, why is something trying to disable something
that is not enabled? Is the above scenario OK? Or should the users of
static_key also prevent this?

-- Steve


diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8..f154caf2a62b 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -194,12 +194,12 @@ void static_key_enable_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
+	jump_label_lock();
 	if (atomic_read(&key->enabled) > 0) {
 		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
-		return;
+		goto unlock;
 	}
 
-	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
 		atomic_set(&key->enabled, -1);
 		jump_label_update(key);
@@ -208,6 +208,7 @@ void static_key_enable_cpuslocked(struct static_key *key)
 		 */
 		atomic_set_release(&key->enabled, 1);
 	}
+unlock:
 	jump_label_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);
@@ -225,14 +226,15 @@ void static_key_disable_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
+	jump_label_lock();
 	if (atomic_read(&key->enabled) != 1) {
 		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
-		return;
+		goto unlock;
 	}
 
-	jump_label_lock();
 	if (atomic_cmpxchg(&key->enabled, 1, 0))
 		jump_label_update(key);
+unlock:
 	jump_label_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);

