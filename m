Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D27CD69D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjJRIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbjJRIdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:33:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F20F10C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:33:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A8C433C9;
        Wed, 18 Oct 2023 08:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697617984;
        bh=JCobLY4PQbNo/OadzXHobT7yufD2DypNJuvfESqM2HM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+dUmYUxHYcwx3NNrG2uKOdo1olAr6xgCpPcdKOL/beEZge9lydlU4VBrkap+yii5
         VDfsf1N+PoStk3ZXbFPhz5LRRS/KVeavE/C8J5YAUYxEodclmgJe7YsPN34J4+gkai
         Axmnddc2WTDolL9azg+IbfS7UO9rbbfmpEMQBqm0=
Date:   Wed, 18 Oct 2023 10:33:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <2023101841-wow-stardust-3c09@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-6-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081941.475277-6-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:19:41AM -0700, Saeed Mahameed wrote:
> +#define umem_dbg(__mdev, fmt, ...) \
> +	dev_dbg((__mdev)->device, "mlx5ctl_umem: " fmt, ##__VA_ARGS__)

That's really really odd, and should not be needed for dev_dbg() because
you already have the driver name and file name and line information in
that message.  Why add yet-another-prefix?  Please just use normal
dev_dbg() lines.

> +#define MLX5CTL_UMEM_MAX_MB 64
> +
> +static size_t umem_num_pages(u64 addr, size_t len)
> +{
> +	return (size_t)((ALIGN(addr + len, PAGE_SIZE) -
> +			 ALIGN_DOWN(addr, PAGE_SIZE))) /
> +			 PAGE_SIZE;
> +}

We don't have a function or macro for this already?

thanks,

greg k-h
