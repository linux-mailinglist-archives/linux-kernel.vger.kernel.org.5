Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9A7E7452
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKIWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:25:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967153C01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:25:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF82C433C7;
        Thu,  9 Nov 2023 22:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699568712;
        bh=w9isLM5Dd7BL6Ud2XPJ80zIY1TA7rWT1OEsuJNBQIcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rw0f3o8iRiVJ5qzx1weQR7M4PRmrppZv9MJmd+ae3wt12CExCQnfqASRAxMUAI6VI
         iyHNZj82AoCNcMdmoE/9D1efDYc6m2MmxkDw1siAhpOfyZ13HPbxoPk5dvr8u64/Na
         8AIu6ox+Fv45O79B7pggkot8usQRw+Ecbvc04My4KpHXFsMD0WG0gzgwOBAQNiKSA5
         K2Hwae6HScJdgVfiDr3aCecNN8J+LN6bdVMwVGBFm04DKjWQnsHxrMOYf4/XLkVxp+
         w2dGz5+gz9k2wqBdTfL/GVTkFpjbfjpb/FUQjBMRvm4O0aUSDY3In6Y4q/TN1F2Rfr
         6K/BaU7Bj3N9w==
Date:   Thu, 9 Nov 2023 17:25:08 -0500
From:   Simon Horman <horms@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20231109222508.GC568506@kernel.org>
References: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:13:52PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul

...

> @@ -62,7 +62,8 @@ static int contains_full_configuration(struct idtcm *idtcm,
>  				       const struct firmware *fw)
>  {
>  	struct idtcm_fwrc *rec = (struct idtcm_fwrc *)fw->data;
> -	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
> +	u16 scratch = SCSR_ADDR(IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH));

Hi Min Li,

I think a similar conversion for scratch in idtcm_load_firmware()
is required.

As flagged by clang-16 W=1, and Smatch.
`
> +	u16 gpio_control = SCSR_ADDR(GPIO_USER_CONTROL);
>  	s32 full_count;
>  	s32 count = 0;
>  	u16 regaddr;

...
