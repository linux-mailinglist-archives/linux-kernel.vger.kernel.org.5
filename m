Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F70800179
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376627AbjLACQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLACQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:16:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A9112;
        Thu, 30 Nov 2023 18:16:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4q8PTko8dlooLZjZb934k4BI6htjGm6fMOPnbQylOv5YV8ceqP/WnbXif29u4GD/tAGe6INdJ8f2MlSTCiRK+MnH2qH3TFhW8fNi0snroO70xuLKnjrONafqcu1cI4D9bqUq8mCIrKyoNlJu/ww10hSB57fFGLhlUqKXnUCEiBRa0V4+aieIUiASBQRzy9Au4aHjmXaZLYFfCrAHLkHJ94U5aAhSZY7Ib+7kTc9LG+QRtohqvPYPoTlBR9LBXUkCuSLBwY0LebSURAjPU3GA49tdssc1IJS22QlhNQT9dN4j/yuSNH4LkTNJ1XZ61mkwWvIRvNNtBLvuUb6J3anTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGurZVkYhzSqmOTmu3ByfEKKBypjGyVnMq0JnmaeEWI=;
 b=hIWMVieFd0eN1+fzToU4fsFHmXnDpJNdB4U8cxAJjF3Vmyzu48JCGYpyYhu3Y6nZb97owLJDfYlLGruNJFoOK5CRE0XzyE1KZ9dwsew5BBnCwkE/Bj9he57mv8oF6bqs54bzGI73YdTj19QmflV8K+jomsCQum263n0JhLjf5fFBz/B061UZ4Ok/etu6lJWPpsBSANBIxOVFThqjIHh5y414hgVbB2lc+V2zvEuyYSSrWspKbS3lcrqRP/bz3iKakcKGqNhHOjAFWl/od3s1kYzBp2+bZ5bghzEQZxfAC4DVQr0ZTjQwp+Cu6qamdr21Q/I9Rez40fG0a0x+KiAljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGurZVkYhzSqmOTmu3ByfEKKBypjGyVnMq0JnmaeEWI=;
 b=GeUlPeBYGEUSEnpZhM/O5okYf6sUj3S6oKDuuQdLMQX39F50JJ1E4WhqC/5gUZwF0gIunutxwSX9nXB78ELFJpAmiQwc9bbig6q0fTvkLcHokG6LGAP+TDmjAT/cy8G/22FXTQqiFKpWQeeocUw/ZA8u13fPuSFn5ecjlsOS0NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6196.prod.exchangelabs.com (2603:10b6:303:71::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 02:16:19 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:16:19 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf vendor events arm64: Add AmpereOneX events and metrics and fix AmpereOne bugs
Date:   Thu, 30 Nov 2023 18:15:47 -0800
Message-ID: <20231201021550.1109196-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::33) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|MW4PR01MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c92bb7-88bb-46c6-d902-08dbf2138120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYzvshdQnXxjJkvuYWP/jBSzmWQKYYi54K21Lmc43PRtURDtOumZd8PNx01eHAnsmRCIGb6MNC7U0VWRAxkm/RVbtuntT2/QV35DmWojDChPBLxRkDhfwyHr4P+NNlAyZTas4A6As+7/oefkyFCxV2o3EMDZhbrXbGo5Dq0/rDZS0nsTFW6f+0kZNhCptWXsDvb/Q9Ju8BkFaDia6Sd4dppyvqBuCgeip+Ti9z5a0s7XACjdQhPrB/0W/7yWycxIeKfl+VfUC0MyaYT5nP/KqZ2hCK88U6MChzvCArQLX9JxfrYyl9gP17U/PbR0f7POrWuKuWoO6pxFHV5opw2NeMoMXFWgVt2NHXCzKn+jOlJCid85SaZ8OYa0L4gJwZbLtYbfyRFCqFN/VChN0S5wvildblc3yNG6LomOElIQCmnlOcfMt1CVi/rt9g/7iXl/kkUFC0wnYR0ADkE4Ufeh/823bFpiymyxNXRm/MENiv8mGBcPtjLwNhos13bdQLkXlTMNKwRywJnPr7dXL/Gf5B6RLO7blkF/lumN3u/2YIbt0B16ofrLFNMu3B2Dh5KJNo529XpJ0E05xjuGBoqDa6yNAwXlV04SxOu/NNSlTXIBAsd+fI6ojudi8BuLZzAZbxC8FTXMUcSRkZfi7D1BzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(1076003)(921008)(83380400001)(26005)(38350700005)(38100700002)(41300700001)(7049001)(52116002)(6512007)(2616005)(6666004)(6486002)(5660300002)(2906002)(7416002)(316002)(6506007)(66556008)(110136005)(66476007)(66946007)(478600001)(86362001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CKHjUzXInfLWbkFxXBWl2spu+d1rG1Fq0cAuNpyl12HB61OQ06ZaprWBIPx?=
 =?us-ascii?Q?1Baow3fdWdrPqKvk5gQZrEAZswX5TzG4J0c2iiKO0iOZgkEXhqc1rBk7KAuE?=
 =?us-ascii?Q?BZGBf1E/rUCwPR+ATiAPmMQHCgODSnFZZSjpzvPGDAtBFCfirA9jlG05QXpr?=
 =?us-ascii?Q?nR7a5iL8wh5tQvUmIKZHwopMUerA+o/Oooj7zVr4yjNr5r0IFENazzek/tNx?=
 =?us-ascii?Q?O6YYfSQxVBdG1SHKmjlz4NvdBChwogZsZ64kG4fz6CPArIZ8dqL8LkWg1OE2?=
 =?us-ascii?Q?5lMXukqJPudH+JRMJAT2RknAUh3uYI9gfQoHdCe9TYHxZ28HYOoMP+u5dUZs?=
 =?us-ascii?Q?umtELw1gHQ7PEWFaxgUXrRlcRo+5q845x7GW9qkAq5z5zcqAQ+YemE1I4UHI?=
 =?us-ascii?Q?bTxN5PHXGDrbknzliYGgWVyZ1nq6aM1zgexTiKghm4bEgZPCG9wSyiuco/R+?=
 =?us-ascii?Q?hDasGtE1CtDw2ANKhF/iC7/rYk/qezFuZwZbmS3sMDU8ZL/43Q9WgiCIfshc?=
 =?us-ascii?Q?4kIVao1c15q0h9fBuhRDdVxl3Bh8iLHwSp2sEAzDygYJcw44eudqajDdvrna?=
 =?us-ascii?Q?it45tRLWNxIYGX6X8kOkV6SkQHmcUsWmF7CH6jAtIdFzYmEWVOYBJFQ4uZoM?=
 =?us-ascii?Q?OP1BLPOPCqFOT/OtANWt6rgpltcuEPjjZT+bFU7+renEOPuKgQGLnpNNIrC3?=
 =?us-ascii?Q?oRRRUeyH1OXPYiG3YMM9RhqeSjdaFpdH4/Wx+Ra44/OqIAhK+ru9vM3H6wFn?=
 =?us-ascii?Q?6ws0SUme7Wr/TqZIkip1kIPsfS1e83RkxKzGj6ExqkXqll/4SwUN86ITs+e7?=
 =?us-ascii?Q?dY12Ko3CVwOhHRx2nyAVXMRnEVr6DKeNaheK8XC/llXuNGKbk6Zuc0t7dGXx?=
 =?us-ascii?Q?3sTbvrUWGsAiOt9MpYTIVnMPs3TzLHpXrwwNhy8aXQNVRzQLLmcuistI683+?=
 =?us-ascii?Q?AdYXHs/VryTJnWLNYQbwZqeqjg/VqrSMcnxRH/EsmHlDJtcu6UN91RNO09tV?=
 =?us-ascii?Q?fgvry2Oy4NvRL4g2mTNOWphx5Lo2zTH1EJ1jL/PTc/xTVjnQIzsJl65tTZ6R?=
 =?us-ascii?Q?5LPiURV3me6kp040KogIRj7WVYSZwBefHCGkqQLk7gy8kscXcrdioatWyiIo?=
 =?us-ascii?Q?qBuZpOuAyMhtptqi7f00tz7YahvijHpI00SDtLM8azrO18drvchV7l8I6TDt?=
 =?us-ascii?Q?LdjIXdqCyfnQDOStCaEDuhyyVxK/ciOf3c8byp7XcFDIAiuVu4vzzieQeoHO?=
 =?us-ascii?Q?7J7p2+fN6w3LvvNx0uTX0Uuw8ijqXZ1hQgeMCGAigMF7gl0Hxq7F9AixGUX0?=
 =?us-ascii?Q?VOeZslXFtdpqx5XSEvfFDKMmcHLA3fCDGq9gcIYbhjtO9np79dkjYiKNzrOs?=
 =?us-ascii?Q?K5jy7ferTHj5RRUx8LywGqUfE8gmfTKH7gGx68nTDLJ4LC+8yPulPx80YSpF?=
 =?us-ascii?Q?AbJ1uk+QP//wsWOrPt+VHX+DtxG0+3SFFVPsj4NRLOP8vFHgPd/V0f7W6isB?=
 =?us-ascii?Q?rt8ilbEXnpG73SfLMlyfN0SzTB3RE13LGFL2oaz2hPhu7U8kI6sPAP977ADh?=
 =?us-ascii?Q?U0NjxIWF7iuS/ZuWAKHmQKlsy4VAZzhhcEnWZQ1gWq8aRa1k5hfQ8ImPN7oc?=
 =?us-ascii?Q?ASF/65u6Tmje5LX/LJXjA1o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c92bb7-88bb-46c6-d902-08dbf2138120
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:16:18.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4h/Jts5+exFct3WQKVPp8boHlCJN4XRQPIfyupjZ9dOO9a/sOIZDZu0ouwiiWsZtls34v+TD4zArIKmIYMr//4PafZ8XCIgS2l7fyfBoQwIG7iaRbwqwgmJHHq00a27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for AmpereOneX Core PMU events. In addition, fix typo in
GPC_FLUSH_MEM_FAULT's name and add missing DefaultMetricgroupName to
metrics.

Ilkka Koskinen (3):
  perf vendor events arm64: AmpereOne: Add missing
    DefaultMetricgroupName fields
  perf vendor events arm64: AmpereOne: Rename BPU_FLUSH_MEM_FAULT to
    GPC_FLUSH_MEM_FAULT
  perf vendor events arm64: AmpereOneX: Add core PMU events and metrics

 .../arm64/ampere/ampereone/core-imp-def.json  |   2 +-
 .../arch/arm64/ampere/ampereone/metrics.json  |   2 +
 .../arch/arm64/ampere/ampereonex/branch.json  | 125 +++++
 .../arch/arm64/ampere/ampereonex/bus.json     |  20 +
 .../arch/arm64/ampere/ampereonex/cache.json   | 206 ++++++++
 .../arm64/ampere/ampereonex/core-imp-def.json | 464 ++++++++++++++++++
 .../arm64/ampere/ampereonex/exception.json    |  47 ++
 .../arm64/ampere/ampereonex/instruction.json  | 128 +++++
 .../arm64/ampere/ampereonex/intrinsic.json    |  14 +
 .../arch/arm64/ampere/ampereonex/memory.json  |  41 ++
 .../arch/arm64/ampere/ampereonex/metrics.json | 442 +++++++++++++++++
 .../arch/arm64/ampere/ampereonex/mmu.json     | 170 +++++++
 .../arm64/ampere/ampereonex/pipeline.json     |  41 ++
 .../arch/arm64/ampere/ampereonex/spe.json     |  14 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 15 files changed, 1716 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/spe.json

-- 
2.41.0

