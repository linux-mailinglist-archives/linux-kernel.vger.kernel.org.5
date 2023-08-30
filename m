Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF678DB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbjH3SkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245674AbjH3Px0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:53:26 -0400
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:53:24 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A1193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED39AB81F57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C900C433CC;
        Wed, 30 Aug 2023 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693410304;
        bh=NiQRt4bsIONLVxmfGlIB8xOVLmN2sexG/RoTqc5xU/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnNPxu55t69M9MEH5fJjGRUtQrVVWMrM/Jm/FOFZ5EUmvpGINUZTquxJ9JijEXAdn
         SgbcvdZCUH1wKw4MHoa+FPcxyDDfMrEPvq6unPqUXOXvXIPGkhTFiGHGt3bDLCNP8E
         D84XynJqierIMHi9w1DMMjS+jsyJWLrasQGLmCQFtg3jRqL7Q0Xr0ZT4x/vD2LW009
         U8bvlHNRXkVxfws3pYyXCdv+CirPp3y1AV2I+2+YzYP+DeeNsiklVgM64pgse5e0mt
         CgjaOrfWvi45WRdTHVs2ymRRWjuxa4H8gVYMziv761GncvcyR2F8ewcVEBnmsXHzfV
         gzjq5n1ep9PHA==
Date:   Wed, 30 Aug 2023 08:45:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cs42l43: Use correct macro for new-style PM runtime
 ops
Message-ID: <20230830154502.GA954483@dev-arch.thelio-3990X>
References: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:49:14PM +0100, Charles Keepax wrote:
> The code was accidentally mixing new and old style macros, update the
> macros used to remove an unused function warning whilst building with
> no PM enabled in the config.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

This is obviously the correct fix for the reported warnings.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/mfd/cs42l43.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> index 37b23e9bae823..7b6d07cbe6fc6 100644
> --- a/drivers/mfd/cs42l43.c
> +++ b/drivers/mfd/cs42l43.c
> @@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
>  }
>  
>  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> -	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> -	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> +	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
>  };
>  
>  MODULE_DESCRIPTION("CS42L43 Core Driver");
> -- 
> 2.30.2
> 
