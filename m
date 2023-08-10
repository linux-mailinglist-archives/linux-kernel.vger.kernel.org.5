Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF37783B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHJWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHJWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:39:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BBD272E;
        Thu, 10 Aug 2023 15:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUEF+T4YQAW5j7auvWOOmP+nyrCLNl1Fuwvg/4YhaSAxobPdo+xlJeA2b6fKHjT+KMH1Uw3UqHBvhz82ZBBO8fYLbnrcYSceNhnjvRTUnqG3BerKutvPb6jOzuzYqHJVd0DxvVTNrWeEZ23le9ZA5VfyDzVCXwWA825QyiP8dtaCKR1WqiXSu+bQI7Zbh7HI3Crh+3oKbhBhu8zdPKh7v1hL6D6kdOzX3lIRVMbiX8ngNKL/a6w+56ci1EhZNAdclabFpnz4nHUYp5g18lp1YK4MmSXWp1M0yXuxru93ebApn6r0m3y0eZIIl1rG7EubNZqkcR7V5qTKIgbSnTUeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwlxCHNs+AJYttHAZGi3rNrJ22MS0dW7dz1EvQheWoc=;
 b=TEBSK+HIjtJ6ZqQEdH1Vd2Bwel8Oa02tw/y81uNVUm92eN+csujBA1C0fe4czEmI/et1Ngr5hU9BjM8ITUMg/3WVTS92eAHikRI7V0b8S3UmJbti6jobv6Wig8gavM4o96RX3aLxMaChwoDQtsZnldLKUeHLd5iBLZ+y7DQtYHC0MwSJvP8S1DGPujBH18b5Z411MWF57luPN8T4ocNX++nO2NYxq5WO1YWnz5yTreKPBd9xVqbVH9edEFmSZUeWz2CzFY65Ssu2SuztYQohxapC0/GSoud+Xa5SD+VH5F6qXqFvRbczMR0KMIGRsKsjuDsboWsiMZL001XendONYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwlxCHNs+AJYttHAZGi3rNrJ22MS0dW7dz1EvQheWoc=;
 b=mkpkI9bqEww1SUkrfaInH2HPruNt3WlB/+pTe8h8xw9n9goJf8ptTs0At61zLp2DcNCsGzjK63fyO86dRz2fSH2fFMsLPV0vIp5u31KygSyRuyGcdEYNKhgqyij/t8opNXjXouSnDacbPql6W05yqvkRx39+A3/ng76Wiy5lAcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7878.prod.exchangelabs.com (2603:10b6:8:81::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 22:39:07 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 22:39:06 +0000
Date:   Thu, 10 Aug 2023 15:38:50 -0700 (PDT)
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
Subject: Re: [PATCH 2/4] perf vendor events arm64: AmpereOne: Mark affected
 STALL_* events impacted by errata
In-Reply-To: <d3da2a30-9e9-73c3-b1aa-aca508bd259@os.amperecomputing.com>
Message-ID: <265ae2c0-d355-f282-4463-4a677d9969cd@os.amperecomputing.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com> <20230803211331.140553-3-ilkka@os.amperecomputing.com> <b690cae6-ee9c-2c6b-a19e-60088cb8cb19@oracle.com> <d3da2a30-9e9-73c3-b1aa-aca508bd259@os.amperecomputing.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:610:e4::32) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS7PR01MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 557bcfa6-e9ad-4fad-d937-08db99f29ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJl/wF+88fLnoj4EAPo51gBYvZN+u1dzw7ruN8yUTjA5SE2oWguron9fQo28Q9ythYTvZkhuWHnRz9rm1N82utQ2tXbuhNIugm9BLy5/+fctIj1/YJW2nk9FSbTQlW5F8pB6HpwHH4G51BgthsnwLJXuUEpd6d/m7PjmAuwB0Uw90TcrK+lfpLyWHEJ90AuQoOTf1nmWno3BWo8Hipv1Yx4J/zjEPr/PfT0EaAeAjRgcxGWCUKsaHzHRT4Twr1JfYd93WufDXJY2hgfCQ+zIOqgM/gv5LkrJR4bGbHE7KE3DIRrGJZthDzvWvacS2VP/MRmsABQ8CvB+Dx0lQ/dJX6+jyyx9isZj2o6bFEvIiPLNtr8dI8ALevx3XxUUn3hsXv9svcgY7/OTl76HQC/uUm25A4Dan3wwTx9gKTGZpZlL75e3tt4d1J/1vlsHg8MU4u1GENUaVbXKsgaZk3kHFQ5o5VO5vXV3sLRicBbejWReB3UMZ0czEddHeCwnT3Hl6CG3ZGxATOh32x3Mqpjh/eWXQ8Q1Yi+wU9EOTMTOIJysochIKkF2VdpvwYvxgmPHf0pRXz7TrYYkN0+++neM6NbQ9wtuoHKBSDCCrd0he5GLNivfhIc8MT1Ifqp/fCM3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39850400004)(396003)(451199021)(186006)(1800799006)(53546011)(6666004)(478600001)(54906003)(66556008)(66946007)(6916009)(6506007)(6486002)(66476007)(26005)(6512007)(4326008)(2906002)(41300700001)(316002)(7416002)(5660300002)(8936002)(38100700002)(8676002)(86362001)(31696002)(38350700002)(83380400001)(2616005)(52116002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oeWjxPX08foZe0uPWVmjkD1iCFyEYIK2le6qkryFEnlp8AlEbtvh/X4qHfhc?=
 =?us-ascii?Q?wp3jTio7FGR5mN7BjKxeWpUo+Ta5ZuPGiN9Twx0IlUf8bVd3axCde8KMsWM/?=
 =?us-ascii?Q?sqUvktj1ZnLv81YNTwyJzWzsol3BRmzL3yMgdGwbHR7p75VM8n9LkaZgLgUg?=
 =?us-ascii?Q?V7PQ8hl7PI6jtUPREQny6y37Nqx1NGnPjm6qSQcf53Q2ovQwbMUIn2Q83ZUC?=
 =?us-ascii?Q?kt4V+xwbWK9BTKWapkCkI0D+3H2u0lyWFvPmmNmpFSnAcvfe1eR8gzcGQ1AS?=
 =?us-ascii?Q?6Zd7nEvTOvLOAoPDKgdk2DnIxfry/P6pmRg6rw+Z6Q7fSki3dD5lsFobInd/?=
 =?us-ascii?Q?10/Sqj0CLad/c4m3bh/lT6DBlFPQgUwY4H8hkjLSCP5vDvs3EI6M6YCJfvkH?=
 =?us-ascii?Q?ZoSdLhl9HKQU24YD69LKcoSOZhACgKExFtmRaJpSTeIGQ2U6kZbzNda+0EVC?=
 =?us-ascii?Q?yUIISEZhR3LkrOrAmpEYfyzPjsLYCYepOmKSApK373UdBVXf+Eu4dfIqfanD?=
 =?us-ascii?Q?nTST2v9IQOdhOS/h07FdD2UH0KsQO4rnVA7GKKuun3K/Wv6NOdCEjyaUZ44Z?=
 =?us-ascii?Q?uBZAKVbRrInHNilcGlReoKTtpKBw+xxTZrLggP+wCxOt/g1d1gxvE4NRs0Ju?=
 =?us-ascii?Q?hMo2k6UBCWg17iXNUCK3zGQCvCqCNWmM5LAKJJe/dzCKe54/zAu+UWxs0S6K?=
 =?us-ascii?Q?QBrfiLSuFA8+STPIGS8M7ua6fVwD62jlXUbt7HVCIeGJgqmfiKsZYhbr3dHd?=
 =?us-ascii?Q?jneex4eWrXRxwr71Oh0nH5CInBtOnGEAsVRhFDdnlnZTsdjQH8646+jSahts?=
 =?us-ascii?Q?O1sWW5KQmPUrfG4efzYrl9aCYcE7PEgcvOiNpvQ8LyurlvfyToZ/F0nZTCCt?=
 =?us-ascii?Q?CLdGFlqSV0r5ZgmbccS7V/O4WTOvdj/FjeTtj347HgyfjIHFGxzgZV50ZSsJ?=
 =?us-ascii?Q?ANbPlvuQYIs8oXRMQWbl3timgxcWOkHkDH3VF0V7fyviFUHbdvN4ZcNINZ9y?=
 =?us-ascii?Q?u4Bk8Vu/wVWtiQQb6aTfs18niSD3FMAhMODoiESgHIQ8AjAoKGrZCXv8bzGA?=
 =?us-ascii?Q?2sD8Jav5ltfEBTnZH+0STD6bjTdl8pFdRFwzRAUUxTnNZSjHSK//rwYJVgYA?=
 =?us-ascii?Q?OKJOSj3+q2nRVYyGifrhpMWJJt+UlEVqoFJ6syNYXh6Aoh/uES30DpQTG/xN?=
 =?us-ascii?Q?D+g1M9f6+3p8SHEmhT0ZXC58cmr75KRniBTBt9uQyzuJ15uViIKPg7ZT8Y8x?=
 =?us-ascii?Q?PD1Zt7dOA1GlFhZV8KAnu+9dAfO0I6zoqEx6FCSAOm0teGBxSGCZo09efaR7?=
 =?us-ascii?Q?qK9fnb880GNYOVNPkFI2/oxMPTtX5xstr9zfbjLdDK9xQUlt8oez3Qffiwjk?=
 =?us-ascii?Q?El18LYZlv2xvtEr22savVkJYKoO6ybhURrFuaiV+i61rdhni+qNIfWijAb1H?=
 =?us-ascii?Q?I/VYg9188ZUlJXo6BUiC3vEmceMISIbOzoTpe+y83GGwIuFoWX8Vhl0pxn5d?=
 =?us-ascii?Q?6Td6MrbtdNcGS6BXESDGsCZMsGmdUT538RSZSR17gR4fmcbh4/Po426B5eGg?=
 =?us-ascii?Q?1cmvgLyJrohbCMrRP6pYu6Z9TBYIvR6nZ+mRgVF+DRK6ubTIhhiwy6lIC76I?=
 =?us-ascii?Q?Evm7+K2bIoLfh6x68gUyjHg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557bcfa6-e9ad-4fad-d937-08db99f29ac9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 22:39:06.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG/jpqdDjvY9iAA6geBIvClweymTQmBeO0rGjFztzU4g29E9bOaxU8HBx5urNLOFia8OFl1b3SKt7iJRe5NQwXKQ/achHSHlfZ2zlxPkConauzCmXUJBieJZ/of0Cf1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7878
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Aug 2023, Ilkka Koskinen wrote:
> On Fri, 4 Aug 2023, John Garry wrote:
>
>> On 03/08/2023 22:13, Ilkka Koskinen wrote:
>>> Per errata AC03_CPU_29, STALL_SLOT_FRONTEND, STALL_FRONTEND, and STALL
>>> events are not counting as expected. The follow up metrics patch will
>>> include correct way to calculate the impacted events.
>>> 
>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> 
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> 
>>> ---
>>>   .../arch/arm64/ampere/ampereone/pipeline.json        | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>> 
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json 
>>> b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
>>> index f9fae15f7555..711028377f3e 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
>>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
>>> @@ -1,18 +1,24 @@
>>>   [
>>>       {
>>> -        "ArchStdEvent": "STALL_FRONTEND"
>>> +        "ArchStdEvent": "STALL_FRONTEND",
>>> +        "Errata": "Errata AC03_CPU_29",
>>> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>> 
>> why end with a '-'?
>
> That's a great question! I wish, I remembered why I did that. Looking at 
> other events with Errata field, they use '.'. I can fix those and submit the 
> patchset again.

John, I took a look at it and it seems that if I use '.', perf will remove 
it. Here are two examples:

metrics.json:
"BriefDescription": "Impacted by errata, use metrics instead."

# perf list
[Impacted by errata, use metrics instead Spec update: Errata AC03_CPU_29]

vs.

"BriefDescription": "Impacted by errata, use metrics instead -"

# perf list

Impacted by errata, use metrics instead - Spec update: Errata AC03_CPU_29

---

So, I believe, I probably used the hyphen to make the 'perf list' output a 
little "prettier". Well, I just change to dot and it's fine.

Cheers, Ilkka


>>
>>>       },
>>>       {
>>>           "ArchStdEvent": "STALL_BACKEND"
>>>       },
>>>       {
>>> -        "ArchStdEvent": "STALL"
>>> +        "ArchStdEvent": "STALL",
>>> +        "Errata": "Errata AC03_CPU_29",
>>> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>>>       },
>>>       {
>>>           "ArchStdEvent": "STALL_SLOT_BACKEND"
>>>       },
>>>       {
>>> -        "ArchStdEvent": "STALL_SLOT_FRONTEND"
>>> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
>>> +        "Errata": "Errata AC03_CPU_29",
>>> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>>>       },
>>>       {
>>>           "ArchStdEvent": "STALL_SLOT"
>> 
>> 
>
