Return-Path: <linux-kernel+bounces-28521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6382FF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25031C23AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1563D5;
	Wed, 17 Jan 2024 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GFFzsh3C"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2138.outbound.protection.outlook.com [40.107.94.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7929A9;
	Wed, 17 Jan 2024 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705466859; cv=fail; b=d3H9CFalv3uqzRIiz8uQkblWaUVeoc/t9v7ySuYqeCQz/eUZPKl+IyTENgBTQIpJxSCtU1OtJFPJHzjNjkmer0FQNOk8d9G4PvF7vBA7KuiAUwgp4ht1MUii917EhPxn+7PW7e2OmgrEmMRS3LbqEV4T8rwkS3yOR1m2WSh6wso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705466859; c=relaxed/simple;
	bh=6fV9M4sv5fJXMLgYC06urs0O34BWutI5kTL4EY1G524=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=R/Xyl4WClKAYBjuZWeHhNEgWOGMRHlODzBVBuBUnt+4kwSsK2c7eGHiC9OeDhVqgwIzGmTAq7cC9YutAB+IFSwmocyRcm5TgNeOPzT/vSpIja3uOBqr5+3/1L3Mlkorzi2dADDTYvGbYxmk7+LLd3UA2L6TT2YYgpkmacBHKu4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GFFzsh3C; arc=fail smtp.client-ip=40.107.94.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhMrxTwS8T1W2DpWHMdKBsvBYlTwD26fZ+DZa/E7XlICv5/gjWT6/mB6pcCO5Pz7WQnF93AHTsZkaEYx5gI41jgZfTcGsBH54xKFczstyNMJUZBTlaOtB/QfoLPTVYbuYzWm2YSjNHtQMM0R6cYi0mrkkwmO8BfZ3TLoun+qVsVeKSE0EoaYrRov/mjseSzIV/5hArfevQ81nwnAD+ZMx+iJdTI2WTk3yBPN9wU1ZburIQsx1bebpKpAj8HoXGu4NsAwAPAhmaXcST93+xTW93ARFjoz/QxcqQ2zkT4JQL6A8gYPLzOzqmwvIqLPFsN7dyzwbbIa9Cevs6m1ft3LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygGWFb0q7nkJU2KfS0Om6ldRmCz176GC6SqdtZ00NWk=;
 b=aKnM6PNLCCCB0H3Vj/vS028UgX5E9+gV4EzKxL59PdVZCMS0ioL9k0hdEsfs1nA/xQGWxYQ7a8DMf2X/SCyJSq9O/moPA4OxWIYJYj6ynUdATRRWDwyeOuOT+yr9N53EvQomLXzHsJpCh+4Nxi8RgmKOPdcq5Qci3bJ83n0GDMpF7lGXC7SE8x/vcz8+x6yLI6/7DAzTXrHEGPhLU/L6ahQo8Oe2trSTo8paz1lBSdq3Vrcp8RPQ6AGSYow+9bf6AUhm6DlkxoFnmEP2a3dEjWW5PNLS0kO17TNzCa0nhbiopIW/PiE7eHw5VixLlSGJ+GLRtgy8M6uHwuvrXnaciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygGWFb0q7nkJU2KfS0Om6ldRmCz176GC6SqdtZ00NWk=;
 b=GFFzsh3CRLYl5Mh0Wi1ghPy2qLhv1qfaafkeztB827kKnRckr6+iQMouo9CMkVfQxuQNHhvbypMkUmlOvtU1dSN/6/n8zOUJ10+Lmt5JymVaYf6cIb5ngUXdrm/Y1PknGtg/ZiXTmg7RtlYM9A9PGHKpEv3JCmt+RAQEC1R273A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 BY3PR01MB6562.prod.exchangelabs.com (2603:10b6:a03:356::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Wed, 17 Jan 2024 04:47:33 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 04:47:32 +0000
Date: Tue, 16 Jan 2024 20:47:12 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf data convert: Fix segfault when converting to json
 on arm64
In-Reply-To: <CAM9d7ch5b9XHzQ-Hb=kPu-6jLyESWqgizz6MRNWb0d-NnK9aqg@mail.gmail.com>
Message-ID: <1834f367-4bc4-4fda-fc89-d2252a76b76d@os.amperecomputing.com>
References: <20240111232923.8138-1-ilkka@os.amperecomputing.com> <2c9f5893-450c-012b-b748-a8fe8ddfae86@arm.com> <CAM9d7ch5b9XHzQ-Hb=kPu-6jLyESWqgizz6MRNWb0d-NnK9aqg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="1372433909-1510186062-1705466852=:2464"
X-ClientProxiedBy: CH0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:610:cc::9) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|BY3PR01MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e757cb-fea9-4964-6106-08dc17176adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P7fVC8/Vea5sMQ2h9dAmMpb+ZEK2oYJJUCnEunqVUiO21tqj5Ig4mkjIweyC8A0psqATRVte+oIH1UpM6qcpGCiWZzxVC7ZYIE0EYfs+3xYITM5McMQfYw+k8G/j5G+2+YjOMbgy/0Q/DzMcsW1JdiWbljEmJuqxZWsjQGt7XcQ0XeV+LkbRoTBqw21imfMPpi0ny25Zu/Ey9kOc3PNkPlB0AYRDhB6adNpPtYOys31RUxgJF7e7Fmaz/1HmyIyu8pcJAXZZTe6UuuenfIKc3fM3Kc+VIoLG6f1ocXqurCNirh1WbopuKs0GfZNJNRwGDPvz7nyer5/833ca94vK42CF6efMA4e6ItHqIvnXIFcafrqjrgeNhPkWmMe78SX/r30JN/avPx6MPEOip4TqChQHweEWnjLQnmw3KW5VvLbVR8zTNxam4CIMP5JzD0ZGHXCfjtBOL7IOjsNIoUQMXzUCeNrggtoUU+SKsYkgO/05hOB1AnVoHtq/WJvf+UXl8uElqE9Yi8VicJg7DSr871myEX9ORm1aBvteMC/ZdKVqgT1IFwsfWuG3dus+vuAxwQEP/FqYqPXk6lBiDBQebDl2wBhghwnkUvTmBbEnRxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(136003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8936002)(7416002)(66476007)(54906003)(66556008)(8676002)(2906002)(6486002)(26005)(2616005)(5660300002)(31696002)(86362001)(38350700005)(6916009)(66946007)(316002)(478600001)(31686004)(52116002)(33964004)(53546011)(6506007)(6666004)(6512007)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d290NFBzRkhkek9ZQmNaUmN0eTdoazJtWlBob2lTbjkvTXpBd1lYa1FGbW9E?=
 =?utf-8?B?YWZIZ0Z5eTcwcnM5TzBkZkk5ZEdKbzJMU1pQZTFLcFIwUitIQW1xaDdQMXd4?=
 =?utf-8?B?SE1QUllJd1ZPeVdpTEVVTFNMUjJ3aFVHTEE1M1lvdUhtTXNRU09rdHE0YXJV?=
 =?utf-8?B?R1lZUkROb2xTSzh5T3orODBUbUtVenZVRUw2SmovcTV4WUhTT0VQUzRneC9P?=
 =?utf-8?B?QisrOVA3VGpjQkFSd3JSY1dYQU9kMklOczk2QS9keW41YUttNDRiTDFHSXNu?=
 =?utf-8?B?Q1JUQ0oxTGJ5WTAxam1LSjdmTzN0a1hEdDdNMGJBT21DNjAzUEE1dmhVVDA3?=
 =?utf-8?B?WW03Uk1jZTB0RERETFpIS1pnS2s0VjloZ1JPTG44TzJjNGNheG9ta1lmczBC?=
 =?utf-8?B?Y2VRUzVrSnFNOC8ydDdzSUU4dklZUWZYOEFTVFNITW5lMGs0alRwM21naXVv?=
 =?utf-8?B?eDRxdFFwSy82YmFoaGpnTEx4RDgxemdWMjkwL2dleVN5YkpmMDVOb2FqZGY5?=
 =?utf-8?B?WWlydGZsODNQNm1rUFJMSnhEVGRJN1dOOWpJd1pMYlpTUlR0NllPdlJrdVFN?=
 =?utf-8?B?aEpPdXJZall5ZGwvWFI2UkdtODJ4QUQrbG94cWtmYlV5VFR5MklxMFJWbXRT?=
 =?utf-8?B?eEFudTlUZEFZdnEvQS90dC9UNmtCamtrcHNuVTVad2JqUXlGMFNOelI4dlly?=
 =?utf-8?B?bzEwbU8yd01YdGE3Qmc0bzBCWjl2R3VoNE00ZllZdmdnRjUxaWE0bCsxcVhY?=
 =?utf-8?B?dTl6SXU2TFMveDBmZjhTY0VoNjhLNFp6em5lZzJCS01QeTFvcjY1Nk9GM0dl?=
 =?utf-8?B?aWRvcmwvVU9DMk1ONVRobTBKZVlBSFpxem9DU2xWajNIcTFvUVhMS3ZHMnEy?=
 =?utf-8?B?Nk5EYXRYdWxOWW5vYmZLNlZaVHg0M1ZhazZoQVpsVzcxcWJVRWpVNkdsaitF?=
 =?utf-8?B?TlJhV2ROTUU2R3J6OW85ODVUUUd3OGpSclgzOU1XNUZXb25KUUJLZ3Q5LzRS?=
 =?utf-8?B?OUJ0U1h6WjhsNmprWnJDYVZDYXQwRHJsSXZrbHc2UVlZMWxRck9pdDRBbE82?=
 =?utf-8?B?MEFSMXBmUXJuM2FySkVZUzBZY2xRUVpoQVAzWXE5RkQyR2Z1ejFHUWhUYUdU?=
 =?utf-8?B?ZTBYSlFpTFJtdEVvZ1o4K1gzdm9NY044UnlDWFJwYWFMbXg3V1BXcGpNMDZE?=
 =?utf-8?B?WXF0S3NxOHgrc3QrQURvdEVRbDc4a3dHOTF4K0tsZjBLYlRsTlEwbDJvWEly?=
 =?utf-8?B?NGEzODZoRVZxelJSdm4yZTlGTDMyaHVsZ1pGOWdOTCtGTUFsYVhnTkZKSXhq?=
 =?utf-8?B?cFpLZ3RuMUM3c3Bub2IzR0RWWWhQUjFaNFpiRHFFTFdTSDBtYXczcTRxSlYy?=
 =?utf-8?B?UzFheUNEOVlndFBxQVNpY2U1dU95TmI3cCt3RTdyK0h6R1BGK1BZc2N1NWhn?=
 =?utf-8?B?UmF2anB3b0Y1cnYxOEVudm1BODNqeFJuQllVeUlWTDhVUERVZzZKRUFtVVNH?=
 =?utf-8?B?M0FlNVJaU0dST085dU1YZkd3c3VIWkRhTmd1TnVpT0cxQ1NURFFDNHdwRTRo?=
 =?utf-8?B?Nkx4c1BlTHY2eUJiRE5ldmhLdzdyMGxUYmVzTDlFRjVuMXRSNGxuVS9wUXUr?=
 =?utf-8?B?eEhtYS8xM2U2aVpSS0VUZk9JODJhUkdEbURDZ0M4cHFxWGRQTy9WNjg1N2FR?=
 =?utf-8?B?VTJmSzJRK0V2OElwMzQrWWRLNEZiMnNrTU1oWUhheWtTRzNSMGxNakxyR2tq?=
 =?utf-8?B?N0VmMC9ZODVOcVFkZHRaOHJWL0YvQk02UXFDSnhBU3lQUXBrVzVodG95cHkw?=
 =?utf-8?B?cFIxYm94RFdCZnBsakl4UlBJSmNINFc3ZzEwRmd5bzBQOHE0U0NUeVZVVXVM?=
 =?utf-8?B?RXZKOVJ1QVdvNXdZWVZrcDVBcldCUmxQcnc3dkVIellUMVZPZnBSK0w0T3hk?=
 =?utf-8?B?MG56TWJiVU0rZFAzSUhLT1hhN2JOVzJaTXRHbmNVQ1NxQWxrYjdEZmY5NUhx?=
 =?utf-8?B?MGtVR2xEbWxmNi9INXpVYzVHRU9sRWN3Vm92Y2E1QmNyTHVRVTF2WENMbG9j?=
 =?utf-8?B?eFlNamg3OU9LT25lUGNlUXVwY29MaHd0WDBWRHI2Q1FGK25jSDIrcUM3ZlR4?=
 =?utf-8?B?YXFJcDhxZzRvZlF0ZXhEZVRGSWJ5K0F6c29ZY1g0ZS81aEE4dXNhNUpQWUV5?=
 =?utf-8?Q?ywYLVTVVLgS1PFUWBiq3f3w=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e757cb-fea9-4964-6106-08dc17176adb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:47:32.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj5xJDt5hggTFoaG32waWnZqM+tLyX3FX8fBQB6DSPmSJ3FxxE/31NkY/ox1lUgoz/3uKAvPvs6H6V8GYs8tllXFbFIlUvw8gE6inCRsL88HAg9asCKYWZXDzSg9iulq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6562

--1372433909-1510186062-1705466852=:2464
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Tue, 16 Jan 2024, Namhyung Kim wrote:
> Hello,
>
> On Fri, Jan 12, 2024 at 3:35 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 11/01/2024 23:29, Ilkka Koskinen wrote:
>>> Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
>>> assigned.
>>>
>>> Running
>>>       $ perf data convert --to-json perf.data.json
>>>
>>> ends up calling output_json_string() with NULL pointer, which causes a
>>> segmentation fault.
>>>
>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>> ---
>>>  tools/perf/util/data-convert-json.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
>>> index 5bb3c2ba95ca..5d6de1cef546 100644
>>> --- a/tools/perf/util/data-convert-json.c
>>> +++ b/tools/perf/util/data-convert-json.c
>>> @@ -97,6 +97,11 @@ static void output_json_format(FILE *out, bool comma, int depth, const char *for
>>>  static void output_json_key_string(FILE *out, bool comma, int depth,
>>>               const char *key, const char *value)
>>>  {
>>> +     if (!value) {
>>> +             pr_info("No value set for key %s\n", key);
>>> +             return;
>>> +     }
>>> +
>>>       output_json_delimiters(out, comma, depth);
>>>       output_json_string(out, key);
>>>       fputs(": ", out);
>>
>>
>> It looks like this would hide new errors on any of the other fields that
>> output_json_key_string() is called on. Maybe it would be better to only
>> wrap the call to output cpu_desc with the if? If that's the only one
>> that we think is optional, and even better only do it for arm64.
>>
>> I mention this because the test for 'perf data convert' only checks for
>> valid json syntax, but not any fields. So we might want to avoid others
>> going missing.
>
> Makes sense.  Ilkka, can you send v2 with this?

I initially considered the choice James suggested but I kind of thought
that pr_info() might be enough. However, I don't have strong prefence on
either. I'll send an updated version soon.

Cheers, Ilkka

>
> Thanks,
> Namhyung
>
--1372433909-1510186062-1705466852=:2464--

