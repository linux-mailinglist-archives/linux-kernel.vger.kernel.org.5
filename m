Return-Path: <linux-kernel+bounces-43949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765AD841B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC4CB23D43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01348381B8;
	Tue, 30 Jan 2024 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="J5BH8ojU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB24376F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592552; cv=fail; b=q2/geHlobKeYeQm6QomwT3RhkEG0XrtA3h/YuQQ60FLcqrIxhJYIc9mb/U+yRVs6HjesZhJ8MRhx2XiyrK1DU4KSDCo67JhIQiy/+IRrc2HFcaUWis2yDllXYtA/U4q6rjFTn6B6M4MCpVAYBVpPaOmRNJGIVsJ6auK7fAxSlW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592552; c=relaxed/simple;
	bh=+PtAAMz5QTiBe6tK5XVIZHFKb4ZesUsmDjGlvgpARPw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=GX+E9y0tAML0P6OMSEShvrX16aQwLtRbUIF3GN8o2AraiALXWjvFaMg6mH5a4FMnWJQKZhX4Qh/exdjRsLv389f8ALCkx+uvArGuwGtdoS0SqdIS7ZeeS1+TS/SGYkEY3GMADSYfOrEvRUL0UhuBuZU6s1vI46Hj/qEWT4kZ4/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=J5BH8ojU; arc=fail smtp.client-ip=40.107.94.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9Evc44BcQnQf3iiDzstud695KvgWSguz/i8caTIIDFHLl3P3Fl0ZAHoIQ5Wf9qk97r761kDg7uSO+FmmtlIcqex7zaPmIcNc6cwM4xZXuL3kbHd7KJfNIha/iuuWcJSSZHGfBek/EPrZG25WFKPvUVEix4eKOhYd+2xTmy00q2sxag6PIXD7YH2Rxe8Po34kZZWNzuCJOW9vrrw/J62xYHrVkBJRzo1KkOR9QIzKaGrTcKfORg+7fbX6Sg9EAfvWWMsHZfTtXR6bXmTIZ3aSD+cAtGUHuGIjoWodiGaMf/M1L1AdsOS+ONA0keBGhkocjzUlksWoF2FSTlQ6WET6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaTSE9YkPW1tKllDtipiKDWQujBV7Y+Mlmm9C1YMkPs=;
 b=Zb4eCkfkwTBBvq/9xIRLqtylRT6TS9fbViZYzS2A5C0doyr1IUaHAuld5xTgMv8RPB0edhIpSlZo9PxHC4WHUXpZmN6A8i6RYfSsHLFtVYo6qpaqKKIrVBNo1lEOGUPX13SOHcD1pq27PMOG9cyuZBNnzMD8yddtt/cFqvVFljAqdqogfnBEdrOzROuFhUoDiCJzKIfY5/ishqoVq6suGTWwcygLA+W2S7g5FnqW9vVK+fNa0iuAyIZxNgnk7dRY7yJpUBAs570xvYKsu3ws6LXh2zEoG9gIjitKwcxNgnfdLQv2XQieiNzEWo1uVpaWtlm3L56/DmHO1eZOvD704A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaTSE9YkPW1tKllDtipiKDWQujBV7Y+Mlmm9C1YMkPs=;
 b=J5BH8ojUtpAcLh42U8dDFRFdl2orzPnPznhkISD8LV/WugzL0gBom+bvQ0amzcyOvxAVvsYyoY2jWHlClkht4JF0imh62j+Jx65C77B1KX4R3zCb872834Krgu+nXvVXssKc6RalcTh7sJMYzUj4b9ub1TumlzAqkeCqCXzcPK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB7349.prod.exchangelabs.com (2603:10b6:510:101::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 05:29:06 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 05:29:06 +0000
Date: Mon, 29 Jan 2024 21:28:42 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/arm-cmn: Decouple wp_config registers from
 filter group number
In-Reply-To: <41299a7b-d0be-4647-8b78-c347bf931d26@arm.com>
Message-ID: <9428322a-72cf-b834-916c-598ab3e0d155@os.amperecomputing.com>
References: <20240126221215.1537377-1-ilkka@os.amperecomputing.com> <20240126221215.1537377-2-ilkka@os.amperecomputing.com> <41299a7b-d0be-4647-8b78-c347bf931d26@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|PH0PR01MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 33656e3f-9b96-4bb1-c803-08dc21546091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GpKR679cStakY2VKZcJrQKMTMeICnUVtYzN2Kz/7eDMtLi1iV4oLqJ6qLWT+6bmzq2HQtdvEy53x41YyuRIyA72YiQn7GNyARgOxwQ8H33eHn+CweSVD7A3IgNGRSBIgJA/J62JFPezym9z50pwYDV6QybLqDJ/6qywqsx8z1Le5guIvlRUmgRdZj8oYbdV0iYQd2Ii/EVqGLsnKVii/+2T726wg8z1iTnr/6p+aM4cW6VWWD6wWvENFs1fcDL+uXeWVUIFv/99VixolVz8Yn7D8x4s6xBi6jXeUGuLjbRptHyNuEUnfXJmZWj3HBRMsJSkttWm97dntITU2RSS9s8uftEMttNLxNQPKAfS/9GgRZiko3McP7DEtmfO+S0QeeG7J4aSCsrP00Ptqgrr3HlSo9cYVXip659bNhGUcTiXZoIM2+T+VNvLUTijxHfeeSCW6w0fn58jCYX4ho37eneYeHIdaUQlpv67mGb/PHxX/bvK5OlXXY53K4KdR545B4GEfTatmD48TzB2c+97zKOLx+m6TcrOcrBBQWRsDHHd07+b8EbhX1YS3txPTmsCWzoGVvGVK8ubnacbAbEJZF7I3DuZIgIcD552bJ404Yva4itXaRXAM5Q28S+IySTpD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31686004)(38100700002)(316002)(86362001)(6506007)(54906003)(6916009)(66946007)(66476007)(6486002)(8676002)(8936002)(53546011)(52116002)(5660300002)(2616005)(6512007)(478600001)(4326008)(26005)(2906002)(6666004)(66556008)(31696002)(83380400001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHH4P0lZePVAGj5MxzYmmpqnStArf928Gwb3TEpPxfF4JA5Jtr9H8UOexdE3?=
 =?us-ascii?Q?Zzjnk/SInPHhm/so+3N6vMPeSLqUbL5mCcDk5g3a/kzhKaRcW9F9bJtVHkhd?=
 =?us-ascii?Q?2Zdb8uik5se3rtNMs1EPN39zkfUFACWu0Dw7BEd/Y6bS0/8hElQH65UWZOpZ?=
 =?us-ascii?Q?Xx2Lfj8qw402xX0yLIuFD4v7vrLG+5EzokRx+MkkhQ1kKJJxgoSvN0Yj0AUU?=
 =?us-ascii?Q?ISs60LjVW6yvLDIi0IQilOmhd8+He5HSmKOXyen8aB6GI1jE+C/qLSgOeNzx?=
 =?us-ascii?Q?zZJU374oeyS612eTwcH6BRTCvpop/IZOM9W8uXOBWOm9elxQutwtxxwzPuob?=
 =?us-ascii?Q?GZVLRV8sEEsLsxvRCq7aK4Vb4RxzJfvVgXtV016Yy6BkrNr2coh8aUbEopNW?=
 =?us-ascii?Q?5xAKLfA9oNMr+8ZxIG7mK03fzppRzquF0mPuD5chObtQSityhSVxzkdWIsIC?=
 =?us-ascii?Q?wxF+2mZ90jvcdyOpS751NJ3sbXMKh8P45vHcUJ8h/pNeW5dIV2DZKTcyHK4p?=
 =?us-ascii?Q?Y6f8hZV8qj/Rp3pYbLhQ2jpmxQMbWwX5gXoA8vExFe4RV0HvtlTVQsGINarj?=
 =?us-ascii?Q?fDcEk0ZGvmRO7s29L2EksExeB3xGgqHndqr6A9uuK8AjENfDk6Un8LRtDdWb?=
 =?us-ascii?Q?ZjHhnznB4P1QSLVRgPr7cWNsUfi7PevmmvExjOvaf/oSETNeDb79loXDORPZ?=
 =?us-ascii?Q?0CblB7wy4HkrXbU8TNlB1dtfh9BEfNuKcUsCKA1DJE7jxJBQV08Ejk04dm7x?=
 =?us-ascii?Q?y18N6SEZg69SrbybQOLDoGcRob8E8zn/ZWwBVK9GGfbBGebzs/kkU0wb2aIF?=
 =?us-ascii?Q?lZfyivOjA6AZytwp6bA5nbTLkEzjWPhW+RJs2YgcsQe99zhZwdfYl3/1ZO/o?=
 =?us-ascii?Q?LWthTGJNIuhKNxHCWi78+00VVsnUn/528npUPpluB188JgPlMkrhQ31EhM4j?=
 =?us-ascii?Q?AyOXoiVDDBRvj9/Xl0e0P1tt0Om8EjX1mtq9GucupfT54Eu7xFh1JIJhiMYE?=
 =?us-ascii?Q?rLi4M1sh+K18eWIyMOL2y4s50bnOxBqSyINRt2IwNyV8oHzEOfKfPOwSwWfN?=
 =?us-ascii?Q?SliPm7reo+c+CMNpR2HXv7J4DtkXy69jLsMJvNOJu4dK+oCLtXipEfMq9GRa?=
 =?us-ascii?Q?6E67CpvdnoszQqwZBPEnPLl9vj6GzHeUuT/2nMNJsHVBuRjCQwJVHFpLgQq3?=
 =?us-ascii?Q?RxvurMpc5TaPy6ZBPZLZL0mi8ds+Lk5lmzs/4/fcgHi+BifZSr/uto4JYTC4?=
 =?us-ascii?Q?6qH44sWgfzVZR2DZ0LJILeLUvLR2I8XOy/P+wKS/ygAKW/7Z02NUAjUhN1Gp?=
 =?us-ascii?Q?RKpCPaHm7uQAU+ivGGtA5uQ4ohajtvUxYBclUb7Vc5TbhwDkaebBToNVkeCi?=
 =?us-ascii?Q?MPr3ykS4wO2s3TqdDA7LIKj7qs5opraeTKg4L5qufzU/XuUTdqnx7P6u1R2L?=
 =?us-ascii?Q?cm2BFiJfethTHmdfYWAJRklwPUbqhgdBjKvgzq88QVQxnuG92IBsS9sUeBje?=
 =?us-ascii?Q?v9E+67a/YwK9kPHN1+5rkPQgTscthg7YQzTHeNvSyFp4bmPQZXONJr51xSAN?=
 =?us-ascii?Q?a2R8Ur5sjAX8ehKVSRBlodfeDXxnzjDIDvf3py2M96FkmifVLuWEtQhRdoNi?=
 =?us-ascii?Q?yO6S4Wk7xYFhObbQD7OcHJQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33656e3f-9b96-4bb1-c803-08dc21546091
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:29:06.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VFH2tPgMQ7MKCJIzT0yttmkw5yLojsQe+1ksKeHx5iO+OWDZVZBs1nkq4+PyaD/t01NcH7TgtBC+nrtti3y8SlzPJ7RShTRLNzXpWyxVX0zaG2VPQq6itiB4ulXkqDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7349


Hi Robin,

Thanks for the review.

On Mon, 29 Jan 2024, Robin Murphy wrote:
> Hi Ilkka,
>
> On 2024-01-26 10:12 pm, Ilkka Koskinen wrote:
>> Previously, wp_config0/2 registers were used for primary match group and
>> wp_config1/3 registers for secondary match group. In order to support
>> tertiary match group, this patch decouples the registers and the groups.
>
> Happy to see you having a stab at this, however I fear I you're in for a fair 
> dose of "if it were this simple I might have already done it" :)

Uh, for a little while I thought it seemed too easy but decided to 
continue nevertheless

>
>> Allocation is changed to dynamic but it's still per mesh instance rather
>> than per node.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm-cmn.c | 52 ++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 43 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index c584165b13ba..93eb47ea7e25 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -591,6 +591,7 @@ struct arm_cmn_hw_event {
>>   	u8 dtm_offset;
>>   	bool wide_sel;
>>   	enum cmn_filter_select filter_sel;
>> +	int wp_idx;
>>   };
>>     #define for_each_hw_dn(hw, dn, i) \
>> @@ -1337,7 +1338,35 @@ static const struct attribute_group 
>> *arm_cmn_attr_groups[] = {
>>     static int arm_cmn_wp_idx(struct perf_event *event)
>>   {
>> -	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
>> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>> +
>> +	return hw->wp_idx;
>
> Sorry, this breaks group validation.

Clearly, watchpoint group validation was missing from my tests :(

>
>> +}
>> +
>> +static int arm_cmn_wp_idx_unused(struct perf_event *event, struct 
>> arm_cmn_dtm *dtm,
>> +	struct arm_cmn_dtc *dtc)
>> +{
>> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>> +	int idx, tmp, direction = CMN_EVENT_EVENTID(event);
>> +
>> +	/*
>> +	 * Examine wp 0 & 1 for the up direction,
>> +	 * examine wp 2 & 3 for the down direction
>> +	 */
>> +	for (idx = direction; idx < direction + 2; idx++)
>> +		if (dtm->wp_event[idx] < 0)
>> +			break;
>> +
>> +	if (idx == direction + 2)
>> +		return -ENOSPC;
>> +
>> +	tmp = dtm->wp_event[idx ^ 1];
>> +	if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
>> +	    CMN_EVENT_WP_COMBINE(dtc->counters[tmp]))
>> +		return -ENOSPC;
>> +
>> +	hw->wp_idx = idx;
>
> I don't really get this logic either - we can allocate a potentially 
> different index for every DTM, but only store the most recent one?
>
>> +	return hw->wp_idx;
>>   }
>>     static u32 arm_cmn_wp_config(struct perf_event *event)
>> @@ -1785,6 +1814,8 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, 
>> struct perf_event *event,
>>     	for_each_hw_dtc_idx(hw, j, idx)
>>   		cmn->dtc[j].counters[idx] = NULL;
>> +
>> +	hw->wp_idx = -1;
>>   }
>>     static int arm_cmn_event_add(struct perf_event *event, int flags)
>> @@ -1794,6 +1825,7 @@ static int arm_cmn_event_add(struct perf_event 
>> *event, int flags)
>>   	struct arm_cmn_node *dn;
>>   	enum cmn_node_type type = CMN_EVENT_TYPE(event);
>>   	unsigned int input_sel, i = 0;
>> +	int wp_idx;
>>     	if (type == CMN_TYPE_DTC) {
>>   		while (cmn->dtc[i].cycles)
>> @@ -1822,6 +1854,7 @@ static int arm_cmn_event_add(struct perf_event 
>> *event, int flags)
>>   	}
>>     	/* ...then the local counters to feed them */
>> +	wp_idx = -1;
>
> Oh, I guess this trying to avoid some of that issue, but I still don't think 
> it works - say we add an event targeted to XP B, which sees WP0 is free on 
> DTM B so allocates index 0; then we add another event aggregating across XPs 
> A and B, which sees WP0 is free on DTM A, allocates index 0, then goes on to 
> stomp WP0 on DTM B as well - oops.
>
> I don't think it's going to be feasible to do this without tracking the full 
> allocation state with a wp_idx bitmap in the hw_event - at least it only 
> needs to be half the size of dtm_idx, so I think there's still room.

Yeah, it was supposed to be simple and stupid version until I'd have time 
to make the allocation per node. But the more I think about this, the more
I start to believe that the bitmap solution would be the better option
right away.

I'll take a look at better solution although it might take a while as I'll 
probably get other more urgent tasks soon. If you find yourself with too 
much free time, feel free to take this task ;)

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>>   	for_each_hw_dn(hw, dn, i) {
>>   		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + 
>> hw->dtm_offset;
>>   		unsigned int dtm_idx, shift, d = max_t(int, dn->dtc, 0);
>> @@ -1835,16 +1868,17 @@ static int arm_cmn_event_add(struct perf_event 
>> *event, int flags)
>>   		if (type == CMN_TYPE_XP) {
>>   			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
>>   		} else if (type == CMN_TYPE_WP) {
>> -			int tmp, wp_idx = arm_cmn_wp_idx(event);
>>   			u32 cfg = arm_cmn_wp_config(event);
>>   -			if (dtm->wp_event[wp_idx] >= 0)
>> -				goto free_dtms;
>> -
>> -			tmp = dtm->wp_event[wp_idx ^ 1];
>> -			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
>> - 
>> CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
>> -				goto free_dtms;
>> +			/*
>> +			 * wp_config register index is currently allocated 
>> per
>> +			 * mesh instance rather than per node.
>> +			 */
>> +			if (wp_idx < 0) {
>> +				wp_idx = arm_cmn_wp_idx_unused(event, dtm, 
>> &cmn->dtc[d]);
>> +				if (wp_idx < 0)
>> +					goto free_dtms;
>> +			}
>>     			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
>>   			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
>

