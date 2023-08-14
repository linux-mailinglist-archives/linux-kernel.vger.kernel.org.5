Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31D77B43C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjHNIeT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHNIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:34:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B74BF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:34:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-148-mMDgg5w-NhK19ckygkrlbg-1; Mon, 14 Aug 2023 09:34:03 +0100
X-MC-Unique: mMDgg5w-NhK19ckygkrlbg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 09:33:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 09:33:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andi Shyti <andi.shyti@kernel.org>
Subject: RE: [PATCH 04/15] hwmon: (ina2xx) fix Wvoid-pointer-to-enum-cast
 warning
Thread-Topic: [PATCH 04/15] hwmon: (ina2xx) fix Wvoid-pointer-to-enum-cast
 warning
Thread-Index: AQHZy22PDAQ6/HNzf0aAlEc1QR4MGa/pfLdA
Date:   Mon, 14 Aug 2023 08:33:31 +0000
Message-ID: <e13c70334dce4bfa9e5ea11126d4eb86@AcuMS.aculab.com>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
 <20230810093157.94244-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810093157.94244-4-krzysztof.kozlowski@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski
> Sent: 10 August 2023 10:32
> 
> 'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   ina2xx.c:627:10: error: cast to smaller integer type 'enum ina2xx_ids' from 'const void *' [-
> Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/hwmon/ina2xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index a47973e2d606..d8415d1f21fc 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -624,7 +624,7 @@ static int ina2xx_probe(struct i2c_client *client)
>  enum ina2xx_ids chip;
> 
>  if (client->dev.of_node)
> -chip = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
> +chip = (uintptr_t)of_device_get_match_data(&client->dev);

The kernel type would be 'long' not uintptr_t.
But this all looks like something horrid is being done.

(And you've clearly lost all the tabs)

	David

>  else
>  chip = i2c_match_id(ina2xx_id, client)->driver_data;
> 
> --
> 2.34.1
> 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

