Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB57380A7E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574405AbjLHPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjLHPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:51:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3A1732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:37 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1584243a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702050697; x=1702655497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zk7HC5so0/fxufyN1/rDn6lTfL6Xf6T0O8RI6n/kBB4=;
        b=j2S8w942SIRF7jn/AHBKMnOW2GuR/LvLllK3EoJ0V67hNdGDyGocyZtHxz2lZnhWua
         QdW7v2Zu2AH4IPaiklFoEDCADz+Kk+5xEqzKS5wo8iInGkGXNRmYCuac3GqmYHllxVFy
         fjda/aSaeiANYdtm5Pf7tvXme2fkPzUHxMSQUCHjwXCW2MdgPveiD+7JIh3HE8VRrGx0
         KLt3POBn3OuFYmp9byQe6fxSvs+r0e1red/ttA/03FVYmHUy/oLntHYViJycIRxcJXzT
         wglY30Cmsj3WoTrcIquLkefUB/+cZYw6Z/BOjvVQMMdKpQ6G00D6W9mb7x5XJI843yTO
         bSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050697; x=1702655497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk7HC5so0/fxufyN1/rDn6lTfL6Xf6T0O8RI6n/kBB4=;
        b=YN9/GfLP8J/1dgpPwQBjt+tOK4pjIZdV/fkBn9GxJvtLuO91fCMM9yfGjP1sCoDhZf
         z1Hq+4If/97v/32ObeBhXwkfiqE+29tNmQLlEr4lBKeJMOo7X6OmfvVdMaF8LLXhEA5s
         +3gnZAMec986hMoh9FE+5HBSF+H+wfld4qVo1Lbg+BPmpx+zMpSyDXBFm6Bqkir1Iu4m
         afzpD/3Fg7kF290dH+FHfKfodbCi1n6U1URUCwGYS8ALj7ovJd0FcEgWhQlcM5p8njJI
         UdxcFBTE57yItQthFOskdfSgm9+Z/M12naooCt2wezlXUax43NzxZEgNyXGQ3zUvvuvv
         MFBQ==
X-Gm-Message-State: AOJu0YwdjZUYJ7IEGiNYgaJevJ1C+nBv4AOCyyQqCO0nr5J2sZTrUAOR
        w5riM3ZbAu5yHL+0e6FOKGbcBA==
X-Google-Smtp-Source: AGHT+IE7mXR0woHSMg3du4/v1FTYxi3ox/DzisBAw8t3/DtxwugbdEjmXwA6bbukvxYcdUNzMf2+vQ==
X-Received: by 2002:a05:6a20:560c:b0:18f:a92:9152 with SMTP id ir12-20020a056a20560c00b0018f0a929152mr162154pzc.103.1702050696653;
        Fri, 08 Dec 2023 07:51:36 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:bc99:83ae:a2d5:c5ca])
        by smtp.gmail.com with ESMTPSA id c7-20020a6566c7000000b005c215baacc1sm1512572pgw.70.2023.12.08.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:51:36 -0800 (PST)
Date:   Fri, 8 Dec 2023 08:51:33 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Message-ID: <ZXM7hZlTAbBb8Iox@p14s>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com>
 <ZV02P3bHEhPLQHBo@p14s>
 <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com>
 <ZV+V6V2sEWgsqngk@p14s>
 <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com>
 <ZWdwl/8LC2Nn+vCq@p14s>
 <ea2edc6e-6655-47f8-8b6d-242f5a0ef804@amd.com>
 <CANLsYkzJgZRSz5=nzW+ATmBKemoSd3ybhKuz1CJy33hftAGiqw@mail.gmail.com>
 <2e24d9be-be10-4f80-b3af-c3e0ed003e7b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e24d9be-be10-4f80-b3af-c3e0ed003e7b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:06:45PM -0600, Tanmay Shah wrote:
> 
> On 12/6/23 9:43 AM, Mathieu Poirier wrote:
> > On Fri, 1 Dec 2023 at 11:10, Tanmay Shah <tanmay.shah@amd.com> wrote:
> > >
> > >
> > > On 11/29/23 11:10 AM, Mathieu Poirier wrote:
> > > > On Mon, Nov 27, 2023 at 10:33:05AM -0600, Tanmay Shah wrote:
> > > > >
> > > > > On 11/23/23 12:11 PM, Mathieu Poirier wrote:
> > > > > > On Wed, Nov 22, 2023 at 03:00:36PM -0600, Tanmay Shah wrote:
> > > > > > > Hi Mathieu,
> > > > > > >
> > > > > > > Please find my comments below.
> > > > > > >
> > > > > > > On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > > > > > > > > Use TCM pm domains extracted from device-tree
> > > > > > > > > to power on/off TCM using general pm domain framework.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v7:
> > > > > > > > >   - %s/pm_dev1/pm_dev_core0/r
> > > > > > > > >   - %s/pm_dev_link1/pm_dev_core0_link/r
> > > > > > > > >   - %s/pm_dev2/pm_dev_core1/r
> > > > > > > > >   - %s/pm_dev_link2/pm_dev_core1_link/r
> > > > > > > > >   - remove pm_domain_id check to move next patch
> > > > > > > > >   - add comment about how 1st entry in pm domain list is used
> > > > > > > > >   - fix loop when jump to fail_add_pm_domains loop
> > > > > > > > >
> > > > > > > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> > > > > > > > >  1 file changed, 212 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > > > > index 4395edea9a64..22bccc5075a0 100644
> > > > > > > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > > > > @@ -16,6 +16,7 @@
> > > > > > > > >  #include <linux/of_reserved_mem.h>
> > > > > > > > >  #include <linux/platform_device.h>
> > > > > > > > >  #include <linux/remoteproc.h>
> > > > > > > > > +#include <linux/pm_domain.h>
> > > > > > > > >
> > > > > > > > >  #include "remoteproc_internal.h"
> > > > > > > > >
> > > > > > > > > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > > > > > > >   * @rproc: rproc handle
> > > > > > > > >   * @pm_domain_id: RPU CPU power domain id
> > > > > > > > >   * @ipi: pointer to mailbox information
> > > > > > > > > + * @num_pm_dev: number of tcm pm domain devices for this core
> > > > > > > > > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > > > > > > > > + * @pm_dev_core0_link: pm domain device links after registration
> > > > > > > > > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > > > > > > > > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > > > > > > > > + * registration
> > > > > > > > >   */
> > > > > > > > >  struct zynqmp_r5_core {
> > > > > > > > >     struct device *dev;
> > > > > > > > > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> > > > > > > > >     struct rproc *rproc;
> > > > > > > > >     u32 pm_domain_id;
> > > > > > > > >     struct mbox_info *ipi;
> > > > > > > > > +   int num_pm_dev;
> > > > > > > > > +   struct device **pm_dev_core0;
> > > > > > > > > +   struct device_link **pm_dev_core0_link;
> > > > > > > > > +   struct device **pm_dev_core1;
> > > > > > > > > +   struct device_link **pm_dev_core1_link;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  /**
> > > > > > > > > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > > > > > > >                                          ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > > > > > >                                          ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > > > > > >             if (ret < 0) {
> > > > > > > > > -                   dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > > > > > > > +                   dev_err(dev, "failed to turn on TCM 0x%x",
> > > > > > > > > +                           pm_domain_id);
> > > > > > > >
> > > > > > > > Spurious change, you should have caught that.
> > > > > > >
> > > > > > > Ack, need to observe changes more closely before sending them.
> > > > > > >
> > > > > > > >
> > > > > > > > >                     goto release_tcm_lockstep;
> > > > > > > > >             }
> > > > > > > > >
> > > > > > > > > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > > > > > > >     return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > > > > > > > > +{
> > > > > > > > > +   struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > > > > +   struct device *dev = r5_core->dev;
> > > > > > > > > +   struct zynqmp_r5_cluster *cluster;
> > > > > > > > > +   int i;
> > > > > > > > > +
> > > > > > > > > +   cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > > > > > > > > +
> > > > > > > > > +   for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > > > > +           device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   kfree(r5_core->pm_dev_core0);
> > > > > > > > > +   r5_core->pm_dev_core0 = NULL;
> > > > > > > > > +   kfree(r5_core->pm_dev_core0_link);
> > > > > > > > > +   r5_core->pm_dev_core0_link = NULL;
> > > > > > > > > +
> > > > > > > > > +   if (cluster->mode == SPLIT_MODE) {
> > > > > > > > > +           r5_core->num_pm_dev = 0;
> > > > > > > > > +           return;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > > > > +           device_link_del(r5_core->pm_dev_core1_link[i]);
> > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   kfree(r5_core->pm_dev_core1);
> > > > > > > > > +   r5_core->pm_dev_core1 = NULL;
> > > > > > > > > +   kfree(r5_core->pm_dev_core1_link);
> > > > > > > > > +   r5_core->pm_dev_core1_link = NULL;
> > > > > > > > > +   r5_core->num_pm_dev = 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > > > > > > > > +{
> > > > > > > > > +   struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > > > > +   struct device *dev = r5_core->dev, *dev2;
> > > > > > > > > +   struct zynqmp_r5_cluster *cluster;
> > > > > > > > > +   struct platform_device *pdev;
> > > > > > > > > +   struct device_node *np;
> > > > > > > > > +   int i, j, num_pm_dev, ret;
> > > > > > > > > +
> > > > > > > > > +   cluster = dev_get_drvdata(dev->parent);
> > > > > > > > > +
> > > > > > > > > +   /* get number of power-domains */
> > > > > > > > > +   num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > > > > > > > > +                                           "#power-domain-cells");
> > > > > > > > > +
> > > > > > > > > +   if (num_pm_dev <= 0)
> > > > > > > > > +           return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +   r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > > > > > > > > +                                   sizeof(struct device *),
> > > > > > > > > +                                   GFP_KERNEL);
> > > > > > > > > +   if (!r5_core->pm_dev_core0)
> > > > > > > > > +           ret = -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +   r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > > > > > > > > +                                        sizeof(struct device_link *),
> > > > > > > > > +                                        GFP_KERNEL);
> > > > > > > > > +   if (!r5_core->pm_dev_core0_link) {
> > > > > > > > > +           kfree(r5_core->pm_dev_core0);
> > > > > > > > > +           r5_core->pm_dev_core0 = NULL;
> > > > > > > > > +           return -ENOMEM;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   r5_core->num_pm_dev = num_pm_dev;
> > > > > > > > > +
> > > > > > > > > +   /*
> > > > > > > > > +    * start from 2nd entry in power-domains property list as
> > > > > > > > > +    * for zynqmp we only add TCM power domains and not core's power domain.
> > > > > > > > > +    * 1st entry is used to configure r5 operation mode.
> > > > > > > >
> > > > > > > > You are still not saying _where_ ->pm_dev_core0[0] gets added.
> > > > > > >
> > > > > > > So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,
> > > > > > >
> > > > > > > zynqmp_pm_request_wake during rproc_start callback. I will document this in next
> > > > > > >
> > > > > >
> > > > > > That is exactly what I am looking for.  That way people don't have to go through
> > > > > > the entire driver trying to figure out what is happening with pm_dev_core[0].
> > > > > >
> > > > > > I'm also not sure about the power-up order.  Logically the TCMs should be
> > > > > > powered up before the R5 in order to put code in them.  The R5s are powered in
> > > > > > zynqmp_r5_rproc_start() but I am unclear as to where in the boot sequence the
> > > > > > TCMs are powered - can you expand on that?
> > > > >
> > > > >
> > > > > Sure. Following is call sequece
> > > > >
> > > > > zynqmp_r5_rproc_prepare
> > > > >
> > > > > zynqmp_r5_add_pm_domains -> Here TCM is powered on when device_link_add is called via zynqmp-pm-domains.c driver.
> > > > >
> > > > > . . .
> > > > >
> > > > > zynqmp_r5_rproc_start -> load firmware and Starts RPU
> > > > >
> > > > > So what you mentioned is correct, TCM is being powerd-on before we load firmware and start RPU.
> > > > >
> > > > >
> > > > > >
> > > > > > > revision. For new platforms pm_dev_core0[0] will be added in future.
> > > > > >
> > > > > > Now I'm really confused - what do you mean by "pm_dev_core0[0] will be added in
> > > > > > future"?
> > > > >
> > > > >
> > > > > ZynqMP platform has platform management firmware running on microblaze.
> > > > >
> > > > > This firmware design does not expect R5 pm domains to be requested explicitly.
> > > > >
> > > > > This means, during zynqmp_r5_rproc_start when "zynqmp_pm_request_wake" is called,
> > > > >
> > > > > firmware powers on R5. So, pm_dev_core[0] is not really used for ZynqMP.
> > > > >
> > > > > However, this design was changed for new platforms i.e. "versal" and onwards.
> > > > >
> > > > > Firmware of new platform expects pm domains to be requested explicitly for R5 cores before
> > > > >
> > > > > waking them up.
> > > > >
> > > > > That means, pm_dev_core[0] for R5 cores on new platform (Versal) needs to be used same as TCM.
> > > > >
> > > > > Then, we should wake it up on r5_core.
> > > > >
> > > > > To summarize:
> > > > >
> > > > > For zynqmp only following call needed to start R5:
> > > > >
> > > > > zynqmp_pm_request_wake
> > > > >
> > > > > For "versal" and onwards we need two calls to start R5:
> > > > >
> > > > > "device_link_add" and zynqmp_pm_request_wake
> > > > >
> > > > > So, in future pm_core_dev[0] will be used.
> > > > >
> > > >
> > > > Thanks for the clarification on both front.  The problem here is that we are
> > > > keeping R5 power domain information in two different places, i.e
> > > > zynqmp_r5_core::pm_domain_id and zynqmp_r5_core::pm_dev_core0[0].
> > > >
> > > > Please see if you can retreive the power domain ID from
> > > > zynqmp_r5_core::pm_dev_core0[0].  That way you can get the power domain ID when
> > > > calling zynqmp_pm_request_wake() and zynqmp_pm_force_pwrdwn() and get rid of
> > > > zynqmp_r5_core::pm_domain_id.
> > >
> > > Hi Mathieu,
> > >
> > > I looked into this. Probably I can't retrieve pm_domain_id from pm_dev_core0[0],
> > >
> > > However, I can retrieve it from device-tree when calling zynqmp_pm_request_wake
> > >
> > > and zynqmp_pm_force_pwrdwn.
> > >
> > > zynqmp_r5_core::pm_domain_id is caching that value during probe, and use it during
> > > rest of the driver lifecycle.
> > >
> > > I am okay either way, (keeping it as it is, or get it from device-tree). Let me know your
> > >
> > > preference.
> > >
> >
> > Humm...  Then I suggest to simply get rid of the device linking to
> > deal with the TCMs' power management.  From where I stand it provides
> > more confusion than benefits, and that is without considering the
> > extra complexity.
> 
> 
> Do you mean to get rid of pm_dev_core0[1], and pm_dev_core0[2] as well ?
>

Yes

> If yes, its preferred to use pm_domain framework to power-on/off TCM.
> 

That is when the pm runtime subsystem is used extensively but it isn't
the case here.  In this scenario using device linking is adding a lot of
complexity for something that could be done in a single line of code.   

> If we want to get rid of zynqmp_r5_core::pm_domain_id, I will do what's done in
> 
> __genpd_dev_pm_attach API where, pm_domain_id is retrieved using of_node of pm_dev_core0[*] device.
> 
> ��� ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> ��������������������������� "#power-domain-cells", index, &pd_args);

That is what I asked for in my previous email, i.e use ->pm_dev_core0[0] to
retrieve the domain ID.

> 
> However, Its preferred to use pm_domain framework when power-domains are available in device-tree.
> 
> Let� me know.
> 
> Thanks,
> 
> Tanmay
> 
> 
> > > Thanks,
> > >
> > > Tanmay
> > >
> > > > >
> > > > > > >
> > > > > > > I hope this meets expectations.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > +    */
> > > > > > > > > +   for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > > > > +           r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > > > > > > > > +           if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
> > > > > > > >
> > > > > > > > Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> > > > > > > > code are used in the loop for the lockstep mode.  Please pick one heuristic and
> > > > > > > > stick with it.  I have no preference on which one.
> > > > > > >
> > > > > > > Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > +                   dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > > > > > > > > +                           PTR_ERR(r5_core->pm_dev_core0[i]));
> > > > > > > > > +                   ret = -EINVAL;
> > > > > > > > > +                   goto fail_add_pm_domains;
> > > > > > > > > +           }
> > > > > > > > > +           r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > > > > > > > > +                                                           r5_core->pm_dev_core0[i],
> > > > > > > > > +                                                           DL_FLAG_STATELESS |
> > > > > > > > > +                                                           DL_FLAG_RPM_ACTIVE |
> > > > > > > > > +                                                           DL_FLAG_PM_RUNTIME);
> > > > > > > > > +           if (!r5_core->pm_dev_core0_link[i]) {
> > > > > > > > > +                   dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > > > > +                   r5_core->pm_dev_core0[i] = NULL;
> > > > > > > > > +                   ret = -EINVAL;
> > > > > > > > > +                   goto fail_add_pm_domains;
> > > > > > > > > +           }
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   if (cluster->mode == SPLIT_MODE)
> > > > > > > > > +           return 0;
> > > > > > > > > +
> > > > > > > > > +   r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > > > > > > > > +                                   sizeof(struct device *),
> > > > > > > > > +                                   GFP_KERNEL);
> > > > > > > > > +   if (!r5_core->pm_dev_core1) {
> > > > > > > > > +           ret = -ENOMEM;
> > > > > > > > > +           goto fail_add_pm_domains;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > > > > > > > > +                                        sizeof(struct device_link *),
> > > > > > > > > +                                        GFP_KERNEL);
> > > > > > > > > +   if (!r5_core->pm_dev_core1_link) {
> > > > > > > > > +           kfree(r5_core->pm_dev_core1);
> > > > > > > > > +           r5_core->pm_dev_core1 = NULL;
> > > > > > > > > +           ret = -ENOMEM;
> > > > > > > > > +           goto fail_add_pm_domains;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   /* get second core's device to detach its power-domains */
> > > > > > > > > +   np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > > > > > > > > +
> > > > > > > > > +   pdev = of_find_device_by_node(np);
> > > > > > > > > +   if (!pdev) {
> > > > > > > > > +           dev_err(cluster->dev, "core1 platform device not available\n");
> > > > > > > > > +           kfree(r5_core->pm_dev_core1);
> > > > > > > > > +           kfree(r5_core->pm_dev_core1_link);
> > > > > > > > > +           r5_core->pm_dev_core1 = NULL;
> > > > > > > > > +           r5_core->pm_dev_core1_link = NULL;
> > > > > > > > > +           ret = -EINVAL;
> > > > > > > > > +           goto fail_add_pm_domains;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   dev2 = &pdev->dev;
> > > > > > > > > +
> > > > > > > > > +   /* for zynqmp we only add TCM power domains and not core's power domain */
> > > > > > > > > +   for (j = 1; j < r5_core->num_pm_dev; j++) {
> > > > > > > > > +           r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > > > > > > > > +           if (!r5_core->pm_dev_core1[j]) {
> > > > > > > > > +                   dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > > > > +                   ret = -EINVAL;
> > > > > > > > > +                   goto fail_add_pm_domains_lockstep;
> > > > > > > > > +           } else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > > > > > > > > +                   dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > > > > +                   ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > > > > > > > > +                   goto fail_add_pm_domains_lockstep;
> > > > > > > > > +           }
> > > > > > > > > +
> > > > > > > > > +           r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > > > > > > > > +                                                           r5_core->pm_dev_core1[j],
> > > > > > > > > +                                                           DL_FLAG_STATELESS |
> > > > > > > > > +                                                           DL_FLAG_RPM_ACTIVE |
> > > > > > > > > +                                                           DL_FLAG_PM_RUNTIME);
> > > > > > > > > +           if (!r5_core->pm_dev_core1_link[j]) {
> > > > > > > > > +                   dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > > > > +                   r5_core->pm_dev_core1[j] = NULL;
> > > > > > > > > +                   ret = -ENODEV;
> > > > > > > > > +                   goto fail_add_pm_domains_lockstep;
> > > > > > > > > +           }
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +fail_add_pm_domains_lockstep:
> > > > > > > > > +   while (--j >= 0) {
> > > > > > > > > +           device_link_del(r5_core->pm_dev_core1_link[j]);
> > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > > > > +   }
> > > > > > > > > +   kfree(r5_core->pm_dev_core1);
> > > > > > > > > +   r5_core->pm_dev_core1 = NULL;
> > > > > > > > > +   kfree(r5_core->pm_dev_core1_link);
> > > > > > > > > +   r5_core->pm_dev_core1_link = NULL;
> > > > > > > > > +
> > > > > > > > > +fail_add_pm_domains:
> > > > > > > > > +   while (--i >= 0) {
> > > > > > > > > +           device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > > > > +   }
> > > > > > > > > +   kfree(r5_core->pm_dev_core0);
> > > > > > > > > +   r5_core->pm_dev_core0 = NULL;
> > > > > > > > > +   kfree(r5_core->pm_dev_core0_link);
> > > > > > > > > +   r5_core->pm_dev_core0_link = NULL;
> > > > > > > > > +
> > > > > > > >
> > > > > > > > The error path is much cleaner and readable now.
> > > > > > > >
> > > > > > > > I will continue tomorrow.
> > > > > > > >
> > > > > > > > Mathieu
> > > > > > > >
> > > > > > > > > +   return ret;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /**
> > > > > > > > >   * zynqmp_r5_rproc_prepare()
> > > > > > > > >   * adds carveouts for TCM bank and reserved memory regions
> > > > > > > > > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > > > > > > >  {
> > > > > > > > >     int ret;
> > > > > > > > >
> > > > > > > > > +   ret = zynqmp_r5_add_pm_domains(rproc);
> > > > > > > > > +   if (ret) {
> > > > > > > > > +           dev_err(&rproc->dev, "failed to add pm domains\n");
> > > > > > > > > +           return ret;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > >     ret = add_tcm_banks(rproc);
> > > > > > > > >     if (ret) {
> > > > > > > > >             dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > > > > > > > > -           return ret;
> > > > > > > > > +           goto fail_prepare;
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > >     ret = add_mem_regions_carveout(rproc);
> > > > > > > > >     if (ret) {
> > > > > > > > >             dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > > > > > > > > -           return ret;
> > > > > > > > > +           goto fail_prepare;
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > >     return 0;
> > > > > > > > > +
> > > > > > > > > +fail_prepare:
> > > > > > > > > +   zynqmp_r5_remove_pm_domains(rproc);
> > > > > > > > > +
> > > > > > > > > +   return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  /**
> > > > > > > > > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > > > > > > >
> > > > > > > > >     r5_core = rproc->priv;
> > > > > > > > >
> > > > > > > > > +   zynqmp_r5_remove_pm_domains(rproc);
> > > > > > > > > +
> > > > > > > > >     for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > > > > > > >             pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > > > > > >             if (zynqmp_pm_release_node(pm_domain_id))
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > >
