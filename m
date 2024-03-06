Return-Path: <linux-kernel+bounces-94481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E2874069
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A559B22026
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75362140366;
	Wed,  6 Mar 2024 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpdDGX21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF560250
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753463; cv=none; b=SisbERvG6D/ckpY9VNOTiH2oEGVqXtghBmVcKVWfOQ1K5M7bEugaYiFp65OYVgNOMR7kLMYK38CsY814EBdaZdVAa/TbBMXqhwXG+2oy1CfYQkIfdHgKjhaBJwWkpduQu6EVMtNC53KhJY62qb2FjF8JpdLpeLgM1tu5c4lv0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753463; c=relaxed/simple;
	bh=dZejzDtOwNBcY1Csz/PwMQsoTNS21ghdsMm5cjM+xQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaI3gR/PYGjqYealMMJNElNpIZR2dwEFH0D4ZJ+qQNAEyAkvFQ75mtt7WAv2ROc1C8qr/x1rKgdk0e3qiHi2pdtm8L4iaEeDnXEK1jK0dXkTXNcEkFeccZrEfvgnayHOxmZ00YGx0gW7nwSx2cfJJCtKa+ZucER4+lBuHVSB4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpdDGX21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE88FC433C7;
	Wed,  6 Mar 2024 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709753463;
	bh=dZejzDtOwNBcY1Csz/PwMQsoTNS21ghdsMm5cjM+xQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpdDGX21PfDcW40OoRhD8mgrM6fbccviuPt8URrm/zYuiz7cdKa1ikDblf2PuZK7q
	 qz+D++q5QIATixs2NuP7oHxKi9A3ksnffg4Q0FOJAcyGeT94Go4BqURlK7WZyGLkX4
	 BjH3HeFocLRB7grjDJ0jE6UTZoNT5BSgczHXJ5Q19jDo1KmfQyZ1I6OZ+ve8PmT8IC
	 WUtOo3hebAiJA6SudCa2DPPQbuJwChT3v95aS596Ogl/O9ch9o7c8e+8IwBFCF+aUN
	 iO6GmsHFGcvs/aRgeH8qw0pUU8J/pn3y95tkyJEJEKmC90kyU1ND6F6Tarf5rGJBSx
	 ZzAmZ1H28CB4w==
Date: Wed, 6 Mar 2024 11:31:01 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, xrivendell7@gmail.com, ardb@kernel.org,
	jbaron@akamai.com, peterz@infradead.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Message-ID: <20240306193101.s2g33o4viqi2azf3@treble>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
 <20240306105420.6a6bea2c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306105420.6a6bea2c@gandalf.local.home>

On Wed, Mar 06, 2024 at 10:54:20AM -0500, Steven Rostedt wrote:
> Now I guess the question is, why is something trying to disable something
> that is not enabled? Is the above scenario OK? Or should the users of
> static_key also prevent this?

Apparently that's an allowed scenario, as the jump label code seems to
be actively trying to support it.  Basically the last one "wins".

See for example:

  1dbb6704de91 ("jump_label: Fix concurrent static_key_enable/disable()")

Also the purpose of the first atomic_read() is to do a quick test before
grabbing the jump lock.  So instead of grabbing the jump lock earlier,
it should actually do the first test atomically:

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8..f29c47930d46 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -191,11 +191,14 @@ EXPORT_SYMBOL_GPL(static_key_slow_inc);
 
 void static_key_enable_cpuslocked(struct static_key *key)
 {
+	int tmp;
+
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
-	if (atomic_read(&key->enabled) > 0) {
-		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
+	tmp = atomic_read(&key->enabled);
+	if (tmp != 0) {
+		WARN_ON_ONCE(tmp != 1);
 		return;
 	}
 
@@ -222,11 +225,14 @@ EXPORT_SYMBOL_GPL(static_key_enable);
 
 void static_key_disable_cpuslocked(struct static_key *key)
 {
+	int tmp;
+
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
-	if (atomic_read(&key->enabled) != 1) {
-		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
+	tmp = atomic_read(&key->enabled);
+	if (tmp != 1) {
+		WARN_ON_ONCE(tmp != 0);
 		return;
 	}
 

