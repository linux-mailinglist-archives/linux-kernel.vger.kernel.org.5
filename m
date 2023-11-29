Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBD7FD1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjK2JIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjK2JIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:08:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCAE1BDC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:08:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EBFC433C7;
        Wed, 29 Nov 2023 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701248921;
        bh=MwgL1kcUU0p+j6TDnsevHvbF5wGMikcg9hRR7s46RQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nh1svg8aog05AEGocb3HiRgJpumKWuOcGk6ae9e8KmVq7U7ZmTsGDONtjUkcz2KnS
         ghK7tUAcqy2oX29n6qYYuYKw70MzpjPtFIWD+7Pw4nU/EAmrxIDvmWxcav5gjFH7w1
         GFqEFqhinbiSEgPgfyLgWpjQnrfM/VRL8GfEHFJQciF6V9fIaE194xWk9R6noKyUe8
         fP6twcKn2RemSYdgFj20CnJAtOCaEKb7a/1Db08iiMQN8Bc7ktLKkW6IRMXPESM0yH
         wRbHvwwPozNu7msiINrrWceHL58XqVeopY5lk82FmGaJf4vdUEzjC8i+oyMUidPKJk
         lD7wbwK++JhZA==
Date:   Wed, 29 Nov 2023 01:08:39 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZWb_l7rC4QK8duU3@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112727-caddie-eardrum-efe8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023112727-caddie-eardrum-efe8@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 18:59, Greg Kroah-Hartman wrote:
>On Mon, Nov 20, 2023 at 11:06:16PM -0800, Saeed Mahameed wrote:
>> +struct mlx5ctl_dev {
>> +	struct mlx5_core_dev *mdev;
>> +	struct miscdevice miscdev;
>> +	struct auxiliary_device *adev;
>> +	struct list_head fd_list;
>> +	spinlock_t fd_list_lock; /* protect list add/del */
>> +	struct rw_semaphore rw_lock;
>> +	struct kref refcount;
>
>You now have 2 different things that control the lifespan of this
>structure.  We really need some way to automatically check this so that
>people don't keep making this same mistake, it happens all the time :(
>
>Please pick one structure (miscdevice) or the other (kref) to control
>the lifespan, having 2 will just not work.
>

miscdevice doesn't handle the lifespan, open files will remain open even
after the miscdevice was unregistered, hence we use the kref to defer the
kfree until the last open file is closed.

>Also, why a rw_semaphore?  Only use those if you can prove with a
>benchmark that it is actually faster, otherwise it's simpler to just use
>a normal mutex (hint, you are changing the fields in the structure with
>the read lock held, which feels very wrong, and so needs a LOT of
>documentation, or just use a normal mutex...)
>

It is needed so we can protect against underlaying device unloading while
miscdevice is active, we use rw semaphore since we don't care about
synchronization between any of the fops, but we want to protect current
active ioctls and fops from sudden mlx5ctl_remove (auxiliary_driver.remove)
which can happen dynamically due to underlaying device removal.

So here is the locking scheme:

write_lock() : only on mlx5_ctl remove and mark the device is down
via assigning NULL to mcdev->dev, to let all new readers abort and to wait
for current readers to finish their task.

read_lock(): used in all fops and ioctls, to make sure underlaying
mlx5_core device is still active, and to prevent open files to access the
device when miscdevice was already unregistered.

I agree, this should've been documented in the code, I will add
documentation.


>thanks,
>
>greg k-h
