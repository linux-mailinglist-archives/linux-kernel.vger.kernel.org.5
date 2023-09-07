Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146479735D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjIGPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjIGPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDFB71BF7;
        Thu,  7 Sep 2023 08:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F381576;
        Thu,  7 Sep 2023 03:37:01 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBA573F67D;
        Thu,  7 Sep 2023 03:36:21 -0700 (PDT)
Date:   Thu, 7 Sep 2023 11:36:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add qcom hvc/shmem transport
Message-ID: <20230907103619.2kqh7tfivwdfm5rd@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230811175719.28378-1-quic_nkela@quicinc.com>
 <3342d8bf-5281-c082-cb9a-7a027b413237@quicinc.com>
 <f5b05cfa-f12c-4f4d-a801-3aa76d843d6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b05cfa-f12c-4f4d-a801-3aa76d843d6d@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 06:37:14PM +0200, Krzysztof Kozlowski wrote:
> On 05/09/2023 18:06, Nikunj Kela wrote:
> > 
> > On 8/11/2023 10:57 AM, Nikunj Kela wrote:
> >> This change introduce a new transport channel for Qualcomm virtual
> >> platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
> >> The difference between the two transports is that a parameter is passed in
> >> the hypervisor call to identify which doorbell to assert. This parameter is
> >> dynamically generated at runtime on the device and insuitable to pass via
> >> the devicetree.
> >>
> >> The function ID and parameter are stored by firmware in the shmem region.
> >>
> >> This has been tested on ARM64 virtual Qualcomm platform.
> >>
> >> ---
> >> v3 -> fix the compilation error reported by the test bot,
> >>        add support for polling based instances
> >>
> >> v2 -> use allOf construct in dtb schema,
> >>        remove wrappers from mutexes,
> >>        use architecture independent channel layout
> >>
> >> v1 -> original patches
> >>
> >> Nikunj Kela (3):
> >>    dt-bindings: arm: convert nested if-else construct to allOf
> >>    dt-bindings: arm: Add qcom specific hvc transport for SCMI
> >>    firmware: arm_scmi: Add qcom hvc/shmem transport
> >>
> >>   .../bindings/firmware/arm,scmi.yaml           |  67 ++---
> >>   drivers/firmware/arm_scmi/Kconfig             |  13 +
> >>   drivers/firmware/arm_scmi/Makefile            |   2 +
> >>   drivers/firmware/arm_scmi/common.h            |   3 +
> >>   drivers/firmware/arm_scmi/driver.c            |   4 +
> >>   drivers/firmware/arm_scmi/qcom_hvc.c          | 232 ++++++++++++++++++
> >>   6 files changed, 293 insertions(+), 28 deletions(-)
> >>   create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c
> > Gentle Ping!

Pong !

>
> It's third ping these two weeks from Qualcomm. Folks, it is merge
> window. What do you think will happen with your ping during this time?
>

+1

Okay, here is the deal with this patch set. As you are aware that a previous
merged solution was abandoned by Qcom in a single kernel release cycle. So
I decided to ignore this for one or 2 kernel release cycle to make sure
Qcom makes up their mind on the design and then we can see how to proceed.
Qcom must understand upstream kernel is not a playground to push their
design which they might decided to drop support for in such short period.
Please understand the upstream kernel supports platforms that are more than
few decades old. It is not like the mobile platforms that are hardly supported
for couple of years. And similarly, we push core support if and only if we
know for sure it will be used on some platform. I trusted Qcom with the
previous extension of SMC/HVC transport but I was proven wrong.

Also, I definitely don't like the way you have copied the whole smc.c
and changed it to Qcom's need and made it qcom_hvc.c. Just add the required
changes in smc.c.

--
Regards,
Sudeep
