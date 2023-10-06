Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB837BB224
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjJFH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJFH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:28:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D94ACA;
        Fri,  6 Oct 2023 00:28:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CE1B1FB;
        Fri,  6 Oct 2023 00:29:03 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB85B3F762;
        Fri,  6 Oct 2023 00:28:21 -0700 (PDT)
Date:   Fri, 6 Oct 2023 08:26:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Nikunj Kela <quic_nkela@quicinc.com>, cristian.marussi@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
Message-ID: <20231006072650.ubgcnbda7daynofa@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
 <20231003111914.63z35sn3r3k7drtp@bogus>
 <6246714a-3b40-e1b6-640e-560ba55b6436@quicinc.com>
 <20231004160630.pxspafszlt6o7oj6@bogus>
 <20231005222016.GI3553829@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005222016.GI3553829@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:20:16PM -0700, Bjorn Andersson wrote:
> On Wed, Oct 04, 2023 at 05:06:30PM +0100, Sudeep Holla wrote:
> > On Tue, Oct 03, 2023 at 09:16:27AM -0700, Nikunj Kela wrote:
> > > On 10/3/2023 4:19 AM, Sudeep Holla wrote:
> > > > On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
> > > > > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> [..]
> > > > > @@ -63,6 +66,8 @@ struct scmi_smc {
> > > > >   	u32 func_id;
> > > > >   	u32 param_page;
> > > > >   	u32 param_offset;
> > > > > +	u64 cap_id;
> > > > Can it be unsigned long instead so that it just works for both 32 and 64 bit.
> > > 
> > > My first version of this patch was ulong but Bjorn suggested to make this
> > > structure size fixed i.e. architecture independent. Hence changed it to u64.
> > > If you are ok with ulong, I can change it back to ulong.
> > >
> > 
> > SMCCC pre-v1.2 used the common structure in that way. I don't see any issue
> > with that. I haven't followed Bjorn suggestions/comments though.
> > 
> 
> My request was that funcId and capId is an ABI between the firmware and
> the OS, so I'd like for that to use well defined, fixed sized, data
> types - if nothing else just for documentation purpose.
> 
> These values will be truncated when passed to arm_smccc_1_1_invoke()
> anyways, so I don't have any opinion against using unsigned long here...
> 
> 
> PS. I understand why func_id is u32, but why are param_page and
> param_offset u32?
> 

Good point. Sorry I somehow missed your original comment, my bad.
Yes, it is good to be consistent. Sorry if I added any confusion by
missing o read your comment and understanding it before I responded.

--
Regards,
Sudeep
