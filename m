Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3F805DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbjLESBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345718AbjLESBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:01:49 -0500
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B9D5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:01:53 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id AZjvrRTwOSNyBAZjvr0n3q; Tue, 05 Dec 2023 19:01:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701799311;
        bh=hvbZ1hzkZAW9+ll+Cf0H0hMrUli14aQS6HIa8H1AiEs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XoptdEkIyaphDGvNlkuK50h82d3TT88V3o4uepBihG58+UUJ9+WkFgg+i5GXukzuB
         m6di0bERiVC9fyjAJbBYKflD1Uaoq9Q+yirlHlHFexeL4ircFJQC6pU7RWM1qE0bIh
         bH1OZNcd/vrsuS+ieYI9rU0yqSbcePcmLZOUCAaoKh54B/ctCPvySPch5rf9U4IoMQ
         ICZKlktLrX8zVPrOiGqDiIQSvNrgiQZCMPpwAZj59Rp3W/h4uYIyOFc4zQhyIvR0EC
         AorPDR1vYKF9CbT1fjB07NijCvh11KyQRUjPpU9k5Zrh9m2BW5vpimmezFYsfizEvY
         U+SAmVVoRm3AQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 05 Dec 2023 19:01:51 +0100
X-ME-IP: 92.140.202.140
Message-ID: <e6752370-7aba-4b47-90ff-7896a49ba84b@wanadoo.fr>
Date:   Tue, 5 Dec 2023 19:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <6eeead27-e1b1-48e4-8a3b-857e1c33496b@wanadoo.fr>
 <20231204231655.19baa1a4@kmaincent-XPS-13-7390>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231204231655.19baa1a4@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/12/2023 à 23:16, Köry Maincent a écrit :
> Thanks for your review!
> 
> On Sun, 3 Dec 2023 22:11:46 +0100
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>>> +
>>> +	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
>>> +				       &pd692x0_fw_ops, priv);
>>> +	if (IS_ERR(fwl)) {
>>> +		dev_err(dev, "Failed to register to the Firmware Upload
>>> API\n");
>>> +		ret = PTR_ERR(fwl);
>>> +		return ret;
>>
>> Nit: return dev_err_probe()?
> 
> No EPROBE_DEFER error can be catch from firmware_upload_register() function, so
> it's not needed.

Hi,

up to you to take it or not, but dev_err_probe() also logs the error 
code in a human readable way and it saves a few lines of code.

If I remember correctly, it also saves some bytes in the .o file.

Other than that, it is a matter of style.

CJ

> 
> Regards,

