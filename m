Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C66792B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbjIEQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354828AbjIEOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:46:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBE18C;
        Tue,  5 Sep 2023 07:46:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg7Zz2qHDz6HJTY;
        Tue,  5 Sep 2023 22:45:15 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 5 Sep
 2023 15:46:35 +0100
Date:   Tue, 5 Sep 2023 15:46:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     Jeongtae Park <jtp.park@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>
Subject: Re: [PATCH] perf: CXL: fix mismatched number of counters mask
Message-ID: <20230905154634.000075c5@huawei.com>
In-Reply-To: <20230905142854.GA3322@willie-the-truck>
References: <CGME20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1@epcas2p2.samsung.com>
        <20230905123309.775854-1-jtp.park@samsung.com>
        <20230905142854.GA3322@willie-the-truck>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 15:28:54 +0100
Will Deacon <will@kernel.org> wrote:

> On Tue, Sep 05, 2023 at 09:33:09PM +0900, Jeongtae Park wrote:
> > The number of Count Units field is described as 6 bits long
> > in the CXL 3.0 specification. However, its mask value was
> > only declared as 5 bits long.
> > 
> > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> > ---
> >  drivers/perf/cxl_pmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index 0a8f597e695b..365d964b0f6a 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -25,7 +25,7 @@
> >  #include "../cxl/pmu.h"
> >  
> >  #define CXL_PMU_CAP_REG			0x0
> > -#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(4, 0)
> > +#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(5, 0)
> >  #define   CXL_PMU_CAP_COUNTER_WIDTH_MSK			GENMASK_ULL(15, 8)
> >  #define   CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK		GENMASK_ULL(24, 20)
> >  #define   CXL_PMU_CAP_FILTERS_SUP_MSK			GENMASK_ULL(39, 32)  
> 
> I don't have access to the CXL spec, but widening this mask looks like
> it puts us out-of-whack with CXL_PMU_MAX_COUNTERS.
> 
> Did v3.0 of the spec bump the number of counters? If so, can you please
> check that this is a backwards-compatible change?

CXL Performance monitors were only introduced in CXL 3.0 so not that.

The max value that register can take is 0x3f (0 based, so 64 counters ==
CXL_PMU_MAX_COUNTERS)
So it should be 6 bits wide. I did some history digging and this isn't
even a draft spec / final spec issue - simple typo I guess.

Fix seems correct to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> 
> Will

