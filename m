Return-Path: <linux-kernel+bounces-79101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992A861D95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777351C231AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020A146E94;
	Fri, 23 Feb 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="j07k74Rv"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2105.outbound.protection.outlook.com [40.107.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A7146E8D;
	Fri, 23 Feb 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719976; cv=fail; b=l60yD/2ffZ+PRu3n6YNBA0jzZdixTzeAz45tHImcazTXL05jcLZjZIoTiNhlk0K9L3SHVfk97Fyfj2CQJXQfJeyrnJyTV4czK0awHdRIZvWbcolAA9aAPKwuc+IxtuUnnmxC8GEUmOTOFygBsZZHacIBtWyM8V1yltFpQhrCdns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719976; c=relaxed/simple;
	bh=CtdJDAa0lgyWnI9fipaTmTt3ftB+eNTc4Jgdd3/eYjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=oZwKrbRrOe7J6V0aYrFy6A13p/d+of0fsDG6fdCbiiKO0rgFVx6Iwec7gIQAANwJLKUCyJfWWK6FmwFbmdreosAUgJEnIThHjW/yFsAM/TBJGaeyBvTaGIrVbrF4pXWcnt4Fr+6a0FXCgNqZZcc01RhtjIfsyVvThHN5to+bgpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=j07k74Rv; arc=fail smtp.client-ip=40.107.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REjoqOsEJWcRoByQ2BubuvfV3aGGLxdmr3TwWOqVBKh/YxevPF8Le2aPSr0hwmlXFQFtuv7UwzjcMwAqbcv+oeReRq/SAeN9puOTguCaWE8583X8G8eN/xWRtaXGbxPLq9qorv9ki229niKHsKHQlLRjPzX6i+HWlf5pEcUO7ggCQMmsh6JEH2s9GaKdPH7Oiha59tmczVuZxMBb23nXcpeD0zsxMqItkdYKucmkMwT3NnPxYQcCk0tNViFiawm15vrAk5bYFpmTTLdp2Ryedlf+ZMHmvTSqjDG2N1NdaztrTcrdXPA4Y5flBdzQpZJo9DJd3hp3KRz/LSrU1fRuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp5+Zzg67A81r52yfYn/gdpLnHgkcBlOjKdBiFB0eVA=;
 b=ecgclP8OuX/PuNyNK/fE9cNVtMwYvAYw+i+WcVBco5v5Q7M3bz+/9xqT5DzsUQcB9wnYfRKtBU9SEhvJ8TTZaCi+iifL1yjbdKjdrXC2/bJn3+zDt0z8INXe8/n3W5g1R+VGqqN90rJC2YbQVL6q4hCRBPNXP2RRM9mC3nAqc+DTVODMRvc0ebKwV/wqKRT0hzDgvOUZholcVFVMTeV/kmns66h6XPgsSNNb4MAWuDT6NE3YklJz/JYFh+bAnTXzBpJDOYDvaTjR1PZcXyxw0u9MCg+CoBlZdSp4AeHrjdxa1U/mJhZizQKknEXmdrmwkoHFZDpOHpCvg4hnNQNxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp5+Zzg67A81r52yfYn/gdpLnHgkcBlOjKdBiFB0eVA=;
 b=j07k74Rvtdw5rDIrRcgQSivTJT8KOk6f8WDhYfb9iVJ564IP3X+1LGDTSgYkaWUmws0ekqsuVm/AhqjjaiE4+7BhUpcYijetCZHpPCShRMKGmWSDxRy1utHUR0RgCNXaJhkJ2e/6XjZ06thhA4y8X1n3z7zTFf/FzUQJ1oAki+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8257.prod.exchangelabs.com (2603:10b6:a03:53d::8) by
 CH0PR01MB6811.prod.exchangelabs.com (2603:10b6:610:110::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.26; Fri, 23 Feb 2024 20:26:06 +0000
Received: from SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2]) by SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 20:26:06 +0000
Date: Fri, 23 Feb 2024 12:25:39 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    Evgeny Pistun <kotborealis@awooo.ru>, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf data convert: Fix segfault when converting to
 json on arm64
In-Reply-To: <CAM9d7cibn7ygfZoHCMNJF0DvRNw4dcyBHSbF0Jm20BaEoQbC=Q@mail.gmail.com>
Message-ID: <6239151a-8a21-27f2-af3e-9b358f8ae036@os.amperecomputing.com>
References: <20240117215101.77713-1-ilkka@os.amperecomputing.com> <d77856e0-50e8-b7b4-734-93be3447ed73@os.amperecomputing.com> <CAM9d7cibn7ygfZoHCMNJF0DvRNw4dcyBHSbF0Jm20BaEoQbC=Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="1372433909-1199438425-1708719966=:2242"
X-ClientProxiedBy: CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::12) To SJ2PR01MB8257.prod.exchangelabs.com
 (2603:10b6:a03:53d::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8257:EE_|CH0PR01MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: e06bdaa3-1783-4c51-56c9-08dc34ada9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lhYB5g+7vh9MVj2VvlB/MNqmIMx652J8+MyEkcq5ngAVlAr14jSLwH5s/Yec0wmPKrQ/5naZTr5e4I8w8WBDKEmUqAPBpCaiy+6mGuZ3VhGpbgAF6rGGrPF9MEd8MV49/VEaG/B7AAs8TLHY6Hy1My+qcwzVTMxTL0xqPPkqxr7DLPTG4ou0TWIUiI5sEBFLxTE6d3E6YTZ+GwU0k9fHjhj/8l9VpgecaiWbL1XCQ5tNnuEWMMmNJ+omyK3B6lhCVZR6Cujtce7O6Vim5Qq9CWTpBWtFvgN6vYKVs3IqRL1kWKnodNz64TgSUsvtmnhk04/0SjW1sk/1pUZCOlnGfZNn1YfGXaJyDdUKFIGWkqI+PPFcyQDcwSVF/63xLFgLOMn4hWH1fTJmKxAoCNffFG7CxeLmR3+OsqDGfE0rWdmrPkIPu8RC9CCPK6HMpML10J9y1RDBeimqLarvQz8XpCo+mZsmUo/ZgW8VPCOq/IBTQc859JaTrt6OcZyk3x6qtfg6U6DVzbHkFMVQOq1w/+xZYJVX5dU9RfR/Zur1KRUHW46HkfGF/wtQ74ncgc3eeYdPG6Ru36oZsa53agqU+H1dJ9weKaQRGo5/n7Yl344=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8257.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TktEK25EampEdCtnNWR3YlVLWm9lcnRBdldYbEJSK2tXV1hOMzdRSlBjci9v?=
 =?utf-8?B?VUk1Nm95UXBYQmFrcVdFZ2xDTFplYngrWWRvdUkzOGxkb3BUcnZCVUZRYnhq?=
 =?utf-8?B?WWxtaWRNZlpjRHg2YlhCRkkweWVWcXdWM1VHbm52NnA4cG9PelVCWW5RNlRT?=
 =?utf-8?B?Y3R0K2t2VEg3am5LY3FiVmg4ZnhkMk8xWjVEWFh6dDBiSEg0alNBQmlWSUZ3?=
 =?utf-8?B?WHd3VlRENUVlZzl5cExEek1uVWY0eHhWTzN6MEhkNXZjbDFPQXdZZThUU0tQ?=
 =?utf-8?B?MkFkaHpUL2ZPSUhINVVWTC9nV0ZEb0NNRWlGN3pIY25FRjRDOE9ZSmg5TkJK?=
 =?utf-8?B?WkV4MUJIaDRtbWVNcFdTM0VpWDZEbDgrcUpBM3FUMUsvbFFRbDlBQUF5WmtD?=
 =?utf-8?B?aFd4OExLQjBtbUE1TlVIVGRvQnZBbE5jditxdnJIbGlpbGprNXFwWHZBLzF3?=
 =?utf-8?B?ZXhUalE2V283dWJtSXZuNlJLM2tGb3JRcXFmTEFSeVltZ1VqTUswY2FXaXJQ?=
 =?utf-8?B?bnNHVE8wK1NheW1lVG1sWjRqSm5KaExaMmIyZFVwdlJUWnA5MXp5K0ZOVDNO?=
 =?utf-8?B?Qkpqd01UT1BQMUZNekRQRGluUjNtZkRFWnZlUG5GdG1nQXNJNVN1a1RBTkha?=
 =?utf-8?B?ajlqREFCeHpQL1V3Q0hIV0hpK2tKNDFac2M2UVVSWTF2Z2ovN3NjUkVGdlVL?=
 =?utf-8?B?RTJUS1dCODdGLzVWekdGKzZobDlGQUZKR3lVaVpLT1pDS2hJVzB2K21JYVdK?=
 =?utf-8?B?Tk56ZmplekthQmpTNlBNM293V2VtNGlkaEs3QlZVZWtlSFZUSFkveERLVFg2?=
 =?utf-8?B?VXVpemRZTlJYbkZacjFTRVdSakN1bVV5bGlET2tXTy9RTGNHZXVYOXpYMmhn?=
 =?utf-8?B?WkgwOFdhYXZOMGlLbFBDOWFmeWlJTklTbDF1b2NiRlBvcmNaZTZkQTRxUzIr?=
 =?utf-8?B?VWlyVWR6MDJDbXR5L1BuWlN6OFdWNkMzVTdPVjdjUDBZeGpwSTViZktpN1hh?=
 =?utf-8?B?Rm9RbVNabFVJcU9xK2tRRFB2M080azBKS3NuZlp4MEpwLzJVRmxFYnBDL1hh?=
 =?utf-8?B?MTFoQXVZUlhVZU9WNEdxM3dGY1puVlBWa3pXRDd1RFN2WG1aQ3V5UnpoUkdN?=
 =?utf-8?B?M2dsY2t1UVF4YUxLRk1IRmF4Mm9Qdnh6cWt6UkRXZGxocS9TUGtQaU53eTBQ?=
 =?utf-8?B?TFZJTk1qWTJzOFl5RVBUOTBxVG13MExOSUFYeVl3NUFpaXZGVFdyMXlsWHhl?=
 =?utf-8?B?TVFVNXRQc3ZJNWx6RjZhVnV0OStyQXhSeW1JZ2dpMDJIdEozUFJDZHdJOVN1?=
 =?utf-8?B?UUlkZ3lNSWl6SEtBR2M2WGY1ZERHY1NYeEVOZTBGTTJ3OHpPdG1EMmgzU1RS?=
 =?utf-8?B?b3NFNzNSUzNFRHJldXJZY2ZzTGFZZGMxWkNBT0Z2Q3kzMzF1L1lmYXM0MzNq?=
 =?utf-8?B?L0J2N0xJU0h1T1lwMHpLT2svamcwNmRVRWJiaTBWYTZCOGZ0VWdMeTg1ZDhY?=
 =?utf-8?B?cnBEM2JOdGJFeElxbGVWdHZYMTVDbmFONlY0R3htYlVaV3ozdkErU2MvWTlN?=
 =?utf-8?B?K3pQa1oxV1RGZUlhZVBtRUdKS1FEcWRadDlVTjBmeTNOejZwei9IT2VONWNm?=
 =?utf-8?B?MHIwV1ZjZm9GdW1lalVjZTgweHRBRk9yN1MvdHloN3d2bUpURW5NamdZTmIy?=
 =?utf-8?B?TFY0dFpLTEt6K2tma2JROWRxVHJmRHErd1dLaloyUE4vUWVTcERxYkJxS3Z5?=
 =?utf-8?B?OTEvc2t0VTdGbkJNZkw5NFBUc2xoL25KQ0hBMDZ6R21kcTkrK3BVRlpSa0No?=
 =?utf-8?B?bTZaY1JJMFpSaVZTYzJJdXQxY1p0TmhtbVN6eDhadHQ0U0ordlMwRUN0ckZQ?=
 =?utf-8?B?blBlZlpUenZYY1V5VnJsNm10bEVialRiU0NROVhlVXB6SGloK1hUdGV3UkZu?=
 =?utf-8?B?M1pVOVVaOWgyNnorV3R0cFNsclFSMlRaMkhEQUpHR2hEdUx3aEEyRzRwSDJ5?=
 =?utf-8?B?YWVkaExKT3pPOWZUU01ib3hObHZMODFtYll0aCtaeUhFZFZsM0dXZktrVUlM?=
 =?utf-8?B?b3lmSlhXNzFoaVJJMFIvOHdqNm9SK2pzU2QvNnJ1bUtsbTVicXp1UW5oUjRy?=
 =?utf-8?B?NWhPNFEzQWhSM3dZV1oyRmVVOCtCTHdZc1lCV08yQU5mMGtKTFVrQnJhVTJ6?=
 =?utf-8?Q?kVkBGIDxcl06x4lm5QuRUXY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06bdaa3-1783-4c51-56c9-08dc34ada9c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8257.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:26:06.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60E9d+Ql3FPBh7rSjjTdKlJ046uW+MZUquUgfuzjSMlDd8twP5YI2vqltRbP+qgtylNeaoPP1fVKVMnk9cN+bfKWmJpB0nyntb00mvqSUtgps0skrjQfCstw95Lkgp0X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6811

--1372433909-1199438425-1708719966=:2242
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 23 Feb 2024, Namhyung Kim wrote:
> Hello,
>
> On Thu, Feb 22, 2024 at 1:42 PM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>>
>> cc: Evgeny Pistun since he submitted a patch pretty similar to my first
>> version
>> (https://lore.kernel.org/all/20240125184411.30757-1-kotborealis@awooo.ru/)
>>
>>
>>
>> Namhyung and James,
>>
>> What's your thought on this? Is one of the patches (Evgeny's or mine)
>> good enough or should we try some other approach?
>
> Sorry for the long delay.  Please see my comments below.
>
>>
>>
>> On Wed, 17 Jan 2024, Ilkka Koskinen wrote:
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
>>> v1:
>>>    - https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
>>> v2:
>>>    - Changed the patch based on James's comments.
>>> v3:
>>>    - The architecture is checked from the actual data file to allow one to do
>>>      conversion on another system. (thanks to James for the feedback)
>>> ---
>>> tools/perf/util/data-convert-json.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
>>> index 5bb3c2ba95ca..405c38371870 100644
>>> --- a/tools/perf/util/data-convert-json.c
>>> +++ b/tools/perf/util/data-convert-json.c
>>> @@ -284,7 +284,13 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
>>>       output_json_key_string(out, true, 2, "os-release", header->env.os_release);
>>>       output_json_key_string(out, true, 2, "arch", header->env.arch);
>>>
>>> -     output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
>>> +     /*
>>> +      * Arm64 doesn't have Model section in /proc/cpuinfo and, thus, cpu-desc
>>> +      * is not set.
>>> +      */
>>> +     if (strncmp(header->env.arch, "aarch64", 7))
>>> +             output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
>
> I prefer checking cpu_desc (if it's NULL) not the arch string.
> Maybe other arch has the same problem or can introduce one later..

Sounds reasonable. I'll submit a new version soon

Cheers, Ilkka



>
> Thanks,
> Namhyung
>
>>> +
>>>       output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
>>>       output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
>>>       output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
>>> --
>>> 2.43.0
>>>
>>>
>
--1372433909-1199438425-1708719966=:2242--

