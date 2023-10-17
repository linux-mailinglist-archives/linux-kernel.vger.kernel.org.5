Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F227CC184
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjJQLHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjJQLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:07:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E2DFD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:06:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so9376569a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697540816; x=1698145616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJC4nFF3vhCV0/q49aZ8HDwgeodSnFveb4bvsgI4wfo=;
        b=BcloNKLWZcnf1n9iQN2f9fxQZkSgqF1QxsawOKBB/3pM8XgUS2d7tM++jLQAQK0hxv
         kt9r7XqUndatyhcndjGsVDLoMWproTXUeUpppgyQkeaoeSMqmuY7JBj5lPzB1gmEemvk
         JPrQl8FQ942tE8dwg/NxmhqzGzQySsoHdV4Md5vXQOBTKUBg7nwV/L4hzLUgg00UzQEP
         mzZD6Z8aFXvJ3TdPCTPS/UangRy1IDaousuorNZ8vMUdg/iAOTlpdKcHxHr52Yh3jBDc
         F7pq4ay3qP7wVrM9yhnyZAMqgz/KkFYbeoSlFY0XXqvFsc+bHOgMykjzUs5yYtwTeUEE
         dD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540816; x=1698145616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJC4nFF3vhCV0/q49aZ8HDwgeodSnFveb4bvsgI4wfo=;
        b=E85u7wei7EOakJFcra43MEpf43aU/pMvNJQ4z8/ffyQvgDpEHFOOEsqqymu84qmDAm
         EGijP7dmum5eUaj18PttK6vVCPhBVaMk+mjDe9bLyLkxRn7fuuiLKbNS+fwzAMevk3Sg
         rT3JLKtZ3C+1sUR6uqyLR8Ah8Qc7dZlDkD18tVQEn/odTdSMQmIuMi/dFuF5vMmiSkV6
         WtCx0QX2/JlOpvgyf/35aybz1319taCuQtl4r4cYO5QmMxNjPb9vfho1AOXUSrJmyV2W
         p+rTO5sdag+38NwjijYDqdhjCkA1qaigIarKnwStZKD1sa6fkAOs7g+6rb/X5MsQmvDe
         jhEQ==
X-Gm-Message-State: AOJu0Yx8s7rZJeSpWddcu3C9CYLP57ubib6HLX7t6J/SeL8tomRJMHSs
        P1xD+N3d4gHpGMmaVSRFL6SUJQ==
X-Google-Smtp-Source: AGHT+IE3+dy9KxR0DMNpJylit/JSLtOQD8wGBT8WZyvnAV56LixZhR/0fOdKoFLIRDgxKatONZOONA==
X-Received: by 2002:a50:ab55:0:b0:52e:1d58:a6ff with SMTP id t21-20020a50ab55000000b0052e1d58a6ffmr1212905edc.35.1697540815909;
        Tue, 17 Oct 2023 04:06:55 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v15-20020a50954f000000b0053120f313cbsm1043876eda.39.2023.10.17.04.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:06:55 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:06:54 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net-next v2 03/11] pds_core: devlink health: use retained
 error fmsg API
Message-ID: <ZS5qztBDc3ebxypI@nanopsycho>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Oct 17, 2023 at 12:53:33PM CEST, przemyslaw.kitszel@intel.com wrote:
>Drop unneeded error checking.
>
>devlink_fmsg_*() family of functions is now retaining errors,
>so there is no need to check for them after each call.
>
>Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
>---
> drivers/net/ethernet/amd/pds_core/devlink.c | 29 ++++++---------------
> 1 file changed, 8 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>index d9607033bbf2..8b2b9e0d59f3 100644
>--- a/drivers/net/ethernet/amd/pds_core/devlink.c
>+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>@@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
> 			      struct netlink_ext_ack *extack)
> {
> 	struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
>-	int err;
> 
> 	mutex_lock(&pdsc->config_lock);
>-
> 	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
> 	else if (!pdsc_is_fw_good(pdsc))
>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
> 	else
>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>-
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
> 	mutex_unlock(&pdsc->config_lock);
> 
>-	if (err)
>-		return err;
>-
>-	err = devlink_fmsg_u32_pair_put(fmsg, "State",
>-					pdsc->fw_status &
>-						~PDS_CORE_FW_STS_F_GENERATION);
>-	if (err)
>-		return err;
>-
>-	err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
>-					pdsc->fw_generation >> 4);
>-	if (err)
>-		return err;
>+	devlink_fmsg_u32_pair_put(fmsg, "State",
>+				  pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
>+	devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
>+	devlink_fmsg_u32_pair_put(fmsg, "Recoveries", pdsc->fw_recoveries);
> 
>-	return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
>-					 pdsc->fw_recoveries);
>+	return 0;

Could you please covert the function to return void? Please make sure
to do this in the rest of the patchset as well.

Thanks!

pw-bot: cr


> }
>-- 
>2.40.1
>
