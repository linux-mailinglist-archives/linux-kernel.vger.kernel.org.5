Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43417AF81E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjI0Caq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjI0C12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:27:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3233D72BC;
        Tue, 26 Sep 2023 18:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ7f0t8zCzaxBbgPc55Z0PU1fpRslWcsRMczDioIwQi1ovTIay3ja7c0Akwuzy58C3XU1dlilV7S8yR0vmB5iHZ+eWPNo8YJ1wyw28cn867j3qBnQTyNedCcB39yghGw7eHtg0T0ie7rdQsBHwcewEqdsMAMUcXdg9a0+rloLfl0BggI5gFumNL/8H4yXv3FaDNwaH3t1p86459hy9aRI/gA41dfWJfOlmuJMa+mDS81y9MxtAOrWKwxGqMEuBsirFHmAuBihKzsn+h3TvPEG2/FO//IT+UiHo7UjupxyiTH+gwpX3kNGEF03RmfqPOTEtaPsw1sZgPdbKD0PHtkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRa94U36y+BpIjEErem9Q6pJbOEC4mTAbnYtPjctVuQ=;
 b=Q2cQtSGj1WfM4rUjuMOAEznAWtjDidf2ikf95vDgJztjrMJDfOMvzPjln6iN1MCfj9NFwsAHJB8A17R9o/8aW7gZt3g+hjDy1zZACJ2EojQm4z7mh3Y+RJWeWPUFIcywvMxVbgiGwNt832rTRtbp/qVeW9K8tA2oKZmhCvBNvZKMZxu+Pgx8Y6TjDjVzfhgejjkOTuySQOI64H8cE8ov5mNdGBfyZvr5Tm9vfkKwxwI7SXFBjY1kGRp7EtMwd7yEAr0c/r1v4cnMjYoxosFR6xsbAqov0whjnwiBM8WV/6vKQ8CekzynFYu0IgIUr2HeloB0hkzKoXYE3O4spOTvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRa94U36y+BpIjEErem9Q6pJbOEC4mTAbnYtPjctVuQ=;
 b=GWBgHwDz9PK7Lg2YjpA30rO3nlz6XKdYEL9KKadT4Y3ESDpcKZpdzwGA2v8r2EFL1KrgyMdiVNn6oo1chkCVP8yJzHIRnsBBI27mltjsZl7SO0IA6e+7Trsyr90HkKQyaWMDKzQEm9lQ/HbKYDVd+4PyuN1gv5HstRN/p1Z1AZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SN4PR0801MB7998.namprd08.prod.outlook.com
 (2603:10b6:806:219::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 27 Sep
 2023 01:56:20 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 01:56:20 +0000
Date:   Tue, 26 Sep 2023 20:56:17 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: goodix: clarify
 irq-gpios misleading text
Message-ID: <ZROLwcgP3vg9j/pO@nixie71>
References: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
X-ClientProxiedBy: SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::8) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SN4PR0801MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: a6774353-e752-4785-3261-08dbbefcf1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qu8aiM885M9H/sHuSdd9kcyppYgSqx2cbJ9iIbJ62+7uftj4r4YCJALINkBnfWUwXyJuF7DIVLnlWslLKzWyFntmkzU+KciBu3RDBBffoA0g+07prhqaP3N8bPdESBGYT7cmMMKWE9gWz4usdz3oqApbvPYxlNIWzIcDM3xNGN8Ja9Y+xHfgiSa+JsVmTPdCF6yJ7KIZdv2A6+AymN8vPFIOEQGMCqmDRr6aHbUJJFr1kLPzABiBcUagdGZY+dFW3caml6DK/nvGCg/b2A1M5iI9KhnXXgMozlZ7nZM5/qsfYGae3Q99ejl1smJzpaz4+evwTnoYun6c/ZmLUSTulj91ji9RL3npjCepywuQ1Yc3dptF1g30hHOKSkKa2RGyRDhJm2ZEpiRlyo7P9auGEBro8RC0WROnE9gl7i+Aq+dJn3ihLm/HOzqWJd2V5Cb/9mRkXldVtocerr0HJChuDK4d5xhtzBw3OsP1UM9OCPCMx8VdwX3ftKKHTnMgtQdKaMbxlw1Ygex7y3yv31edth0+Wp5b/tfCl2uDDL40BnX0AaAE9bDuxPSaiIP5JtVn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39830400003)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(478600001)(9686003)(86362001)(33716001)(41300700001)(8676002)(6916009)(38100700002)(26005)(83380400001)(5660300002)(6512007)(6506007)(2906002)(4326008)(66476007)(66946007)(6486002)(66556008)(6666004)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VokMMN9O45fpegvGz03FGH0JzpR20CllReTr4XXVbi5X2hRXlylxP00iaATt?=
 =?us-ascii?Q?C91YgI7EbHQWoacXLCnyf8zMFVUoQi1qEQSZHHRLnx27yy/wvCkcSvAnx0Mr?=
 =?us-ascii?Q?T+eKNc30OqAe0mL22fAi6zVgQrXMjCzMxVZN/h7q/bqOuzdBM+0KLgQNh+ee?=
 =?us-ascii?Q?1IIpqG9A/W3P7EyuOIT5PQN2CB3cfcXGyguKEOrP4NOzAXfc4+DTF7f8iAUa?=
 =?us-ascii?Q?B0PzByI0l3uTJnn4J4DxXIWR+TdT76M99cHQVXQJH+jM5pNPz563Ch4PDByl?=
 =?us-ascii?Q?UcA27vXDKDIHuNU2ImSop03Z5NPzqPlmml+HlaGd1RGIEhm7arWhTMEi2h8s?=
 =?us-ascii?Q?glVYTcIQLGaaeFGUk9JWHJuWVDme1qDIe0kPI51jbQz/M+XcZS1iaJagyoO1?=
 =?us-ascii?Q?EfYwG+9/OzG18DrHrYZuRih5qmB3e1QT6hbF856m3zZC9Vjav/X2oRwUd5dO?=
 =?us-ascii?Q?03CsUCO52PbIdcFfoqD6HTGZVPyp3xV/ON/hKTCbHEKYZni8jFSwvQWaUXkO?=
 =?us-ascii?Q?Eyb5PWd60aCy67TTuUdbmtffEVZJuMv9C9/7AMyFEIiRlfewSBBJHvVK00vA?=
 =?us-ascii?Q?sAOmuuyNRPXsp+gGdgd9unyCLodU742aAPcfh9Py644bWb5XsQsj74b/RLiV?=
 =?us-ascii?Q?b5b1623UWfK51fXWQHmudrDCvEw+BO4kKYOTPY0NzkjpUt5pgKRCqbmw0mS5?=
 =?us-ascii?Q?oWrJykc10nCU+X0xSDmIRP83c/3DkaUsa0WHsoWtlPvEt0w4G3srMU4hRfTn?=
 =?us-ascii?Q?ooOUTnZp0nwOOauQBKWELXHqWoVNbbWjP+cvp5P4Kt5UdzRABp2VMAZCya52?=
 =?us-ascii?Q?AVi6oDTaw+9RpPJAYdldUIgLLjrTlEXXCjBPP0ES9D2zVHEzbbzeXLxdN4q+?=
 =?us-ascii?Q?XFnhsvxm2+Hqohp57ESsfU/nYjpB/OrZ9zvRbvmZb3whwMVHygO8H5Td8dl4?=
 =?us-ascii?Q?wWZjb6NM1wxC5urh1fEtjOykdiQopYdxPW+nnsr1tDiCJV1sDLZh1/MeOz/c?=
 =?us-ascii?Q?dIiEvmwcPdB8l7gR+uq1XlAu/V20EoRjIOc6SnmmjJUi13fu1P1lWu0wdGNP?=
 =?us-ascii?Q?2g+Cc9R87q1+LuO90Um/e8L5APsGx1xdnF5T5DW2DRy0LZ2MSJBJJ1RIcs4p?=
 =?us-ascii?Q?5gbsmr2o+oGBOVPu6zq0yr6xWsOZzjeHVNIkGwK1W/SnnKgwnxzB3sr/2ktg?=
 =?us-ascii?Q?A1jdthZe+2iQbRE/QrPmU8cPkLjEmor+UQHvVLoflHWdq/xPImDNyGIRcE8v?=
 =?us-ascii?Q?+vg4P6sLzLSmjPxz3UtQHCQn53gJBYsnQP1Fa2cyWB+QRvVhn6mRNtzZ5R9l?=
 =?us-ascii?Q?Js+xuZKVGt+YKBLC5EKbA81kXRMnCGGWtTPV1dTcukt/MfxTA+2kUj6i1haq?=
 =?us-ascii?Q?fyBzExP1xpn3U4DbNphVZC7arGYAnhPNe6BHUbQhl+Xu/tphiCB8tBiE/GNy?=
 =?us-ascii?Q?3AUcqpdENoMSsoOJkAyxthyU0rJ2VfvzVggZU+Bj43BO+7ogUyshY87pSSvK?=
 =?us-ascii?Q?+/AOWMrtd+zlGqfRyCiZ5ACcw+78uNxSkY4+yxAQmR0prEMty8lKoTI7QJoq?=
 =?us-ascii?Q?lWe+Uiam3NdjU9GnAnRu0lVEZ94j/5TFfTBM21M9?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6774353-e752-4785-3261-08dbbefcf1cc
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 01:56:20.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocQykKUaMSBfrRuSxalLSTdbfpjcJydvKV9ZuszAZ0EW1GXCpAfnfVZskHn85/p6Ns9hJTyfAQ5X+INsKgBCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, Sep 25, 2023 at 05:22:08AM +0200, Luca Ceresoli wrote:
> The irq-gpios description misleading, apparently saying that driving the
> IRQ GPIO resets the device, which is even more puzzling as there is a reset
> GPIO as well.
> 
> In reality the IRQ pin can be driven during the reset sequence to configure
> the client address, as it becomes clear after checking both the datasheet
> and the driver code. Improve the text to clarify that.
> 
> Also rephrase to remove reference to the driver, which is not appropriate
> in the bindings.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> 
> ---
> 
> Changed in v2:
>  - reworded to clarify even further
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.yaml        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> index 3d016b87c8df..2a2d86cfd104 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> @@ -37,8 +37,9 @@ properties:
>      maxItems: 1
>  
>    irq-gpios:
> -    description: GPIO pin used for IRQ. The driver uses the interrupt gpio pin
> -      as output to reset the device.
> +    description: GPIO pin used for IRQ input. Additionally, this line is
> +      sampled by the device on reset deassertion to select the I2C client
> +      address, thus it can be driven by the host during the reset sequence.
>      maxItems: 1
>  
>    reset-gpios:
> -- 
> 2.34.1
> 

Thanks for considering my feedback; the messaging is clear now.

Kind regards,
Jeff LaBundy
