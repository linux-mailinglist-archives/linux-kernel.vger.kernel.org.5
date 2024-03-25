Return-Path: <linux-kernel+bounces-118077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D588B35B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C141F649A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD871739;
	Mon, 25 Mar 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="a8FojRiY"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2108.outbound.protection.outlook.com [40.107.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E326FE35
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404259; cv=fail; b=SMz2+cycI4PzhuZVxAhnMLB6CSoMiPHtZY6fwG7JNoJHUmnni+c3q04/wrTF8sSpLdRk03xNgifMRbXB14Unb+jbv/to5uWotKoTP+yrQGeLTtVaNzWZcsrv5IrTBLKT1ZxGmZ8yZexwC16vDTh7xVc2EUqGZ6vp9XQwagpIX6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404259; c=relaxed/simple;
	bh=ZUwRLSZPFgtiaUNtPrMnTBsaSkRNtA8OqzCTJJRv0t8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=oSphg6CTjo5lyGzFAQVq7YVfFtFDZkGDLLc0CRVasUNnql/fjYNERArhkCzsJd2O/mFF4hVQrc+OL4EYFV9NENdutSUU73Kpaog2yu9I9K6p82BzrsOzHK7WVPoLRmWGGQG2pTeCTdwe5ake9NSNl7sOzgM9H7Rb/+uOmkPTmMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=a8FojRiY; arc=fail smtp.client-ip=40.107.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZWJfbgb7bPKxb/R7uYkInwQfPXp/Xv7BDXhgmbeLpD9PWwYFb6VqMb4vRpB0tTT9HnpkoNKoAHcPD1O5MZsmC1E4tDtRg6szLc6QDNPbk1Aba58qXiSkUFV2/zlWm9Npw1Xv3wiJuDkzM6L/uX/WfvLOc4pn8vehz7JOy/YyBuElYR1Ij0oC4Uy3raw3gu5NzuqNvUJbAl+/MHhYMsIQ+8QSLcyf0ZuC2L20nq8R7DH5qGNTAusf0ZvE5FQ9AE2gS1YfOk3jDtr+UbfN7tdHPA0YHtUBnGiubbtO8O+DzTC/hQ2s3gRe7+gyKYnHe26u/aNtnSScfJ5Vfptmewdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEFcamFumm2wsmacmL6O8GC4C37kpy7WXpLA2or3VsI=;
 b=L29EeAr9WtV3DArRosJJ6krVTeaMeJb83ImPQZc7a9oDVKYz2fuPRPj9gRkR/RQoofhsaMX8M8GJU56T5atNaginZyAkYB0BaKTqvZ2jvz+gt8kJAlLAJnzPikkPhbG4c/mWXwujPt8RXOz/6zgIR8olqGiPDQuxFEbEANR54a1os3+0H+6WBfG68oHrN7MwmeutyxJeXzqwRyaaDZBJLR9xIusZ79PAolJfYNjp3gSrVq9Klnyuye7SS+DppDp36lcevh/CKuDEaxogSIPDAFlJKjp6y+BVE8BtIQbqaYIPLZ1A91gXQFykXUdxf2kNNUWpBOEeSVUqDneTPgxWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEFcamFumm2wsmacmL6O8GC4C37kpy7WXpLA2or3VsI=;
 b=a8FojRiYIsSXdvkz1d6RB0I379BTEjj9aMLak2Gs32VBomrwwepPUUBDJdSPHZdBMeDuPt6tyBLnl7VoN2Uk6V0Hc0PgOb59QQv/ABtPeQ2xNrSqZnmWKd0gTG/IFq/yFIkxmf0O8yofFd2EoRDVdS0mLbtScXIbjtb3UNUOD9Y=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 MW6PR01MB8625.prod.exchangelabs.com (2603:10b6:303:245::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Mon, 25 Mar 2024 22:04:13 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 22:04:13 +0000
Date: Mon, 25 Mar 2024 15:03:51 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Jing Zhang <renyu.zj@linux.alibaba.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf/arm-cmn: Decouple wp_config registers from
 filter group number
In-Reply-To: <69a17eff-5338-44a5-a53e-4b8142c21bf1@arm.com>
Message-ID: <c9876419-e4ef-4824-2812-e84718ae8e@os.amperecomputing.com>
References: <20240307230929.6233-1-ilkka@os.amperecomputing.com> <20240307230929.6233-2-ilkka@os.amperecomputing.com> <69a17eff-5338-44a5-a53e-4b8142c21bf1@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:930:17::32) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|MW6PR01MB8625:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jmi9Tpk/lDQ4wPeqjLrw/PakittJuATakVBNruzorfG9iOe/iB+bNH1zerl+VzTGnMgae5DWBASSEmobgyAnZQr0XpY2arW25n8z4ZwitTTEFE2yPsl0ZH3NvxT7JxBbYT4B/ViO83+OMX1u0q8WNt/qCN6r6Cx0XO1oi1UWAiOKU7VIFY96S7ddo6L3hIgZt7NrVEDRMzxl6+uZM6r7mtmp8gCF7RgeouY00mRqPuCHH4Y2JOkQxzDdiGDxerkGaFhSnasiVJ1/ECgsgsZN8bEu5btvteADoHnUBCjRsmnXx4Yv+nG45U5jXn+gKMeOG83TNNXJo7e25vF+0tJNk+B1dKaAzqK4xm/Rom9W1lC0Z37v6zmg3tq5HGSbvTXUYqJxpW8U7qn7wcAmr/8ACT71Z8PhJj3KzS/eQ7ks0OBA2Bgusq4BPheMFxSYwOGSJON2Q0Oh2Qug5IEOkdKQU8M+PFA9Jgh716gLwQwdwcV/M62K0qeBpqRnawTYWlNzbQuMqHGNYaA29ODhZ9ecQPjfTi4d48rgGixU5Vbt9WGSz+8PM9fumdt359A/N6BMhoesmE9cIiyBauf+NlPmA0RdyMVqH0p/braDIeMptUZ6bqCEY3w8fFsd0+VJBntPPqeomyHHUbS4T43FIHqMpS9+xj31iOMPWhknzV79pGvj/Jggr9D3Ee5KY/xxrcHupiHwKLJHuLJKz81mIbYSfCl1sirwx7PphJ9Lu7c/RgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvRhFa5WM7+tc1PlsCRV5twiM3b6mCnv/btBPzbTIk5K+gAUygNXAsQg+Un8?=
 =?us-ascii?Q?wUJn0b7OjwD6QZw6C47QOq/oBCkI3QrkK+KaF8SCpIItCAn/oQdR7DXipAzZ?=
 =?us-ascii?Q?D9NON5qbQHmPs20czWrZC32eI9btcNq7xAdldwXk75PrFBZsO7e+6YKuN2NA?=
 =?us-ascii?Q?OTFJFA2qT8DFl+nJyy/hUGGmdR5JdKTOZiiqIi9mmIEQwlqV6TEINCxXd2wJ?=
 =?us-ascii?Q?nokk5iuu39otJc2KBNiojZ3cLH/K429S/OtRt9jsHdQ0z11Yn/59rQrFBvPp?=
 =?us-ascii?Q?H9dY9l//JMdNeqisN5S3Xb96CFqFzTcVPpoQbi3ENtQDkcSQV9CPROJDIxmZ?=
 =?us-ascii?Q?IbfRL84t3Bc6FRxPCqwItR0KXuYn+ytelb9eYPlK+uX4Uzg4fSFoC49fceBw?=
 =?us-ascii?Q?NEAA77jHv3NGDKzyfA2ObqiGkL+DtJzYMYPKBo8ju7kj6GtY5r7VCqEpFcvy?=
 =?us-ascii?Q?so4Kvh9zpFKhJ0hzssPOUctW1oU65+fQU4LRk8vkkdJmoZyUZ4fnptUxwGz6?=
 =?us-ascii?Q?jn/32e//KsQMXgxIW1aGzBAaV9ac7ej6EWf0hr064jXl/NRXmLKoXappK00b?=
 =?us-ascii?Q?R5qTJc7GMRGH1EXH+gNYiWYb6Q9OwDA1tNzjGXDShnNtispUaN6/OuK0uHuc?=
 =?us-ascii?Q?Sda3toqtT7KQf6WzDOCaIqfKO0ph6bd9Y4ZgMPHUP2RJVhfg7Vlfyku/w3sh?=
 =?us-ascii?Q?yxjs6kCQb/mRKu81vBALaZ2956venkq1Ud/Hxfv54QX8JFR/Rw2JEIDYmIDo?=
 =?us-ascii?Q?rxZmyyuyb/do9NjZYwVWtBMremXXWMjORu+wUcCFiwCskMtrlQAKMOo4jK6S?=
 =?us-ascii?Q?lF152QMHettvVAVBEZJ8N3GyTsFjZ329PviG4rsw1JiyiBVGdNA9Ehq0aOOH?=
 =?us-ascii?Q?AVfAhWaIdQL7F4yB4TvabEhiBdA3gFlhvlfXlLK/clI4cXoswrJGPuspUH83?=
 =?us-ascii?Q?NKydXSBDwgJqXGYeH+tpYBdEgePDD2mg56Hlaz1XWGShaJ0VUI+VXIVC03ru?=
 =?us-ascii?Q?QusIOuD4pSkKrNZkWFSotsSTDI0kKeq13g7+iE5HO5Jg53nr+nCdXnMcw5WH?=
 =?us-ascii?Q?LK72GEI0MgKDFHpb53VWBPwtkVhrBGatsp2HKE7MFZkhxymJjv8JWCUc4fUg?=
 =?us-ascii?Q?e+GLYW9QgRTTnoKd1npYYIUInheE5bykrrjJhqv7eMsbzMdpKL7ArTFRsx+O?=
 =?us-ascii?Q?AWfEGlnQIFg27KZ1vbE1PMxaQbUZ8sYKeJQrU4dIhXSJvNCfUJ80SJ8/iCGk?=
 =?us-ascii?Q?we1nIMe59MuyePj0IRxUiXYP8eFCO1XzcMRnz5ECgPVpM+VLdLPyQMUzw+6r?=
 =?us-ascii?Q?ClQEF610O+LvckJRG96Et7WlD8UmbUxr++F/hVwcdD5Q3Iv54ekwp/em7rKA?=
 =?us-ascii?Q?6c0YqhvKy7I02SMgO6xUivWEmNCt0CKpMuGXL3FLje/ea0DKLib82YZzhN+t?=
 =?us-ascii?Q?OOF7ZiiOgYwIUJtAWsueBLPGa18NowUOW7oVGJH2YYzHOxV0aP8lMu96k3WV?=
 =?us-ascii?Q?OLkX/4T9BwmkMI43nfVtfRF1Jh7vbIXbrSpCzkf3PPSENASyGJgJ4NMuXR+T?=
 =?us-ascii?Q?U1ILIt3Zu1jyv/x1Ym0/iX8ozFfkVA/GdU5qjErpdsFuyXGZwZ073DXkU+LC?=
 =?us-ascii?Q?KFy7r0VpImrO0Bys1lp0vhE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628582d5-5add-483c-fe72-08dc4d178180
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:04:13.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Esj8O9357FR6De6HORf4Wmy1u4qsz9sRDsP5O/bHQqBQsOI2gMsGcDezOS5rbEKD7ZwthhbmHKdeFfUwoK/Oh4jhCH2TXQ0Z4erYzdbCiGOVWIUt5vIajTIksaRcGZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8625



Hi Robin,

On Fri, 8 Mar 2024, Robin Murphy wrote:
> On 2024-03-07 11:09 pm, Ilkka Koskinen wrote:
>> Previously, wp_config0/2 registers were used for primary match group and
>> wp_config1/3 registers for secondary match group. In order to support
>> tertiary match group, this patch decouples the registers and the groups.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm-cmn.c | 125 ++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 105 insertions(+), 20 deletions(-)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 7e3aa7e2345f..29d46e0cf1cd 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -589,6 +589,13 @@ struct arm_cmn_hw_event {
>>   	s8 dtc_idx[CMN_MAX_DTCS];
>>   	u8 num_dns;
>>   	u8 dtm_offset;
>> +
>> +	/*
>> +	 * WP config registers are divided to UP and DOWN events. We need to
>> +	 * keep to track only one of them.
>> +	 */
>> +	DECLARE_BITMAP(wp_cfg, 2 * CMN_MAX_XPS);
>
> What I had in mind was a wp_idx field which works the same way as dtm_idx, 
> i.e. we just store the allocated index per relevant DN, since a single event 
> can never use *both* watchpoints on a single XP. Each index then need only be 
> 0 or 1 since they're already scoped by the watchpoint direction of the base 
> event, thus we should only need one bit per XP.

Ah, I got it now.

>
>> +
>>   	bool wide_sel;
>>   	enum cmn_filter_select filter_sel;
>>   };
>> @@ -1335,9 +1342,51 @@ static const struct attribute_group 
>> *arm_cmn_attr_groups[] = {
>>   	NULL
>>   };
>>   -static int arm_cmn_wp_idx(struct perf_event *event)
>> +static inline unsigned int arm_cmn_get_xp_idx(struct arm_cmn *cmn,
>> +					      struct arm_cmn_node *xp)
>>   {
>> -	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
>> +	return  ((unsigned long) xp - (unsigned long) cmn->xps) / 
>> sizeof(struct arm_cmn_node);
>> +}
>> +
>> +static int arm_cmn_find_free_wp_idx(struct arm_cmn *cmn, struct 
>> arm_cmn_dtm *dtm,
>> +				   struct perf_event *event)
>> +{
>> +	int wp_idx = CMN_EVENT_EVENTID(event);
>> +
>> +	if (dtm->wp_event[wp_idx] >= 0)
>> +		if (dtm->wp_event[++wp_idx] >= 0)
>> +			return -ENOSPC;
>> +
>> +	return wp_idx;
>> +}
>> +
>> +static int arm_cmn_get_assigned_wp_idx(struct arm_cmn *cmn,
>> +				       struct arm_cmn_node *xp,
>> +				       struct perf_event *event,
>> +				       struct arm_cmn_hw_event *hw)
>> +{
>> +	int xp_idx = arm_cmn_get_xp_idx(cmn, xp);
>> +
>> +	if (test_bit(2 * xp_idx, hw->wp_cfg))
>> +		return CMN_EVENT_EVENTID(event);
>> +	else if (test_bit(2 * xp_idx + 1, hw->wp_cfg))
>> +		return CMN_EVENT_EVENTID(event) + 1;
>> +
>> +	dev_err(cmn->dev, "Could't find the assigned wp_cfg\n");
>> +	return -EINVAL;
>> +}
>
> ...and so for this we would only need more of a mild tweak to the existing 
> design, something like:
>
> static int arm_cmn_get_wp_idx(struct perf_event *event, int pos)
> {
> 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>
> 	return CMN_EVENT_EVENTID(event) + test_bit(&hw->wp_idx, pos);
> }

Yep, it simplifies it quite a bit.

>
>> +
>> +static void arm_cmn_claim_wp_idx(struct arm_cmn *cmn,
>> +				    struct arm_cmn_dtm *dtm,
>> +				    struct perf_event *event,
>> +				    struct arm_cmn_node *xp,
>> +				    int wp_idx, unsigned int dtc)
>> +{
>> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>> +	int xp_idx = arm_cmn_get_xp_idx(cmn, xp);
>> +
>> +	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
>> +	set_bit(2 * xp_idx + (wp_idx & 1), hw->wp_cfg);
>
> This is recalculating way more than it needs to. It's only ever used within 
> for_each_hw_dn(), which already has all the information to hand already - 
> again, look at how hw->dtm_idx is managed. Furthermore I'd also prefer to 
> similarly not conflate management of the per-event state with that of the DTM 
> state (i.e. just have an arm_cmn_set_wp_idx() for updating the event data).

Right, I somehow forgot that hw->dn points to the right type of the node 
and I can simply use the index from for_each_hw_dn().

>
>>   }
>>     static u32 arm_cmn_wp_config(struct perf_event *event)
>> @@ -1519,12 +1568,16 @@ static void arm_cmn_event_start(struct perf_event 
>> *event, int flags)
>>   		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + 
>> CMN_DT_PMCCNTR);
>>   		cmn->dtc[i].cc_active = true;
>>   	} else if (type == CMN_TYPE_WP) {
>> -		int wp_idx = arm_cmn_wp_idx(event);
>>   		u64 val = CMN_EVENT_WP_VAL(event);
>>   		u64 mask = CMN_EVENT_WP_MASK(event);
>>     		for_each_hw_dn(hw, dn, i) {
>>   			void __iomem *base = dn->pmu_base + 
>> CMN_DTM_OFFSET(hw->dtm_offset);
>> +			int wp_idx;
>> +
>> +			wp_idx = arm_cmn_get_assigned_wp_idx(cmn, dn, event, 
>> hw);
>> +			if (wp_idx < 0)
>> +				return;
>>     			writeq_relaxed(val, base + CMN_DTM_WPn_VAL(wp_idx));
>>   			writeq_relaxed(mask, base + 
>> CMN_DTM_WPn_MASK(wp_idx));
>> @@ -1549,10 +1602,13 @@ static void arm_cmn_event_stop(struct perf_event 
>> *event, int flags)
>>   		i = hw->dtc_idx[0];
>>   		cmn->dtc[i].cc_active = false;
>>   	} else if (type == CMN_TYPE_WP) {
>> -		int wp_idx = arm_cmn_wp_idx(event);
>> -
>>   		for_each_hw_dn(hw, dn, i) {
>>   			void __iomem *base = dn->pmu_base + 
>> CMN_DTM_OFFSET(hw->dtm_offset);
>> +			int wp_idx;
>> +
>> +			wp_idx = arm_cmn_get_assigned_wp_idx(cmn, dn, event, 
>> hw);
>> +			if (wp_idx < 0)
>> +				continue;
>>     			writeq_relaxed(0, base + CMN_DTM_WPn_MASK(wp_idx));
>>   			writeq_relaxed(~0ULL, base + 
>> CMN_DTM_WPn_VAL(wp_idx));
>> @@ -1574,8 +1630,20 @@ struct arm_cmn_val {
>>   	bool cycles;
>>   };
>>   -static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct 
>> arm_cmn_val *val,
>> -				  struct perf_event *event)
>> +static int arm_cmn_val_find_free_wp_config(struct perf_event *event,
>> +					  struct arm_cmn_val *val, int dtm)
>> +{
>> +	int wp_idx = CMN_EVENT_EVENTID(event);
>> +
>> +	if (val->wp[dtm][wp_idx])
>> +		if (val->wp[dtm][++wp_idx])
>> +			return -ENOSPC;
>> +
>> +	return wp_idx;
>> +}
>> +
>> +static int arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val 
>> *val,
>> +				 struct perf_event *event)
>
> This must never fail - the purpose of val_add_event is to fill in the val 
> structure with the combination of leader and sibling events which have 
> *already* passed their own event_init calls been declared valid as a group. 
> The body of validate_group then does the "what if?" version to test whether 
> the group would remain valid if the *current* event were to be added.

Makes perfectly sense. I fix it.

>
> The trick with the offset combine value relies on direct indexing to work, so 
> I think we need to rejig the structure slightly to track distinct wp_count 
> and wp_combine values (per direction) - that then becomes nicely consistent 
> with the relationship between dtm_count and occupid, too.

I'm not sure if it's necessary but I do get the consistency reason though

>
>>   {
>>   	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>>   	struct arm_cmn_node *dn;
>> @@ -1583,12 +1651,12 @@ static void arm_cmn_val_add_event(struct arm_cmn 
>> *cmn, struct arm_cmn_val *val,
>>   	int i;
>>     	if (is_software_event(event))
>> -		return;
>> +		return 0;
>>     	type = CMN_EVENT_TYPE(event);
>>   	if (type == CMN_TYPE_DTC) {
>>   		val->cycles = true;
>> -		return;
>> +		return 0;
>>   	}
>>     	for_each_hw_dtc_idx(hw, dtc, idx)
>> @@ -1605,9 +1673,14 @@ static void arm_cmn_val_add_event(struct arm_cmn 
>> *cmn, struct arm_cmn_val *val,
>>   		if (type != CMN_TYPE_WP)
>>   			continue;
>>   -		wp_idx = arm_cmn_wp_idx(event);
>> +		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
>> +		if (wp_idx < 0)
>> +			return -ENOSPC;
>> +
>>   		val->wp[dtm][wp_idx] = CMN_EVENT_WP_COMBINE(event) + 1;
>>   	}
>> +
>> +	return 0;
>>   }
>>     static int arm_cmn_validate_group(struct arm_cmn *cmn, struct 
>> perf_event *event)
>> @@ -1629,9 +1702,15 @@ static int arm_cmn_validate_group(struct arm_cmn 
>> *cmn, struct perf_event *event)
>>   	if (!val)
>>   		return -ENOMEM;
>>   -	arm_cmn_val_add_event(cmn, val, leader);
>> -	for_each_sibling_event(sibling, leader)
>> -		arm_cmn_val_add_event(cmn, val, sibling);
>> +	ret = arm_cmn_val_add_event(cmn, val, leader);
>> +	if (ret)
>> +		goto done;
>> +
>> +	for_each_sibling_event(sibling, leader) {
>> +		ret = arm_cmn_val_add_event(cmn, val, sibling);
>> +		if (ret)
>> +			goto done;
>> +	}
>>     	type = CMN_EVENT_TYPE(event);
>>   	if (type == CMN_TYPE_DTC) {
>> @@ -1656,8 +1735,8 @@ static int arm_cmn_validate_group(struct arm_cmn 
>> *cmn, struct perf_event *event)
>>   		if (type != CMN_TYPE_WP)
>>   			continue;
>>   -		wp_idx = arm_cmn_wp_idx(event);
>> -		if (val->wp[dtm][wp_idx])
>> +		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
>> +		if (wp_idx < 0)
>>   			goto done;
>>     		wp_cmb = val->wp[dtm][wp_idx ^ 1];
>> @@ -1772,8 +1851,11 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, 
>> struct perf_event *event,
>>   		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + 
>> hw->dtm_offset;
>>   		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
>>   -		if (type == CMN_TYPE_WP)
>> -			dtm->wp_event[arm_cmn_wp_idx(event)] = -1;
>> +		if (type == CMN_TYPE_WP) {
>> +			int wp_idx = arm_cmn_get_assigned_wp_idx(cmn, 
>> &hw->dn[i], event, hw);
>> +
>> +			dtm->wp_event[wp_idx] = -1;
>> +		}
>>     		if (hw->filter_sel > SEL_NONE)
>>   			hw->dn[i].occupid[hw->filter_sel].count--;
>> @@ -1782,6 +1864,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, 
>> struct perf_event *event,
>>   		writel_relaxed(dtm->pmu_config_low, dtm->base + 
>> CMN_DTM_PMU_CONFIG);
>>   	}
>>   	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
>> +	bitmap_zero(hw->wp_cfg, 2 * CMN_MAX_XPS);
>
> Nit: I'd rather do this in terms of sizeof() so it's harder to break in 
> future. And since it's going to end up being a memset() anyway I'd then 
> probably just open-code that rather than mucking about with bytes-to-bits 
> calculations.

I change it.

>
>>   	for_each_hw_dtc_idx(hw, j, idx)
>>   		cmn->dtc[j].counters[idx] = NULL;
>> @@ -1835,10 +1918,11 @@ static int arm_cmn_event_add(struct perf_event 
>> *event, int flags)
>>   		if (type == CMN_TYPE_XP) {
>>   			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
>>   		} else if (type == CMN_TYPE_WP) {
>> -			int tmp, wp_idx = arm_cmn_wp_idx(event);
>> +			int tmp, wp_idx;
>>   			u32 cfg = arm_cmn_wp_config(event);
>>   -			if (dtm->wp_event[wp_idx] >= 0)
>> +			wp_idx = arm_cmn_find_free_wp_idx(cmn, dtm, event);
>> +			if (wp_idx < 0)
>
> TBH I'm not convinced it's even worth factoring out the "allocator" here, 
> since inline it can be as simple as:
>
> 	int tmp, wp_idx = CMN_EVENT_EVENTID(event);
> 	...
> 	if (dtm->wp_event[wp_idx] && dtm->wp_event[++wp_idx])
>
> (or perhaps follow the same while/if shape as for dtm_idx further up, if you 
> think it's worth being more clear than concise)

I'd rather keep them in their own functions to be more consistent and 
slghtly clearer.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>>   				goto free_dtms;
>>     			tmp = dtm->wp_event[wp_idx ^ 1];
>> @@ -1847,7 +1931,8 @@ static int arm_cmn_event_add(struct perf_event 
>> *event, int flags)
>>   				goto free_dtms;
>>     			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
>> -			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
>> +
>> +			arm_cmn_claim_wp_idx(cmn, dtm, event, dn, wp_idx, d);
>>   			writel_relaxed(cfg, dtm->base + 
>> CMN_DTM_WPn_CONFIG(wp_idx));
>>   		} else {
>>   			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
>

