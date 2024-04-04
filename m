Return-Path: <linux-kernel+bounces-131090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59848982F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14731C20F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18CC67A0A;
	Thu,  4 Apr 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kiUYI1ou"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA0210E4;
	Thu,  4 Apr 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218673; cv=none; b=Y86jqiJyE9u00121aNKbhodw/AB1H8chAOcnNPCpAFZSQmmcdr8I2SF4iFc1nv4EicT21laXxw6yKwpQNyr3OIp9JQzolQNZNF3+wS2eCC9cccaLwd3N6XJFUA6menuqpiQ0Z5wKOqmQ5qVUk+nnMXdhxFrJphcDJLxFGKv/m1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218673; c=relaxed/simple;
	bh=a04Cb2BcyVX9jhqC6vtIILvSpbNtaa5eg83cdWddhqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSonTZvCwLvF6xU/CogueB/7ZlxlZqjrljcOWDuQZG6DVBUiK2oiee/f2qPiKLLxpE49BExlA8fhU3sO5zzBD6squXTaf4nUOyHWwS0ImzDXIXoTfrJhBi+ovCisKp7dOUUqBdGIYL6GVf+8PIt80W31heEhIY6zczvv2Z4yVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kiUYI1ou; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1112)
	id 1DFEF20E8FC0; Thu,  4 Apr 2024 01:17:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1DFEF20E8FC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712218665;
	bh=1fa86v2yTAS/llsv5uOSTC/qT7DwBGOZMeDPleZzIic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiUYI1oun1ajVVbaiMD7RX1hixxNLB4ZocH/zDYyajTH2xMytv8ztOz7pzqvGSNLX
	 6EInUKK1N7UzjnM5LfRgvGZpjwY/TPFo+Y+MEKqbri9WuDoUW7S6yKxEIQ0TZN/a4R
	 F9YhY7m+q9LUy3nZi3P2uqYrIFEYJ3pwIRxZd/pY=
Date: Thu, 4 Apr 2024 01:17:45 -0700
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-tip-commits@vger.kernel.org, bp@alien8.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240404081745.GA15636@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
 <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
 <b2da0a15-c0f5-49a7-b34c-eb408e9aa293@amd.com>
 <20240402224222.vxaqenqvyi32zleb@amd.com>
 <ff810b13-b534-4e4f-a2e2-3cdf2b563494@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff810b13-b534-4e4f-a2e2-3cdf2b563494@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 03, 2024 at 04:08:35PM -0500, Kalra, Ashish wrote:
> 
> On 4/2/2024 5:42 PM, Michael Roth wrote:
> >On Tue, Apr 02, 2024 at 05:31:09PM -0500, Kalra, Ashish wrote:
> >>On 4/2/2024 5:09 PM, Tom Lendacky wrote:
> >>>On 3/12/24 13:47, Ashish Kalra wrote:
> >>>>From: Ashish Kalra <ashish.kalra@amd.com>
> >>>>
> >>>>RMP table start and end physical range may not be aligned to 2MB in
> >>>>the e820 tables causing fatal RMP page faults during kexec boot when
> >>>>new page allocations are done in the same 2MB page as the RMP table.
> >>>>Check if RMP table start and end physical range in e820_table is not
> >>>>aligned to 2MB and in that case use e820__range_update() to map this
> >>>>range to reserved.
> >>>>
> >>>>Override e820__memory_setup_default() to check and apply these RMP table
> >>>>fixups in e820_table before e820_table is used to setup
> >>>>e280_table_firmware and e820_table_kexec.
> >>>>
> >>>>Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU
> >>>>feature")
> >>>>Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> >>>>---
> >>>>   arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
> >>>>   1 file changed, 52 insertions(+)
> >>>>
> >>>>diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> >>>>index cffe1157a90a..e0d7584df28f 100644
> >>>>--- a/arch/x86/virt/svm/sev.c
> >>>>+++ b/arch/x86/virt/svm/sev.c
> >>>>@@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
> >>>>   static struct rmpentry *rmptable __ro_after_init;
> >>>>   static u64 rmptable_max_pfn __ro_after_init;
> >>>>   +static char *__init snp_rmptable_e820_fixup(void);
> >>>>+
> >>>>   static LIST_HEAD(snp_leaked_pages_list);
> >>>>   static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
> >>>>   @@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
> >>>>       pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
> >>>>           probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
> >>>>   +    /*
> >>>>+     * Override e820__memory_setup_default() to do any RMP table fixups
> >>>>+     * for kexec if required.
> >>>>+     */
> >>>>+    x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
> >>>This produces a build warning:
> >>>
> >>>WARNING: modpost: vmlinux: section mismatch in reference:
> >>>snp_probe_rmptable_info+0x95 (section: .text) -> x86_init (section:
> >>>.init.data)
> >>>WARNING: modpost: vmlinux: section mismatch in reference:
> >>>snp_probe_rmptable_info+0x99 (section: .text) -> snp_rmptable_e820_fixup
> >>>(section: .init.text)
> >>>
> >>Oh, so this requires snp_probe_rmptable_info() to be fixed to use the __init
> >>macro.
> >>
> >>I believe that snp_probe_rmptable_info() should be anyway using the __init
> >>macro and this fix for snp_probe_rmptable_info() needs to be sent as a
> >>separate patch and regardless of this patch getting merged or not.
> >I think you'll hit issues with:
> >
> >   bsp_determine_snp() ->           //non-__init
> >     snp_probe_rmptable_info()      //__init
> >
> >and bsp_determine_snp() sticks around as a function pointer assigned to
> >cpuinfo_x86 so I don't think you can use __init there.
> >
> >So might need to just drop __init from snp_rmptable_e820_fixup().
> 
> Actually, that will not help as snp_probe_rmptable_info() is *also*
> accessing x86_init.resources.memory_setup
> 

What if we flipped the whole flow? Borislav is adding a CC_ATTR to indicate
HOST_SEV_SNP support, we don't need to clear X86_FEATURE_SEV_SNP at this phase
(or at all for that matter). snp_probe_rmptable_info() can be done later
during kernel init, once e820 has been parsed.

One way of doing this would be to override x86_init.resources.memory_setup()
to do both snp_probe_rmptable_info() and snp_rmptable_e820_fixup().

What do you think?

