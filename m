Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955A17AF864
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjI0DB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjI0C7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:59:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73D12511;
        Tue, 26 Sep 2023 18:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crTHSbee2QyG0LAFxN6TXNbbCYZoT2nAMsYQF8pZ1AW7w1wJDidBaUGhGm4b/g3GTu3UQgAqyFH9qabKaw63xqH8yet9KiARrfA0p7W9faGj/qTSQLp0b7YFRHqYa9mkYzkfdWZSoowIk0mateKoF7V6D+hl6exZa3bg8F7Iyi48bkHVvM+I/RJ5W1i0R7fp8hw5le2sqxvgc/IqYme9m1/MOBMqs7TvM8tCJrvzeQaoDVAHth1klM5Z2CO0soJLSkg8SaJ/SLdwwhY105rR5+kaFyxa+jRhWM+xK5hzKsXR2eKqLi0GAvaTQmkAnWlNatCsCTfkj28kR3fJeJ1LqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyJZwY3ewVTTG2FtX1swWkhWSdTfSqDtMC70tD6Bu2Q=;
 b=i6Io3eanh8mO1rdHtvpi/aT84twU0C3B2AGUV+vSZ9OZr1qzXdjwVl+75wCjcrEzcKHgeON+In3P0c0XJFsdWxoy2YdmHzLJozNxqpNabe+qGVsABVxje2l9aqZcDJqWSU50geTfbKeAfIAodW93pv+o9JY0ZFLdscDO24bdFw43Sl4ciGStlr25+X2sQ1/zD5WJre9BHvWRj7EAR0J1r819cX0BK+vvsl4mV/i7cwUZKvznx+hYWKWIavuP07zQ6uqRsQ+dDHWstMXjzafeetomY93EyLyQqLywgczFrFEbSlfFimf/C9T2QNYzOd0XsLI9BaG/G/K7h4z1EU+HWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyJZwY3ewVTTG2FtX1swWkhWSdTfSqDtMC70tD6Bu2Q=;
 b=Wuf8fUVsWYUFPI37n7QoV/5zy1Z0tRpGqmORwho5vs6HM2NwlUvDyar4awh4a3PZN4g6FHBy8/pji0C6QxgXCo7v/zR+szXmqKO+r0qdULGJZr4VFgP/GYrT4/LzQuqej9C9E6nzvXZhvFBmP254mXa3iEMbByP4QUqCLPNDcqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ2PR08MB8401.namprd08.prod.outlook.com
 (2603:10b6:a03:4f7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 01:41:00 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 01:41:00 +0000
Date:   Tue, 26 Sep 2023 20:40:57 -0500
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
Subject: Re: [PATCH 2/2] input: Imagis: add support for the IST3032C
 touchscreen
Message-ID: <ZROIKSVCiTI3VB2B@nixie71>
References: <20230926173531.18715-1-balejk@matfyz.cz>
 <20230926173531.18715-3-balejk@matfyz.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926173531.18715-3-balejk@matfyz.cz>
X-ClientProxiedBy: SN7PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:806:122::7) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ2PR08MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 2363f223-f30e-48cd-0055-08dbbefacd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9PCJQGka/1R669+xJv/P90iAm2BIZVZG27ZzhoSm3q3GLLK6NBC/ppuzmozHLt/phXb32cE7c53QTOon6fVa8R1+frSMYZeIdxI/fvscfNt+JkNNao5UGLIjk0V5P6mHRofbb7b6V1Zu/K1kAEr1fsMM5Esay3ocHVKb69NI9hixDw5ikRqHtEgxxTNP8wFDPnW+Jzbq5Yu0scbxwtShrdJLDHLmxKzsTf7ZJzaWrRKFw/N9hRixxiDHiXqVxt7kSWX3v60EMSviKBUu+OMuWGLD5s+FKyTmqowkJT78ZFoJrskVwUkx1pwx5I5KSwHHZx+LLJnQRKLdzCqNUVEBD3ltyDcOBDxAU31YtxHvj5q68i5V3XErmg2cYpL3FghD+XbwHdhX1TUwC7B1RDB/nmPk7JTEOAnl6k6ZoHvFFuYxUQVghOux66f9v5fnLlzSa3X+5aWVT7HB7jr4XkvFWONdSHNh2vyIECiT92m5WXVoP3tvnI3aplatChf+nFGddnSQwdphu3XyH6tTUzxLorzJ1Ld6D3YPPTHI/djyEPE+tFFt87w6EzbN6XuzxMK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(366004)(39830400003)(346002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(38100700002)(33716001)(9686003)(5660300002)(2906002)(6666004)(478600001)(7416002)(6506007)(6486002)(26005)(66476007)(66946007)(54906003)(6916009)(316002)(8936002)(8676002)(4326008)(41300700001)(6512007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3A5Vm1yS1BDRHpNd0FPTy84RnkrRk5MUVhWbU9maVpJUkdXaXRSN2RHYWNv?=
 =?utf-8?B?cjZscHRHYkhuNXBDa3VxUUxFTkpmQkxHU3dwUWJxU3F2VU9raFRwb1lkSTM2?=
 =?utf-8?B?RHpQSDYzNnJMSnFHeUFmTkNYdkhCOC9tTkwxL1A0SlNtZnpWdlYzQU1Vc0hw?=
 =?utf-8?B?VG0yTjN0SzVhY1JDZEZGR3JoZFVab2RNN29kbzZoZHhsRlhRRjdwU2ZXSzV0?=
 =?utf-8?B?MUo4cjIvak9zeGlVSWJBMnlvMlZ4WnZyVDZMZlJLYldydU1IMFVZZGpRMzVn?=
 =?utf-8?B?M0hMOFVuMWdoT2oxcUM5Nk9YQ09GeWRMYjJONXRJY2lrN0JBVno0d1VFc0oy?=
 =?utf-8?B?OGFEUzE1aWE1T3h5TzBkUjkwQjdXYTRQWmpRelJVN0t4ekhCbUJDeXgrNlBE?=
 =?utf-8?B?dkZ0eS84TGlJeDVXZEpKbkhyRFRhbXltQmQza2JFYUVwUnB4NjdtVWtrL1Vy?=
 =?utf-8?B?R2RBRmlPbG51U3hsSHRDcitBMk5VVjQwYy95OG1idWdhVFRFN21rbzVpSTBh?=
 =?utf-8?B?YXlDZm5HNWlvckRtWThncUVtNDF1am92elEwRWhsOHhCRWI5eFhJREs5LzRu?=
 =?utf-8?B?R2hBdXZQK2doMlVFZWJFSytDaVZXT1o1S0d5MncxTUZiOVU0aXBhVDFycmRZ?=
 =?utf-8?B?c05xYlhsbGg0U1BEbTF0cWJQR3JCOU5ZeVUzUndWR21welZSZm1EcHZaTWtY?=
 =?utf-8?B?SmNCRzFicVRZUVBiN3RIQkhmN2kvYXdUQkl5SlRrRk9nNER3TnJkL0FBUkhB?=
 =?utf-8?B?TXVTWEZhUGJuUXFBeVRWMS9LMkxabmEvOUovRWxhcmcvOHpRV3BNeDRGYk40?=
 =?utf-8?B?cFV0K1N1WEhaS0VESVJmbXZvcjJySnFHM1R1N1U4ZUp6c2gyRGd0RFQwa2Nu?=
 =?utf-8?B?ZFFSM1d4Wlp5R0pWZlh0aE1CbVpTbi9BclNDbzU3Y1g1eW5ONU9kcGJORmdt?=
 =?utf-8?B?RXY3K1F3VXNMdkdoRE94dGJHdGZGZ01qT0RxTjY5bmwyZWxYZjhzZzRYZGpN?=
 =?utf-8?B?S3lFM2o0Nm5zeW9PNkc5YmNXQTdDVzRHOFRmRHBoZGgreUJYOTViZllTRWNt?=
 =?utf-8?B?Q1ZlQnhNWHpKcjJFQkFvZEtSWHRINk9xRGRKeURBcmM0aFhEbXBHcnlHS3pI?=
 =?utf-8?B?d2VwcThBRWlPVkV3b1N4bXp6UkJNQXNCTmRrenVWLzZhbXBhWThPZHBVRzFU?=
 =?utf-8?B?dkhOdzZJVktYRURlUlFwSE9aN21LL0x0Z1d4N1kvSzhFMHNMZUM3TlErdXdJ?=
 =?utf-8?B?NnJSQVE5TnI5VHdFQ3pTTTBLY0I2dGJRTk54KytMNHNweThwZVdTcHRPTWw4?=
 =?utf-8?B?dzQ5NVFKRGJDaTNmZHFuUFhob2hkTFBXN1hyVUJlSUdTZlNGVDlmTk80NzJY?=
 =?utf-8?B?aStMR1BvWDdOQmpaNjZyS1R6YzRFQ1RMRkhJazdwd0RvOVJDRDJDY3F4Unl3?=
 =?utf-8?B?L2R6ZS96Sjg4b25ha1orRWZhajRQVEJZTlhPckd5NDQ0dlNoT0s4T2krejNZ?=
 =?utf-8?B?Q3UyNy9FVFQ0OXk0RnNlSy9UUTEyZ3dlU1lYalNrVnNCNlpFRGtLRmQ3L3lE?=
 =?utf-8?B?czcvaDBYTmw1em5OTTV5UXcvN1UvVnNSdjVPLzF0RlR1WHp6cmJQckREVk9r?=
 =?utf-8?B?bVA1Um9HdzZNSEJMZ3JrUE11ekY1WTJXdkZpVXU3M2ZpZklhdEVVQXhrTHRz?=
 =?utf-8?B?elVFZVBjaE9ULzNDNHlCMWVQd3M4RGlvWVJXUkhxU3NLNGduNGhiNmVzd1VV?=
 =?utf-8?B?OG42U0JHcUFJamhNMkZOZVQ5RkZvU3pGcjc5UkI4NW9KSkoxampKbkVyemxP?=
 =?utf-8?B?SkhRUDVPQXV6T0RsemhWMFVGbmVjYWhCbEwvbHZPNGhIM0Juanp3NjM2eHVx?=
 =?utf-8?B?T3pMcmRvMkxvZEF3T1prWUQrZWQ1Z1htblVTWDhac3Y3cUtWUm8vdThlRWRj?=
 =?utf-8?B?ejdGMThpcU9sTU5vaTl4dk5qN3RWUkYxSEl5NlhyRzZ6dkI0aHlUWHB0M3Z3?=
 =?utf-8?B?V0l6NmZRZndua2YyZTFJbytyVGtEeDA2UnVKa2wzWk4wOU5NUEZHaWRkdjNY?=
 =?utf-8?B?WjU4SERvYnVPc0xLWlN0SEUwd1hZUzJ3KzY4SklXb1pteXNwQUduWEVvdi9C?=
 =?utf-8?Q?0a30wi2394IsgcGLbZsbLvjfl?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2363f223-f30e-48cd-0055-08dbbefacd84
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 01:41:00.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSrzYiViCFwpRI+p5R/m/Zz8DYBM8LAti85R7iudbCwPNq9Xsmu6625hzrMYKomSKFP7UxXHyeM0UY6664ayhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR08MB8401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On Tue, Sep 26, 2023 at 07:35:24PM +0200, Karel Balej wrote:
> The downstream driver sets the regulator voltage to 3.1 V. Without this,
> the touchscreen generates random touches even after it is no longer
> being touched. It is unknown whether the same problem appears with other
> chips of the IST30**C series.
> 
> Co-developed-by: Duje Mihanović <duje.mihanovic@skole.hr>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../bindings/input/touchscreen/imagis,ist30xxc.yaml |  1 +
>  drivers/input/touchscreen/imagis.c                  | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> index 09bf3a6acc5e..d6f75bbfaec3 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> @@ -18,6 +18,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - imagis,ist3032c
>        - imagis,ist3038c
>  
>    reg:
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> index 4456f1b4d527..df9a8fbf2c5f 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -30,6 +30,7 @@
>  #define IST30XXC_FINGER_COUNT_SHIFT	12
>  #define IST30XXC_FINGER_STATUS_MASK	GENMASK(9, 0)
>  
> +#define IST3032C_WHOAMI			0x32c
>  #define IST3038C_WHOAMI			0x38c
>  
>  struct imagis_ts {
> @@ -295,6 +296,16 @@ static int imagis_probe(struct i2c_client *i2c)
>  		return -EINVAL;
>  	}
>  
> +	if (chip_id == IST3032C_WHOAMI) {
> +		/*
> +		 * if the regulator voltage is not set like this, the touchscreen
> +		 * generates random touches without user interaction
> +		 */
> +		error = regulator_set_voltage(ts->supplies[0].consumer, 3100000, 3100000);
> +		if (error)
> +			dev_warn(dev, "failed to set regulator voltage\n");
> +	}
> +

Opinions may vary, but mine is that this kind of hard-coded board-level policy
does not belong in the driver. Surely the supply need not be equal to exactly
3.1 V and this is merely an upper or lower limit? Assuming so, what if the board
designer opts to share this supply with another consumer that requires a specific
voltage not equal to 3.1 V, but still within the safe range of IST3032C?

To me, this restriction belongs in dts, specifically within the regulator child
node referenced by the client which bears the new 'ist3032c' compatible string.
Maybe a better solution is to simply note this presumed silicon erratum in the
description of the vdd supply in the binding which, as Conor states, must not be
clubbed with driver patches.

>  	error = devm_request_threaded_irq(dev, i2c->irq,
>  					  NULL, imagis_interrupt,
>  					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> @@ -348,6 +359,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id imagis_of_match[] = {
> +	{ .compatible = "imagis,ist3032c", .data = (void *)IST3032C_WHOAMI, },
>  	{ .compatible = "imagis,ist3038c", .data = (void *)IST3038C_WHOAMI, },
>  	{ },
>  };
> @@ -355,6 +367,7 @@ MODULE_DEVICE_TABLE(of, imagis_of_match);
>  #endif
>  
>  static const struct i2c_device_id imagis_ts_i2c_id[] = {
> +	{ "ist3032c", IST3032C_WHOAMI, },
>  	{ "ist3038c", IST3038C_WHOAMI, },
>  	{ },
>  };
> -- 
> 2.42.0
> 

Kind regards,
Jeff LaBundy
