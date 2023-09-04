Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5F7919D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbjIDOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjIDOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30B128
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C5C617D8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57B7C433C7;
        Mon,  4 Sep 2023 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693838412;
        bh=wu9CoQRDbfdzKFjYXjYkU7f3X86+jkiGe0fTEZrRyvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ50tvn9puhHteIC2gsBL+X5ajeZ5a/AmzosxkVprgeLCf2bXj+7WA3R7/tNEAEaf
         ea7gw95nD378dZ783ASYvQNlglFgOq5+vpo9dDHKl+2FBYgTMWRLHccwEQoEXxkMR/
         27TYs1HxlYaS/JSW0mOVHn0/DeWCf02c1tMOuRAwgsOlE6HMFej5Awtqm1g5Teu+AS
         BfDihqrpBU8aviSwCEDSnNjY4khRj9RkgQdd20X4IAp/8x5mYMZpDMfWc9L2yhCacb
         wD+jaSYyaro1e3Lugljppkzt2sMz8hvBsdRCyqXyciUDh+xWiYa0Sn2MMxWcAJFQM9
         9/4M1ObTrL62A==
Date:   Mon, 4 Sep 2023 15:40:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH] mfd: cs42l43: Use correct macro for new-style PM runtime
 ops
Message-ID: <20230904144008.GG13143@google.com>
References: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023, Charles Keepax wrote:

> The code was accidentally mixing new and old style macros, update the
> macros used to remove an unused function warning whilst building with
> no PM enabled in the config.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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

Acked-by: Lee Jones <lee@kernel.org>

If anyone wants to submit this directly to Linus before -rc1, please, be
my guest.

-- 
Lee Jones [李琼斯]
