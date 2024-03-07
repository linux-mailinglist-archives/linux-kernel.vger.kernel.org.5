Return-Path: <linux-kernel+bounces-94824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B68745A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9984B22F17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B936AA1;
	Thu,  7 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt3vEybg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0063B8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775012; cv=none; b=ZVHlgR4tehPN4XXpzdjF8LEoeU6WbXFWULAq2X/vE2HMSRHYoOXcswgDiOl2NvDB0JeUB20vaFVhRJsBzuZ/4FLHLprUgXzfw1UPq3wtC+8+6XyxpuSzzbmhbq3lfWXLkcwVVkha/bEekFPGcqI1iO9g+NEPJhOyu+enRlxfWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775012; c=relaxed/simple;
	bh=3iEyCAOIpIr+olvkgpU7l0MpcoipYtMImoe35an3NbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL1Efp4QJy59q0JtTf6GnMicCL7psT5kZ87KdOHS7o16XbIoWSVU1XzzdZvW35uM+uTOQYlmAAajI6Vy5muh/DmxftWlCd1Nd7hzJb5LUR/CHoiYSTHzVIf+RRTrGbzevsVWXWc65gcacggrlMIPWebZymFxdpS/sP96kb2HxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt3vEybg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99348C433C7;
	Thu,  7 Mar 2024 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709775012;
	bh=3iEyCAOIpIr+olvkgpU7l0MpcoipYtMImoe35an3NbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dt3vEybgbCDhmPIzPNp15wv/LSmpaIdJyanOUje6Kg2JNG0WyAqol6dA5vQqYgSbX
	 ZfjujaGjut999mzEYrAZKINbQhKWRKT9u1Ca/qh8gEPqbfvVKemiYfUlMwvy2WubHO
	 CoLqUEZ81VnfsxdDth9a76dSXYtrJkpP+MlSsHJIg+9R4+bMW3fN/fbSSHCmZD/8OD
	 0QUcGm4WjcS5WRYs8M0URCHkCuZAhEnx5wXD0Glz4lxGX9FnIYo+e7VVuTX8ltJb7E
	 2teRBj6ORHEXCNejKzyHW7vcqEsVUD5rzQO3iLO5uHXhwb2hHGuK9SHjGjMUGc54mV
	 yAHYmDdE4bTqg==
Date: Wed, 6 Mar 2024 17:30:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	xrivendell7@gmail.com, ardb@kernel.org, peterz@infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Message-ID: <20240307013009.erbnug2mopx5yrnf@treble>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
 <20240306105420.6a6bea2c@gandalf.local.home>
 <20240306193101.s2g33o4viqi2azf3@treble>
 <854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>
 <20240306221650.sw3lha7kca2quv63@treble>
 <8f586bd2-c436-4334-92af-762a284e1101@akamai.com>
 <20240306234253.zporv6cypoc7yihs@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306234253.zporv6cypoc7yihs@treble>

On Wed, Mar 06, 2024 at 03:42:55PM -0800, Josh Poimboeuf wrote:
> On Wed, Mar 06, 2024 at 05:40:11PM -0500, Jason Baron wrote:
> > On 3/6/24 5:16 PM, Josh Poimboeuf wrote:
> > > On Wed, Mar 06, 2024 at 03:12:07PM -0500, Jason Baron wrote:
> > > > On 3/6/24 2:31 PM, Josh Poimboeuf wrote:
> > > > > On Wed, Mar 06, 2024 at 10:54:20AM -0500, Steven Rostedt wrote:
> > > > > > Now I guess the question is, why is something trying to disable something
> > > > > > that is not enabled? Is the above scenario OK? Or should the users of
> > > > > > static_key also prevent this?
> > > > > 
> > > > > Apparently that's an allowed scenario, as the jump label code seems to
> > > > > be actively trying to support it.  Basically the last one "wins".
> > > > > 
> > > > > See for example:
> > > > > 
> > > > >     1dbb6704de91 ("jump_label: Fix concurrent static_key_enable/disable()")
> > > > > 
> > > > > Also the purpose of the first atomic_read() is to do a quick test before
> > > > > grabbing the jump lock.  So instead of grabbing the jump lock earlier,
> > > > > it should actually do the first test atomically:
> > > > 
> > > > Makes sense but the enable path can also set key->enabled to -1.
> > > 
> > > Ah, this code is really subtle :-/
> > > 
> > > > So I think a concurrent disable could then see the -1 in tmp and still
> > > > trigger the WARN.
> > > 
> > > I think this shouldn't be possible, for the same reason that
> > > static_key_slow_try_dec() warns on -1:  key->enabled can only be -1
> > > during the first enable.  And disable should never be called before
> > > then.
> > 
> > hmm, right but I think in this case the reproducer is writing to a sysfs
> > file to enable/disable randomly so i'm not sure if there is anything that
> > would enforce that ordering. I guess you could try the reproducer, I haven't
> > really looked at it in any detail.
> > 
> > The code in question here is in mm/vmscan.c which actually already takes the
> > local 'state_mutex' for some cases. So that could be extended I think easily
> > to avoid this warning.
> 
> Hm, right... For now I'll just continue to allow "disable before enable"
> (or "double disable") since it may be harmless and I don't want to
> introduce any unnecessary constraints, unless we manage to convince
> ourselves that it's the right thing to do.

So, I think we can simplify this nicely by getting rid of the whole -1
thing altogether:

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8..ef7eda7685b2 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -194,20 +194,15 @@ void static_key_enable_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
-	if (atomic_read(&key->enabled) > 0) {
-		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
+	if (atomic_read(&key->enabled) == 1)
 		return;
-	}
-
 	jump_label_lock();
-	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+
+	if (atomic_cmpxchg(&key->enabled, 0, 1) == 0)
 		jump_label_update(key);
-		/*
-		 * See static_key_slow_inc().
-		 */
-		atomic_set_release(&key->enabled, 1);
-	}
+	else
+		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
+
 	jump_label_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);
@@ -225,14 +220,16 @@ void static_key_disable_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
-	if (atomic_read(&key->enabled) != 1) {
-		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
+	if (atomic_read(&key->enabled) == 0)
 		return;
-	}
 
 	jump_label_lock();
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
+	else
+		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
+
 	jump_label_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);

