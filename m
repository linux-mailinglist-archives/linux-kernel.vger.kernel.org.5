Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6CF7EFF4E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjKRLiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjKRLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:38:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CFD57
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:38:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso4086493a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700307487; x=1700912287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwfAcLpPBP9/VcLdhWC2YYKbzJ5W2WwAWFFBT48SHb4=;
        b=DPszGSJv+/tGL68O9MV438e2U1IphyHA0fsDT2uxnwuiwt7B/0DLfpSDpbwkD3NW2P
         0zeUrhEuLencCLY0QnjWvHmylomF7ke4W5wXDzibQLR9FYuD55VhCIza49bY3kpMdy4q
         eK1e5XT5utNGsgO5SAPeXL0/rrj+MVCuePNvhHL03ZfDv5pT8l9WKTkcddPFd6MaaVaG
         D5tfc/OiNFvXaDYz8MoapDsutZAACb3N6em8x645BeuoB/OXb7H7hiN4rGzpkR3j5iEk
         GYME1/SpaQZXZlGMt5JoLFf1AkK4byirGEfA4vKNwZtWPmei53xP4bZrpXCJjHIboE0X
         dFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700307487; x=1700912287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwfAcLpPBP9/VcLdhWC2YYKbzJ5W2WwAWFFBT48SHb4=;
        b=eov6q7TDcTn9OYWlZmCWpyRAdm6qbjYnOtX8cGtHaVH8570IIIeJklT5YLpV5aosrV
         liFCEuN39kB8tJh/J3sMzghnHRljLZHdEs8zaaZpu2RjhhkNNkMzGA9hWaCib+z3BYH6
         OrCBNnw6g5ssKeC1sqnTq55h5WH/Ecf5dGFKhw8deNz91wma3B1ufgRiTcHsbDGy9zf4
         xBZgZnAtMPD7TEIgp+g/3baSBBKMnb60iVTikrEk/AyKbs1jSul7ylWGTBe4cM4Gmx9b
         SMmOTJyTg/zMdZbN6UMLeRkS6cJsRISu8abnXWTShhMiRpp8ML8zmMzQKCNLlLTa1vGR
         c9jA==
X-Gm-Message-State: AOJu0YyrKGXOEfD5dgoYeOVl0hrfTz9qvHJQBFy91oGxCwFLZNJZcFwp
        D2vfUX5cC0jBLFJQ6qqaALXqhoXriP8allx7I9Q=
X-Google-Smtp-Source: AGHT+IE+gKa6JOvpcInpH3bQMumK5AwCQgXOXPQVa/fdX7kkkSyuYgD+wsAxlw24m1SQ73zpdAvBhg==
X-Received: by 2002:a50:9ec3:0:b0:543:4fca:cc91 with SMTP id a61-20020a509ec3000000b005434fcacc91mr1333532edf.20.1700307486789;
        Sat, 18 Nov 2023 03:38:06 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7c747000000b0053dfd3519f4sm1669355eds.22.2023.11.18.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 03:38:06 -0800 (PST)
Date:   Sat, 18 Nov 2023 12:38:05 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sachin Bahadur <sachin.bahadur@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v3] ice: Block PF reinit if attached to bond
Message-ID: <ZViiHS0sYyoXHK+x@nanopsycho>
References: <20231117164427.912563-1-sachin.bahadur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117164427.912563-1-sachin.bahadur@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Nov 17, 2023 at 05:44:27PM CET, sachin.bahadur@intel.com wrote:
>PF interface part of LAG should not allow driver reinit via devlink. The
>Bond config will be lost due to driver reinit. ice_devlink_reload_down is

Reinit whould remove and re-create netdevices. This patch should not be
needed.


>called before PF driver reinit. If PF is attached to bond,
>ice_devlink_reload_down returns error.
>
>Fixes: trailer
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index f4e24d11ebd0..5fe88e949b09 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 					   "Remove all VFs before doing reinit\n");
> 			return -EOPNOTSUPP;
> 		}
>+		if (pf->lag && pf->lag->bonded) {
>+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");
>+			return -EBUSY;
>+		}
> 		ice_unload(pf);
> 		return 0;
> 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>-- 
>2.25.1
>
>
