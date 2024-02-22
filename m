Return-Path: <linux-kernel+bounces-76445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612DA85F770
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B8A286120
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A413346544;
	Thu, 22 Feb 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAorM4sN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA846435
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602611; cv=fail; b=NYQPVAsIkwM3+m5F8To1aoLCW6MNLqX7fRR1zpByS/umFNyX2LP691q+mAZRjaC0Go6gJCZeJUrnFd/lVPIKvNVadUSb6lMvHI+CabeD6bwdbW6IqOTdbpNbWEZ5PTTW2LdPSeJJER+QtoAeHuDuCEhzcYNFugd3IOtH5xBFB0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602611; c=relaxed/simple;
	bh=ScFQyqsrkEsulY06o+2GrqZV3EJKZKmLQdgY7BfwWqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IwPQYDoZUMD1RopRB1rZISrFEbnLjKYfYA2RZ6gDQX55+trZk7+/AxjWDSKQdBnQG0/Y4rDoC8r5mopbNy/ITlx7lcD19I1Z7+35vYfCywFV4/QLJwB0RA0LZ8mwTL4wdtkgx6eRmr92FBG1qc5cARQ2qm7WmFEngBFmIBXYgUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAorM4sN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708602602; x=1740138602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ScFQyqsrkEsulY06o+2GrqZV3EJKZKmLQdgY7BfwWqM=;
  b=VAorM4sNVTSQlR/UnhSZrd/YGcy96QdMcYj6w77bxhstjcEMXwl7B7So
   Low+ZYslGZmfA0wx7YhCKC6zE4es9yXGaXYnIzavHy2v4XqRdkabrLGcw
   WWQd1zuKwYtltdv9Do5lkVkWnHJH2AnycGpMvInV1/+yv/M0bw9/w+su/
   iQ7bcnYfMuTvpFDb3qvEVDTLOpMVPw+3+oNEa6S+d+BvwjMqOCm9h63/p
   FYWnWq4eMx9E9RO9XnqnoX2JgDXv+9XAE6xdCCV/SUdqdqeKHs3abcFlE
   thsaeEEVUamzfDH4OEi9knKv7LriO3k6Pe4NY4ROpWc2aUgjRhvCFIVrv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13443491"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13443491"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28635093"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 03:50:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 03:50:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 03:50:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 03:50:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 03:49:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF4nwk71eacc+J+Fr8fHVosewB6fcyg25slQW3zLYzS9Q415jzWJ/kc8rguNUJtw6dR+6YtWid2ZbuEu2uRxxPhL6CIGX4NwUTNMhCZRrqdupx2VotXoYGDXfxpeoeI2aOAtcaGwHNfluwtJTG4byTDfgEAHj+GsSFa7auUL9WfaA22+BOOhP6mMST8apz5nLamYrzR7eas8uCTGoA5c1GT3u+ZkQOfBhFGfy5vplXkU8Df1xWAjig9czVqrADth/mvDnJlmbrKNpH0DwIbRjn0GJ5N3A2mXwGFXkgwtihoc7rGi2E2Kmjh3SG55a33JMMc1KFcL6frQJEAw1qyCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScFQyqsrkEsulY06o+2GrqZV3EJKZKmLQdgY7BfwWqM=;
 b=WDISOwHSOIQHRgg19ZyusIaZFlA0OTS3rV4C/VNUcOJMZS1qOjdwjD3AvhINKJvSiQabh3txkLJQKb/vXYruLKolxc/uassAVhZT/CmfDZXdWwPoAKen9XkLndCOXorQBzSnIPkg+VYEP39AHhJecPoCtZWsLwCIQJ3Epc/2gCL1nirn9dNWZyTHbQwWnvwlULXkpf5EhEdA119uICPsXgaJHoeiv7kI2PyH3LPNlOxRmIqwfYRIFfw2aM2IxtibLQBcGp7zzLYugbj4DJMtZveNwjVWU7saRb+JVGAWAPojMbAhvpxN/BeKDktRYV8JMb5rBoGLkaRVGgcqs+HDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Thu, 22 Feb
 2024 11:49:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 11:49:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "bp@alien8.de" <bp@alien8.de>
CC: "Gao, Chao" <chao.gao@intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHaVDdfcLjlgK8/xEqQPfvtDlVukLER9XiAgAA6hICAAA0QAIAAGziAgAERXgCAAAWBAIAAWS2AgAAn/oCAALgLAIABubKA
Date: Thu, 22 Feb 2024 11:49:52 +0000
Message-ID: <f01b2ad1fe239444148bded21ae4df64e3f267f2.camel@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
	 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
	 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
	 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
	 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
	 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
	 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
	 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
	 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
	 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
	 <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
In-Reply-To: <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS7PR11MB7858:EE_
x-ms-office365-filtering-correlation-id: 995b496e-55e3-478c-b5b7-08dc339c61ce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NrbWpZSp+tsUOvU91Icg0lk0FHRn2Tcn8pDLYLiluR053qLndU2DvPb2vSKL1hgLPZBE+5DfVeafAl1FbI1EbK6/KFM4pnkcMwuV/TFvI44QZ9XeqybIX+2XqKEVMzYk1OM8jQiAKpHreckjrtHH+KLP77v+2kquQMdRSz8/EQCzAUVekargEVmQ4ChySrDM8hyL9++E3UoeTxqQXomsN/j7YTZ7RveKBrwW/ku6W3A8oXKMs3oKfChlWQTuT/RcK0yqUT6f7U6ZR4Xki0bUkaU0R5J1US7Wj+g4hIwoWKFgqX7Nxhflf2ibY0K+OWn+eLR5XFfC7RXBaitKjUR+dA6IPqtsrNW51zdL4TvDJ5CwPOLcZJ4fTLPsxn7b3Mo1nEXTrwtpcLQcvnZI1fkP61mbHv0UIT0IY7ltn9aLnehyLE7HygF6cxNoV9KLjPir/qpv00U5ETgBBIRIyY8VfNnWE0bQ35fWws7MPG4F8R5iAplIYF+X4uEffKdqKJmAfTLgF3yzPDPEiPS2G6hw3sgsF4qfZabadRKxkf16AcwqQqmNolzvjfYKsPb8dYF/QidbHn7b0JEu5miRzOf4jkFm5q9lHZUz7zkwMsKx6Ndwb7Sb1OaD7Og4hZZxN5OV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGNyZzVWNnN2WDFTL2NVUnY0SEYyRFkzeE52eDdUQUxrZ1UvUU1ZU2hrc2tj?=
 =?utf-8?B?RlM5QXJFQUMrKy90Yys0Tmo1TTJQdDZpZkVQUlRJWDdCTXFGUmRVSUYrZGVp?=
 =?utf-8?B?NmFYUTZNNThzUmtDbWhVcTlaaXU4eXFkNEhZWHNZQnBzdThVZkFUVVJDcmlC?=
 =?utf-8?B?ajJ2aGhPRS8zdS8xWnFxOHhUWmZZL01Qbjg2UXBSdVpJYW1SclZWUGU0emhL?=
 =?utf-8?B?bmZIV29KeGNlTVBjWnR5NTJQTXVzNUtlbTloOE95TlhSUldYZ1BnQjVoMWlx?=
 =?utf-8?B?aW9CbS9IMDMwVEdoeVRaY2wvTEVMOTBkeFNkUlNZUzlMeGtFQkMvdFJvMXpR?=
 =?utf-8?B?akpJN3VnQWlnaHowczZXbnhDMGdPZ3YyR1ltLzhnaHBTYTRJU3cvQmZmYTl5?=
 =?utf-8?B?NzdBZElRZUw2QUZOb3hDOFJpSW1CWWZQcEFabkZRRVMyVGdqZ054cW80a2sv?=
 =?utf-8?B?cXJXaHVsM2EwYkNZRjNRYVpRSXp5Z1U0MmloQ0l5TU9TMDJqeTBjcVpMMStp?=
 =?utf-8?B?eHRwYlhjMVBObko1Umdsa1UwQllNV3h6UHZtL3NkckRYZlVGVjM5c2hORE9P?=
 =?utf-8?B?bHdnbUJ2RW9tMC8zVVhBSXc3RmpJVkJaWlRqWmpjMDlvOS9keUlWaGhFalo2?=
 =?utf-8?B?NzY3UXpWYXpnVy9IS3RIdGZJUm96YWx3N2hXQVErMXpPbXcwSGxUZUFlTVFC?=
 =?utf-8?B?YVAxV0V6OE92ZlFCMEpPM2E1WW96Tm5CYXYvck5TRnJIa3J6NjF2eG5Xdkp0?=
 =?utf-8?B?cWgrVnBrcTV4VDNMRGFCdEZNWWhuU0laaVp5TUc0NGYzYkJ6aDRHWnE3MGRL?=
 =?utf-8?B?R05qK01PZTNsQWZ3SFFhRG0yZXJCS0dCc04zR3V5cnQrLzNpRmcrbDlvZ1Q4?=
 =?utf-8?B?cDYyL2J1NFFQWit5cndYYXpiZjVUUEJ2Y2pEcUxOOHVGMVJJczBHZmNvU2lH?=
 =?utf-8?B?WndTTjlKYWJzcldpR29LNUdkc3E0eVhQWW5VcHY0UmkxY1FwNkFiUThiZytJ?=
 =?utf-8?B?ZEdiUGhpS3NBZ0kzcGdTRkU3c0dlVG9nK2FZbDdUSzA1U1Y3TTBGMXNkWEs5?=
 =?utf-8?B?bk1LMlZ0ZVAzU1BnV00xTVZXYWpMRGpCRjkvZlNuVVg0QmNMMWl6MDdLNk15?=
 =?utf-8?B?dXpicFd5VjZ6UXkyWkNLYjd1TTdDT0piY1JnZ285L3EvUVhRVnh1dWEyNzFl?=
 =?utf-8?B?VXFRaXpSWmIrdUVKbHR0ZEVKNm5WWlczSWhRTVFBNHVkdS84ZjdodFNwd3p5?=
 =?utf-8?B?VktoeUJZd2hrdXBXOERKNDI1b1lxaENpbUtrd2RFSndyYmZ6eGVEY21Ea3JX?=
 =?utf-8?B?MmVzeTRoR2pmeitUb3lGaDRlRytWK1ZKTUFxRkE3ZENmcGZjUEt4alp4OEk3?=
 =?utf-8?B?NnFUckphdGZpOTdCU01jWnQ0MU9GMnhuY3JkYlFZeW9ldzRuZDhLQklyOWRI?=
 =?utf-8?B?NDJ3YktZM0lGWGd0b1R6UzZESHRtN3VoVVM2NnRUSCs2a3BJNjZEY1hQUVg0?=
 =?utf-8?B?Qm1ObFY0UWdxUlNYTXlNREZEekw3c3pJMjl3U0NMZnRTd0JiUWIzanphRlRS?=
 =?utf-8?B?NVdlS2VaNXlnd0l2cGdMbklqekdoeXVHNkMyQlN5UXFLWGZCdzcxT2owUFAw?=
 =?utf-8?B?WWtyTEczYi9ydGxGbTdrZUlmaWQrVlNuYlFicTF0YzB5SGlzOWR4K0lBaUJF?=
 =?utf-8?B?amViOWRGSmlhcjliOTRUYlhQbURsSXRLb0V3cGpyUit0VXczb000TmFKblRh?=
 =?utf-8?B?SjcwNHpDeGxtaWlGK0phZGlnTnRJeEJ0QzZpNFpzVHhsUkFSZzZxMTdRTE1U?=
 =?utf-8?B?Tkkwb2JpMVZDdnBEUE9heVc4SHhPT2VmdHNBQTVNR0NwVWxRUW9xSFZwQXlG?=
 =?utf-8?B?cjRtelU5RUtVYjBHQis0bUtSa1JvUCttRWlIWmFvMzBwTWNKT3lPUmhRencz?=
 =?utf-8?B?V0JrazVQRERkSDlHQXg1Rno5SWtCYXlNdERNMmhwRWhwekhCRGM5WlJKbmNj?=
 =?utf-8?B?dGtoWGVQQ3lnZlFlNUZUVnFyaVp1NWxjT0hJMzlFOHk4UDJQQ25kVGJGODdl?=
 =?utf-8?B?dVFHbk16YnYrQjFzYnVhaTJKYzI5ZnhQRzB3dG02TitDN1hTU0g2YUxrU3Y5?=
 =?utf-8?B?K01uVEV2R3ZIemNiTkZzRGhDZ2R6M3k1VmRzaVdSaG9oaGJQRVpOUStoMHdR?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11EDCC003747AD408041145D451991FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b496e-55e3-478c-b5b7-08dc339c61ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 11:49:52.8317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRxnCrQeLEvI4IqPkkd0TXneofOIE9Yh48krkOkSYiQFlB61YnFgzOCoimx3KDnUtYL/1SUWToRA2oY/ssZebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDEwOjI4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDA0OjMwOjEzUE0gLTA2MDAsIFRvbSBMZW5kYWNr
eSB3cm90ZToNCj4gPiBJIGJlbGlldmUgdGhlIGlzc3VlcyB3ZXJlIHRoYXQgZGlmZmVyZW50IElu
dGVsIHN5c3RlbXMgd291bGQgaGFuZyBvciByZXNldA0KPiA+IGFuZCBpdCB3YXMgYmlzZWN0ZWQg
dG8gdGhhdCBjb21taXQgdGhhdCBhZGRlZCB0aGUgV0JJTlZELiBJdCB3YXMgYSB3aGlsZQ0KPiA+
IGFnbywgYnV0IEkgcmVtZW1iZXIgdGhhdCB0aGV5IHdlcmUgc2ltaWxhciB0byB3aGF0IHRoZSAx
ZjVlN2ViNzg2OGUgY29tbWl0DQo+ID4gZW5kZWQgdXAgZml4aW5nLCB3aGljaCB3YXMgZGVidWdn
ZWQgYmVjYXVzZSBzb21ldGltZXMgdGhlIFdCSU5WRCB3YXMgc3RpbGwNCj4gPiBvY2Nhc2lvbmFs
bHkgaXNzdWVkIHJlc3VsdGluZyBpbiB0aGUgZm9sbG93aW5nIHBhdGNoDQo+ID4gDQo+ID4gICA5
YjA0MDQ1M2Q0NDQgKCJ4ODYvc21wOiBEb250IGFjY2VzcyBub24tZXhpc3RpbmcgQ1BVSUQgbGVh
ZiIpDQo+ID4gDQo+ID4gSXQganVzdCBtZWFucyB0aGF0IGlmIHdlIGdvIHRvIGFuIHVuY29uZGl0
aW9uYWwgV0JJTlZELCB0aGVuIHdlIG5lZWQgdG8gYmUNCj4gPiBjYXJlZnVsLg0KPiANCj4gTGV0
J3MgdHJ5IGl0Lg0KPiANCj4gRGF2ZSwgZG8geW91IHJlbWVtYmVyIHdoYXQgaXNzdWVzDQo+IA0K
PiAgIGYyM2Q3NGY2YzY2YyAoIng4Ni9tbTogUmV3b3JrIHdiaW52ZCwgaGx0IG9wZXJhdGlvbiBp
biBzdG9wX3RoaXNfY3B1KCkiKQ0KPiANCj4gZml4ZWQ/DQo+IA0KPiBJZiBzbywgY2FuIHlvdSB0
cnkgdGhlIGJlbG93IGRpZmYgb250b3Agb2YgbGF0ZXN0IHRpcC9tYXN0ZXIgdG8gc2VlIGlmDQo+
IHRob3NlIGlzc3VlcyB3b3VsZCByZWFwcGVhcj8NCj4gDQo+IFRoeC4NCj4gDQo+IC0tLQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL3g4Ni9rZXJu
ZWwvcHJvY2Vzcy5jDQo+IGluZGV4IGFiNDlhZGUzMWIwZC4uZWM0ZGNjOWY3MGNhIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9wcm9jZXNzLmMNCj4gQEAgLTgyNCw4ICs4MjQsNyBAQCB2b2lkIF9fbm9yZXR1cm4gc3RvcF90
aGlzX2NwdSh2b2lkICpkdW1teSkNCj4gIAkgKiBUZXN0IHRoZSBDUFVJRCBiaXQgZGlyZWN0bHkg
YmVjYXVzZSB0aGUgbWFjaGluZSBtaWdodCd2ZSBjbGVhcmVkDQo+ICAJICogWDg2X0ZFQVRVUkVf
U01FIGR1ZSB0byBjbWRsaW5lIG9wdGlvbnMuDQo+ICAJICovDQo+IC0JaWYgKGMtPmV4dGVuZGVk
X2NwdWlkX2xldmVsID49IDB4ODAwMDAwMWYgJiYgKGNwdWlkX2VheCgweDgwMDAwMDFmKSAmIEJJ
VCgwKSkpDQo+IC0JCW5hdGl2ZV93YmludmQoKTsNCj4gKwluYXRpdmVfd2JpbnZkKCk7DQo+ICAN
Cj4gIAkvKg0KPiAgCSAqIFRoaXMgYnJpbmdzIGEgY2FjaGUgbGluZSBiYWNrIGFuZCBkaXJ0aWVz
IGl0LCBidXQNCj4gDQoNCkkgcmVhbGx5IGFwcHJlY2lhdGUgaWYgRGF2ZSBjYW4gaGVscCBoZXJl
Lg0KDQpJIHdpbGwgYWxzbyByZWFjaCBvdXQgdG8gc2VlIHdoZXRoZXIgdGhlcmUncyBhbnlvbmUg
aW4gSW50ZWwgbWV0IHRoaXMgYmVmb3JlLg0K

