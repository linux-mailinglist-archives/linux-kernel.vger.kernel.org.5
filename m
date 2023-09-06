Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E6794221
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbjIFRjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbjIFRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:39:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4832FE41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:39:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91714C433C7;
        Wed,  6 Sep 2023 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694021989;
        bh=woGQ3GBTdrvaqUWY294SsWX6BIxtB6DjopSTav8HuTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAmRXM1HkdREq/ViK+DGlAO09uz3GkksK3AX3TN9DIPeYudb+hm0PIOzprHI6Gcb8
         u70lT0NW439n3+WdmU7z+tiJixkLjFjysEhDhz+uP0t8l9iaoe9D5T4mgBkPwsCeBc
         Lzxp79blVpSk11xaqe51AouZ5yt8JVkjdjHxjQ6E3WzOoZGeo7/VHmQGMahRFV8I52
         gQ7IRwYdfwP7k/w9JkOWnE2GOUBWmqUlirC5akBAgsvKW9ZNSRue64pohPeocdtWVD
         DUOlOCYxNp5sxJNkiHigrmp5THOQd+BH7MuwQoCV7B1Pgeyx+dZfnOV41GYEAWq19q
         wwDnEHRyMczvg==
Date:   Wed, 6 Sep 2023 19:39:46 +0200
From:   Simon Horman <horms@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net 1/1] ptp: clockmatrix: support 32-bit address space
Message-ID: <20230906173946.GD270386@kernel.org>
References: <MW5PR03MB6932BFFE31583BBF02CD9488A0EFA@MW5PR03MB6932.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB6932BFFE31583BBF02CD9488A0EFA@MW5PR03MB6932.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:54:05PM -0400, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>

Hi Min Li,

A patch description should go here, describing the motivation for the
change.

It does seem to me that this is an enhancement rather than a bug fix.
And as such is more appropriate for 'net-next' rather than 'net'.
i.e. Subject: [PATCH net-next] ...

If the patch is for net-next then it will need to be resubmitted,
as per the form letter below. If, on the other hand it is for net,
a Fixes tag is most likely warranted.

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/ptp_clockmatrix.c    |  72 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  33 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 340 insertions(+), 307 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..875841892842 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,7 +41,7 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm);
>  
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> +			     u32 module,
>  			     u16 regaddr,
>  			     u8 *buf,
>  			     u16 count)
> @@ -50,7 +50,7 @@ static inline int idtcm_read(struct idtcm *idtcm,
>  }
>  
>  static inline int idtcm_write(struct idtcm *idtcm,
> -			      u16 module,
> +			      u32 module,
>  			      u16 regaddr,
>  			      u8 *buf,
>  			      u16 count)
> @@ -62,7 +62,8 @@ static int contains_full_configuration(struct idtcm *idtcm,
>  				       const struct firmware *fw)
>  {
>  	struct idtcm_fwrc *rec = (struct idtcm_fwrc *)fw->data;
> -	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
> +	u16 scratch = SCSR_ADDR(IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH));

I think you also need a similar change in idtcm_load_firmware().

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index 875841892842..69c170133a25 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1254,7 +1254,7 @@ static void display_pll_and_masks(struct idtcm *idtcm)
 static int idtcm_load_firmware(struct idtcm *idtcm,
 			       struct device *dev)
 {
-	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
+	u16 scratch = SCSR_ADDR(IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH));
 	char fname[128] = FW_FILENAME;
 	const struct firmware *fw;
 	struct idtcm_fwrc *rec;

As flagged by Smatch and clang-16 W=1.

> +	u16 gpio_control = SCSR_ADDR(GPIO_USER_CONTROL);
>  	s32 full_count;
>  	s32 count = 0;
>  	u16 regaddr;

...

-- 
pw-bot: defer
