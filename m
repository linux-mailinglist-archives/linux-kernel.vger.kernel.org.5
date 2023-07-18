Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9861757707
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGRIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGRIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:48:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B841197
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:48:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 851E62F4;
        Tue, 18 Jul 2023 01:49:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6AE3F67D;
        Tue, 18 Jul 2023 01:48:44 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:48:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH] firmware: smccc: Fix use of uninitialised results
 structure
Message-ID: <20230718084842.6edna54m5njijdiz@bogus>
References: <20230717171702.424253-1-punit.agrawal@bytedance.com>
 <86351lvcl9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86351lvcl9.wl-maz@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:38:26AM +0100, Marc Zyngier wrote:
> On Mon, 17 Jul 2023 18:17:02 +0100,
> Punit Agrawal <punit.agrawal@bytedance.com> wrote:
> > 
> > Commit 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum
> > T241-FABRIC-4") moved the initialisation of the SoC version to
> > arm_smccc_version_init() but forgot to update the results structure
> > and it's usage.
> > 
> > Fix the use of the uninitialised results structure and update the
> > error strings.
> > 
> > Fixes: 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4")
> > Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Vikram Sethi <vsethi@nvidia.com>
> > Cc: Shanker Donthineni <sdonthineni@nvidia.com>
> > ---
> >  drivers/firmware/smccc/soc_id.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
> > index 890eb454599a..1990263fbba0 100644
> > --- a/drivers/firmware/smccc/soc_id.c
> > +++ b/drivers/firmware/smccc/soc_id.c
> > @@ -34,7 +34,6 @@ static struct soc_device_attribute *soc_dev_attr;
> >  
> >  static int __init smccc_soc_init(void)
> >  {
> > -	struct arm_smccc_res res;
> >  	int soc_id_rev, soc_id_version;
> >  	static char soc_id_str[20], soc_id_rev_str[12];
> >  	static char soc_id_jep106_id_str[12];
> > @@ -49,13 +48,13 @@ static int __init smccc_soc_init(void)
> >  	}
> >  
> >  	if (soc_id_version < 0) {
> > -		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
> > +		pr_err("Invalid SoC Version: %x\n", soc_id_version);
> >  		return -EINVAL;
> >  	}
> >  
> >  	soc_id_rev = arm_smccc_get_soc_id_revision();
> >  	if (soc_id_rev < 0) {
> > -		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
> > +		pr_err("Invalid SoC Revision: %x\n", soc_id_rev);
> >  		return -EINVAL;
> >  	}
> >  
> 
> Ah, indeed. Well caught. FWIW:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Sudeep, I assume you'll take that one directly?
> 

Sure I will route it via (arm-)soc team.

-- 
Regards,
Sudeep
