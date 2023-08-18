Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37378055B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbjHRFGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357992AbjHRFGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:06:25 -0400
Received: from mx11.pro-ite.de (ox4u.de [212.118.221.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06393AA7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:06:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx11.pro-ite.de (Postfix) with ESMTP id 60A9E19651DCA;
        Fri, 18 Aug 2023 07:06:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at ox4u.de
Received: from mx11.pro-ite.de ([127.0.0.1])
        by localhost (ox4u.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1HQC3jv-EYES; Fri, 18 Aug 2023 07:06:13 +0200 (CEST)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx11.pro-ite.de (Postfix) with ESMTPSA id E64A919651DB5;
        Fri, 18 Aug 2023 07:06:12 +0200 (CEST)
Date:   Fri, 18 Aug 2023 07:06:03 +0200 (CEST)
From:   Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To:     Lee Jones <lee@kernel.org>
cc:     werneazc@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH 1/2] mfd: (tps65086): Read DEVICE ID register 1 from
 device
In-Reply-To: <20230817170223.GI986605@google.com>
Message-ID: <c4df3803-854a-8c88-f174-18eb98fed195@systec-electronic.com>
References: <20230809101429.7885-1-andre.werner@systec-electronic.com> <20230817170223.GI986605@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463788022-898169523-1692335174=:20242"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463788022-898169523-1692335174=:20242
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Aug 2023, Lee Jones wrote:

> On Wed, 09 Aug 2023, werneazc@gmail.com wrote:
>
>> From: Andre Werner <andre.werner@systec-electronic.com>
>>
>> This commit prepares a following commit for the regulator part of the =
MFD.
>> The driver should support different device chips that differ in their
>> register definitions, for instance to control LDOA1 and SWB2.
>> So it is necessary to use a dedicated regulator description for a
>> specific device variant. Thus, the content from DEVICEID Register 1 is
>> used to choose a dedicated configuration between the different device
>> variants.
>>
>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
>> ---
>>  drivers/mfd/tps65086.c       | 37 ++++++++++++++++++++++++++++++-----=
-
>>  include/linux/mfd/tps65086.h | 27 ++++++++++++++++++++------
>>  2 files changed, 52 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
>> index 6a21000aad4a..38f8572c265e 100644
>> --- a/drivers/mfd/tps65086.c
>> +++ b/drivers/mfd/tps65086.c
>> @@ -64,7 +64,7 @@ MODULE_DEVICE_TABLE(of, tps65086_of_match_table);
>>  static int tps65086_probe(struct i2c_client *client)
>>  {
>>  	struct tps65086 *tps;
>> -	unsigned int version;
>> +	unsigned int version, id;
>>  	int ret;
>>
>>  	tps =3D devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
>> @@ -81,16 +81,41 @@ static int tps65086_probe(struct i2c_client *clien=
t)
>>  		return PTR_ERR(tps->regmap);
>>  	}
>>
>> -	ret =3D regmap_read(tps->regmap, TPS65086_DEVICEID, &version);
>> +	ret =3D regmap_read(tps->regmap, TPS65086_DEVICEID1, &id);
>>  	if (ret) {
>> -		dev_err(tps->dev, "Failed to read revision register\n");
>> +		dev_err(tps->dev, "Failed to read revision register 1\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Store device ID to load regulator configuration that fit to IC va=
riant */
>> +	switch (id) {
>> +	case TPS6508640_ID:
>> +		tps->chip_id =3D TPS6508640;
>
> Why not use the meaningful TPS6508640_ID for the chip_id instead of an
> arbitrary enum?

In the regulator part for this MFD I use this enum ID to select the
right configuration from an array. So the intention is using the enum as
the index for this table. I can move this selection into the regulator
part and store the meaningful TPS65086 IDs in the MFD data if you
prefer?

>
>> +		break;
>> +	case TPS65086401_ID:
>> +		tps->chip_id =3D TPS65086401;
>> +		break;
>> +	case TPS6508641_ID:
>> +		tps->chip_id =3D TPS6508641;
>> +		break;
>> +	case TPS65086470_ID:
>> +		tps->chip_id =3D TPS65086470;
>> +		break;
>> +	default:
>> +		dev_err(tps->dev, "Unknown device ID. Cannot determine regulator co=
nfig.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret =3D regmap_read(tps->regmap, TPS65086_DEVICEID2, &version);
>> +	if (ret) {
>> +		dev_err(tps->dev, "Failed to read revision register 2\n");
>>  		return ret;
>>  	}
>>
>>  	dev_info(tps->dev, "Device: TPS65086%01lX, OTP: %c, Rev: %ld\n",
>> -		 (version & TPS65086_DEVICEID_PART_MASK),
>> -		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
>> -		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
>> +		 (version & TPS65086_DEVICEID2_PART_MASK),
>> +		 (char)((version & TPS65086_DEVICEID2_OTP_MASK) >> 4) + 'A',
>> +		 (version & TPS65086_DEVICEID2_REV_MASK) >> 6);
>>
>>  	if (tps->irq > 0) {
>>  		ret =3D regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
>> diff --git a/include/linux/mfd/tps65086.h b/include/linux/mfd/tps65086=
.h
>> index 16f87cccc003..88df344b38df 100644
>> --- a/include/linux/mfd/tps65086.h
>> +++ b/include/linux/mfd/tps65086.h
>> @@ -13,8 +13,9 @@
>>  #include <linux/regmap.h>
>>
>>  /* List of registers for TPS65086 */
>> -#define TPS65086_DEVICEID		0x01
>> -#define TPS65086_IRQ			0x02
>> +#define TPS65086_DEVICEID1		0x00
>> +#define TPS65086_DEVICEID2		0x01
>> +#define TPS65086_IRQ		0x02
>>  #define TPS65086_IRQ_MASK		0x03
>>  #define TPS65086_PMICSTAT		0x04
>>  #define TPS65086_SHUTDNSRC		0x05
>> @@ -75,16 +76,29 @@
>>  #define TPS65086_IRQ_SHUTDN_MASK	BIT(3)
>>  #define TPS65086_IRQ_FAULT_MASK		BIT(7)
>>
>> -/* DEVICEID Register field definitions */
>> -#define TPS65086_DEVICEID_PART_MASK	GENMASK(3, 0)
>> -#define TPS65086_DEVICEID_OTP_MASK	GENMASK(5, 4)
>> -#define TPS65086_DEVICEID_REV_MASK	GENMASK(7, 6)
>> +/* DEVICEID1 Register field definitions */
>> +#define TPS6508640_ID			0x00
>> +#define TPS65086401_ID			0x01
>> +#define TPS6508641_ID			0x10
>> +#define TPS65086470_ID			0x70
>> +
>> +/* DEVICEID2 Register field definitions */
>> +#define TPS65086_DEVICEID2_PART_MASK	GENMASK(3, 0)
>> +#define TPS65086_DEVICEID2_OTP_MASK	GENMASK(5, 4)
>> +#define TPS65086_DEVICEID2_REV_MASK	GENMASK(7, 6)
>>
>>  /* VID Masks */
>>  #define BUCK_VID_MASK			GENMASK(7, 1)
>>  #define VDOA1_VID_MASK			GENMASK(4, 1)
>>  #define VDOA23_VID_MASK			GENMASK(3, 0)
>>
>> +enum tps65086_ids {
>> +	TPS6508640,
>> +	TPS65086401,
>> +	TPS6508641,
>> +	TPS65086470,
>> +};
>> +
>>  /* Define the TPS65086 IRQ numbers */
>>  enum tps65086_irqs {
>>  	TPS65086_IRQ_DIETEMP,
>> @@ -100,6 +114,7 @@ enum tps65086_irqs {
>>  struct tps65086 {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> +	unsigned int chip_id;
>>
>>  	/* IRQ Data */
>>  	int irq;
>> --
>> 2.41.0
>>
>
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>

Regards,

Andr=C3=A9
---1463788022-898169523-1692335174=:20242--
