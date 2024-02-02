Return-Path: <linux-kernel+bounces-49845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993B0847062
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55397296F38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3CD15AB;
	Fri,  2 Feb 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D56drevp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAC4206C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877046; cv=none; b=gfyqMDE/o+dy9sfxZym30trNSBRkESN/XM4ZiNrsVvVgOjb6Iiw3+0L0TmH/V/vau2F/+ylMPAT4tiYXukZGCB2Vq1WZs776SYA14icOa1rD2rzUaPw3XswsexaFr0gk+3Q2bsRy7aKPBBKbw4bz6x+NdBUiXZuKe8TPewrtrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877046; c=relaxed/simple;
	bh=6kSFMQfQ6yQnGE0Dw7Q4P+dZOQf+sdUi8tqFp7CM+Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njT5JaWsfPHx7X3KKJW2nlD0aHWKewM6WJ8LZIp7vP7tQfFF5xaSJE+6ctFBZq7q/nRPKDF0P6SBKzd38IK4XNuOU2dFz8HeDbjgFfINL/g2sn2Uwsf+Rky/mvyJ7RWM86tlXijkL7UDg6ggRLvDtrytAViuJYTVXmizolbgyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D56drevp reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5C2540E01A9;
	Fri,  2 Feb 2024 12:30:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q8sUyCQ-xDJ6; Fri,  2 Feb 2024 12:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706877037; bh=LAnMzrZs6f7RGntop7h3m0eQMyoneTWjdlZan+jFKfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D56drevpdtRq1XgIpZlwYvi7WxSfT7P6hUTd5mxlwFf+YMxwsgFr1B2ChDX/7qC67
	 vfF6XZtUv0oGpQ+6nJrqClUMS8xyif5OmupiwwCewgp/xy4ydsBEkN4GePx8yxK4Ml
	 ORaG3FEYvcgG9fgRS7CkL7lSUqdJngE9pPXXLeCyNXjJejWg2hBXY0BT+OsnPoxgn+
	 LLtWc9GCyfQmm1ZTDYiRM6tLrOJavaA64LmmxicGmSRtiGAJHYG51mcun9SebwrWPk
	 P1WVZ2LtuulUtUy2vDkUO85/Meq62eu99IdT8BJvsPta463pywenL4OcRh+ESFJohU
	 NSm0H6uuAZAB0CM9VD3xEfZWLsz7AZt/f9gKUP5dy8XhZi+eaRezdOjpdIsKlgrjxv
	 a3s60Q3sB8cye6iXhApC3rch3Q0QU45oirO1Mq2IAG5wCFcACAVATTX4caDkZayEok
	 F10xPx0q5qKH3wTSOvYONs3J+S7+u9nSLxqYdVZx56Ihf+KwKvkau6BbPsrdNR1p++
	 aAfSIvQcS+Ha6Cim3hd6cB5fxwD56f0im2A/eFcuCKRsladiXvHXeQjuqFkkdnwOJX
	 cEY+m13WBaAZDlNJzraQDIbstj+LLxHgw+mRPAs7ZlRcXzdEUj+n9ZyxtB9X0+c97O
	 FJpeDDS8khy322bT1X/c0qz8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E80B340E01A2;
	Fri,  2 Feb 2024 12:30:18 +0000 (UTC)
Date: Fri, 2 Feb 2024 13:30:11 +0100
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
Subject: Re: [patch v5 09/19] x86/cpu: Provide an AMD/HYGON specific topology
 parser
Message-ID: <20240202123011.GAZbzgU8jqAYiTe8bH@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.880472059@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.880472059@linutronix.de>
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:53:43PM +0100, Thomas Gleixner wrote:
> +static bool parse_8000_0008(struct topo_scan *tscan)
> +{
> +	struct {
> +		u32	ncores		:  8,

Yeah, so there was some confusion what this field actually means. It is
documented correctly in the latest APM:

"NT: number of physical threads - 1. The number of threads in the
processor is NT+1 (e.g., if NT =3D 0, then there is one thread). See
=E2=80=9CLegacy Method=E2=80=9D on page 645."

> +			__rsvd0		:  4,
> +			apicidsize	:  4,
> +			perftscsize	:  2,
> +			__rsvd1		: 14;
> +	} ecx;
> +	unsigned int sft;
> +
> +	if (tscan->c->extended_cpuid_level < 0x80000008)
> +		return false;
> +
> +	cpuid_leaf_reg(0x80000008, CPUID_ECX, &ecx);
> +
> +	/* If the APIC ID size is 0, then get the shift value from ecx.ncores=
 */
> +	sft =3D ecx.apicidsize;
> +	if (!sft)
> +		sft =3D get_count_order(ecx.ncores + 1);
> +
> +	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.ncores + 1);

So yeah, this should be TOPO_SMT_DOMAIN.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

