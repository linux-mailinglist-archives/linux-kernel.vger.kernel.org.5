Return-Path: <linux-kernel+bounces-45195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22885842CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE8B23A66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0969DF3;
	Tue, 30 Jan 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gZKQI3vs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D269970
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643093; cv=none; b=MkYYfGQtu0HDTEQ5BrS+lvUe7F1xMrQWd63JsAa+LCL12gLkxdrxCLgnVQqrIW34w7kZgQJJMl1QckDtSjed+7naP9fZ6Lht8/+R4LCc+wRMA96HgpRuBktdumsdIv0d0wII3/QliTipw3LZHL5y/ZFZgGtwd5YH6FQyaCwgJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643093; c=relaxed/simple;
	bh=aNeJssBj+aRNsuDMKwmL1TJ142yvH19m2Er2RCt5LP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8fX+evHyYz86CisF/h8iCHYj+Fz9a2TZuj89/GppFpHLUWrkHa854DzqjjvjiqEHdhhmR66+P7pQ9RmGESn+9qsNGaoVPtF5s+7YEjvGo6QkYEizKoQz6D3cyR0N8m9ajSS9GbXZ2TEBC085JPvBLjjURFs9UMNGhJpa8YXE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gZKQI3vs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0CA0840E016C;
	Tue, 30 Jan 2024 19:31:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dhx-q-ky9JRH; Tue, 30 Jan 2024 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706643086; bh=R2HtjsZaYHaJDIqSnqOTydURjQ4JqiIpNDczBhmWJZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZKQI3vsSE2+hznC/G5SO01tOPTfg0cOAGdDgPPg501GV6LOXnS/NG+32HcwFQv3W
	 Mr1mVBcyD2+Rt78A5MI+/aKKlFgbebLG/u3Hv4n7d71yQcR6LDq5h+HXVOzIUK+1hR
	 TawUUxV2tZnMfqS/SZYhgGwwllmhV0ISOo5ezX6GEcLP+1r5dHmGvjxTUVCwjax0Km
	 jM9aA2M0Rq0gkbpL43CYsY3F1e+Pj2oS2EGBnHFu8UBOqA9MPoU2E/DeltyRK2C2oM
	 CQ2PgcXEYcfCi4O4VqrC16waE1qwNx+uyqvsj5EOuQRiaCcMqTOKoilgpYhFGSI63k
	 24RtwxcTpqRMmmPlqVjLqQO27E00gsvaPCIKYVKyhFKuYgzIU/CHZaRD1lqnPeOwL2
	 eMLl3uWhuHjMgpsobnRWGLvglx0N3LuI9SHXMqeXv+GnDMBuiVI4VBo/reiNBlAMw2
	 s3UlntkySVbMbYL5/VysuFCn5evp4RbNgmrqAsFeZX0wtLcDa/JsCk52cBvndpOoM1
	 scN9OtWr+E8CSYCtLpBSV2W18d1VYQC45wlQ/VAOxbofKeUMTwO624tRqzQalzzCF3
	 di1e7s3d4YZhCusjwmES0Fg9ZDxyJbKRmaCUR6gPUxEiaOMcCE9w1rLeXHNO3X1hIa
	 yPj5301IPc6DwX4hTjV211ZY=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DC8A40E00C5;
	Tue, 30 Jan 2024 19:31:08 +0000 (UTC)
Date: Tue, 30 Jan 2024 20:31:02 +0100
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
Subject: Re: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Message-ID: <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.674834306@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:39PM +0100, Thomas Gleixner wrote:
> +static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,

"parse_topo_subleaf"?

With a verb in the name...

> +				unsigned int *last_dom)
> +{
> +	unsigned int dom, maxtype;
> +	const unsigned int *map;
> +	struct {
> +		// eax

Can we please not use those yucky // comments together with the
multiline ones?

> +		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
> +					      // for the topology ID at the next level
> +					: 27; // Reserved
> +		// ebx
> +		u32	num_processors	: 16, // Number of processors at current level
> +					: 16; // Reserved
> +		// ecx
> +		u32	level		:  8, // Current topology level. Same as sub leaf number
> +			type		:  8, // Level type. If 0, invalid
> +					: 16; // Reserved
> +		// edx
> +		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
> +	} sl;

..

> +static bool parse_topology_leaf(struct topo_scan *tscan, u32 leaf)
> +{
> +	unsigned int last_dom;
> +	u32 subleaf;
> +
> +	/* Read all available subleafs and populate the levels */
> +	for (subleaf = 0, last_dom = 0; topo_subleaf(tscan, leaf, subleaf, &last_dom); subleaf++);
> +
> +	/* If subleaf 0 failed to parse, give up */
> +	if (!subleaf)
> +		return false;
> +
> +	/*
> +	 * There are machines in the wild which have shift 0 in the subleaf
> +	 * 0, but advertise 2 logical processors at that level. They are
> +	 * truly SMT.
> +	 */
> +	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN] > 1) {
> +		unsigned int sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
> +
> +		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs\n",
> +			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);

Do you really wanna warn about that? Hoping that someone would do
something about it while there's time...?

> +		topology_update_dom(tscan, TOPO_SMT_DOMAIN, sft, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
> +	}
> +
> +	set_cpu_cap(tscan->c, X86_FEATURE_XTOPOLOGY);
> +	return true;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

