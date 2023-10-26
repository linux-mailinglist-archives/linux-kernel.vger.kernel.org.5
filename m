Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486187D7B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJZEin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:38:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD318A;
        Wed, 25 Oct 2023 21:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD+Iwi2fZD4tlKUX6eO3gt8s422Cti2bT1Cyjt7lxTSigp0al+R2sNTy966QlvR2optxvZdZ1EIHESwRlgU9URNOs8IpsU5HkZoeq+qAliXCpAlU649Jun9x1XcRH2m4wRITYiqKWQOZW+L8GstbcItOUQic3TbIzQV0ah5/Mp5jVNLP62by/GkM+ucbLcVF3kmN/IRgbnLREehoDb0RGi2/XLDenvl7aw7R/FofgNKYiQpa9CxG9eVzPeZshX5j7C2wDjpaojc6lrwV7e9I5kThPfwjx49Ir0ML0ws9uS9ocbjpeshNreWydvIeajSgDXHdcdIYTd6VJDq//NluUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH7pMCczovcJF0KDREgCAlRllewwKJNvAy6V3cuJmVQ=;
 b=UqzjdsdXkhLPqDjYNWV1izCgKpOJzdsfmxZYPp1CdPuU1pQ7fGKaTQrzsnIrl2ER8RTtYpf4cupUCG+ZrBpHsOcTdrK5g2mEeLKhpJbS4ZNcFMJYE9Jb5gk/Jlue7tpRh8QRx+bmbzcjXbpvsEHgd/VGI+fd97GjmEWCT3xOUHYeSNUb3RrXyLqGrvNL/xHHzqrQFGbI7SNXwLR/H/d4+WeSMHp77gsKfrFafEhIaunLKdqZQWJMG5gKAhVX9KOIEIOW3/7rrCyQdmr4Dhum2KpHr10kfDT5NeiRgSigzLSdoq5mSDYSXe3ihWJfCIerTRH4UxG09ejD3TnkvT0Izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH7pMCczovcJF0KDREgCAlRllewwKJNvAy6V3cuJmVQ=;
 b=lXFYwQGKIRxFRZUlAIarDPHLY7m7CBonBcVwNHqadKwDuVoZtPFvar+ZHbLFqHVQi47RZ7goAmw1nxn+P1PKxCML3OHwijDfaDEa84yRrkLD6SqRcUe76f66fg4JV73MOppNgz3bS3cvSYq9XVm5I1VRKQvI9whihvcT0YqbRKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH3PR08MB8971.namprd08.prod.outlook.com
 (2603:10b6:610:1c8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 04:38:32 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 04:38:31 +0000
Date:   Wed, 25 Oct 2023 23:38:24 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <ZTntQNbk0bLkjuvc@nixie71>
References: <20231017034356.1436677-1-anshulusr@gmail.com>
 <20231017034356.1436677-2-anshulusr@gmail.com>
 <ZTWza+S+t+UZKlwu@nixie71>
 <c4eed4e8-77e1-4129-ab6c-cc76ee4197db@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4eed4e8-77e1-4129-ab6c-cc76ee4197db@gmail.com>
X-ClientProxiedBy: DS7PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::7) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH3PR08MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: ef904196-9edf-4ac5-c487-08dbd5dd67c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzGo+6vBjxXa8myh+0uDtQahhnbzlFKZQpY0RqvbKS2JhBFmzlLIXCswIHaTyVYQ1ebsjsMwdtt2VtSgD6BtypnwPVB3l4xWNu9jbf5gTwnlTDg2/e7UpLTGP81P/SPz0GYcXo3PgFH4D5HhZySK2fCuS38sx45nETyXEpkYNXx0/hdDD2kMu2/GTcijXPnZt7lCNWFO7PTBIsc7m8RzokI8FQqccCVWe0iY8dATIgJpKcRufDV/aBReC0EC7h68RGiNrRhcKMfvMkVvOXefCt1iCampPVDGQ0zrETDF2/5fcPA3EcwsjqaRjaHoOgG8JOMgwEFuytoF6YiaWh7IrD69XLaTsmJavamZJWQfCUgl6Xwgwrirbwey3JNDNwVxdBa0kPMrN4ffSKu6jrf6wwC/shwn8ybit0lMD5uJsG3hbyuYW54Ogj+0WxHJosxOPZne4pZPgBKkSAEMwpLsSNnkpwwZBtsTik5LnC+pDxwctUF9AS3LVmWFLFDTe+v4ry783BHk0Dnb26wBVkTJo/aHxf98+W14szSQncilxa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(376002)(136003)(346002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(33716001)(26005)(2906002)(38100700002)(6916009)(30864003)(41300700001)(7416002)(4326008)(5660300002)(8936002)(8676002)(66556008)(6666004)(478600001)(6506007)(66476007)(86362001)(54906003)(316002)(66946007)(6512007)(66574015)(83380400001)(6486002)(9686003)(966005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?m+a31rsCTd8Csy6XZw6jpxvyUQ7jWiCY5rMgQ49IDxIxRcdK4molB2Izon?=
 =?iso-8859-1?Q?9hrqF21m6t7fms4BrnCbGS8Iu/G3p44jKOsCqIiz/QvFQAAKvkzwAVxyOm?=
 =?iso-8859-1?Q?9yTYIxtgoxdcGOUWw9ndAy/vg2DgW2RR/QgEjG2PPFPcaRHs9O/sAdRHSF?=
 =?iso-8859-1?Q?4d8GVSZ8bePeiuo9fmhX4fHNu3+RFm7sKaAy6GG0lNS32xdtbYko6Ihsj7?=
 =?iso-8859-1?Q?VXgWmL5v5NHJCD92U4WJNpzyA2ZhDWikLk3IJq7D0QjSrl+Vb9GXijH7Ju?=
 =?iso-8859-1?Q?yBOBWr+Aw5fDF7bZaDBo8rVteP6l0Kx7whglrMTbIiSQjzTKfrRg6NFt2Y?=
 =?iso-8859-1?Q?iEUkE1JJqUa2nFfMR6YDmi+ayPZxeBOElJgxYCbhf77tIY7pcugMs8TVFe?=
 =?iso-8859-1?Q?NUWDGuz5UypQ2owwOjABO31fTtMvz4AHU9fHOk2eeWIqh918kPdXkAAoGD?=
 =?iso-8859-1?Q?RVlgKdtpaASih7SKox4AQ+2pexvfe7/V37744gd076qbLR5qPRXO+9bNWK?=
 =?iso-8859-1?Q?b8APavzr5IZ2sKhtQ/m4AA3+8+C9Ff1KruxiJmgoWeqXvFAHpuXnMAgBVz?=
 =?iso-8859-1?Q?7l3M3TPBoO9kaQ1FiTIpbvKWxOP9kNamFNQVke9ZVbWeMVoXlnPOmtjCZ7?=
 =?iso-8859-1?Q?ZJStNA4EJKdbeArfFpNwXCp73Sjq5kEEhVUMRIhAND4PWAJzhLod5AaANY?=
 =?iso-8859-1?Q?pImqfyBdnMnz76FPXq3GmqrUxvG3TDE6DrJR92L7PD4kBb0CjS2eDPrs0r?=
 =?iso-8859-1?Q?MGFFQEqX1x0fHG/6mINd9jEvsyazu7gmnc9Rlw482z3FmKGq7KwABEnewC?=
 =?iso-8859-1?Q?sSLxd7GIxVc+SzeAJWicFriMlKYx4ZeWJMaqQGSzmxw7B+xJ2J/uek5xBH?=
 =?iso-8859-1?Q?QtvbMGS+6Pcnhrog1YPHiv95+3mBjQ5iANHv6+Gh+JQ1bdJvJrVGKValc9?=
 =?iso-8859-1?Q?wvl6HxZdGU8kSIEtYdoe2Vf8X4ie0e6OazywuA+PBtejGYwrD/FO0SNrYB?=
 =?iso-8859-1?Q?Sq5/PqNjmhcVI4CYgJS7gFpY7r6t3tQROq9AW7rS/wgPTRNH42gilK1R++?=
 =?iso-8859-1?Q?3/BHLlxmB7hX2/g0AmZ+rT7TsODuA85H2yVDkLvp9PD7Q8PW7YsWSEM8qU?=
 =?iso-8859-1?Q?K5XNuXi6Z/+ZqqyImN/FXS5NS/Wt2sE+ywikPjvjrIqVtc3fUaZRJk0S3N?=
 =?iso-8859-1?Q?PWFwyqQAZ/9DFrXv50pIFDBhF4wVj+0263T4Pdh4RU4K/+L6X+RibYn6vZ?=
 =?iso-8859-1?Q?SAQio1FqxNrtywOU557wW8E2xF7J99cTuWbF739nFyGTxYWCqetFAd0j7j?=
 =?iso-8859-1?Q?Fd06djIC27jIQzbbPlOIuRkHQ9F83mv9RgBZ60uudXA4lh7TdkUZfwp0WP?=
 =?iso-8859-1?Q?H3R+/MXUpNwvs4lw5NvGV463nEhx7kfZvMTfr734QjiT7vC0hxAk4xeNR+?=
 =?iso-8859-1?Q?zyNUzr2mlAl0YYyrn1J4O3vVz2pwGskFhe/Mh7F4FeqKpWBFiSaR9If2cZ?=
 =?iso-8859-1?Q?F9Cmn0AOgsU8EN1ABT9R+kW7Lk4tZpPikgjiFDR8WnN0cOK4jXWRVFMpQl?=
 =?iso-8859-1?Q?jR+N2s4EPEn3WuCRq1RtnxreA9baIpLhb1rYX1bQUCIq0eeL4EVfACBRQM?=
 =?iso-8859-1?Q?YNPRWViy0VfTzBwTJlIWd4KoNYnAIcZEnQ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef904196-9edf-4ac5-c487-08dbd5dd67c0
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 04:38:31.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaSsKrlqYEULcFBKZaJhAySewNzdU6QhHi+05xAhzxV3fvs/JNcB8ajjoWNTpSFdMDJ0ff/MlG5oIc3oBuLb9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB8971
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

On Wed, Oct 25, 2023 at 03:50:04PM +0530, Anshul Dalal wrote:
> Hello Jeff,
> Thanks for the review, I plan on addressing the changes you requested in
> the next version of the patch. Though I had a few questions:

Sounds great; thank you for the informative discussion.

> 
> On 10/23/23 05:12, Jeff LaBundy wrote:
> > Hi Anshul,
> > 
> > On Tue, Oct 17, 2023 at 09:13:45AM +0530, Anshul Dalal wrote:
> >> Adds a driver for a mini gamepad that communicates over i2c, the gamepad
> >> has bidirectional thumb stick input and six buttons.
> >>
> >> The gamepad chip utilizes the open framework from Adafruit called 'Seesaw'
> >> to transmit the ADC data for the joystick and digital pin state for the
> >> buttons. I have only implemented the functionality required to receive the
> >> thumb stick and button state.
> >>
> >> Steps in reading the gamepad state over i2c:
> >>   1. Reset the registers
> >>   2. Set the pin mode of the pins specified by the `BUTTON_MASK` to input
> >>       `BUTTON_MASK`: A bit-map for the six digital pins internally
> >>        connected to the joystick buttons.
> >>   3. Enable internal pullup resistors for the `BUTTON_MASK`
> >>   4. Bulk set the pin state HIGH for `BUTTON_MASK`
> >>   5. Poll the device for button and joystick state done by:
> >>       `seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)`
> >>
> >> Product page:
> >>   https://www.adafruit.com/product/5743
> >> Arduino driver:
> >>   https://github.com/adafruit/Adafruit_Seesaw
> >>
> >> Driver tested on RPi Zero 2W
> >>
> >> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> >> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> >> ---
> >>
> >> Changes for v5:
> >> - Added link to the datasheet
> >> - Added debug log message when `seesaw_read_data` fails
> >>
> >> Changes for v4:
> >> - Changed `1UL << BUTTON_` to BIT(BUTTON_)
> >> - Removed `hardware_id` field from `struct seesaw_gamepad`
> >> - Removed redundant checks for the number of bytes written and received by
> >>   `i2c_master_send` and `i2c_master_recv`
> >> - Used `get_unaligned_be32` to instantiate `u32 result` from `read_buf`
> >> - Changed  `result & (1UL << BUTTON_)` to
> >>   `test_bit(BUTTON_, (long *)&result)`
> >> - Changed `KBUILD_MODNAME` in id-tables to `SEESAW_DEVICE_NAME`
> >> - Fixed formatting issues
> >> - Changed button reporting:
> >>     Since the gamepad had the action buttons in a non-standard layout:
> >>          (X)
> >>       (Y)   (A)
> >>          (B)
> >>     Therefore moved to using generic directional action button event codes
> >>     instead of BTN_[ABXY].
> >>
> >> Changes for v3:
> >> - no updates
> >>
> >> Changes for v2:
> >> adafruit-seesaw.c:
> >> - Renamed file from 'adafruit_seesaw.c'
> >> - Changed device name from 'seesaw_gamepad' to 'seesaw-gamepad'
> >> - Changed count parameter for receiving joystick x on line 118:
> >>     `2` to `sizeof(write_buf)`
> >> - Fixed invalid buffer size on line 123 and 126:
> >>     `data->y` to `sizeof(data->y)`
> >> - Added comment for the `mdelay(10)` on line 169
> >> - Changed inconsistent indentation on line 271
> >> Kconfig:
> >> - Fixed indentation for the help text
> >> - Updated module name
> >> Makefile:
> >> - Updated module object file name
> >> MAINTAINERS:
> >> - Updated file name for the driver and bindings
> >>
> >>  MAINTAINERS                              |   7 +
> >>  drivers/input/joystick/Kconfig           |   9 +
> >>  drivers/input/joystick/Makefile          |   1 +
> >>  drivers/input/joystick/adafruit-seesaw.c | 273 +++++++++++++++++++++++
> >>  4 files changed, 290 insertions(+)
> >>  create mode 100644 drivers/input/joystick/adafruit-seesaw.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 6c4cce45a09d..a314f9b48e21 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -441,6 +441,13 @@ W:	http://wiki.analog.com/AD7879
> >>  W:	https://ez.analog.com/linux-software-drivers
> >>  F:	drivers/input/touchscreen/ad7879.c
> >>  
> >> +ADAFRUIT MINI I2C GAMEPAD
> >> +M:	Anshul Dalal <anshulusr@gmail.com>
> >> +L:	linux-input@vger.kernel.org
> >> +S:	Maintained
> >> +F:	Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> >> +F:	drivers/input/joystick/adafruit-seesaw.c
> >> +
> >>  ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
> >>  M:	Jiri Kosina <jikos@kernel.org>
> >>  S:	Maintained
> >> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> >> index ac6925ce8366..df9cd1830b29 100644
> >> --- a/drivers/input/joystick/Kconfig
> >> +++ b/drivers/input/joystick/Kconfig
> >> @@ -412,4 +412,13 @@ config JOYSTICK_SENSEHAT
> >>  	  To compile this driver as a module, choose M here: the
> >>  	  module will be called sensehat_joystick.
> >>  
> >> +config JOYSTICK_SEESAW
> >> +	tristate "Adafruit Mini I2C Gamepad with Seesaw"
> >> +	depends on I2C
> >> +	help
> >> +	  Say Y here if you want to use the Adafruit Mini I2C Gamepad.
> >> +
> >> +	  To compile this driver as a module, choose M here: the module will be
> >> +	  called adafruit-seesaw.
> >> +
> >>  endif
> >> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
> >> index 3937535f0098..9976f596a920 100644
> >> --- a/drivers/input/joystick/Makefile
> >> +++ b/drivers/input/joystick/Makefile
> >> @@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
> >>  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
> >>  obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
> >>  obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
> >> +obj-$(CONFIG_JOYSTICK_SEESAW)		+= adafruit-seesaw.o
> >>  obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
> >>  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
> >>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
> >> diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
> >> new file mode 100644
> >> index 000000000000..2a1eae8d2861
> >> --- /dev/null
> >> +++ b/drivers/input/joystick/adafruit-seesaw.c
> >> @@ -0,0 +1,273 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
> >> + *
> >> + * Driver for Adafruit Mini I2C Gamepad
> >> + *
> >> + * Based on the work of:
> >> + *	Oleh Kravchenko (Sparkfun Qwiic Joystick driver)
> >> + *
> >> + * Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
> >> + * Product page: https://www.adafruit.com/product/5743
> >> + * Firmware and hardware sources: https://github.com/adafruit/Adafruit_Seesaw
> >> + */
> >> +
> >> +#include <asm-generic/unaligned.h>
> >> +#include <linux/bits.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/input.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +
> >> +/* clang-format off */
> > 
> > I don't think we need this directive; at least, no other input drivers have
> > it, or really any drivers for that matter.
> > 
> >> +#define SEESAW_DEVICE_NAME	"seesaw-gamepad"
> >> +
> >> +#define SEESAW_STATUS_BASE	0
> >> +#define SEESAW_GPIO_BASE	1
> >> +#define SEESAW_ADC_BASE		9
> >> +
> >> +#define SEESAW_GPIO_DIRCLR_BULK	3
> >> +#define SEESAW_GPIO_BULK	4
> >> +#define SEESAW_GPIO_BULK_SET	5
> >> +#define SEESAW_GPIO_PULLENSET	11
> >> +
> >> +#define SEESAW_STATUS_HW_ID	1
> >> +#define SEESAW_STATUS_SWRST	127
> >> +
> >> +#define SEESAW_ADC_OFFSET	7
> >> +
> >> +#define BUTTON_A	5
> >> +#define BUTTON_B	1
> >> +#define BUTTON_X	6
> >> +#define BUTTON_Y	2
> >> +#define BUTTON_START	16
> >> +#define BUTTON_SELECT	0
> > 
> > Please namespace these (e.g. SEESAW_BUTTON_A) to make it clear they refer
> > to device-specific bits and not standard keycodes (e.g. BTN_A). In fact,
> > these seem better off as part of an array of structs; more on that below.
> > 
> >> +
> >> +#define ANALOG_X	14
> >> +#define ANALOG_Y	15
> > 
> > Please namespace these as well.
> > 
> >> +
> >> +#define SEESAW_JOYSTICK_MAX_AXIS	1023
> >> +#define SEESAW_JOYSTICK_FUZZ		2
> >> +#define SEESAW_JOYSTICK_FLAT		4
> >> +
> >> +#define SEESAW_GAMEPAD_POLL_INTERVAL	16
> >> +#define SEESAW_GAMEPAD_POLL_MIN		8
> >> +#define SEESAW_GAMEPAD_POLL_MAX		32
> >> +/* clang-format on */
> >> +
> >> +u32 BUTTON_MASK = BIT(BUTTON_A) | BIT(BUTTON_B) | BIT(BUTTON_X) |
> >> +		  BIT(BUTTON_Y) | BIT(BUTTON_START) | BIT(BUTTON_SELECT);
> >> +
> >> +struct seesaw_gamepad {
> >> +	char physical_path[32];
> >> +	struct input_dev *input_dev;
> >> +	struct i2c_client *i2c_client;
> >> +};
> >> +
> >> +struct seesaw_data {
> >> +	__be16 x;
> >> +	__be16 y;
> >> +	u8 button_a, button_b, button_x, button_y, button_start, button_select;
> > 
> > Please keep these each on a separate line.
> > 
> >> +};
> > 
> > Please declare this struct as __packed, as that is how it appears to be used.
> > 
> >> +
> >> +static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
> >> +{
> >> +	int err;
> > 
> > Please use 'ret' for return variables that can indicate a positive value on success.
> > 
> >> +	unsigned char write_buf[2] = { SEESAW_GPIO_BASE, SEESAW_GPIO_BULK };
> >> +	unsigned char read_buf[4];
> > 
> > Please use standard kernel type definitions (i.e. u8 in this case).
> > 
> >> +
> >> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
> >> +	if (err < 0)
> >> +		return err;
> > 
> > You correctly return err (or rather, ret) for negative values, but you should also
> > check that ret matches the size of the data sent. For 0 <= ret < sizeof(writebuf),
> > return -EIO.
> > 
> >> +	err = i2c_master_recv(client, read_buf, sizeof(read_buf));
> >> +	if (err < 0)
> >> +		return err;
> > 
> > And here.
> > 
> >> +
> >> +	u32 result = get_unaligned_be32(&read_buf);
> > 
> > Please do not mix declarations and code; all declarations must be at the
> > top of the function.
> > 
> >> +
> >> +	data->button_a = !test_bit(BUTTON_A, (long *)&result);
> >> +	data->button_b = !test_bit(BUTTON_B, (long *)&result);
> >> +	data->button_x = !test_bit(BUTTON_X, (long *)&result);
> >> +	data->button_y = !test_bit(BUTTON_Y, (long *)&result);
> >> +	data->button_start = !test_bit(BUTTON_START, (long *)&result);
> >> +	data->button_select = !test_bit(BUTTON_SELECT, (long *)&result);
> >> +
> >> +	write_buf[0] = SEESAW_ADC_BASE;
> >> +	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_X;
> >> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
> >> +	if (err < 0)
> >> +		return err;
> >> +	err = i2c_master_recv(client, (char *)&data->x, sizeof(data->x));
> >> +	if (err < 0)
> >> +		return err;
> > 
> > This is starting to look like a 16-bit register map. To that end, please
> > consider using regmap instead of open-coding each of these standard write-
> > then-read operations.
> > 
> > Using regmap would also save you the trouble of managing the endianness
> > yourself, as well as having to check for incomplete transfers since its
> > functions return zero or a negative error code only.
> > 
> In this driver there are only two places a 16-bit regmap could be used,
> for getting the joystick X and Y values. I see minimal utility in adding
> the boilerplate necessary to use the more sophisticated regmap API in
> this case.

I counted a total of three sequences that write two bytes (i.e. a 16-bit
"address"), send a stop condition, then read back a modulo-2 number of
bytes. If the hardware can tolerate a repeated start in between the write
and read operations, which is quite common, all of these can be replaced
with a single call to regmap_read().

A fourth sequence reads back a single byte after the 16-bit "address",
while a fifth writes a single byte after the 16-bit "address." Those two
admittedly break the model.

Given those two oddballs in seesaw_probe(), maybe regmap is not the best
solution after all. You could, however, mix the two and use regmap where
it works, and roll your own where it doesn't.

> 
> As for the handling of endianness, if I am not mistaken the
> `be16_to_cpu` macro should manage it.

Right, what I mean to say is that regmap calls be16_to_cpu() for you. You
do not need to do any extra operations on the values returned by regmap.

> 
> If you prefer I could add the following function to reduce code duplication:
> 
> int seesaw_get_analog(int pin) {
> 	__be16 result;
> 	u8 write_buf[2] = { SEESAW_ADC_BASE, SEESAW_ADC_OFFSET + pin };
> 	int ret;
> 	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> 	if (ret < 0)
> 		return ret;
> 	ret = i2c_master_recv(client, (char *)&result, sizeof(result));
> 	if (ret < 0)
> 		return ret;
> 	return result;
> }

Assuming regmap is out of the picture, I'd like to see something even more
generic like the following:

static int seesaw_register_read(struct i2c_client *client,
				u16 reg, void *val, u16 len)
{
	__be16 reg_buf = cpu_to_be16(reg);
	int ret;

	ret = i2c_master_send(client, (char *)&reg_buf, sizeof(reg_buf));
	if (ret < 0)
		return ret;

	ret = i2c_master_recv(client, (char *)&val, len);
	if (ret < 0)
		return ret;

	return 0;
}

A call to seesaw_register_read() might look like the following:

	int error;
	__be16 val;

	error = seesaw_register_read(client,
				     SEESAW_ADC_BASE + SEESAW_ADC_OFFSET + ANALOG_X,
				     &val, sizeof(val);
	if (error)
		return error;

	input_report_abs(input, ABS_X, be16_to_cpu(val));

Last but not least:

static int seesaw_register_write(struct i2c_client *client, u16 reg, u8 val)
{
	u8 buf[sizeof(reg) + sizeof(val)];
	int ret;

	put_unaligned_be16(reg, buf);
	*(buf + sizeof(reg)) = val;

        ret = i2c_master_send(client, (char *)&buf, sizeof(buf));
        if (ret < 0)
                return ret;

	return 0;
}

And to reset the device:

	error = seesaw_register_write(client,
				      SEESAW_STATUS_BASE + SEESAW_STATUS_SWRST, 0xFF);
	if (error)
		return error;

You can extend this as necessary to support the pin configuration registers
discussed below. Does this seem like a reasonable compromise?

> 
> >> +	/*
> >> +	 * ADC reads left as max and right as 0, must be reversed since kernel
> >> +	 * expects reports in opposite order.
> >> +	 */
> >> +	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(data->x);
> >> +
> >> +	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_Y;
> >> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
> >> +	if (err < 0)
> >> +		return err;
> >> +	err = i2c_master_recv(client, (char *)&data->y, sizeof(data->y));
> >> +	if (err < 0)
> >> +		return err;
> >> +	data->y = be16_to_cpu(data->y);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void seesaw_poll(struct input_dev *input)
> >> +{
> >> +	struct seesaw_gamepad *private = input_get_drvdata(input);
> >> +	struct seesaw_data data;
> >> +	int err;
> >> +
> >> +	err = seesaw_read_data(private->i2c_client, &data);
> >> +	if (err != 0) {
> >> +		dev_dbg(&input->dev, "failed to read joystick state: %d\n",
> >> +			err);
> > 
> > This should be dev_err_ratelimited().
> > 
> >> +		return;
> >> +	}
> >> +
> >> +	input_report_abs(input, ABS_X, data.x);
> >> +	input_report_abs(input, ABS_Y, data.y);
> >> +	input_report_key(input, BTN_EAST, data.button_a);
> >> +	input_report_key(input, BTN_SOUTH, data.button_b);
> >> +	input_report_key(input, BTN_NORTH, data.button_x);
> >> +	input_report_key(input, BTN_WEST, data.button_y);
> >> +	input_report_key(input, BTN_START, data.button_start);
> >> +	input_report_key(input, BTN_SELECT, data.button_select);
> > 
> > I think you can make this much cleaner and smaller by defining an array
> > of structs, each with a key code and bit position. You can then simply
> > iterate over the array and call input_report_key() once per element as
> > in the following:
> > 
> > struct seesaw_btn_desc {
> > 	unsigned int code;
> > 	unsigned int shift;
> > };
> > 
> > static const struct seesaw_btn_desc seesaw_btns[] = {
> > 	{
> > 		.code = BTN_EAST,
> > 		.mask = 5,
> > 	},
> > 	[...]
> > };
> > 
> > And then:
> > 
> > 	btn_status = ...;
> > 
> > 	for (i = 0; i < ARRAY_SIZE(seesaw_btns); i++)
> > 		input_report_key(input, seesaw_btns[i].code,
> > 				 btn_status & seesaw_btns[i].mask);
> > 
> > This would also make it easier to quickly discern what keycodes are mapped
> > to which bits in the register.
> > 
> >> +	input_sync(input);
> >> +}
> >> +
> >> +static int seesaw_probe(struct i2c_client *client)
> >> +{
> >> +	int err;
> >> +	struct seesaw_gamepad *private;
> > 
> > I'd rather this be called something like 'seesaw' rather than private.
> > 
> >> +	unsigned char register_reset[] = { SEESAW_STATUS_BASE,
> >> +					   SEESAW_STATUS_SWRST, 0xFF };
> >> +	unsigned char get_hw_id[] = { SEESAW_STATUS_BASE, SEESAW_STATUS_HW_ID };
> >> +
> >> +	err = i2c_master_send(client, register_reset, sizeof(register_reset));
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	/* Wait for the registers to reset before proceeding */
> >> +	mdelay(10);
> >> +
> >> +	private = devm_kzalloc(&client->dev, sizeof(*private), GFP_KERNEL);
> >> +	if (!private)
> >> +		return -ENOMEM;
> >> +
> >> +	err = i2c_master_send(client, get_hw_id, sizeof(get_hw_id));
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	unsigned char hardware_id;
> > 
> > Same comment as earlier with regard to mixed declarations.
> > 
> >> +
> >> +	err = i2c_master_recv(client, &hardware_id, 1);
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
> >> +		hardware_id);
> >> +
> >> +	private->i2c_client = client;
> >> +	scnprintf(private->physical_path, sizeof(private->physical_path),
> >> +		  "i2c/%s", dev_name(&client->dev));
> > 
> > This seems overly complex; can we not simply set input_dev->phys to the
> > literal "i2c/seesaw-gamepad"? Why to copy at runtime and incur the cost
> > of carrying 'physical_path' throughout the life of the module?
> > 
> >> +	i2c_set_clientdata(client, private);
> >> +
> >> +	private->input_dev = devm_input_allocate_device(&client->dev);
> >> +	if (!private->input_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	private->input_dev->id.bustype = BUS_I2C;
> >> +	private->input_dev->name = "Adafruit Seesaw Gamepad";
> >> +	private->input_dev->phys = private->physical_path;
> >> +	input_set_drvdata(private->input_dev, private);
> >> +	input_set_abs_params(private->input_dev, ABS_X, 0,
> >> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
> >> +			     SEESAW_JOYSTICK_FLAT);
> >> +	input_set_abs_params(private->input_dev, ABS_Y, 0,
> >> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
> >> +			     SEESAW_JOYSTICK_FLAT);
> >> +	input_set_capability(private->input_dev, EV_KEY, BTN_EAST);
> >> +	input_set_capability(private->input_dev, EV_KEY, BTN_SOUTH);
> >> +	input_set_capability(private->input_dev, EV_KEY, BTN_NORTH);
> >> +	input_set_capability(private->input_dev, EV_KEY, BTN_WEST);
> >> +	input_set_capability(private->input_dev, EV_KEY, BTN_START);
> >> +	input_set_capability(private->input_dev, EV_KEY, BTN_SELECT);
> > 
> > Same comment with regard to creating an array of structs, and hence only
> > having to call input_set_capability() from within a small loop.
> > 
> >> +
> >> +	err = input_setup_polling(private->input_dev, seesaw_poll);
> >> +	if (err) {
> >> +		dev_err(&client->dev, "failed to set up polling: %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	input_set_poll_interval(private->input_dev,
> >> +				SEESAW_GAMEPAD_POLL_INTERVAL);
> >> +	input_set_max_poll_interval(private->input_dev,
> >> +				    SEESAW_GAMEPAD_POLL_MAX);
> >> +	input_set_min_poll_interval(private->input_dev,
> >> +				    SEESAW_GAMEPAD_POLL_MIN);
> >> +
> >> +	err = input_register_device(private->input_dev);
> >> +	if (err) {
> >> +		dev_err(&client->dev, "failed to register joystick: %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	/* Set Pin Mode to input and enable pull-up resistors */
> >> +	unsigned char pin_mode[] = { SEESAW_GPIO_BASE,	SEESAW_GPIO_DIRCLR_BULK,
> >> +				     BUTTON_MASK >> 24, BUTTON_MASK >> 16,
> >> +				     BUTTON_MASK >> 8,	BUTTON_MASK };
> >> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
> >> +	if (err < 0)
> >> +		return err;
> >> +	pin_mode[1] = SEESAW_GPIO_PULLENSET;
> >> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
> >> +	if (err < 0)
> >> +		return err;
> >> +	pin_mode[1] = SEESAW_GPIO_BULK_SET;
> >> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
> >> +	if (err < 0)
> >> +		return err;
> > 
> > Please configure the HW before the input device is live and being polled.
> > 
> 
> Could you elaborate on what you meant by this. To my knowledge, the
> device is ready to be polled right after the pin state for the
> `BUTTON_MASK` is configured. That is also how it's done in the Arduino
> driver provided by the manufacturer. Please clarify if I'm missing
> something here.

Normally, we want to do the following:

1. Configure the hardware.
2. Register the input device.
3. Request an interrupt line or enable polling.

Here, we have placed step (1) at the end of the sequence, which is dangerous
for two reasons:

1. For a brief moment, the device is availing button status to the input core
   while the pull-up resistors are not yet enabled, and the buttons are in an
   undefined state. Any kind of electrical noise or disturbance may trigger a
   false button event.

2. The input poller is reading registers and changing the device's internal
   address pointer at the same time probe() is still writing some registers.
   This is a concurrency problem.

If what is shown is how the Arduino reference design operates, then I would
argue the reference design is mistaken, or not subject to the same constraints
and behaviors as a Linux input driver. Therefore, please set the pin mode much
earlier in probe().

> 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +#ifdef CONFIG_OF
> >> +static const struct of_device_id of_seesaw_match[] = {
> >> +	{
> >> +		.compatible = "adafruit,seesaw-gamepad",
> >> +	},
> >> +	{ /* Sentinel */ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, of_seesaw_match);
> >> +#endif /* CONFIG_OF */
> > 
> > Please correct me if I am wrong, but it does not seem that OF support is
> > required by this driver. There are no properties beyond the standard ones
> > understood by the I2C core, which can match based on the ID table below.
> > 
> >> +
> >> +/* clang-format off */
> >> +static const struct i2c_device_id seesaw_id_table[] = {
> >> +	{ SEESAW_DEVICE_NAME, 0 },
> >> +	{ /* Sentinel */ }
> >> +};
> >> +/* clang-format on */
> > 
> > Again, I don't see any need for these directives.
> > 
> >> +
> > 
> > Nit: unnecessary NL.
> > 
> >> +MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
> >> +
> >> +static struct i2c_driver seesaw_driver = {
> >> +	.driver = {
> >> +		.name = SEESAW_DEVICE_NAME,
> >> +		.of_match_table = of_match_ptr(of_seesaw_match),
> >> +	},
> >> +	.id_table = seesaw_id_table,
> >> +	.probe = seesaw_probe,
> >> +};
> >> +module_i2c_driver(seesaw_driver);
> >> +
> >> +MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
> >> +MODULE_DESCRIPTION("Adafruit Mini I2C Gamepad driver");
> >> +MODULE_LICENSE("GPL");
> >> -- 
> >> 2.42.0
> >>
> > 
> > Kind regards,
> > Jeff LaBundy
> 
> Regards,
> Anshul Dalal

Kind regards,
Jeff LaBundy
