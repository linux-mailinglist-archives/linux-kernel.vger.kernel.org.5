Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58380110D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjLAQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378508AbjLAQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:17:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CCF11BC5;
        Fri,  1 Dec 2023 08:18:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6408A1007;
        Fri,  1 Dec 2023 08:18:46 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4F043F6C4;
        Fri,  1 Dec 2023 08:17:58 -0800 (PST)
Date:   Fri, 1 Dec 2023 16:17:56 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_mdtipton@quicinc.com, quic_asartor@quicinc.com,
        quic_lingutla@quicinc.com, Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix frequency truncation by
 promoting multiplier to u64
Message-ID: <ZWoHNPlxs-WnVAFe@pluto>
References: <20231130204343.503076-1-sudeep.holla@arm.com>
 <20231201143935.be6wzjzxmyl5vpz6@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201143935.be6wzjzxmyl5vpz6@bogus>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 02:39:35PM +0000, Sudeep Holla wrote:
> On Thu, Nov 30, 2023 at 08:43:42PM +0000, Sudeep Holla wrote:
> > Fix the frequency truncation for all values equal to or greater 4GHz by
> > updating the multiplier 'mult_factor' to u64 type. It is also possible
> > that the multiplier itself can be greater than or equal to 2^32. So we need
> > to also fix the equation computing the value of the multiplier.
> > 
> > Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
> > Reported-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Closes: https://lore.kernel.org/all/20231129065748.19871-3-quic_sibis@quicinc.com/
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/perf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index 81dd5c5e5533..8ce449922e55 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -152,7 +152,7 @@ struct perf_dom_info {
> >  	u32 opp_count;
> >  	u32 sustained_freq_khz;
> >  	u32 sustained_perf_level;
> > -	u32 mult_factor;
> > +	u64 mult_factor;
> 
> I have now changed this to unsigned long instead of u64 to fix the 32-bit
> build failure[1].

Right, I was caught a few times too by this kind of failures on v7 :D

... but this 32bit issue makes me wonder what to do in such a case...

...I mean, on 32bit if the calculated freq oveflows, there is just
nothing we can do on v7 without overcomplicating the code...but I suppose
it is unplausible to have such high freq on a v7... as a palliative I can
only think of some sort of overflow check (only on v7) that could trigger
a warning ... but it is hardly worth the effort probably..

Thanks,
Cristian
