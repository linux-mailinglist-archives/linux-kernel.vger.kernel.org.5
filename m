Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6F7F0510
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjKSJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKSJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:49:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71933F9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:49:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3822C433C7;
        Sun, 19 Nov 2023 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700387369;
        bh=3a5Gn7rFtAxlkvJ1/i8+/JGUTthS4YkHAdmksXABxx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2jv3BUwWQqXgyhazr8XrIoSKX19cOjVLHH2XgcsnFeXxoge5zeLJ4OjAcPUppE44
         M679skES7yDoeG+3SubvQ/TLndp8EM/+BdaDX9O3M+mQpA81aSuUVHST56nFRxgq5u
         BR0eaK+1vjsd/tPoUrDUBRdy6azO/bXfwHq/M85old0xNLwvzdU3S5MrD7kFmP8ydq
         Jx6rRT44IzWsM85uzumosh8Qou4BWBzbG+uFSrezhnc8+6mjFPMboUSfFdh2mPj+uP
         4FhTnRBPQvSqhB+1J7nk472LpELW/yxP2p5zforScxGhfX1wlmo0mdG+1SHS7NMqu9
         Kf+a+MM+MGIWg==
Date:   Sun, 19 Nov 2023 01:49:27 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <ZVnaJ5vW7iLboQkJ@x130>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-6-saeed@kernel.org>
 <2023101841-wow-stardust-3c09@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023101841-wow-stardust-3c09@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Oct 10:33, Greg Kroah-Hartman wrote:
>On Wed, Oct 18, 2023 at 01:19:41AM -0700, Saeed Mahameed wrote:
> +#define MLX5CTL_UMEM_MAX_MB 64
>> +
>> +static size_t umem_num_pages(u64 addr, size_t len)
>> +{
>> +	return (size_t)((ALIGN(addr + len, PAGE_SIZE) -
>> +			 ALIGN_DOWN(addr, PAGE_SIZE))) /
>> +			 PAGE_SIZE;
>> +}
>
>We don't have a function or macro for this already?
>

I looked around and saw similar implementations, but nothing generic,
each has different assumptions, for example PAGE_SIZE can be different
or base address is assumed to be PAGE aligned, or len has a specific
alignment, so each use is a bit different.

I managed to reduce this to a one liner in V2.

Thanks,
Saeed.

