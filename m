Return-Path: <linux-kernel+bounces-43951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C66841B74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D2A1F259B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF79381B8;
	Tue, 30 Jan 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bdsVzYNp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D4376F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592961; cv=fail; b=bcXJx1Suc7PloTBa01E10AtnY6IRA/lruGmLNuwq6QFPqNG6fmtLioJcyh0SdjllFKHH6ysNAlcIex2j+1tIbfgeFLBtIAWuknVV+EXu/CdaVi5j12w9H4Q7paGOFaEzb9jB4uEu1koBig0SXoSkJSxsspbLuB1L2l/mhpLPDQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592961; c=relaxed/simple;
	bh=xcwebWOGkRzXXNnZo/JLdO3PyZjxrdj6yHyI7bU9c00=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=ZDNVd3H7uSnmxlXkKOZaDAPnr2anlkYI3HNJhT4k+VF7+PZ+kzhYesEYJ3QcurANY+ZZcsxUN9Hkxt6mwrb1flVn8+MmQ5KJW/yZwRsuRCIAqQxtkI0wnf/dElmUt5c0G7MFuEm1LSyNYFUKS/AohbepOkkieBO+W89FvkpX+Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bdsVzYNp; arc=fail smtp.client-ip=40.107.93.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/fIkEDFcxEaCNqpUX35P54aspwJCp0sxoJbsijoHqGT1F8498q5Qdj8lIrU0gWcgp8Vk3wuIpXiLn1QLg5lqabadQlKilnuE+OMhnGTtw/wM9q7I2OgeMoIbxVJZzfZ+hDlMmDgPk5ev2bUawOfXHIMRSBzEk7lPvKGZ59zcIWTHNqUbk8qh2g0OoI19HUMv6yiPkcx5ZnmQ9UWxavF4w0V3RcWtbgLZG0xlt1jS0v0LM9lPWyk7U7HzcBcQJUgc9A8ytRH2NhqHVY1aHBgr4JYka7Ilwz52ilP+74IhVetEWLGmPEjsl07ARUj/7I4hKKuoRqyiWvCa5ULrKQZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMT2PbVMCy9yR6XQJ1ohAVvGPwS0RWaTUGlFTjiJpN4=;
 b=Tghuiu6p/ZUWhg1gCzat2hBq58aqcFGnBFRjXe5QFyStOoKG/oTyvOBRHgZGrBJJcWG0r5r3pb0yXiufRDFRTm39aSYvCK7EssEU9+GrL+1YmB1Qb17wEIHxmEgri/8C83gVFMF6qvStRk7fL90nR7Xss4+VR3aDOKtasMis8ghKkphTwh39LM0bb/MNCsj1zr411qqJSeSjG8CMQzKEXWyYQVbrMRXoRpIbuiiYdItB/Igq4/dpFrJXqA2qQBgbNtnOsRXAyXG1/3XQmdnuOtJ5rnblVTdQTE/fLL2eE5OmJSY80xzfbGLCCN5PY5NL6t5gE1sxxjb+oG66WqmFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMT2PbVMCy9yR6XQJ1ohAVvGPwS0RWaTUGlFTjiJpN4=;
 b=bdsVzYNpgrqRLpKiEBiflLSHafqnf+zhWNN1dbniBdnOgH2EqSQ9CE2S3HVdkwmBLAJqTdPrnlzHANNElC/9enKIVJVtRXXkPIfyFqSgAhlnaq4qTxSfxFwPXTLUxYQT5GrmRPvp3+D/qlKFKHDyG0eg/cXZBcKVoPz/ogvZl9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB7349.prod.exchangelabs.com (2603:10b6:510:101::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 05:35:57 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 05:35:57 +0000
Date: Mon, 29 Jan 2024 21:35:51 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf/arm-cmn: Enable support for tertiary match
 group
In-Reply-To: <154b01c4-2ce3-4b85-abb6-b3baffe4f272@arm.com>
Message-ID: <7cea725-940-4728-2879-529a49bceda@os.amperecomputing.com>
References: <20240126221215.1537377-1-ilkka@os.amperecomputing.com> <20240126221215.1537377-4-ilkka@os.amperecomputing.com> <154b01c4-2ce3-4b85-abb6-b3baffe4f272@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|PH0PR01MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a4d7f6-6801-4526-b383-08dc215555b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3TZpX7NQ7qmLIC3d8IzWs6TrZK89DiH2UAxHtsFPKzIaxkgVcMSSBk4rS2qqDN4k9OZvnkf4yGWCoAcWKDM6QyIUdPEE2bd9oRiS/Zo4J0cH//IzJHME9DrZr+L9IsNgK59IFgqntazVNxfoyIOoe54PR5uftXqkVtISs0Xpj7X26/HpQvAFZwYbbp4x3YZ+RhFFMjyQxLwWuDDMN/pYfuRkQEsAqOtw8WHMkUBOUVoZWQo84hWkoET5EkKR95rB3A12nbONJug/yRoxeVmBhneQf3p5toL6eb2vjTtjfGl6t8vJuDeVzSDA7i/Ibpc5iWmsgoj0X+ok3lfNTlCuLnsFxNZ7Fssvfoj2WRPvilaMFfSFjV1tu0KigWKyYCMSTb2qg2TaJ9Ss9Z3hlBGo/FbTSLpb8cvS96NRq0ajPYgZxMJvj89EfAWnl6uug8Uzkv5iha43OKL/BYYxJUo5q2QjaLJg3eljVHoHLepzVYiM7rjrwophNs3ZbNDiqdOII8tyn1Z7ZYTXYskpvNWdMqS6uTHRfLZlG4C29Fl7q7SnTeXThgKgEk5tqOniEiL8MENqTqUBEHNNmDkyLDlLoSq9N1O9CfZ8T9N3EMTVEnmSobs2+LIpmKv2yjq46g+b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(38100700002)(316002)(86362001)(6506007)(54906003)(6916009)(66946007)(66476007)(6486002)(8676002)(8936002)(53546011)(52116002)(5660300002)(2616005)(6512007)(478600001)(4326008)(26005)(2906002)(6666004)(66556008)(83380400001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBBOYMagWjIib6ib1GC457CssY+uoiPaBt9QGYGODjRoBBVB2+OQxhlhDEnW?=
 =?us-ascii?Q?n4OCLr/w3XRLBzTuwnScV7snB5/F1N1h35UvpalAgdcji9XcNUn521rBWW0/?=
 =?us-ascii?Q?3WY7UeoLVXSo34S6QwvwscvdYbIcMkSpBaCL1TUXsT0Ge8w0rtvF5t/fviHq?=
 =?us-ascii?Q?aDrBMsTsZbeqI5mbR4WsPCSp9YLErZf/qtCrjUgx/vSUhxFZblQ6RlEnx72P?=
 =?us-ascii?Q?rK4kPu78wKUjwHaezcLiMXF1cJpRrop8p1dpmRjpoxb7kdrGCazqkKvLudtb?=
 =?us-ascii?Q?gfzpxlH5pY68iNaTruCc0z2pXmWaRzAbqClOfKf/Tohvgqai7YLEHO+3orcA?=
 =?us-ascii?Q?rnRWfidgy8jRuuxAD0PXaRwyqsfBsu6gArXrw/2E7mZLUTqIv4HqMaUL3nsb?=
 =?us-ascii?Q?SvkkDV2aKLkUFteyxIlID5Ed/y6WnajWMqVJqvu41+DYfWO4e7oC8ZNFuSOJ?=
 =?us-ascii?Q?FHwqmyiL5MRmsxp5PLjgSDrWr0HD50KyR8qT2kAPq/gQWFmt6GdUBJCqVdf6?=
 =?us-ascii?Q?eYDaNBMmS4DNNtuCWVVmcq2SPi5RccQyiw8J3WRm1+YkC/uqowLUEsV+1XCn?=
 =?us-ascii?Q?ZxeI4lOzlG4RfJ5ZqQJM0+Mowccm6OVCyYmv1KwOYDjQEw2vI0Ki7GP5Wa/c?=
 =?us-ascii?Q?aeGtq8XymwKjVAj85iOYQ/+pC6eNr1xzINBFdQEa7F1fOvcnyWNolww7CCr8?=
 =?us-ascii?Q?0XSvkQw4ObbwHH5AJlRBtwdNeKiD1tl2FJFCgWp6IHhU2bon7BiISQ1mgYNA?=
 =?us-ascii?Q?LDf+thdkeiYE/IRcMYq4zHj2dTKI6zyuPn7ZHBPHOy84IFu07/8paAuVugHb?=
 =?us-ascii?Q?ecLUTHp7jbuHymJVZOKwIfXwe57faloIPzgOZVN1EDsyw5xdhu4sW3YYMQpU?=
 =?us-ascii?Q?SJQNPta5c35VmRxvX3arOZ8UuZhO9sy623hdRQewjZ4zE09f9mm+NnR5R+0X?=
 =?us-ascii?Q?rG2jj1fkA5TMr5IXyuce8a7oMKGbXD8uyluqHtdrf1/e8FT2F+T2IkqWUydJ?=
 =?us-ascii?Q?W5cbdFE36Tc1gKbSyhgVrb2V3UjZnRTBu/XP5q+gSYm+K/XCP55i1OG79uSM?=
 =?us-ascii?Q?VaDONfd1b8FNA4AREMVQspbmzQnCl10iUC6ZjfwAkw98LJzo9Meh5KlY8DaF?=
 =?us-ascii?Q?Bp7XOtr7pJurNtEPuT4P2gF+rsgj+21va40IBxn1i6AxsrDXOWgYjwK5YnKF?=
 =?us-ascii?Q?ei2QefjRQjidUI31BphrpNM0/18I+QEHW9eNudr0StjEdpvL6hfqOuenhbp2?=
 =?us-ascii?Q?ETnhSfVBwVn8RAu4LasasJXT2+JjVdQYV5irzmpCAKrBAEmr7/ZZbYX4CnMX?=
 =?us-ascii?Q?LpQrz/b8a2lvkHCrwUkXIwqcB6x4KIHsvGXErKik1U5C0CZxdYsNTOHsUWnL?=
 =?us-ascii?Q?sriXXxAmFdEn5U7q5utunvXksQ7qMrHm2I/K6NakPkjV6Z/K75JNtgReYX9R?=
 =?us-ascii?Q?GkokC3mXN66MOM37I+EVgeIpbitVjtxiL/it4sEI6FI7GqFrpsC2qpPy/szr?=
 =?us-ascii?Q?mGvbDR3QvVqoVdQReAqBSa1SrKiaAPTsOOKSWiTThE516Be8d7NwB3fJDLQV?=
 =?us-ascii?Q?ws4Q9HqYujWikXAOJRrKJMDdqv2xvyWbodcKklvhnAyfsPDtJZh/DYCOn8xB?=
 =?us-ascii?Q?e3GamDD9MrlJfO1hr4ngK3U=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a4d7f6-6801-4526-b383-08dc215555b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:35:57.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYYC8RrN4HdBL5dumut/0p3rqKJ3IytQxj3rCjbcbyzHj0hjPSijvv2XxV78E2smV/Xq8w+4noSLQ1fEXhSglOf0SG8gQyM9QLOWdYWjRJN3bfj8p07pM8lPNZTJ5HVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7349



On Mon, 29 Jan 2024, Robin Murphy wrote:

> On 2024-01-26 10:12 pm, Ilkka Koskinen wrote:
>> Add support for tertiary match group.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm-cmn.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index dc6370396ad0..ce9fbdcf6144 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -91,10 +91,13 @@
>>   #define CMN600_WPn_CONFIG_WP_COMBINE	BIT(6)
>>   #define CMN600_WPn_CONFIG_WP_EXCLUSIVE	BIT(5)
>>   #define CMN_DTM_WPn_CONFIG_WP_GRP	GENMASK_ULL(5, 4)
>> +#define CMN600_WPn_CONFIG_WP_GRP	BIT(4)
>>   #define CMN_DTM_WPn_CONFIG_WP_CHN_SEL	GENMASK_ULL(3, 1)
>>   #define CMN_DTM_WPn_CONFIG_WP_DEV_SEL	BIT(0)
>>   #define CMN_DTM_WPn_VAL(n)		(CMN_DTM_WPn(n) + 0x08)
>>   #define CMN_DTM_WPn_MASK(n)		(CMN_DTM_WPn(n) + 0x10)
>> +#define CMN_DTM_WP_CHN_SEL_REQ_VC	0
>> +#define CMN_DTM_WP_GRP_TERTIARY		0x2
>>     #define CMN_DTM_PMU_CONFIG		0x210
>>   #define CMN__PMEVCNT0_INPUT_SEL		GENMASK_ULL(37, 32)
>> @@ -175,8 +178,8 @@
>>   #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
>>   #define CMN_CONFIG_WP_CHN_SEL		GENMASK_ULL(55, 51)
>>   /* Note that we don't yet support the tertiary match group on newer IPs 
>> */
>> -#define CMN_CONFIG_WP_GRP		BIT_ULL(56)
>> -#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(57)
>> +#define CMN_CONFIG_WP_GRP		GENMASK_ULL(57, 56)
>> +#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(58)
>>   #define CMN_CONFIG1_WP_VAL		GENMASK_ULL(63, 0)
>>   #define CMN_CONFIG2_WP_MASK		GENMASK_ULL(63, 0)
>>   @@ -1298,7 +1301,9 @@ static struct attribute *arm_cmn_format_attrs[] = {
>>     	CMN_FORMAT_ATTR(CMN_ANY, wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
>>   	CMN_FORMAT_ATTR(CMN_ANY, wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
>> -	CMN_FORMAT_ATTR(CMN_ANY, wp_grp, CMN_CONFIG_WP_GRP),
>> +	CMN_FORMAT_ATTR(CMN600, wp_grp, CMN600_WPn_CONFIG_WP_GRP),
>
> Perhaps an easy confusion, but 4 != 56: CMN_CONFIG_WP_* represent 
> perf_event->config{,1,2} attribute fields per the CMN_CONFIG_* pattern, 
> whereas CMN*_WPn_CONFIG_* are hardware register fields where "config" is just 
> annoygingly part of the register name.

Ah, true.

>
>> +	CMN_FORMAT_ATTR(NOT_CMN600, wp_grp, CMN_CONFIG_WP_GRP),
>
> Hmm, I'm sure last time I tried something like this, sysfs wouldn't let two 
> attributes with the same name exist, regardless of whether one was meant to 
> be hidden :/
>
> TBH I think that either we change ABI for everyone consistently, or we extend 
> the field in a backwards-compatible way. If you think an ABI break would 
> affect existing CMN-600 users, then surely at stands to affect existing 
> CMN-650 and CMN-700 users just as much?

Well, I doubt it would really affect. Sounds like extending would be just 
fine.

>> +
>>   	CMN_FORMAT_ATTR(CMN_ANY, wp_exclusive, CMN_CONFIG_WP_EXCLUSIVE),
>>   	CMN_FORMAT_ATTR(CMN_ANY, wp_combine, CMN_CONFIG_WP_COMBINE),
>>   @@ -1398,8 +1403,11 @@ static u32 arm_cmn_wp_config(struct perf_event 
>> *event)
>>     	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
>>   		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
>> -		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
>>   		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
>> +
>> +	if (grp)
>> +		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_GRP :
>> +				      FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, 
>> grp);
>
> FWIW I think something more like "if (is_cmn600) grp &= 1;" before the 
> existing assignent might be clearer. Note that that *is* effectively how this 
> works already since CMN_DTM_WPn_CONFIG_WP_GRP was updated, it's just 
> currently implicit in CMN_EVENT_WP_GRP().

Seems reasonable

>
>>   	if (exc)
>>   		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
>>   				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;
>
> You've missed the "(combine && !grp)" logic below this point, which also 
> needs to get rather more involved if a combined match across groups 1 and 2 
> is going to work correctly.

Ah, that's right

>
>> @@ -1764,6 +1772,13 @@ static int arm_cmn_event_init(struct perf_event 
>> *event)
>>   		/* ...and we need a "real" direction */
>>   		if (eventid != CMN_WP_UP && eventid != CMN_WP_DOWN)
>>   			return -EINVAL;
>> +
>> +		if (cmn->part != PART_CMN600)
>> +			if (CMN_EVENT_WP_GRP(event) > CMN_DTM_WP_GRP_TERTIARY 
>> ||
>> +			    (CMN_EVENT_WP_GRP(event) == 
>> CMN_DTM_WP_GRP_TERTIARY &&
>> +			     CMN_EVENT_WP_CHN_SEL(event) != 
>> CMN_DTM_WP_CHN_SEL_REQ_VC))
>> +				return -EINVAL;
>> +
>
> We already don't attempt to sanity-check watchpoint arguments (e.g. chn>3 or 
> chn=1,grp=1), so I'm not really inclined to start. The aim here has always 
> been not to try to understand watchpoints at all, and effectively just pass 
> through the register interface to the user.

Yep, I noticed that. I'm fine with either way

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>>   		/* ...but the DTM may depend on which port we're watching */
>>   		if (cmn->multi_dtm)
>>   			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
>

