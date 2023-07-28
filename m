Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC5766F58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjG1OWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjG1OWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93063C0E;
        Fri, 28 Jul 2023 07:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7878C62165;
        Fri, 28 Jul 2023 14:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEB6C433CA;
        Fri, 28 Jul 2023 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690554132;
        bh=rT/eYOtLbTs03n3CSJnusC5NVZmatwwQuZ8puahV/zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQBCeYpjqJoC+8dCdqVfDuw2kDRY999MaieN08n8ET27F03kpTfDupXf5CARbu63C
         AYOllWRGGGnNivY6kqP2rNLon3At9e9IMfxVrtXTElHVngdTb1ZKXsH9Yd5e+kS3FQ
         ln5e7k8vv8mjrVLLSu0GdyTRHbaVL7EvFdtoYN2D9C4oN3nmxxIGKz2Ymjw0y6sU6N
         kzGlRk22ib0r5Tu05o/wGwZFvhJ8t7mVOi6DhyU7K4mD2txPI73NwePBbi2VTV5GXA
         vP1JqACtyvFD1+EgbuIxO+p8wfHNmV/CTiRo1hPFpwzPEkOHap4BzeffdDXoY8pbck
         Sv/IRwFProZug==
Date:   Fri, 28 Jul 2023 15:22:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, fissure2010@gmail.com
Subject: Re: [PATCH v1 3/3] perf arm-spe: Support data source for Cortex-X4
 CPU
Message-ID: <20230728142204.GB21718@willie-the-truck>
References: <20230717054327.79815-1-leo.yan@linaro.org>
 <20230717054327.79815-4-leo.yan@linaro.org>
 <c784911e-72f4-8150-530b-234978546a45@arm.com>
 <20230724110509.GA76473@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724110509.GA76473@leoy-huanghe.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:05:09PM +0800, Leo Yan wrote:
> On Mon, Jul 24, 2023 at 12:27:31PM +0530, Anshuman Khandual wrote:
> 
> [...]
> 
> > > -static const struct midr_range neoverse_spe[] = {
> > > +static const struct midr_range cpus_use_default_data_src[] = {
> > 
> > Is not 'cpus_use_default_data_src' too long ? 'use' could be dropped ?
> 
> Okay, I can drop 'use'.
> 
> > >  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> > >  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> > >  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> > > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
> > >  	{},
> > >  };
> 
> [...]
> 
> > >  static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
> > >  {
> > >  	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
> > > -	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
> > > +	bool is_default_dc =
> > 
> > _dc stands for ?
> 
> Thanks for pointing out this; actually I mean '_ds' which stands for
> data source.  Will spin a new patch for this.

Thanks. Please can you put patch 2 (the one touching tools) at the end of
the series, too? That way I can easily pick up the kernel changes.

Will
