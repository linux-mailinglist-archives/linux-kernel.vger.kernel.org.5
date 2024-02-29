Return-Path: <linux-kernel+bounces-87712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8886D812
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E915A284668
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E413E7C4;
	Thu, 29 Feb 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgF+frGZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10047A158;
	Thu, 29 Feb 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251005; cv=fail; b=m3Lx7iR0tp/LtVCDVfGIpSTZBBhjKxg+izkVnsb7GG2LtQ2V/uDouMR/z73wanvln9L94dxCKKM/FVAiBzjHTO9L4NEiHZBRTSNSL3+GyAixPcU7DaQTFQNKPDy6wly81zc70Bt667iPZmiNbi9MJyri3NIsupCc2jV3iffz6xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251005; c=relaxed/simple;
	bh=LVLv4AFiRQURzVYhVMKeRdsrvBfvJdsd3jtYZEwFHjU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t8xKYDbB0ynnaN9/+pq3B7rQEIdvZuPvUC0s2FVG89iH6vb/9tJbMqyhEbrYi04qH0EwnNsaSzPp0x87t4rN5DH66ePYscpqsQnCyS/As5Q3T37czXECoT9ZTot/m+g77bDP0bdJeIMOrvF8HTtsIlWsZT3I/VWEBybXTyVYeBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgF+frGZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709251003; x=1740787003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LVLv4AFiRQURzVYhVMKeRdsrvBfvJdsd3jtYZEwFHjU=;
  b=bgF+frGZ+SWUajQ5lmwrPmhn9ENgU/bTwii025iwubFQl3hgl0ooJzh1
   IHjCqecXEnfybBIp1mkeD+46kd8MSe77keLIbchw1eSyHO36Wcg2Gm2II
   MuRA7gjXUyFXfreTb3KwZPLFr1wbf4QTW05ZVyQtises/dLPQPGtudNqr
   LOCmJ3eVjwl1ygtk0ScmRZr3jjXmPhYhz6jYT2cHt7wnB4TcEAlvVufJo
   lBk6LMGC5n17G+RfyxsAM3BfTF7CwlQoWbXJ//NVA2qHORDhBLPJ5n5+i
   5+iidaT+j7P3JHJfARC0yDsHllNDG7wmmYei/Hy/uXXf/wYePvDTfsbx2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3929274"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3929274"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12670516"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 15:56:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 15:56:41 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 15:56:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 15:56:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 15:56:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm//wVyprcjzh1rJfy/LtRsWH5KD2OJgazZkAzOzzd3wBgSTi0ba2MfAvgTvKEu/uZNG5R80j4KXs8eVq+oFGQrJ8BJMa8x6977KhDEf99I6FFgQZw7EgYJWDGidY+ywAwsHdkjS+0DDYnvh26fbjs9MF61NBxMx+t+5ZOVJ5GWrA/kzHTYUnaS0Fk4WnCuYqRZM/FVGDfv3XF31ldUQfwbggF1HwuwbGXWXYCbLIjZ6M+joFurEkslsWNIKbAOCZ1ncmKgu67K2J4u72BroZw4jmbr13YC99deQ6vi4HQ1Fyer9vcOBpCUuaXN58qYQSR6qZpOr4ncteOjWUEKBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRcBvRL7V83nxGecUDrtuyBiRAZd0DkBbuFStU7yGgg=;
 b=Lb7NeA5Zv+4boEGSPhQIdnIzq6mGZf1Rc6jn0Mok57DydcJDlP1CwZkqphjpjqiw7LRFS1Wca4oZH21l7CZ7N0DLh8R17c1+oIzEVisJcpIPSuLEthsDXLTOu0IiAajnPLLDckl4O4QEjgTUcSQCxM1EBOBXvsKuYMQoKR2GVMABv9jYKx2knrsFfYyJcPiu37MSwRpqUAVqMwWutG4iM6D2Dnwi0nqT5L6BP0JP0HX49fAUsTy1XJTmd5oUiJgcLmvcQ8JmH7RZiB3tjZw1YWrxXfsClIV1DweMb7cJOjkaGfVz5/uzoRxsudOEM+Gi2AKqKOS/k+4WoaGTwa+vIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 23:56:38 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb%3]) with mapi id 15.20.7339.023; Thu, 29 Feb 2024
 23:56:38 +0000
Message-ID: <3be03f9e-53cc-4b40-9933-5bf59db84477@intel.com>
Date: Thu, 29 Feb 2024 15:56:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
To: Tony Luck <tony.luck@intel.com>
CC: Borislav Petkov <bp@alien8.de>, "Naik, Avadhut" <avadnaik@amd.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>
 <ZeC8_jzdFnkpPVPf@agluck-desk3>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ZeC8_jzdFnkpPVPf@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8e4753-b803-442e-f6d1-08dc3982118a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dI7PVwRCI26crj23IOC8N8QFC7IGYJo5wHxm4L4a8RjU3HwKdAl94QqpwMNz3ICkY5O5x8XOpa9dM1PYJ61mkOnVzD+lpqLRPSScEIPrNJs4qtsVevcWZh2uYZxjMiFjXU7K406uNMEcKrQWJxBFQnVrrg4JWM3EkvYPQ3ZdETYqrcDF/STfRVBoEAIjx4EVx7nAdBOkMN/BVfNoVznd/ndJEZMZHVyAZHhO4LXJAKMtsHRuKH8ZdFDh9tUiIJwSc+cdtscoxulsbu6lzD9xF1VcqmwZhxM0+Ox0zRUbh+jouRwsieklP69sFNsO4id2eXxamSsQfuucnkc1D2aQoDhKX+ITOdb/wLFAlvttk3nJfVKCLu0Oq+ogYvdl6oYxh16dW8i5tJUuc2/5yS1WqTtorsFA3zA0lgOcHBy+PvdiTqwblXto/EbjqtPASO0jQ+EnniaiNEjCucwuWl18OWK1Ff6vXyB0VWym++rQa8A82VH2gaPTYrApOA8hKAKH6y1e9o0SJX1ENVAFEsP6Jn7JtyHtIM2BRrt5pq0LiU2wh/Re0Bqzgtzkth1bIlO8iY5uUY7MLaPNsH1puvX+Ul4V4XAGi0LNK70ZWbSwFzxL8bk3p92it+4rNncu0xYVj8KZRLccID5lGtEAbmqEEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJRS011N2M1SmNXUlYyVmR6SW9TTzZCTHdiN0tyYVEvRTFRMUF6bG9QczFV?=
 =?utf-8?B?Nmh5TEpRZVVpa2l4SUZoRUJ6YUxlS3VvOHNTbEZ5WndEUDk2TVlPRXJ5cTlo?=
 =?utf-8?B?RDFQcmJpSVFlOVRPUWhKb0VyU0xHZlhXZzlNSmQ4d2RJZmMzeVpiSGRGQmJD?=
 =?utf-8?B?YWJ6L1B4NVhUd2RwVFZRdVpRTzJBRVU2SzJ0aTdnOGI5eGxPalVtUnpHYlZS?=
 =?utf-8?B?c2VyOWluTDk2MXdGblI1UmNOV09qbEM2bEdUcGhPUmN6MmFLYU9mRW1jMklQ?=
 =?utf-8?B?YTVZalJ1a0ZZNk5GZWZxTEZQbThMcDAyWjRhTFRnSDlqWFlFdkZmakY4eDVh?=
 =?utf-8?B?bXgvYXE5V3BjYTcvT3BlclJtbVVIa3ZMaEVKei94SGtXbWthWWk2RkZpRnJP?=
 =?utf-8?B?eFhDcXB5c2tiMktRNjkwb1I4M1RHdW02WlR2Qk1xcFJUTm10V1VBV3hPK1NT?=
 =?utf-8?B?M0VvMHVzMytNRloyY1BxMXQrbG80Kzlnak1YVkM1WU4yZGxEQVl5WEFNSWl5?=
 =?utf-8?B?ejh2eVZGc2ZXN01QbUZrblUwQ3lhSFRDWTBqTklqR3lOZ0E0K080UjE4RFZp?=
 =?utf-8?B?azF6TTAydVhwclVxMFloL0ltSHM4dUpSS2NuQ0hnajE0L0JFZjVkYTc2QVJo?=
 =?utf-8?B?ZEdlU240TXd5WCtXOG9hc1RKRktZa05nd2tYcEFhNmZjL25UTTBmN1Y2N2Nh?=
 =?utf-8?B?N1krR21hbG1wZzg0TzhqOXZFNlE3cW85cTNXK3d3T1dJSHpNM29GbVBjdFRM?=
 =?utf-8?B?V3psUXNFNUJIQWk1bnZvMVBTcWpIZFAwd04vRVQwTWptOHphRWl5T3o4b0Y5?=
 =?utf-8?B?UEZiZnZjVXJxSmNkVklwbXFKUUtrdDNDRXlnVHVuR0V5bTBKbEhzTkx2UFlF?=
 =?utf-8?B?VHMwbFVyVGV1b05nMnZjYXlaL1h1TDYza29POXdvamlDMVRUdnNLRlFXZjgy?=
 =?utf-8?B?V3VSU084dHA1NVlQQW4rSzhWeFI5b2VtbEFYSlpBcFo5YmJ3RHl1S1hwUkNS?=
 =?utf-8?B?MGxwVFRRT0dXT1FXcTg1M29NbVRPYzcrZXNid0ovTDV0aFljSDdlVURpazRh?=
 =?utf-8?B?QStYWHNTT1AybUVnK0xmOEw5WDBwQVVXNWdZYmNCSGc1VVN0Ly80ZmJteUQ5?=
 =?utf-8?B?aDdGV3BTNFUwc21ocFdpWTRYaGxrWStFNldjVXhwR0ZyOE9OYWlzMTJQV2lW?=
 =?utf-8?B?R1dKUy9ycGYxVm02NkxJV0g3Ny9XYjlvc1FjdTlUZUQ3YVR5RDlMRDBKbWhi?=
 =?utf-8?B?Q0xITnlZR29TL09sd09vOWVSUHVXWFhuOEVxemhveVpMSDRMWncxVXRkR1FL?=
 =?utf-8?B?Nnc2Uzg0b0IyT1FXZlhjaGNOUUFUUS9pZFBUS09yWFYwdk5nNzMvcTF5ZVAx?=
 =?utf-8?B?c0FBQWtQZzB3T1p4WXFEME1NQTl2Qjk1RER5Q3U2SGtORW1uSzNxSTZUc2JG?=
 =?utf-8?B?dEM4dkYwYTVWUXJXd2NwTEEwUTBHSmtEaDU5bjAvM2ZlMmx3aXQzT1pkWUFP?=
 =?utf-8?B?dkRKQ1lGcEhSN2I1c2Q1cGUwYis3QTNIWHdBLy8vVkN4S1d4aXpjaW9idmpH?=
 =?utf-8?B?Vk1WaSswa245R1lwTDNVRjVRTjRyYnlwOVJYWWFuNkRUR251NnNjdG9vVGs4?=
 =?utf-8?B?SmRIZFk0bzRnMkVKZkt6R2JPTXRDOTYrc1Urdit3aTF4eTJtQXkyaHU2cjVx?=
 =?utf-8?B?Ymg3MWluZjNpMkQvU0cwSkZvdDVXRnJzaHMxVm5QMUtGUlhHRnEwMTNFZ3NV?=
 =?utf-8?B?d2hOMjQzMlZHRjlkdjJhbStzbVJYSkJCUG5yVmRPRXZkWkZmU3ZFQXVJUjN2?=
 =?utf-8?B?cTR3S3ZqTWpBZkZIREpUNGc2TmpIQ1NSMDRoS0Nhb3RsLzZVbkI2dnBPZ1ZG?=
 =?utf-8?B?TUkzZVJ6ZVErbDZqQlVYS2kycnhMMWZWbmM2QzV6cmNLN21CdVo2c3dtUUNJ?=
 =?utf-8?B?aTA4QWR1Ti9RSTIzZTlVcHU2Q1NSa283bzdmS01lUWlIZXNCY2VYYStxZ05B?=
 =?utf-8?B?Z3ZmNnYxMDMvcUNvN0tTRE94d1lrbzlCckVEeWpPOWUvaW96VFRVekwzd3FZ?=
 =?utf-8?B?SG03SEorcmFmK0RMMWg1dXVaNGhWYVJ1ajlMLzVMMVUzclVFU1dHcHV4V01U?=
 =?utf-8?Q?pzdng1SAKNNAzkNz6cq60iMtt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8e4753-b803-442e-f6d1-08dc3982118a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 23:56:38.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERQgPVEelLTM8kI2X9J65rgUihT3kU7UQ54lb/KS+pybITwj/ReZwoez7U/mhOItSDnlM/jts4HBW0l++puIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com

On 2/29/2024 9:21 AM, Tony Luck wrote:

> Looking at this specific case, sizeof(struct mce_evt_llist) is 136. So
> the original version of this code picks order 7 to allocate in 128 byte
> units. But this means that every allocation of a mce_evt_llist will take
> two 128-byte blocks.
> 
> Net result is that the comment at the top of arch/x86/kernel/cpu/mce/genpool.c
> that two pages are enough for ~80 records was wrong when written. At
> that point struct mce_evt_llist was below 128, so order was 6, and each
> allocation took two blocks. So two pages = 8192 bytes divided by (2 * 64)
> results in 64 possible allocations.
> 

Thanks for the explanation. The part that got me is that I somehow
expected ilog2() to round-up and not round-down.

> But over time Intel and AMD added to the structure. So the current math
> comes out at just 32 allocations before the pool is out of space.
> 
> Yazen provided the right answer for this. Change to use order_base_2()
> 

Yes, I agree. order_base_2() is better than doing ilog2(struct size) +
1. In the rare scenario of the size exactly being a power of 2 we don't
need to add the +1.




