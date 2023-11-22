Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DC7F474B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjKVNCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbjKVNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:02:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD53193
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:02:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316ad2bee5so3253917f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700658131; x=1701262931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAYBW/dYtjxj/mIFheTLcX/YTMyi0LyyXwltchBNxB0=;
        b=elLTQnSm9XJcVRx/bhUqjBEm8bMjSnlwe2U09kiu4T3UZthjhCyQIdHEoZ5G0bLVY3
         I6A+PC4GeGvd8r6Sl2x8/RVux5iMsz4TuhX2gry807Q8DGhNIp8DoLcToPirL/tFy+Cv
         8Q+Efj9qANkBAShtZNIItmh7POAQR0+V94968m6W/7h3N+ONZ70aj26lSKjKBCFWS+t2
         Mjr8HH25H53fkUlf8Y8q41p0l/rhYsrLPbWJMiO1ic3VL3kAHM/1BO1MrC6GBM6L+XZX
         I2LXvDpZvGu54DB4YuBCmCqxKl4+MqCnFYjswmET9slqhKNrcnmL422eUolzpdPiDJ/c
         Z+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700658131; x=1701262931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAYBW/dYtjxj/mIFheTLcX/YTMyi0LyyXwltchBNxB0=;
        b=tXj0wLZBOHeAu0UaxyXPi9QY+/mHWFmMN8/Y8xmBsIAm9JdRHSZ9OKfg1ddgp8zhE2
         VDH+31kG63U2MLz+bR5lpZ2PWSdhsts9jgDUeteZrhlAcTKDKpmpVJSgI+5kWhofqwLW
         fjZGJjVbK0XDvgxvTOhAN4e8T4/vyMkExU0NIcl4TP9eVFfrQbfijWRFZBZ63+wICZ6b
         KB9uHE3uSD484PvxJdOgkkP6vITVLgWXfG9PcyWZPAbIoSV+HO0vg0P1pQvESd4URm9F
         Q5lh1qYp1f97LbAI4JG3pRbNtvXIkzogshyjY9KzDesUY1bO9wV69+rukjHZQcB/U3qs
         JHgA==
X-Gm-Message-State: AOJu0YwgHkWZLKnpoUL/wDWzSWJ7qIHpiN6PoJZIN9XBxjSfWxspMDZc
        4QpxN/jnOAbqNM4d3tOBxVlYUw==
X-Google-Smtp-Source: AGHT+IFm/gvzWYz8Z3gyoz/52Dw4SJ4D1BBYzMbXvuiTFLxpBZfbv3NItqBLCI+UzFq90ikS/hTasA==
X-Received: by 2002:a5d:6843:0:b0:32f:e1a2:526a with SMTP id o3-20020a5d6843000000b0032fe1a2526amr266266wrw.67.1700658131308;
        Wed, 22 Nov 2023 05:02:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x11-20020adfffcb000000b003316b8607cesm16215688wrs.1.2023.11.22.05.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:02:10 -0800 (PST)
Date:   Wed, 22 Nov 2023 08:02:06 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     pkshih@realtek.com, kvalo@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, lizetao1@huawei.com,
        linville@tuxdriver.com, Larry.Finger@lwfinger.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an
 undefined bitwise shift behavior
Message-ID: <2ec14802-78b0-4a3f-a730-19e95ec8d359@suswa.mountain>
References: <20231122090210.951185-1-suhui@nfschina.com>
 <20231122090210.951185-2-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090210.951185-2-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 05:02:12PM +0800, Su Hui wrote:
> Clang staic checker warning:
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:184:49:
> 	The result of the left shift is undefined due to shifting by '32',
> 	which is greater or equal to the width of type 'u32'.
> 	[core.UndefinedBinaryOperatorResult]
> 
> If the value of the right operand is negative or is greater than or
> equal to the width of the promoted left operand, the behavior is
> undefined.[1][2]
> 
> For example, when using different gcc's compilation optimizaation options
> (-O0 or -O2), the result of '(u32)data << 32' is different. One is 0, the
> other is old value of data. Adding an u64 cast to fix this problem.
> 
> [1]:https://stackoverflow.com/questions/11270492/what-does-the-c-
> standard-say-about-bitshifting-more-bits-than-the-width-of-type
> [2]:https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
> 
> Fixes: 21e4b0726dc6 ("rtlwifi: rtl8821ae: Move driver from staging to regular tree")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> index 6df270e29e66..89713e0587b5 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> @@ -106,7 +106,7 @@ u32 rtl8821ae_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
>  		regaddr, bitmask);
>  	originalvalue = rtl_read_dword(rtlpriv, regaddr);
>  	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
> -	returnvalue = (originalvalue & bitmask) >> bitshift;
> +	returnvalue = (u64)(originalvalue & bitmask) >> bitshift;

This is a right shift, not a left shift. << vs >>.

>  
>  	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
>  		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
> @@ -128,7 +128,7 @@ void rtl8821ae_phy_set_bb_reg(struct ieee80211_hw *hw,
>  		originalvalue = rtl_read_dword(rtlpriv, regaddr);
>  		bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
>  		data = ((originalvalue & (~bitmask)) |
> -			((data << bitshift) & bitmask));
> +			(((u64)data << bitshift) & bitmask));

The checker is printing an accurate warning, however, I'm not sure the
fix is correct.  Obviously, shift wrapping is bad and your patch would
eliminate that possibility.  However, data is a u32 so we end up
discarding the high 32 bits.  I can imagine a different static checker
would complain about that.

Perhaps, a better way to silence the warning is to just change
_rtl8821ae_phy_calculate_bit_shift() to not return 32 bits?  Do we
really ever pass bitmask 0?  No idea...

regards,
dan carpenter

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 5323ead30db0..42885e3a458f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -29,9 +29,7 @@ static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 					   u32 data);
 static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
+	return ffs(bitmask) - 1;
 }
 static bool _rtl8821ae_phy_bb8821a_config_parafile(struct ieee80211_hw *hw);
 /*static bool _rtl8812ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);*/
