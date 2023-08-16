Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3477E744
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjHPRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbjHPRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:07:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A0103;
        Wed, 16 Aug 2023 10:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW0e9uoLY2yJkSojigIXN8vKWIitqHgWeZm8jee7eE0o7t6chu8px/sZmDtg7yZcDEfKQta043xH5jBtBUySBCPNg87PQEODi4ygPrJzBuHFE5Q3b/HkUBXBDlHV4HDdEdqSCu9dTNHAZuk3ophWIILPJXYJGgSVvEF9IGG/jnMq4aT9cGmZ/OCZjj2qbUo1T9b7hSUdOoR3FfSswPqtFc4iS1gXtkNeMtsA2neBG6Dhtm6vNl9y0MrSOKAVpWm+hEu1T7zwKnYp8ccYIP+5NYEoiX610dLquiETrHVWPPD8YXYVH5VwAHiG7YXfOZl/1hXhrDYRtx5zHrCW29t6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+yXwKQm1jrF7j9zSfSX5dnzGfrqxeHh06wn55UplEw=;
 b=KmfIFYIIL82yptAHr7ArqMIFTu2bk6g/tNq8k8HxxiZoDR/nq2tCH/535IY5CQt53Be4/X5bTgWq6tfxzYU46Q/7MzGXVVr6c+K1jTXR0CBaRlEw8qps4SXegh/pffsGwS14YW3hcOm/gOepD8lUnlUW188cnJHLf1d54xTwI8/gsu8gOPYEe1Ng2IyC6d3HGnrSzsu7rxRDQCUILg/nRb8YP+88B2mWrlxN7p0AEuOiflhZqttoHQ2nYez1T+Z3EMSKgH274/x8nOMql3dMIw76XVz6gT27k7LfhioAwChEW1rZ+Tg+nVgBt5el2N/CktPHN+0tGJKLvnC3lKN+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+yXwKQm1jrF7j9zSfSX5dnzGfrqxeHh06wn55UplEw=;
 b=C8oLTnrjbbGHB29B0yee+UHlQVssqtWLy5wt2oZQ6Y/2Zx5brMgyCkv9edoq9h/kDCTwgCGZ6dqYTMCrX+Roa2HLyvJ16qmjI1Y4csXVi8D+pDm5cdvpC9anINTEcEhhmFToBNwfTjwOtXmNCtXDrhccDv1WKEE5Y0yo7QEnoCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9428.eurprd04.prod.outlook.com (2603:10a6:10:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:07:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 17:07:47 +0000
Date:   Wed, 16 Aug 2023 13:07:33 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Message-ID: <ZN0CVa9or/FltHJM@lizhi-Precision-Tower-5810>
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
 <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
 <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
 <ZNz5Drb+EVLjWxRV@lizhi-Precision-Tower-5810>
 <dd42952c-4dea-ea57-7ad2-73fa159d265d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd42952c-4dea-ea57-7ad2-73fa159d265d@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: cd22890a-fb14-4de9-ca51-08db9e7b504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHa33IueHqPcxLCWXIo5rI1coNNUQx753RrrFPVsHX/BO5mXnoTJoCSFPxjYSVRVn3pdZ3fi9fDXqv56cYYaXq97gguhOLTTzPfe9LGk7PSjc4a/LM7aOk/ZYsGyGwrG6++0v2/8Jl1D9klHNMevCfw2Z1qrCH97y5YVNDXs/CC/91w8yKcve0rnDKqZBctkgbzXYI5zV2YIvD3pdRg7ON6o5uyz964uhEYvsAQy/1t1NYDAOcdhf8cECZkOp8fUYiQCIe68VSZdfS9LZ+xQX2qI69UoroSgJ082ZJlss4dU22yhnZPO0VcriEGB9eq7HvyQ+06hqEbTorP9WMff61kduRWCxBnZQYZtm47+jPmOdrTwaXPH2g7ueD7+YDh/hpzS56/16WubOPO3O8hDGfTVc0B/yRrquGD+0DpM46JQUQzzCjbW77/h4kcCHTHYQObeIZoR/GklNyial0BklLuE6szwo/3/afILFjDv0BjRi/lXhOAnmgnO/wvXKAtKBz9tQ5sCikuOSHfw+MDJjQwe5EZLkL0jhcO0B8C2uF/khOuCjk3jQRrZBFzOg8VZrP0DVrXMQbhU476Mvr/ZSZTpooxQf2c3OT8nbEzC0cU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(33716001)(66899024)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(53546011)(52116002)(6506007)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRaTitNL3NXWFpuQnlRM3pzM3FEbGEzTkZmUGpJZU92QlZOdTIzc2l3aFR6?=
 =?utf-8?B?TXJMRDRHR01iK09mVHYzcTMwemtPTnpqVXJCZVVDeS9RWXRNcWJmcDRnT0Zp?=
 =?utf-8?B?bEMzWEF5azRhVGo5UStocGo2SDNwR3J4ekI5S2JWK0thcXVoWEEyU1pJQkF3?=
 =?utf-8?B?YkpXR0lsbEJSalVMRVJxUkVIVURDMTAxbElXbWtGaWttMWZHL0F6STFkenFz?=
 =?utf-8?B?Y3VwUzI2ZWVMMFpTb1pKN3JQUkRFQ2hHdzV5QkY1WW84OFZNUk9JMUtsSjgv?=
 =?utf-8?B?V0R2bzB0ODY5bThvNkNCYTBsU0crbjZsNVlOVUs3R0pKZFdHSDIrTk9HRGUr?=
 =?utf-8?B?eW1GU3JmWWpEYnBLUElmYXNzdUZmK2JKN0d5N0gvcUk0SmJKRVZ3dnhlZlVm?=
 =?utf-8?B?amhEYlZ6SGVCS3R0bEo2Q1RhbmlFVG5yOTdvS1k5dndyQTVHUUZQVUpnaXFq?=
 =?utf-8?B?djFoRTJMcW02dG9CZjJwQ0Q0M29ZeHp6SFRwUjhTN1NWdXVzeEg3R2hHQUN4?=
 =?utf-8?B?TU9mQTFzMTRKRnBVMDJ1cU94RUF4Z2xOdGlNV2JsamFDVXB5a21BQWlvZ2Zx?=
 =?utf-8?B?Vjk0elpQRElTVWM5eUhUVExKZVo0WkxYbllpSVV4Mm9mcEtGS2w1T2RTYTd5?=
 =?utf-8?B?bG5mT2pSRkxVVkZvUE5yYnhVMzlKWnJTYVEyRTNqTjAwYzNRZDd3dmYzSEwr?=
 =?utf-8?B?Sm81VEY0QkhYeXV3K2htUVorOGRYMlNkOUpkaXdMYXA4RnhobWJzbE5jb3NH?=
 =?utf-8?B?dzlVS1FGdEdNdlR2RjZaQ0ttRE54MGVEZ2ZabFdJUngyM21vd1g4VUxTR1d2?=
 =?utf-8?B?T3ZtL0I0Z3FWbWdJZWVyTThRUnFEYkw3bHJ2SkpQRzhURFhucFVNN0huUUQ4?=
 =?utf-8?B?ZFFHd0c4YzNUTGNIMXVSS1pRditKRlFMTmpEYW5GZk5FQUJUYU5MOC9XTnls?=
 =?utf-8?B?V1BrdHNLcExyZm55ejV6UktxU3g3L3ZrMnRZS0ZkcVlOY1RhSVRkTDc0NkJ3?=
 =?utf-8?B?UXExbktGOHcyaEVZZVN6TkhPeHU2bDZmaVMzUkpXT2NDUTcwOE9hV1NpaFlm?=
 =?utf-8?B?SG5MSzJlcnBQRllkcUQyV3FvMEtZSkFra1gyaWwxdGdCMFhZMUxMTnlJQmhz?=
 =?utf-8?B?VTUwSzNLZGZ2LzNDVGs1MWxGR1dndDlSQmZoTkQ3aWV2M3dXUklQbWdKNTFO?=
 =?utf-8?B?dXBiZWVtQlorNlBDVlNDWmxpb2JmbEw3NmZRMjR2bUVkcXZGY3JjUm9qUXZN?=
 =?utf-8?B?K21lNHRtMVo5S0VyTU91emIvSzQwaFBVUEI3RUV2N3lxMGV4MFhieFd0ODEy?=
 =?utf-8?B?UktKR1N3SHAybm9hVlRZWU9zZ0plRDFpdmlDSU5rMG5MY3VnSzl3YXczR3hG?=
 =?utf-8?B?YU5LWEFEbE8xM1YxL2RyUTVHZG1vZVlzZnp0T0FBamxmbkdzYnNCRnFKckJP?=
 =?utf-8?B?K3hMOXNBRHQzTkxRVEhNVmpuLzZqUHJDQXdqdkluTS9UamhQemVTamM3eVVR?=
 =?utf-8?B?b0Q1L0pCbmUvbG54dS92dmczMVppYi9raUl6UXdYdFJvcHVzcnNVM2FBeXBi?=
 =?utf-8?B?S2NEaGlsdzMrREpzT3N2NnVHZTRQMnpZY0tiZVZzZURqRVZhN3hkckF0VDJC?=
 =?utf-8?B?djFTMkljY1ZIN0l4U0lsMEkvemhCZ0x6cXZJUGZVQTJwdm83bStHYU45Zy9P?=
 =?utf-8?B?Y3JJbFY2bkFIUDdxTFZJOXZDTkZMb3lCNHJiMWJZU0ZHQUN3cXlrV25SeHZs?=
 =?utf-8?B?eWZtcGlVNXFEMTJWQ0kwYkl2Y2U3ZkxuSis5RlBmaFFvZ0JYUXo2Um5hYjZi?=
 =?utf-8?B?Z3UrVkxFYzJJb09WQ0FvNUpXSm1EcnkvbFV6YUc5NlNkU3NLRndKWmFCejhY?=
 =?utf-8?B?a3ZYenp5d3dYN0MrRDNYb2lOTlVTaFdSQWRzZjVoS29BYUdCdkg0Q09lOTc1?=
 =?utf-8?B?QzFYaTdkMlErK2xYbGlUMzRNRENIUEhNWUVhTXQ5LzdUb2Nod0ViUndHUnlv?=
 =?utf-8?B?ZGlBTTgzUVFKSVNjenlnb2RLSWhzUG1DaGhMaTE0S1JSdFlIZVM4VXl5Rzh2?=
 =?utf-8?B?ZzRqTHVYQUFPeFRBazlqeFRCRFE0YU5GM3Z1dHp6d01SRzdXSEhsbFlYTElx?=
 =?utf-8?Q?NIDg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd22890a-fb14-4de9-ca51-08db9e7b504e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:07:47.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNVOP6AdFUly8CjRKa1bbgZnDZhWWMcXvf++3edoChL7KcrWPiVBN9b1csmcx7so4pW8MMWkMfIOVD0UEeY3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:47:17PM +0200, Daniel Lezcano wrote:
> On 16/08/2023 18:28, Frank Li wrote:
> > On Wed, Aug 16, 2023 at 10:44:32AM +0200, Daniel Lezcano wrote:
> > > 
> > > Hi Frank,
> > > 
> > > sorry for the delay
> > > 
> > > On 14/07/2023 19:19, Frank Li wrote:
> > > > On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
> > > > > On 12/07/2023 23:05, Frank Li wrote:
> > > > > > Avoid endless print following message when SCFW turns off resource.
> > > > > >     [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> > > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >     drivers/thermal/imx_sc_thermal.c | 4 +++-
> > > > > >     1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> > > > > > index 8d6b4ef23746..0533d58f199f 100644
> > > > > > --- a/drivers/thermal/imx_sc_thermal.c
> > > > > > +++ b/drivers/thermal/imx_sc_thermal.c
> > > > > > @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > > > > >     	hdr->size = 2;
> > > > > >     	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> > > > > > -	if (ret)
> > > > > > +	if (ret == -EPERM) /* NO POWER */
> > > > > > +		return -EAGAIN;
> > > > > 
> > > > > Isn't there a chain call somewhere when the resource is turned off, so the
> > > > > thermal zone can be disabled?
> > > > 
> > > > A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
> > > > get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
> > > > am not sure if it is good to depend on "name", which add coupling between
> > > > two drivers and if there are external thermal devices(such as) has the
> > > > same name, it will wrong turn off.
> > > 
> > > Correct
> > > 
> > > > If add power domain notification in thermal driver, I am not how to get
> > > > other devices's pd in thermal driver.
> > > > 
> > > > Any example I can refer?
> > > > 
> > > > Or this is simple enough solution.
> > > 
> > > The solution works for removing the error message but it does not solve the
> > > root cause of the issue. The thermal zone keeps monitoring while the sensor
> > > is down.
> > > 
> > > So the question is why the sensor is shut down if it is in use?
> > 
> > Do you know if there are any code I reference? I supposed it is quite common.
> 
> Sorry, I don't get your comment
> 
> What I meant is why is the sensor turned off if it is in use ?

One typical example is cpu hotplug. The sensor is located CPU power domain.
If CPU hotplug off,  CPU power domain will be turn off.

It doesn't make sensor keep monitor such sensor when CPU already power off.
It doesn't make sensor to keep CPU power on just because want to get sensor
data.

Anthor example is GPU, if there are GPU0 and GPU1. Most case just GPU0
work.  GPU1 may turn off when less loading.

Ideally, thermal can get notification from power domain driver.
when such power domain turn off,  disable thermal zone.

So far, I have not idea how to do that.

> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
