Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78122792AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbjIEQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354833AbjIEOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:51:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D3113;
        Tue,  5 Sep 2023 07:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55995CE11D9;
        Tue,  5 Sep 2023 14:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8973CC433C8;
        Tue,  5 Sep 2023 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693925466;
        bh=SIFsFjVXa4EVY6ryyNMcawtByWDU+9xvsMPj0ugRqMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6gxkkVF4yp8Y29+wdlhNzoudKMaSUGL4gbpGm0UW4ROenvqguTu3PRRw8M8CCqQc
         Wq8Ut+Lyy5/G4v9hBR/G3bb/G4+xxb+e0HRgva5R0TohmdXmSKG7Og1zlMNPVsfIJN
         5cYeuIRS4pzxVN5ojMdfa7z/bbiSJNKyfgitAhYLDpBOvvm+WrrBZ2HNTqOmgCoY9v
         qS5wu6XugvSR/DtYXpa/81p13IWKPqHe49TJGG4TVMIf2DZYGRBSMh5Ig+UpYdLE7N
         +9BE9cL1o0A8iNbFJyPNqtkpMzd0xco76M6rSHuIN0G0T3YSHeVyCCs0bCf3Fmhq48
         gIXhb4BFEqIRw==
Date:   Tue, 5 Sep 2023 15:51:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jeongtae Park <jtp.park@samsung.com>, linux-cxl@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>
Subject: Re: [PATCH] perf: CXL: fix mismatched number of counters mask
Message-ID: <20230905145100.GC3322@willie-the-truck>
References: <CGME20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1@epcas2p2.samsung.com>
 <20230905123309.775854-1-jtp.park@samsung.com>
 <20230905142854.GA3322@willie-the-truck>
 <20230905154634.000075c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905154634.000075c5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:46:34PM +0100, Jonathan Cameron wrote:
> On Tue, 5 Sep 2023 15:28:54 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > On Tue, Sep 05, 2023 at 09:33:09PM +0900, Jeongtae Park wrote:
> > > The number of Count Units field is described as 6 bits long
> > > in the CXL 3.0 specification. However, its mask value was
> > > only declared as 5 bits long.
> > > 
> > > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> > > ---
> > >  drivers/perf/cxl_pmu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > > index 0a8f597e695b..365d964b0f6a 100644
> > > --- a/drivers/perf/cxl_pmu.c
> > > +++ b/drivers/perf/cxl_pmu.c
> > > @@ -25,7 +25,7 @@
> > >  #include "../cxl/pmu.h"
> > >  
> > >  #define CXL_PMU_CAP_REG			0x0
> > > -#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(4, 0)
> > > +#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(5, 0)
> > >  #define   CXL_PMU_CAP_COUNTER_WIDTH_MSK			GENMASK_ULL(15, 8)
> > >  #define   CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK		GENMASK_ULL(24, 20)
> > >  #define   CXL_PMU_CAP_FILTERS_SUP_MSK			GENMASK_ULL(39, 32)  
> > 
> > I don't have access to the CXL spec, but widening this mask looks like
> > it puts us out-of-whack with CXL_PMU_MAX_COUNTERS.
> > 
> > Did v3.0 of the spec bump the number of counters? If so, can you please
> > check that this is a backwards-compatible change?
> 
> CXL Performance monitors were only introduced in CXL 3.0 so not that.

Thanks for the information!

> The max value that register can take is 0x3f (0 based, so 64 counters ==
> CXL_PMU_MAX_COUNTERS)
> So it should be 6 bits wide. I did some history digging and this isn't
> even a draft spec / final spec issue - simple typo I guess.

Heh, I blame the heat as I thought this was extending to 7 bits for some
reason. Sorry about that.

> Fix seems correct to me.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll pick it up, thanks again!

Will
