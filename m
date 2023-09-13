Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3869879DE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjIMCBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:01:11 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A401706;
        Tue, 12 Sep 2023 19:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxVyUrw6i7KauGZlHMjk0QEvkuYWRXeQC8sn0MogWHtCXLuEttZXMoOwRMkY21fI2RUm9g+rD8q64xJpkxY9jgvpWrnHZHubAxO6sy2iZDzGn9sc4eOkHEF2++7aBpLGvwEnsP7HSl5wTmZuxCrteA84fjQA3qT9y0VD2MQCAhjUDrCst8XfIKTWGX19SflIbaMZmjfoXz1FscMiBbtab2glIXYFR7dDR0XYih/x9sIoJ7vGTAU7Yk0gj4pwUD8GqNFJtF8kcRSFCUrf97qSMh+d2N9eCFiFlvvIshhUGyoLGDyDEnDt9/nIHBzRyrQazbvYZHacwRSAu17SVyDMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWjuKFTfEdYWUzxFSbWNb6xhprF8wwH9ENctrcmvEIU=;
 b=Nxetm4hVgNlwmB2Dij0yFT4eW6vrK3fO0Ay7KR5oxAT3NJI7hGXpg93upLninNn37xf4CTrCdXlsnWljTH+BLMVfvvdqzB/gQPC0NO8nb1zLRip7YISPsf+slU/AMVhX8Y4uDAd2IatLJZcnzt0ZxMCvUcTLhIOVyyLhtYqMofVuVzzqbfxxb0FejdS9UqlC9Z88IDCNz1Vj5yPq4NkDJVWUYCW3A+g03CrLYg2N0Dnin2pvntBLROGvP/rtO4STv/yWUqo3oC+hEkQKfeZ9jsZCb9ZlHihZO7TECEkw3+l8p5lLyIdXqcC4hKLXDRvX0mBhY5z8Mjna1jV9+yZiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWjuKFTfEdYWUzxFSbWNb6xhprF8wwH9ENctrcmvEIU=;
 b=ct54HBb3mNmsFNDsFUOsD9TGeu+tGVfroNyqc9OL8Vs3T9UZ5uyLNPGUQ32OglOXemee9OcoRfFfNePyBVS9qxEf/Dudv543QcwImFtg4gVRraid9E010blRV8nQIFhHKmv2LZ16bKdy7MjDCvkyApyvZQeLrDU1qR5tkutopg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 02:01:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:01:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] genpd: imx8: support multiple states
Date:   Wed, 13 Sep 2023 10:05:35 +0800
Message-Id: <20230913-multiple-state-scu-v1-0-9d91c6904ffa@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8YAWUC/x2MOQqAMBAAvyJbG0iyhcdXxCImqy54hBwiiH832
 AxMMfNApMAUoa8eCHRx5PMoouoK7GqOhQS74qClRtkpFHveEvuNREwmFdosWufsJLFBhxZK6AP
 NfP/TYXzfD5Aae65kAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694570750; l=1282;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6Y556uHPGzjmfHxV4SuQ3tyXxb2cqErceAhWD7B4cCU=;
 b=+3YJD4j8IxJtFA1MKJa8P1wHPr4JuMzGjaCWICYG9+ofTeh6xNj4z8AzMv89r6Sd6v48rPod5
 8L+H4BC/KQhDrdIA8Q5oY+x4u/dHMJdJ0ypASYAe2PIpEuUirxt/ZEh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe255d1-3ed6-4990-5b37-08dbb3fd465d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6erIUsaVmBBal79DZ/uoNCf8UgPoTl43N9QYYwhnYCpyYTOVehV24xwD0TTS1xxgp8HN8swl7P7iLRpQX2HLXYVG0CAdNw6tln1/UzJtbnVOYNLX4IWUvL5JHgsDpL2rkp5rUy6MtIeDYWE65ZOG1rwZg3fMjvQV6If5cizF5uQHgmPa/h/n1/wR8ydRTxjrtKcfQqrvIXgPsl3IdLiSPttDEwMhJeBDV+GahKrauTk3FQhErivXDSGlGQ/s9+1L4HlVKhs0TU2tgCdInBkpK2S1KiY2PJTUN5G8jFYqGPYRNnLb1j5rk5SmDG6/YhEUedAlNwVtEHJZnhZSrVPN34OzL04UJs1nW3vO8o08K0/AsLJWVONj1+JdKkpMby5a6qPNML/tPak79k13j94RPEL3Dl4hLakxJWEblux6XyQ5+Eiqk812K47mPqQcPRgeNwWuav8vgacECxeGxcqdC1dHLAQufig2/LPEJe6jbHfnJm7yrU3+aSM3KufY9LfEbLW9moWjR5783/cMmEpCvX6z3hQ5rb5a7RbaMbmwXFq+0RQG1QXswDCtHGNpuihx3VUi48Ik5MsdwcO/pWCF+kOWBHxNDQ1y+rQN2TFux/dW8rK5jGTZnNGdy46GzIb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(186009)(451199024)(1800799009)(9686003)(6512007)(7416002)(966005)(5660300002)(6666004)(52116002)(6486002)(6506007)(26005)(478600001)(2906002)(83380400001)(8936002)(8676002)(4326008)(66946007)(921005)(41300700001)(316002)(54906003)(110136005)(38100700002)(36756003)(38350700002)(86362001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJuVXRMZkpHcFJ1V2tPbkJVZUVVMXVIeGJ5bUpEVlU3djg2N3RQR2QzeHJh?=
 =?utf-8?B?d2V1MDVKbW1FbEp5SjZPQXZSVFA1YThub3NwRERQbVR1YWw0bWkwVkx5ZndM?=
 =?utf-8?B?L3N6R2s5Q2FRWSt0QVVpaGkwZTJDT1FVVS9kSEpGZW44Q29oaFJkSDlkem9k?=
 =?utf-8?B?R2oybTNvNlpkWlpmMG1ndmVVZTJSMEZLSG5kQVc1bmQ2QS8zb1pzOE1JK2lX?=
 =?utf-8?B?VHZUSmh4SjZjU21FRGZTU0ZOcVRKSHlsTTJ0ZXRDSThEMEQxM3l2clEvY3Ry?=
 =?utf-8?B?TzB3aFA0YjViY3dHS2lZWlRBZDVxUXJsUVZ1K1BLVlg4VkZXbmVENFlnTGZs?=
 =?utf-8?B?VFVTcUpHOG1wajFEaTNzajdzQmd4RG1nTjJLemNqOG00SnArdmZUdXA0SXJN?=
 =?utf-8?B?anVkaC9nQy9CTThocERNb3BBRWlWd3hpSTEyWWNCSDNWRU1zRkdGUUtyY3JT?=
 =?utf-8?B?dk1VYUFKQ2pZTUFEM3VWWUZCdGZUNDFSWDBFa1RRZmRtcFlzbHlyNzk4SWZU?=
 =?utf-8?B?ckRhUk5xY2tlN1F6VUdLekpzaDRpd0dieGY1U1V5VzY1UTFqTDlDajloeGl5?=
 =?utf-8?B?V2pYNGVLKzRBTEdtUE9aZ01rT2xNdFdHdnFRVk9kbzY0N2IxeVE1L2lCRUhj?=
 =?utf-8?B?bHdLNlpxSG15a2NtOVhLcFI4blloOVRXbWJrbmZ4a0p2bERHL1RUaVB2aWpi?=
 =?utf-8?B?REx6V09VZHBRR3lQUXZmbkFGY2hGdkpuWWxQQlRUajRhSThieVFYb2RFYzcy?=
 =?utf-8?B?SjNRbmNsc1lWT2hkbERaRzdNTDdwaWhXd3o2VklFMDJMU0c4cDR2cHNNSnBS?=
 =?utf-8?B?SUUrNlBNTWNOYkg5VVBUbTdtRjlOUjZZQWFCaDVINlgwbm9HSnkvblhjRmVx?=
 =?utf-8?B?elV3TzhWSkszcVFmUlhJTTB6clcxYVA3WEcrZnNNSDYycGRhei9LbWNqUjIx?=
 =?utf-8?B?VFRBK3RLM0tjZEdtNzhuajNUUlMzOEFTZVlPZmNBeHVaZHkyRTBEM1kvMmda?=
 =?utf-8?B?S1RLZklLRnl3eUxKdUludCsvZEM2MGZ5T2RCanNDTU0zKytDU2h0bnEyR1Ar?=
 =?utf-8?B?TE1qdStIN2QrTUZYSkpxcmVGbjdDYUpvZ1E4dE1pWWVxVTY3L044S2VxQXRJ?=
 =?utf-8?B?N0lJN1pQeS9semUwNG8rTVI0cUJOU3oxeC95eXpFYWtZSVhoRHJjemx3cXJW?=
 =?utf-8?B?OGdwdzg1enFDVS9LYm53YVBuY1VqM2wvUjRWSG5HcDNnYjRqTEtDUlBtNm5z?=
 =?utf-8?B?Uzk1ZWZkdmxYczdUKzVmRkQzVTV0R2xQSUhJV0wxTGNOR1NjQ3ZqNzkwZmVk?=
 =?utf-8?B?NVQzRjZaRXRCU0dUd0lTYWxSLzZINFNLVzZodmo1N054S3JFMHVIV2NMOHNq?=
 =?utf-8?B?Wi8yS2xFNU9jb01iazNXZE5CdmJQMDUweFJydlpUdDdUemZaSktKSG9ibjdx?=
 =?utf-8?B?STlZcEx5NDlOM1JpMTNPQjJjZytYOE1yTERyb0ozRExWbTVkSnE0NStjYjR0?=
 =?utf-8?B?MDRnL0hBMWk3amVyRXd1RUxUa0JKTm83OTdtN0U3ckJHQU1JZXR0M1JwcGpz?=
 =?utf-8?B?OEFac0txRlgyYzlmeThVZ0VUR3BaUHd5djdZR1hsVitJdk5KTDJJMFVsSkFt?=
 =?utf-8?B?MHdqU2JJeVVVSjlWUS9uRGhzWDd4bFBSK1ZiN3hyUVdlQmhhZDNTSy91dWpq?=
 =?utf-8?B?UVhjcmRPbDZWaEVBQVJIV01pOXNFWXhuSzRhamhOYy9jeU1meXpKWlRjNTN3?=
 =?utf-8?B?OHJZR2ovK253NmtDdkpsOWFvQWhkeU1NWWo4MlhHenNaNHRTSVB5K2hQUERK?=
 =?utf-8?B?UGJTQ0JKenBaUnNGVmgyc0kyeHowTWtyRUh4NVc5Y1RNcUhaZ2Fjb014THNG?=
 =?utf-8?B?UXFLTzViSTBkSWMyeHlTaWg2bnFqUjZDMGZRNHFRbkl6VThSQUxwNzd3a1hT?=
 =?utf-8?B?TEUwZ2FtenlhTmZxTXdEUkxLL1NnNkJaQ3NLNmNkbXRFUnNKTXlFZU4wL1RM?=
 =?utf-8?B?QzhEKzhLMmdLWEcvY09KS0lNYWNCWUNvalpyZ1lmQWh1aXpKdWF2d1B0VU9k?=
 =?utf-8?B?a1F4RlpPRytGeTdtYmczV3VJeE9ZcWkrb2ZUeXQ2dk1GeEhPeC85RUxOdkhy?=
 =?utf-8?Q?hHOdfcvCA3GF0VFwaaom6FSrp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe255d1-3ed6-4990-5b37-08dbb3fd465d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:01:00.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVrjv2AYHTv5HEl84JzUprT4YK+gO22fW8oG8O6n1flTbgLOKv6ekmzqsoWB7wZRCUmXjBrf3zMbfh02Hl6RTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 & 2 are for common code.
Patch 3 is almost same as https://lore.kernel.org/all/20230814104127.1929-8-peng.fan@oss.nxp.com/
For patch 3, I thought of using QoS constraint in the clk-scu driver,
but the clk-scu not support runtime pm, and using simple_qos_governer
would introduce complexity for current SCU Power domain, and the SCU
power domain not only used by clk-scu, but also used by other devices.
So keep current design as NXP downstream which has passed several
rounds LTS releases.

Patch 1&2 has been in NXP LTS for quite some time and pass through
several releases. patch 3 is an update of NXP downstream patch.

---
Dong Aisheng (2):
      PM / Domains: Support enter deepest state for multiple states domains
      PM / Domains: Choose the deepest state to enter if no devices using it

Peng Fan (1):
      genpd: imx: scu-pd: add multi states support

 drivers/base/power/domain.c | 22 +++++++++++++++++++++-
 drivers/genpd/imx/scu-pd.c  | 42 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  1 +
 3 files changed, 62 insertions(+), 3 deletions(-)
---
base-commit: 3c13c772fc233a10342c8e1605ff0855dfdf0c89
change-id: 20230913-multiple-state-scu-8ddcb0373d3c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

