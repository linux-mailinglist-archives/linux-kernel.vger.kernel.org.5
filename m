Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6467F912B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 04:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjKZDsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 22:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZDse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 22:48:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A09DD;
        Sat, 25 Nov 2023 19:48:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My1Vian5xcjlAAtP9aX5avvMU5jBVF3E96MkEzAcDMstXCWl9IQuF5X8CJ2lq9cTcuZ87DLf2UgTLzHwv2ryyzP38/T+1ERlRJHGEdUQMTFw6dtwVqovb3DZ5v3Vm4u8fD2FxeIioDxdeG6HjYtD0MRDISrOzcsnJQB8CIPD9spcLJhydnSd3BBJFXaUFDBK9AbCKfmty3kVSn/U/joN5rJdjIYtPlJgdi62TNnQq+9/bQtCnZPrqUJB/EraEXwB9C0Xvt0v9ysalVOtFXsyq9mPKCNAuW/ydjknPskWZocKLxNGY1jjmk0HuCS6dJR7pfCQEt+I2i1iNlux/y2QEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDgosMiWx5YERBBDgxA2WalVFkwwAsktVR+V9SBX7fE=;
 b=LAr1cGZgtHSODyvWeFcOKpP/3C2eMiwIE8liAqHGWiycgdcJB+QxDjOskwlzOre8TzXZDmRqkSjxhMGYGIX7E2ij80JtlSB5UUIvwv+GIYcTIpSI40ivBFX/zdWJbIdByK1ONczdyZC2td2IUAhoqdoM4ozMsGuncFUnIc7aCXbHSIwdkKm4yDK2xycrfN0lQ+lfjG8T/K4WbhgKpuv8mxAqg5ZxiIB1OhwDELeTwj65FnN0reOpKZ2fDhp7wf6N9mqSY4lFCTuVnIeAOW3ehmdDrKzulK7eE0JqcR/gqwRtrClePMfODdrosmhdBSRibWzqTftfg8E4o/CfznRKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDgosMiWx5YERBBDgxA2WalVFkwwAsktVR+V9SBX7fE=;
 b=bLQ4Zi8FMeuMg/0me6qZVpD+OM0hwqBUu7KWkPXS3EVAR4H0XC+RHV6pO099gk1Qn+TqrktZY7gLhqPesS6R2VMWRvHphSdgmkHkcBSvWhyuCe40s7v8TCu8mES/4yyllgUXdkYX+iebWdBDIi/QQmQXTCFRRX4u6Q9le0PNHnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB7781.namprd08.prod.outlook.com
 (2603:10b6:a03:3d9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26; Sun, 26 Nov
 2023 03:48:34 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 03:48:34 +0000
Date:   Sat, 25 Nov 2023 21:48:24 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     kamel.bouhara@bootlin.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v3 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <ZWLACNZrDzcHHA7D@nixie71>
References: <d760ad5e60b21816a395713f004ca14c@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d760ad5e60b21816a395713f004ca14c@bootlin.com>
X-ClientProxiedBy: DM6PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:5:334::21) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3632b7-e724-4cfb-99ee-08dbee329064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lz61YRQR0JnCV7OE8wBNRSYWuckgLb4hsGP/lSrpC8FPDZ8oyt9m8j9VgqYhvcaj7lSYZXjFhrhv2frfHpZlW3XGlhfoymzk0nHvyyk6uqSvwSw8eU87JSs2ou69zKW89WcEc5rVs+lwsgVnw4K2ausEtW72C6TYPfj+RPK8Vf2fF6JxnDvxmZqP/No+wd24KLpejiEgADzTxlcgfKonC50N5iq6Y3p7k5mokLMxhjeoXZ6ZZVN6cruhaJHoGr4J2Qc/LhBtNzY/5Vrrxei05nuN2sJwJA9eh75yDx4Yr3Y0e0ODmE6tfHm601uTAEnOOchwSWpqBfCo433R/4oZ+pq9qnpb8JfUrQSx6auZl5QlXMXmH8lCQXhWVz2vdaIXp6qWb/anBZQmiWk0ueTxiePLnzOe4BvD30/+8EFVNx1u7GnYiI37RIWjjwdt+ESrxQztXsKa5RVoAsRjWx5UOCR9iloWXmdXYSeT4jhEEPBqYEtBwjmahOR0GE1tRgPR347QDvq8bOq5y37Az6Rw+8BnfIBwnzVejxPzgsB5bYWkGISu94wvEuXAa+hTW1Iv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(366004)(136003)(39830400003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6666004)(66574015)(26005)(6512007)(9686003)(6506007)(83380400001)(7416002)(478600001)(5660300002)(2906002)(33716001)(4001150100001)(41300700001)(6486002)(4326008)(8676002)(8936002)(54906003)(66476007)(66556008)(66946007)(6916009)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vGx6+ysj7dmeyl4qdhCkCiRLgC3CVuJVstOgOdbcAI6OLUSRaWdBpMWpbV?=
 =?iso-8859-1?Q?oas5oXXzHj/8YACJdUvR9t74mHlMTaS5iy9eS+0MeosK5UshXuapdGpp1h?=
 =?iso-8859-1?Q?228yXEjauHh6m+r27J362MXQQ5ZTSPt059xd/qmQqQJQxvjf2Igicr8N17?=
 =?iso-8859-1?Q?QMC7g38rfHOyelNtNCUkQDE07f4O69wnjOK/xZgDeMfJVif1Q7EPeIXdO+?=
 =?iso-8859-1?Q?2I2bd7Pm9m7dIgKwQaeieUu13kJTxpp81+oj3HgokurOxo1TyLNosQX/s1?=
 =?iso-8859-1?Q?aWtlplReRLk/smRak0ypxIHIk99NR1MV/T261qhpSkeI2gFCusNj2wCdml?=
 =?iso-8859-1?Q?vsUjBrE50pXKYpXa5lHa8EYlUl47HdOepUvPsx3PVbq+aEdVlKUHA8QvJ7?=
 =?iso-8859-1?Q?3dCDuaKXsPYWQO/3VdFM4iz2EdE/El92N71Earo7I4gPmhy00IAasheV58?=
 =?iso-8859-1?Q?1TGQS910nugbsnUa5t59SJV6dbzxuXKcmvnapEdiqq2TuY1P+2LukTKT8k?=
 =?iso-8859-1?Q?NnyXTJzf2YEKUUjasEB4bdXQ55O6w1+kG//fWHCz1srLhr/zuH9dUpvoQU?=
 =?iso-8859-1?Q?HqQwu6Rn/7FHXv4WPAbrj4VRwHp41deIPZyU6zyC+7kzcjsYPREQaaS9du?=
 =?iso-8859-1?Q?yjq7EzS8dsxfbt0q3XThSiO415GldU7SoAdZVa7rH5s0ceT5iLH6H8vgvV?=
 =?iso-8859-1?Q?jQ8irG4l+Ja9T8p01POGp9BYP/wjv9oyit/P9xmSRfKwKBnVaxDD1aCujo?=
 =?iso-8859-1?Q?y8Kftyz7N8lorBmAqgdL4TQNtltTniorCQ12uWO+In4+DpizooADPaqYHV?=
 =?iso-8859-1?Q?Jtm8gHheRVMi4UVit1nTsW1QoVVlUlJDtGAdJG+avnxV9KVr2gxjcepixR?=
 =?iso-8859-1?Q?2wmZ+n8MEspfdvF0Zii/zhVvVDnXCybWgkqFo1kL4ndQioldGAycLajHr4?=
 =?iso-8859-1?Q?qJVMsJEG49S/RrPjr9mAJwbTZ9a+rpVABImONe251zTfUcqwoKUK68xFpZ?=
 =?iso-8859-1?Q?haqQ4CRKww/twxNnWv0yt0UK0Xw8avofiTWtVZeSFgv6fyVDy4r8cHr711?=
 =?iso-8859-1?Q?GYDTbqGkc6Ke/+4g0Qq9BHuTOHcgLSOepeQKApbqq6Ie6OHyvefJYWFrIT?=
 =?iso-8859-1?Q?vMaP9jM7xdbaSYTbYDCBDBO7HN+7D7NMG9Ln+eisQKKj9yksP7NRWctJWv?=
 =?iso-8859-1?Q?lvCwhHIcv4ApMqrRHlJgI8MYd27LOsI4VvNd/guzz34RPPQkKUMgVQgR0f?=
 =?iso-8859-1?Q?+NcfcBpX9BtAIdX0s4hKDAuQ1V5p1qTZ2fPDY6caeQuUUo6FCNcaBQV7G1?=
 =?iso-8859-1?Q?qkM7C/TXxwjklb4Qbicvcdir0xNU4sJwYvI57wqYuU/lP42Nq0ICI5dY+p?=
 =?iso-8859-1?Q?j+wQTZo5+Yu/XBT/UTuqJobud2yEYogZXSLKsyhgqinLcpO98M8LaupiJF?=
 =?iso-8859-1?Q?AbTbwdQkFK61QSswOFPTcvo3Z23v+we4I9+2ez9oucOEJVUZYadOrqUspi?=
 =?iso-8859-1?Q?GF+oyTJ0+G3M4V7GLj1dh6lD9igCQOKaXqSodMMap09Hv2PgYAE1bXYK0v?=
 =?iso-8859-1?Q?PnLHnxTyuOjDWdX23uhSJTeyF6IQl9PjbRLrmC/1Hv8lP/+3+jvC0erg5i?=
 =?iso-8859-1?Q?NKricSkk6cDZzNDli2jma1qQYv1IepJbYu?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3632b7-e724-4cfb-99ee-08dbee329064
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 03:48:34.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTCuR217BwCWfq4r09xUP1Ffdw2+Evs1R9OdnlO0cCl8za/rHzivmtEUS12wOZ1e6d9wxnrwRWVFCIKKkGgGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7781
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamel,

On Mon, Nov 13, 2023 at 02:32:12PM +0100, kamel.bouhara@bootlin.com wrote:
> Le 2023-10-22 23:54, Jeff LaBundy a écrit :
> > Hi Kamel,
> 
> Hi Jeff,
> 
> > 
> > On Thu, Oct 12, 2023 at 09:40:34AM +0200, Kamel Bouhara wrote:
> > > Add a new driver for the TouchNetix's axiom family of
> > > touchscreen controllers. This driver only supports i2c
> > > and can be later adapted for SPI and USB support.
> > > 
> > > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > ---
> > >  MAINTAINERS                                   |   1 +
> > >  drivers/input/touchscreen/Kconfig             |  13 +
> > >  drivers/input/touchscreen/Makefile            |   1 +
> > >  .../input/touchscreen/touchnetix_axiom_i2c.c  | 740
> > > ++++++++++++++++++
> > >  4 files changed, 755 insertions(+)
> > >  create mode 100644 drivers/input/touchscreen/touchnetix_axiom_i2c.c
> > 
> > Please do not include 'i2c' in the filename. If the driver is expanded
> > in
> > the future to support SPI, it would make sense to have
> > touchnetix_axiom.c,
> > touchnetix_axiom_i2c.c and touchnetix_axiom_spi.c. To prevent this
> > driver
> > from having to be renamed in that case, just call it touchnetix_axiom.c.
> > 
> 
> Sure but the generic part of the code could also be moved to
> touchnetix_axiom.c.

Right; I'm simply saying to do this now as opposed to having a giant patch
later when SPI support comes along. In case I have misunderstood your reply,
please let me know.

[...]

> > > +#include <linux/crc16.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/input.h>
> > > +#include <linux/input/mt.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > 
> > Please #include mod_devicetable.h as well.
> > 
> 
> OK is this only for the sake of clarity ? As mod_devicetable.h is already
> included in linux/of.h ?

I haphazardly wrote this comment while in the process of reviewing
dbce1a7d5dce ("Input: Explicitly include correct DT includes"); however
you are correct. That being said, do you really need the entire of.h
for this driver?

> 
> > > +#include <linux/of.h>
> > > +#include <linux/pm.h>

[...]

> > > +static int
> > > +axiom_i2c_read(struct i2c_client *client, u8 usage, u8 page, u8
> > > *buf, u16 len)
> > > +{
> > > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > > +	struct axiom_cmd_header cmd_header;
> > > +	struct i2c_msg msg[2];
> > > +	int ret;
> > > +
> > > +	cmd_header.target_address =
> > > cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> > > +	cmd_header.length = cpu_to_le16(len);
> > > +	cmd_header.read = 1;
> > > +
> > > +	msg[0].addr = client->addr;
> > > +	msg[0].flags = 0;
> > > +	msg[0].len = sizeof(cmd_header);
> > > +	msg[0].buf = (u8 *)&cmd_header;
> > > +
> > > +	msg[1].addr = client->addr;
> > > +	msg[1].flags = I2C_M_RD;
> > > +	msg[1].len = len;
> > > +	msg[1].buf = (char *)buf;
> > 
> > Again, please use u8 in place of char, as was done for the first
> > element.
> 
> OK.
> 
> > 
> > > +
> > > +	ret = i2c_transfer(client->adapter, msg, 2);
> > 
> > Please use ARRAY_SIZE(msg) above as you do below.
> > 
> > > +	if (ret != ARRAY_SIZE(msg)) {
> > > +		dev_err(&client->dev,
> > > +			"Failed reading usage %#x page %#x, error=%d\n",
> > > +			usage, page, ret);
> > > +		return -EIO;
> > > +	}
> > 
> > This check papers over negative error codes that may have been returned
> > by
> > i2c_transfer(). For ret < 0 you should return ret, and only return -EIO
> > for
> > 0 <= ret < ARRAY_SIZE(msg).
> > 
> > More importantly, however, if this device supports multiple transports
> > and
> > you expect SPI support can be added in the future, you really should use
> > regmap throughout in order to avoid ripping up this driver later.
> > 
> 
> I have a doubt on wether or not regmap can be used for SPI as there is some
> specific padding required for SPI.

You can still define your own read and write callbacks in the small SPI
driver, leaving generic regmap calls in the core driver.

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int
> > > +axiom_i2c_write(struct i2c_client *client, u8 usage, u8 page, u8
> > > *buf, u16 len)
> > > +{
> > > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > > +	struct axiom_cmd_header cmd_header;
> > > +	struct i2c_msg msg[2];
> > > +	int ret;
> > > +
> > > +	cmd_header.target_address =
> > > cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> > > +	cmd_header.length = cpu_to_le16(len);
> > > +	cmd_header.read = 0;
> > > +
> > > +	msg[0].addr = client->addr;
> > > +	msg[0].flags = 0;
> > > +	msg[0].len = sizeof(cmd_header);
> > > +	msg[0].buf = (u8 *)&cmd_header;
> > > +
> > > +	msg[1].addr = client->addr;
> > > +	msg[1].flags = 0;
> > > +	msg[1].len = len;
> > > +	msg[1].buf = (char *)buf;
> > > +
> > > +	ret = i2c_transfer(client->adapter, msg, 2);
> > > +	if (ret < 0) {
> > > +		dev_err(&client->dev,
> > > +			"Failed to write usage %#x page %#x, error=%d\n", usage,
> > > +			page, ret);
> > > +		return ret;
> > > +	}
> > 
> > The error handling between your read and write wrappers is inconsistent;
> > please see my comment above.
> > 
> > Is there any reason i2c_master_send() cannot work here? I'm guessing the
> > controller needs a repeated start in between the two messages?
> > 
> 
> Yes reads requires repeated starts between each messages.
> 
> For writes I could still use i2c_master_send() but what makes it more
> relevant here ?

The code can be a bit smaller in terms of lines with the header and payload
copied into a small buffer and written with i2c_master_send(), but this is
fine too.

[...]

> 
> > For these kind of special requirements, it's helpful to add some
> > comments
> > as to why the HW calls for additional housekeeping.
> > 
> 
> OK.
> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Decodes and populates the local Usage Table.
> > > + * Given a buffer of data read from page 1 onwards of u31 from an
> > > aXiom
> > > + * device.
> > > + */
> > 
> > What is a usage table? These comments aren't helpful unless some of the
> > underlying concepts are defined as well.
> 
> It's a set of registers regrouped in categories (data, configuration, device
> and report).
> 
> I'll try to clarify it.

ACK, thanks.

[...]

> > > +/* Rebaseline the touchscreen, effectively zero-ing it */
> > 
> > What does it mean to rebaseline the touchscreen? I'm guessing it means
> > to null out or normalize pressure? Please consider a less colloquialized
> > function name.
> > 
> > Out of curiousity, what happens if the user's hand happens to be on the
> > touch surface at the time you call axiom_rebaseline()? Does the device
> > recover on its own?
> 
> This indeed force the controller to measure a new capacitance by zeoring it,
> I don't really know if it's harmful, yet the documentation says rebaseline
> is
> for tuning or debug purpose.
> 
> I believe this is done for testing the communication.

ACK, thanks.

> 
> > 
> > > +static int axiom_rebaseline(struct axiom_data *ts)
> > > +{
> > > +	char buffer[8] = {};
> > 
> > Are you expecting each element to be initialized to zero?
> 
> Yes.

ACK, I merely had not seen this method before.

> 
> > 
> > > +
> > > +	buffer[0] = AXIOM_REBASELINE_CMD;
> > > +
> > > +	return axiom_i2c_write(ts->client, AXIOM_REPORT_USAGE_ID, 0,
> > > buffer, sizeof(buffer));
> > > +}
> > > +
> > > +static int axiom_i2c_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct input_dev *input_dev;
> > > +	struct axiom_data *ts;
> > > +	int ret;
> > > +	int target;
> > > +
> > > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > > +	if (!ts)
> > > +		return -ENOMEM;
> > > +
> > > +	ts->client = client;
> > > +	i2c_set_clientdata(client, ts);
> > > +	ts->dev = dev;
> > > +
> > > +	ts->irq_gpio = devm_gpiod_get_optional(dev, "irq", GPIOD_IN);
> > > +	if (IS_ERR(ts->irq_gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(ts->irq_gpio), "failed to get
> > > irq GPIO");
> > > +
> > > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > > GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(ts->reset_gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get
> > > reset GPIO\n");
> > > +
> > > +	axiom_reset(ts->reset_gpio);
> > 
> > We shouldn't call axiom_reset() if reset_gpio is NULL. Even though the
> > calls to gpiod_set_value_cansleep() will bail safely, there is no reason
> > to make the CPU sleep for 100 ms if the device was not actually reset.
> > 
> > > +
> > > +	if (ts->irq_gpio) {
> > > +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> > > +						axiom_irq, 0, dev_name(dev), ts);
> > 
> > Did you mean to set IRQF_ONESHOT?
> 
> No

OK, why not? This is a threaded handler and it's obviously not meant to be
reentrant. Why is this implementation different than any other driver with
a threaded handler? In case I have misunderstood, please let me know.

Kind regards,
Jeff LaBundy
