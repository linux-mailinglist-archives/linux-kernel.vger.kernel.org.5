Return-Path: <linux-kernel+bounces-135017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D489B9F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A701F21CDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4A383BF;
	Mon,  8 Apr 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="k9t1jdrI"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE42E407
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564113; cv=fail; b=cBA1+zys3A9s/y9NEUwU2DHP3i0vu6KI08qrvWNGiw5rrCZKWfOtr1aeWfsxN+7iHgweGY4lz5xtNDXJEOGfe+eSYWRkiHlmTuN9zbiShaPpM950tNFfhITzr6W8qwuqoxu3Ua7pYyzQ9c60NCQHfVC0zl4mUOfPo3zzcGi+sQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564113; c=relaxed/simple;
	bh=W8WljTcpjmg4XOu/ALFjRFqVJ1VF8gjpr+Exl41cMbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fIc4U6klPlFvUsZ8TrRkyx6t1uTFRp06I+2MLi3TwgITDGbBPwztlFF1LDprXUkLu3tgak+0e9s1miU4Jw6avg1U3q58A572vzlbTJB8vTaGn3VbUc0N1oNiUi27iglelHb5pCSn6gTJZUI2EAyhu5Xcaa6tMEZzPuIjvJ9iZU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=k9t1jdrI; arc=fail smtp.client-ip=40.107.215.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnXwAbmiaCx8lEugp4SGskcsuG6fhSwQqapqIkzIv9QwRY05yWSkFCfUsdUlW33ZJXXN9/5JQ7Uhd/oI8gcQyx5QymruZyJHfEOyLRJBRALlr3XgTPg09ryjlSfj/goI06PlUnWlO+RukSqT31lHIXkJBAlWI7s4r/XpBiym5wgxxKHun/K8J0GI7KRq18CNbDsUDbObS8Zoljoh/WxghVp8D49GyBaKgyFXjJ1D0bZ1WG8BJIKMzAeFKoEWsy1jFOz+i+CAOOSS7Xs2ZMiWv/F5HhbBYWPZvo+8uQ2E4g4GhohjP+RqK8I6cjs5zhdvm3loc130lhWBFou/lL07mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHfsz9CnqN+agC+pjK/wi3EuzNn0Dz+nDntYzUC2wT4=;
 b=meS3sMFHL4l7YPSzyxyB4sZtgpgKuMdf0w5Pg0091W0oqTdFM1loDCnqkNhs4LMzZDHPuymMe+Me1+YcFaTX+jFRbh6ln5LFZxUCxxbZmNIL/DflO2SJ9YiBzX25LyUUkQYaGccmQcVYfzHF61zFz8hrBuFztvU0kV+zQwPufRc3qxV7LKSaY/w/ct1X/KohShsJJ2ZLXxa00Vmwv2EIthUshwY0QPn46/SiWQlzucofeMLqmtNX/AHSByMawZBaeL1XdxdhuLsniHaAExd2oP3OGaC2DfWqmQdE7RE87+ffSYyN8jJZgTOma+li3xH6kWPJbSuY3JYav4RO/m4m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHfsz9CnqN+agC+pjK/wi3EuzNn0Dz+nDntYzUC2wT4=;
 b=k9t1jdrIOgEi1ulKqnPqw+BKEV1iVrXlq+3O8fBGsGMMPRLdg6jWTb5o73ifjnBNS1mDI7/ZV8Cm8Si46ZCntwezRtf29SIOMCUoBGxJNuQc8tHicD13LuZq/H2OqVPXL05Vpqd/uEeW9jZRiSoAkd/9Mdd1m8WTyhdhjKvuUjE=
Received: from KL1PR02MB5187.apcprd02.prod.outlook.com (2603:1096:820:71::5)
 by KL1PR02MB7285.apcprd02.prod.outlook.com (2603:1096:820:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 08:15:07 +0000
Received: from KL1PR02MB5187.apcprd02.prod.outlook.com
 ([fe80::22c9:19bb:1ceb:c239]) by KL1PR02MB5187.apcprd02.prod.outlook.com
 ([fe80::22c9:19bb:1ceb:c239%2]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 08:15:07 +0000
Message-ID: <bf2b7ee4-16a5-43ba-bfe0-d24ad7ad87a4@oppo.com>
Date: Mon, 8 Apr 2024 16:15:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
To: Bongkyu Kim <bongkyu7.kim@samsung.com>, Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
 <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
 <20240403012132.GA460@KORCO045595.samsungds.net>
 <CANDhNCpvKj6Swer-8DtQEotdnOiqfAg43oZLw_HZs6ogwqPwzg@mail.gmail.com>
 <20240403014207.GA499@KORCO045595.samsungds.net>
 <23fd78bb-76a7-46e8-9523-5d2cab4186f5@redhat.com>
 <45ddde77-a5dd-41e8-933f-36ed0f8cf178@redhat.com>
 <20240405065133.GA5329@KORCO045595.samsungds.net>
From: xieliujie <xieliujie@oppo.com>
In-Reply-To: <20240405065133.GA5329@KORCO045595.samsungds.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To KL1PR02MB5187.apcprd02.prod.outlook.com
 (2603:1096:820:71::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB5187:EE_|KL1PR02MB7285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jx+p6bN12Q5P2mjlp4qEvy1L+26AaRNwoNT/WNuhWYqD4BLwYwvaLSUVQdhPSulixVj7mhkXVG8xLPuCr8+8CxkHm53oA6Py5W8isgHclwQ1wlM9yvR1uXwzpDhBhjPQJPnlmY1HxXro9fk527EL0x+Z9Imrg9FtN3Uzvp/k1HcF85ifTMh+iTEoG6CjgsvZ+NjJ6L1Epe47i0AHoXzmSJn0x4lyDgTARVF3PBY8HSlhbj9LY/o+NWek2DLMcFMEWekL2ETa4IBXPTAtlE9qqRigw917aBrUk1EnE+VbNQYjFDftj/cI20vNntGQUgFyw7lvcjpslxTXLRLy1o1MSgsLxeM+zOsNPwQTEMu6RYvKanQ14pihJT7K08r20jAijR78yohH3cPYUklMbvyJS3d4E9nDMLroQRRIcqATZC2hnt2rNo0uI4XSazlZbyZj4VL+ABjX4bqcu37/UKXQ9BImqBfEZ5Ozcokzh/UF5Xmthhu7tcht0aKbADvBXVWqbljlmk7gdIYktc0wQcSfPvoTcGNqGD/GJgcCP4GZ9PXE2BvfVTJ7wJFspUJNi4Lx9Y2AYMEDl5ok8XvssE4VKm1m8MblZUWuYtVgqcjmEgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB5187.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXh0dEdhdmlzUFg0RFZtTk00MDd2dm03Z2xic1hRNTFDRCtsNE9zeVRsYmNx?=
 =?utf-8?B?SVBPYUQxZmFnMkVVOExpSkxrTkU3ek1pVUdjdjYrNlQvYVJlQXFIVmUzZ0s4?=
 =?utf-8?B?dUZKQ3A0RHRaZndYT2J4VHNoSENhS0ZhRkZOMk5hSWVMak9XRk5vS0VyTFhm?=
 =?utf-8?B?UERzWlcyM0JyM0hSQTJTRFdtalNQZGxmcm9BOWYxSG1KVEpLYlhUOEtmQ3Q5?=
 =?utf-8?B?UVRjVmpOck5hdEc0WWVJMjkrSWhOT1N4dUdMQXUwWXJJYW9ISmdseXFzbW9y?=
 =?utf-8?B?dmprNzdQQ2xKQXVTV1VqSkR6Rmh1MkhLd3NnZWZ3SVpVdnE5ZFRjOEl6NEhR?=
 =?utf-8?B?bVhQMWNLWDNUOXd0TStUTjlDS2VjT1JoS1VGVVRNVnd6eERSSTJ3N0pkTVJw?=
 =?utf-8?B?Qkd1RnhLVm5tVUtSd2tla2ZxcFZWcFlZSGplbk9ZS2xYQXVMRmhydS9vVzZF?=
 =?utf-8?B?UWZUN25nQjE4MERxamVvQ2pQZE1XNFVKVHllNHRpSHM3Y3lYc1J3RUlMYTlo?=
 =?utf-8?B?NGVqZWhoT00veEtIWFhiaU9MVW9aZlJoMkZpSkRnTXNTcnRlUnJlYUxUbFAz?=
 =?utf-8?B?am4wcm51SWNYdXRCWWxOSnhSYjkwNzVtUXVEVlB0TnZuZHkrUFVlN0RJOEw3?=
 =?utf-8?B?OWQyRGpmc1B0OWpRMkwvUkNTY0w2S05nTVdUL2ZnUnVxZ0FCVTlQVzFOQnRN?=
 =?utf-8?B?Y0Jlekhja2JrQjlUOEdWK3dXanhtVkN0Yk9wNWMwUGlncS9iVXRJQm5UaHRM?=
 =?utf-8?B?M2xZbVJ4dTg5djlFRjRWVkJ2cCtobTBvODgvaUJBWmRMQ0RBZS9CMlBDY3BR?=
 =?utf-8?B?K3NUVFc0UE1RMWRxc2ptQ3NVdVVwbHRnSnlCN3NzYkx0YW5LeGw0MDE2ckpS?=
 =?utf-8?B?T1BNQVkwdGJkcFAxRVFaM2lJOEJWaTdQQnBBbGJVM1pkTjRsSXFRYXVIYVZ1?=
 =?utf-8?B?MXZ2dlhKdDNsMTlFeHJqdWt4RHZIRDJscFhtVlllbGRSei9GWGtMLzNwZ1Bm?=
 =?utf-8?B?dmE0cXo4QVZXbjhCalh0d29SZVVRaGkvT3N6b0lSc2U3WTQrUzFyenRkMHZa?=
 =?utf-8?B?Y0hFSDQ3VzJwczgrcjBCTDdwSHQ5QzFPdmRsdVdDcVpRbzdkQkFZYnJkdEpE?=
 =?utf-8?B?SVlpQ3dLc3FjdDV2M2NVdnlISGlQdUErZFR4S3pLN2xvZ3NXRkI1NGpHYTFz?=
 =?utf-8?B?d21wOWV4ekNrbEFnZmNCQy90MjIxeXdMU0dKWk9PTUc2Y2JEbklESHllTkhu?=
 =?utf-8?B?M0tMMnJuYUx2V0pJY2FaT2pmNU1DcTNQUC9oMHVRVXJCS0dMcXA4NHhtRURC?=
 =?utf-8?B?eVphTFdDS3R2K0UzY1RRMm9yUnYwbHhBdVZVd1k0eHNkZGF0THRGcmhUN1NK?=
 =?utf-8?B?ZFFqeVlmc2JSN2lvblNnTFBXdkpnV3NCU1pzY1ZzU0ZwOTY1Y1NkbmhvSCs2?=
 =?utf-8?B?M05YbjljR0VMWGxlcEdqc3F6UFJMZXNSZTFsbVpadnk5allmWkVrUk10OUR4?=
 =?utf-8?B?em9sUG9OT1ArK2dOQ3F1SE1MU1V1RzlqS05Nb1BlY2ZhZldYcmRjenF4S1py?=
 =?utf-8?B?MGd6VUJlTE9URTN1WTUyaEE0aklWNFNhSTF4MzBrVGZUNzAydXpYdmxJMGZN?=
 =?utf-8?B?MGVxK0lPSjlabUpaeEVhRFNHQkwrTmNkUmlROG5CbXhCR05lU2FDY25sT2xG?=
 =?utf-8?B?elVCOTBYcysrOWxjMUJHVnVLVnRaRkhCeTlyVzFmWDVDYVlMRjF0NUZxZjdM?=
 =?utf-8?B?UkM0ZFhwU3BtVnVHNkt2bzEyRHlCUUFEdXM1MW80QUNRVnc0bFhWeGo0TElh?=
 =?utf-8?B?ZEoxUUp3Tk9nMzVoeE5TTzVYcEJ3N0hoTEwvNWlkbTRWZStzTEMzcEVRcVlY?=
 =?utf-8?B?cW5EVERqNFgySUtnRlYvcXhHckNiajZBZy9IQUc5TWc3VXVTSDdiUG5KWmgx?=
 =?utf-8?B?d2J2U3dqSWZQWXZMK3N2TlN0WU1FZFZ2dEhWK0VqZnFIVWNIVm1VVmYvaWps?=
 =?utf-8?B?dTRRTGpDVEZBMFEwNzNXbzM4UTk0UmRlUHloSVNEK0t6ZkxGYWxkL011ckNC?=
 =?utf-8?B?b2dKTk9oSHdEK2J6d0gvWXVJOG1rdlNsdUhuOVBQMkxkN1VVZkdUejdqRjFq?=
 =?utf-8?Q?WMxxAteE5BHFIY1Nk/CRWLe9c?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cd4bf8-be48-4f05-2e98-08dc57a4006b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB5187.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 08:15:07.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ACSulUgtnEYCE1W+A4Ly+caqpcHoTMtAvXV7rlZ7DCWZiGJXTXW3PdC+cVadlb3regqlkNh9dlOExAX3eXw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7285


On 2024/4/5 14:51, Bongkyu Kim wrote:
> On Thu, Apr 04, 2024 at 11:06:12PM -0400, Waiman Long wrote:
>> On 4/4/24 13:44, Waiman Long wrote:
>>> On 4/2/24 21:42, Bongkyu Kim wrote:
>>>> On Tue, Apr 02, 2024 at 06:27:40PM -0700, John Stultz wrote:
>>>>> On Tue, Apr 2, 2024 at 6:21=E2=80=AFPM Bongkyu Kim
>>>>> <bongkyu7.kim@samsung.com> wrote:
>>>>>> On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
>>>>>>> On Thu, Aug 31, 2023 at 6:07=E2=80=AFPM Bongkyu Kim
>>>>>>> <bongkyu7.kim@samsung.com> wrote:
>>>>>>>> This is rework of the following discussed patch.
>>>>>>>> https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.sams=
ungds.net/
>>>>>>>>
>>>>>>>>
>>>>>>>> Changes from the previous patch
>>>>>>>> - Split to revert and modify patches
>>>>>>>> - Change according to Waiman Long's review
>>>>>>>>       More wording to documentation part
>>>>>>>>       Change module_param to early_param
>>>>>>>>       Code change by Waiman Long's suggestion
>>>>>>>>
>>>>>>>> In mobile environment, reader optimistic spinning is still useful
>>>>>>>> because there're not many readers. In my test result
>>>>>>>> at android device,
>>>>>>>> it improves application startup time about 3.8%
>>>>>>>> App startup time is most important factor for
>>>>>>>> android user expriences.
>>>>>>>> So, re-enable reader optimistic spinning by this commit. And,
>>>>>>>> make it optional feature by cmdline.
>>>>>>>>
>>>>>>>> Test result:
>>>>>>>> This is 15 application startup performance in our exynos soc.
>>>>>>>> - Cortex A78*2 + Cortex A55*6
>>>>>>>> - unit: ms (lower is better)
>>>>>>>>
>>>>>>>> Application             base  opt_rspin  Diff  Diff(%)
>>>>>>>> --------------------  ------  ---------  ----  -------
>>>>>>>> * Total(geomean)         343        330   -13    +3.8%
>>>>>>>> --------------------  ------  ---------  ----  -------
>>>>>>>> helloworld               110        108    -2    +1.8%
>>>>>>>> Amazon_Seller            397        388    -9    +2.3%
>>>>>>>> Whatsapp                 311        304    -7    +2.3%
>>>>>>>> Simple_PDF_Reader        500        463   -37    +7.4%
>>>>>>>> FaceApp                  330        317   -13    +3.9%
>>>>>>>> Timestamp_Camera_Free    451        443    -8    +1.8%
>>>>>>>> Kindle                   629        597   -32    +5.1%
>>>>>>>> Coinbase                 243        233   -10    +4.1%
>>>>>>>> Firefox                  425        399   -26    +6.1%
>>>>>>>> Candy_Crush_Soda         552        538   -14    +2.5%
>>>>>>>> Hill_Climb_Racing        245        230   -15    +6.1%
>>>>>>>> Call_Recorder            437        426   -11    +2.5%
>>>>>>>> Color_Fill_3D            190        180   -10    +5.3%
>>>>>>>> eToro                    512        505    -7    +1.4%
>>>>>>>> GroupMe                  281        266   -15    +5.3%
>>>>>>>>
>>>>>>> Hey Bongkyu,
>>>>>>>     I wanted to reach out to see what the current status of this pa=
tch
>>>>>>> set? I'm seeing other parties trying to work around the loss of the
>>>>>>> optimistic spinning functionality since commit 617f3ef95177
>>>>>>> ("locking/rwsem: Remove reader optimistic spinning") as well, with
>>>>>>> their own custom variants (providing some substantial gains), and
>>>>>>> would really like to have a common solution.
>>>>>>>
>>>>>> I didn't get an reply, so I've been waiting.
>>>>>> Could you let me know about their patch?
>>>>> I don't have insight/access to any other implementations, but I have
>>>>> nudged folks to test your patch and chime in here.
>>>>>
>>>>> Mostly I just wanted to share that others are also seeing performance
>>>>> trouble from the loss of optimistic spinning, so it would be good to
>>>>> get some sort of shared solution upstream.
>>>>>
>>>>> thanks
>>>>> -john
>>>>>
>>> When this patch series was originally posted last year, we gave some
>>> comments and suggestion on how to improve it as well as request for mor=
e
>>> information on certain area. We were expecting a v2 with the suggested
>>> changes, but we never got one and so it just fell off the cliff.
>>>
>>> Please send a v2 with the requested change and we can continue our
>>> discussion.
>> The major reason that reader optimistic spinning was taken out is becaus=
e of
>> reader fragmentation especially now that we essentially wake up all the
>> readers all at once when it is reader's turn to take the read lock. I do
>> admit I am a bit biased toward systems with large number of CPU cores. O=
n
>> smaller systems with just a few CPU cores, reader optimistic spinning ma=
y
>> help performance. So one idea that I have is that one of the command lin=
e
>> option values is an auto mode (beside on and off) that reader optimistic
>> spinning is enabled for, say, <=3D 8 CPUs, but disabled with more CPUs.
>>
>> Anyway, this is just one of my ideas.
>>
>> Cheers,
>> Longman
>>
> Hi Longman,
>
> Including your idea, I will reconsider and resend patch.
>
> Thanks,
> Bongkyu
Hi Bongkyu,

I have met the same problem as you. After rwsem reader optimistic spin
disabled, DouYin(or TikTok as you know, is one of the top applicaitons),
it's uninterruptible sleep (non-io) time increased during cold launch.
With the patch set you provide, the blocked time can be reduce from
122.6ms to 59.3ms(we test it in our mobile device with SM8650 core). Now
I'm trying to use vendor hook in GKI to restore the reader spin, and
john said I can share my test result to you here.

Thanks,
Liujie
>
>
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.

