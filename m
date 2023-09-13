Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED679DE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjIMCBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjIMCBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:01:23 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D6170A;
        Tue, 12 Sep 2023 19:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgtoY2xHd0kVfaqaasVZycwYeMWc3iZrtSFfQvNcT9mhx+hhi2/qjvMVGM5zAvx3l6gxlYBTI5lq1wFrNBgrGqTps57uJCPMF9k1z7RKRlS+hiOJruNTLFFRtcthfOiYfc7TqteVFx6TQn0pQmpoYcKN0XtFnHY3zzzIkmuHtLLZCv018Vh3TjMLuvrQM4uZxVRSyGEgVnVWct5D0GmygO3DJ9Ga8hJmw8uPN09KeRAZZKri1swotxWIavUaJvEenibQFy0neYE5MxqJ/9aQRiQaV+tJZHfladkKE+qXzkGwDAHzOFlmA6oYezeL/Zt+8x3VXlB0Y7UAEsePequZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK8g8WBtLs1659Dih8bzw/P9yNUtWe4jegDKFUTaTeM=;
 b=Y0EC53vXuvqD2DNqRblfx06EJW2Oz9HrLATvQetjVAhypRMXRRQPBhZhh9I7vTvvrh5hz6BOOnjWvw919ybNP1f+rU7qsqukxB4SS+beNR81uKRnaKGZ8hAkGXkBY9rXOcmZMKsrgQCoiuLkrUbBCzJe8mSiihqDi0NzuA7ZEIENYiL6DSVMKiNaHabvXNFIIMmXCpi+dyt1a1fqvHAj/MfabLV9UU4PZmvLXTtv7qE27oUuFeQ5uOktRNVRnWCBTayErHELiEdSiohdpa8t1A11flsWYudZc0Ay9kKM1uaoGcj7MyzU7wSYfdZomae1fP7w4sYt6ZFE+OtBEl5p/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK8g8WBtLs1659Dih8bzw/P9yNUtWe4jegDKFUTaTeM=;
 b=M5QCDLqulxk0juDn/L4+UK0jvWY9PwRU0uQIpIbRcUD4G22FjZ0m5UKscbi05vaJfWdnT298b1ChrYw4+sRwxgdm20wjxA6/qpCOdU4gW8EfUtwA91x/NS00ltevzO3uo9J5O/2I/JpZfjLEFFfGAQ4ssL/LrjLJoDq7tNOw0uY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 02:01:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:01:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Wed, 13 Sep 2023 10:05:37 +0800
Subject: [PATCH 2/3] PM / Domains: Choose the deepest state to enter if no
 devices using it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-multiple-state-scu-v1-2-9d91c6904ffa@nxp.com>
References: <20230913-multiple-state-scu-v1-0-9d91c6904ffa@nxp.com>
In-Reply-To: <20230913-multiple-state-scu-v1-0-9d91c6904ffa@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694570751; l=915;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qvVSxMEbUt5msArNvyrVU8YXTGWc1AE9b3pKa/4hFSo=;
 b=LXguZlHBKDCysSJp4EOPAEoEi7JoxskXTmrfTGVYexYNHJWlpAv+3A8JHrLy62M2z8YmgXBrx
 K77ryN+kOXZDJy+ERwxsFdc9MQ4cC388Hxj3ykAy4uVzEQnRwThR9By
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 44053930-43de-4423-e7f4-08dbb3fd5040
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fypPQTHgRqmI+xumNRPuRMZr1vSdDW7s2og5k14AQdXT6fCJ/8yniWHzmHTUEGcspDs/XunedE+tHeF5F/dA4dFF5IvctVGp31S5sMD/z2ruiAJgQlooAZsQ4cN/DKdTvGyTSFhtSY7FUnH8CGTgRe4f/b92uhXrBUKfBnX5aTiRXHtm1BNp/5XaG1V1KcHuGg51bbVHNmuBrzUwplw9yy+TsFBCZb4x38rrGwaUZhu5MRcUxD+AUHBH/Zdy0+DrUhcdlDeynFdtSOPO1hs3Wgx7MC6hHFFnfonFVqvUy2weCoAevTSo7H9yEMG/i1zRJVP/t82I1rDsDnDI/sVt0BmMW7j/qgRvIqM+rJIpmX1DQhA9ERGQEj2/u16ZolqMffns5Tl5T4XgS1X9vFHLIyW3f79625TY4R7dIa7SxfpktGsZGe3Q7nxO8PI1UM9LvUh7H5Z/x7xxzK5sKUYtnX5fpdQDPnNL1NgLqLj87Mx+W+XRo6xifjTGo65WokSbdWEDLZvAom4MM5XOrtN8zxSbvdzjTgfFsNLMZG8h/olev8BdhSVbtEH4vhkd5UAs55pqjBt8iShov3TlcBB6QoPPpCoEDsAOkxdOjTq+3jYufw4R+J8HOQM+m4CUT5JwzOJPzynjfGUqRzxU0EirbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(186009)(451199024)(1800799009)(9686003)(6512007)(7416002)(5660300002)(6666004)(52116002)(6486002)(6506007)(26005)(4744005)(478600001)(2906002)(83380400001)(8936002)(8676002)(4326008)(66946007)(921005)(41300700001)(316002)(54906003)(110136005)(38100700002)(36756003)(38350700002)(86362001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFvNGl1K0Z1cjZFWXJ6S2FxVkRxNTlneUhWSTFlSDViUURtZGNLbmtuV2Ri?=
 =?utf-8?B?aFVRWng1dXhQUmFPZ2hVdlg0VlhSQnplWnJRMlMzdyt2ZFJqdVJDcFFvd2ZZ?=
 =?utf-8?B?djM0ZU0vcXpKb2FscENoWkJUdGZDdWJ0aXRZK0FIUkZmQ3gyUklRbWR2eEFB?=
 =?utf-8?B?cmZEcWdZRVpBdVpqQTl1TVZlU1BLODJzcVN1UXFWNFMvQkdyMklhTW5jMlBj?=
 =?utf-8?B?dUY4WG1JU0JzTzZyQXNUR2s3eTh5cUM3VVBrNkJ5amJpSG1McWdTR0h3aTFp?=
 =?utf-8?B?NzlTM1dmM2RreDZrRE5YcUlKVUhrRHJYaWQwcTdxZGJsUkhyWTBHd0J1NGxq?=
 =?utf-8?B?b1k4SVoxTVJMSmsyWmV3WlNUaGE4NkVhTk91UThaQ2pYcjFocFlUdkhJamtu?=
 =?utf-8?B?TWlKanFDQTdNUVFpVkZTMG95aDdWSm5aQzJIVFVUcWtpZGpGY1dxSzd5NjVL?=
 =?utf-8?B?eHJ4enRscnJPRmFhbGFLV3BVYmhVZE9UOFZzNDREc3lPUXJpMlVyeUcxa0hR?=
 =?utf-8?B?UTg1ODZieGwwOWxvT1pLbEZ0eFJUbWFqeElXaGFvUGg1RlJKVnFxTzJEdk5C?=
 =?utf-8?B?cnQ5OHBxcnduanFNNmkyZC9QSzFGR21TRXY5ZVZGZ2hla2Q5b1BmY2lhNlhV?=
 =?utf-8?B?dWlvQXVVOUlYZWxIdkdWRjBwNnlWVHNpUGxyVU1peEs3UytsMmNRMmVwbCs2?=
 =?utf-8?B?engyRUQ4bStkZU5odDBGNi82L3Y1Ui9WT1huV0dyeDF4TFo0YTkwQm0xek9H?=
 =?utf-8?B?cFR6bFc5SFNxU1JOMDIvbGJIVFRSejg5SU81N2JxdWtxTlVoVmdjUCtpcEtq?=
 =?utf-8?B?ZUxCUnNDL3dqcUFyOGIvbnBCTDhhRlRITkRLQjZxbEZMeU8yditjR1U4WGQw?=
 =?utf-8?B?N3UwYnoyd2JUenpuVXZ1Y2dDSEpQcTJveTUwZlBkUXBobDM4L3FHUi9pTnh5?=
 =?utf-8?B?a3JkTXFELzI1OGVtcE5sNkFwblNWcDlkS2JxaFNHeVNsSGMrYkt6emlYa3lZ?=
 =?utf-8?B?bFArRmVScVNoY3NPWWNTTTZNMlRjMjZGQzlrMDExaXNPdmVtVnN6Qy9YaytC?=
 =?utf-8?B?ZW1rcmVVT01VS1d0V3UrRHM1a0hHTnlRK01BSkxKall2SmQ5TWlFSjVTRFhR?=
 =?utf-8?B?Q0piazdONytlSGc3QW1hbDRtSWxLOTlGSTU5ZFlXa0MrRmlydzdmM0g5cThC?=
 =?utf-8?B?dE9QaTdWNWpFWUtva3ZZME04MW01eWMxMzR5WGFxNVgrK01tT2ZkSlplWnpW?=
 =?utf-8?B?UzRJbmZET2ZuTlpHbXRkZmt1dzUvUjRxUkR3cmltcldpclkvQUFHVTl3M3VQ?=
 =?utf-8?B?b2pjZ0hVSzBza0ZCc2puSHBmR3d4U1Rmc2FscHRRUEZscUxYTWxtNHdEZ2xK?=
 =?utf-8?B?R2U2eXRQL0tubWRQYUlEOWV2eVV4RVJ4emJQTjhzZ1dBcXM0YndDWXRISTRQ?=
 =?utf-8?B?R2VWajBkbjBQQ2swQ2M5cW9xR1U2Q1A2SmZmczcvaE5OQWREblJzQ05ubldy?=
 =?utf-8?B?TWhZS0VMQmFOY1hyOUpxcnRWd1hlRVVvSUtORzJXRTM5eHlxK0xaVTV4VlZE?=
 =?utf-8?B?L1Vwd0VZZkpqODZyV0NtN2pwMWQycXlESjJsZi9aS09sWGp3QllxdUJvUFRQ?=
 =?utf-8?B?ZGVvVk1WWHhVaXlMTXpZMmJ2NTJSUFRwTHoreGhpQ1lCUEJPcVFHbUdWU3ls?=
 =?utf-8?B?aGhzVUZyS1ZOUnMwZlFPbXhkVTZjZGdSUGF4MEFaU1U4YXVzdXNzR0s3bGsy?=
 =?utf-8?B?N29peU9rQjI3VHBVYklVa2lQalMybXBKNFFiMUxxY25zWTVUVlVXUVorK2FY?=
 =?utf-8?B?Y3RvYmEyczJzc1FEcHZRRG4zOFBwdUlKK3BhTVF0blRZZ003Rlc4MGVQYUtZ?=
 =?utf-8?B?a2QzOG9SemhoOGU3RVhOQXhFNExWcnY1SnhXZkhwVnNTQUpabU9LRFNOWExH?=
 =?utf-8?B?WExiTHYxREtKdlJVNTE0djdQUVVUbFBIM1BqNDRsRHpZQ0VjNW9hRHJqS1Jx?=
 =?utf-8?B?MHRROEd4Q2kxRHJvU1dlL0pjOTd5N2MxeW5HR21YanYzTHFpV0QyQ3ZRR1pu?=
 =?utf-8?B?KzZlWVpsQVRrWlo1WkZWalhJSEN0bkFSN3FaQ3BpU0VlTm02N1p1cE8zVUQz?=
 =?utf-8?Q?n6fSWlQxN5XHPkpqdzqyb9q+y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44053930-43de-4423-e7f4-08dbb3fd5040
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:01:16.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+nMZG0HvD0HK8rhI2qiLc+EpVFRrnjErs51ZueK78I+yr3W85gmXFMhgxL2WIgV1o7gD2xrqFh1Omb7975mqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

For a domain has no working devices anymore, let's choose the deepest state
to enter to save power. e.g. driver probe failure.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 22cfa3020b18..1887eb1b3130 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -730,6 +730,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
+	/* Choose the deepest state if no devices using this domain */
+	if (!genpd->device_count)
+		genpd->state_idx = genpd->state_count - 1;
+
 	ret = _genpd_power_off(genpd, true);
 	if (ret) {
 		genpd->states[genpd->state_idx].rejected++;

-- 
2.37.1

