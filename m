Return-Path: <linux-kernel+bounces-48366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4E845AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD8D1F28B73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001FC62166;
	Thu,  1 Feb 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hSnc92Qj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17D62161
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800066; cv=none; b=i4eyAzduNMHdxL30oXM10ykXXX63po33qWhi9ewfzbs0cGCq0nVeR9Igm9XxTWUGCYAf+aH2tBBU89WO+17qwdPDConSpox6ykI0hjRZulmFgFC2bIKU1u2uA/KRUEdZe+mfPrA8JtevqVARBLNBuiByNDFvoW5zfiYRzItKyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800066; c=relaxed/simple;
	bh=XBjclBTOSkTVxZ8Ts8UOn2p1Y4rHi0XFMqzczpYcWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI3iz9s0X+WTc5mtiFfGJXhohpcqUxnU8YRzuLGKCcKcm6+Mgses60NEEPQlA/i0THI7Ltcjim/Qpq3v/KVTzT6hxXqIZqy+HWy+HQKT7CmokI5kjjbU8Swh/pPSSu8+32F2oqZ4BtfJZj7/Zsu9qYuDJ1oDlEgi7P0Ugqg/za0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hSnc92Qj reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BA9940E01B0;
	Thu,  1 Feb 2024 15:07:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i2-zDSo717nE; Thu,  1 Feb 2024 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706800058; bh=d4iyIeD5VB3Lh3K5SmTuEl5mGkX/rk36fJBsXttyW+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSnc92Qjdpopu51jhVHaXiKPgRHplRfPmeIEo34/HYtD7GFZVwMfJhNl1cy0XVnLN
	 h96Jrh7B7MoNe1H3H6xmLTaDCe+MZl+ysJIxaDPew7KKqjTCHafwbBloR6Gyeb0te2
	 Lmg5/1jLWdtjtFE3qnSgR5egDtQnAfKxr9rWEkcRFhVMIUH/mX1rVCQXCIzVtnxAGH
	 gQznCMspHpi3leCkIPfr7L2pcu4VU6sSCPL8gDG8C5JRVGM6HZLnEfAkIA3YvJm/iq
	 u+ONZQDZkuJNbf5qqmfAHypEW3nGwlHJvJtstVhy9tPsMEzc+NKRUnTJpKLnhwEp3M
	 HRUQDzU73PKO51zj4SQty2alSU8sdS4r/OcJuXj4blkrMS29YW6ylhv6tICoPgrKBj
	 miOR/aRatUQGZH9ptaSbL7woE/s1kXT8ldvb7pHQKZe1htSeT5kEQbvJqtLChmXhbh
	 HhaxHQ3nJS9i3EyYCWXLoUqmyk7xFkex8Xhk4jBeXg8knctU7yde4IBjEmhGrVQndH
	 B8fgqFiDRdoG9ZBVnSLAJrFkr71YX9J0hXPUKp/SQeHXMUNer5+K36/NiIChovWAaz
	 c2o4wyMiB0GQ45ShsDLmWcknrUXX3vnIrLEUtu7bH9c3o67lkEooDYBvVWojTRCDJf
	 B/4pCcVbgqWlR+pyLI8D9ub8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3087C40E01A2;
	Thu,  1 Feb 2024 15:07:20 +0000 (UTC)
Date: Thu, 1 Feb 2024 16:07:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 07/19] x86/cpu: Use common topology code for Intel
Message-ID: <20240201150719.GKZbuzp5_4Bi0kZ3t9@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.740438007@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.740438007@linutronix.de>
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:53:40PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> Intel CPUs use either topology leaf 0xb/0x1f evaluation or the legacy
> SMP/HT evaluation based on CPUID leaf 0x1/0x4.
>=20
> Move it over to the consolidated topology code and remove the random
> topology hacks which are sprinkled into the Intel and the common code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Tested-by: Sohil Mehta <sohil.mehta@intel.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
>=20
>=20
> ---
>  arch/x86/kernel/cpu/common.c          |   65 -------------------------=
---------
>  arch/x86/kernel/cpu/cpu.h             |    4 --
>  arch/x86/kernel/cpu/intel.c           |   25 -------------
>  arch/x86/kernel/cpu/topology_common.c |    5 ++
>  4 files changed, 4 insertions(+), 95 deletions(-)

Right:

arch/x86/kernel/cpu/topology.c:62:5: warning: no previous prototype for =E2=
=80=98detect_extended_topology_early=E2=80=99 [-Wmissing-prototypes]
   62 | int detect_extended_topology_early(struct cpuinfo_x86 *c)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

That one is already unused after this one - might zap it here.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

