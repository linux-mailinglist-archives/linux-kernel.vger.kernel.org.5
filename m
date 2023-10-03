Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB67B66C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbjJCKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjJCKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:50:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60B0BF;
        Tue,  3 Oct 2023 03:50:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E60BC15;
        Tue,  3 Oct 2023 03:51:28 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 602633F5A1;
        Tue,  3 Oct 2023 03:50:48 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:50:46 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nikunj Kela <quic_nkela@quicinc.com>, robh+dt@kernel.org,
        Brian Masney <bmasney@redhat.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] firmware: arm_scmi: Add polling support for
 completion in smc
Message-ID: <ZRvyBocdU9y33z2Z@pluto>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-2-quic_nkela@quicinc.com>
 <20231003103317.pjfmf6uisahowmom@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003103317.pjfmf6uisahowmom@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:33:17AM +0100, Sudeep Holla wrote:
> On Mon, Sep 11, 2023 at 12:43:56PM -0700, Nikunj Kela wrote:
> > Currently, the return from the smc call assumes the completion of
> > the scmi request. However this may not be true in virtual platforms
> > that are using hvc doorbell.
> >
> 
> Hmm, it is expectation from SMCCC for the fast calls. Is you HVC FID
> not a fast call. AFAIK, only TOS use yielding calls. Are you using them
> here ? If not, this must complete when the SMC/HVC returns. We added
> support for platforms indicating the same via interrupt.
> 
> I would like to avoid adding this build config. Why does it require polling ?
> Broken firmware ? I would add a compatible for that. Or if the qcom always
> wants to do this way, just make it specific to the qcom compatible.
> 
> I would avoid a config flag as it needs to be always enabled for single
> image and affects other platforms as well. So please drop this change.
> If this is absolutely needed, just add additional property which DT
> maintainers may not like as it is more like a policy or just make it
> compatible specific.
> 

Not sure if it could be acceptable or controversial, BUT if there is the
need somehow to support polling for yielding calls (depending on the location
of the SCMI server), should not we think about doing this by just looking up
dynamically the fast-call bits in the provided FID ?

Why we need another binding, given that the FID is currently already
statically provided by the DT itself (via smc-id) or dynamically by the
hypervisor at setup by the changes in this series and the SMCCC spec
clearly defines how the IDs are supposed to be formed for
fast-atomic-calls ?

This way we could enforce the compliance with the SMCCC spec tooo...
...for sure it would require a bit of work in the core, though, given the
const nature of some of this structures.

Thanks,
Cristian
