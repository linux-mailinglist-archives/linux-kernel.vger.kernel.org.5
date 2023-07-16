Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E335754D78
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGPFo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGPFoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 01:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0CEE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 22:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D175D60C52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 05:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A7EC433C8;
        Sun, 16 Jul 2023 05:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689486250;
        bh=K3KSV69KL+G4EpdOXNT0X1s+4FdOMMdZE2tLA+LKUBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxRGKWUNC4rFUWq/sc8jNmyqfsRLxI3l3+xk3CIjcqzeqkVdATtOksHqr4rb9EmY7
         nuqkTOXVAuXkoWfPVWPIks75fJOO6HCmyeEaaaMYv39ker/n/7xeTZL0wnuj0q02ie
         V81iXpzoz+tQuap16fHTaC80RnALG3WoE4I0vzqM=
Date:   Sun, 16 Jul 2023 07:44:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        Richard Gong <richard.gong@intel.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] firmware: Fix an NULL vs IS_ERR() bug in probe
Message-ID: <2023071643-anthill-snowdrift-f1f6@gregkh>
References: <20230716015310.12293-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716015310.12293-1-machel@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 09:52:57AM +0800, Wang Ming wrote:
> The devm_memremap() function returns error pointers.
> It never returns NULL. Fix the check.
> 
> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/firmware/stratix10-svc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 2d674126160f..935bc0cf913f 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -756,7 +756,8 @@ svc_create_memory_pool(struct platform_device *pdev,
>  	paddr = begin;
>  	size = end - begin;
>  	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
> -	if (!va) {
> +
> +	if (IS_ERR(va)) {

Why did you add an extra blank line?

