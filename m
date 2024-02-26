Return-Path: <linux-kernel+bounces-82270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EF86817F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C775A291DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5ED130AF9;
	Mon, 26 Feb 2024 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTJZwrFx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA160BA1;
	Mon, 26 Feb 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977300; cv=fail; b=RwKM6lfo7bJ7AHD1I/XsXjUuze7xdO94wsEVWyKpKke7d1eihL7tXwONVmoSyiYBaGCXDpQsy5X3Xaiz6QPAfzEknLEfq9RvFYq6knf97Tr92YJbrrqd+HFRnkvYbzb4fiUSCUbLmALbbmymdEsk8DgCs7LSnkuIMpIlcyGR/5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977300; c=relaxed/simple;
	bh=oS393CsZp4eDKHf4ljXTITOLNXkjl+kOuMPgQeNCNno=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZJE5fWa2KlQBJDpD9LjGAxfSNxp1pDBNcL0JxdDK72ts9h0lOzC0/O2dNwF1fEfo3bnXW+2WvNkIrF0Qt35r2xBNou2C7R6lry7OVbho15Zo8urbX2gBmFa2Izd7zideRB/a3FUG9KlPWHExKuI0tOhDO41qDh64edyrHJAFw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTJZwrFx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708977298; x=1740513298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oS393CsZp4eDKHf4ljXTITOLNXkjl+kOuMPgQeNCNno=;
  b=QTJZwrFxLO9917waRa8jNWolG9nbeNNV6Rfgnm6KXriQkPEa0KNZTJGo
   M9op3z7/ArCsyrdlJkegV7fNKowQAhm1pt44sOkbkpG7eIs9iOLDmHCIB
   TA6Rzd3eUr1xNIfirBDE/Yq4Tx+laZm6DepIXfhBTxlyaW89kxlnu10hC
   y7SQPxxDOXBVipYxIlVkmdC7ij5pc5A2bPbAWJjSVdVsx6tDYP+EJp0ir
   6jFclatOmME2otx+WlSIiYQvJ7nrcoTm7oBuBzcQvbJHV5wrGONvVHP0h
   3JYIWTZaSrDy3OPkG3n51rcYLpKNeKrqz1iVM9ZPuaZYYz5XELhGkkpUi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3448333"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3448333"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7320782"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 11:54:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:54:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:54:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 11:54:55 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 11:54:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ3gnS738ME4b4HJTGqkpEjnZWNwo4Mcq2ZdeZvXE9w4ngp4BYOfV6RQ8lyrlNYZh5azzLT3rrgGQZsAyTuU/KqvaI8ygqFy5YJ4pmZDEzA9n4zIHcZzY5wyj8rj0Mb0RNXoTKmzo8bWMhaf6JoameOxlERcMF9vXrYvIB2bazs9Q/ZZsilm8/Lu5CMm/S1g5LKhEwFY3DyBokmyzRBPdavJe+qXNhd5PmkQTADGlNR3Y7pM02vKwtnzoTCF4w8iW5kI8q489ZN3HDih3FXT03YNj7OgP/fE1tBv5B6zIb45VWmRhtypXhL6CdNSPkuyh+I5D17e61o9m3cLC5Klbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Pnr6Wuyvl8OKaYOp00jYv3VGYy9sSqTpC/keGfApY=;
 b=JcVApfDZzZJpQ2mzPoVlTXuql0xjbtRzx5MHBNqXzFRMNpSeN39KOqhNOTx1gZ8ygCky73Gid5KOvX02JS+L6hkDDOxfKKEH02kk8ms/vf8NiZXl7/OIJeMSscL48CTAHyTVfWTjQ7LSPuyS1/GplnlzZmDok0qW8ju5gx35xw/Ybcg3maOKJ0zSdsxGgkFXdk1mS/iI1Kq9NH7xKOWpSFiAXyqmDnYIiI4RtSU04idJWqUJLBaBoOg/pG2z5GsRcnDDLGvX+vQa5ie9Zka8dOrJHpyJ3KSKEZ9jBblieoBb73PR5T1nUQQtXRVlH5PRMYwKK9KG++Iegl/gmzfp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 26 Feb
 2024 19:54:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Mon, 26 Feb 2024
 19:54:53 +0000
Message-ID: <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com>
Date: Mon, 26 Feb 2024 11:54:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Content-Language: en-US
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com> <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com> <87il2evhtk.fsf@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <87il2evhtk.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d979e9-5d1f-4e6f-6f70-08dc3704cc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vp6FevFnNQ9F2hcrA5ZvwfcoQN6T68AsUhuvyUYk02S1feKvwzKYhifQ8z67FcQpaYZb8POJ+Z18TsHYhrVorh5Pqa2+lsncXlaiZTZw5js9H6K5s2LOtRa/rHb0bv4eGZghJtHKF8Qs9k/3bPZsQduk/+LOVb9ChGrztsDGHRG1Wxv7fDbj3VMz2God12FBIouzNe02jkN5Tz+pCoabBGZ6YQpkuvk7F4yo/pFRpPIRC6mmAe/1kfqVopdIe8PUIVI6R9Gj+khJHW10a73dGzWr3baNeA5qTHr/m5jyz9XDHvFcPlASP0IhLquMpLCztL7Umor/5/TCL75cBsXSpxIcXUUs27Lr085gJQko6Mr06OfixJ+tvymTN+egUPKtbT69U+WFbVzWznr3BbknI0TifCitRjbqHKlqmEZOrclIhxQJRFh5+ACvriUs3mjf68PMYdfaPJB4CrEnWS2B3IdoOaGen1t7TGrXYe19VUNhAVeVc4dV/uBIaTufg6HpOI87ohIyTBhM0Sl6wJQFFG6rytB0gVIQMiLFryxP7xJMpwRbcVV2JhhZZXTX5Aj98g2+yPNghzJDeAQhTzBLKJijVs4YUXotRyx1ondWDWPxv2D94P5x2NlHur23hpI2NxluWBkgQJAUvOEGD9K8eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG4rUjJJa1pXS2tyRUo5ZDM0WDU2SzViT1lKVUtHOTZQYmgvLy9zTXh2dWpU?=
 =?utf-8?B?MS9aZml3V2sxTHh1MW52L1hVOW9FTTNITng5b0psUytkdlZGcGFaaEFxVkdN?=
 =?utf-8?B?THNPZk5SVUF0WFZRZHUvWHBISldSUm1QdHZ6VVdlYzlQWmdYclFaMHQ2dnlt?=
 =?utf-8?B?UzVDekNyTHRFblp1RXlBWVhUQzBTT2l1S3dVVDlRYVNkelVxOVdUa2I1bzFp?=
 =?utf-8?B?UkJYaG9yOEt0elRDUHloVWdrLzlWTHM2SHpsaUxpSVFnR0RBZURWV1B2NHZI?=
 =?utf-8?B?NVI0enF4SUZPRHUwWS93NkZyUHRkZ09VOElqQ1ZrQkZsa2JMSGhGNmE3VWxn?=
 =?utf-8?B?THBpbTJTdUlwS0ptNlJnNHJPQzFPV0lDUlVzNlIrb0N6YkNLMmhqYS8rMkJZ?=
 =?utf-8?B?MUJBRm1tVXpyalFOMGkwaTZ6bThSbFBXcjJxOEM5Vkt1ZExjaGxlTGw4WDdt?=
 =?utf-8?B?b0NOTVhSYUFKbnhHbGlsWUc0QVRlanprTG1BNEFqbjdycFhQRkMrblI5eEov?=
 =?utf-8?B?V3NwaDc3SjlDL25nbk1RYmc4dmw2d1hmZnNrdzA3eW9YMEhKVXJicVBqci80?=
 =?utf-8?B?SlV3RW5LamJSMTBtQ1ZEN1dWM3QwWnAzVTJMZGptZTQzc1A2UGQ3b1pGNEND?=
 =?utf-8?B?ZGxpaTloZy9PZXFmVm9reEFHcmRvSkkvZE9XM0R6cFl3K2tLRUZOY2pDOFdY?=
 =?utf-8?B?eXpBbDZqblBwQk8rZ2lhaWFydXlSSGQ0RWJKbUc0blpwZWNmOWRkR3NnNUll?=
 =?utf-8?B?V1pCR2xsczFNQklTZHNacldPczZ4cGZiKzkrQXZmVEFlUWNWMDljZG90MDc1?=
 =?utf-8?B?aXY4enlyZ09LTFF6bkR0VXJnUElrUWUzeVBIMVBjN014NFczVzVXSGFBUUc5?=
 =?utf-8?B?eXRTR1VncTI4UnRPMFlSTUcxekp3eURlVkFIdjVycnpjMnVYbzE4alV2bnRH?=
 =?utf-8?B?RkJGdlVheVFWY0dBRHdKNmNBRGxVbjMzVWxuWjU3OXdaRy9CbURxUDBOS2V2?=
 =?utf-8?B?ODNQTlg2QTVPeDc2RWVpMnlOb2hndUptR2RpcVdxVUZRZTlmYm5idFhDbU14?=
 =?utf-8?B?aUFqVHdLM2xTRGUxNmp2MmpOc1FmWWk3NG04YzVRRHo1T3NZYmxYaGl0WDFh?=
 =?utf-8?B?b3J6eFVjUmlXNURCZWFOUG0wYmRKV3F2MngzVW1RemE3MVp0ZHYwWjRYcmtT?=
 =?utf-8?B?RXR3K0MzQTNvWjMyalJnbjk4TzBYdnhMWFNQcko4Y0VnWk53N2U5bENqQ1Vk?=
 =?utf-8?B?ODlldVRRNXVwYm4rWCsyamdpcHRWWUEwWC9WZWdYc2hzMjAzam9FbTlYb1Qx?=
 =?utf-8?B?b1hnOEd0NGZ5TzAwUm5VL1plYlpNeE16VVcxM1pEeHIzcjFHL1ZSeGh5bkNj?=
 =?utf-8?B?RzVzWDVtcktDOXY2OHg2UGdtSFdxbW8rUW56dno0MFhEc295YWhBN0l4U3h4?=
 =?utf-8?B?NjdwTzJ5dXU2cndZTE5xVGFOYWd1NElhZXpRNWs5alV0cVNNZlZSOVYyRmZx?=
 =?utf-8?B?UWYyTDdWY3AzMjNsVWpVRjhQU3lZV09UYkI5bmpqMFlmQ05peldWOG9zWG5v?=
 =?utf-8?B?TDRGMTJoSmdhQVhqdUpkVXowMUl3dXdvTXEzZGt4MzdJMjRBY0FoTTA4d2g5?=
 =?utf-8?B?SEhoRmJVVHRFN3gwZnhsKzBLZ1JnSVV0MkxHT2VNS2hXQUtRVzdoalNGTTVP?=
 =?utf-8?B?b01UMCtpMlZrb3RPUjRCSitwU2orRW9EN3FPc2ViN2cyaXdSNDBML0U0T0pJ?=
 =?utf-8?B?Vjc3UUVFcFh2L1k2YWllS1BndzRvbEJFRGZIbWJlWmlJaGc0Y05Qbmh4NVdT?=
 =?utf-8?B?TkpTanVyeXhTOU1XZ2w5TndGbkpObmJFOGd0a3VnOWUrS0dMMVA2MHFmUzR0?=
 =?utf-8?B?YzZzUHpjZGdscm9LK2t1OFpqc1NwOEloTUVYQk5vVENkYWdOQ2wxYllOTE1l?=
 =?utf-8?B?N0ttSStUNmhnSlNmb0Q5T2ROc2VwQTI0QzBuN3AzRUgzWm53Q1RMMWNUdUtz?=
 =?utf-8?B?WU1SNGVoRHJQRlQ0R013WFpma2greWhmdTlXOXBFOTBnTjc3akZWVExYZTBT?=
 =?utf-8?B?cUFNZG5aWkdEQWVZMWY2Z0NOUXorZTdxUGpXWUdERnJVdVphWldLS1FORk1j?=
 =?utf-8?B?SlZsejlPMkdzbUduYUE2Z015MUFpZi9KYVR0eGFsM2srQ3Fjank3Z0JIK3hj?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d979e9-5d1f-4e6f-6f70-08dc3704cc9d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:54:53.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiA9SfKoOLlyhTO/DRoB0vMdf0DW080oBecAMPB1Hj9Ph09Qydk8jp4+V0ANCzLa36TwipF/9qK0w1It646EdfxzFgEANtAewJSQbXJvyv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com



On 2/23/2024 3:43 PM, Rahul Rameshbabu wrote:
> 
> On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>>> The Intel ice drivers has the following Tx timestamp statistics:
>>>>
>>>> tx_hwtstamp_skipped - indicates when we get a Tx timestamp request but
>>>> are unable to fulfill it.
>>>> tx_hwtstamp_timeouts - indicates we had a Tx timestamp skb waiting for a
>>>> timestamp from hardware but it didn't get received within some internal
>>>> time limit.
>>>
>>> This is interesting. In mlx5 land, the only case where we are unable to
>>> fulfill a hwtstamp is when the timestamp information is lost or late.
>>>
>>
>> For ice, the timestamps are captured in the PHY and stored in a block of
>> registers with limited slots. The driver tracks the available slots and
>> uses one when a Tx timestamp request comes in.
>>
>> So we have "skipped" because its possible to request too many timestamps
>> at once and fill up all the slots before the first timestamp is reported
>> back.
>>
>>> lost for us means that the timestamp never arrived within some internal
>>> time limit that our device will supposedly never be able to deliver
>>> timestamp information after that point.
>>>
>>
>> That is more or less the equivalent we have for timeout.
>>
>>> late for us is that we got hardware timestamp information delivered
>>> after that internal time limit. We are able to track this by using
>>> identifiers in our completion events and we only release references to
>>> these identifiers upon delivery (never delivering leaks the references.
>>> Enough build up leads to a recovery flow). The theory for us is that
>>> late timestamp information arrival after that period of time should not
>>> happen. However the truth is that it does happen and we want our driver
>>> implementation to be resilient to this case rather than trusting the
>>> time interval.
>>>
>>
>> In our case, because of how the slots work, once we "timeout" a slot, it
>> could get re-used. We set the timeout to be pretty ridiculous (1 second)
>> to ensure that if we do timeout its almost certainly because hardware
>> never timestamped the packet.
> 
> We were thinking about that design as well. We use a 1 second timeout to
> be safe.
> 
>   #define MLX5E_PTP_TS_CQE_UNDELIVERED_TIMEOUT (1 * NSEC_PER_SEC)
> 
> Our device does not do any bookkeeping internally to prevent a
> completion event with timestamp information from arriving after 1
> second. Some internal folks have said it shouldn't be possible, but we
> did not want to take any chances and built a model that is resilient to
> timestamp deliveries after any period of time even after consuming the
> skb without appending timestamp information. If no other vendor finds
> this useful, we could roll this up into the error counter and leave the
> late counter as vendor specific. I do not want to introduce too many
> counters that are hard to understand. We document the device specific
> counters on top of introducing them in the code base already.
> 
>   https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/counters.html
> 

We can't distinguish "late". At best we could notice if we get a
timestamp on an index thats not currently active, but we wouldn't know
for sure if it was late from a previous request or due to some other
programming error.

>>
>>> Do you have any example of a case of skipping timestamp information that
>>> is not related to lack of delivery over time? I am wondering if this
>>> case is more like a hardware error or not. Or is it more like something
>>> along the lines of being busy/would impact line rate of timestamp
>>> information must be recorded?
>>>
>>
>> The main example for skipped is the event where all our slots are full
>> at point of timestamp request.
> 
> This is what I was guessing as the main (if not only reason). For this
> specific reason, I think a general "busy" stats counter makes sense.
> mlx5 does not need this counter, but I can see a lot of other hw
> implementations needing this. (The skipped counter name obviously should
> be left only in the ice driver. Just felt "busy" was easy to understand
> for generalized counters.)

Yea, I don't expect this would be required for all hardware but it seems
like a common approach if you have limited slots for Tx timestamps
available.

> 
> The reason why I prefer busy is that "skip" to me makes me think someone
> used SIOCSHWTSTAMP to filter which packets get timestamped which is very
> different from something like lack of resource availability.
> 

Busy is fine with me.

>>>> The only major addition I think is the skipped stat, which I would
>>>> prefer to have. Perhaps that could be tracked in the netdev layer by
>>>> checking whether the skb flags to see whether or not the driver actually
>>>> set the appropriate flag?
>>>
>>> I guess the problem is how would the core stack know at what layer this
>>> was skipped at (I think Kory's patch series can be used to help with
>>> this since it's adding a common interface in ethtool to select the
>>> timestamping layer). As of today, mlx5 is the only driver I know of that
>>> supports selecting between the DMA and PHY layers for timestamp
>>> information.
>>>
>>
>> Well, the way the interface worked in my understanding was that the core
>> sets the SKBTX_HW_TSTAMP flag. The driver is supposed to then prepare
>> the packet for timestamp and set the SKBTX_IN_PROGRESS flag. I just
>> looked though, and it looks like ice doesn't actually set this flag...
> 
> That would be a good fix. We set this in mlx5.
> 
> 	/* device driver is going to provide hardware time stamp */
> 	SKBTX_IN_PROGRESS = 1 << 2,
> 

Yea. I kind of wonder how necessary it is since we haven't been setting
it and don't seem to have an existing bug report for this. I can dig
through the kernel and see what it actually does...

>>
>> If we fixed this, in theory the stack should be able to check after the
>> packet gets sent with SKBTX_HW_TSTAMP, if SKBTX_IN_PROGRESS isn't set
>> then it would be a skipped timestamp?
> 
> One question I have about this idea. Wouldn't SKBTX_IN_PROGRESS also not
> be set in the case when timestamp information is lost/a timeout occurs?
> I feel like the problem is not being able to separate these two cases
> from the perspective of the core stack.
> 
> Btw, mlx5 does keep the flag even when we fail to write timestamp
> information..... I feel like it might be a good idea to add a warning in
> the core stack if both SKBTX_HW_TSTAMP and SKBTX_IN_PROGRESS are set but
> the skb is consumed without skb_hwtstamps(skb) being written by the
> driver before consuming the skb.
> 

I was thinking the check would happen much earlier, i.e. the moment we
exit the driver xmit routines it would check whether SKBTX_IN_PROGRESS
is set. This would be well before any actual Tx timestamp was acquired.
Its basically a "if we set SKBTX_HW_TSTAMP and you didn't set
IN_PROGRESS then we know you didn't even start a timestamp request, so
you must have been busy"

It might not be workable because I think the IN_PROGRESS flag is used
for another purpose. I tried to read the documentation for it in
Documentation, but I got confused a bit. I'm going to go through the
code and see what places actually check this flag.

