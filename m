Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AC7A5BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjISIFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:05:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E98100;
        Tue, 19 Sep 2023 01:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXIAj2gD+9/f2GBaawqEmiSWIsjrC+LbrL5gYOfWYhwHRUKN6nQ0ujjxGQzJh306jwTpdlCHlh38JQXAPDnw9GVGbLuRNd0fvt4qOiLm0DqsfVSIH9muprdmhPbEjMGJoJgpjDGEWr5nGyqdFUU2bIEDOfkBotRJiPSGikpTpYG7IYQUu2ErmY4Z/niZM+wNnuwTFRNvvudmAhQmm5SY0wQ0d3X0RePXMzRg2MKwjj3VcrNqi1P8NcXO4gXTUjJXUhYBwz9LE66XLa3CHAs+LYO9d5qWuLLTem+HQM07Lu0is5Iyh7F7Pk4/ZWpxRPMLtNko+hJUVetgQ8oj2slOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxhEgIgyV3L2F30HYyOnJZyO7eYfNR81TlxUv0LrLkg=;
 b=S/3Srgz9buyKgncvTVSfxifLVT4/fHu2AzyWXX5uZ0vFKnZcI939HuZny+sDu/7HpKLaMdnVkH0aJXTC7H6tcoDITEUGFMNjvj9YSEdmxF6awtKzLDZhAZtQ6FCZbglXBfCNoORCSXWFZLUPWBxqZRg4yLhtysCzd2gVxmpO+Bwdl6bMb90qlV9scYwLYzdCFN3hh+WJfYFxrkbrsJrADdbx3YhBUVjzJGTgyHsT+qasWib2o0zLECekHrhy/kOgcCQkzkDU+oDIIjYjZBMiwNPuDwgx7i6dqfIPaMWZimD8G+66CFReiysswSql3q+2ZHvXL6wTbA3l0RrsSGiBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxhEgIgyV3L2F30HYyOnJZyO7eYfNR81TlxUv0LrLkg=;
 b=q6uliTaC6La/KIok26/PgXFlOaL/yIi3yh9HuyVI86NO+KC5VzlykcdyvzevpHcGnEJgeOdVTJz+ba4kKbcm2MR2mHnekx1FdFNUzrgcYtjaKMCilzgPd4xr4y5v0zEGh6q5HZISwxDKY3luioFrQHcOklT810WdzxLE3D0oIQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com (2603:10a6:5:39::26) by
 DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Tue, 19 Sep 2023 08:04:51 +0000
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::6444:e07a:e7f7:3923]) by DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::6444:e07a:e7f7:3923%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:04:51 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.yang_2@nxp.com
Subject: [PATCH] perf jevents: fix no member named 'entries' issue
Date:   Tue, 19 Sep 2023 16:09:29 +0800
Message-Id: <20230919080929.3807123-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To DB7PR04MB4505.eurprd04.prod.outlook.com
 (2603:10a6:5:39::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4505:EE_|DU0PR04MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: a4943999-db5e-44b1-29f1-08dbb8e71989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8AF1GM5al4yxZEN8gDEU2MHbJd7xbv9eq+3DpFJrIsCbbsRP2aol16nv37QkusMdVZsySpZUw4vhOmO9A96Z9qvxWwM8XGLwGUCuj6hizuULklOPK0xUp4n134P4ccjv+vdOYynw1S6Gz9cGHJAooVUOLqem592o9wWYxhBt/xSVoCmLpfdzOiEf/gWvcF90++6pQyUAPPJe3bLhd0eZ++HOChSxrF0t5OdQ6pG03ev8GVkra3PUciIq2FrT122z5a5EopK9jH8D/LHdUzRNK0l+U9+YKJS1nl9qZv82Xw5Pjd+4sKA8Jg1Kay8+mtH6jLTUw3/mP50Djm44qAQpvz5+xRmEJuEvJZDkGp+V6Zj3Mt5ps5PtjUKIcqvIAGW80TNJj0Re/zDIwYZqSiSAMJV3656SS/+iWCsLsGZc67Pvhhf3P9+Mf41WkJBcXjR6qauGxRm/HvT2NUnA2Qh7ikE1ITfTDywL2WOb3KtP1N7VjdjpKdectycpH9O727DAh+P2kJhNwQGPTCtqhqrRSpJm2Rst+MN8wARam+hhKl78TFIRblPFQTHUa5luHs2nALGpDnkpF3KKvtg5QFJpUCdTtyZT/csDoo7pBbrxKkl9WCI/84H/T5DU4zT5VfB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(186009)(1800799009)(6666004)(6486002)(52116002)(36756003)(6506007)(86362001)(38350700002)(38100700002)(2616005)(1076003)(26005)(2906002)(6512007)(478600001)(8676002)(83380400001)(5660300002)(4326008)(8936002)(41300700001)(66556008)(7416002)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGtIakdZbzBCZUVGNEFtTnBvZktCKzBvUkMrbDVwejI3NFRDY1Exd1llREJR?=
 =?utf-8?B?cmpqbkhCYjhOUytHbW5ZMmo5SzV3UnRrV2hFK0Z6YWpaWGg5Y24rUDBzMkZ0?=
 =?utf-8?B?WkhVamtKYmVDNnpUUVNJeUhQM3BOWUdQbTcwQ3FVR2FxN0lySU1rZUw5RmNV?=
 =?utf-8?B?bDh0eC85QUhtM1dOV0E2YUtnM1lPcFNJY1U2WXkzalR6Y3RiMUY2WVdyaUdX?=
 =?utf-8?B?Tzc5MllZTWxhV1dKTmljN1dTc0lSWDdJRUYraFF2RnZHMklabEVHWlQxNWRG?=
 =?utf-8?B?OFp3OFprQlJXRTNtRE5lYXpWOXRBcGs5SE9IeVlrdGRUNStYdjdLbmRlRnBL?=
 =?utf-8?B?Vy9BRnBpZW9pMU54MXRIM2tHb2tkSnFSZCtFdmIxNGk0YXc0dU00QUpXNmVF?=
 =?utf-8?B?ak15bDV6QkRvUHJ1Vnl5Wk9yZm41YmlaQlJWWGtEVWNuSDNuK2FSQk9pcjFq?=
 =?utf-8?B?QW5ldCtWbEZ6TXBxVlVjcGgxSVRMNGwxMDZ0WDVSbGdieXVEQnovVzRmOEhq?=
 =?utf-8?B?VmVFVGNYdXA0ZnAyNkRnTG8rNXhTNG9LUWNETGFhTGNtbWsvV0FnVk4wU1J3?=
 =?utf-8?B?UUtlcVVhYnBWWkJuUzBLcnd6cXJlOFd1WFZadFBsbFptdXBvMDVpMG04d3A5?=
 =?utf-8?B?UGo2K29FL2hFWnhVTmYwMVhwZGhHR0hRd29XRmNET3h0N1hVd0R5THBUWkVv?=
 =?utf-8?B?bFVmeXBNZVN1a0o5bmpLNXpxQ0JodjZKUUp1UllPR3J0b3BwVmQrS3crMDhX?=
 =?utf-8?B?N1RUQTVpWm9yU2lwM251dHNFbVR0Rnh5M3gzMEpxaUNLcGxJWlZDMU9HNnc4?=
 =?utf-8?B?dWIybERFMk5BVWFnWlpIZkdlK3dGMzJBbWhjZHhGYUI4L3VWQi84aGhBLzVK?=
 =?utf-8?B?dzBrWk5iaUI1cnZrTERTbzd6Mm1lOGJRRWNacmNNM3hRZDU4ZUZXQzZmR1Ba?=
 =?utf-8?B?V00yaEF4VzlmVy9wL3NDQTZaL1Z1cnVwaHNPN1kzZnhmNzM0dlN4eU5lOEVM?=
 =?utf-8?B?c2pzS2YvbGpsQ0xycDVncnp2L2daWk1hbzRqZlFvY3FUV2NPWnZVdW9FU0kw?=
 =?utf-8?B?blBsUjI5VUxwVHBERUUwTTNzbmhGQWFZa05iTVlJdTFraHRSbjBObHRLckhi?=
 =?utf-8?B?eWlBZmNuL3lwSSsyNWx1d2w3Mk9iUUR0NCsyblZOK2RsZFA2V3I1czZ3Rlht?=
 =?utf-8?B?NWNUc3ZqeDVjSy9mZ2ZKSkJLQTRaS0lxY3pKd2QxR2Y0MmVxbE1mTkI1YjEw?=
 =?utf-8?B?N2RXTWxOWndDRXptcWFpQUYxREN0VERybXJ3NVNwVUdwVEp1M3kwUUNmRXlX?=
 =?utf-8?B?UzloUHpxTnZZNGFoQklXT0xNRU04TUFWaFQwRUZ6N05pNnNzcHVzVEF1NFVB?=
 =?utf-8?B?T0w3eVZ0djVwUjArV1k2Mmc5ZnIwajhLMGRxcVBrMFJxTktQeUgyZklMNml1?=
 =?utf-8?B?OTJJTUM0L0J4YU9ndmJRbmdJWERwTUtQZWFyK0NFemI3Z2plVzU3cGlwZmlz?=
 =?utf-8?B?MDMzOVBuU0g3RGFzN2c4cEVxT2RwMkdLUmh2VXNKQUM5cElXRWtIcU5YY0RB?=
 =?utf-8?B?S05HTVlvZS9JYnROR2wzcHhuamtweHlteXFNeENEeUhVcXpkVi9EVjNmYWFW?=
 =?utf-8?B?NlNVSTFXNm1ZbUhVRjhLV0cxNy9BT2k2L3J1NVdXNzNGbDM1N21CMVJZTlNn?=
 =?utf-8?B?N1MwMTVEdS9oVW1vN2VBUjhnNndOOTBwOTBSSUVpRkhXS3AySHpxTTlGOENE?=
 =?utf-8?B?R0RWa2lUU0JiWDlNR05idDJaNFVHUkkzcmVYbmdKR1FBbWUrQmJWeFhmbkZH?=
 =?utf-8?B?aWd3N1A4cUZTYVk2ZG5Uazd2YTVKS1RUL3p1VlYzdGJkV0pVTlcwY0VkVzJV?=
 =?utf-8?B?bHdPT1hQSjEyV0Q2QTkwMndrS2dtVVlxT1ZMYzZLemZwOFVVMTZDRjZ6OHVk?=
 =?utf-8?B?YkNkWk9mcUt2V080eFZ1eUQ4T2UyVmNwR2tKdzFYVWJXYXZWaUhWWnkwb2hR?=
 =?utf-8?B?dC8rdVhOMUdGa3p0RFpKTzJNOFNnUUk5OE9QU1djZU9IZk1KM3E4Z3czSVBD?=
 =?utf-8?B?Umo3TFljUkdaMmhNcWNXeExLOThJZ1hJSTBFTWRzZ08zcWM0WDBnVVJDM0Nr?=
 =?utf-8?Q?mCmBgdxoHiNMWC4TZtWUnwNIE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4943999-db5e-44b1-29f1-08dbb8e71989
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:04:51.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGUr0efceQJ7txdF5stWsQFRoyNVelMPZvhhSxibXcAgppP9/WztNe70S0I0uNl6Z4hmxE+hYXWCjlTdj2MwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct "pmu_events_table" has been changed after commit
2e255b4f9f41 (perf jevents: Group events by PMU, 2023-08-23).
So there doesn't exist 'entries' in pmu_events_table anymore.
This will align the members with that commit. Othewise, below
errors will be printed when run jevent.py:

pmu-events/pmu-events.c:5485:26: error: ‘struct pmu_metrics_table’ has no member named ‘entries’
 5485 |                         .entries = pmu_metrics__freescale_imx8dxl_sys,

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index a7e88332276d..af15fa2cadbd 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -764,8 +764,8 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       continue
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
-\t\t\t.entries = {tblname},
-\t\t\t.length = ARRAY_SIZE({tblname})
+\t\t\t.pmus = {tblname},
+\t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
 \t\t.name = \"{tblname}\",
 \t}},
-- 
2.34.1

