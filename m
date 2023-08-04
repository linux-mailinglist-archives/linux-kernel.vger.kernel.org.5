Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87B770926
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHDTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHDTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:40:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2197E7;
        Fri,  4 Aug 2023 12:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFftNMENjX4aZX/iY8Sq4bOy6Jfe7LSeQx0fK1k9ma5dQ6h+SK+A7G+vO76FmvRFBCVjKig1FeSkecqTUGxxEs1bD3KGE5kARgPa12U69xeLXccB++mwEcLJPc2nTpeg2PPhUCW5bmQW+5ZBK9/UHkQrku1VA5cI8BaggTBMihJE7x6mRG3XGTiB8vtKuJZFE3HivMApRV1lKHK9MI61+gaLdKUWcseQCh3+mFLrr7AGPi/T56h77cFuv5oMQYE7lxIbM2+ROU4RnaFc5Df73Dy/btKa/nYk4aBDom0Nsq7ggHxM0ouo0E/JRko8S2ZZ+xiCuRK9PPNbHqOJHPtZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKPAYwcRj8oWsc4yBSmVz2y3WCUJqIx6WmYInC2+76E=;
 b=bCNpkEAudJMUqmIwhJhZOn3h6Euk01hVCAXsDzAZx5Z772Nvvup/hD0c7ZibUpdMVxba/XMbWJ5AFwZfcfCNTdlpXmwATC2o8vo6XPWXssmQY+7ynZRK+VanNpaQgbeJ4Bn5M48gvCxXZ0/iCNeTZbgOmtvGZnj9F1bNw1cKreduCHXic+0nfAhK2c1jF1EBauCYn0gGzySO0XWImDJ6OTb8Lxvs6W5qP2VvU6Fn11JD1c2pUGjbLNftkeT0Sa6WtHkDJQWBO9LGV3wnJ3JoHGqSxJZFFQ+IWkhcy2epu7PaEr+u8jjUb7bdNcHuIuBoRelfP/wgprXzHFIbaFCnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKPAYwcRj8oWsc4yBSmVz2y3WCUJqIx6WmYInC2+76E=;
 b=qOeo3wifx24lMSd7OGgjleObA5Qh4NliwOdsID8eepEaLoyRlkNSm+fv1Zej6F/nSqr1n0eo5W/lzX+PBxhM24Ip+GO9kU8mtMoy7TkN69Vw17nmI/9L21Uzkwiz4DG51x3sVoE/GDdvCtpM1wlGTwBEjAJT8XiZbHX13NJlcV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6701.prod.exchangelabs.com (2603:10b6:806:1aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 19:40:10 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 19:40:10 +0000
Date:   Fri, 4 Aug 2023 12:40:02 -0700 (PDT)
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
In-Reply-To: <b690cae6-ee9c-2c6b-a19e-60088cb8cb19@oracle.com>
Message-ID: <d3da2a30-9e9-73c3-b1aa-aca508bd259@os.amperecomputing.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com> <20230803211331.140553-3-ilkka@os.amperecomputing.com> <b690cae6-ee9c-2c6b-a19e-60088cb8cb19@oracle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:610:76::35) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d087235-3d9d-4ead-0f42-08db95229d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRXaTJMdU7NHQ+T8+dCsjV4BdCvhJtIZQF0JSlhg98+CEF1Yv4QPjjRB+3Y79IAKTPsyK7FOyTuFapsEEPW5HmPerrZQqrjJrY1ELwWhUm5lUu2OtQygkrtQHFGs6YTRGgAOKaMRBoioTochy0AlO+7JD1fnHraWUY8aaoXTPq5BayniwcCBU7iYyINOAI3jpwqeeZGFKHBmO+kbgx8tI6YRk9WpNR+i73O5iN7Qyuxx1UItmbtHVij5QihPNR8edL19U7wMLJ3E6vwvLnYoXzC3PpSncbZnbmam4GZz1Ip2180enYc5aKKftnN/Uwhl0T9blJPpvSc/RPmL0yMuqLVReBmELScBwLQAJyCb6IIi0oP/nfxUHSqs1kmuJ4XvupXKcO7ExsIM37E19gLmvqUw7DGSDuz5+fu3REHOjZq11CXwZFItCEnXvXQPCVheYNZAIrvBgvtXT+Zg4fUitX+zSFh5qkCBhb+YK+DGdb1NpMJALmwr+Emis70DjfAv7MEcEOfbapm6oEmqMMWoBVRJRpQ7a87BjLNvxLNnFZNKH5qBzkn+YUBZADrflcwT8xxVxmtYcOuqCqX8lu/+nfxURGy1y75DkyAdAo47vcq69jMErGU2njKdrwml32BD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(186006)(451199021)(1800799003)(66476007)(66946007)(66556008)(4326008)(6916009)(2906002)(2616005)(38100700002)(38350700002)(53546011)(6506007)(7416002)(83380400001)(54906003)(86362001)(6512007)(26005)(478600001)(6486002)(52116002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ns88MOQU19HfK0YpdhYyNDiQa3DMfXh/WAAADllcRn9/ycfYZRKbA58QhTv4?=
 =?us-ascii?Q?eLhGqjl0Hw08EhoapYCNJh3/nL02DzHe6rauZ7FbKEK+DXJN675vm6+PS2Dx?=
 =?us-ascii?Q?7uOBnrwN1mzWIoKybb7MvgnR+HwV0jwoHJGQDYsQD1ay7ZqQVagQeRLeX5e4?=
 =?us-ascii?Q?AZd+X53R7zehWnxt0GWdnnYHKIvKw09A64aCrdwMRz3RQdWPFmxm6wGNviAk?=
 =?us-ascii?Q?hy0IAIaBShrdDAvxg7WReGD8ze/7D9Ch2np7CAQ6pAOZHKCgBKHyQleYuV19?=
 =?us-ascii?Q?9/w8efqvnF9XyqTj9fmeeFofAMYf6GqkDUmzdRyzqyU0b8LnIWRb4G1n2q8y?=
 =?us-ascii?Q?MO+0DqWw/yrEO15DUue9DOBEdRp6/3O13EgrvE5j6uNo9MftHoPsApV8RaM5?=
 =?us-ascii?Q?y4PXbyZz/I5wsJETC+XgtKz0vb5k9Gk8TfZ7SGhs4YufofP79Q2gbJK23bZH?=
 =?us-ascii?Q?BxdvQoJiD2DJ/TdwoiLoYZ14z7bUIFy5cnfImjAD7qOL1ePIb99H9tYUdSDk?=
 =?us-ascii?Q?KWr5FMzVcxRWHzIQjMvPQJY46FC4lPWDB00pAA2KGLT/vLjUl81BT/jV295z?=
 =?us-ascii?Q?eUNeGCoknMrHuXJoEshnVN5djIOxNG8k7Hu6V6Dei+a1IGEiqxT6FxZKLPe9?=
 =?us-ascii?Q?6QTr+4BfQl6VDUHByeJY+kghcM/iGeuw6DUP2L1qUwu85Zn7oiNzaHPU0/H9?=
 =?us-ascii?Q?xSicJQntxFP0j6mapb1aFqxkfAs1593mNn1xJQbbFC5HNjHyxGPoK/A6hHSI?=
 =?us-ascii?Q?wBLhkpSEk7A4b0aGpi8VJBKL2aGMyMjs/YY00hWjjRHdJkmEuf8konY5Fbf4?=
 =?us-ascii?Q?K7xr0F2Puz+Mw/fkcsh44hj6iMv1i4jUuGOb0R+vo8OJR4xPmnJziPCumdT1?=
 =?us-ascii?Q?te5H3N/Yw2k4ysAtkckQY1WW88tXbR9w+yQO99vN2WcTi6SfQ3tV9atEmU8G?=
 =?us-ascii?Q?1z1G0vmiwB/bdlG3JUNCRY1VemtxPcNW5P7LiSWyl11h5GYKZgxnMQi0s2tX?=
 =?us-ascii?Q?7GHSF1tk1xeLc9vU9k4C/W409aA+KwFlSJviS5qq2WhBwtSSyD2IIE48Ht+Q?=
 =?us-ascii?Q?6t3rPMh9qpeP6qs4SK4dSxuywiqWto9l6tvY398h8/b1/dZ0toIGpPEjHBl1?=
 =?us-ascii?Q?zMSA9ZSBTdJIqQ9PAlxnZ68Yk//048ptN12PUv2LcnTI8SpWfJJKcxdODTBF?=
 =?us-ascii?Q?Vts9iLnqVTPVqqFr+rh1YLt0damukjgV/b3p8xvbC1eXPqBLUuQHL73N/AlG?=
 =?us-ascii?Q?ODSjLFN711HbS7hH21vV/LoL98HfplHPDbte6a7XQj6G2U79gFZD+65Z6w15?=
 =?us-ascii?Q?V+m6ITdMpdWqNt5qY3M94+rGN5SP6o2DDD34g5qUAeeBAejkaKKvpuLBv5nV?=
 =?us-ascii?Q?70qz0E8MAVGpdOfFAHx57UkfIhuthU5rSHDUL7gewyfuNf29n4ptji799v9l?=
 =?us-ascii?Q?UJ4ohORgLSfy/vJEUarLzyXrA+Ge9j1OTU783MBJHraaFEjifjbecyKdy/ex?=
 =?us-ascii?Q?ke3/f8U6deXx3Om0pNSINuQlNKA3683k0eSu5YvDfGuyPqYg7pmaffi5Kj4I?=
 =?us-ascii?Q?ecVvJxIpEZnZed60FiBHlzYKA65iMwA4ZoLFBvHUjfsou9mCcEnRp7s3N2yi?=
 =?us-ascii?Q?PrRUUUE0RipS8koSg9CYh/I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d087235-3d9d-4ead-0f42-08db95229d37
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:40:10.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUSP9Z7z/+ix2CH01RqfMvBwPjKodVsKKzuzZHOB3d5iNTQhcqNfoUj9SN130JJg7QFLHxG11ZC6BAJX1vYnHiBIsSBS5vOsPhBhGHuY30Z6kByTr5UFmmgpqO0NW+mG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6701
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Aug 2023, John Garry wrote:

> On 03/08/2023 22:13, Ilkka Koskinen wrote:
>> Per errata AC03_CPU_29, STALL_SLOT_FRONTEND, STALL_FRONTEND, and STALL
>> events are not counting as expected. The follow up metrics patch will
>> include correct way to calculate the impacted events.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
>
>> ---
>>   .../arch/arm64/ampere/ampereone/pipeline.json        | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json 
>> b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
>> index f9fae15f7555..711028377f3e 100644
>> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
>> @@ -1,18 +1,24 @@
>>   [
>>       {
>> -        "ArchStdEvent": "STALL_FRONTEND"
>> +        "ArchStdEvent": "STALL_FRONTEND",
>> +        "Errata": "Errata AC03_CPU_29",
>> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>
> why end with a '-'?

That's a great question! I wish, I remembered why I did that. Looking at 
other events with Errata field, they use '.'. I can fix those and submit 
the patchset again.

Cheers, Ilkka

>
>>       },
>>       {
>>           "ArchStdEvent": "STALL_BACKEND"
>>       },
>>       {
>> -        "ArchStdEvent": "STALL"
>> +        "ArchStdEvent": "STALL",
>> +        "Errata": "Errata AC03_CPU_29",
>> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>>       },
>>       {
>>           "ArchStdEvent": "STALL_SLOT_BACKEND"
>>       },
>>       {
>> -        "ArchStdEvent": "STALL_SLOT_FRONTEND"
>> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
>> +        "Errata": "Errata AC03_CPU_29",
>> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>>       },
>>       {
>>           "ArchStdEvent": "STALL_SLOT"
>
>
