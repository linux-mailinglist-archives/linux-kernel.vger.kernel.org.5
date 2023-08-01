Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD776C052
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHAWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjHAWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F42122
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D0F61718
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70EDC433C8;
        Tue,  1 Aug 2023 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690928447;
        bh=/3ZpV7PvDpNHQ6JI7sYfztIa7N59r470nd86poWPqmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTE57w5yErK0BlM9QonREzTHjki2N2LbQfa+C0ezrKNtIUe+5Yuojpi/hCnGqN9VS
         kajXcFpwRhHFzQtyu0nHCKFYROeZdkQE2/36JRA5xZ0OsoPOcVZ+NeI4sTjEeErL+C
         tBuQLqhtL1EIcvSHojhIQRx3LtEiUssniXh1dAENOnOHw5DHHEex8+CNoci3QLqPec
         BdgKs44IJMQYuNoBgTtc2wmG11jPsH83VPR+1u5PlTcEM0DHQgG2BRkgFw6LIMt31t
         vOS2Q3Qp7HEqVC7mIr0F6OBhA6XAt2y56dL4v3tXAP2LP1LoWL1yhDflCXcfO+UgsY
         HBfYotIZf73Rg==
Date:   Wed, 2 Aug 2023 00:20:44 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Feng Liu <feliu@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove PM #ifdef guards to fix i2c driver
Message-ID: <20230801222044.f2mewj4nedslepfk@intel.intel>
References: <20230801105846.3708252-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801105846.3708252-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Aug 01, 2023 at 12:58:15PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A cleanup in the virtio i2c caused a build failure:
> 
> drivers/i2c/busses/i2c-virtio.c:270:10: error: 'struct virtio_driver' has no member named 'freeze'
> drivers/i2c/busses/i2c-virtio.c:271:10: error: 'struct virtio_driver' has no member named 'restore'
> 
> Change the structure definition to allow this cleanup to
> be applied everywhere.
> 
> Fixes: 73d546c76235b ("i2c: virtio: Remove #ifdef guards for PM related functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/virtio.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 0f3b9017dff40..9b94e2c9bbb81 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -218,10 +218,8 @@ struct virtio_driver {
>  	void (*scan)(struct virtio_device *dev);
>  	void (*remove)(struct virtio_device *dev);
>  	void (*config_changed)(struct virtio_device *dev);
> -#ifdef CONFIG_PM
>  	int (*freeze)(struct virtio_device *dev);
>  	int (*restore)(struct virtio_device *dev);
> -#endif

oh yes! Thank you!

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
