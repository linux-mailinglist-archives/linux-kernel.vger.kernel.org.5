Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0D7934B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjIFFHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjIFFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:07:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D44197;
        Tue,  5 Sep 2023 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=lu5CsFTRvNr2ltXiexrLfJ//QES5eteF0z+ySRWEFww=; b=fBMcQWBkpelZiJnLJ61x+/6zhe
        t/iDgcdwPc4iUifkHpZqMwkKw9lah9QNFs5GXDilC0YmlSdh3K0HkdQKphSlzHx5m6POhpxVwoUMp
        eIKGpvq6HxSIbeP1zC/6z9pbDAzEBy+GKI0ZtWZnVLjfgqvsGMF1eJYkSdvlM4MQh5T5ee7/gNYui
        4vmz4fgXnKcuaF92nzfJ+hgtQiSfoa8dYFjNAwllcSpBkC49zthaDiCL5WWInBg19UeGO6kyE3DTk
        UgZLYqnzoiEdcQeY1x0asLAz3NBoreo8VhJ9gD5JBFhWlaY/7sYulJEZVzaV3m/S9q5Y0L1EfvnUU
        kKYPaVoA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdklK-007H5s-2l;
        Wed, 06 Sep 2023 05:07:34 +0000
Message-ID: <4b55e7c0-aed2-5225-fcac-1122a985800b@infradead.org>
Date:   Tue, 5 Sep 2023 22:07:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] mlxbf-bootctl: add NET dependency into Kconfig
Content-Language: en-US
To:     David Thompson <davthompson@nvidia.com>, hdegoede@redhat.com,
        markgross@kernel.org, vadimp@nvidia.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230905133243.31550-1-davthompson@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230905133243.31550-1-davthompson@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 9/5/23 06:32, David Thompson wrote:
> The latest version of the mlxbf_bootctl driver utilizes
> "sysfs_format_mac", and this API is only available if
> NET is defined in the kernel configuration. This patch
> changes the mlxbf_bootctl Kconfig to depend on NET.
> 
> Reported-by: kernel test robot <lkp@intel.com>

Also
Reported-by: Randy Dunlap <rdunlap@infradead.org>

> Closes: https://lore.kernel.org/oe-kbuild-all/202309031058.JvwNDBKt-lkp@intel.com/
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/platform/mellanox/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
> index 382793e73a60..e52aea996ca5 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -60,6 +60,7 @@ config MLXBF_BOOTCTL
>  	tristate "Mellanox BlueField Firmware Boot Control driver"
>  	depends on ARM64
>  	depends on ACPI
> +	depends on NET
>  	help
>  	  The Mellanox BlueField firmware implements functionality to
>  	  request swapping the primary and alternate eMMC boot partition,


I'm sure that this will fix the build problem, but I don't see this
being a network driver. To me it looks like some management s/w
that can run independently of networking software.
It just wants to show/store a MAC address -- no networking.
FWIW.

-- 
~Randy
