Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D175405C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjGNRTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjGNRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:19:39 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53962D47;
        Fri, 14 Jul 2023 10:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtzOB+3WaZJoOJFQH1zVpCovzi7sawVuwvfbx7Vqk9GQcLnMp4IYG9YMyB1+40hQRt49fqY3aLUMUNjPysIaNFw5s+W5RAxWx35/8GK/qW4lb40tQnaFCG6v/SZYdLA9EwrxZeos2f9dd8KNwF9Cb/nqiW8eM8OVrI/0XFVRGK9bm+M1v21aiYzsHhdog+++7+NStmf/lJ2ox1snOGe6Q2cCl38U8inlxsnQh4DR7p29Fz1nie8NKQUZjmJ3+Q9aTj9mtbMquFEARl3/7k16/JuMlxvVD0d4L6AsQnLpY9VyFxMGHEfOG/AUEW1vYcgvQGAKEn2t/3Is7Cpw7cOinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmM2jbgvtinW1BF1Lr5nXdW5W40BrMmxkL3pZR1IlHQ=;
 b=VupB2JjHf8YSkj8EMWnxtrrw33T2rAnMTwtVh/ZUPtNawu3Ejoy3qf6OZ8Nnn7VfLK7cRVKdoQgreLmIYaczJ8IN3TwT6RedtiRQT6ripAOWDhZwxkk5VkLKWAEoc07W+mzVfLdyZmlGQuRIoh+NajZQHme5kF4GXdAZyo7IIFUMdQrzHMW++W9CO75Azs1ryqXJf76RlcvLDyocEaOkXzPrmUT8YycnkDZYIZWR7dJJjex/197AaU1UiU1dN5YMSFhRmKY8tJWBmKRBvYAchvZ72VB/vdKt3wBK7dS6IRiwfraO5QNMW4s4Usn1kZj89fm+EHjN2eotlN9HgXelqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmM2jbgvtinW1BF1Lr5nXdW5W40BrMmxkL3pZR1IlHQ=;
 b=OGCnGAIrqhaDUjXBCw/TaJI0AjGUbPEDKW4CjahlSERCRbXzGsdxA/0A6g+vmwfJH+b5Jhw98Xwsdpj3TKid0wG1txrBJqXvSb4NVWwQKEp8r3kZVp8ce4QqIBJ4KRZaje70K2QXMLQZIfzF2an09j16lFA9l1MXyYs5lzDpR3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.37; Fri, 14 Jul
 2023 17:19:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 17:19:16 +0000
Date:   Fri, 14 Jul 2023 13:19:00 -0400
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
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Message-ID: <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
 <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: ece6281f-7a2c-4192-3a5c-08db848e73be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxYUiEHwVW90X7Owi7ROqrQ/pB31/B/KOo9u2ghrVpOk+6+8OnplPJ56zCuBksGGFF6tob6dMqOMdy2FHDJE3VAcLs1IjA0pf4B4l8UC5Q/lEZFoJ+35HYy0MN6stvMLKxxEXqBqg+DMs60d+5Atxsbk98+ExNI50x+H4x5+FR6w62yF6DLYK+6Wzi8n2EUfWGoFo/goTz4d7UWktZFOkw5mNJ9HVG9IKFwY/HFdCLfOLJ4TJVf6liS8Ff1aBlf19wxZMeQzUaY49+nqAhmVzGaK08Hnk9y8pDDsvvrtBM1T9pcAOo3Tj/qr8CkNgIBC+kfcriHuHdZYiv1j+uo2ws4DEbMAfwWKvjrl0sUwvuY1fcVfIpecYfIumGXSutHbPwd8MiZu97dMPVb8w5jDxt3I63b3JJzuI798keC1ZI7IQSNux5Zy6hW9Ba4gFwLSJRBw4upnjW0JwpOSJlZxs8Jl2JT6vEDCaWLo9ovddEOPHJqg71b1qE2VvhBdrzQXBnC1aRaqhoR7LQqaBQcRSj51hp2qnF13fSuMGy7UV9zgya3cm1O3gW+tN8lrrPEaZjf6nMX62V+ZUfdd/Sxw9I1DdSPmt06c1a8cngx9hzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(6486002)(52116002)(9686003)(6512007)(6666004)(186003)(6506007)(53546011)(83380400001)(38350700002)(86362001)(38100700002)(33716001)(26005)(4326008)(6916009)(66476007)(66946007)(66556008)(41300700001)(2906002)(316002)(7416002)(8676002)(5660300002)(8936002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHVncXhMMTYrSnVBUE1XTW8rakdVdjU3ZC9BSXFXUVpPZ09uZnpBSWNoV2tv?=
 =?utf-8?B?QllENVdjOUFkYkNabVZNV0tkWmltM2h5NE82Rysra0MraFMvWWpLRC9tb2p3?=
 =?utf-8?B?d21YaVFqNEZ5bkl2NEVzdktkUWpGSGdOTTduRnZCcW92S0oxb2FlYkZUMmxa?=
 =?utf-8?B?VDloajFLczVoWnBDTVRxTXZ0NDBJNU1vc0pGS1pWd2pQVWNRcVdHaTlUOW5G?=
 =?utf-8?B?ZHVkdzVaVFFnWE1EbEFlVUtYdG9WN2g0VThOcVQ1Q1BSZkdUVjVLTm14ckN4?=
 =?utf-8?B?bkJCVkJETG5zdmZVMzlERHMvbFBjNkJTMTY3OWJEQUNWNkZvVlRBMHRNTzVI?=
 =?utf-8?B?UitKYUJwOHFGMDd4Mi9IUUtQdjBLRFpDMU5mdHRtRVYxcGNXbzJsN24xdWFY?=
 =?utf-8?B?TlNiRW8rN1BvYkZIZkExUkpmbkdYckc3RDFQQ2ROTVQwb3RPL1NZYS9JaXVx?=
 =?utf-8?B?b2RpUFZkMmZ4RjR5bVpBbnUxaE1mcDJVQWVoNjE3RUN0OXZEWnVYTVVabnZw?=
 =?utf-8?B?SUJpZ05pWTBwWDdBV21HN24vbHZnV290cjZFVmJFUjR5MkloVlZxN1lQNXpB?=
 =?utf-8?B?d2F6Wk1EWnVIVHBxTEJuMUFmREpSNWh2VGI1RnIzTzN2N2RoZ2locE5HYzlt?=
 =?utf-8?B?ZUZBdDFOTlgyejdFbElIYjdtNmNyeDBaaFRTWWpQYjM1eDh4TFhRVVZIeHBW?=
 =?utf-8?B?d1g2c2NDb2dFYmZqbWRWRmk1QmhrNDcwWG4xNWErS211SkpsK2t6eks4WWZi?=
 =?utf-8?B?UW0wVjJzUExKK1JnRU1Xc3FLQzZqeno2UjZETU1pRTdIbGRTN2tPR0lqaHYz?=
 =?utf-8?B?WkxUOGJ6a3k4UUZ0NjJQVTh4WWlKOEpwMjZZQ085VDZkZTdhMStMOUdVeDlt?=
 =?utf-8?B?cndFUWk4MWFIUXpQdHlmZzNHa3pFT3BpcytRbGxUbXVUOFRNbU1qdUh6T09H?=
 =?utf-8?B?VVVkaUJUak52NEhHSnpuTVY0cTVpKzF4RExtMzltTzlVeW5KTkJqTHJDdm4x?=
 =?utf-8?B?QmNaKzVUWDNrZnJ5VGlqVmpKQ1l3Z3p0NVBZZXRXVlM0SURJVzdUcURUVkND?=
 =?utf-8?B?VFRreE9JaTZaaDViSWFUcUJ2VEQ1bEplOTU2YTlJZFVtUjR5WDEraWRWSW9Y?=
 =?utf-8?B?czl6MUs3bW01SmM0dC9sVXRWK1FUeXgycnovOU1BMzlnSFphWFY1eThGNnlU?=
 =?utf-8?B?Vk5INnRxNTdHeXRYSFlqTW1nUkR0V0lZbHFaOUIrZjdDMHF3Y3prS2FwQlRn?=
 =?utf-8?B?alhBbHRJdGpTMmhOU21FblUwZzhXTEt4VWtTaUtxdlQ5cStiL3FBQW1NMno2?=
 =?utf-8?B?M1I3ck54QlljN3gzU1FFVVpWVzZ0U1hGS0dqS1dST3dXWXlCRXBVdWdVWlJZ?=
 =?utf-8?B?M3dCRjdsVU1LUTNyeTlPbDBKa1ZsUWUwUjkvNkw3Wm4wMDcwbk5jbDNUNi9z?=
 =?utf-8?B?VnQycGoxaU5DNWZCMXd5ZStDUVlMNVZTZkJFY1BnTUlkYS9Fc29KcXM1Q3Fj?=
 =?utf-8?B?Y1dvVWM1MTN0MXZ0NDg0eFBmcy9sTjJCcFZJMEVLLzFoVm9VaDY4YkJtTkk0?=
 =?utf-8?B?T2VWengzeGY0eHJQOTEzbk9SVUtDemxBOUF1OERuc0VhM2lBeDIxakxSeEk1?=
 =?utf-8?B?N2xQMk9BeDM0KzFsYURqZ29JZjc4NnRQWFgvN0ErU045djBvc1RYYWd6SGZW?=
 =?utf-8?B?WnpteTNWalRUQmdtSWk2QXAyZzU2VmdUc2xOOUNZQTJRTHhVa3ZXbmFIazFh?=
 =?utf-8?B?T0lCaWhPc3VyV2JEa3JiVSszanh4NDRRZi9nemM0MWpPV1o0Z1htMDRsTERF?=
 =?utf-8?B?Yy9CckF3QlFhRE9EcnVvdmVtdkExZW1XVUJ4TE9TNTZ0NlpKTmhWc04zNDhp?=
 =?utf-8?B?QlZZVVpDU2VpTnBTa2xKRjRHd1FEZ3VrRG5CWU5nVFhtaEpvZmFBblc2YWlU?=
 =?utf-8?B?dERQcUhFTGNnTnQrZjY0bzRRTUFTRjJsck9YTjVDcU9RVm9wdXZHbll5clZs?=
 =?utf-8?B?YmgxZDhabmNicUJRYmMzemw3bFJ0Vys2elhuc2ZRZ3NaZ2RMbTFoMVlmcTda?=
 =?utf-8?B?NWZyVm9SNWQvdjlxc0NaWU1XUHA4QjRjZlZtdURoZGtCcUI0bU1pY1RhcDlw?=
 =?utf-8?Q?OYst5A6P503nmx1buF44lP0s0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece6281f-7a2c-4192-3a5c-08db848e73be
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:19:16.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSThurh3UkWGBscht2XI8GfCzlnKe76lhe67BwTWHOsQcq9eaD4OnKYSlQ2AznpU6kdVl4IGM0vsWkO7y26OtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
> On 12/07/2023 23:05, Frank Li wrote:
> > Avoid endless print following message when SCFW turns off resource.
> >   [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   drivers/thermal/imx_sc_thermal.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> > index 8d6b4ef23746..0533d58f199f 100644
> > --- a/drivers/thermal/imx_sc_thermal.c
> > +++ b/drivers/thermal/imx_sc_thermal.c
> > @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> >   	hdr->size = 2;
> >   	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> > -	if (ret)
> > +	if (ret == -EPERM) /* NO POWER */
> > +		return -EAGAIN;
> 
> Isn't there a chain call somewhere when the resource is turned off, so the
> thermal zone can be disabled?

A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
am not sure if it is good to depend on "name", which add coupling between
two drivers and if there are external thermal devices(such as) has the
same name, it will wrong turn off.

If add power domain notification in thermal driver, I am not how to get
other devices's pd in thermal driver.

Any example I can refer?

Or this is simple enough solution. 

Frank

> 
> > +	else if (ret)
> >   		return ret;
> >   	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
