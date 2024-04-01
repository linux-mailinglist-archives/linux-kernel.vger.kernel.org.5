Return-Path: <linux-kernel+bounces-126545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D889394A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E5C28152C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F410788;
	Mon,  1 Apr 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAmGaNF2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EA1113
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962837; cv=fail; b=RrNKO74Hexl+kKhdYCZgt63TwlcKwMrhoLnH53wv1OX8EcAj7wp2WapZk00QViRYaftftxarCy3WRILEgX1/SsELB+1EZMwefJLgDjaSBkBJxMPLAdKpa8Q61j/+o8mKojLxloGqfuRRvkDeUnERq5olGjskaNbOI1T6rIH/YWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962837; c=relaxed/simple;
	bh=roWOD1eYvvo5TTz8WSMEieVrgGjlYokN3hD2R7jHqCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iPd5nF/LFBgDxp1nYC1zBF0n4jUM6kS/6JI7gscB5xagB15gkV682b5jRlWgjUaWyUo3SmeLQd1YTbk0MgZTCQyM0X0ILhLdOU/VLYskfLpWEpJ9lUNRw8SQFgFEsS3G+aH6hX8EQIqi55CR4ulu6N3B3W97KCmPilYhTrlQTjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAmGaNF2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711962835; x=1743498835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=roWOD1eYvvo5TTz8WSMEieVrgGjlYokN3hD2R7jHqCM=;
  b=aAmGaNF2UwnxCkll3zPuvIIexkZH79HS8JoBLPogua02rH5uBxzqQnww
   QaXQV3DiSSLsuuqooBwn6dfMD68AMVrK9xd4sVvohNEEvlmpnHLjqw9Ou
   WAZ90MW2DVpDR7xJcnpT+z2TpZf/qbslcDs6L+vCuiU+bZAwdyyYi3DqK
   kBB7RWEBPYhMvs2najNfD6MRfaxaU4WdwKdGByeCYoHoE9L9mtwPtOAE0
   sssge/Vf1x1kEyZZLMgPQeLmJtQlp0VwfxkkmqpDISsh1+j7cKgj/q2by
   qHv5y5WhOE8txsBSzbMkFfjGFrij61sFg8pGopRckjWIt6rC4LcRqmxj3
   Q==;
X-CSE-ConnectionGUID: W7Ibb5WKTyCKs+M+hilB0A==
X-CSE-MsgGUID: 8dP7UQQaSjSKViPdNcpYaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6945323"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6945323"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 02:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="17742106"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 02:13:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 02:13:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 02:13:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 02:13:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 02:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X69i6LniycgO1W6lRi7Y3Y281ur7lNHf0DKZGXi5Idi5w8oYXCFMcBZGdQwp9VLwjwHJt5Z/5TljLD4qf36o6pL11hZu7dANPaE2MYinF0Vd4Vw6wX4HCRgk6tODtSMBA8nvuxElTY/cenGU93I5PsCDY4ZV1hLGFkNEcWDcqTFC2DG/M2A93Rx4I4gm4VDWxyFMAh3YW+ZlxZvm1XglFoWh94VtxBOcUGhVCS/Sgq6HTHrf6i2B+hCy/rXzZnpOBugJImT9kQnRXdseHHbvkYsKfThJIB7XMlHCMmkupHN7dPYYRBMM0z83LhhneW7ieKKnFdRXfSd8M/WrHUPXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roWOD1eYvvo5TTz8WSMEieVrgGjlYokN3hD2R7jHqCM=;
 b=MSre27mKWdbIspssIOZOaBNZ9KhfBhLFSck+7EUlUrAQ7PUdGpGR7VuL3nQCeSscUwhgskwq4WXDqkSjem5tnmVDeeFK/9rS0DLfdCG7K7JBTXKkpj5zsogKeW5HOeIxqKlrnGI+W2Wfk5UpqGNJRWs4Yo3rAwRhLiKvnt6YRoBXIjH3nOqrhJDdDKDNbhB8KXBMnpCkWYyzwlfJwGIsAd+5/bV5psxSgL7vb/rAqE9zHPoaPFDyXBDkdjYAOMtnW5JH8Do6G1nhHoEh/9vQT++FyPToAn1yzxh/beDHE8XMgFZ0KdxVKlQqj2AFlHgCi5q4t0VyHDnV4tv+KiFKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.20; Mon, 1 Apr
 2024 09:13:50 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 09:13:50 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "luto@kernel.org" <luto@kernel.org>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "Gao, Chao"
	<chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Thread-Topic: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Thread-Index: AQHaeZ4rWTyxlb7R8E2AD6na+zVPXrE+6c6AgAA5LgCAAHBpAIABFFuAgAB07wCAACfDgIABbmeAgADkvQCAAEXPAIAEmWEAgATq1oCABdT1gA==
Date: Mon, 1 Apr 2024 09:13:50 +0000
Message-ID: <554c27ac68dfc1190f8f932db6a43e622283a978.camel@intel.com>
References: <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
	 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
	 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
	 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
	 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
	 <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
	 <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>
	 <glorzobyf42wylp57izgiukbe33c6ez5mgiwxepgn6pt2h4lr3@aqdas5q75mcb>
	 <9679cc44-fb90-d1ca-7c9a-10d0f6f5d3c2@amd.com>
	 <144a6a5bb6f78966611b42a526e587c3daf4fd9f.camel@intel.com>
	 <unsk2vaqeyh4a3zckf3vd3vxuv7rgtjq7dzv2kfdqrjjy6tvkl@rg5p46djnhmy>
In-Reply-To: <unsk2vaqeyh4a3zckf3vd3vxuv7rgtjq7dzv2kfdqrjjy6tvkl@rg5p46djnhmy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5328:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pE87/wesXPnd+wG1KsRnbF7A3XGuwtssM+Jtp7zSOGhv9LArPXG7oTDl6boX3yBuWmoG0lSQtZQFhHvaro1BK0MZYk12x4E4J0urpm/wvOpdUs7fuRfeDYLlnkObxdMe9/dtrck0/hUyic6Br1hp838PhTfMvgpqih3ABQ9gG3AjEWSaZ+B/jwyWGzhJoypDVCY1g7INtoV0hd+JnERmhyLXyfnAEf3pg7SsvS6De7HKo4fTPbWHbPhDc0mfx2/sxjY4kaedpmjkLZZPBs4yta+xbrSGYftH8rrhyM2HLDO3Itkrugr0H6TuR5qyG28+USAVSI9Emuj9tiFyKnnU8DnmoLk8+/MYPxlLlmixzrLC/PLzkDc+Xz6cKbEZZhJ0rE+tsrKWLZRQSbjmrywyD5q5SMKDe+/hW6F2+bO+Gsb5cjgkkLdUuNm9MM46p2R4qbl/7zGMd8whKKbyojrvTtDfNdO57KMoJF0mBoLBBBa/UDHdYxL4UbK7dg0dynSNEGhxezO46he+h5nBZR0zPgfO0rWBEvTIApe9V5wnA54wjR1xKYC5W7zvIXPl0SzoxAgkrc7JyGwHuanbgHnlhSVZ//X+DMditk1p+ciAkdeBS5C/t7S2H4VjFvs2uFsx6YTZqxfU784IvRRf7n8fKaPlQ9ZNdPRx/3LR8+bwnYg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckk5QStDVGE5N0JSQTg4TndGQ1JhbThsWE1PeUdGZkxmNDNhdEZzYTFqSlZs?=
 =?utf-8?B?cXFMMFZaNkttN3FVU0FuWHdCb0xnTU81QkJaeWtsUlBzUDV6UEszQXV4WXhq?=
 =?utf-8?B?RG9CSE9TcTBZS1pDUXQwcnNUQWlGYm0zQ0o0UThqU3pEYUFpb2hzV0t2cWVI?=
 =?utf-8?B?UXp0MENUZHdudnNheXNVdDZuUDFRcVpSUnZGa2ptdzh5Z2hYaU9tb3BDcmMw?=
 =?utf-8?B?cWlDQm1lMEkycExhVk1xeGNiUmhOaHZhck95K3oyd2RLOFpLQU5Zd1BibFJE?=
 =?utf-8?B?YXRuYnBqVTdhV1pjeC83aVc4R1VhTk9QZVFWRTVSVjVLWS9vMktkZmdubkx1?=
 =?utf-8?B?Tk5oNDNoTFdoeUY0UEVySU5sL1hUWGpxa0pHN292UFBFL0ZWOFFsSlFVaFdY?=
 =?utf-8?B?V2xMN2hBNjUrOXlqcUdZSU56UmlYVEtXMWdKMVhDWmYzdnNhUFAzNnJRQTND?=
 =?utf-8?B?YVBWWW5QS2ZjeU5rUnI5S29lVHBqRlNsK1lCcHVCajNuSTk3UnJIaFcvb1BX?=
 =?utf-8?B?UE5tbkdvQTRjOW8wSnE1aldxR08wV0ZHVFljVkk1bkFqZnFEajRJQWFJdmhX?=
 =?utf-8?B?d1N0anc0MXc2SUdxY3JUL2hNdi9rSzB4Q0hMalJ6MFRWa2RyZDdueWFzNHJn?=
 =?utf-8?B?ald3dVNMSjhVWFU2bGMrTTdYOWUxRzM4a2xZd2pEVDZvYmJyaXltRENTdE41?=
 =?utf-8?B?NGVISDZVeTlPcTk3ZXo3ck1OS1czeGlsNmxzVVRBUzYxaTlVVXB6MmJVSGVS?=
 =?utf-8?B?ZVh3dUdXVWV4QmhyczlVdFR0QlBTNjlmWnYwaG9CZndWZmhjU29CS01KY25n?=
 =?utf-8?B?WHFaa3hGdndCVUErbDJBTVVOSDBQNDFhdXJ4RG43Vmd0dmNDZm9iWWJBMmp0?=
 =?utf-8?B?TkRFT216bk41LzdpQjJXLzVzMXh0TlgrbzJidFBpdmFmUEhEbEZtWHhLbFB2?=
 =?utf-8?B?RlRQMXVhQXVMUFJOSjQvME5Jbm9CNnVoRWo0OFBIT3hDTHMrTVJPNmtiN29T?=
 =?utf-8?B?NXVTRkpGMmpwd3NBa2orRmZUVmVPbXBXdmtRWmtqU2dhbGgrWjZtWU16aHo2?=
 =?utf-8?B?THFmWno4dFFVVGtOOGRCU283V3lwUWxaWlhrUFZKaFQrcnhhYkJFc2lPYzRx?=
 =?utf-8?B?WjFoTDJMVDR6OTJnNG1LWkxYTTJERGtPWEhaUDU4eGlkaTBCMzNnL0VOVXZl?=
 =?utf-8?B?MEd2cFAxYVg5M1ZRRWNkbnYzSDlXQTU0ZVVWeEtUeXNiUEZpa0VKZU9PelQ0?=
 =?utf-8?B?emFuSVI3RWJSTXdJeVFHLzNydHlOTnZvcVlDT2dsK1d5SzVTbVgzbG04emp2?=
 =?utf-8?B?UjV3ckl1OWtGSkFTczIrNmFCcGQ5VFRhby9TQUc3cm5VWWlRT3NKVTNEWkZQ?=
 =?utf-8?B?bzgrOEhkaktNcmUrdE1VVk9YcjJBOWtxK0VzeGFpaCtQMGd1YW9vczJETnRq?=
 =?utf-8?B?dHlZTEVqYVNhRTRkRkpBcUF0OTUwVllNUUJJSHpjdC9vWDQybElwSTRwZlVU?=
 =?utf-8?B?MnVDZ2lJSjJVSVJtT3FKa0VqZ2w4U01kVzIyZUdFRmdDbTZlZUprL3owYVE0?=
 =?utf-8?B?cktrbnlIa0NQay9scWZkbkpJZjBTdU5BMllFUS9QTjM0QXFDWThWeUdFWGhZ?=
 =?utf-8?B?c0RqR2MvRC81REcwTjU0MmZqSEhqMHNEejNPY2twMTFEN0d4Wk5vWmptMjR3?=
 =?utf-8?B?WExGVCtIenJQZlZIQ1JuSURrejMrL3F3anJPdXN0WC9ZUDRnV1Y3TDNmalZm?=
 =?utf-8?B?N0NyVTg1Mm9wYzFxT2ZDNU84REZGcGV1TnYwb0VZL0orQjNNclN0WUZ0N1U3?=
 =?utf-8?B?THFneWZkQmJmQlBhYkZ4bDZvL1BYVHpYZGtZWVBBZjVwQ29YS2xFZUFhRzA4?=
 =?utf-8?B?dnpsZDhnSHRDeU15SHplVTNGZkhDZ3RnaW95RlFzSE1qV3ZPbHlSVUxibWlo?=
 =?utf-8?B?SXhXYm5nSkM3dzU3QXFoc2VuSGZEYnZJaXhtRGovSThjZFRvV0JLU3duQTg0?=
 =?utf-8?B?MEJENXVmTFlTaFFrRCsrMnhHYUxMMUo1dTJsS1ZxU0ZENGxjeC9ocG91MEVp?=
 =?utf-8?B?dEJseEt2QUVIRGtZbUFPMkUySmxONURPRlBpK2QvbFJvYzRsVEdEcVo0ZFJK?=
 =?utf-8?B?SDA3Q1FzNTZzdFkyeWMraTlvbTlvQzdUUnNsTllYeWtGdG1xelUzeXYvcStG?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <202AEC1AB10D2343B9809E1574C687AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823a7b23-b431-441f-a92e-08dc522c0b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 09:13:50.6073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: analzslqOaoes5tKQtVskL1QK1wW+1PSuBjq1o4xjo44m1ToOQ0NVwi4SDI4pJIhzN6GSjidfkrmGJooykXa9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

PiA+ID4gPiA+ID4gDQo+IA0KPiA+IA0KPiA+IEFueXdheSwgdGhlIGN1cnJlbnQgVERYIGd1ZXN0
IGRvZXNuJ3QgaGFuZGxlICNWRSBkdWUgdG8gV0JJTlZELCBzbyBJIHRoaW5rIGZvcg0KPiA+IHNp
bXBsaWNpdHkgd2UganVzdCBkb24ndCBkbyBXQklOVkQgaW4gc3RvcF90aGlzX2NwdSgpIGFuZCBy
ZWxvY2F0ZV9rZXJuZWwoKSBmb3INCj4gPiBib3RoIFREWCBhbmQgU05QL1NFVi1FUyBndWVzdHMu
DQo+ID4gDQo+ID4gQXMgbWVudGlvbmVkIGluIG15IGVhcmxpZXIgcmVwbHksIHdlIGNhbiBhY2hp
ZXZlIHRoaXMgYnkgc2tpcHBpbmcgV0JJTlZEIHdoZW4NCj4gPiB0aGUgQ0NfQVRUUl9HVUVTVF9N
RU1fRU5DUllQVCBpcyB0cnVlOg0KPiA+IA0KPiA+IAlpZiAoIWNjX3BsYXRmb3JtX2hhcyhDQ19B
VFRSX0dVRVNUX01FTV9FTkNSWVBUKSkNCj4gPiAJCW5hdGl2ZV93YmludmQoKTsgwqANCj4gPiAN
Cj4gPiAoVGhpcyBza2lwcyBXQklOVkQgZm9yIHBsYWluIFNFViBndWVzdCB0b28sIGJ1dCB0aGlz
IGV4YWN0bHkgaXMgdGhlIGN1cnJlbnQNCj4gPiBiZWhhdmlvdXIgb2YgdGhlIHVwc3RyZWFtIGNv
ZGUsIHNvIEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtLikNCj4gPiANCj4gPiBBbHRlcm5hdGl2ZWx5
LCB3ZSBjYW4gaGF2ZSBhIGRlZGljYXRlZCBDUFUgZmVhdHVyZSBmbGFnIHN1Y2ggYXMNCj4gPiBY
ODZfRkVBVFVSRV9OT19XQklOVkQsDQo+ID4gDQo+ID4gCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9G
RUFUVVJFX05PX1dCSU5WRCkpDQo+ID4gCQluYXRpdmVfd2JpbnZkKCk7DQo+ID4gDQo+ID4gT3Is
IHdlIGNhbiBqdXN0IGNoYW5nZSB0byBvdXIgbWluZHNldCB0byAiZG8gdW5jb25kaXRpb25hbCBX
QklOVkQsIGJ1dCBub3QgaW4NCj4gPiB2aXJ0dWFsaXplZCBlbnZpcm9ubWVudCI6DQo+ID4gDQo+
ID4gCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpKQ0KPiA+IAkJbmF0
aXZlX3diaW52ZCgpOw0KPiANCj4gQUNQSV9GTFVTSF9DUFVfQ0FDSEUoKSB1c2VzIGNwdV9mZWF0
dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikNCj4gY2hlY2suDQo+IA0KPiANCg0K
VGhhbmtzIGZvciBwb2ludGluZyBvdXQgdGhpcy4gIFllYWggSSB0aGluayBza2lwcGluZyBXQklO
VkQgaW4gdmlydHVhbGl6ZWQNCmVudmlyb25tZW50IG1ha2VzIHNlbnNlLiAgV2lsbCB1c2UgdGhp
cyB3YXkuDQoNCg0K

