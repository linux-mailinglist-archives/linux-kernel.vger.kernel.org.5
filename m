Return-Path: <linux-kernel+bounces-153502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1428ACEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E3F2831A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9E1509BE;
	Mon, 22 Apr 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONNyv98w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F511509A2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793956; cv=fail; b=IGETWW8IfbNDQNfACc/NbHFbfvfFl/fQ+oCmoaXi28cVtOc/Ljj8XHwfT4ZSWYspazlDvmp6r02L7wj9C1yTTV3DT9L3maPzPzao99qZlbfLvm2CMak3fz3B0KLatulJmOFZPrsX79yMJV/DLOodtCSECuAJO/qxUSNQmgbjEBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793956; c=relaxed/simple;
	bh=Ay4uYo5JLAqV9LgWFc51DVUsu2r87UotwoM2wgrDSJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hb75xM8Cq3Ma6TveW03YHW3E/bYD0cS/5+rDegJAV6kYB0dO0jx4+xMnO4y/4iXpj9QBiNmMjVfOYWOTaPWAt/Fy3ddg+AK62ac85BdyRVOdFC+oE+eArDImj+w49EewyKeyOnPtwR+8x1o0DQrzVWj9o2EFK4aHaAGQjsSAsDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONNyv98w; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713793955; x=1745329955;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ay4uYo5JLAqV9LgWFc51DVUsu2r87UotwoM2wgrDSJc=;
  b=ONNyv98wJhYmVHdwk7Wb00juk+Eq55p/O2/lIEECJoX6ni20Q/1LU0wa
   oMdse8n/8NsHq+bblJ8ptDsx7DzztfxN1XOOQK+SWjmjokaa1CpJ1OlYV
   EFA0ZMixWpYQXxSMR9pSLwkeqh67qE/RCs5QXrUdfPgUB88k5kYXonNxJ
   5TqyGWwkAyhxpP2uAfmk8kSqonJ6SQTyKyEkch4Oqo1T5BumnxC2LTC6n
   +lRixpScT/o4AGGt3FkuV3+UCpKXDpDjxLObxltS5vVLgXXWPNvKeqKId
   PweuafbWCy94gJtnIVhOnvnlepv69bKhsQt/It/7cHatd0lpdsRY9P0+z
   w==;
X-CSE-ConnectionGUID: /T7Yc17JQ+urmVhHF1C2rg==
X-CSE-MsgGUID: BRF9Y6Z8SoimIlOXpJsBzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9198840"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9198840"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 06:52:33 -0700
X-CSE-ConnectionGUID: D9n63mZsQ4qAKHaXyQy7yQ==
X-CSE-MsgGUID: 8E99sYlJSG2ZMvRD09hU1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24071102"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 06:52:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 06:52:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 06:52:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 06:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2vMMaLPq3IG9GwO/8gTnIdWU9FGrOwRv09cXEOmZo0g0bvm15VW9QyQx/+rM82Xs/pLA1c71yKn5h4gJ8Gr+F20GTtU1WmTPTuiEewA534Gc43IN4HRbAMe9GJqDo7RDk/PQP3ZQdYsmBgxrUN2NwZnf71AeUrbN7CZucyrtwzaK9yeL6Dxcu6K+Z1kuI45w8wMHLF0oFA+1AO1prcrijMAtSIeuIJBTNkg+RcecKZ1diVZ0vMo4D3Dscdv3hLCcjgQp6EFzxYTBNewR7OlmKIjrKn2jnCfgW7c53PEynt5P8tWLfg+jeudsX9oiUyEAjbBKC74kDy9IvQeTohduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qw8jUJNtZjHFVZHV4oAmYEHtz5rG3TjO2iNh15NHHc=;
 b=NLWJxKMZfX48yRd02YpVhHGcmM5yHg0UbXb9zCoHJH3kEmPCRr7nAtfKhsZv7TTTOWR3SmZUK2ZAZcX1Ej0lyycSGMiE7DeVUZzJ1h6gUJiy1tADnmNIvEir+AEYcnUHwUynGDUOBA2FI3ZMK5iSx38O7mIjvBkIR82421Aaf9GGDOu1AeqiGtyivPaFt97ayh/O3mhMJNCtAt1URb/eg+a4F2YX7xNkvKcvEhYT7XUX6rNv5Qna5TNHZgZzkJrB7nMGIhQ1JPK1n1trNtN8AcggdMqvZYoCWXfxl4p2MePW0Tg6qnUdr8lEv4JotWvcGECqkhE4YvflJ0uodLnbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA3PR11MB8002.namprd11.prod.outlook.com (2603:10b6:806:2f6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.20; Mon, 22 Apr 2024 13:52:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 13:52:28 +0000
Date: Mon, 22 Apr 2024 21:52:19 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Xuewen Yan <xuewen.yan@unisoc.com>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<ke.wang@unisoc.com>, <di.shen@unisoc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
Message-ID: <ZiZrkyzQQQny945u@chenyu5-mobl2>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
 <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net>
 <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
 <20240422111744.GO30852@noisy.programming.kicks-ass.net>
 <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA3PR11MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd6a082-fc48-44e0-9a8c-08dc62d372ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVlwOTlFeGtmT0RiSjNrTDUyK2hCdHIwSGIzN0RWdExWU0hETGs1QXY4Tk93?=
 =?utf-8?B?c1FQaXYzSytGRXJPUzduUjFhZS9JMnRibWFaRzQyazJRMUh1c2E1M0JYTThp?=
 =?utf-8?B?d3Bra0NQbGhXd2xNQ3dleG1EWnd0Q1RWS2FQalM4VDkwOEhMeUhjNFV4YXAv?=
 =?utf-8?B?UW1hbTJObjFEYTFITE9EZmRpZ3BEcDBXQitqMHdxZ3d6Q1ZFdlBPZWEzenNG?=
 =?utf-8?B?eFBIYVRYRE16dEdKZ0tyYnFUWW9FUnR6YnYxcWJldjZpUldycERuUFFIa2dW?=
 =?utf-8?B?bW5Md3ZBV21kdy80VHRLcmp5VG8zMG85YmNvNXdjaDBjVGdoZzNkT3hMbDR6?=
 =?utf-8?B?bmNFUGh1SmJKTWtLb05YL29uQll1a2pPellxeXFTWXJrSEhib3hBRWRrUWhY?=
 =?utf-8?B?OGljU3NDamZmaExjS3hibFNjd2s5SE52Z2paUTFDM1NRTnUwRHlZMmQ3Qitm?=
 =?utf-8?B?NW0rTzBjYzlybWxVTW0zTlJDTnpSV1FHT2V2V1RDcG1TSlpWR01BeFFCNG9a?=
 =?utf-8?B?VXhQS2VweXZRYWNUcXdaS2FoTE1wbVVraFlZdDNUYUlHWm12ajFnZU12UXdG?=
 =?utf-8?B?TlRMTmFTdis3OXM2Q2hQU25yWlZ0VU9xbVk0R244QjhnMmZWcFg5OEN2MExh?=
 =?utf-8?B?Q1p6dFdRbkhtSXBpZUl3anhkV3lGY1d1VjlKWUVXNnJhZVYwcmhoc2pzVVZG?=
 =?utf-8?B?cGFEQnZoUERrZkZvUEswWlErZ1FiRTBIT29Ga0MwOFo0N001dTNUZjZHUXlo?=
 =?utf-8?B?bk12YWNjTENwU0JrVForbDVBOFFDNlQ2SFhqZWp6dlUvVDdBbmRnbEhrY0Ft?=
 =?utf-8?B?NGdQZ0tnenEraUUwNndhQkFCZ1FrYUNoeUVxcUFtdGZjdWlVMzZMQmtHQmJO?=
 =?utf-8?B?SmlESDcwcTlJUmxWTUJGb0IzQWN4bVJ1YWlVZThmWXlCYkZLVWo3dFNvYVl5?=
 =?utf-8?B?cTd5RFdWTXVEKzlrT2xXWlpueENjUmFMYUR2V3hGSElJUDNBKzRob2RSUmRT?=
 =?utf-8?B?ZlZCeDdmODZjZ1NEZlVxSnpTRFFUNnYxejlVaktUcDRrUVFOKy80azhUQml2?=
 =?utf-8?B?Q3lMNXVFMzRGTkJvTVlHUTlBcUhtYXN4Sm5QVUdVQ2F4YzVmVVRlM1ZIc1Js?=
 =?utf-8?B?UlQwN29ET0JZR2lOSHlybEVCeU9KVkc0cXlIT2FrTmRqZzBCaW5rcDRsYk9p?=
 =?utf-8?B?RFJhazYwREVYTllJMUUxS0I2cHorWENCVnZWNkVjSHI3ZXZQMUxhUzFHbDFQ?=
 =?utf-8?B?Tk1KUHVENGs2Z1ZoakttdktXUVdsaytLWlRtcXNuRWlHVnJrY2I0SjdsaGww?=
 =?utf-8?B?UXpXYitxZk1oZERzeDdJQWt1aUdjNGFBcHhBNFJHaUV0cXNNRmJoZXNKVDVH?=
 =?utf-8?B?RElTYzlFZ01qdldoU1d6ZXpaMWlUMGhudW9EbjRiTmFrSlh0WmlpS2RSU1Bk?=
 =?utf-8?B?bGkzQU1vZkdvcmRrV050RVd6SDhiR3F5UUcrUDB0OFdtL1RvNEhOVmp3NGpn?=
 =?utf-8?B?aUl5emQyaUVWOFN3OEtmeGs2bVIzL3A5UjhLVDgwQWJSYzhkaisrU2gvbGc4?=
 =?utf-8?B?Y2xLeXZsNUlzc0FrUGhEYkQrby9UdUw2Q3B4KzdzNmxDN2RZV1QxYVA1OXNn?=
 =?utf-8?B?QldmZjZZOXRHc0NzWWkrbmwzeVo1eTNJRFBIKzBNZC9zSXdqNXRzOGtLOFBt?=
 =?utf-8?B?SERwYVBxRjZ2T0xjVnZOSnRhdUFQS0F2ZHN1UWZlWmVCdFRIUGozT0d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklxSm8vdWhZUGpRcGR3V0pvK2MrbVdla0Zsb3NoelZleFRCUm1zWkxvQlpW?=
 =?utf-8?B?STlxU0pkY0ZTZ0k5cUhlTWRJNzJJeUFqd2piUmJFVTVQcFpGdkhKUGUvRU4w?=
 =?utf-8?B?Y0pZWWJSR1lZd2dXR2FDUzJ4a1E4aXR3aEVvS0tpem82SDFJUFJ1cTdhQ00x?=
 =?utf-8?B?eVRrRnM0ZmhIbW1uWmthQ2t6Y0dURWwrWWRUSjFRMTRLaUlqQkIrSWdKcitT?=
 =?utf-8?B?SXpIcUovdm5UWVprY21SWkJrQU04dmVJQmt0Ry8xSXBSQTA5UzhKdjB3UURl?=
 =?utf-8?B?UHVQSFlOSW5iN0xtWkViMW1NS1ZTQnp2eE9kZlN6bWpPVENFVWtPbWQ2bHpU?=
 =?utf-8?B?WlhlaEhYRjliNTdnL010R3NFOSt4V010dWdPSEx0VXNWRmVzSi90Nk9DZXZ5?=
 =?utf-8?B?Q2ZRamRiNkpGTTJhN1FYUm9qYXFtdEUxTXNlTThWNDZ2eTRJbEtubFVLd0hx?=
 =?utf-8?B?Y3hiY2hBS05ZQTFnUmhVaDZITk5KZWlwSXpGUFNQVDFxT2xIeHhibWI3T0Vn?=
 =?utf-8?B?c2V4RHpFMWlZTitHUjJOUG1NSm45aWNCQThSL1pRVW9JdTVKOXhja3NQTWxm?=
 =?utf-8?B?WHNhaEgvV2xHT2hlQnNybGJTWUxlSFBGb0x0OFVtb2FBOXQydXUwTytKTTZo?=
 =?utf-8?B?OWdUa2Z1OWNNYU5UWWZoNHNsTUpNb2hYRW5PdEVuZXRCNDh5NmVaUHQ5eDB6?=
 =?utf-8?B?eSt5U012UXQ3L2pIb0tBU0hnM3FGM3hkTVF5NVBZMWtSYksyS2pMaE9iQ1BE?=
 =?utf-8?B?cUQ1Sks3MEVxS3ZDUU1KWmo0QXNuUU9EK2lxSE15TlpkQWMwK2lKWm5iQWFq?=
 =?utf-8?B?RWpGTmFISnR4d3lnRm4wa3JOcC9qQk0zdGhhRDhXVG9GVmpNdnhVbnIvdFp3?=
 =?utf-8?B?WUl3dWlEZUtadzkvQi90anhlZ1BtTEhwTWZvZFF0d1Nxbk84d1BBRkNKbkJj?=
 =?utf-8?B?K0NETWRMcTQ1bXpPaHNCMElNaEpiSnUyekNSVmJ3VmJRcC9IWjk5WWQ3T3cw?=
 =?utf-8?B?dzM3cUhTSXBnN3d0bzhzRHgvTmJTQVNGZnRPUks4cVZxa3Y5eTFqc3Q1OWpR?=
 =?utf-8?B?TmVub2dWQjVDdytmOTcvRm85OFl6SnZISDRabW1PdHZ2UlRSS0U5K1NPYzhD?=
 =?utf-8?B?U1NzdHZwN3RNWU82M0RDSThHd1RoNXNNVnJLcGV6R2dmaGNyYzdmYmxIOHM4?=
 =?utf-8?B?ZUtJNGFwQmVtdTJuNE54V3pRbHRkWnlDUGhkTlkydHZnRnhlbUtLRmQ3R1hl?=
 =?utf-8?B?YXg4andqc2kraWRsQldPK1FTY3JtV2xwOW5ONW1NNDdQMDBhd2JYaUpUaS9z?=
 =?utf-8?B?NXdPYkJ0VGM3QWF0QzQ1RUJBcXhVSS93bVQrbGtDVFN6alV2QXQxbXhpc0tT?=
 =?utf-8?B?ZHEzZkdMaHF6d1BiK1EvZHp1S2FIR2t6dkFxa3NNSHFUY1BKLzFCQWgwZHV3?=
 =?utf-8?B?U3ZseWJXOXAvNWl4VHdqTUcrT2hqZ0JweVZuSWhGb3ZiZ2VTL1F2clJ6WVhu?=
 =?utf-8?B?WkZTdmlvZjB6alFFT1JNYllWa0tVMEc0dnpWeW9nTlcyNmVXL1JWVDRyTGwy?=
 =?utf-8?B?d3Q2QnFvVS9STktOS3ByRVB4cGJ4N3MxMzVHWTJ6dUdseUlJckNTZnBubS9Z?=
 =?utf-8?B?MlpPZXdabjZJbmlHOFQrNGRDYXVkUWo0U1FoaC9PMU5ubjhFMVMvNUErUFJ5?=
 =?utf-8?B?NGllSURzdkRiY1NDRzg3R0tuN2FFcFA4OFRFSGxsK1ZWNWR3UHNNNy84clZ1?=
 =?utf-8?B?cjBKRStuT0VkN1JnWFhLYkxWVmJGUXlPRHo2V1BBSmtQTzM1T1I1Y3pDNzQz?=
 =?utf-8?B?ODE1Qi9VdlNBdnlySjZMWjZObENWcG4reGRFNTROODgyb0xzenpQN0p0T2hX?=
 =?utf-8?B?eTRTb3dxMVB2Yk16Z21vRk1OUzUwMk9Kc1F5a0JLZVhqOWVGT2lEVVdlazQw?=
 =?utf-8?B?aHZ0bTJXTE5mMllLRmNWTTdWbElhM3IzVmRKYnlRVTFSM2NQV1h5OHBBUGp6?=
 =?utf-8?B?OFU3ci9IbVlSQlZIc1JGTlpKS0ZXOFZwRmIvTS9Bc0EwTXBIZml3ZkdUbEl1?=
 =?utf-8?B?NnZUd2NZWnlRWEdSaFhPdDFHSkRBcWU4VmRQbUFnMkhYM0VwemRlVDVRblNk?=
 =?utf-8?Q?vI8tiKzV6JJ/ZK/Y87Ipo09eL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd6a082-fc48-44e0-9a8c-08dc62d372ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:52:28.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t1lVw6pi7qSOn9AScHiFYEgBR8Sm0d0JkPoXuONIuCs95bUqp1oACX+cKqi1fQ5h67019VUfwZD/GAQptFV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8002
X-OriginatorOrg: intel.com

On 2024-04-22 at 21:12:12 +0800, Xuewen Yan wrote:
> Hi peter,
> 
> On Mon, Apr 22, 2024 at 7:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Apr 22, 2024 at 07:07:25PM +0800, Xuewen Yan wrote:
> > > On Mon, Apr 22, 2024 at 5:42 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Mon, Apr 22, 2024 at 04:33:37PM +0800, Xuewen Yan wrote:
> > > >
> > > > > On the Android system, the nice value of a task will change very
> > > > > frequently. The limit can also be exceeded.
> > > > > Maybe the !on_rq case is still necessary.
> > > > > So I'm planning to propose another patch for !on_rq case later after
> > > > > careful testing locally.
> > > >
> > > > So the scaling is: vlag = vlag * old_Weight / weight
> > > >
> > > > But given that integer devision is truncating, you could expect repeated
> > > > application of such scaling would eventually decrease the vlag instead
> > > > of grow it.
> > > >
> > > > Is there perhaps an invocation of reweight_task() missing? Looking at
> > >
> > > Is it necessary to add reweight_task in the prio_changed_fair()?
> >
> > I think that's the wrong place. Note how __setscheduler_params() already
> > has set_load_weight(). And all other callers of ->prio_changed() already
> > seem to do set_load_weight() as well.
> >
> > But that idle policy thing there still looks wrong, that sets the weight
> > very low but doesn't re-adjust anything.
> 
> By adding a log to observe weight changes in reweight_entity, I found
> that calc_group_shares() often causes new_weight to become very small:
>

If I understand correctly, the on_rq matters when doing reweight.
In the following calltrace, after the entity(task group) is dequeued from
the tree, on_rq is 0, then subsequent update_cfs_group()->reweight_entity()
does not clamp the vlag because reweight_eevdf() can not be invoked, which could result in
the scaling(237238/2) of se->vlag quite large.

thanks,
Chenyu
 
> Hardware name: Unisoc UMS-base Board (DT)
> Call trace:
> dump_backtrace+0xec/0x138
> show_stack+0x18/0x24
> dump_stack_lvl+0x60/0x84
> dump_stack+0x18/0x24
> reweight_entity+0x3e8/0x5f4
> dequeue_task_fair+0x448/0x948
> dequeue_task+0xc4/0x398
> deactivate_task+0x1c/0x28
> pull_tasks+0x200/0x334
> newidle_balance+0x3cc/0x438
> pick_next_task_fair+0x58/0x670
> __schedule+0x204/0x9a0
> schedule+0x128/0x1a8
> schedule_timeout+0x44/0x1c8
> __skb_wait_for_more_packets+0xd0/0x17c
> __unix_dgram_recvmsg+0xdc/0x3a8
> unix_seqpacket_recvmsg+0x64/0x74
> __sys_recvfrom+0x14c/0x1e4
> __arm64_sys_recvfrom+0x24/0x38
> invoke_syscall+0x58/0x114
> el0_svc_common+0xac/0xe0
> do_el0_svc+0x1c/0x28
> el0_svc+0x3c/0x70
> el0t_64_sync_handler+0x68/0xbc
> el0t_64_sync+0x1a8/0x1ac
> reweight_entity: the lag=-831088603030 vruntime=2086205903
> limit=3071999998 old_weight=237238 new_weight=2

