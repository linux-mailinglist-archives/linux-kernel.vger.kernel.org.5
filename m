Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D17DB30D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJ3GBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3GBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:01:05 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2078.outbound.protection.outlook.com [40.92.50.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3694;
        Sun, 29 Oct 2023 23:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjl2l2yvYvZrf05hK7LgvgXiMiqdNzifmrsOk9N1gU1BWB2YmIQ8CLfswryMiX6i8Ao4l5FShobU9bheenHqSmGoRQU0XjDyUUj6s/MWQjeAit0RTFOjvtjAsKe508IBzC0oHdEX+uRxWubpK7yMHoCrBKhA2aAQbnU7utcqj5Ytks/WZiakzJsYw+/c7vfepG+Gt+Mjn6Dd68ltPUNK24BxAXcnOA69smNsflITrN7SKskDSn0SuLwRToAKjjawrS0dRgahKb+NF87MiyLpNLmEsd6n45Vlzzztyib82dBgsZBLIZl0pnV8sF4ejP2IUVeK+Mv9uvr5ihoXDOj9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5DZNpf+qOfjj3gM57iNET/DMzd/j0XUj1yxtK5Cykk=;
 b=Q6Jc1YnHs3KDuzvtoGIBGri4E/xsO6f1PgNGrUqdLkg0QLENkKsgZZDeC1KUQ3LaKObdLBCPOa4aXNitWfReZMwXWa9C7aEOQOfX9CiY+LZNNQKzXGcJFD1PXGYj/NQUDWEZoz7ZzA4x4+/CHngBQcMLSBrkIK8HqFaE1H0ZYdogkWsAEiUPdUrShoNI6v2UAy0EihM+SbauALHsTnl2WhjKM2dp4sgvYkCdRDyoVGsOrWd5pSCALE33XY2Gq6zVZ4kMPdsDRHwvEddTuwB/JZNgLn0r5RcTPpg6mqVYh+mHbTZdqgBKGCeFnlnV6a6SfzY5A8zh3vxwIac+kpZ+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by DB8P193MB0695.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:147::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 06:01:00 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d%6]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 06:01:00 +0000
Message-ID: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date:   Mon, 30 Oct 2023 07:01:11 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] net: stmmac: Wait a bit for the reset to take effect
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [5TayCGdesDPDyQeQVdMawVO0/gmh2YV/Su02BQrexM/V2tY3DQ/87gEVr2nSsLjQ]
X-ClientProxiedBy: BE1P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::10) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID: <72fb07eb-137d-4b8b-b930-a568788de591@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|DB8P193MB0695:EE_
X-MS-Office365-Filtering-Correlation-Id: 54336de4-b497-45c6-a0f5-08dbd90d9725
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qo8HgyfwVdmtID+Zz0bi8HE2SyFhbyzFDTgJIimm6pEL86oJEHmJ03ZMYBsZbEVs9gQjmB6quqvZnhrpKk9CW7Yda8twt1xOxs6h+48ZDBjVOiHtVnkhQGt+NwKmIWWoq9BzuXwk+40BG8AyVvxmxsNweEN0apXkCXpluH39YrkFb0PDcJPGMXKIUJnW6tnsfs3zw72fs7NCNmv0WX6dCQWChHfZeARZNyoyrocLhZSWeWmzkd/SDDgAiXpKi4Y5vtiB23ckT/yAUSk3xbZWw5FE5+91GVnX36fMJWcceRMjLHdepW14L3+qhAve+PRyzrdlAExCH+hNv3FSDYRb/IWato9SUDRPGO2gcrCvQJhk06tiSiUUj7RHDGenrJ9WN8vjiqmF1lI/pu2lWOZO+o5HGVewtOI9Gj1CkzUbMwjd0akf9DzIGmXZJQfnCSTZhpqXB7XprW4jqIbq+/HQ1JSa9gqN8eY3MV9gMOkJaQZQuyk8GxyVq34haR2Q+GrXKX2Wc/gPW4zO3icBz5PpYDGG4LIZV+4IpKZIg4ecwx7wUB+/iJ7pzqBqG9MtBSp9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjV3Zk1EMkxSdS9GSlhlZDBsTS9mcmkvQ2NGRzdiem15NVJyOUY5amp3ZkhP?=
 =?utf-8?B?UFRtZGNBdnhhUE11YUpTVU1KL0RQc1UyNCt6YU1INElSMTkySkZmR1VSNHJs?=
 =?utf-8?B?VzJWKzhmcytUVUhQaGhVRjZ4UFlLa3B6QytiOU10RjEvSG83ZXE2aEl5cjlI?=
 =?utf-8?B?b3dGUHhQYWdGRVFZNGNrM240aXdyRkxrblZvbTl1VUZOc1N0WlJySDcxSFZ4?=
 =?utf-8?B?MzlTc1NZSFJOaUlwdVRBajRxMXVHT05Wd0NmcGdPeWNZTitKKzNNanFxSk5W?=
 =?utf-8?B?QWZtODVsc3REZnFTclhzQkR0TW8zSlJYZnp6M2czc29sS3dSRG1pbUJEZEFa?=
 =?utf-8?B?L2tSM0VpWFhxZGZYelhlVTh6bGYwNnh0UXVEdm9qQjloNHBQdURnY3EzMDc4?=
 =?utf-8?B?V2Vna2RMeEtrc2k1Ymx5NjZkdGRMSnFRMHkreDBIWksvdkpiV0FkVFJudksy?=
 =?utf-8?B?QVg1NTBMUU1NekJWRWFobGVrbUhTN1IxR3Arc2tzUTNoYW5iSjJuTmZBM0Ny?=
 =?utf-8?B?c080Q056NWZwSHBJMTZOaDBhTUNNUjNKNGpzQVZrbkZYUjBIRlNkUmdCL3Ux?=
 =?utf-8?B?TDhZdHRJL1R5QTlzQTN0dkEyTXBPTjFKYWt6NDlma0FSSE1yVHprWnA0c0RB?=
 =?utf-8?B?ZjVxOFhXZ3ZBR1BBR0Q4SDUwNzVtRENISXJNTnhaY2ozS0xpaWFtTDg0aFpS?=
 =?utf-8?B?bkNNaEZyT3R2QzhHMTRhT0ZZTmVUNDlZTitYY0E5ZDlTUytuUmdHMUF2cm9Y?=
 =?utf-8?B?RWRiZWZFNWtwRFF1VVBERTlmZlRXZnZ0cXlsZS9BRnNaUXZUM0IybW90aTAz?=
 =?utf-8?B?d0dQbEZRdTk1aTJKdXJOSWJjV29nUnp1bk9NNHZEMmltS3ZXQWpaZjF3a2Ex?=
 =?utf-8?B?SXFHbFd0Z2RxT01mZVBvZWtXM0VLa0t6TTRUU3B6KzB4NC94Nmk5MlVURGF4?=
 =?utf-8?B?QWlUeFRNTU1QQ3I2cDdHZG9KUnhmRjdmeXBpVUhhaEppUjEyV1VmWEdiMWF0?=
 =?utf-8?B?SHZIM2VxS3R0Nk51ZnpUWlJYSEVualhEYnAvcEFEbUVhM0dqVG8rYVlqemwx?=
 =?utf-8?B?eXZWanJleXFWZk9iSSt2dFVxNUlQOG1MMFRhMUp0cWdnSWt1UURPWmdzVUYz?=
 =?utf-8?B?ME1oM2lmd080ay83SE5SbnFYRGdHeE9ia28xQkhJcFVGRlBJdTU1YmZGbHJR?=
 =?utf-8?B?M21YSUQ5YXUrVjBkMGJOUmdCcHIwZ2hxNHZKV3Q4S3lYSVdPL3duL0NSeWhy?=
 =?utf-8?B?Q2QrNnB3bVE1d2RTYjlHditxUkdDUktqS1hZM0ZWMUZMSjNzejBkVTkrZE9K?=
 =?utf-8?B?TGJNeHhFMC91RkEzai9JVjk0eW5SK3REUXZYdjEvMUFoQUJhQnVQNHMrU3hi?=
 =?utf-8?B?b2NkN09tZmxaa1lOUXluaEUwdEY0a2xneksyMUROV29OdXlPZDJ3MTREdUtQ?=
 =?utf-8?B?b1ptSHF4NXBiYTBneDYzRGdjYkZZOXBnR2R0UzJ4M0h4cmE5Tm9PQlZVekVp?=
 =?utf-8?B?bkpHMlgyR0pCNE5PUEw1ejNhUVV5R2g4RG1VMXJZMVZ0Mlp6S0pIZkNmVjFI?=
 =?utf-8?B?Ry9PQzlEckVaY0htbm00M3FTRlpDTlBSbU5SOEJwekRnTFI5cU5vQ2ZJMmor?=
 =?utf-8?B?VzNPVDZGZThJd29VUytIVTUxTXI3VVY1bzlPUWRGVnU2STZhV1NWeWtyYSt3?=
 =?utf-8?B?L05HNXlDNHdQQXg2azJkZUVaSWFJWnk4eDByMFc5c3VQRlZLSkZlYUo2cFRu?=
 =?utf-8?Q?iBOfTnF2H+4/bqPEmk=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 54336de4-b497-45c6-a0f5-08dbd90d9725
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:01:00.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0695
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

otherwise the synopsys_id value may be read out wrong,
because the GMAC_VERSION register might still be in reset
state, for at least 1 us after the reset is de-asserted.

Add a wait for 10 us before continuing to be on the safe side.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5801f4d50f95..e485f4db3605 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7398,6 +7398,9 @@ int stmmac_dvr_probe(struct device *device,
 		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
 			ERR_PTR(ret));
 
+	/* Wait a bit for the reset to take effect */
+	udelay(10);
+
 	/* Init MAC and get the capabilities */
 	ret = stmmac_hw_init(priv);
 	if (ret)
-- 
2.39.2

