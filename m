Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0E7FA95B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjK0S7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjK0S7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:59:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44EED4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:59:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46187C433C7;
        Mon, 27 Nov 2023 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701111554;
        bh=Evnqx1z1/S6wB+DGU8MkMOg+woE8DrTDrItqC+r57lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XANlISV1xf1fmQVFpXBopOP+AnSU7G7UrOU7S/ZcU9L8stKKyEPie3AtN7u9F8P1t
         JkBriUUwEUsKz3nIsqd3aHhkCOiKkm70rUqn2aPCdYgxTAjRPLTXEvaXfCveKXwdom
         rtAdTl31K+KBtQDN5JEiMyHZw3cIlCTbfy7YldQ0=
Date:   Mon, 27 Nov 2023 18:59:12 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112727-caddie-eardrum-efe8@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070619.9836-3-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:06:16PM -0800, Saeed Mahameed wrote:
> +struct mlx5ctl_dev {
> +	struct mlx5_core_dev *mdev;
> +	struct miscdevice miscdev;
> +	struct auxiliary_device *adev;
> +	struct list_head fd_list;
> +	spinlock_t fd_list_lock; /* protect list add/del */
> +	struct rw_semaphore rw_lock;
> +	struct kref refcount;

You now have 2 different things that control the lifespan of this
structure.  We really need some way to automatically check this so that
people don't keep making this same mistake, it happens all the time :(

Please pick one structure (miscdevice) or the other (kref) to control
the lifespan, having 2 will just not work.

Also, why a rw_semaphore?  Only use those if you can prove with a
benchmark that it is actually faster, otherwise it's simpler to just use
a normal mutex (hint, you are changing the fields in the structure with
the read lock held, which feels very wrong, and so needs a LOT of
documentation, or just use a normal mutex...)

thanks,

greg k-h
