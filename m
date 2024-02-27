Return-Path: <linux-kernel+bounces-84094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA386A222
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A024F1C20E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C4159580;
	Tue, 27 Feb 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABttJ2wO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F51534F4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071525; cv=fail; b=Mzb2snV7gA2HjdltpCxKxIVdGD2bWl1A0IPa3LhVocDxIHX9BBxx/9Zg5hGnBx+XrkYuRe391xJLXn8uAQPplCC2aJE9IYJFX10cYhMnPZJDIWg23AgsJMvq3fEkCtG3WEknBBlwnY9j7yb0llup40lCnjqV80+5wlirg6yq1cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071525; c=relaxed/simple;
	bh=BXb+WqiPCMP6UiTr2UHkpvpO0w11y+mx2XhiMaqFSPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvOvpVKM9E0lj8YkAPghlmUQzyl11wTFXz207NkBlHn7kaRtEZN3UWbqEjovY/737Z2Zi47EqUHWGi1/318hyFkP1H/oEbitXnipGm9yNANy7lfy2bPqKOl+Lr2g6k+N/STF1HLrsewmZb41xztVNr2usV0AdobE8+9fmQsn05M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABttJ2wO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709071524; x=1740607524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BXb+WqiPCMP6UiTr2UHkpvpO0w11y+mx2XhiMaqFSPA=;
  b=ABttJ2wOzlCQcsjxz9hxoTEsVk+kP4wnCcF8fIDbHqUObLvmR4E/r/Uu
   PNBDhzwjaSGA8uTfCUG3jkVl1NG9EkAwNlD5syIPuoDfjUPR9WA2AiWRu
   /F0R6sDtIWHezZwSCKrrHclhQ7kKiKx/Rj1Uy1gftdniY6jD/KXpvS/WW
   3tTlUzZl834mWOMQIbEP+oDdVhtHqZjAx4hTCEdHc+tHRsizvQ8ANOgU/
   7yPBmipqa2Kv+ZRRgwuhY9wv+TufKBRKrX32Pv8JTSGIebUprpfQaKTbL
   fAYTE+8cjW2M49Ra2iwPmsKLTHpshL4/VUIVLvp51mPg2k3aCB1O4nUeI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20894410"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="20894410"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 14:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7167324"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 14:05:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 14:05:21 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 14:05:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 14:05:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 14:05:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j90QO/GT2FmZceCfC2tgMHopjj/xB/L7OWA5NDmJJJO4DA1jDpT+L2ExWFce4h+J5Igb8yJK0QTqZphbeYGv/EylN0OMLjLyBNzpUi8Bpxis4KA968AK1LPboed1PMTJueyBZHKR/AKQuAi7cXNekfNZOJPqvm2KB7Kz0Z6SILTM8FhitIuy+VXytnvQwc1vKNB+8ns2XCQYHBjvC4kz7Oz/blb96dCBF2TK+8GQPd4CKUKmyRBfQ7D4nGTeEduvNPy2u/ZkVsmCl1VOBPOZ6ujbX7nuNzjazQwovGo8wt9ViNjDSpFtTOlOuBRqO87gWPhuZRt1v31SEAiXJoTwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gizho6+Mf+J8G/yDhTbUNn9Z77RdiSgJjvg76f8pahI=;
 b=nPJahDe3BkoyOynh1UBFWmuIgKsseGE0ff/xKQ+6eKVBTOpFuUi4DIj2ddXgxPSkX1FF1WGi+otxn2U64sHpvdFpRRNOUzX4qIyV4us9i/reNNcMoYWliyuthMJmW65omlfDwZQqoTB5tioZ533Pys7+YsqCLfHn1k8QvaV01+RXkmz2TjfcOP5MvkYbIOfr4eLkXTAP5n4oL3RgWwsrZHqrycFtmOleqzW1zsCGeXhzOZsJMzyEKuMNmT4h+8zUzAxV+TUIi0LTRMnSfiFkcMRCjsfcbYbwMTpzESROB0Vv49wmMYwHRe9hdawbaOu637Od8Q+R89Ielpdq1tVxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 22:05:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 22:05:18 +0000
Message-ID: <e16b9165-2907-48c0-9e34-d0b78b9781f5@intel.com>
Date: Tue, 27 Feb 2024 14:05:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/resctrl: Simply call convention for MSR update
 functions
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240222185039.72201-1-tony.luck@intel.com>
 <20240222185039.72201-3-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240222185039.72201-3-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e638578-3652-42fa-4c8e-08dc37e02ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKFguqR9PQgURalj3w/KoztWifFRzgTgTVLP3wuxBUJ9LHXoBHSVj0+H4Z4M5EMNaCZddiqivKH9St6cWAfyl1yUfMZiCFcNcItJY7C75kqhbaQmQQ6eCywjK7rRa4kUIms2ztjtfwvxVdi0jg5AUw1KwgRGaW7ogu7CxauP3foeNsHrbbvDtsqlO5ruacDD7P9fWvcga58qR/Bchpf5uAfAaotQ19qvcvbwKbvSXwKC7CSlXezAtx+nG5CWxqVt2LuVuWPhGIU0PL4CfmUJqe/R+Ga/aNWVzDRUBwmkv1Wpw9oT1wJBN/5Fv/GQ4G5fk6SvjKp6K0mOZ38TSshmJUFgYbDYD3M8u3WSf+9RCAHGe3mXXAqhhrGCXaeB7o91o90uXJpZfe27NQR8VE9ITHXdGHAnxElyDHluDdJaOsF6U46r7vWsjRB2V40xiXnRqBtn5Y/vbkTZVnhGFXo1qAe9lQmmOKoihZkn6t0Ler4o3JXrEMjxUtYS1xIMRYys+UHbLq+gwtARz/ZaehfqU8iZcPHAYqwWK1KrFQDsR5TAm7t+pd4Q6MZ0DCSvgkec3+HhQSNFsWL1CC9fQO+ShPz0vJHQxaTEsyZigIKjymYsX6xncBywjMWJPaSuFSIhPE0aZIiWq/fXmdEnSRz+Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBaLzl4eUZvaWhHMGVDNjEraGRpaXJlZW5ORDZaNkxZcW1ZWldoSy8zc1BQ?=
 =?utf-8?B?ZnNEZnZXd1huRjNXdTFaN2R4ejFjanZ6NEtZcUZFWG1KM1N1YmNmQ1gvZmxI?=
 =?utf-8?B?UVBQMWhuU21paEJDUE1qSUtzSjlyRFZtV1gwSGg4SGUyZ0VHWktGVmdEY25X?=
 =?utf-8?B?bEFQelJEdkVCS1BIeiswZS8xNWNJcCszNW4ybS9yaUZmTGM5bjlXZ2NVdW8r?=
 =?utf-8?B?Z0dsMUJDdzBIUkxyYVF4U1RoU1VLSEVsNS8xeGRvN0xabjhtZ0ZYYWlvZUR3?=
 =?utf-8?B?eFcwK3ZtWXFkZUlsd2ZETDFLVlR1NkVIbG9yYjZpV2hMbFcyV2hRbE16UFJv?=
 =?utf-8?B?MlRyT2QzNFVQTXhaL09ONHdBNGFwQ2U5eTNSa09yT2V4Zkh1RVZEWWFham9Y?=
 =?utf-8?B?Q3piMEpsQUQ4a3J3V2VLTU0yaWtTQXB2eTg4RUZ5N0pQOUpLVENqbmlrZVZa?=
 =?utf-8?B?TENxeWVIN3k0QTVUVXAwdlhqWHdPQjhmbGpySXhxd3dKdlFia2xRVkhaSDUw?=
 =?utf-8?B?MWxIK2VwMTdqdkNCbW1MK01kdmh2WklDNHdhdjl3WmhyRGxFZ3V6TENoQkJh?=
 =?utf-8?B?NHNSdlB1NzlNVXFSNjdraDRFNGdCOWVEQ21GRkxZUWhwK3lJWkZ4VUNnRlZa?=
 =?utf-8?B?dHYzaDhMWUlaNWM5WXZ1ZGlTd2pYNCtPRFEvTVozNFlUSDQxVzF1T01YcGJz?=
 =?utf-8?B?NjRwa2V2a3pjbFQyZ1pkNitVWVFBaisxZDBlMU53SU9RaHQ3NGRtdnoxY2c5?=
 =?utf-8?B?L2RhR1ZNbC8rbDVmT2RicmlHeENFZThKWXdBNkxqSHhXaVp1amJTSVFrMzdm?=
 =?utf-8?B?cnY0aEVub2NQNVZpMGVHSi9PTlhNMG1xa0VSZC9iSjA1c0dxdW5tdlQ3R1hr?=
 =?utf-8?B?K1RsUUdKb1FacTFCcGUwb053VURNNEIwZXdMc01uaDF6OXVjNitOWm5xWHBH?=
 =?utf-8?B?QldUNHJaNXFncVNXUlpmU2NYVStRK3d5a0VJV01vSDdYNSswcytvMzBMNTFX?=
 =?utf-8?B?VjF0YzRIVnZHSmJ1NGRoRW1IeW1RODNsV1h1VERwZTBESENPN1hjdlR4a1lj?=
 =?utf-8?B?Tkp3SHBtenZBUSs3MGQzczlvbmpTeFp1Z2VEcHVNeVZybk5VSDBldUd3MGNn?=
 =?utf-8?B?cmRNaHcxcTRSRXpPZ1NNcmhVd1JyQ0xwY0VyZi9aOFVGZmhiaDlQdmpKTzJa?=
 =?utf-8?B?c3ZncXdwSnR5TFVIeG5GK1gxWkp6YmdNM2c4a2Z2L0N2N1VWMis4WFlRS3Z4?=
 =?utf-8?B?MWl3Z0llQVdTYTB0NjJ6ZzZFTGhjTHR5WmJqa2wyY1JIMENmUlNDcktYMUhF?=
 =?utf-8?B?ajN6K2hBdW54bjkwWVB6bzJrTHJENEZEZ3A1em9iTGg0YXdSNlE5MkswN2VO?=
 =?utf-8?B?cStrVURGZ0VlVUhMYlI1U1J0UkRMbjNUWGJMc0tSRE4wS3lxZ3ZwblI1dnpB?=
 =?utf-8?B?SWVXNStoL1Y5RDRLUEkvcDdJVmt4SjF6Y1pSQWU4ajNSd1duZUdPOGI1enY5?=
 =?utf-8?B?QzdxZm9xVERvT0FuY2lBdCtOTEJudzhrMi9qbTJPdUdvUUVJM1pOMjhrZzZL?=
 =?utf-8?B?Y25wOWdHYnFZaWJheXpzT0hTNkpSYVllRFpqeFZNa080UnE5dWE0aDl6Q3RS?=
 =?utf-8?B?RDA3VzlTbW83eTRib3Q2UWUwdE95alVuU3ZlSGxEc0ZPSndCOUpkbkxMbVlm?=
 =?utf-8?B?QkExbCtaUDFSVXhscTM4c2JwdU5NSExLYUMwakx0bVpEUmxPVGNlcHoybFFS?=
 =?utf-8?B?MkJEeitLWlZBcUg5SkJnQyt6T3VQK2VTRzE5aWUzTEFnK25VOHJvbm9OV3pE?=
 =?utf-8?B?WU5JUHc3cThhMFpMSlpiZDFoTzArVVhDOERrc2N2MkEzQTgwYnkrL3JONkZS?=
 =?utf-8?B?ZFdTR1JjVVFXSTZ6cXZUcXY4aG1MaUhjTlpCc2I3Y3pWYTFWMCtXdUVEOXlh?=
 =?utf-8?B?SHdYNXlSUk1UaEx3TXUvTWFnSUtnem4wbTFFcWgvUlBrOVc0TG9zNzlTSGVx?=
 =?utf-8?B?YmRRUmtTWERmM1BOMVZzWWk2V3VBVkRjVkUrUTZETXNWZklMMW5OTnFMSTJ5?=
 =?utf-8?B?eGVGNVBidmxTVU5BRnpMRmVVWi9yaUJSUjVLd21JYjRBaFNiQ2txT1Z3aE15?=
 =?utf-8?B?REd4aG9HSUU2UFlCQXJCcTNZcXlDRUJDWVlCUlZ4VXU3QnVkVURoZ0NEcnNt?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e638578-3652-42fa-4c8e-08dc37e02ef8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:05:18.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi4Br4sLE7bebCS0NX/CoIvt3b/oYUPUob2KOOOHzWyPDjI94C3wVDOkjq/dETRSq0rO8O1ZfTtvC/8rwiBRUdFJk8HhHvYzVbYzpBhXE9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com

Hi Tony,

On 2/22/2024 10:50 AM, Tony Luck wrote:
> The per-resource MSR update functions cat_wrmsr(), mba_wrmsr_intel(),
> and mba_wrmsr_amd() all take three arguments:
> 
>   (struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
> 
> But struct msr_param has always contained the rdt_resource, and now
> contains the rdt_domain too.
> 
> Change to just pass struct msr_param as a single parameter. Clean
> up formatting and fix some firtree parameter ordering.

Please stick to imperative tone. For example (feel free to improve):
	struct msr_param contains pointers to both struct rdt_resource
	and struct rdt_domain, thus only struct msr_param is necessary.

	Pass struct msr_param as a single parameter. Clean
	up formatting and fix some fir tree declaration ordering.

The patch looks good to me, thank you.

Reinette

