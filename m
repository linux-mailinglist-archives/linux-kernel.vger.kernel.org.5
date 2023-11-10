Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B087E762C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbjKJBBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJBB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:01:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA71BD;
        Thu,  9 Nov 2023 17:01:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D74BC433C7;
        Fri, 10 Nov 2023 01:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699578087;
        bh=3Zwn8mXaL4Iuj8o6fu7I1L1XY8iCIFNrgn7GhwwZ3CU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tB3V/P8kQbjXvhEuMjlXdUoVBLudPOrbgBMV1Z8+aL0tDV5a2UqSlPdekBRHKYVJu
         uf0JHBsWiU7NXeywTWfLl16QzoJmOd4tKjJIEIQJexPxentV91KJhTHiDcjCiLvSUz
         AK5wAV2/XCcqEgGM3sDuE8N5Pzf7GFn71KtSPOy30w0Ux636yuYtL8MJe6HeQNLgMI
         zA/JUuVhDq/zwmrG4wkTrd/1/Vf8K5E9L6nAbtIi83iV7u5wi7EgmUi6UTe+nR2p3P
         /9O4afWxcVwRhsSVpIc7v07OU73HZnLvOH3v8NW59EIYHpMBShvxtItNzZEZcjl1Ho
         nRubm4nEztqxg==
Message-ID: <bbe5e6d2-9622-4f36-b832-450bf56424f9@kernel.org>
Date:   Fri, 10 Nov 2023 10:01:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pata_isapnp: Add check for devm_ioport_map
Content-Language: en-US
To:     Chen Ni <nichen@iscas.ac.cn>, s.shtylyov@omp.ru, jeff@garzik.org,
        htejun@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231031040007.2498659-1-nichen@iscas.ac.cn>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231031040007.2498659-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 13:00, Chen Ni wrote:
> Add check for devm_ioport_map() and return the error if it fails in
> order to guarantee the success of devm_ioport_map().
> 
> Fixes: 0d5ff566779f ("libata: convert to iomap")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Apologies for the delay. This fell through the cracks :)
Applied to for-6.7-fixes. I will send this next week.

> ---
>  drivers/ata/pata_isapnp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
> index 25a63d043c8e..0f77e0424066 100644
> --- a/drivers/ata/pata_isapnp.c
> +++ b/drivers/ata/pata_isapnp.c
> @@ -82,6 +82,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
>  	if (pnp_port_valid(idev, 1)) {
>  		ctl_addr = devm_ioport_map(&idev->dev,
>  					   pnp_port_start(idev, 1), 1);
> +		if (!ctl_addr)
> +			return -ENOMEM;
> +
>  		ap->ioaddr.altstatus_addr = ctl_addr;
>  		ap->ioaddr.ctl_addr = ctl_addr;
>  		ap->ops = &isapnp_port_ops;

-- 
Damien Le Moal
Western Digital Research

