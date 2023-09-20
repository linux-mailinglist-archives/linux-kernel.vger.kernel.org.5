Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00D7A77F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjITJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjITJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:52:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408B8F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:52:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF699C433C8;
        Wed, 20 Sep 2023 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695203572;
        bh=G3+t/AULLWNh/21z8lviL/DfMfnBVEfDFPKXU/x5BUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNkLOFC6GBv/DB79y+fdROm7M47768bWI9Vxlr4zTuYfWvtGIHJTrxWRACe/H7vEB
         nxR1VT8B6Otw+uCW1B118CyHut8SoO1Dh4zrlvJ35qDnebAy2VHDi04+6e6rILtJYr
         ESrhTYDtDWzVq6ND2MH1yZ1eXbjc6ujEixBCwh4R93wtVzKvE8awExTXHSryPdbf8P
         DR0hLE35Rt1XM47NWtn9zYU3DJmSvjF554DAIyUbt7+rcVDi5NXejNqYHHIiHy+8Ca
         QVqo13+B1ycKy+T/xV8Yc6UgXbiaEpc0Z2IdRBno9NXmbiEJDLTnvap24yKuNhEgw/
         5w8EDtuA9XREg==
Date:   Wed, 20 Sep 2023 10:52:48 +0100
From:   Lee Jones <lee@kernel.org>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] mfd: cs42l43: fix defined but not used warnings
Message-ID: <20230920095248.GC13143@google.com>
References: <20230905021209.1412987-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230905021209.1412987-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2023, zhangshida wrote:

> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Warnings were generated during compiling for functions like
> cs42l43_*_{resume,suspend}:
> 
> ../drivers/mfd/cs42l43.c:1138:12: error: ‘cs42l43_runtime_resume’ defined but not used [-Werror=unused-function]
>  1138 | static int cs42l43_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/mfd/cs42l43.c:1124:12: error: ‘cs42l43_runtime_suspend’ defined but not used [-Werror=unused-function]
>  1124 | static int cs42l43_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/mfd/cs42l43.c:1106:12: error: ‘cs42l43_resume’ defined but not used [-Werror=unused-function]
>  1106 | static int cs42l43_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> ../drivers/mfd/cs42l43.c:1076:12: error: ‘cs42l43_suspend’ defined but not used [-Werror=unused-function]
>  1076 | static int cs42l43_suspend(struct device *dev)
> 
> Fix it by guarding it with CONFIG_PM/CONFIG_PM_SLEEP.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  drivers/mfd/cs42l43.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> index 37b23e9bae82..e589a61c118d 100644
> --- a/drivers/mfd/cs42l43.c
> +++ b/drivers/mfd/cs42l43.c
> @@ -1073,6 +1073,7 @@ void cs42l43_dev_remove(struct cs42l43 *cs42l43)
>  }
>  EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int cs42l43_suspend(struct device *dev)
>  {
>  	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> @@ -1120,7 +1121,9 @@ static int cs42l43_resume(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
> +#ifdef CONFIG_PM
>  static int cs42l43_runtime_suspend(struct device *dev)
>  {
>  	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> @@ -1176,6 +1179,7 @@ static int cs42l43_runtime_resume(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
>  
>  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
>  	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)

I see a bunch of drivers using PM helpers and not many of them are
are being guarded by ugly #ifery.  Please find out what they're doing to
solve the same issue and replicate that instead.

Here's a really big hint:

  `git log --oneline 02313a90095fb`

-- 
Lee Jones [李琼斯]
