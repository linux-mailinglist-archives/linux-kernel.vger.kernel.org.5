Return-Path: <linux-kernel+bounces-157682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0318B1489
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E751C21CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6953714264F;
	Wed, 24 Apr 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="My8x/aVq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A6142E9D;
	Wed, 24 Apr 2024 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990315; cv=fail; b=UyCKGrhxdrQWy1TBo4Eham2s+S9PQn9sCJdpp4GUgJbRJn0ksa+htaMC9iW2GabfHqoKc78BKgpRLfYb2nh7Qq9NodLipMASJdX+xQdjC//xJFc5a/PXqJbn/JrpezQwDJ4cpmQc+/jo9Ce5Mcg3V+NeLYncJQAbM7cTv56+EZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990315; c=relaxed/simple;
	bh=ii/SXIDayelkU2/cIGJxgnq45wlzYmRFLgkO7//DUxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rnCB7NCbu0YJbgcjY5HODFcLmYDu2ZMqXTDsfxHwfai+Th9eRH2K+GrOz569YTmdqrcVjGVMT5wkXrZdFaUSDz2OY8/xj5H7Ao46ftrQrELc24XQaixtM0Wj1pGI4MeVlqc0X0mmeXtrVxLfMGQ/7RUM9B0I5K/Z7kXc80iPxwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=My8x/aVq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713990314; x=1745526314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ii/SXIDayelkU2/cIGJxgnq45wlzYmRFLgkO7//DUxI=;
  b=My8x/aVqhh3fqozNMNDFJleOUeSZkLGq1/PN6nZFJISoZktqsaXr6D8f
   jfTzRH+8Kqk52bd7t1NCG2Og359XT2xGHP2xPBvcIsFviiq2nmmmGIADR
   CVsBzqWd1zfizxC/m19UVEoEHe/mMCjdwq8393SqjcQpHQZ8nrO0dhLmo
   /SbMonvFloCUg9EdREffqUJ9gOCd3L136Lhj+s29RfZxp9x88dw1sIUWL
   vBjKdxWhfClhOaOWjMlSlxbFW7B6jgzSX/5DZhRPzXB/1OP16TZ+HAe6D
   NegzoChY3JDEkihqFS4naJxLWfxSaXc2QUoNDApN4QdOc25y+qQHhYNQy
   A==;
X-CSE-ConnectionGUID: 5yMMGfndTIi4x52y4UohjA==
X-CSE-MsgGUID: 5kLx0yKBSI2e9HyowMfVwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="10181087"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="10181087"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:25:13 -0700
X-CSE-ConnectionGUID: jUB5Eus+SFOfARF97SXmSw==
X-CSE-MsgGUID: aJJ0LnAZS8q6fZJgbFaIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29463168"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 13:25:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 13:25:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 13:25:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 13:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lrd9VY7TqnCL1M4A8gHIn2/Ht6e++0Z2/Ey2zpBjbNWv2amv3R736Sjum+NnKQG3dghpJVoOqP5x4j0cmurNnvnTaYHXqeFM0Nfcqp26azAmw425yFu2UYwVDQF0Z60vpkYCXAnJjP66Nsorxgl2zBIYZ7ZTr2wGq/NpbyiFOtJ3tgxYLwea9ovFgZAJnYucnWSICK73eIRPMw4wudwnhP82i5l5jbVfDwJPR87fJWUhGVRnAf232Ea77GUePx+aC5/+7cqddEyphmaaQKpPShC5CV2H67MdGDS2lE3JwGdX30liehY0wDjBC8cqxQTvm3fqa7tGXfv3f1GkzSEYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii/SXIDayelkU2/cIGJxgnq45wlzYmRFLgkO7//DUxI=;
 b=TAf77QgW59HbqzbAHkGCVvk8S1tjXG19rVr/qxcX9idtq38JINAgTyb0mCtOENmYlkkMFqy/8z/8h4kXyECneAqD+78H7Eo/4v9L7lfmdvd/J+lICPadDx70PLhhsRL3g7aycfq/xIuu3ZfrHM2bG4WlU4bNdwHXaWLXhgWFI7XSNvNW8Sle9Ev26PHRgby9Lu6f22FYdtbiF1+FNTZGp0XdcyLFFHyQNDDbctNL9iArNj1qnU19n2GuXHCDoAdbDz5HkiMQa30bADCrKx2nLjOFS3JaXOlBjtBs9Ox+A+q0YB8QJjisNMZcVvdrnTGz6CWBMmC0xcTne2AJNcuqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.26; Wed, 24 Apr 2024 20:25:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Wed, 24 Apr 2024
 20:25:10 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@alien8.de>, "Jean
 Delvare" <jdelvare@suse.com>
CC: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Thread-Topic: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Thread-Index: AQHalnNrrHLVRKMzlk+IiUw2AK/C/rF310iAgAAA15A=
Date: Wed, 24 Apr 2024 20:25:10 +0000
Message-ID: <SJ1PR11MB6083E8AFB8E001855DE4162EFC102@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181534.42216-1-tony.luck@intel.com>
 <8b138aec-9565-4847-8c7c-8a1fe6972a04@roeck-us.net>
In-Reply-To: <8b138aec-9565-4847-8c7c-8a1fe6972a04@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7957:EE_
x-ms-office365-filtering-correlation-id: 24c32ab5-ebe0-46dc-2b02-08dc649ca38c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?eVZEdEFyMklMYzhjeURMdER3eXNrSmpqTzVKZDgxRG04clNROUJvUXBqUGpG?=
 =?utf-8?B?bGJOcjhDbm1OT0RmWDU2Y0F5SFlBZExNZlJqSmtkS1MxTDNjbmUwYUgzZGEv?=
 =?utf-8?B?TTkyNy9UWSt6MTBpUGU1c1cxWFk2SWtEdWR0Sm4vTUNmUnlqbGtTNm5XZHds?=
 =?utf-8?B?eVliclZZTkNmWTMvNzZnOEFIYTV0V1FNb1IzQ3lXUTVxSnJtMGFGNVZwQ2xH?=
 =?utf-8?B?UVlPUGsrbm5rZE8wSWl2eUh0czFPL0p1cGQvQ1FnT3ZIbSttVFlKNlJ5Z2NZ?=
 =?utf-8?B?cUFTbnNyTk5TRHpRbFQzdi85eVc0OWVSTU5xVFM4R0FacEI0NEFnczR2WTJK?=
 =?utf-8?B?NnJ5alZuYW10SWhzajRYb2FCYU1XT0p2Q0hYVFhGblIwTGw1eVBKS1JleFA3?=
 =?utf-8?B?VDlLQW5XTzZnNmwyRis4VkdzQ0NWYmo0Y2pWSmx0UStya0ZmZndBRmVMaXVI?=
 =?utf-8?B?TDlLQ21YaXkyMDBmcnlsV0lCeEcvMzlXdGI1dnlIcHAzREdrZG1TYVljQnQ2?=
 =?utf-8?B?NHRGU2RCZ29DdDMrNnBqRGFaYXExVWJZUnZ1clpmNG1iZjVwbEdjZmhYUmhx?=
 =?utf-8?B?SS9vYkl4Y1VNTUFkekJWWEQyRmowZTZrRkFBTExrMGZOUHlWT1lYd3Y4M056?=
 =?utf-8?B?M3p1eWRjc2hmZzVoQXp0Skxvc2hvZWlsbkVVTjNkYktnQmIydWZyamFIUmpK?=
 =?utf-8?B?anh5NU5pcGNkUVFqK2pkaGYraldQc1h5SDN0NlVlOFlaSURzcjl6akVsTU50?=
 =?utf-8?B?Nno3a0k1TkE2WFlsTUo4N3U3MnNMMkQ3MGRabzUrZGozbTZ1ZjU2WkFqS2xy?=
 =?utf-8?B?RjZya202dWJFN1BEVEtpa1RRL2wrT3lCWXZJVmtpc0xFdVlieVhHMlBKbE03?=
 =?utf-8?B?QnFzU1lOZFlQS29BTVo2T0I1MzBwMXNFRUcrcU5JTkJVWU1kWGVPZWhMRS9o?=
 =?utf-8?B?elB1aHFtK2NnWXFINHZUeHgyV0kvZjN4WGVoWENpNGxUZGttS2RXeVZRRlFk?=
 =?utf-8?B?Y0RKTnA5ZUdtb1RIS29aSGhDaUovNEc1SnJ6bS9zNnNSOTBKU3drY0RYbWtX?=
 =?utf-8?B?bjBBc2RSbWI3cEZjZjRXTmdUaEFFYlBtSnNYNmpzSXBtRkZHOC9NdEZ1NFNW?=
 =?utf-8?B?ZTkzWEpiTWo1U2RYK1o3K3pMYnI4UDZXdUFHb1RnK0tDQ3FuR1NULzZYT0c4?=
 =?utf-8?B?cnVSbmwzb2hzOEZqVHl0ejgvVERnOC95b0x3VFdpT2dRdXRtUHUxS2dpYmFF?=
 =?utf-8?B?cW9CVytzTVh0UVdIc0YvMWlKeGFXY1RtdHBPZGhYU0dxQkpqMnQ0eEJxVWVh?=
 =?utf-8?B?ME9GU0hKNFhQSDhmT0Q3UUN6SXFuQnRPUEhDT2VIZ2hJSXdnelE5VnNqZ0N1?=
 =?utf-8?B?NWw3MjZKRmRUb2lTL0NkZ3dzQmhMNk96bXd1NC9wbjRJTG5HUDJuODNpOUlE?=
 =?utf-8?B?TDRJVTFEcmVTWXhtWm9VaExFUFdFM3VFNzNxV3FoeXJod1ZWdEozWWhoMjk0?=
 =?utf-8?B?cmFqQnBqaHBYYzgvdTNJY2lqR1VpVlJmQjhaaDdFcHhmbE5WT09RNkZpQ3Z0?=
 =?utf-8?B?Y1BxRXFNQ1JyOHphb0hXbXNBUGhjNEVZTVUrUFRWTkI1SURyNWlralJqQW9R?=
 =?utf-8?B?c2o3UzZkQk9rVFhtbENyZExjem5DWDNxL1NlajZGU3pzVm9ESDQ1ekZObVgv?=
 =?utf-8?B?VzJWR1h0N0oxYTkzKy9Xa3ljcmMrODFoUC9nclFwRUpXZGtmdDFYZ3JUMUJI?=
 =?utf-8?B?M01DQVhHR1dYdlc1OVZCb3V5L0NMUVFtYWdTOGh5dkdTOS9BbEwrR2dDOXMy?=
 =?utf-8?B?Y0hnS0JyRXlVUTYwV3dCQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhqOUV6dVo1bUcxejhjRE05c1kxSkZ3empRWkVzeEtTYzczN3NBcS9oejI0?=
 =?utf-8?B?Q1hnV2lsTG1kSjVwQlRWdUhlVldGWE4vS0djZkZteDVjaUFXV1d0Z0dkNTNI?=
 =?utf-8?B?aWNHbXpEc3hUUWFwVnRmNmFvOTI1TGs4UFdGWnk2ZC9yMEpTN3FFb2N3cnIy?=
 =?utf-8?B?R2RZWXpuZmpuVnUrODAzTjJZSE1HRGlhRUUzT0RCRDVIUXk1aWJ1OEJad3pE?=
 =?utf-8?B?anBTT2VSYXdRbGFTSTdXRHp6MTVtZ0xUeUh2eTd6UUtvMjA3cUhNaWtjVHF4?=
 =?utf-8?B?YnYrS3dpYXh0Ny9MZEw3a3BKUDMzQ1Mxd1VkTCs1UVFDWFNxVzBNbjl4WFRO?=
 =?utf-8?B?TUR5OEY3STR3UzNLdlpuZ1VyWE1mdG1pcXEzc2NCbGxFVlRWREpHb08vcklE?=
 =?utf-8?B?SFBvTEtMMk1LMHlRZ2hlUWxRNEhFL0J6UjdnWWNmVWUwU1YyN2dmbHo0VDYv?=
 =?utf-8?B?SGxOa1hLZVYxcjBkQXd5STdMOE9Vbmp0UWt5TUo2SFdPazE3ZlJVL0lVZmRD?=
 =?utf-8?B?cEgwYzh0V1lUL3V2RnA2Q3I1cEwyK29OQ0NNNGZtMS9RZlBKTzVkUHlEdDgx?=
 =?utf-8?B?WStzNmhDR1BrbEx1NEFjT0tWTjA0aGhTWEwyaU9ia1RGRk10emVudXhINXNJ?=
 =?utf-8?B?NTV6UFZsRjVzTjFpbHQwQkEwNTFWckNWUHYwNTd2a2NoU1pGdjJ3V3BHazMx?=
 =?utf-8?B?a20veldiRDhoMWJlMGlqcEZpZ2FzeERBRlBpN2dLTE1sdnNLN3NuNXpJUVVK?=
 =?utf-8?B?emt2TGU1Z2MwTC9KaVl4TkdrNmFSRmkxNDdBMXRjaHRuV0lhQktlQkg3c2Ji?=
 =?utf-8?B?bVhTa21uRzJ1VHJ3ZW9JTVRpclZncndtSjJoTUtwMjB6RjJWaWhWb2ZPY2JE?=
 =?utf-8?B?RklGYTY2VFZVR3Bxck5lOXUyQXNaZDFBcGo0aUdlRnpWK250NWd4M3VUNUdt?=
 =?utf-8?B?S2NHdGxmdmhSK05SMUNjWFhkVG5nYWpCMXlMMnlUeXVaMWQ2OCtoRWRpYitx?=
 =?utf-8?B?TmxSWDdpQ2tJeUk4ZkM5RnFZSDlXdU8xeWlUQktTd0RnY3ZiR3crSThxeldC?=
 =?utf-8?B?ZU5RU04vQnJ5TFIxV242VG9iQXE1eEFWY1Y5WjRkRDVUTUxYc3laM2ErTVdE?=
 =?utf-8?B?NDVoNTdseWtjNmZRMU5yc1BOSmFwMkcyQ3pIeXZ5MlBuWjhVOEdIVVk5L0xJ?=
 =?utf-8?B?VzZwU0FWVWhEM04rVlB6TkE4R1ZXZllWTEdlWEsraWkzTE51NmovMWJyNXY3?=
 =?utf-8?B?Qkd4cUFlcUVkSVhuYnNqT2hONDJkQXFJcUtCQWxOckxJL09wWVFrdUxOTVpI?=
 =?utf-8?B?Y01UbjF6dm1xZENiYWVBeWptMTVPakRBUytZM3lFaUQ1c1lmZS9sWjl5OXI1?=
 =?utf-8?B?UXFXKzJpK1JxUTB0WE5VN1d5TlZJRDVrZ3Q5V3pDVEVaTFZ0OGUrSlFWVS85?=
 =?utf-8?B?UTdXOFVObnBFSG1BMmI2TW0zRG9QT0dDR2N0dHlXL0JyUDNsK1BGanFLdUhr?=
 =?utf-8?B?eGhJZkNQOGdnQkErL0cyYnk0ZzZ1ZlhKbVhQaWNGcWhNc3lQdW03VmtPOEcz?=
 =?utf-8?B?bjNNWllIQzNSQTJMSkNiNUVNbjVtOW5iWDZ4UkYrVW40NmEvQ2RyN3R2M0d1?=
 =?utf-8?B?dEduRVpEZG1JT1FWOEs5R1VVM1dtT2FJeVpDYTJlWDN2SEM3a0tQN2Jrektz?=
 =?utf-8?B?Vk5EREh5VzlkOWlET1JxSFN4TVJ5QWFDeWtXbWRqUCtNdy8zSnpkdW9zNDRs?=
 =?utf-8?B?TUdSN0lkMHJXVWFiTWFoUm11MVFMNDJFVFlpUzJRSXplUTEvTm1QUTQrWmtE?=
 =?utf-8?B?cEV1Vm5PN2pOQ1BiR3JscUR5b1JwMVByQnhkdGVKaEFhUGZ1eGZpeUg5VHY5?=
 =?utf-8?B?STBOSTZMNEpGUDI4MHNRbUNLSkxPbnVaMURIQVh6RkQ5akRlcG1Qb3EyQTY0?=
 =?utf-8?B?MUR6b1VGMjNOcm42Y05tMjNXbWVLTXZ0VFBUOFdER0Z4WktLV2V5VnpmcTlw?=
 =?utf-8?B?MDNFcFlZTnVhWWNGbXJ4N2gvMW1mcVJ5SXZpcmYwdmtKWWE1RldJU2JyMFJy?=
 =?utf-8?B?UmVEYllrZ3REZitadHlzY1BpWXJQZUpUU2UwajNJTnlLTldFY3RwOHVyU1Zw?=
 =?utf-8?Q?+BhX/ZgjCfnLNqYJ7INTgKDa0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c32ab5-ebe0-46dc-2b02-08dc649ca38c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 20:25:10.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWTuHvnQ9iujX33Ywhb7tvL0dgaP7y7aPLhmPPZH4lnO5iUaaJeBbAoyh0Z8NDIvPa0UUqSucwI967MnREOFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com

Pj4gTmV3IENQVSAjZGVmaW5lcyBlbmNvZGUgdmVuZG9yIGFuZCBmYW1pbHkgYXMgd2VsbCBhcyBt
b2RlbC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwu
Y29tPg0KPg0KPiBBY2tlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0K
DQpUaGFua3MuDQoNCj4+ICAgCS8qIEdldCB0aGUgUkVTT0xWRURfQ09SRVMgcmVnaXN0ZXIgdmFs
dWUgKi8NCj4+ICAgCXN3aXRjaCAocGVjaV9kZXYtPmluZm8ubW9kZWwpIHsNCi4uLi4NCj4+ICsJ
Y2FzZSBWRk1fTU9ERUwoSU5URUxfSUNFTEFLRV9YKToNCg0KSG1tbS4gSSBtYXkgaGF2ZSBkYXNo
ZWQgdG9vIHF1aWNrbHkgdG8gYSBzaW1wbGUgc29sdXRpb24gaGVyZS4NCkxvb2tpbmcgYXQgPGxp
bnV4L3BlY2kuaD4gSSBzZWU6DQoNCnN0cnVjdCBwZWNpX2RldmljZSB7DQogICAgICAgIHN0cnVj
dCBkZXZpY2UgZGV2Ow0KICAgICAgICBzdHJ1Y3Qgew0KICAgICAgICAgICAgICAgIHUxNiBmYW1p
bHk7DQogICAgICAgICAgICAgICAgdTggbW9kZWw7DQogICAgICAgICAgICAgICAgdTggcGVjaV9y
ZXZpc2lvbjsNCiAgICAgICAgICAgICAgICB1OCBzb2NrZXRfaWQ7DQogICAgICAgIH0gaW5mbzsN
CiAgICAgICAgdTggYWRkcjsNCiAgICAgICAgYm9vbCBkZWxldGVkOw0KfTsNCg0KU28gdGhlIGZh
bWlseSBpcyBhdmFpbGFibGUgYXMgd2VsbCBhcyB0aGUgbW9kZWwuDQoNClRoaXMgd2lsbCBuZWVk
IHRvIGJlIHJldmlzaXRlZCB3aGVuIEkgc3RhcnQgYWRkaW5nIHNvbWUgbm9uLWZhbWlseS02IENQ
VXMNCmFzICJtb2RlbCIgd29uJ3QgYmUgYSB1bmlxdWUgaWRlbnRpZmllciAoaXQgYWxyZWFkeSBp
c24ndCwgYnV0IHRoZXJlIGFyZW4ndCBhbnkNCm1lYW5pbmdmdWwgY29sbGlzaW9ucyByaWdodCBu
b3cpLg0KDQpJcyBkcml2ZXJzL3BlY2kvZGV2aWNlLmM6IHBlY2lfZ2V0X2NwdV9pZCgpIHNwZWNp
ZmljIHRvIEludGVsIENQVXM/IEl0IHNlZW1zDQp0byByZXRyaWV2ZSBhIHZhbHVlIGluIHRoZSBm
b3JtYXQgb2YgQ1BVSUQoRUFYPTEpLkVBWCB0aGF0IHdvdWxkIGFwcGx5IHRvDQpib3RoIEludGVs
IGFuZCBBTUQuIFlldCBJIGRvbid0IHNlZSBhbnkgY2hlY2tpbmcgb2YgdmVuZG9yIGlkIGJlZm9y
ZSBsb29raW5nDQphdCB0aGUgbW9kZWwgaWQuDQoNCi1Ub255DQo=

