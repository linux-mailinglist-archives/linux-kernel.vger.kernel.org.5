Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0626780E2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbjLLDqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLLDqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:46:31 -0500
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19BB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:46:36 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 40790 invoked from network); 12 Dec 2023 04:46:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1702352789; bh=KEnyD0G9lUx4nu5+rapx3vQ3jzs5K2y6u+B86vS4Spg=;
          h=From:To:Cc:Subject;
          b=U6WEvZCxvP26U467tukZG5fiewSwlnRchWXKljjTWMmWzRdXI/nRb6HLZormOaO96
           0eBY30iUfiAQTpbjNywsWiE/oB+o3bQDy85Guf76cbv7KQDo9OxjhEZuIMSmD5S7rr
           jUeshJilBr4iO+/ouML1OOhOxQFRt6z/mMo1q8C0=
Received: from 89-64-13-61.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.61])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <chentao@kylinos.cn>; 12 Dec 2023 04:46:29 +0100
Date:   Tue, 12 Dec 2023 04:46:29 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] iwlegacy: Add null pointer check to il_leds_init
Message-ID: <20231212034629.GA24323@wp.pl>
References: <20231211033019.238149-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211033019.238149-1-chentao@kylinos.cn>
X-WP-MailID: a1807858da1ce335e0bf330da43f922c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kVNU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:30:19AM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index 054fef680aba..17570d62c896 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -541,6 +541,9 @@ il_leds_init(struct il_priv *il)
>  
>  	il->led.name =
>  	    kasprintf(GFP_KERNEL, "%s-led", wiphy_name(il->hw->wiphy));
> +	if (!il->led.name)
> +		return;
> +
>  	il->led.brightness_set = il_led_brightness_set;
>  	il->led.blink_set = il_led_blink_set;
>  	il->led.max_brightness = 1;
> -- 
> 2.39.2
> 
