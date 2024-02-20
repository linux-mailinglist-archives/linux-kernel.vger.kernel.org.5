Return-Path: <linux-kernel+bounces-73652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710285C57F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1681C21F80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D428D14A4C0;
	Tue, 20 Feb 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGTZ8kBU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5B76030
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459644; cv=fail; b=Ptx/Hf8WcU8Ayj0HcVFb+Z43gif4UqjkujQcF9XwEeCTJkA1o7NTEtPZjdUHSoyDI9AS28HyxvgZ3vC7lnEyfnkgwQmzSblQ9oOIqvKrD/1gxkaYOdE2Y1EnbA2AV1bCAvhx09Pja76jDBfvJU3OTv4sb4Nwpz3S9vXkTklOab4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459644; c=relaxed/simple;
	bh=uMuhIGAngL2iscc7h3BsH6vNFil5qsDuYdgEHXQLtgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iau1kFLFCDfukw/yFtY0TLf2qgNj6Sw+NHEFWBX0BHaLR0fkR++nLbuM7xDEdAxdS0XJEeTSP8dTfcLNVkdv2c6fPGY2OFIq6eCHHWxCFPLKulau/EzsNT1+uHnaVkI57631hMw8YzK9mHwIAGdtHIbhgEbM62bH9G1qxgu/OtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGTZ8kBU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708459643; x=1739995643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uMuhIGAngL2iscc7h3BsH6vNFil5qsDuYdgEHXQLtgk=;
  b=CGTZ8kBUxg19S5u+k5xgqt7qgVYy0cCzs7c6PiRmnizg9gi55VXeU684
   8JobUOSL2RiPlP5DXtjxyfYeXIcYLpaQG2USs/dwaBvw2Y/CeiLmyMGXc
   AxejIo5K3crkIHTQ2pf184DR7nCYr3ZJHLNPK4q4eCdWmlTHx94//rH/K
   d3jPahDYSs11EXGTPg0RqpmBHxF1/lb9TkNhZlU9oEIt6vMVMh80Ewhfm
   uQ3EBG3IBXpa85gxv2tLfZfdj8WCj/ZO31eFZg4YhALp9cMvqXpIHQotA
   xQtjQZPXv+VFAwk7afC0uIlaepduOyasiLHJIDUGUwliWB11SdxduoAdu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2450904"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2450904"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4774145"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:07:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:07:11 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:07:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:07:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:07:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nybNRppjDYq2BWpT4sSyzuxEsHoK3d9EAa5kQTvpOJzd9BTPMvYdy2jiGvnunJXZT4fcyFTskFJ0ki4ia3aRlLd+4SdUwgkgkUiXLr8aGUpevA953jpniFz/DbqjJKJ2nhYLkN6PJkY1mvgtRKyhXcO4sN6Te+t4NjwSj3M36G+nRBei2suKBNiOYQmmV+3I8wIVjflHellp3N4DriQ8uDrq+YytP0NyfDQbZM1h+NIb+zZIi6HN/G3ISFKg4iPJVf+AIBM4yBsPKkIUsSyiujJNAg9GN3NbtDgRtvYIXOjipY2BO4udPmLZ6mS7ZcXNOy8sLDo3fNoyjKfc5clMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMuhIGAngL2iscc7h3BsH6vNFil5qsDuYdgEHXQLtgk=;
 b=CeWpU6pHEMd1guG1ve+AZp8oQA0PB/vhZBZVKCT6FCcVWNf9mLURXmRgfB3sEyfeOeKWX6Kz7YoQ7ARzsQBbo7MQtgiGaa5CqjnwTAMGRCt6ShE3F5QtljPG017U5GTCep8Vms5Edal4MbsfVIncnEfgzKjwt2jz2/P20KpzxeGq1oL64qOUDmFjzS+gWAQVZUBw/+eSjMMoMPV1da2i/BFrX0VhV8OAhshSvAx22Nz0lb8eacPiPIW7TZCtksUlFlqxQCBjsf9Ycnevc8IKR3DgxNAty7zKhi7h6Kgd/r7/VOb58N4Z++bQvW0QeRQDOI2NbzZeyP8nqX7MmMxx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 20:07:08 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 20:07:08 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Thread-Topic: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Thread-Index: AQHaVDdfcLjlgK8/xEqQPfvtDlVukLER9XiAgAA6hICAAA0QAIAAGziAgAERXgCAAAWBAIAAWS2A
Date: Tue, 20 Feb 2024 20:07:08 +0000
Message-ID: <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
	 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
	 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
	 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
	 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
	 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
	 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
	 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
In-Reply-To: <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB8097:EE_
x-ms-office365-filtering-correlation-id: 95f3c029-9be6-40e6-5e3d-08dc324f8486
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9NPrjl8SoE4hNXrTLLNS+D9y7PI3BEio6k00lby5yW8cKT7eu9bx644sgfNFJOIrYoCWgis9VYudpKrZE12IPYImSHZao7Ai9svsaPHNRzrXmI0K4ffIB1IMISO+Bmo3dChFIYQQRkmmvgDM1fVk8BIkIgrum+JdfCF2Ih9KomO1NNMLL9MFO/wSWKXd4PMfetNp0oYeIyA3VQZjxuxfEWAfTg9vQoBuzf885/XhDmnz+UHfIBkWYSiJ4DXl6Scr3DwN/qktqLiw+cbpYKMbOvm8/BVBJVWkwB5CvkSSJ59cbcU3/ZjNl4evmkdSDTfAIIuQNKEkxLsve2e/lDgi2+GvQbDp+vxjW2+a10+87gR70nveWP99gPohEPJc7AXkbqpee52Tz3qqO22sCjFvY6atZvp5UlusoGsQiUqZUKsRUk6guQXcn3fyI0zdUReTsoiwvu3eyZZfYmk+hrL2/pLsZXC55nJYHf4djAsCt8RVOvbuFZ3ItGg/oDh9RHeEf912N/V6+ROjM7qPw9ewMWZzTl8pteUlgdBNR+fEusOj12R/K7Xiy35TvEPw3+IjoGKHzZCr5lMqKaVLY2vKuJV646+G16YslbgQHPRUdWmb7R3q1ndtZ4f3AL53Jh2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDVNS041UWJmUThKWEp1cnl2ODhRVjdJZ0xLZTJ2bHR5VzhwU3VVY1hOUlh4?=
 =?utf-8?B?SVR3L1VTdmtVWCtYekhKZFJuUFdWY0RrWWhrVERYSWtUQ0FqUjd6SnkrNlds?=
 =?utf-8?B?TzA2QXBsQ0V3aHcrNFhubVdLWndkdmx6Q25ZNG9QNitxNlJpbHg0bXd1Um95?=
 =?utf-8?B?RzBNTHZkYmZvSWNSNWdSa2NCa0MwWUx4WThJWnR3SExvcnB5aFZIVG5ZMHls?=
 =?utf-8?B?V1dzeXpWakJDbEEveGlzYmdlNFFPa1N6NHl5eXB5K013dXFCa3lKRGo0T20z?=
 =?utf-8?B?cHFVNmlObzJjbXpPc1RHS2NTVmJOekE3N002ZmZ3RDVoV09aSGE4a3NvNktj?=
 =?utf-8?B?dVVSRll0a1o4RFdRY2NBWXV1L2E1blV6TThHZzgyTXB6aDcyZEF4UithaFNs?=
 =?utf-8?B?NjZ3cTB5ZEUxaVFWZUliejdWbkhvOGZETGcvRGNJMFRKTXc0eWV4M3lnYUY2?=
 =?utf-8?B?UEZWVkV4WTFpL1N6anIyVk9hb0ZKdCtsMDB3cEJzUXBrVGU0dnQxVzVHUGtw?=
 =?utf-8?B?dy9iWlVxSWNjMlJBZFE0b0JOUitQRnZTY0EzYWJEaC80eXIza3l6cXJueVd1?=
 =?utf-8?B?QnFLVWJ3UENxdnFyZjY3TURVMTVoeDNpY3lLNWdYQ0tZdjFhblJDQStBbkdJ?=
 =?utf-8?B?OFFVK3YwSE51SEJaMEFWUFV6VXg0aXhJTzdDSTJ5Um40Tm03ZGdkYWpZUmhx?=
 =?utf-8?B?SW9COHZ4WWVpL0twTmhCeWR4NnEwMG9XTTV6RkI4Mm1MUVJLaEpoWWpxWXlB?=
 =?utf-8?B?UWg5L2hLazNnT0pZaVYxNkdaWEJCbVRFOXVoNjdJNW5WT3FsU3ZBNm1IU3ZK?=
 =?utf-8?B?QjVSLy9yVkJzTkQ5a1Q4MnNxVHo5R2ZYSWR3aUNkdnhQdmFFZExHc2ZodW9L?=
 =?utf-8?B?TGptSlhZQjUrbkNXVTNMWW0vdHljK3FCMVRyTmdDR3gxZjRnMnhYR0RNc3Qy?=
 =?utf-8?B?ZHBZVEk1VXpSWnlreXNTUzg1dXhoMXAxcnpScFJoS3p4TWFQUVlFaEdtU3pu?=
 =?utf-8?B?eGVDYjYwVC90MGJMK0RvbDdsc0N0MkNDbUNWSWw4dDltRFFHUGNyc1VuY0gx?=
 =?utf-8?B?Vm16czYxZ3dWNGovRVV2Y1FPek5zVjhUUGVDYzFveU1KWlp3cU83ZHd4VnAz?=
 =?utf-8?B?VnRFOWxOYVRkblhjSUhDbnpFUlZQTllRYWZqVjZQVmx2Mk9HaFI3OEdacWkx?=
 =?utf-8?B?OGZBSDFsZ1J4T1l5RnNrTkFMRytjSGFkN2pvaktGdTJiRnNJRU5YZml4RXpJ?=
 =?utf-8?B?bjBhck5yWGFFT3JZREg4YXNuR25hNDBFbFcvYW84L0F5U0FwaGdja242YnM0?=
 =?utf-8?B?TzNPS283dllTTW1xeGZPRjRuazJaV3d4b2Z0WXB5ZDg3aElUL280UnR0QnQ4?=
 =?utf-8?B?ZERNV09XYm5YbUJCSjBaQ3V2UnlVd1RNRFM1YUFKVEFlMlZndVozbXdFa0dQ?=
 =?utf-8?B?RlAvK2dnMFNtczVwVzc2QkQzRjRabEJPcUNLZVVxYytlaG9XbzZGczF6ejBt?=
 =?utf-8?B?RVBWSEVKbnJGcE5UcGcvSEJVb1FDVENUL2VPNmMvc00rYlpFOXJkdWRFS1ZR?=
 =?utf-8?B?cnZzZmhZKzMyVTBYaHhoMU5zZlNxbVVGQ0Y0aE9zWnRGYS9rL0hCRERJanR6?=
 =?utf-8?B?YTMrNWxGZlNXbk5xUmthd1NwdTZnZGFOZmRiTDFNenhnUDFiaVBGWUtFMkli?=
 =?utf-8?B?ZytiWS9Kc3FKeHg2djlmdWxQNEx3TUkycG5NUFFCLzVnczU3Sy9ockNPNlpL?=
 =?utf-8?B?NFdJWEpJRkF3dVpieXBKOHBTT0UvOTBjVTJ1UWh4SnlTWStYTWhmMG5Sd3Bh?=
 =?utf-8?B?MG5UcDFVdytHRi9jKzNER1ZMQWxJSE1oUm54ZXRucEpWMXMzUWxTSFB6VjBD?=
 =?utf-8?B?NEVUbW9DSHVWMVBqWURySzk1bjZJT3NyYTdOUkNUNWkyWWhLTzRNcWNHLzFu?=
 =?utf-8?B?Wk9OY1JBZTB1c2pHbk9OTVV0Qk1UVytXOUtXUDBlWjVzMm1BQzlPZUFhNWxW?=
 =?utf-8?B?QWFJQzIySmM3ZTkvVWZna3UxRFhnd0F6TXlFNnRLQmxNOWY1MUVaczR3dVZq?=
 =?utf-8?B?YUNaUWdKSWFOcUF0M25EWm9nUmp5ZHJiK3hDOEc4aHZnZkVVK0xNdGlwSHJ0?=
 =?utf-8?B?UkRITktBVjJVYTlkU2lxeko2WG83OTJScndjRlhUWDNKR1VFUmlTWGIxOE1K?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46C5FDCEEEC1E747A87877BF34D4530A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f3c029-9be6-40e6-5e3d-08dc324f8486
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 20:07:08.6762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPf9r0iWqbjr7MYkqEn6BQl9l2afPm8yHjeb5klN4DneksWA8c3q5miw8D/mEJIcJHknx+xBK5P23LOD/GiDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDA4OjQ3IC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IE9uIDIvMjAvMjQgMDg6MjgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBPbiBNb24sIEZl
YiAxOSwgMjAyNCBhdCAwNDowOTo0N1BNIC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+ID4g
PiBUaGF0J3Mgd2h5IHRoZSAnIShzZXZfc3RhdHVzICYgTVNSX0FNRDY0X1NFVl9FTkFCTEVEKScg
d29ya3MgaGVyZS4NCj4gPiANCj4gPiBJIHdvdWxkJ3ZlIG5ldmVyIGZpZ3VyZWQgdGhhdCBvdXQg
anVzdCBmcm9tIHN0YXJpbmcgYXQgdGhlIHRlc3QuIDotXA0KPiA+IA0KPiA+ID4gQmFzaWNhbGx5
LCBpZiB5b3UgYXJlIGJhcmUtbWV0YWwsIGl0IHdpbGwgcmV0dXJuIHRydWUuIEFuZCBpdCB3aWxs
IG9ubHkNCj4gPiA+IHJldHVybiB0cnVlIGZvciBtYWNoaW5lcyB0aGF0IHN1cHBvcnQgU01FIGFu
ZCBoYXZlIHRoZQ0KPiA+ID4gTVNSX0FNRDY0X1NZU0NGR19NRU1fRU5DUllQVCBiaXQgc2V0IGlu
IFNZU19DRkcgTVNSIGJlY2F1c2Ugb2Ygd2hlcmUgdGhlDQo+ID4gPiAnY2NfdmVuZG9yID0gQ0Nf
VkVORE9SX0FNRCcgYXNzaWdubWVudCBpcy4gSG93ZXZlciwgaWYgeW91IG1vdmUgdGhlDQo+ID4g
PiAnY2NfdmVuZG9yID0gQ0NfVkVORE9SX0FNRCcgdG8gYmVmb3JlIHRoZSBpZiBzdGF0ZW1lbnQs
IHRoZW4geW91IHdpbGwgaGF2ZQ0KPiA+ID4gdGhlIFdCSU5WRCBjYWxsZWQgZm9yIGFueSBtYWNo
aW5lIHRoYXQgc3VwcG9ydHMgU01FLCBldmVuIGlmIFNNRSBpcyBub3QNCj4gPiA+IHBvc3NpYmxl
IGJlY2F1c2UgdGhlIHByb3BlciBiaXQgaW4gdGhlIFNZU19DRkcgTVNSIGhhc24ndCBiZWVuIHNl
dC4NCj4gPiA+IA0KPiA+ID4gSSBrbm93IHdoYXQgSSdtIHRyeWluZyB0byBzYXksIGxldCBtZSBr
bm93IGlmIGl0IGlzIG1ha2luZyBzZW5zZS4uLg0KPiA+IA0KPiA+IFlhaCwgdGhhbmtzIGZvciB0
YWtpbmcgdGhlIHRpbWUgdG8gZXhwbGFpbi4NCj4gPiANCj4gPiBIZXJlJ3MgYW4gZXZlbiBtb3Jl
IHJhZGljYWwgaWRlYToNCj4gPiANCj4gPiBXaHkgbm90IGRvIFdCSU5WRCAqdW5jb25kaXRpb25h
bGx5KiBvbiB0aGUgQ1BVIGRvd24gcGF0aD8NCj4gPiANCj4gPiAtIGl0IGlzIHRoZSBvcHBvc2l0
ZSBvZiBhIGZhc3QgcGF0aCwgaS5lLiwgbm8gb25lIGNhcmVzDQo+ID4gDQo+ID4gLSBpdCdsbCB0
YWtlIGNhcmUgb2YgZXZlcnkgcG9zc2libGUgY29uZmlndXJhdGlvbiB3aXRob3V0IHVnbHkgbG9n
aWMNCj4gPiANCj4gPiAtIGl0IHdvdWxkbid0IGh1cnQgdG8gaGF2ZSB0aGUgY2FjaGVzIG5pY2Ug
YW5kIGNvaGVyZW50IGJlZm9yZSBnb2luZw0KPiA+ICAgIGRvd24NCj4gPiANCj4gPiBIbW1tLg0K
PiANCj4gVGhhdCdzIHdoYXQgSSBpbml0aWFsbHkgZGlkLCBidXQgZXJyb3JzIHdlcmUgcmVwb3J0
ZWQsIHNlZSBjb21taXQ6DQo+ICAgIGYyM2Q3NGY2YzY2YyAoIng4Ni9tbTogUmV3b3JrIHdiaW52
ZCwgaGx0IG9wZXJhdGlvbiBpbiBzdG9wX3RoaXNfY3B1KCkiKQ0KDQpUaGlzIGNoYW5nZWxvZyBv
bmx5IG1lbnRpb25zICJTb21lIGlzc3VlcyIuICBEbyB5b3Uga25vdyBleGFjdGx5IHdoYXQga2lu
ZA0KaXNzdWVzIGRpZCB5b3Ugc2VlPyAgQXJlIHRoZXNlIGlzc3VlcyBvbmx5IGFwcGVhcmVkIG9u
IFNNRSBlbmFibGVkIHN5c3RlbSBvcg0Kb3RoZXIgbm9uLVNNRS1jYXBhYmxlIHN5c3RlbXMgdG9v
Pw0KDQpCZWNhdXNlIC4uLg0KDQo+IA0KPiBCdXQgdGhhdCBtYXkgYmUgYmVjYXVzZSBvZiB0aGUg
aXNzdWUgc29sdmVkIGJ5IGNvbW1pdDoNCj4gICAgMWY1ZTdlYjc4NjhlICgieDg2L3NtcDogTWFr
ZSBzdG9wX290aGVyX2NwdXMoKSBtb3JlIHJvYnVzdCIpDQoNCi4uLiB0aGUgaXNzdWUgcmVzb2x2
ZWQgaW4gdGhpcyBjb21taXQgc2VlbXMgdG8gYmUgaGFuZy4NCg0K

