Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6507AF8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjI0Dg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjI0D2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:28:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7219EE4;
        Tue, 26 Sep 2023 18:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtximyCZm/tZaH61fE+IEx9C/yAA2GkX7uiN28dIVeQHY+sufxPzHD3gTsjnX1Ps7CrDEchVufPW8sQWx9SkTosXvt6c60jHsYjnP/qP7RumFgu0E6PMLRkhsjZqJWcqEhrOHUwAnVchShNAK8h6kPt3mjxs7iCnAfrnCE03ar+nPiT9/pTYG+wvSWJsbeoHrlEo58z+STgNVO/BcYnlUPya+EsvEHiTwSuYqIdrEmNC8IioivtM7CMmLiGQlhaG4hgLHR29IuwbaTXvlqPBbGQyOmkqSzl9TxgqhGmG0B1zPnnT+yA5IYCHIhfZp0/QD2UB7bT96eA14g82cwCxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHLDD+VlKAF0S2/dF6yMN4KB6dwY0STAlqexKO5RmqM=;
 b=Ft7/EkuOWQaEBlkGb1n4z5IzE4zgmj0RwieZG/dZ4c6G1HIOZD3G++wQxE73s3/E7mw9s52OPeYGa51jUUnVvzBxIVSWBs493wrOGa54QCmQm4Wr5gvObSR6tIP8hdGaguuY+t1CfwQr1gmaTmr9GSFbWj0opbRHNBxlB2X1FFJ36DPRV9QZwA754IjUMweu68QW1nlxZpXAByEHPXk2mUE/dWmDLOD5UOqGXCUbo6jGYpIii9DYpTH+9BPZfsmuRV2TKnjEsuAKquMss0dX8XrAJFiae1z71e1ta8ygl17DwhVQCrQRSshNAdA7XMd1RgT6F+29T6fGYIVLTNJc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHLDD+VlKAF0S2/dF6yMN4KB6dwY0STAlqexKO5RmqM=;
 b=dYVEutwrNBbhrrjEk993RL2+Qdv8hsszc8nYwEx3okbH7AE3uzivBpbyX3+4BQtEQGouV77G9DJA+gopP4LFAWSv8xQPDNp1i770ljK8ZPS21+FM9auRiPCWxyn1LHApckuCu6eSX67//dLRsOqS8R6k26fbMwq26RsfmJzP+So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SN4PR0801MB7998.namprd08.prod.outlook.com
 (2603:10b6:806:219::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 27 Sep
 2023 01:48:48 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 01:48:48 +0000
Date:   Tue, 26 Sep 2023 20:48:44 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Karel Balej <balejk@matfyz.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] input: generalize the Imagis touchscreen driver
Message-ID: <ZROJ/G0hXV/bNIYX@nixie71>
References: <20230926173531.18715-1-balejk@matfyz.cz>
 <20230926173531.18715-2-balejk@matfyz.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926173531.18715-2-balejk@matfyz.cz>
X-ClientProxiedBy: DM6PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:5:120::40) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SN4PR0801MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 388ae0ff-d004-4459-e958-08dbbefbe486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxV6WvX3uU5ah7k1C2bCmTamUzmteeypGfd1/N1qY7+NebKXuTcmccC0Hvi5TiNubriRWTgSni1GWensWAbs2QyCrphuFTMxBt4LhX3QNWWLtD6+Id9wREtT1KbwLrr23Gd/xcAYSKv0mwpIEl3N7VNI0cMfke3rA/3LYrTFGLo5WFFjh825AI6A24Vtv4nOnJQhZnOuwTsaZ701m6iThsZKoL950OZXetq+GNzGZPi6JiUQaCQ9eHHPloqblP1eP/yGMCo0xfdSXLCBZ/oOSmL/GuKEFrh0z/7zjp8tlJthDLpNTAxEqqL8ZRwYozmuEzQXyomlTlO8ko3t/bWwFjqa9cwF5HDGaAifR9G6OOB7XJtaIJCiX1QmMkSOzbU9ooY+nZhu9XQekQTkcVeW4HKvlWD5ATJv+XAQoH7RV9HEhMkP4mLX780ocFTa1XUazhIM7n357XTPjeEvVh9asoyPgv36cGdv2gl+yJ8LQ9uyn1oF2Dn/8QCBzlh+thxzutlDzthWp+Fx6GsHPVE8ahnjaBSILSRnxO9Psg2ogI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39830400003)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(966005)(478600001)(9686003)(86362001)(33716001)(41300700001)(8676002)(7416002)(6916009)(38100700002)(26005)(83380400001)(5660300002)(6512007)(6506007)(2906002)(4326008)(66476007)(66946007)(6486002)(66556008)(6666004)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVBMy9EZ0ZXbzBSZE9uTDlQUDRmNEhTTFRSYUs5Sm9sOStsaFQyMmhiQnNR?=
 =?utf-8?B?NWZTQlVJeGVrS2hWUG83dXJZTmd3OE02YnBCeGtpaFpWenNPb3FDbTJRSG5D?=
 =?utf-8?B?N1ZLZlN3NHQ1eWJ4L012ajcyWjVtM0MyQzFQUytJYmpQSjFVL0NUV3diTmd1?=
 =?utf-8?B?R0I0T2FnK3dXNFpKQVU1NXphSm1EMW5FamsyeHY5SWxrSDB5cTRiOXVEMjN3?=
 =?utf-8?B?aWhjTWZTa05SaUxDb3hCRVJ3WVFzRUZjalhocG1RS2ZuVFRUMk5ySVRuWVYz?=
 =?utf-8?B?aktISFVMRlc2eXBNQVdZcGtTUXV1T25RUDVJbmVMUnVPMDNHZm0zNE41V1J6?=
 =?utf-8?B?Z0NsTkJwM3F1NXhyUU04Nm01MW1mQlJEdU5yWU9UWTVJUksrdEpPdExGa2NR?=
 =?utf-8?B?SG9DY2tpSzBNUUNabm1DNmV5dkFMeU9vaHZrc3kwaUxpMWFTYVZXYm5VMnc0?=
 =?utf-8?B?cXNYSEdSbHQvajI1L3ozSU1taDBGcHBmVlNMU21BRDBhVGdCY2hCYUFkeWVx?=
 =?utf-8?B?VUFBeCtWWEdzZnIxRzFoVXZqWWxCOWgzWHkzZ0JLeUUvekVISCtSR211c1Bu?=
 =?utf-8?B?Zjkyc2VTY0lWUHRwWnI0NFlvYzZGd3VaVTdtQWpRc2JqeFBHTFlseVg2VlJG?=
 =?utf-8?B?WHlXd09wMFBKTmlDT3h6bEVvVGgwVFBqdWxIZnNTd2xXZFMwSWJUdlRJMFcw?=
 =?utf-8?B?c0w0WE5WZVkwWll6VW1ER2hJeXhpK1BOcEFxTStGeEdPZUJyVVNGaEZqQ3Za?=
 =?utf-8?B?SjlEMi83bUt4RzgvZFBWNlBvek1TMjVLS0FYZTIxellnYlMwU2J3NS8yeW9T?=
 =?utf-8?B?a3ZwUmNoVGIwM05kaU1JY3NDbWkrVldtM3VzTjlKb2gySGZ4WkJpd2RIYmdM?=
 =?utf-8?B?QVZnWUdrSmhGRDZEeWMxZXgxZGFyTjZFUnBPQ0JWV3RTRXREc1E2MHZTVG1s?=
 =?utf-8?B?YndxUERvYndOV3JPODlqczFFOS9ReUdYTlhXcE5IU2JHVnk2c2ZiV003TElN?=
 =?utf-8?B?aTNhMXp6dXNvNjFTZDRpeEg3bEoreGZiWFdRQWhVU0loMmVmN04rS3U4V2FE?=
 =?utf-8?B?Ty9UUTUzOG1lZ1lFSzNVVEFFR0dBTW1ORDRiM24xcEdtS0NMTHRKWis0NW95?=
 =?utf-8?B?MkJHaC8zSExwQUV5NXVFaU5RK2VSeHYrUHk1SFVLOEx0QUxKN1FCYkxYNzk1?=
 =?utf-8?B?eGJ0RzFkWWo0MG9RODlQUW14cG1vMEw5ZnpLTjVhSlA0VUxQTVlOY2tyaDA1?=
 =?utf-8?B?L0tBRm9oWmt1eVRxSXozbVFGN0tWRVpVY1JyREJWSmJmVThqSDZSL1J1YmN3?=
 =?utf-8?B?cGxNNjUzRVU5bm05Q05tS2t6ZGIrTUx5cko2Um14M1BoSE9TdUVEeVJpT05s?=
 =?utf-8?B?SzBNTGhVZnpZczlYdjFHV3VwMXJaSVl1azZsWmV2RXdHdXc0ZG9aRStMbVQr?=
 =?utf-8?B?MzgxaEJDNUV2RG0zRGxNMHBFbTNNeHdZdFlzRGl4MFNkVUN1VTNnTnVJd2tj?=
 =?utf-8?B?WllnUkRkSjY5T2hzbTlnZVo2K0xEM0htT2ZCaVdTbTJ5RmJBeHhLSUJ4cW1i?=
 =?utf-8?B?MmQvcjhPK01ENVM5NVA0WXFsenJRek1GSm56VXp2U1lSOUJnbVZ1Nyt1M01v?=
 =?utf-8?B?NElzdGZERUZZTGJMTDVxekhXYUpWQWZXM3VVelFtL2lwNWxlZmZTd05qV2hK?=
 =?utf-8?B?aTlTR0FrWlNkaWtpWkczWUhINm1tSWJ2dyszQ1h4c3VjQnpobVEyQ0xZc2xZ?=
 =?utf-8?B?UnZMeTBNNTVHb0RGOCsrOHFPNkFISnlXZlJYRm5aS2tTK3FsWjdPSHlBbFFn?=
 =?utf-8?B?Z095YzhCWmI5VTRtQkEzM1RPclp4NjFCYURRR1FFVWNCM3FxNk14RVJZdWFR?=
 =?utf-8?B?L2JaT3d3UkNnaDh2QXJWSVh0SEFhMnZGS0JUWjRXT2NOS21xcmUyWGZCRXdr?=
 =?utf-8?B?Q0UxRnZCMHNTSUVUZkxockVpTGhBNENQeUZtTXprajdMcWVsRzBsb3JYV3c0?=
 =?utf-8?B?SEhaanB2NG5Dc2gzRXpOeGd5Y1JVNEJlQURYelF6eUhUU0pUTDBNbWRCTTZr?=
 =?utf-8?B?UXFYMUk5bnc2RDM1OHF2RVh1S0lXSDY0cjdONVNPejZUdExFVTdxTGg5c21X?=
 =?utf-8?Q?v6omsIdodFex1j0JQm8Txg90z?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388ae0ff-d004-4459-e958-08dbbefbe486
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 01:48:48.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDzcNemV4vKS6DoxlvgJhfnXtRWCfZ8P8e8nmxKvtSzWbK8kbUlxCwKV9OoFZ0iXp3BuSA9AT8Io6SHMh+owhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On Tue, Sep 26, 2023 at 07:35:23PM +0200, Karel Balej wrote:
> This driver should work with other Imagis ICs of the IST30**C series.
> Make that more apparent.
> 
> Co-developed-by: Duje Mihanović <duje.mihanovic@skole.hr>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  ...gis,ist3038c.yaml => imagis,ist30xxc.yaml} |  2 +-
>  MAINTAINERS                                   |  2 +-
>  drivers/input/touchscreen/Kconfig             |  4 +-
>  drivers/input/touchscreen/imagis.c            | 86 +++++++++++--------
>  4 files changed, 52 insertions(+), 42 deletions(-)
>  rename Documentation/devicetree/bindings/input/touchscreen/{imagis,ist3038c.yaml => imagis,ist30xxc.yaml} (99%)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> similarity index 99%
> rename from Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> rename to Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> index 0d6b033fd5fb..09bf3a6acc5e 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
> +$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist30xxc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Imagis IST30XXC family touchscreen controller
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..b23e76418d94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10209,7 +10209,7 @@ F:	drivers/usb/atm/ueagle-atm.c
>  IMAGIS TOUCHSCREEN DRIVER
>  M:	Markuss Broks <markuss.broks@gmail.com>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
>  F:	drivers/input/touchscreen/imagis.c
>  
>  IMGTEC ASCII LCD DRIVER
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e3e2324547b9..45503aa2653e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -665,10 +665,10 @@ config TOUCHSCREEN_NOVATEK_NVT_TS
>  	  module will be called novatek-nvt-ts.
>  
>  config TOUCHSCREEN_IMAGIS
> -	tristate "Imagis touchscreen support"
> +	tristate "Imagis IST30XXC touchscreen support"
>  	depends on I2C
>  	help
> -	  Say Y here if you have an Imagis IST30xxC touchscreen.
> +	  Say Y here if you have an Imagis IST30XXC touchscreen.
>  	  If unsure, say N.
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> index 07111ca24455..4456f1b4d527 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -11,25 +11,26 @@
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  
> -#define IST3038C_HIB_ACCESS		(0x800B << 16)
> -#define IST3038C_DIRECT_ACCESS		BIT(31)
> -#define IST3038C_REG_CHIPID		0x40001000
> -#define IST3038C_REG_HIB_BASE		0x30000100
> -#define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
> -#define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
> -#define IST3038C_REG_INTR_MESSAGE	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x4)
> +#define IST30XXC_HIB_ACCESS		(0x800B << 16)
> +#define IST30XXC_DIRECT_ACCESS		BIT(31)
> +#define IST30XXC_REG_CHIPID		0x40001000
> +#define IST30XXC_REG_HIB_BASE		0x30000100
> +#define IST30XXC_REG_TOUCH_STATUS	(IST30XXC_REG_HIB_BASE | IST30XXC_HIB_ACCESS)
> +#define IST30XXC_REG_TOUCH_COORD	(IST30XXC_REG_HIB_BASE | IST30XXC_HIB_ACCESS | 0x8)
> +#define IST30XXC_REG_INTR_MESSAGE	(IST30XXC_REG_HIB_BASE | IST30XXC_HIB_ACCESS | 0x4)
> +#define IST30XXC_CHIP_ON_DELAY_MS	60
> +#define IST30XXC_I2C_RETRY_COUNT	3
> +#define IST30XXC_MAX_FINGER_NUM		10
> +#define IST30XXC_X_MASK			GENMASK(23, 12)
> +#define IST30XXC_X_SHIFT		12
> +#define IST30XXC_Y_MASK			GENMASK(11, 0)
> +#define IST30XXC_AREA_MASK		GENMASK(27, 24)
> +#define IST30XXC_AREA_SHIFT		24
> +#define IST30XXC_FINGER_COUNT_MASK	GENMASK(15, 12)
> +#define IST30XXC_FINGER_COUNT_SHIFT	12
> +#define IST30XXC_FINGER_STATUS_MASK	GENMASK(9, 0)
> +
>  #define IST3038C_WHOAMI			0x38c
> -#define IST3038C_CHIP_ON_DELAY_MS	60
> -#define IST3038C_I2C_RETRY_COUNT	3
> -#define IST3038C_MAX_FINGER_NUM		10
> -#define IST3038C_X_MASK			GENMASK(23, 12)
> -#define IST3038C_X_SHIFT		12
> -#define IST3038C_Y_MASK			GENMASK(11, 0)
> -#define IST3038C_AREA_MASK		GENMASK(27, 24)
> -#define IST3038C_AREA_SHIFT		24
> -#define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
> -#define IST3038C_FINGER_COUNT_SHIFT	12
> -#define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
>  

There is no need to change all of the namespacing from IST3038C to IST30XXC;
this is purely cosmetic and adds noise to the actual patch.

It is perfectly acceptable for the driver to call itself IST3038C throughout
while remaining compatible with other devices (e.g. IST3032C), in fact this
flexibility is the intent of the compatible string in the first place.

[...]
>  
> -MODULE_DESCRIPTION("Imagis IST3038C Touchscreen Driver");
> +MODULE_DESCRIPTION("Imagis IST30XXC Touchscreen Driver");
>  MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
>  MODULE_LICENSE("GPL");
> -- 
> 2.42.0
> 

Kind regards,
Jeff LaBundy
