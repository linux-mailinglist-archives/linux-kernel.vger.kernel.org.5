Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB28579DE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbjIMCBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbjIMCBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:01:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C181706;
        Tue, 12 Sep 2023 19:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1SAju/jrQkvjYEDffv0FVKoqUl1T26rPbqzTqtO6ZrAdjdTOzXboaFg8gKhBYligXQrtpzQjhGNv9tQAm1xq0SwbfSm0VC0CyoS5JPmL69EUtndLUzpSeHgTQ9HeavEWQz8tny/9IiN8AlTsVbfA2KJCGTQTEOO6z7w9OaM9+M0fo1eu3RZdPIbatdc9JGsKGpE84mFpIX96nugTTEsAOcGfUywHsMiKTSTp/lPrB069f2MbAhKalDsBvH2mQFupeznRCK8B39zX1fKbvKPRhVqodB2MsbV1IDwgTIKBGSfd8H8M66sgwmWWv1NKWGkRUfVf8uBHXwlgPE3NZFnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CphTRmQFp4aKG1R6ujHLI+fgirNZKeqT8MlKcLFtWE=;
 b=UIRTA0qEkMc0wYXHSsOtrpBmUmLhMsZUeq7Qnj/n3U+pzFF20xCwwohpvfDKfJOBlH8FLUe3Pl+RjoOQ0SiPLi2CtXIiqOmhZa4EzF13VpAPsumRvzsInBFGlft9LWk7bPmz1VoJPufaekJ1ttDC9b+XGMJGJbgOAdI44u/F1nE+KGmNKD17/uBKHwx6zfxumkMg0K9snyNZjCSl3x9QpO4UUPJ/9/oyuUTpMswiEo2BSDmyWh+NP9akQ9Ohhk3Q63nigxUon6e4fZzzwDebr13D5DmdROGYQxPMVCH8Wl2hTMFQKBozzj4Jr4fva6scXRp0iyoNKYgCzVSyDbS2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CphTRmQFp4aKG1R6ujHLI+fgirNZKeqT8MlKcLFtWE=;
 b=EBxKJmUrSfmUiXXko7IjW9RnFq3ylLfW+pbb4qyviC7DnATxMUkIHytk0XoQLcfVnNFS3K2dAKa3uYK59C+3NrZWUj4dhBQhqTkdlmqJAlfzE6ImdGgw7vmNmKZrH4mgg5cS43Pl148mIllZbzeQB+88Oes74FevqGyZCuFesIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 02:01:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:01:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Wed, 13 Sep 2023 10:05:36 +0800
Subject: [PATCH 1/3] PM / Domains: Support enter deepest state for multiple
 states domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-multiple-state-scu-v1-1-9d91c6904ffa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694570751; l=2848;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WzVpFHVCTbI8zhHb0izO8j6+hEmyN9JYHoZIs2nN/00=;
 b=x5MB0kWQ+YlcRxwsvZKSgszc3sxU43xTKgNHYIqa2Qd+X1abSo1zjvXi84fnR87XcfTLtL7zF
 5pIJ+jVPPWrBmMDHDznqPVnlbo5lUIu9oJbeHQ5T6ATqEr8wsFpkmn7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e91393e-1fa2-4cb1-4932-08dbb3fd4c23
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pCkJXy1V3cjkeC/UI9vwlWFveOiHWxHNz9qegFHluc4rXomXp9iLDVkRKZ40CJVBvagZ0OdeFJawLbOpaTP4caicOo2MnfpSA9o1MyO4XXXNx12fTaDFP0wuPdR/BCIHW2qvABkDjNGvU3RJUUAjm/brnYNLG3ZGgxFStbgysHewmwwO23KBHuEDf9tCJnZkAj6UcUUGu6sPBe5yT4yZIkF7hgsIeraXCbtg8LSg20nD2A55Sp4cvPWWOcYW/qPlexn7Z0cohdZGzBb495C9Y925lffEdBudjdKLqLTfUJLWI5fkd0doIyhSY3cdOJ14wbaAqKTBuV7VqGMRiLaZ1n0+oe1k/UULycJoJ/8vMzmrRid9NZ37QMVfn5kWNy3KhqbkZm2zHeBJWei/y/sxTxZodU8hEL/RgQtnh4UQxdhEoqd1O2wqLspFyhAz23YnB0wa74e058f1gyE6xKmqE3emorBnchepWOEEyIZ+U60kZGQh77qVQ9qPcBet1KMxu1yhdd4XokU+tgUNS/YCq3wbNxyPnfRDbWuZP8p5WAFOwfLU+3t79AAfB3PkGgHja+qIszLDJMdy2TGJHT+LofSX2FhsIC1Q1xiJAspTYLOEIyvIh4P3tgpw18doug7ur0/ThfgGsRafGHnD+2Yow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(186009)(451199024)(1800799009)(9686003)(6512007)(7416002)(5660300002)(6666004)(52116002)(6486002)(6506007)(26005)(478600001)(2906002)(83380400001)(8936002)(8676002)(4326008)(66946007)(921005)(41300700001)(316002)(54906003)(110136005)(38100700002)(36756003)(38350700002)(86362001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRONGlOd1NwV2J6L3UvYjE1Uk5HWFVKUnhWaDFQVE4rU0VDcGlQTmxSdFR2?=
 =?utf-8?B?RndaQmU3bzVIZ2IzSEpHZjRqNjl3MW9LS1kxRGZSVW5FSG9YRzlLWEtDU2lH?=
 =?utf-8?B?Ry96d0JRcEU5akMyRVVWeUhHRWViOS9xMVFZV2RLSWlXQnRSbnh2THNoZm9q?=
 =?utf-8?B?dzhTMGJZdVF2QW9Mc1BFN2h3WVdzRW5xanNCbmhsNm5WVGhjakptQy8zcTRE?=
 =?utf-8?B?UnM3azdUWWR2eDhER1lzS3IzWU4vVW1NQkRWVjk1UzYzdzVJTGt3SmF2Tkcv?=
 =?utf-8?B?MTh6TytBTHBwYnB2YVVuRk5SSzl6RFRoRzViM2hBTFpHYXc3QWl0RFpXdzk1?=
 =?utf-8?B?ejM2WGtBaDhiQndUSW5DZFRxeDZSeXRweitDaDJiODN4L1dxc3pMNWJRVVVi?=
 =?utf-8?B?Mjl4V213T3lBUXRzYmZYSnJzKzVjK3B4ZzNJbEk2a1ZrNzFuM1RLWWZEL09y?=
 =?utf-8?B?VlI0TFhvcXhMQmRvWnpUZ1NBbUk1bm1hQVRvbklKcDZHRU9LMTh6bXZiVGxj?=
 =?utf-8?B?R3pLN2p4TUhzQ0VMWmZKbkwxVXRUbEhhZ1locmhXR1NocVN2NFlvSmFIbGJs?=
 =?utf-8?B?TWZmN0pnczJuR0ZwRi9WT2NwZTMyOWd4UDV4QzNRbSsvQmgzalcrQkMyK09p?=
 =?utf-8?B?enZqaUNzZXZsWGJTMXVaYkxGT3hnWUJXZUZxSDZrbEUvZGVEVzdOT3djaXBW?=
 =?utf-8?B?UDJ0NlBLczRXKytFOXFpejQ4Zkp3TEhZTDNsT21LelZ0elo5UmpsTHQ0SmNS?=
 =?utf-8?B?TWExMmEvQ2t2Vm0yK2dzbEJVdkttclNlNVVSSG1MTXpaRWRjYnlMQkpMU1Zw?=
 =?utf-8?B?RWRsZVc0N0prTy9ta3YzdHEwUFJ0cnVIQmRIQUR5OHlSMmtzcWVWVTA4Y2h4?=
 =?utf-8?B?dEJPcUlURjF6SXhqelcvRnlEejNSSk9OWlZjL0VuMWpocWpWZmxvS0Y2bllD?=
 =?utf-8?B?Y2tQRFJ2Snp2aVlJS3Z0VDZaQ1dBMS9NMWhvR0hRMXRGbHk5WlVudFNYS3Zo?=
 =?utf-8?B?cENMcWFPTnZDRjBtQ1d5QU9qclB1M3JIZlI3SnhkRlR5M3F5WFdabmova2x0?=
 =?utf-8?B?TGNETHdVRzRtYk56YlpnS1pHb2J2K3BGbkZmZkJrd052UVZwV1pybXNTRy9w?=
 =?utf-8?B?UzJlOWxzalcxUDJYbEpJLzRKOFY2NVRGNzduejgxbjBQSGZmTVMwMUo2di9E?=
 =?utf-8?B?dnBsVVEwR0VybFIxUnJodlMrT1FCbmhqckp1SFJHWVpqaWIvTDJlVW8xN05U?=
 =?utf-8?B?Y1JkRTVMVVZCem11VnQ2S2RlWmdtenpUOHVZclhZcTBCb0hIRTBYaGFEQnRl?=
 =?utf-8?B?azBOVTBPSm9mU0tLTGhjMTF0TlcvczN5M3pKWk9DS0UvLzZxa2J4Z2YwV3h6?=
 =?utf-8?B?VjRZcTdvZzJVaFFZT2tMUUVwL2lQUm9SWmlNS2x5d3dnOTVRdVBQYTJDQnAw?=
 =?utf-8?B?SlU1ODhxUXFFM0lnS0JYeHlMbWdmUUtyV082WHRBUXlleGRGVVJOcXpidm56?=
 =?utf-8?B?Vm1EY3BxRGhsK0YwdWlGVWpheDNhR0ZLenQ2MWROZTI3ZzR2ZHhNdm1OYnRu?=
 =?utf-8?B?a2V2M2QxcWMxWUJ6dHRjVXpON1lpT1hubWRDMjJGakpiWTd4OXBCUC9lemlK?=
 =?utf-8?B?b1NWVUJ6cStBTVIwMHY4b2I0Tnh5Q3d0YTFNZ0FiVnVJNVU0K0J0ZldMNkln?=
 =?utf-8?B?LzRwZVBkR0Z0WW9yeGR2YS9sbzFiSmU0Y1JiSTY4d0htM241OWpJSWZzYXR5?=
 =?utf-8?B?Vm5iOHJ4eDV6TDNaVzQzMVBOMGx0UW1KaTgvLytaWXZRbkVydThLZytJc2Q2?=
 =?utf-8?B?NjNqYkZuZHFXeGFFU0JBZkxwZmRSZWtVYzlra1VjajRDczNkeCt2MFlRanJp?=
 =?utf-8?B?dktmZ0xCU1lQTDdYVG5iL2V6Z0phc1hZNWFwWkNGdVhoSDBEdHpZb2x4RzE5?=
 =?utf-8?B?SWpidVhIV2thSmgzTWNDVWQvTWJVNEhKK3lCTSt0YjlERHBMazdWWUdMQjFq?=
 =?utf-8?B?cmsrSlAyb08vTlBMTWZza21YTFE2dGNhM2lPWEs5T2NjWlE0cVFSbmlQMlhq?=
 =?utf-8?B?eGQxLzQ5OFlVUEFvWncxMWxIbndzZW45TFEyZC9HbGtodERZMW1Wb0JtNjNn?=
 =?utf-8?Q?JnRryrHZUzQNGlmFbMRHVRXWw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e91393e-1fa2-4cb1-4932-08dbb3fd4c23
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:01:10.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggCCo251r+V5bjg8O79a9aQAABb7kEbfnaDWFNm1hmPWAYpxGfpKqJWJ8w/c1d3yISU7hU6MGq6dEh7AblB/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Currently the generic power domain will power off the domain if all
devices in it have been stopped during system suspend.

It is done by checking if the domain is active in genpd_sync_power_off,
then disable it. However, for power domains supporting multiple low power
states, it may have already entered an intermediate low power state by
runtime PM before system suspend and the status is already
GPD_STATE_POWER_OFF which results in then the power domain stay at an
intermediate low power state during system suspend.
Then genpd_sync_power_off will keep it at the low power state instead
of completely gate off it.

Let's give the power domain a chance to switch to the deepest state in
case it's already off but in an intermediate low power state.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/domain.c | 18 +++++++++++++++++-
 include/linux/pm_domain.h   |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5cb2023581d4..22cfa3020b18 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1124,7 +1124,17 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
+	/*
+	 * Give the power domain a chance to switch to the deepest state in
+	 * case it's already off but in an intermediate low power state.
+	 */
+	genpd->state_idx_saved = genpd->state_idx;
+
+	if (genpd_is_always_on(genpd))
+		return;
+
+	if (!genpd_status_on(genpd) &&
+	    genpd->state_idx == (genpd->state_count - 1))
 		return;
 
 	if (genpd->suspended_count != genpd->device_count
@@ -1143,6 +1153,9 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	if (_genpd_power_off(genpd, false))
 		return;
 
+	if (genpd->status == GENPD_STATE_OFF)
+		return;
+
 	genpd->status = GENPD_STATE_OFF;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
@@ -1189,6 +1202,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 	}
 
 	_genpd_power_on(genpd, false);
+	/* restore save power domain state after resume */
+	genpd->state_idx = genpd->state_idx_saved;
+
 	genpd->status = GENPD_STATE_ON;
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..bbd08115a1fc 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -167,6 +167,7 @@ struct generic_pm_domain {
 		};
 	};
 
+	unsigned int state_idx_saved; /* saved power state for recovery after system suspend/resume */
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)

-- 
2.37.1

