Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04E763F85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGZT2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGZT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818EFE;
        Wed, 26 Jul 2023 12:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD5561C9A;
        Wed, 26 Jul 2023 19:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E606EC433C8;
        Wed, 26 Jul 2023 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690399678;
        bh=F7Dod8/nvUA0tq0PCrFVeNauL6pXHKi/K+D/3mDf+Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MmS470dbMJnDxmAM2gHkqoof8mpjP05HKaqd+FAk8g/e9KuqxYDrFRP3VDijSLrP
         CMi/B3ijrjBqhbbofNfnruBkFepKbiuCbXBQZk2fF64Cxt4a1Hex3vqobOSoAALNqv
         18F0FHQDiBentOHsEEaJB+3UAskjBKpXQfhyhAlk=
Date:   Wed, 26 Jul 2023 21:27:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa: Enable strict validation for netlinks ops
Message-ID: <2023072650-flight-reshuffle-65a0@gregkh>
References: <20230726185104.12479-1-dtatulea@nvidia.com>
 <20230726185104.12479-3-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726185104.12479-3-dtatulea@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:49:44PM +0300, Dragos Tatulea wrote:
> The previous patch added the missing nla policies that were required for
> validation to work.
> 
> Now strict validation on netlink ops can be enabled. This patch does it.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index f2f654fd84e5..a7612e0783b3 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1257,37 +1257,31 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  static const struct genl_ops vdpa_nl_ops[] = {
>  	{
>  		.cmd = VDPA_CMD_MGMTDEV_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_mgmtdev_get_doit,
>  		.dumpit = vdpa_nl_cmd_mgmtdev_get_dumpit,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_NEW,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_add_set_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_DEL,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_del_set_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_get_doit,
>  		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_CONFIG_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_config_get_doit,
>  		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>  	},
>  	{
>  		.cmd = VDPA_CMD_DEV_VSTATS_GET,
> -		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> -- 
> 2.41.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
