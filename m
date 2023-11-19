Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C077F050B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjKSJpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjKSJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:45:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25162D7A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:44:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DF8C433C7;
        Sun, 19 Nov 2023 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700387078;
        bh=Fl4ApciDc/jv8fxMx5Ald8QojByY2Q5XIcdQaqIWnqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d24DvuWG5nnomn6ZcMnBP2nbOjCiNdMm70OXeqzQoySFksT9fJCiTPzdWukrGOArn
         wVn6p0hK7CF2dXFhK3QhWRSINdO7XHWwnWWaE2zdg/URqiNM2GMxY5fFAqeHFULTYu
         /AAst56Ec9sqRksSTM6+KfPlBOwv/8PK6Ewkjbxri1LWI3oKTf/dmgPjgtokZ/qET3
         t4AiOpiS0bZQAdTwcoqYpapWECVDoFYodnlR0Ys5cDvhq311ycNlr5Xsd4QgVg+9j9
         zkWGZ5s4EKSsZriMaZABDx7lmD0HxR6lF1fsIp+/jAZ0SCU9Cjo893ywZfEqn8VNvW
         mZ0IbEtoWqkog==
Date:   Sun, 19 Nov 2023 01:44:37 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <ZVnZBXtV5LYUWUHp@x130>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-6-saeed@kernel.org>
 <bfdc04b3-d776-4cb9-a95a-eec317e792e1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bfdc04b3-d776-4cb9-a95a-eec317e792e1@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Oct 11:30, Arnd Bergmann wrote:
>On Wed, Oct 18, 2023, at 10:19, Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>
>>
>> To do so this patch introduces two ioctls:
>>
>> MLX5CTL_IOCTL_UMEM_REG(va_address, size):
>>  - calculate page fragments from the user provided virtual address
>>  - pin the pages, and allocate a sg list
>>  - dma map the sg list
>>  - create a UMEM device object that points to the dma addresses
>>  - add a driver umem object to an xarray data base for bookkeeping
>>  - return UMEM ID to user so it can be used in subsequent rpcs
>>
>> MLX5CTL_IOCTL_UMEM_UNREG(umem_id):
>>  - user provides a pre allocated umem ID
>>  - unwinds the above
>>
>

[...]

>> +
>> +	umem_id = mlx5ctl_umem_reg(mfd->umem_db, (unsigned
>> long)umem_reg.addr, umem_reg.len);
>
>umem_reg.addr seems to be a user space address, so I would
>suggest consistently passing it as a 'void __user *' instead
>of casting to (unsigned long) here. You can use u64_to_user_ptr()
>to handle the pointer conversion correctly across all
>architectures that way, and get better type checking.
>

Hi Arnd,
I handled all of your comments in V2 except this one, since here we use
the user address for arithmetic calculations only, so it is easier to
convert it to (unsigned long) early on ..

