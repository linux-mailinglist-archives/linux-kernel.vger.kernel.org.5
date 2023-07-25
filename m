Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62901761FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGYRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjGYRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:03:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8AA4FE;
        Tue, 25 Jul 2023 10:03:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF67615DB;
        Tue, 25 Jul 2023 10:03:59 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718353F6C4;
        Tue, 25 Jul 2023 10:03:14 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:03:04 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] firmware: arm_scmi: Add qcom hvc/shmem transport
Message-ID: <ZMAASCqwMbqX7T7L@pluto>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230724164419.16092-1-quic_nkela@quicinc.com>
 <20230724164419.16092-4-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724164419.16092-4-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:44:19AM -0700, Nikunj Kela wrote:
> Add a new transport channel to the SCMI firmware interface driver for
> SCMI message exchange on Qualcomm virtual platforms.
> 
> The hypervisor associates an object-id also known as capability-id
> with each hvc doorbell object. The capability-id is used to identify the
> doorbell from the VM's capability namespace, similar to a file-descriptor.
> 
> The hypervisor, in addition to the function-id, expects the capability-id
> to be passed in x1 register when HVC call is invoked.
> 
> The qcom hvc doorbell/shared memory transport uses a statically defined
> shared memory region that binds with "arm,scmi-shmem" device tree node.
> 
> The function-id & capability-id are allocated by the hypervisor on bootup
> and are stored in the shmem region by the firmware before starting Linux.
> 
> Currently, there is no usecase for the atomic support therefore this driver
> doesn't include the changes for the same.
> 

Hi Nikunj,

so basically this new SCMI transport that you are introducing is just
exactly like the existing SMC transport with the only difference that
you introduced even another new way to configure func_id, a new cap_id
param AND the fact that you use HVC instead of SMC... all of this tied
to a new compatible to identify this new transport mechanism....
..but all in all is just a lot of plain duplicated code to maintain...

...why can't you fit this other smc/hvc transport variant into the
existing SMC transport by properly picking and configuring func_id/cap_id
and "doorbell" method (SMC vs HVC) in the chan_setup() step ?

..I mean ... you can decide where to pick your params based on
compatibles and also you can setup your invokation method (SMC vs HVC)
based on those...while keeping all the other stuff exactly the same...
...including support for atomic exchanges...if not, when you'll need that
too in your QC_HVC transport you'll have to duplicate also that (and my
bugs too probably :P)

(... well maybe in this scenario also the transport itself should be
renamed from SMC to something more general...)

Not sure if I am missing something, or if Sudeep will be horrified by
this unifying proposal of mine, but in this series as it stands now I
just see a lot of brutally duplicated stuff that just differs by naming
and a very minimal change in logic that could be addressed changing and
generalizing the original SMC transport code instead.

Thanks,
Cristian

