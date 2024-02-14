Return-Path: <linux-kernel+bounces-64903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28785447D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A809B26BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F391579F4;
	Wed, 14 Feb 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BBkhg/2c"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E579C0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901305; cv=none; b=iBjjG6fWjeIlIvk9774hO3R5FOj9CGO42XbOmaFipKRwvmrxtk0RHlEXn3/S6a3xTs/8VhthY0M4BMfNqr3SMmwAgzO/f9x/rs0s32ozJhOsKSXthEtJ5D3TEoSb23nvc7X2/Xd880AnIHm/Poe7anPACB4iSYgPCWjkP++cz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901305; c=relaxed/simple;
	bh=rVGyWvVFyRsLDqBCpY9swRjnG36wOAV4a+EPdavhwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVQcsh6d08D74f5q+KWRrivfmtyBTQbjuNN4M1j+9XcMedWqbzVo8ZthcekrlIMeia54QOykU3iyH9/fJiHvXAsgzH1onYjNbUDjDQ0QesnqMwFF2dhJCozPKDMsdkXSIvZ56q5Jvn0qksC0M4LmDkDEgCybgnEfDM07yjlRTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BBkhg/2c reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF52140E016C;
	Wed, 14 Feb 2024 09:01:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JZfeISjeEu0e; Wed, 14 Feb 2024 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707901298; bh=rLdOtQOfh1UfG8Cn92KapL1Eu7yP6XBs8mjWI33kxGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBkhg/2ciQYgJxsJ6C0ntUnnShFinKwl3kW9xnWWLwc17kDv6efvKK155ay6iAI9i
	 EWXBWGfz22xCApcblxgAVIesN9KijSZbGqO04IYgMMQM8lXpaHtpH6Ta15lgXxiVPO
	 6HQe/QLPEl1Zutgj4vv7y9o9aRQiJxC6ZVwNFsCbeFR436kWYZCO1DpmR/AmgP0uKH
	 Z9D1o+uNFrREVfXylq0yQMN/eS7BD+qoLvVqMmxIXzUYD2HbWdLBkIOW3etnaJr/vx
	 FoaC9i1YhqpndlA0pV1x1RvZn6DVRIT6KCH7ZR9Mr/KA4lWeJCvUnEiH01O8WWwFN0
	 jZ8sfP8n4QURx+ddoHw4aqXa6NYrooLHFGZ72UvxgZx9udpknCgC4t+vpYBgsB7eOB
	 ADCGncjQrpF4BjaD0Wl6RfmUyElBhgISw1NfkIaTZLPRATg0uQ7xQv3MDV/jR/oR3j
	 /bnrqZDSgZmNiqtDsEkkpz9mR2Hcby3xrM1BbKaj3Dbxi3rWasJ+NI2oIVCp7Jd4f7
	 h0Dc0f/E6uamzwVGP9GDzJoisLLVUDKzNtn8Rpf+iZ6RFpPPKfy17P0Qq5+1Aw4e5x
	 hiEZaqEm7TIaQz98kOb7G817fBNwk1dG2TCfFusXXRmLp3r71clq4YupoeOJD/eSkA
	 hJYaMKfizoGoEZe6hGEOtAQE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E676040E00B2;
	Wed, 14 Feb 2024 09:01:32 +0000 (UTC)
Date: Wed, 14 Feb 2024 10:01:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] hrtimer: select housekeeping CPU during migration
Message-ID: <20240214090127.GAZcyBZ9mRTrSOoCSR@fat_crate.local>
References: <20240211135213.2518068-1-costa.shul@redhat.com>
 <20240213164650.2935909-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213164650.2935909-3-costa.shul@redhat.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 06:46:51PM +0200, Costa Shulyupin wrote:
> During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
> compromising CPU isolation. This commit addresses this issue by
> masking valid CPUs for hrtimers using housekeeping_cpumask(HK_TYPE_TIME=
R).
>=20
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>=20
> Changes in v2:
> - [v1] https://lore.kernel.org/all/20240211135213.2518068-1-costa.shul@=
redhat.com/
> - reworded and rebased on linux-next
> ---
>  kernel/time/hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index edb0f821dcea..947bd6cf7105 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2224,7 +2224,7 @@ static void migrate_hrtimer_list(struct hrtimer_c=
lock_base *old_base,
>  int hrtimers_cpu_dying(unsigned int dying_cpu)
>  {
>  	struct hrtimer_cpu_base *old_base, *new_base;
> -	int i, ncpu =3D cpumask_first(cpu_active_mask);
> +	int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE=
_TIMER));
							^^^^^^^^^^^^^^
How was this patch tested?

It even says housekeeping_cpumask() in the commit message so the
*intent* to use the correct function is there:

kernel/time/hrtimer.c: In function =E2=80=98hrtimers_cpu_dying=E2=80=99:
kernel/time/hrtimer.c:2226:56: error: implicit declaration of function =E2=
=80=98housekeeping=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 2226 |         int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekee=
ping(HK_TYPE_TIMER));
      |                                                        ^~~~~~~~~~=
~~
/include/linux/cpumask.h:774:67: note: in definition of macro =E2=80=98c=
pumask_any_and=E2=80=99
  774 | #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), =
(mask2))
      |                                                                  =
 ^~~~~
kernel/time/hrtimer.c:2226:69: error: =E2=80=98HK_TYPE_TIMER=E2=80=99 und=
eclared (first use in this function)
 2226 |         int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekee=
ping(HK_TYPE_TIMER));
      |                                                                  =
   ^~~~~~~~~~~~~
/include/linux/cpumask.h:774:67: note: in definition of macro =E2=80=98c=
pumask_any_and=E2=80=99
  774 | #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), =
(mask2))
      |                                                                  =
 ^~~~~
kernel/time/hrtimer.c:2226:69: note: each undeclared identifier is report=
ed only once for each function it appears in
 2226 |         int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekee=
ping(HK_TYPE_TIMER));
      |                                                                  =
   ^~~~~~~~~~~~~
/include/linux/cpumask.h:774:67: note: in definition of macro =E2=80=98c=
pumask_any_and=E2=80=99
  774 | #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), =
(mask2))
      |                                                                  =
 ^~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:243: kernel/time/hrtimer.o] Error 1
make[3]: *** [scripts/Makefile.build:481: kernel/time] Error 2
make[2]: *** [scripts/Makefile.build:481: kernel] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1921: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2

This makes it build again at least:

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2cbdf64d746c..6057fe2e179b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -38,6 +38,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
@@ -2223,7 +2224,7 @@ static void migrate_hrtimer_list(struct hrtimer_clo=
ck_base *old_base,
=20
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
-	int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_T=
IMER));
+	int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping_cpumask(H=
K_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
=20
 	tick_cancel_sched_timer(dying_cpu);


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

