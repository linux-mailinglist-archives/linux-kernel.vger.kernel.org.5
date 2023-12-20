Return-Path: <linux-kernel+bounces-7512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A981A916
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D01C22A16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B24A9B0;
	Wed, 20 Dec 2023 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkqFiPsk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C294A997;
	Wed, 20 Dec 2023 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111101; x=1734647101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r4xkDBtXpQn7JbTu/n8bDeN51FYgb/WllhBMvDQwdMw=;
  b=JkqFiPskBDFWo6k2j2YEksdk0zpg3Kud158+afff65+5fVLnv0+3NmU1
   GP/xfAl+gzkNaaVhU/MAdkOF0qX+WpuSobHicw8WwCw+iqeahwwZ1JUqI
   fQ/qfkYe4m9CBGf0JYoLU0pjRdQZuLfabHexRNIxJAHrsE+gessiyOt+a
   3UXzgvGaicdCgSxpQTtZ5g1+0qWdr9dc0tKm4A1HKd1WLeliwP57ppcWk
   K3tl2FHqCVRcoqOVcdgontyXzhkc7ospAc3fBT5T6y5Tr72b1GH8fVPQO
   gUJuNM36mvTbFiqyjGRPWi4jidXIF31zdAunW65Y5W1N/KWUR0Oj6Jch1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399715162"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="399715162"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="752711507"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="752711507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:24:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:24:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:24:58 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:24:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnXZluroPLUyYFSvGHMrIuuxQb0xaBY5xjUZpb27sP5KiJjsiCTwMZKT1dJeg1VVCyNuK4Z8FGPDSGoqoTNyvAAt9RkcZYPpZRrQs+L4ui1moNVImDEdvIEjJKD4mh8G3wXbxcPLEZEXYITibolCZrJ/rEjQEF+nmNjeyhOU45MS12zM+U72LUcy2CildZ+NIoOz08FhXLdoreC0+7nW0I/CefbIGfGyFNZJIpbdAlgZtnGAmZLmzVYXRgOxNlW0+vDZpdopZC6/WoGg/T5DQb5eqO5mZ4mwurx/l4kAadUrQoChpXZWHf2GJs8CQbPmla2s79m8J3iB0WoI3aGiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puWBRQf4Fsp00aCfqZyuhqh4UxowsnFjhxg3pS2guMo=;
 b=aN+6GvOyE+bWejMw/NHn7IDYdYUALvjLOpDjFEzOnrbYffz6otb8hS9JEy7pt0riYnp0HKnG3JpL5ei4/JDRB0J0clO7ycFTGrOGs4YHS5PTr85ARchECFImIYsS1n38MJosBIBPVuQOhK5MReehtFRRA/PfgMVqdJ7B3XzJKt48IGrYNXB+ihwpftAYWrSE5w45WG1jTnBTzQWf0r+KvpFiM266bwgYgH45gSCECzyAvTYbCKrfXwS9t8iDl/3h3uzdXfoKQcx8LbPeTWN4G6MlPbGK5tLS8wBwIUtRlmD6IVF7uvPBN4T3lkJHiArYz7LeJ4NbodCHRJ5B9w6E1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 22:24:56 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:24:56 +0000
Message-ID: <a9b5c452-6131-4c73-a972-566551df381b@intel.com>
Date: Wed, 20 Dec 2023 14:24:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/12 net-next] qca_spi: Add QCASPI prefix to ring
 defines
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-7-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-7-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ0PR11MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ccd45-7bca-46fc-853c-08dc01aa7e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNIQkah33GlaY2wX+X7VsyoaJwTYnUHn46fC/V/xMZikunnr23+lFhYX3/YvpWjo1PQN3tlTWU3M93z1DtbVjD6eTIxQ5ZxZ7vic41CUAwoitgPlrdXCyCYzw1CpbZvML4y4nK/SliACMzzH+4r2ERDXv+SP2Xu5la7Qyn6MYA4mwWDvTuHYGvaAF6PTMANEKBDjVQdK2wtca3WUnK8BkkBVSTQexNtvd/xJtuYkTzajlmFTNFNrckjbiu5jFIWBy0ZXJg/j7Obv/Y2IUZGRyB3uAYFnp3+nMvkjldqv5h/uS7RK9ilJqLhqPahuhQ9ICF/UkgYez9zYvykLXFtI4evSFzFq9TyYp57UsBETnVvGsws4JrXABuWsHNl2u7zx1O705l4JIMRQ85VboZosE4gKIwWgC2Xa3uhIoiB/V3DLTpox+IFmsQc5388pzBjkQa9va+vkv4uvBrgflJXBhxnlQJC/LlW3Wo6JigKA2Ml5xA+g/1MJquYSvLIyfNxO6qQnQe/xoyWTTvt/oZKyIJSmCxB5t3stLWTJd2u1quahwgGzOo/IfrH7xBiyvWgajiJgV1CHitQl+cfJIZ2AXfXMIfKXPPNs/0aovgdrvy5YSjDlLKJB4+WWSIvUPwXusoj1Q01kWpCgnM/8OgTIyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(38100700002)(41300700001)(2906002)(5660300002)(4744005)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(31696002)(86362001)(26005)(82960400001)(8936002)(110136005)(36756003)(6486002)(83380400001)(6506007)(53546011)(478600001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG80WUFiSTk1ZHV5TG0wQlZqQVI3Zk51WE5NWHNyTUtONWhpL0pJVklEdjNh?=
 =?utf-8?B?NUp4anlCRk43UXdkNG1VWjBnVFpRcVkvVTh4N3RQcXJtWlVGS2d0bVhaa1F6?=
 =?utf-8?B?UDQ1alltdy8rODgycURRT01EcitxTVRoWTczTlhVSTFkNTVWUTFKaXZZcVJI?=
 =?utf-8?B?bUsyVjV3WW1Ebm05TnZXcndrbWpnb2R5bmxYTW8xRHVZVDRObTJtR3ZDOFJR?=
 =?utf-8?B?Ny9FZXdad2NoOWI5SjVqVjlkQ1lpbU9KTGs4RGgwWTBEOURzMUNQNzlmeXZ2?=
 =?utf-8?B?VlNhd1FscmkzZ3BwanZZWGk0QzVUcFlmOHRNbVVNRTZZRFZZREFVNDNSWW8w?=
 =?utf-8?B?MVQwN2FyRklBSlRVejgzaWxHdk4raUV1dldYWVFtSVVqTXZwZ0RyZXg2R2Nn?=
 =?utf-8?B?MzlSc1QzSEdxMXFlTnFwZjBrdVpRRDAyOHJCU0RrYmg1QWNMclIzZW56akVt?=
 =?utf-8?B?ZUowMGx3Z3B4bEtUVy85WDhRWmZpVXlyWm8wUzdTNmdNcVF0SzlGd0FIQWZT?=
 =?utf-8?B?RzY1bjY1V3ZySVI5bnFlOEhMbWk5QzJmRFNvNlpseXU5K1FreXhNcXl5bUsv?=
 =?utf-8?B?K3NHZnAwR2FaekpVU0I0M1FHV3VaQlZWbXZFVUxmb0tEalJRVDUzM20yUGI5?=
 =?utf-8?B?VHRhQ1pHck53MGhBOU9RMEp1dVhjQUZqeW5hcTE0ZEM0cHlnSGhYa2tvOFpz?=
 =?utf-8?B?dUdkdU1MMmFjOERCbUZaVCtVaDlQVXVnTDRQSzlTeXNya1lGN1h2SUtZdDlX?=
 =?utf-8?B?VFJVQW9TdjZKY1NIeXN1eENWREVNL2tpYnplNldYdm1udk9aeldmMmlVdThJ?=
 =?utf-8?B?V25rWTNoSFM5SWQrcCsxZkNJU1NyamlTeUUvQzNXa2pydmxzM0xvaXRpTmVn?=
 =?utf-8?B?a3ZuVndmL2lZeHJLYWFXM29xN2NFNzVaRE9HZkt2K25vYjQ4ZjNRVC9obytW?=
 =?utf-8?B?dFdiaFUxeVJac0RXSEJaMElOOWdQYWhiSVFnS29tTGQrdXR3MndFWTFpNThW?=
 =?utf-8?B?TnBlMUY0SzByc01FVDZVRExiV3h6bldxQUtwbzg3ZWVxOWR4V3ZiSjdZTTVk?=
 =?utf-8?B?M3ZRL2tGV3dvUlIrYitIY2xkUkVWTWV5SkdoZGl0SElCakxXYTk4ZkhGSGJw?=
 =?utf-8?B?RXFvMksrY1pMc2xrTXlyZ1BVWDdadm1hSjJPc2Zvbi9ZeU53bW52bGlxVW9l?=
 =?utf-8?B?ZVR2Ky8xM3FhRDM4ZlUzNnRRTVphY1oxWU8wa21ZdjhoUmV1cmhneVdTc2Rv?=
 =?utf-8?B?cUNJY1VIb2c1UGEwU3hCZXFCcnNkeTl4ZncwSE1EazgrZGZDZVo1Mk0zL3c0?=
 =?utf-8?B?dm1tL1NVL3krT3ZtK2F5MzVoWnFtZDJEY1V0TUw1QnFCUEkxSmJSdTUyeFNI?=
 =?utf-8?B?bFgxSmt4bkNvVUkrSFJhQWtMNFIvQW1pVUdycnNGSVhGRWpGc1ViWUtaZnpE?=
 =?utf-8?B?REovbWJ6Z01scWtHNGViYkcrcGkvc01FZ05oVFlpWVhoUERObDluUVIyTkFJ?=
 =?utf-8?B?VjBHY2NKQXlqcnluZVplNjR0aWxQVWt3NVBwM3JKZmo0UTc2UkRLZ0R6b0Vl?=
 =?utf-8?B?Rm95UjVJNk8vWEZPc0ZnUVBpQXBVcjFNekF0RUl6WVJKOFNVcHg3MkkzVFQv?=
 =?utf-8?B?YncwcUEwUWVEbUdnakxTWTdxN0E0OVN1UkZCZGxLa1lYR3B3dndBU1ZLc2lW?=
 =?utf-8?B?ckNqVVRSb1VkRVNrTkx5THdYNVZGajRZaEtpdThsUXp6NG11OVN3YWhaelRa?=
 =?utf-8?B?ZUFxbUZkcm1VVEJqcTBNd0Fta1JhTXpEeHZkNlNXc1huZ3hiRGJXZittWHhE?=
 =?utf-8?B?UisvNDdrK29VL2xFTjZSNVlQL0xmRUplc0RPSUVEbDQzRDJSZjZTVVRXVGtj?=
 =?utf-8?B?Y2VubENncU5qL0JBV0pkYmZyYkVUVCtrbmswVTk1NVFscGZacTJXcW9lMGg5?=
 =?utf-8?B?cGwvYXc0QlVOdjZTalpNM1hqbE9jbVIzY1VOQy9lMlBzREJnbU9GVFhnc3Iw?=
 =?utf-8?B?VnBhY1hkdTRacjNQSkhSWlhQS3hBb2JjcUVVaGJ0SVZTQ0tIbCtVREZJUWVv?=
 =?utf-8?B?ZTVBSG5IUnRLcGJrTGN1c1J0MGszL1BLbjV1eWRhVy8vTmVvN3VIY2JIZGRD?=
 =?utf-8?B?MTZKNmo3WW9RS1l4QlNTc2ZjN3BPRlcrNjZ6L2JqZkFocUdUYWFzcXBhSDVt?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ccd45-7bca-46fc-853c-08dc01aa7e72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:24:55.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBSgK6xjub0phuxsy9bdgCOcDyhIL2EMtNIMvKcnTuBOo+dEuTKXkihAH6fL2mWi4lQfGNzL6Fg0JqVTnp2cMO/aGB8CRcrxaFoDpDoQDYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> All defines in qca_spi.h except of the two ring limit defines have
> a QCASPI prefix. Since the name is quite generic add the QCASPI prefix
> to avoid possible name conflicts.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>

Makes sense. This is in the header too, not just a single .c file.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

