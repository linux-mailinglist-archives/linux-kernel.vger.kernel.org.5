Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B179EACE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbjIMORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbjIMORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:17:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D9E64;
        Wed, 13 Sep 2023 07:17:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C816C433CA;
        Wed, 13 Sep 2023 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694614624;
        bh=/rNYMfmPg+JGRzNdRuWzEsyg8yvemb1m47ESpOOafwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2uI7QNFhk6zUFRfrqsp17vuk306nqCbi1llBnDYOLVTtrliQ/6/ZwRYO2+Sfd8dI
         4YO8yO1WYcDralnrpJOr0S0tMlBVyM1UhkQaNOzyxMsa1wq+rb4a6RSRbf/+F3n2mE
         Fuz2gEUz/ChF5Ovx3MwHuiGcEmBFiKjCQJiRrSBHiMjA5mArn2IptGVJ2D+q5UqJ46
         Wbj1wUHByl1bRy9D3W+m21+zRz9t7xTEcFLZx0BIzDX0UpvnFmL5F2+uj/98ynr7X9
         y+UWsgniWcFR6vVMV/CuZ03JeFhxRhbSxqrnAua2l4SZSKWy347zlVnVZF58Acl3EO
         gc01oA5q58odA==
Date:   Wed, 13 Sep 2023 16:16:58 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jinjian Song <songjinjian@hotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, jiri@resnulli.us,
        johannes@sipsolutions.net, chandrashekar.devegowda@intel.com,
        linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
        ricardo.martinez@linux.intel.com, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        nmarupaka@google.com, vsankar@lenovo.com, danielwinkler@google.com,
        Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v4 4/5] net: wwan: t7xx: Adds sysfs attribute of modem
 event
Message-ID: <20230913141658.GV401982@kernel.org>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
 <ME3P282MB27032EB049D5135D68ADE09FBBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB27032EB049D5135D68ADE09FBBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:48:44PM +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Adds support for t7xx wwan device firmware flashing & coredump collection
> using devlink.
> 
> Provides sysfs attribute on user space to query the event from modem
> about flashing/coredump/reset.
> 
> Base on the v5 patch version of follow series:
> 'net: wwan: t7xx: fw flashing & coredump support'
> (https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

Hi Jinjian Song,

some minor feedback from my side.

...

> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c

...

> +static ssize_t t7xx_event_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	enum t7xx_event event = T7XX_UNKNOWN;
> +	struct pci_dev *pdev;
> +	struct t7xx_pci_dev *t7xx_dev;

Please arrange local variables in networking code in reverse xmas tree
order - longest line to shortest.

https://github.com/ecree-solarflare/xmastree can be helpful here.

...

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c

...

> @@ -361,6 +367,10 @@ static int t7xx_devlink_flash_update(struct devlink *devlink,
>  	clear_bit(T7XX_FLASH_STATUS, &flash_dump->status);
>  
>  err_out:
> +	if (ret)
> +		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_FAILURE);
> +	else
> +		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_SUCCESS);

If the lines immediately above are reached as the result of jumping
to err_out, then port is not initialised.

>  	return ret;
>  }

...
