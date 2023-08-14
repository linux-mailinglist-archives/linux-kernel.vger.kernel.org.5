Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4C77C003
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHNSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHNSt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:49:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6363E5E;
        Mon, 14 Aug 2023 11:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVGQY7NbQNUkxtulEN06IrKl6RmUsMAOmpnrGgAQcu3TTecn0h/E/KxyeKwQDI5Pekm0ln9EImlzEtW0j8SvYcm/DXEO5dwf6cWpgXk05NpOXrMZJu7+Sk5SqGx3rpP8e7wjvRaz8CRhtlnClloH5SxBwReK7Igh11rntTUyHvSD2iJ4cSUpqAF6d86BsX0hY+xpYGlpXntHQBQShkGGIbiIfcnb1lXD8ma42LUrgkheKNijoqqeCu8zYFG6PAAWvOpO9NGvCiXVfAOqau5pqqzVrMFBH6TXMr9U9LRUaVv1c9Y27cXFfRocXJ3zMNkR3Uf2s2W4ZrypvOBM2p3L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr+nvsUqXeyE4cxTch8iFLDAJdpKDRnVNKwb0bdZ188=;
 b=bsgNE+FChpG4CFjVixo7y9+BM/KE1Xlud8hJAD1/1xHs+nxXayWohHDTi1XeRJJoCxQX53szdM1Kg4FI3a9KjzFLAT0/OPgpruyjjub2TaqTGUSKmn3NWMEW+yY+S/a8IyOShsDNXzwO/nQC8c4w6z82RjG9i6XJQgedojfvYp7V4d7QabxKq3yFRkEtoS+z6FC7I0vRS2BqkDl/d0z2ETS1Mk6m1X/+DyoN4qxcTfCE85xRFhqkspizlRHRlP0zX4rGClvubopuDEHTXCiZ5nwYWSCxMy/23fBt0UrpuktlilS4K2N5JkALWgHdwlVBLsRh0/UXgI0j975WWMnpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr+nvsUqXeyE4cxTch8iFLDAJdpKDRnVNKwb0bdZ188=;
 b=FjA43W/BnZ5tF/NCxGswVr7A6lCTlw7HXOH+VbGDLSCi1XNsCwU2oeOfVHgejZekCGZbM9Nb61snV8Eg/bXUgdVB3duKGaYZBH5goQRoHP0X0lzig4o1fm/Ub5wD05uK0w5YL80UNqNeL0c1K6atZKZQpXPzD4C6blYB8AA3kW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB7236.prod.exchangelabs.com (2603:10b6:510:10c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Mon, 14 Aug 2023 18:49:50 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 18:49:50 +0000
Date:   Mon, 14 Aug 2023 11:49:36 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Ian Rogers <irogers@google.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
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
In-Reply-To: <CAP-5=fXYyt8EYMh4SLb3xSokUW0-pOtDo_HK+jbUoTFcvbyrqw@mail.gmail.com>
Message-ID: <e9bdacb-a231-36af-6a2e-6918ee7effa@os.amperecomputing.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com> <20230803211331.140553-4-ilkka@os.amperecomputing.com> <CAP-5=fXYyt8EYMh4SLb3xSokUW0-pOtDo_HK+jbUoTFcvbyrqw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="1372433909-942687723-1692038989=:2468"
X-ClientProxiedBy: CH0PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:610:77::14) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH0PR01MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b299e10-8c28-4f72-6176-08db9cf73ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ae1acQyHeUwQ7WhBGQwC8se6hK6iEsL9pO1KHvO2lX/oWE+0GBuyUnVV9XnAbsqhiQS3/QsxnG+IRrt3Xijydik00uJ1Qc8o3YqzV6/Iunc9FeOs4kcTnZqoRBPxXqqv0NQ8xLKvhmoAfwbAxZ+uZPNaQgZ9m7urRL5iBkapaCEQ0ZLQzAVw+LgaTNkKgNQgr8m9c2unHNFAa3O6JNxARSx09iS3VmRajJJVFFb3k92h2OS2AIoldiwK+XKJzv1y+ISXedISd3sh6w2BWaI/2L5hs5ihpc8B8PLHrZ8avI257kBLNBSZn43kWWROvb+xO8TS+zNuV4xOXod/8Su4+V3QKB5AucPgMZeZLWpaYD8wdN05QCbMl5+xKNv5mhjlMTnouTz5rXaD5Lz2+W+qGQAwLx5MNb1RQr+XEgGZEa0HiYOr9wm7eMv+mTZ4vbI7kBb3zAli3s9DNCAZXSJIia++f0Ah2nyB18qzcGSo6J8CKeS1xqetUBUJYE5anBfy1OXGJCsrn6C8QYZYEt0zgZUEDszOBhekOYOYekwhSivAKovqDwhYnoikXopkk/mnJ3XeRHa5g2CeSjuQ0tfTuhnfzr7SZX4+dZWDK9XZy1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39850400004)(396003)(376002)(451199021)(186006)(1800799006)(38100700002)(33964004)(2906002)(6666004)(6506007)(6486002)(52116002)(53546011)(7416002)(30864003)(2616005)(26005)(86362001)(6512007)(966005)(316002)(6916009)(66476007)(66556008)(478600001)(38350700002)(41300700001)(54906003)(66946007)(5660300002)(4326008)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRVc01ZOE1rOTgvMXZlSmJtcXRXK3NPaWswOXRUT3RVMWVpcGZVNGJHQ011?=
 =?utf-8?B?aE55eXBzREk1T3NmOHliN1RlVjNVMzBlTXcwUHJyVUlpaDJpU2RKazNFbHBv?=
 =?utf-8?B?NVZGZmVLbWZpaVYzSUJDMFBTZk5iSHJDNnI2K1pLdTBNSkd5M204VkJYYW9E?=
 =?utf-8?B?bVJjc01LdXdHTE5GYXZSemVsWDh6eWVWNW5leC9tc0hWa1h3QmllOFRuL1Jj?=
 =?utf-8?B?d1pyVGRxTUVqQUNsNFhhUHVJQ2w3Vnd1bFJjVyt2ejhrM0xyNnpkZDRPOE85?=
 =?utf-8?B?YzJLbHo3RDFTaTI3QlR5Sk5zWGdzbVFlb2N6KzREd0l6d3B0c0lvUXVwa3dv?=
 =?utf-8?B?SFYxQkx2YWpNcXp2dzFRbjZ0V2IzUVdrMXFudS9QS1BOT3lKUis2dUNaTUE0?=
 =?utf-8?B?NUhuSHZUOU9EWGFUUWlzRGxiRC9NMFBoQjVXSktCMUxnMmFmRGxhMWp0TUpZ?=
 =?utf-8?B?TkcrVTdjQVZaU1FEVHE4ckRuSEdlcytnanlHV0FCSlM1Szhyc2cvdzNmZ05j?=
 =?utf-8?B?ckM3RnM1NGNmMG1SQ0J1aDVoRm0wUHNpRFcrTEJrQlZIdWVSakczZG0za3hT?=
 =?utf-8?B?OERlOVRsbEpIbTZJWUlESjI5Q3loNGNCQ0tsY3JTck96T0twWjVxWXZnRldl?=
 =?utf-8?B?dThhQmV1RDFzU0FHODZXdGZ2d1phWlFRU1JKZXNKS1RxNnYyYUhSbm12T3Rl?=
 =?utf-8?B?a2pidVF2d2Q0TGxHMzdIcWkybU5BajFNRFBJdnFiUllvRlVpS0VuTzRvNlhy?=
 =?utf-8?B?L25WU2YwVWRqTjNFZHY0SlRITXFrSmhtZlVuV3RoeHZPOHRqaG5ONjlrY1F3?=
 =?utf-8?B?eTZCSzg5cFJLSWtaaGE3TzVJalV1eFZ1Z1hzRVFjUEhWcUxWZ0xJZ3pQUmZK?=
 =?utf-8?B?OGE2UEFyTGVVZVdOQzRyWTR1RVZyY1hEZkxoWEkvMnU5akJBekpPQ2JVS0Yv?=
 =?utf-8?B?bU80Q1FHOGxRVWJzQ29JZWN1cW5oQlpNUk82eTZkUWJRNDg0a2gyajJOSnNt?=
 =?utf-8?B?Y2NlUG1HQytDZ21pUS9OZmJlYXIrSWFKWGNaRlJxZXBEaUUwVWx3OCtKSVlG?=
 =?utf-8?B?T0JLakdhd0llY2F0L1pwbzZtY0FKWng5ZFIwRkxrUjdoZ3RzN0FZRkEyS09K?=
 =?utf-8?B?SDNKaGw3RXhZZTY5RDl5YTA0VzVEWWs4dSsyNHJEa01HdUNHdzk2UHY1MVR0?=
 =?utf-8?B?MG50T1N4UTBRaHRJZ0dPSUJmUXBxWFljeXZOcTQ1MHovanBnZ3FkNG1NOVhT?=
 =?utf-8?B?VUlYZjRLblBCRlpyblo2bVVPMEFsQjJwaFhYcVJ4SFFFOVRpNVVYRStnUmNF?=
 =?utf-8?B?d0l6VEhHTmFReGJmaFlPVnBzMEl0b3pIZTMwYXhnZDltVjdjb0Y4U0RrL2RK?=
 =?utf-8?B?SzZEajFBd1JkWmpGUHdDL2YzMHloRXdJcnlKbkprYmFQQ1dxdGZWd3VONU5L?=
 =?utf-8?B?YkR3SzhaTWdQYk5MUmJ1eE5nV3dDbDZJQU0rNHVYRmFEZ3VmbjdYUzZySkxz?=
 =?utf-8?B?TUFoOFN5UlFhbmhBZFprekpkdmVTR1RGR1BUak0zdk0wdUMrNGpqRHM4cGRY?=
 =?utf-8?B?UG9aaTBUOHVJY1V3amhjc0lYT01DWityU2UvOXhCTysrUnFLaks5ZkplQmVv?=
 =?utf-8?B?V1RjVXBIY1NNeXVxSFBEUy83TUduV3lCeDBuVUJPWU52RzMzZWlJY0JRZDZv?=
 =?utf-8?B?WkJXWjlPWVRGUjhOQ1NmMkxhS0pKMVNCSnlTeEt2aytZRGVFcUs5VzJkUUkx?=
 =?utf-8?B?V1ZpS0dtSmJGMjZ5VnR6dWNxaHRqRlBrUGEwL1dHaTV4aW9SL1hTNFZzVFlR?=
 =?utf-8?B?SVgzQW9wUGhCTTRvSjN4OVFVK2Z4dkEwVnhhK2xrR3kyTTNaZ0c0bnNVREJP?=
 =?utf-8?B?b3JRS2tuV21iMXlvUmlGZGo3UytBUUdidUlZMFA1RU8zcHFDMFJRbWpnY3FT?=
 =?utf-8?B?d1NvamdyT09QV2g3dytTMjhFN2srSWZqTDdEVzZoRS9aMmNyVWZCWkRJZkNS?=
 =?utf-8?B?RU81bXo1Y1VLRkRKQmJ3UGsvY0pqbnJKY1JQeFBvZjVyeDF5dU90eklVNU9K?=
 =?utf-8?B?TUhnSVc2NXA4bEQ4NFcxUDdzQm9QSDd1WXFNNEJHMXVpVjQ0TWczaUNITWpZ?=
 =?utf-8?B?c1U5bGxocC9rdWFwaXgzVi96b0IyVTVMcWpjYnF1RUhjRWhOc29kU0F2NldF?=
 =?utf-8?Q?7pbGVUvnkFXsT1e4n0AwXpk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b299e10-8c28-4f72-6176-08db9cf73ca4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:49:49.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 916VzakLnBwY6me6E49pOKU/5RpI3AWmC5X59P/4Rn4SfadmO3SQl4A26HV48GX2EWhuaIA7QX84YJ5qVQU0vOl13VS2fuMzs52NQ+81vcTlhfcyuCf3+O18pODedRnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7236
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1372433909-942687723-1692038989=:2468
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Mon, 14 Aug 2023, Ian Rogers wrote:

> On Thu, Aug 3, 2023 at 2:14 PM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>> This patch adds AmpereOne metrics. The metrics also work around
>> the issue related to some of the events.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  .../arch/arm64/ampere/ampereone/metrics.json  | 362 ++++++++++++++++++
>>  1 file changed, 362 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
>> new file mode 100644
>> index 000000000000..1e7e8901a445
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
>> @@ -0,0 +1,362 @@
>> +[
>> +    {
>> +       "MetricExpr": "BR_MIS_PRED / BR_PRED",
>> +       "BriefDescription": "Branch predictor misprediction rate. May not count branches that are never resolved because they are in the misprediction shadow of an earlier branch",
>> +       "MetricGroup": "Branch Prediction",
>> +       "MetricName": "Misprediction"
>> +    },
>> +    {
>> +       "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
>> +       "BriefDescription": "Branch predictor misprediction rate",
>> +       "MetricGroup": "Branch Prediction",
>> +       "MetricName": "Misprediction (retired)"
>> +    },
>> +    {
>> +       "MetricExpr": "BUS_ACCESS / ( BUS_CYCLES * 1)",
>> +       "BriefDescription": "Core-to-uncore bus utilization",
>> +       "MetricGroup": "Bus",
>> +       "MetricName": "Bus utilization"
>> +    },
>> +    {
>> +       "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
>> +       "BriefDescription": "L1D cache miss rate",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "L1D cache miss"
>> +    },
>> +    {
>> +       "MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
>> +       "BriefDescription": "L1D cache read miss rate",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "L1D cache read miss"
>> +    },
>> +    {
>> +       "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
>> +       "BriefDescription": "L1I cache miss rate",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "L1I cache miss"
>> +    },
>> +    {
>> +       "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
>> +       "BriefDescription": "L2 cache miss rate",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "L2 cache miss"
>
> I'm a bit concerned with spaces in metric names. There's logic to
> replace/rewrite metrics in terms of each other:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/metric.py?h=perf-tools-next#n561
> but spaces in rewritten metric name would break this as spaces are separators.
>
> Thanks,
> Ian

After John's reply of using the same metric group names as the existing 
ones, I decided to go through all the metric names and groups with our 
architect and use the same or at least similar names as all the other 
architectures have done. So, there shouldn't be spaces in the next version 
any more.

Cheers, Ilkka

>
>> +    },
>> +    {
>> +       "MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
>> +       "BriefDescription": "L1I cache read miss rate",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "L1I cache read miss"
>> +    },
>> +    {
>> +       "MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
>> +       "BriefDescription": "L2 cache read miss rate",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "L2 cache read miss"
>> +    },
>> +    {
>> +       "MetricExpr": "(L1D_CACHE_LMISS_RD * 1000) / INST_RETIRED",
>> +       "BriefDescription": "Misses per thousand instructions (data)",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "MPKI data"
>> +    },
>> +    {
>> +       "MetricExpr": "(L1I_CACHE_LMISS * 1000) / INST_RETIRED",
>> +       "BriefDescription": "Misses per thousand instructions (instruction)",
>> +       "MetricGroup": "Cache",
>> +       "MetricName": "MPKI instruction"
>> +    },
>> +    {
>> +       "MetricExpr": "ASE_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "ASE mix"
>> +    },
>> +    {
>> +       "MetricExpr": "CRYPTO_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of crypto data processing operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "Crypto mix"
>> +    },
>> +    {
>> +       "MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
>> +       "BriefDescription": "Giga-floating point operations per second",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "GFLOPS_ISSUED"
>> +    },
>> +    {
>> +       "MetricExpr": "DP_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of integer data processing operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "Integer mix"
>> +    },
>> +    {
>> +       "MetricExpr": "INST_RETIRED / CPU_CYCLES",
>> +       "BriefDescription": "Instructions per cycle",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "IPC"
>> +    },
>> +    {
>> +       "MetricExpr": "LD_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of load operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "Load mix"
>> +    },
>> +    {
>> +       "MetricExpr": "LDST_SPEC/ OP_SPEC",
>> +       "BriefDescription": "Proportion of load & store operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "Load-store mix"
>> +    },
>> +    {
>> +       "MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
>> +       "BriefDescription": "Millions of instructions per second",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "MIPS_RETIRED"
>> +    },
>> +    {
>> +       "MetricExpr": "INST_SPEC / (duration_time * 1000000)",
>> +       "BriefDescription": "Millions of instructions per second",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "MIPS_UTILIZATION"
>> +    },
>> +    {
>> +       "MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of software change of PC operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "PC write mix"
>> +    },
>> +    {
>> +       "MetricExpr": "ST_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of store operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "Store mix"
>> +    },
>> +    {
>> +       "MetricExpr": "VFP_SPEC / OP_SPEC",
>> +       "BriefDescription": "Proportion of FP operations",
>> +       "MetricGroup": "Instruction",
>> +       "MetricName": "VFP mix"
>> +    },
>> +    {
>> +       "MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
>> +       "BriefDescription": "Proportion of slots lost",
>> +       "MetricGroup": "Speculation / TDA",
>> +       "MetricName": "CPU lost"
>> +    },
>> +    {
>> +       "MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
>> +       "BriefDescription": "Proportion of slots retiring",
>> +       "MetricGroup": "Speculation / TDA",
>> +       "MetricName": "CPU utilization"
>> +    },
>> +    {
>> +       "MetricExpr": "OP_RETIRED - OP_SPEC",
>> +       "BriefDescription": "Operations lost due to misspeculation",
>> +       "MetricGroup": "Speculation / TDA",
>> +       "MetricName": "Operations lost"
>> +    },
>> +    {
>> +       "MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
>> +       "BriefDescription": "Proportion of operations lost",
>> +       "MetricGroup": "Speculation / TDA",
>> +       "MetricName": "Operations lost (ratio)"
>> +    },
>> +    {
>> +       "MetricExpr": "OP_RETIRED / OP_SPEC",
>> +       "BriefDescription": "Proportion of operations retired",
>> +       "MetricGroup": "Speculation / TDA",
>> +       "MetricName": "Operations retired"
>> +    },
>> +    {
>> +       "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
>> +       "BriefDescription": "Proportion of cycles stalled and no operations issued to backend and cache miss",
>> +       "MetricGroup": "Stall",
>> +       "MetricName": "Stall backend cache cycles"
>> +    },
>> +    {
>> +       "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
>> +       "BriefDescription": "Proportion of cycles stalled and no operations issued to backend and resource full",
>> +       "MetricGroup": "Stall",
>> +       "MetricName": "Stall backend resource cycles"
>> +    },
>> +    {
>> +       "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
>> +       "BriefDescription": "Proportion of cycles stalled and no operations issued to backend and TLB miss",
>> +       "MetricGroup": "Stall",
>> +       "MetricName": "Stall backend tlb cycles"
>> +    },
>> +    {
>> +       "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
>> +       "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
>> +       "MetricGroup": "Stall",
>> +       "MetricName": "Stall frontend cache cycles"
>> +    },
>> +    {
>> +       "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
>> +       "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
>> +       "MetricGroup": "Stall",
>> +       "MetricName": "Stall frontend tlb cycles"
>> +    },
>> +    {
>> +       "MetricExpr": "DTLB_WALK / L1D_TLB",
>> +       "BriefDescription": "D-side walk per d-side translation request",
>> +       "MetricGroup": "TLB",
>> +       "MetricName": "DTLB walks"
>> +    },
>> +    {
>> +       "MetricExpr": "ITLB_WALK / L1I_TLB",
>> +       "BriefDescription": "I-side walk per i-side translation request",
>> +       "MetricGroup": "TLB",
>> +       "MetricName": "ITLB walks"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
>> +        "BriefDescription": "Fraction of slots backend bound",
>> +        "MetricGroup": "TopDownL1",
>> +        "MetricName": "backend"
>> +    },
>> +    {
>> +        "MetricExpr": "1 - (retiring + lost + backend)",
>> +        "BriefDescription": "Fraction of slots frontend bound",
>> +        "MetricGroup": "TopDownL1",
>> +        "MetricName": "frontend"
>> +    },
>> +    {
>> +        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
>> +        "BriefDescription": "Fraction of slots lost due to misspeculation",
>> +        "MetricGroup": "TopDownL1",
>> +        "MetricName": "lost"
>> +    },
>> +    {
>> +        "MetricExpr": "(OP_RETIRED / (CPU_CYCLES * 4))",
>> +        "BriefDescription": "Fraction of slots retiring, useful work",
>> +        "MetricGroup": "TopDownL1",
>> +        "MetricName": "retiring"
>> +    },
>> +    {
>> +        "MetricExpr": "backend - backend_memory",
>> +        "BriefDescription": "Fraction of slots the CPU was stalled due to backend non-memory subsystem issues",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "backend_core"
>> +    },
>> +    {
>> +        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE + STALL_BACKEND_MEM) / CPU_CYCLES ",
>> +        "BriefDescription": "Fraction of slots the CPU was stalled due to backend memory subsystem issues (cache/tlb miss)",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "backend_memory"
>> +    },
>> +    {
>> +        "MetricExpr": " (BR_MIS_PRED_RETIRED / GPC_FLUSH) * lost",
>> +        "BriefDescription": "Fraction of slots lost due to branch misprediciton",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "branch_mispredict"
>> +    },
>> +    {
>> +        "MetricExpr": "frontend - frontend_latency",
>> +        "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "frontend_bandwidth"
>> +    },
>> +    {
>> +        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (frontend * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of slots the CPU was stalled due to frontend latency issues (cache/tlb miss); nothing to dispatch",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "frontend_latency"
>> +    },
>> +    {
>> +        "MetricExpr": "lost - branch_mispredict",
>> +        "BriefDescription": "Fraction of slots lost due to other/non-branch misprediction misspeculation",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "other_clears"
>> +    },
>> +    {
>> +        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6)",
>> +        "BriefDescription": "Fraction of execute slots utilized",
>> +        "MetricGroup": "TopDownL2",
>> +        "MetricName": "pipe_utilization"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to data L2 cache miss",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "d_cache_l2_miss"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to data cache miss",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "d_cache_miss"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to data TLB miss",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "d_tlb_miss"
>> +    },
>> +    {
>> +        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
>> +        "BriefDescription": "Fraction of FSU execute slots utilized",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "fsu_pipe_utilization"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction cache miss",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "i_cache_miss"
>> +    },
>> +    {
>> +        "MetricExpr": " STALL_FRONTEND_TLB / CPU_CYCLES ",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction TLB miss",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "i_tlb_miss"
>> +    },
>> +    {
>> +        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES / 4)",
>> +        "BriefDescription": "Fraction of IXU execute slots utilized",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "ixu_pipe_utilization"
>> +    },
>> +    {
>> +        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to flush recovery",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "recovery"
>> +    },
>> +    {
>> +        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled due to core resource shortage",
>> +        "MetricGroup": "TopDownL3",
>> +        "MetricName": "resource"
>> +    },
>> +    {
>> +        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES ",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled and FSU was full",
>> +        "MetricGroup": "TopDownL4",
>> +        "MetricName": "stall_fsu_sched"
>> +    },
>> +    {
>> +        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES ",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled and IXU was full",
>> +        "MetricGroup": "TopDownL4",
>> +        "MetricName": "stall_ixu_sched"
>> +    },
>> +    {
>> +        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES ",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled and LOB was full",
>> +        "MetricGroup": "TopDownL4",
>> +        "MetricName": "stall_lob_id"
>> +    },
>> +    {
>> +        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled and ROB was full",
>> +        "MetricGroup": "TopDownL4",
>> +        "MetricName": "stall_rob_id"
>> +    },
>> +    {
>> +        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES ",
>> +        "BriefDescription": "Fraction of cycles the CPU was stalled and SOB was full",
>> +        "MetricGroup": "TopDownL4",
>> +        "MetricName": "stall_sob_id"
>> +    }
>> +]
>> --
>> 2.40.1
>>
>
--1372433909-942687723-1692038989=:2468--
