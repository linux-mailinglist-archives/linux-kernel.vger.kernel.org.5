Return-Path: <linux-kernel+bounces-91488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA6871245
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C879B1C21989
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8112B71;
	Tue,  5 Mar 2024 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa2ceZ2J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDF111A2;
	Tue,  5 Mar 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601557; cv=fail; b=X9oPzwTK25tdbJCuEZ9Mo1yTco3VzhAFAph8XTfdWFjJSnxTY/TLc/bispHfQi5p7GIbOsjkhiFJDXI/c6g9UMDV4YNRnhnU4sDB+E0wnUh2pNX+rlxOD2RAhLnFnsAcsg2YyYGo7QqZiKToAyQ45U1KwL/ryD4buUdY/pY14yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601557; c=relaxed/simple;
	bh=Efp2/+HkcWxH72EGDh4NJzn1ONublp6xKrVQ6MqVv/Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OoEaTbq+Ms+SI9B40iCvruMnz3OS/NEsBRjGM6cO8I3jSv8rtCAAcov2FYAXhXVseokPF9tPEGcPyJoHfABo5Ty4E77nPjm7Wyttl5wXzRKi7mtkydBQBMLu4j3wL86TVVTPsSx+EYoq4o46VH48X4U0T99sgJk4d8BQ0WxruD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa2ceZ2J; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709601556; x=1741137556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Efp2/+HkcWxH72EGDh4NJzn1ONublp6xKrVQ6MqVv/Y=;
  b=Xa2ceZ2JyfSnYM5mQI/1IY0+G5LfwxQVnFuaWpsRx3nT3vjGVIya3ULW
   GqBo6f4YNGWgHJ52J7VwO7aJdfvRQBuoFWoJ4CK4nTKZv7/CdWxo4vyEb
   f3u77/poT3KbQhckXw3mK/t9gV/Li3C7Pdts+4ZPObthaIEsil0+nEiOY
   F3t4Moixel2ZLNabEB3fYYvcG3sqhcg5VEvRy6DE6A/Z/mioTuPXZYDBR
   rwylfZJ9XTQnn45k2lRhpd6TvyZ9B9OSHW3OIZEoUrqP8ah88UrQvuKmb
   e80RpElv+nUy/WmHoBGE5wDe7ED1H2LRv1X2rKin3qfaS8tPGdXSx2wnm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7940110"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7940110"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:19:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40067789"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 17:19:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:19:11 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:19:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 17:19:10 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 17:19:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Doyy7rMy2BpZd9L692JiVSsVBXPfWvQkQk0oS2Id63zDDFKtKTLpH/1tSeFNNQTWTblk9CgcIZTacG6B+oZOqKiI8dPZEuIaBjRkdSJjf5q1LOh65x0P1D8/Rinj42/nYcEzYLyXGnvy0TeYZMdw577ymEuhWbdLgYdxOt/vGqq+sdovF2UA7kYFM4OP1n7TxlYnYgCrGIMH1BIU1ptfWeNamCNfiWzje+BZqYFTOEMv4qrv/0++2lztoSb9eYgPGxY+ZQ5eJlFasvbHejiIeWyXgF/XPzPakHcPYpw/PMeiBoKepRWfN59sfpXoppf18FWgsMHa5WE0IYUW91NKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyvuIBdK0EXBr3OXP4r4T1iYKX9SvvHgOAxQYvQyTwo=;
 b=ePceCA4bPTkEBLQGUynIYrjZ+Ln+Gem8w4webmmMxs/P0KXC7XMjwUh/5ouepTnReMMm7mEuAimOPFxQOlC3L62ooI0QTBaLDiXMx+P3BSutUHdCXonOHsEpgQVTLvhmg3uljeFaimVbAnn1pHkpS+7C8afiO2ppdQ29bxDj49ctz4rVWxReDK/5o54aY5qEbF+ViETJ2RoquQPOK3D4msgHmEX2fncAla4ahAOrdvTrmHXnawsdzHK7TgRfMyplpzxfzAPbd0zpVL/U7HWkNmuLOW3KhXUT2uwJjxgHChBEoJXsQn0lfRPCbAwVnd29tyGKfckW/CVxP8Y4LCvvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 01:19:09 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::4422:63f4:41ce:cc6c]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::4422:63f4:41ce:cc6c%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 01:19:08 +0000
Message-ID: <3d5ffd62-beff-4394-91e7-715b348b7bae@intel.com>
Date: Mon, 4 Mar 2024 17:19:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Dan Williams
	<dan.j.williams@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
 <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 88407ab8-92a9-4d52-89cd-08dc3cb241de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUfVId9oliOtTIlHsxq+3dAVscsirWNpKGDHtdBAUA9qT/7n9o3vBNK+ZOAqhS1ZZ84U7i7l+fGXZkWEwmG8Zzzljscyl9+mu6HVWNf64jV0Eqk0ozW1BjzPigLCIHcCwohazXGI2UL+bTybVrzNqrl59kheapAk5eOG6kZVj2jGs9QCo6P9u7DgLGDcRVywarO73svHpbHYpsV5o/9Hj2iZayqi3U4t8E4kkn7Kjxd59O6qTgj2d0G6ceJ7DmoS+UuB8JnG/MF6Lxef6l1r1Ua4urv89HqWeyD2Yal8LMukLPc1R8f3XviVedKoaqoqryiB+x5X05JYz1phUhbUs6gYJ0jzF7NQOr+Z0z1oxwppcEQGnemdHRBJxLoZeyZLQOBVb37Cqt/FLrUZnPWim1+ciSbKOqnZ/enxYyNn8CyrBoQrg2POmZHbq0ZrfH1ZY00hbelGLAv+li+E5nyTX3O6Jrsu73GTETEoLPUktVvSx1gwvyXU1/BPKm0Cgy+3OZr/0S09OSlUUIkKU0UMgdRLQSCrYTgR6ixf4JFBA+maz7t8tcc20zeQ/0pwkIbxkerAj5KjGJbaMT2+p26o10Kd+KoFHu+sRljkaDahcu2PfsyTJB1G+keMN8ON/ETx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVR0dzFLMnlhVEtndlBiaWRxcllrb3dHR3JXSWZscWk3d2hxb3l4R25RZ3lx?=
 =?utf-8?B?QWFhVXFBL1dFWU5VQldXZUJtMUhGZHBvSFg3V21wR3B3MllrZmhGRmZMUTNX?=
 =?utf-8?B?Yyt2WEdQUURLa3F0bTlETVJDSWtGRmdHZVYxVW5SdHdXem0xV2pnM1hwVGRp?=
 =?utf-8?B?MUlNWkU0SVpXZjVJL25PMkk4dG4yR0ZNdnF2ZkFiVmRCN3RCbG1FZ1hUblVQ?=
 =?utf-8?B?RTZqNEVPSWMyRGpVR0djNGRZMjJ3cXc2UVFETkdodEkxN3U3dy9NclZWOVAr?=
 =?utf-8?B?Q0xidGx1V3h6WjZsT0pwOFJBL0N4Y1pwT09XY3dTYlN4RzZlM0hRQXVKcGE3?=
 =?utf-8?B?cGhLVDB3VXlyaFIwYUFQRm41dEorUzdsRjNuQk1GMHZkNXVKSG5XZXR3R3N5?=
 =?utf-8?B?eVRvZXpyLyt3SVdZaDFFSktZeGtIWGIvYTJUVFdqRWVqQTBUYkdlcUdROU0y?=
 =?utf-8?B?enZvTWZzV2Vhdll4NmVIU1dla0hHS0pFQWh3Z1F1V2syNFpYd2Z5bXBrMTdT?=
 =?utf-8?B?QnU1Rmx1dkNLYkF2NmVuSmdlS1lidm9CSm0wcXdXQnVkUDRmWFAwdTFFRThS?=
 =?utf-8?B?c2s4UnMweHNOYXorNEJJUXpYZ0VBT3JnbXpkVnVvZ3kyOWdvdXA1eFo1aGQ2?=
 =?utf-8?B?cVBlSCtNZi9ZS0NPNCtQQUo5aDlYVW5PYWI0RjZSbG9aK3BMcTVVd2JlcTFk?=
 =?utf-8?B?WnQxeG1XM2FSbFR3Z084eDMwcGhBVkFxaHg3Sm0renpGTkkvV1VlSU8wQlZ1?=
 =?utf-8?B?NnFGcVdYZG5yUVpCQ3dnV3dwYnZ0bkFCM1pzRDd2RkhKMDgyNFkxZ1hoNUVj?=
 =?utf-8?B?REQ3MWs2S1BkYzNiOXEyb2FKQWRiYlpxLy9Gb2ZxV1p0MHFtc1BwSHZ4ekZl?=
 =?utf-8?B?eVRrK1MvZml5M0E5RURyNVdjQlVFSm55dThhS1VZT2xKK2YrZmRVcm5HTWFv?=
 =?utf-8?B?UGIybytRMXdvbDJmc0lIdm5HR3ZhdldYcExLL0x3aVBBdmhNRVhVMFExbHBm?=
 =?utf-8?B?MVNEeDZUU3ZHa09yUlAvTFdvU29lYkYySzRTTzRENHpFcTJjVlFUQUp1Yyts?=
 =?utf-8?B?QVB5elR1NW03ZjJLUUxxK1dwN0FaMFIzWHFyM0l0WWdST2Zrc1JQNjdIeWhN?=
 =?utf-8?B?RTZVdDhGRFNjUUhnQURuZUpYZjZSTDdZRDRGZnJxUUZkM3lqUnl5cmdqN053?=
 =?utf-8?B?MTFEQjRoNDlUMWJTZjJYLys1bzF2Ulp4a1JXMFdtZU1Rb0hxTkplUDhNWG43?=
 =?utf-8?B?RU11aVNrNmJuMkRiSnJ2UlhhYlVWbDliNXF5UngrSUtoTU0xajdNSzZwemU2?=
 =?utf-8?B?VHhub09wb0FmaTJEV281ZlZkbDF0MS85R1hjK2xVODhQMzF3YUt0Mkk4RWVu?=
 =?utf-8?B?VWsxbUw0U0FUL0x1dVp4QUdVanpyalZFSURiQitVR3NrRHJlR1VmV2R0N1NS?=
 =?utf-8?B?QUdlUkpqKzY3RFlmVWZGOGdjKzN1d3pvSnBtT01DREp6dVFpZy90QktacklW?=
 =?utf-8?B?d3A2RlJwTVBNdS82cU9tNTZYL3RjVVAyS3ZPaldReG5MRDNTM2NIMDJCUkxL?=
 =?utf-8?B?dDJ0SFppeGhZcXppV3RMWTZBTTRZbDFGeVVqU2pPU0RvNldXNWVaMUN5emZx?=
 =?utf-8?B?SmRKNnl1djJ0MWxaWlRWbTBkUGVBd3djUjdFb2FhelhxTHUybzFTYTBBZnZ0?=
 =?utf-8?B?THBGZzFoc0J3L2lPRmJsK1pib0JXK09GM3BUNk93azg1ZXRTNXh2cms0RXZT?=
 =?utf-8?B?RkRqWFA4Qk8vU1dKd0V0QkRyTVhJTWlxWDZYVUNWc05mS0V2SXpwejdzZ2dQ?=
 =?utf-8?B?NG12TlVtOEtPSk56MlExd3BEMGV2RDEzQUtzYVl2ZjdXU0NWcUpxVXFKS250?=
 =?utf-8?B?ei9jNXE2b1R2NUVXY1VwcEVkWHJRMys4dmlsbktGQmdVNGJ5a0g5SUhBa0kr?=
 =?utf-8?B?Qk1RZmdkRkQvNmIxZmZScUlWdXltbURMNm8vZjVKRUJ5aGFQbGZtMlRlbnp0?=
 =?utf-8?B?Mmp4Ny9IMmI2T1UxODNDanE4QmZIVFJBWlNhZWJPRDV6dDErL29NT1o0UGZK?=
 =?utf-8?B?RU44cDU2K2RYV2NDbkErV09HSVIwV1lweFlINDMyRFQyTi9YNWVaQ09wR0da?=
 =?utf-8?Q?DkI9gzvinSxIaRNGPBCzbdR2P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88407ab8-92a9-4d52-89cd-08dc3cb241de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 01:19:08.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3IZtosBc6DBdKDl2NZu10NBMzbh3AzeLm2cFZCgrbLsTQK4wHdbvF7o7rb7H249FgkC8P8ZKVnaY9IaEDgyuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
X-OriginatorOrg: intel.com

Hi James,

In the past couple of weeks I've been thinking about what should be a 
good log format that can be conformant to existing standards and 
accommodate future applications at the same time. After discussing with 
folks from Alibaba and Intel internally, I created this issue - 
https://github.com/confidential-containers/guest-components/issues/495 
to document what I've found. Although it was written for CoCo, the 
design I believe is CEL (Canonical Event Log) conformant and generic 
enough to be adopted by the kernel. Hence, I revive this thread to 
solicit your opinion. Your valuable time and feedback will be highly 
appreciated!

Thanks!

-Cedric

On 2/13/2024 8:05 AM, James Bottomley wrote:
> On Mon, 2024-02-12 at 23:36 -0800, Xing, Cedric wrote:
>> On 2/9/2024 12:58 PM, Dan Williams wrote:
>>> James Bottomley wrote:
>>>> Just to correct this: IMA uses its own log format, but I think
>>>> this was a mistake long ago and the new log should use TCG2
>>>> format so all the tools know how to parse it.
>>>
>>> Is this a chance to nudge IMA towards a standard log format? In
>>> other words, one of the goals alongside userspace consumers of the
>>> RTMR log would be for IMA to support it as well as an alternate in-
>>> kernel backend next to TPM. IMA-over-TPM continues with its current
>>> format, IMA-over-RTMR internally unifies with the log format that
>>> is shared with RTMR-user-ABI.
>>>
>> I'm not a TCG expert. As far as I know,
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub-1.pdf
>>   
>> defines the event types for TCG2 logs for firmware uses only. I
>> cannot  find a spec that defines event types for OS or applications.
>> We may  reuse the firmware event types for Linux but I doubt they can
>> accommodate IMA.
> 
> The TCG crypto agile log format is
> 
>   index (32 bit),
>   event tag (32 bit),
>   digests array,
>   sized event entry (up to 4GB)
> 
> So an IMA log entry can definitely be transformed into this format
> (providing someone agrees to the tag or set of tags).  The slight
> problem would be that none of the current IMA tools would understand
> it, but that could be solved over time (the kernel could use the TCG
> format internally but transform to the IMA format for the current
> securityfs IMA log).
> 
>> IMHO, we don't have to follow TCG2 format because TDX is never TPM,
>> nor are any other TEEs that support runtime measurements. The
>> existing TCG2 format looks to me somewhat like ASN.1 - well defined
>> but schema is needed to decode. In contrast, JSON is a lot more
>> popular than ASN.1  nowadays because it's human readable and doesn't
>> require a schema. I just wonder if we should introduce a text based
>> log format. We could make the log a text file, in which each line is
>> an event record and the digest of the line is extended to the
>> specified runtime measurement register. The content of each line
>> could be free-form at the ABI level, but we can still recommend a
>> convention for applications - e.g., the first word/column must be an
>> URL for readers to find out the format/syntax of the rest of the
>> line. Thoughts?
> 
> https://xkcd.com/927/
> 
>>> ...but be warned the above is a comment from someone who knows
>>> nothing about IMA internals, just reacting to the comment.
>>>
>>>
>>>>> I am wondering where will the event log be stored? Is it in the
>>>>> log_area region of CCEL table?
>>>>
>>>> IMA stores its log in kernel memory and makes it visible in
>>>> securityfs (in the smae place as the measured boot log).  Since
>>>> this interface is using configfs, that's where I'd make the log
>>>> visible.
>>>>
>>>> Just to add a note about how UEFI works: the measured boot log is
>>>> effectively copied into kernel memory because the UEFI memory it
>>>> once occupied is freed after exit boot services, so no UEFI
>>>> interface will suffice for the log location.
>>>>
>>>> I'd make the file exporting it root owned but probably readable
>>>> by only the people who can also extend it (presumably enforced by
>>>> group?).
>>>
>>> I assume EFI copying into kernel memory is ok because that log has
>>> a limited number of entries. If this RTMR log gets large I assume
>>> it needs some way cull entries that have been moved to storage.
>>> Maybe this is a problem IMA has already solved.
>>
>> We don't have to, and are also not supposed to I guess, append to the
>> log generated by BIOS.
> 
> We do actually: the EFI boot stub in the kernel appends entries for the
> initrd and command line.
> 
>>   The kernel can start a new log, and potentially in a different
>> format. I think the BIOS log is exposed via securityfs today. Am I
>> correct?
> 
> I already said that, yes.
> 
>>   For the new TEE measurement log, I don't think it has to be
>> collocated with the BIOS log, because TEEs are never TPMs.
> 
> This depends.  Logs are separable by PCRs.  As in every entry for the
> same PCR could be in a separate, correctly ordered, log.  However, you
> can't have separate logs that both use the same PCR because they won't
> replay.
> 
> James
> 
> 
> 

