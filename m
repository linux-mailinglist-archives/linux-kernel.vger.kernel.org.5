Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9379FCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjINHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjINHHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:07:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E6CCD;
        Thu, 14 Sep 2023 00:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7DCU0x+6xsbe80mT+8mxxowmrzNN2B9talozuZ/VdVGHzwBsFGFEzbJYzEn0BhjSKUNWCxvfR41c48TQxtoXY/IArDsW2GEsu7yaKPmdDCbPPEiPjb4zx62IHMGxVyiO9ZuWfceMZ8mfpDzGx5jCJ4O9xSQ3d2dg/jR5hVo0w1MqXwaGgnC8bJiZkXGDo08tuJur5vPpUZSNIuPxwVAG0cs29VjdGKMe6ftujf00Tye8333mKacUbUByZwvY/BaVw8tdgHhJkzu4klXN4jZsgNCw6wuTj4ciVj+P3GUrtQf2+okdQB0bsv1liXRMGm28Om7xj6eeAsmi/9ocfQ3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmJtPY66NZ3AHlMgdGR6PTUFBSipakcJJGOTc2pSdOc=;
 b=iGBP63KiSgeDuYT/TYUX9mn2hirzFOtns69GzQPVELQ0GE9r/2PWmK0aYHyzD39qJtPjaipdAgUJDAWrPE0rcZWd/D7r4sEQZ0xL0gxanTVPSRDnTF808h3K7YOJCXSNzMF10dr0cfQomp/jUaRnJbAhTjEpXDvorLPvebDhJHc7YSZ6iJmfRzaQjRnZH0okTFNwWSKND0V6VScdAfz0chFdXKJ5erK8M3jGzT1QrVvttVGFvLUM2ii6wfyUHVeMlS839TZrNVvC+eC15g8JiG6rzgJ7W3fx4IjWgIUXBvZsT+62gQwg0mMLbWOr4fLI6Nqop5pkazLBNfKdgjyd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmJtPY66NZ3AHlMgdGR6PTUFBSipakcJJGOTc2pSdOc=;
 b=Bez8lELlIDcZic3AdnrAQb4DmTwm004B5iNdBDIDi8w6UjIH/m4ITQbX8UMaGhONBYG/0Oj/g+pZTjV7afEX2l4anK3jAXnymj+tus74E2937zcEBbazVecmDJyPcuJt63Gw3qt0PWj3CtSHZAAd/QOp08vaS0DHdFt+cChwiN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:07:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:07:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] firmware: arm_scmi: clock: support parents commands
Date:   Thu, 14 Sep 2023 15:12:10 +0800
Message-Id: <20230914-scmi-clock-v1-0-bf8edfb0546e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqyAmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0MT3eLk3Ezd5Jz85GxdU6NkIwPTlERLM0MzJaCGgqLUtMwKsGHRsbW
 1AB2yFyBcAAAA
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694675547; l=815;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=c0iAWynEmqdmSj7ZWEjpponf8J4WbzbDh3t0TNzBlmU=;
 b=QH46KVYoOSJxe/gGy2S+g3n96Tw7Ew3mdoJ3luc2B/yvounlJq9Jd7Zhn64ChsTcHCXxHwiaO
 TDGRUYMLbxGAFqgZwHXgyIK5JffW5fG7k4P2W1ccFH3oZNEFKUTaXNu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: b18f622b-dc1e-40a9-d2b4-08dbb4f14518
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDB7qhce7a1eGB7MOOKKTXjZHY8D//g313AFgdPBecrbIrGTHYdGOZwt5LKmH4dmK3rfy49wFvFieU1PJOU/ZHOh2mQem7kJ6u8LyrC3h9S+A78JjDNVvRfQVC2BSupF/tdlqA9gR2LaxGlqvavDwlmwc9yzY4zGIjQ1nOKhaqe/xQ+8JhOfcUFE0LVPEbOovYInmJJ+j6tKDGCG3WF35YbfNAwd8kFEPhW1ZI5MkSbPDYGTOliVAIJ2V7eIAoes84uBjZ+eYTLmThkwyR4nBz8ZgAeUiy88Dhe/qo/VccSBYh0HE4InMZXzJFLWX0k9kLihtMuV10ueE/UwjXFex9m9mYlE5928w53mQhYjkZdFLLMleyi72mRH6pVrW5M+IT5R54+tlkDZ3oJT81Q+6n7gLivjdRa7J/zvTZkrz36SKA5UPtGByJz+tr6xdXAt5nqrOWG58XVi0oZrMAQ3YFTuv0sW93WkyFVhnssCEcVmlmDakJ7+gYwMkm72vgRAp4sXnfxZc1RxaT5nkF2RhIv/AN/SqwieiUwC8OoCwyylU53vPAljmQ9LKHuK6PVPPGw+/pUXwesbsPcg4ShJEDknJYU1aThLtWE4kw9LIo8ZkVH+42XI2mxg01AUPSJX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(316002)(54906003)(110136005)(66556008)(66946007)(66476007)(41300700001)(478600001)(38100700002)(38350700002)(4744005)(86362001)(36756003)(2906002)(5660300002)(8936002)(8676002)(26005)(4326008)(83380400001)(6666004)(6506007)(6512007)(9686003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWszV0NBYnl0QTJCSUZubCt4QS9wc2VSK0lhd1Vrd1E3NloxOTBSMmRxTm4y?=
 =?utf-8?B?UW5WOHE0MWhZcVZqQlp3cDV1Q0YyMEJLY0VNeFhIekk5a1I1VVhETUVLUU9y?=
 =?utf-8?B?VC9QREpCNVloSjFoSXk3SlBaM3RZNnhEK1QyQW5YQ2lVeFlzZmJLRjlvQXc4?=
 =?utf-8?B?RWppQTYxWDdFL3lQNkRMZWRsOXhCSkQraTZTR3JFeVJFRTBycWtQVE9FMFZU?=
 =?utf-8?B?TGUzV2U2SzRRcG1BVkJCZDlQMG9QN2hqTDFkdm5ZcDcyZEpFMmcvV3JRcFJI?=
 =?utf-8?B?T1FWSm45eGRXRkE5WkVmYTMvU21GcmwzQUdqeWJybzRobVVicDB6MjZNTHlq?=
 =?utf-8?B?YUFBYUhBVzRCdTNCbWRyNjRkUTRwL1h6V2lDeFZZOTJaVUhaVEFKM2thWSsv?=
 =?utf-8?B?RVBMVGtGMy9TVlZZeDdlWi9XUXlNc3VaZm05djFDWjJ4dWNObDVyRmtrSlZx?=
 =?utf-8?B?eTFrblpZcTZ6b1oyVEx4V3czK3dvSytXRXAxRW1QbWNwQldUTnFrNm43dTVK?=
 =?utf-8?B?QlVqK0J5dWRWQXNQQ0xQY1lMZkZRWVlsRWlpYW9CL0xMWlRnUWRjMkdFNnNY?=
 =?utf-8?B?QnVrU2Y5OWFqZ3lWOWZuL01zOThhc0VobmU1L0ltU1BZRSt2OFliaHEyTzJ5?=
 =?utf-8?B?aW51REFLSWtyQWJleWJaM3EwT2tLQjNJUkQyLzNKMUN5RXFzWDlaZ3N2ZmZ4?=
 =?utf-8?B?SlZRV1A2Y1QxSWVhWDJZS1FrbG1HNGwySXZUYlg4UnR4bytnV0NTSGhHOGxt?=
 =?utf-8?B?T1pWK1ByVlNhQlFrdkZyWWpBbHlEWVUwcUowWHNDZXo1ZmpFT3BWMHAvaVo4?=
 =?utf-8?B?QnFMNnhMOWQ2SGlXakhvN0VGR3NyUXo4SSs4ejZKQ3dsTmZBcGd1SDQxUGVR?=
 =?utf-8?B?bkZWWHY3Q0hpOWUxS1I1MldELzN4TG1KbWdIcy9UWmVrQ3V6STFqTGczc3RK?=
 =?utf-8?B?aTlKOGIxdG5nUUVkZDNTODJiZ1dWcnNHRitzcUdQeGJncEdIM01ZYXBJNUdF?=
 =?utf-8?B?Y1p3U1p5Z2lUT0pPQmZZUmlQM09IeGtFUWtxaW9VWVVIOGlZQzZMQnMwQXBj?=
 =?utf-8?B?Z2xzV21TR2FqWkx5V2ZabEhZUnlrZk1SRVZid0NaN0dvYkY5WTRMeXAzNlUr?=
 =?utf-8?B?ZTMrQjZGOXZtQldpbzZEQWxyNWlxYm5ZNHZtck9TbE1BN3JjWENhbm1XNS9K?=
 =?utf-8?B?eGZSMURVWFVMWHVhVkNKQlkzYXhoTGJZamtpVXgxUFBzQWFBMVl6S3JwUk9R?=
 =?utf-8?B?UDd5UCtQNG1FaUZ3Umgrb2tNd3Q3NnI2bDFYdWEzUURpTDJZYllXVDJ5c3p3?=
 =?utf-8?B?ZWMwc3V5MENTZFVDUEdFbWNaV2E2VzgxNG5WakZrWDE2WDBObnE2bkh5MXRW?=
 =?utf-8?B?VUlyVmJCbTZRbm12UjBSOTUveVhBSEhLUXpsWTBFeGI5S045dHBYY1ZOVFNZ?=
 =?utf-8?B?emYzK3VUbVNpdFZkTzMwY1hkaHNtbVJMc2VmZ3RwMHl0KzAwWjhKTGwzcnhw?=
 =?utf-8?B?dFVNMW9JdTloZlVvdnJjVzRSZmNhWGR2czFOc3hGakwrU2JHaG5jS1gra1Vs?=
 =?utf-8?B?RUVHV1lEQnBUaDIrNHRtaDR4aS9pV1poRTgwQWI2NEFNenEvTFJ6VURHS3pD?=
 =?utf-8?B?dmpwNXZvVEFlQytYQzBuUTRzZW5zMCs1QjczUzVlM3Z0ZU9DeGsyd1FxQXlS?=
 =?utf-8?B?alF3enpWQ0dMNkhCeTFqYUpxTVhJdWxyclpXeUJmTW9aTGRwaVRzRlI1UHZu?=
 =?utf-8?B?ZWtuc2VQNDliMVl2T3Q2bVV2SHMvbkMyeDZhRUJGZS9iUk8vM1grSitOQ1Rj?=
 =?utf-8?B?TjY2Y1VyNGo1UlZHVVhFMXRoa2N0Rng5bkNOS25nR25QZXpUelZveFdTVm95?=
 =?utf-8?B?anN1cm1KSTRMYW14eXhBY29qZ2hQcUlFMmRzRmx0WHdVemdSNFdmbHpsTk5i?=
 =?utf-8?B?dW9QbndnYVhsT1llQVdZNVVWaVYvNXJqNWcrZng3YURhVlcxVVc4U0FUMHJv?=
 =?utf-8?B?Vko3cHhvVU1Ga3ovdjMvb1lYM2J2eVdQL0hIWEpPdXZ0dnJzUFBRc3l2RTJI?=
 =?utf-8?B?TmNSbjloaXZrU05qSE0rc0NCOXlUSDhNRDBxQ3BKcUxNV2JHbVVzZkR6bWVJ?=
 =?utf-8?Q?gamZJg4ihxTOlhNYMTbfyyg1R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18f622b-dc1e-40a9-d2b4-08dbb4f14518
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:07:34.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rxa79qGzU0tJL/8AWU+yxtDL2ti13om4jGzlmh0lvKNhXU6DKxKAWFiDYxDj1URzl5WxZU8IckVoQsBw04DajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v3.2 spec adds parents commands, this patchset is to support them:
CLOCK_POSSIBLE_PARENTS_GET
CLOCK_PARENT_SET
CLOCK_PARENT_GET

Besides firmware api clock driver update, the clk_scmi driver also
updated to support set_parent and get_parent ops.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      firmware: arm_scmi: clock: support clock parents
      clk: scmi: add set/get_parent support

 drivers/clk/clk-scmi.c            |  39 +++++++++-
 drivers/firmware/arm_scmi/clock.c | 156 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   5 ++
 3 files changed, 193 insertions(+), 7 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230914-scmi-clock-52c205da9616

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

