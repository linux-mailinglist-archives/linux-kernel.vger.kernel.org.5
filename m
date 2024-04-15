Return-Path: <linux-kernel+bounces-145246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7598A5165
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08371C2250D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791B127E0E;
	Mon, 15 Apr 2024 13:22:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBE126F36;
	Mon, 15 Apr 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187326; cv=none; b=B0ug4cmZiBlZMHo3wM69IDbxzSt9+S7+eCuCws/CCtCpUH4tu2wT4xiX6L6kPmAZlztWF3+FlFoyqbZGLFYrY22Eo1jX6wb3orxmRWDOIPQx7XdDa0EudqmpC1PkYimYjv+KXyD9pe7nSmDVRQd8d5ugcBUizgVofNAqvG9Fb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187326; c=relaxed/simple;
	bh=c9S4lDBsYHRr2v3kQQwGMcvUDoMDtV1vjj4QujV7SMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbB6RTPf3hshSUZc9Jm9dm0W5TTzkAiGL2a6eEQk0vsDuEk6Zuulnpg4e8A5Wp9pujD6S2bY9+Gt1+3ixevBJXuLuAylwbwaoHba19MnbAONHMfE3UOZz2lPpwuhVKcaufDQ3sREhRWa/VosmRZNKpb6H/w3Fox20merAwAfpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47FCDA7;
	Mon, 15 Apr 2024 06:22:27 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D2AF3F7CE;
	Mon, 15 Apr 2024 06:21:57 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:21:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, tiantao6@huawei.com
Subject: Re: [External] Re: [PATCH v2 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
Message-ID: <Zh0p8iJe05d71yZK@bogus>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
 <20240414025826.64025-2-cuiyunhui@bytedance.com>
 <Zhzo_gWFiURs_geD@bogus>
 <CAEEQ3wkzvOpahzPuoD7=aMG3srjdyCA21tnh-j9PvY3Qerk_hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkzvOpahzPuoD7=aMG3srjdyCA21tnh-j9PvY3Qerk_hg@mail.gmail.com>

On Mon, Apr 15, 2024 at 08:03:38PM +0800, yunhui cui wrote:
> Hi Sudeep,
> 
> On Mon, Apr 15, 2024 at 4:45 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Sun, Apr 14, 2024 at 10:58:25AM +0800, Yunhui Cui wrote:
> > > Before cacheinfo can be built correctly, we need to initialize level
> > > and type. Since RSIC-V currently does not have a register group that
> > > describes cache-related attributes like ARM64, we cannot obtain them
> > > directly, so now we obtain cache leaves from the ACPI PPTT table
> > > (acpi_get_cache_info()) and set the cache type through split_levels.
> > >
> > > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/riscv/kernel/cacheinfo.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> > > index 30a6878287ad..ece92aa404e3 100644
> > > --- a/arch/riscv/kernel/cacheinfo.c
> > > +++ b/arch/riscv/kernel/cacheinfo.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/cpu.h>
> > >  #include <linux/of.h>
> > >  #include <asm/cacheinfo.h>
> > > +#include <linux/acpi.h>
> > >
> > >  static struct riscv_cacheinfo_ops *rv_cache_ops;
> > >
> > > @@ -78,6 +79,28 @@ int populate_cache_leaves(unsigned int cpu)
> > >       struct device_node *prev = NULL;
> > >       int levels = 1, level = 1;
> > >
> > > +     if (!acpi_disabled) {
> > > +             int ret, idx, fw_levels, split_levels;
> > > +
> > > +             ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             /* must be set, so we can drop num_leaves assignment below */
> >
> > I intentionally added this above comment to check and drop the below statement
> > if it is already set. Please check if the value is already set when we call
> > into this function(which I think is the case).
> >
> > > +             this_cpu_ci->num_leaves = fw_levels + split_levels;
> 
> Uh,got it. I understand that there is no need to add this line:
> "this_cpu_ci->num_leaves = fw_levels + split_levels; " , because in
> the Master core first it will:
> smp_prepare_cpus
>      ->init_cpu_topology
>           ->for_each_possible_cpu(cpu) {
>                  fetch_cache_info(cpu); //num_leaves and num_levels will be set
> Then store_cpu_topology->update_siblings_masks->detect_cache_attributes->populate_cache_leaves().
> 
> Slave core will follow the logic of smp_callin->store_cpu_topology().
> It's the same after I tested it, so I plan to remove that line and
> update V3, what do you think?
>

Correct, just drop the statement updating "this_cpu_ci->num_leaves".

-- 
Regards,
Sudeep

