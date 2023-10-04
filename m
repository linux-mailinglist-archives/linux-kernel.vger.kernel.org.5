Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8F7B84AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbjJDQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbjJDQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:12:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E08141703;
        Wed,  4 Oct 2023 09:11:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA334C15;
        Wed,  4 Oct 2023 09:12:22 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2543F762;
        Wed,  4 Oct 2023 09:11:42 -0700 (PDT)
Date:   Wed, 4 Oct 2023 17:11:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Brian Masney <bmasney@redhat.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] firmware: arm_scmi: Add polling support for
 completion in smc
Message-ID: <20231004161140.uzqb4eapyo6gd7xm@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-2-quic_nkela@quicinc.com>
 <20231003103317.pjfmf6uisahowmom@bogus>
 <1c58a05b-1337-0287-225f-5a73b4c6828e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c58a05b-1337-0287-225f-5a73b4c6828e@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:53:20AM -0700, Nikunj Kela wrote:
> 
> On 10/3/2023 3:33 AM, Sudeep Holla wrote:
> > On Mon, Sep 11, 2023 at 12:43:56PM -0700, Nikunj Kela wrote:
> > > Currently, the return from the smc call assumes the completion of
> > > the scmi request. However this may not be true in virtual platforms
> > > that are using hvc doorbell.
> > > 
> > Hmm, it is expectation from SMCCC for the fast calls. Is you HVC FID
> > not a fast call. AFAIK, only TOS use yielding calls. Are you using them
> > here ? If not, this must complete when the SMC/HVC returns. We added
> > support for platforms indicating the same via interrupt.
> > 
> > I would like to avoid adding this build config. Why does it require polling ?
> > Broken firmware ? I would add a compatible for that. Or if the qcom always
> > wants to do this way, just make it specific to the qcom compatible.
> > 
> > I would avoid a config flag as it needs to be always enabled for single
> > image and affects other platforms as well. So please drop this change.
> > If this is absolutely needed, just add additional property which DT
> > maintainers may not like as it is more like a policy or just make it
> > compatible specific.
> > 
> > --
> > Regards,
> > Sudeep
> We are using Fast call FID. We are using completion IRQ for all the scmi
> instances except one where we need to communicate with the server when GIC
> is in suspended state in HLOS. We will need to poll the channel for
> completion in that use case. I am open to suggestions.

IIUC, for the sake of that one corner case, you have added the polling
Kconfig and will be enabled for all the case and even on other platforms
in a single Image. I think we could be something better, no ?

Please share details on that one corner case.
Is it in the scmi drivers already ? If so, specifics please.
If no, again provide details on how you plan to use. We do have ways
to make a polling call, but haven't mixed it with interrupt based calls
for a reason, but we can revisit if it makes sense.

--
Regards,
Sudeep
