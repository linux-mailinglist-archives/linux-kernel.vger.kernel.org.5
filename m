Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC7C774FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHIABC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHIABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:01:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ECAA1;
        Tue,  8 Aug 2023 17:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDd2Og7PAVRS4sw61Y5+ykHOHqDWMpXLPG5PvqmvePJBaUTV3Nh4mMZXGT/GNcJcLtT6fmkTBbFsy2t7b8x+PZ9pC9Vn2MVEAK6qOMGj36WxroGUEnihboBA9L701SPc7hpDNxFTzhJtk5BRWa5jhFTHW/Z0IWIwlJQZaa4S15ut6Fj2yuJWQqwktsTbYkoJkI/OS/BUVWtuZ2uAPOUjH8H3Z/OBlAQWUvX8pouQ4kcLy8+BOa6gYdRw1g67BLxtLh6Lc1n+4pNdGQFwdsrsVW0N8wvhfCeOszBs8j6xZxI0YxA6d1UmGD6octB62axqrbsPWTtRp4LAKkUe3pyovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE5i8YDPH78q79boaiIB9TCa/dbSPbr9lQMssaXToHs=;
 b=R1K299VAstb02ZMSBWKlqH4UfcItRkwT/9x0NZMECMVKz3eRUtDXhpBUFgRlF2NSeUIlVQfv4F06r+IjOs0UGZKC3PlLWV14dGHYtIQymrjqWNxZCz5ONyzNruWPV9JXxZDJISxETNRLyI4KtvkmxLOUZ0EjA0bioMaIBY3B75jhlxPCmoCsYF6xRs+zD/ZxQLKLQ+flIauG/HrdIfjgp9ALQ5uaGDp/r1pfe7nKVRZBF85z0UB7GEu5LhiDUnfUXHrczhamAXw1uqlFSOelU9RgdI6eb0/90gmQrI0d9nyfOgUUiYsPwAeHN1le/lYzKGGdwRbIUJ6Y70Fswjz4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE5i8YDPH78q79boaiIB9TCa/dbSPbr9lQMssaXToHs=;
 b=um81hC10eVWsagSmk/Wa+F01xaNKWFlKF1Hpgt7rY3/cR/kVy3Sh7aw1vjjaqf3dKmHKylShg/QTc6KhcN14ZE2Qr5UADw6NYhScbbo1HjBZckOi7u0zVsH5SFo6CPyRgChTQpd1qFTE3UdMD1KVpVb75XW8STYaHsq1H7kixEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6624.prod.exchangelabs.com (2603:10b6:806:1a3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Wed, 9 Aug 2023 00:00:56 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 00:00:53 +0000
Date:   Tue, 8 Aug 2023 17:00:41 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 3/4] perf vendor events arm64: Add AmpereOne metrics
In-Reply-To: <90c18a64-4de6-a251-13d2-e6671a04c398@oracle.com>
Message-ID: <fe49313-add2-a3a7-49f0-54dcf0dd8c84@os.amperecomputing.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com> <20230803211331.140553-4-ilkka@os.amperecomputing.com> <ccce391b-da5e-584c-9c56-1de754df8362@oracle.com> <e5879193-515b-662c-8597-ca8ea8e3fb4@os.amperecomputing.com>
 <90c18a64-4de6-a251-13d2-e6671a04c398@oracle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:610:38::14) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 636b01fd-73cd-4218-77de-08db986bb283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4xMJUbkhfCT6KREO/Rid/vfGBIIJnd/KL+2yNEcXL+17U5t6kvDMc3Wesix8Mo17hgYz2b9pDE5zeZEKrtXyX3OAyA++r+nI2vKc9MMUojRdPW5jwxl9NB/uX21SFoWLLdlbs5HRUWjCpPffMX398CvnLKAuY1wxbh5YxiKG+I+4hlW+QNujenNFSks99l/I+uFVy3D6IlTfNtawh0yeHqp7QOa4hE/qnFrdd3wcjSysCItNQ9f9SJ0lKk5P/3tidCqWdUTGtSVoEz9+3gcFTyJ3xYiCBSMd15gkvxqDRGxRpf7qyiJbiNifLbeJf3ydasVVIz+sKy3qHAaSvrcV5BKAbU4NtEjFWaHvOB2l1uWGeQ9uBLeWTG0vRNJVEL+uNgwl57ZB+R7wlHKjf1+roN3nc8U8G1XZiMT/UvEKg5Zxj5jzg05EhC/Sd9qcb6dx9ghROKrUL0ILLt9+osU9GKatnKd/yiRJ0gWejV66XagKzgoyKnqs0Zhk986mA+vosUTsCk4zLpqQkrpfR1k8cb11msWAf7079QKfC8fGRA1oW6r04VdKaW3iC4vB9jSzm+lXFIx8sNNHHdBufSkXaAz7OLmVBVCa1yVrhJ/JyHuiB/T/AkmySrppQFKQrxs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(1800799006)(451199021)(186006)(7416002)(8676002)(5660300002)(8936002)(4326008)(41300700001)(316002)(83380400001)(86362001)(2906002)(6916009)(6512007)(6666004)(6486002)(52116002)(53546011)(26005)(6506007)(2616005)(66946007)(66556008)(66476007)(478600001)(54906003)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tv6WP/9eacMRCDdny/wCElH8acZErP7mxxsv0CoTx/0SesJB6MNK4ikkbbLV?=
 =?us-ascii?Q?2rCBBKxe7cPZFXHezWk3lV1Y5iziR1rxSiJ3CQg4ZMkQVFKH3U8kufNwc1jl?=
 =?us-ascii?Q?7GmM2AT2Hu2D8axk1rQh/f78pbawW8JpKIFDYbokr9WlVlopxmVZnDlW7Avg?=
 =?us-ascii?Q?PvhVt3W678oV4GVHKqm+4q0dBwQ0QAmpC5ROOE/ZtNTzUSVewssgDBvaU9Ty?=
 =?us-ascii?Q?wUDEG2YdlXo728fMl4L8Re1sZwwb9AhYizBdaz4qCrs8Z9iglrMAW6zMYuRA?=
 =?us-ascii?Q?Wu3fCBCIaCLy0CP9J3/nw6DFugn/p/VG+LcSNSXJa5QBg9y6Q3/jocn8j4da?=
 =?us-ascii?Q?64A314I5QmFif1RtdD9gE2tGN/blRZq7zEJvKffyD9xNeSihleXgePwfwol8?=
 =?us-ascii?Q?cQchowwH/RzXE2atSLlSJUwcat5v/xWX1OpBcHWNyMq5F0QB9A1FRNq3Wm6y?=
 =?us-ascii?Q?SHmqHEmH3YJil2NMlQHe+fCEoeb5jRoZMoTcT3oUOb/zRNCMg9n5nevLwjVm?=
 =?us-ascii?Q?n2Weg6jQkzGt4hLkKSYeihBXGjyGqc0L8K3+HJ3SbZd9k6PBDln9Gh7Y1jpo?=
 =?us-ascii?Q?53Gq0rJibNVOPGUPpWM0ewrZsJaqXS8U5GTnnDwJ5c+w1ayRKTlO5FpxEErE?=
 =?us-ascii?Q?Vq22Xqs7mEIKpiGIMWMHFj9Gw5R4F/xqql7nGOi7GUAGTqtOT71K7KTtMvea?=
 =?us-ascii?Q?7lFmqr+l/cYmwvZvaKRWgz+W9H9FukpGErUnasSpjE9LxsWPs+Ca8de/2GAz?=
 =?us-ascii?Q?mq90949ZGgDD0+Gi1ovPi8TpJHiNt7Ri3FtcgMS0XzeZ7OtWGAv3ltht4SS6?=
 =?us-ascii?Q?bFH4E7a8ZQpi94vCDtzOXsFw5Ka+IhAxX7jInE6irV9kubQ43kaTuS+5whpA?=
 =?us-ascii?Q?Px45bZoEZp8gcdZpkawruw/zNnMkvPB4GgNQ96zS3aREEEorsPQvSH614X3X?=
 =?us-ascii?Q?mczaUoOMHt2/QiLQ4VohuS4q4Rae8gTf3oS3Z2wHaQZ+zGzcbMdBhdu9SYlQ?=
 =?us-ascii?Q?2VkGdWY5HzKegUhV35uS02jroY/IMhrxtcQPEruar6rIysVoYbz1Y6N+iMBW?=
 =?us-ascii?Q?gsN4EuL+vn/rovXQtvLeuaM0wo6vWVRr4vWcShsU0EMaL8KvCAgSYQD+nRd7?=
 =?us-ascii?Q?Q/6QtgjXPwjChkxW6ry/DMQAzzSzNKbI461uRc29MQ3KERdVKrISngaH4Wop?=
 =?us-ascii?Q?wbOUKFjQ0ilIfI3Xdogu+qxY/s33dS0++TOR74BIbVeIeJomvF57FuiIrEv3?=
 =?us-ascii?Q?91YFtgyIDXuttTMxuLP9HP05Lpr03X3DBUAFRDqeyiqLYjQBWrTjIpSXS7GZ?=
 =?us-ascii?Q?ossTU8T40OuhxQPudFzI1zVGX9yXvW8VlPC0DO5XyFsGMguI0pOOfrv4/QVf?=
 =?us-ascii?Q?CzDgQh6rIGGQv7YbilVzT08NmBtP0+QE79pQdXWsKoVMzZE4aq5wbGFmb8Ms?=
 =?us-ascii?Q?mAEAa4mDi9Fx8FimrYzzIAFga2bGjSrMgF7WAfi+thvT+ymcEyKUMywX+wHX?=
 =?us-ascii?Q?qXNwqIa4ztuVAPfyCcKQ6wJuZMysL22L0qzADxCGuC/40fqLRQDJTeS9ne85?=
 =?us-ascii?Q?4h5Bu6QFOJ/HVMYBJBGRQdpcE+Am1QHAqni+oiyQXN9GyjX6LSZeqb7ikqir?=
 =?us-ascii?Q?UQsTeYWIuKKyl6ybApxJyJA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636b01fd-73cd-4218-77de-08db986bb283
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 00:00:53.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG+chQzGWwuXHbqD7ZOIH4LOavDcJ2dey4F5I3AkpY36Pa3kB2bzSM4DeUYjazEFzzGKxyvCjyGexHQj5gonQ5+9/OUDsrFnM2lBeus2S21wm7Bs8VoG4xtcsFn9Yq38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6624
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Aug 2023, John Garry wrote:
> On 04/08/2023 20:59, Ilkka Koskinen wrote:
>> 
>> Hi John
>> 
>> On Fri, 4 Aug 2023, John Garry wrote:
>>> On 03/08/2023 22:13, Ilkka Koskinen wrote:
>>>> This patch adds AmpereOne metrics. The metrics also work around
>>>> the issue related to some of the events.
>
> Would these events be any metrics added which are not a "Topdown"? I guess 
> no, since there are many, but I just don't know.
>
>>> 
>>> Just curious, are these events/metrics described in some 
>>> publically-available document?
>> 
>> I quickly checked that and there are a spreadsheet and a document 
>> available, which list the supported PMUs, their events and metrics in the 
>> customer connect website but that requires registering.
>> 
>
> OK, thanks for the info. I ask is it always worthwhile mentioning a link in 
> the changelog if publicly available.

I can certainly add a comment that the events are available at the 
customer connect website.

>
>
> Just a few minor comments:
>
> On 03/08/2023 22:13, Ilkka Koskinen wrote:
>> This patch adds AmpereOne metrics. The metrics also work around
>> the issue related to some of the events.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   .../arch/arm64/ampere/ampereone/metrics.json  | 362 ++++++++++++++++++
>>   1 file changed, 362 insertions(+)
>>
>
> ...
>
>> +    {
>> +	"MetricExpr": "CRYPTO_SPEC / OP_SPEC",
>> +	"BriefDescription": "Proportion of crypto data processing 
> operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "Crypto mix"
>> +    },
>> +    {
>> +	"MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
>> +	"BriefDescription": "Giga-floating point operations per second",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "GFLOPS_ISSUED"
>> +    },
>> +    {
>> +	"MetricExpr": "DP_SPEC / OP_SPEC",
>> +	"BriefDescription": "Proportion of integer data processing 
> operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "Integer mix"
>> +    },
>> +    {
>> +	"MetricExpr": "INST_RETIRED / CPU_CYCLES",
>> +	"BriefDescription": "Instructions per cycle",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "IPC"
>> +    },
>> +    {
>> +	"MetricExpr": "LD_SPEC / OP_SPEC",
>> +	"BriefDescription": "Proportion of load operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "Load mix"
>> +    },
>> +    {
>> +	"MetricExpr": "LDST_SPEC/ OP_SPEC",
>
> mega nit: missing whitespace before '/'

I'll fix it.

>
>> +	"BriefDescription": "Proportion of load & store operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "Load-store mix"
>> +    },
>> +    {
>> +	"MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
>
> I think that we may use 1e6 here for shorthand - it helps avoid mistakes with 
> too few or many '0's :)

Oh, that's great. I don't think anyone needed to use those in arm64 and I 
guess I didn't realize to take a look at other architectures. I'll change 
all the numbers.

>
>> +	"BriefDescription": "Millions of instructions per second",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "MIPS_RETIRED"
>> +    },
>> +    {
>> +	"MetricExpr": "INST_SPEC / (duration_time * 1000000)",
>> +	"BriefDescription": "Millions of instructions per second",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "MIPS_UTILIZATION"
>> +    },
>> +    {
>> +	"MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
>> +	"BriefDescription": "Proportion of software change of PC operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "PC write mix"
>> +    },
>> +    {
>> +	"MetricExpr": "ST_SPEC / OP_SPEC",
>> +	"BriefDescription": "Proportion of store operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "Store mix"
>> +    },
>> +    {
>> +	"MetricExpr": "VFP_SPEC / OP_SPEC",
>> +	"BriefDescription": "Proportion of FP operations",
>> +	"MetricGroup": "Instruction",
>> +	"MetricName": "VFP mix"
>> +    },
>> +    {
>> +	"MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
>> +	"BriefDescription": "Proportion of slots lost",
>> +	"MetricGroup": "Speculation / TDA",
>> +	"MetricName": "CPU lost"
>> +    },
>> +    {
>> +	"MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
>> +	"BriefDescription": "Proportion of slots retiring",
>> +	"MetricGroup": "Speculation / TDA",
>> +	"MetricName": "CPU utilization"
>> +    },
>> +    {
>> +	"MetricExpr": "OP_RETIRED - OP_SPEC",
>> +	"BriefDescription": "Operations lost due to misspeculation",
>> +	"MetricGroup": "Speculation / TDA",
>> +	"MetricName": "Operations lost"
>> +    },
>> +    {
>> +	"MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
>> +	"BriefDescription": "Proportion of operations lost",
>> +	"MetricGroup": "Speculation / TDA",
>> +	"MetricName": "Operations lost (ratio)"
>> +    },
>> +    {
>> +	"MetricExpr": "OP_RETIRED / OP_SPEC",
>> +	"BriefDescription": "Proportion of operations retired",
>> +	"MetricGroup": "Speculation / TDA",
>> +	"MetricName": "Operations retired"
>> +    },
>> +    {
>> +	"MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
>> +	"BriefDescription": "Proportion of cycles stalled and no operations 
> issued to backend and cache miss",
>> +	"MetricGroup": "Stall",
>> +	"MetricName": "Stall backend cache cycles"
>> +    },
>> +    {
>> +	"MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
>> +	"BriefDescription": "Proportion of cycles stalled and no operations 
> issued to backend and resource full",
>> +	"MetricGroup": "Stall",
>> +	"MetricName": "Stall backend resource cycles"
>> +    },
>> +    {
>> +	"MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
>> +	"BriefDescription": "Proportion of cycles stalled and no operations 
> issued to backend and TLB miss",
>> +	"MetricGroup": "Stall",
>> +	"MetricName": "Stall backend tlb cycles"
>> +    },
>> +    {
>> +	"MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
>> +	"BriefDescription": "Proportion of cycles stalled and no ops 
> delivered from frontend and cache miss",
>> +	"MetricGroup": "Stall",
>> +	"MetricName": "Stall frontend cache cycles"
>> +    },
>> +    {
>> +	"MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
>> +	"BriefDescription": "Proportion of cycles stalled and no ops 
> delivered from frontend and TLB miss",
>> +	"MetricGroup": "Stall",
>> +	"MetricName": "Stall frontend tlb cycles"
>> +    },
>> +    {
>> +	"MetricExpr": "DTLB_WALK / L1D_TLB",
>> +	"BriefDescription": "D-side walk per d-side translation request",
>> +	"MetricGroup": "TLB",
>> +	"MetricName": "DTLB walks"
>> +    },
>> +    {
>> +	"MetricExpr": "ITLB_WALK / L1I_TLB",
>> +	"BriefDescription": "I-side walk per i-side translation request",
>> +	"MetricGroup": "TLB",
>> +	"MetricName": "ITLB walks"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
>> +        "BriefDescription": "Fraction of slots backend bound",
>> +        "MetricGroup": "TopDownL1",
>
> @Ian, should this be "Default;TopDownL1"?
>
>> +        "MetricName": "backend"
>
> How about use consistent names with other other archs and arm64 platforms, 
> like "backend_bound"? I did not check all names, but please consider this.
>
> If 'perf topdown' is ever supported for arm64, we would prob rely on 
> metricgroups, so would need use a fixed standard name here. Note that x86 
> uses custom kernel events for this instead.

That's an excellent point. I'll reach out to our architect and we'll 
change the names and groups in the patch and the document to be more 
consistent to the existing ones.

>> +    },
>> +    {
>> +        "MetricExpr": "1 - (retiring + lost + backend)",
>> +        "BriefDescription": "Fraction of slots frontend bound",
>> +        "MetricGroup": "TopDownL1",
>> +        "MetricName": "frontend"
>
> As above, it would be "frontend_bound"

I'll fix it.

Cheers, Ilkka

>
>> +    },
>> +    {
>> +        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
>> +        "BriefDescription": "Fraction of slots lost due to 
> misspeculation",
>> +        "MetricGroup": "TopDownL1",
>> +        "MetricName": "lost"
>> +    },
>> +    {
>
>
