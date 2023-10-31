Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECED7DCD10
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjJaMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJaMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:37:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505A97
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698755779; x=1699360579; i=wahrenst@gmx.net;
        bh=Wol4eZK7l5EC/qWI/PPM4Y8Byp+bD7f9MiXGXAsIAl0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=q6Qoyibzpdyk/FbPWOuJCaZpAAVUCaTtQzTBBvbwZS+Tds8wxvbsUTGKfwcxPwJN
         KTU4O97lPYs7BBtT8swiMDZP4CCEzNaMN14qa2LmZjUyCTBBhxgpgMsuF0+Y9zgGN
         uvE1C3Y7KzztKJqVGiYRJdB50uRG3qi1KGITH2IUDr+g4ld3mqcstBfvvYW9fz/sL
         liFc+JICBi1iARWggAR6PJy3Gvn8AfIf2CrLzTclm06pIMGZuon+0WTDzMp/TVvK3
         kfLWRWHMJq8cFP6/+2bUh9tsEn++KCOmFYklEXIZ7+xz/aTUzSmbj6rw19hEX2owl
         4ogaSVlWLVsIs8lPaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1r6Ju01lYl-008a8Q; Tue, 31
 Oct 2023 13:36:19 +0100
Message-ID: <dfda6779-6ac7-4d4c-b249-84780b30bd42@gmx.net>
Date:   Tue, 31 Oct 2023 13:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine
 after a timeout
To:     mike.isely@cobaltdigital.com, Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Cc:     Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
 <20231030162114.3603829-2-mike.isely@cobaltdigital.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231030162114.3603829-2-mike.isely@cobaltdigital.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vk8xJvqTk/EoVcLoA1PPiGdNCMJ9xJ4cxiA64I3Upz+949fgMSw
 l1z1cNO4fIqZk8mCZamJBUQfI4WVuD8P8IQSF37iAD8O5hYz3bizXkdv+RrjhXVWtW95+59
 pjUWfnLlZiVHwjJrdX6RnvAyJ/00JhTggR9Ly5NmxCKYZyT22Bk+BXaOwKAu7pDDM2FDyWc
 LdARXGtIpLqs/J/KJ5/Zw==
UI-OutboundReport: notjunk:1;M01:P0:sz6lUGrfC0E=;TevaV2Crd4AxLzB8224Lcf7eZ5X
 ASS6aeFWA8tkDWPpaBrS8HhTUxhPH7HD5sjRqdAQ7+EZhQL3kUYmvBmOIU4u0UN+pna6PH4J9
 ZimgOjhOHuyaWifczgHCC1LTQbAjKXa31HDkrq6qfNyJIQ90HjTZ4wymHAxGY5hpT6CTaCMeS
 MrhmX895LqlGlChp8qak49CnCnFqDzxEajU9jIaPumxHDG6B3pURGzAnudBJDpaq0ztVsdsx0
 4p3qYYxXO58TxO3C6AfAlmZLFJz7o8cY69nm7TIZCiXEFDWOR+/7UWMruPeYpYZBxV0GRP2hy
 mYZCnwclNQv0U+YyD42+mDZOgTKRRnJCNNt6+q7YrPR2esnCeykd02NEz1612W3VONLhjhM5K
 ZFNa6JKda+fzSUTMHbM8/Hs1OjMGLcKRcAfVwCzbxmRhjhXeQqj3B0jwm6Lg52bTMH5scYt5E
 e2yvN1C2WRdRohEC6Quvsfue6I4Ihj8TBh5ge3gBjimr+1MCb2YWT8W60vf4obfjBbTW4ABuB
 uRJ6v98fJYA/9Zy4zw4Ot1u6jNJ5xEVbWtkcoSyE1Ljx4PbD6gRosV5d68XHLFp06kzX2grWv
 lc4sWqMvpKADzW5Vz3jlEkHe/JZO6QI2WQ2i8WrH0f0gSN31IkhtwJ4Fcln64MP5cWEetB1Yt
 DKVHc+pLPmnm2HA6hkZ//RCv2QYJz1JWLUsKxoERHwZhn4wZkqs52HQ6uCYmx2bkjKJmw9shr
 gSyKquoa17OxuUch5pgSz3O4FL3LbZrjwnyWd7QTEaWHCLzeWPkgbvYE2lcRWYYPay06dRlqI
 4xGW7SDHObD5Isuxav7mQ4hZUeT0qOSjIlBBhdjrfZD5yrD3DFZC06hItvNzoCV5KrJLjP2Wg
 jBOZNlUwQQ5G1JdS1ZNbUZA05aV8ELnqqMdEILSXgocF8oW2K3pFsXlUGZvafO/dasOHL1JhB
 8T3qVA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Forward to Dave and Phil]

Am 30.10.23 um 17:21 schrieb mike.isely@cobaltdigital.com:
> From: Mike Isely <mike.isely@cobaltdigital.com>
>
> When the driver detects a timeout, there's no guarantee that the ISR
> would have fired.  Thus after a timeout, it's the foreground that
> becomes responsible to reset the hardware state machine.  The change
> here just duplicates what is already implemented in the ISR.
>
> Signed-off-by: Mike Isely <isely@pobox.com>
> ---
>   drivers/i2c/busses/i2c-bcm2835.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-b=
cm2835.c
> index 8ce6d3f49551..96de875394e1 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -345,42 +345,46 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, v=
oid *data)
>   static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg m=
sgs[],
>   			    int num)
>   {
>   	struct bcm2835_i2c_dev *i2c_dev =3D i2c_get_adapdata(adap);
>   	unsigned long time_left;
>   	int i;
>
>   	for (i =3D 0; i < (num - 1); i++)
>   		if (msgs[i].flags & I2C_M_RD) {
>   			dev_warn_once(i2c_dev->dev,
>   				      "only one read message supported, has to be last\n");
>   			return -EOPNOTSUPP;
>   		}
>
>   	i2c_dev->curr_msg =3D msgs;
>   	i2c_dev->num_msgs =3D num;
>   	reinit_completion(&i2c_dev->completion);
>
>   	bcm2835_i2c_start_transfer(i2c_dev);
>
>   	time_left =3D wait_for_completion_timeout(&i2c_dev->completion,
>   						adap->timeout);
>
>   	bcm2835_i2c_finish_transfer(i2c_dev);
>
>   	if (!time_left) {
> +		/* Since we can't trust the ISR to have cleaned up, do the
> +		 * full cleanup here... */
>   		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
>   				   BCM2835_I2C_C_CLEAR);
> +		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
> +				   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
>   		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
>   		return -ETIMEDOUT;
>   	}
>
>   	if (!i2c_dev->msg_err)
>   		return num;
>
>   	dev_dbg(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
>
>   	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
>   		return -EREMOTEIO;
>
>   	return -EIO;
>   }

