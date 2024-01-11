Return-Path: <linux-kernel+bounces-22938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F8682A5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411C71F240DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EE2807;
	Thu, 11 Jan 2024 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzEBqid/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA557E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704937936; x=1736473936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rz3jIqtACQfdkr1MQ1JmI2Yk69b7aBk7qoGXPFytllk=;
  b=JzEBqid/p73PXYXj0Xrz/0hy/Ihg2wOHDr/fitxuqat+yxhkWLnXk1ag
   U6cT6yIRFw4Ixy9xQFwbvKSGPOQOu7JqgiqHYla2KgzaBT4+JpPegtntj
   bHNKyNwUdJK6jov6vFLoUiDZDfn/cI0aiQTeo91dAte68Dx/W97e9DkmW
   ohLbCq+vxKuv841uEUASKcRSx3F0K0MySMT3bdL6mB5G6jUQJopzMS/Pq
   Huh1JNljdO1MiwlXXP0tlbZgtPoPY9AKM8Jv7zpbDAnOqZ9Bptp41Skt6
   5mnYBRo9/6A96kqt7G1XBJ1UsWLIDJblOIbYtKVzqbFR4BlIYhDowWb8u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12062136"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12062136"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 17:52:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="901373833"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="901373833"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 17:52:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 17:52:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 17:52:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 17:52:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 17:52:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgc7FvCr+L0v46egek2OlOiWxtdZFv0Uhgu6ciTE+Ll/4IKxkKPpN8Kkxj68hZuds0bjKj+VHMzzroXSbzIg5IUPqe8PUbmUl99r1jH/8cn7spyswnpZUARfys0RYpwXhKRGQvepEYWonyyLBu9FQVHrLju8kUb3DOixlju7RtXDGMTKOxQaV/lq9gZDxriyioGnJ2HtNXj2h7BeNoZTD8K6XNQXH3oGkTMg8uyrokvxfr5wtmZBcY27Hei+qSvZlCaMgXd7arSXmGUZI0T19oLm+9qDSvviGybCQ+pnSDGp4if1BdW3peCFc+NMwjbiUn9KVF9yS8V7g5srZ0TZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz3jIqtACQfdkr1MQ1JmI2Yk69b7aBk7qoGXPFytllk=;
 b=FZfbThlxRsxx1t4GJpRJQwjkcluNbuoZxwUxaK5EYakqeP/x36fzbbBhB5B9Ikjz1GYX4N1O1hK7A5WWPivvF1KiEDX1ci+Rf6x9H3uekrWX30BG8sLDYjWYcM5x0K0GDi8I3UlCVKk0x3WaaqiD+nMtLwW9geoKQC6OMG+O2yloau1lgH76yZ6s60bgBAi0pgUYKHXCYsenGR6uVoHqaoAzR6ry4ZGqMIMJhaJkoW2U1ktC04b+12TJZv+U8Io1p4Gidc0rIAjiRKe901JYsfuOLKZ2GwEjE0SV4GVYd3Nn7Z1LeQOEur6BIq45ZAATU/lmzHSgR3Nn9trf9B4ExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 01:52:03 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 01:52:03 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
	"arjan@linux.intel.com" <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "Tang, Feng" <feng.tang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
	<ray.huang@amd.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"Sivanich, Dimitri" <dimitri.sivanich@hpe.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"andy@infradead.org" <andy@infradead.org>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Topic: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Index: AQHaQjyCF3Nt+9p0tkSkWmDSuvApOLDQAJIAgAAWM4CAAKJBgIACYq8AgAAPKoCAALIxgA==
Date: Thu, 11 Jan 2024 01:52:03 +0000
Message-ID: <2ce8a48346de7561df12adeedf8060d7578b6146.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
	 <20230807135028.381851690@linutronix.de>
	 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
	 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
	 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
	 <87frz5jmnl.ffs@tglx> <87a5pdjk54.ffs@tglx>
In-Reply-To: <87a5pdjk54.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB6803:EE_
x-ms-office365-filtering-correlation-id: c6a49edc-a7ca-4153-6107-08dc1247e88e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGA/VrYMPWZwaAXpXoXP966bmUxTe8S6mPyR8CyZi0+KWAnSvj7g1+DXyVCYsBOC7CFZuC53l2ffKtrMUNBW8EmdSY7F2ykKI2GpuxmZGIr5CEad1Gh+gBK5PIoLu6stCeEPmaMHnypcgTn7WL5lcIyB9dY2l0ds5vRs+9EeRU84lI92+x+BoKbxnXKqSmTW/vHqgmeL6DcXz8l7bDu7CEuCXs30bV2y8YHRmlPDRGYjZOc+B1wCfLUQX7pl2kQVO6Ncx6jpg1WVI/GocalJEMe/sI+O5Ltuf4/OPpsaqbEe82LAVvACCFvswEzkAUPeqMrsS8jZ/IkWvSlNrjlDi7HuG4diWfsijsxKSFUJbobeVMXPO8NGaxxQupgE+WshzS7nj0zkTW5Nz1rDSOUWj4zIpNgVCKCZGfwmYM+q+aDDN/TXAK7bTbZVPKeMSkQrdt2bPRnf2YIOF+LPr92ppgPqK0xspb1kqiVwmoVTDUzWhD4VZvD33jIXnuTWTbcHNW0pF+Y2NZeXV1R3VnNzb+EHy5sQQ5RVHvHn9g6zfKYFrx7kDLjf8d+esZVaupTsWFoviDlXfnam+gPKstyx0IXjqg+SxZgZGpRC4OBHFyOCy1Ik65qpK/l3bZ3aFDYy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(6486002)(6506007)(76116006)(64756008)(6512007)(66446008)(66946007)(66556008)(91956017)(38070700009)(86362001)(478600001)(66476007)(122000001)(38100700002)(5660300002)(316002)(82960400001)(8936002)(83380400001)(2616005)(26005)(110136005)(7416002)(2906002)(4326008)(4744005)(71200400001)(41300700001)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVpNHpSNzN0NWN1Q2E5dUk2WEpNaG9vUjMydERDWWU0c0w4REFSVUdxaUNs?=
 =?utf-8?B?cDBHY040cDJ2bWNrUXpJZmFVZWVNejgyaGFGbldiNVhSbTdTbnFkSk52US9B?=
 =?utf-8?B?Z1NPOTRzbi81SWtDVU01Y01nRHpHT1pGUkQvMU5RbFFwbkQ2MmUzUExXbEdJ?=
 =?utf-8?B?K2txUCtEcVNEN09nWTNKdFloeW9DR2JDNmtjd3lnS29hS05zdEs5UTlGbkZK?=
 =?utf-8?B?enY1TTdNY2I2ZzIxV0pLMlJ4OGxRbFlKbkxHQW0rK1JtSGw3ZVdOeHZHSHlh?=
 =?utf-8?B?VTJiNTdSTE9jdWNiSStTS3RYSVk5MnNqMnN4VEtDTmNqaDg5MG16YjQ5TUdP?=
 =?utf-8?B?VnBWVHRYMjZ5OHJBN2lBays5a2JwaVlMUWU0ZnB0QjNOSlY1S251ZkMvenFG?=
 =?utf-8?B?TDR1cnpZNHZKa0tWZTU5RFRIeXVEMnBNSTZlOW9yNkVoUVpJWUZsYkdXbFlW?=
 =?utf-8?B?SFVlbW5ZeFRwVmZXOXVGWUh2UjJqUVZ0dFJvMnlmbHZmUTM2WE1teXZmMGR1?=
 =?utf-8?B?YnExR0dCLzRvZlVLK3JQK243NXF0bTkrTUsrcDZGY0pJNWx3S1dEZGhMQjZT?=
 =?utf-8?B?VEZMY1VGMjlKTDNvYUdnOExVOWplNTZJNmdKWmxvWnBLZlgzODBYRzZrbVR2?=
 =?utf-8?B?RjYxeUhBQWZSaUtMYUlyc3RxbTl5dUlnUzU2eE1NWGdzQlgyNzBtVDJkb1Q1?=
 =?utf-8?B?aVpIRyt3VDNQa1NHQ1htNDBXUUFVL3krQS9MOXpDRkJYaTVwT2ZTS2NHdzFl?=
 =?utf-8?B?eWJmOGJkaWNUREx1b3kwMmRDMUlhVmltOWZvaVBkTEttSlZXT0xYZzNyZS84?=
 =?utf-8?B?d24rTzZSWDFQR3ppWU53MVI1UUQvZDNnay8xSmgxVjY1b1cwZEhSdjVubkdV?=
 =?utf-8?B?eTUvQjI5UGtwTEFwbnFqdHdmNHhTNWpVbFc5QWlWZTdCbzRLeURKRGwwUUFw?=
 =?utf-8?B?d2IrQkpNVHo0OEY5b0lWTDRKY2ZiMEs4d0dZWnNHV0pHdkZDMEhHUkFqOXp6?=
 =?utf-8?B?MnU3R3lFOWd5VEFwL1JlcUZyUVhBNHZXVjFJWHdVRUoxeFBUK3ErZlF5V2dx?=
 =?utf-8?B?TWQvS2dwSFV5RjFYbk1yOXJJYjhsQXdPV1NlRXdtRVNSUk15dTN0M25NVkl3?=
 =?utf-8?B?UnlORUI2bGNyTit2blJjOFRhVXBoWGdQdU9qSnlYRldWdEJEN3RIUmRxVGd0?=
 =?utf-8?B?Vkx0bkhsM2crL1NHSDFZOGRpcXpYdVRRWldDT0xmRmFkZmZ1SERqSkMvOStH?=
 =?utf-8?B?bmw4eWU5OUwwZG51OGMxTDFDaktmbGFTUUxvcnhMckFhTERMdzNEM3BkOTI0?=
 =?utf-8?B?NU1VbVYxTXlHTEZCbFpmMG4wamtOQVJ6STNMRzBCbTZ1eHNzK2xrRVRNUmpY?=
 =?utf-8?B?NEx1WFBMSWdtd05RZjdUTGhWWWxWOTIzOHFpRUIyZTA2QnJUUFJrWmZNT2dj?=
 =?utf-8?B?aHJQbEw3Y2hZbXA1aVpyVFoyZjdRa0VOZXdiOXYzSjkxbnJDbmlZQXpmMDJ4?=
 =?utf-8?B?ZFAyTXJsTlF3V3krekJ2QzN5dFZ5YVhMQ2RSQXY2RCtqdU5hRFVvV1RpcjZq?=
 =?utf-8?B?bjlWbjV0NkhVVG5hQWhSOUU3YUw2dXk5MWQvczN6WE5XVTlpOFhzdUE2ZTdC?=
 =?utf-8?B?R3lqOFU0SjVDcHd1OUdnVWxSMlNXL005cHhhWFBTdHpyWk8yWFVqNU9JV1hE?=
 =?utf-8?B?V3Qrcko0eFNOeGYycmxWRXNQWFhpa0JjVlB5YUo3WWF4cC82Zjl3TDBWL2hn?=
 =?utf-8?B?VlJXM2UvL25kUFppd3llNVFRaHU0UGVNUG0xelR2aWd3cWhzV2pzc2N4d25n?=
 =?utf-8?B?dllXUFZHZit0OEZWRVY4U0d5UENoU3ZwcEJLUVZVZ096UTNhSVhBZGFKNmNi?=
 =?utf-8?B?cGFjSVZ6dGNkZTQrRjlCd1N0UVZUUFg1eURwcHhIZk9ONm5yNk1BS3hPSzNk?=
 =?utf-8?B?ZnpNYXlhTmFtSWNQUk5hQzUxWU8rVjJXY21XaUpBRm1oTHJQTnRtMVRLYm03?=
 =?utf-8?B?TjhlQUljbHpXU0s4SSsxeHd4cGkxVGJsSkRYSXp4Nlg4M3RGVlh2cjZYYkpH?=
 =?utf-8?B?VzJIZ0xmL21IWnFXM2ZFcEd4SVlEaTVOSG1hZ3UzMldCUzhrS0w3U2o4dWRS?=
 =?utf-8?B?TCs5UUZnUXpORlFoUUVuQWpVaEoyRjRwTitlRUh0Z1RCM0Zqek42WnJDZ3JJ?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F9EF172DAB0104A9D6D3880F91D71E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a49edc-a7ca-4153-6107-08dc1247e88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 01:52:03.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Au52gI09LEwTQmW6JraSWBfB6eZL1lRgn70w2l+lCShf1fx9/1lvOTtFBOcWJ+PYVJF6x/UtptrK8etzNNjoqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6803
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTEwIGF0IDE2OjE0ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFdlZCwgSmFuIDEwIDIwMjQgYXQgMTU6MTksIFRob21hcyBHbGVpeG5lciB3cm90ZToN
Cj4gPiA+IFRoaXMgaXMgdGhlIG9yZGVyIGluIE1BRFQsDQo+ID4gPiAkIGNhdCBhcGljLmRzbMKg
IHwgZ3JlcCB4MkFwaWMNCj4gPiA+IFswMzBoIDAwNDjCoMKgIDRdwqDCoMKgwqDCoMKgwqDCoMKg
IFByb2Nlc3NvciB4MkFwaWMgSUQgOiAwMDAwMDAxMA0KPiA+ID4gWzA0MGggMDA2NMKgwqAgNF3C
oMKgwqDCoMKgwqDCoMKgwqAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDExDQo+IC4uLg0K
PiA+ID4gYW5kIHRoaXMgaXMgdGhlIG9yZGVyIGluIExpbnV4IChmcm9tIENQVTAgdG8gQ1BVTikN
Cj4gPiA+IMKgwqDCoMKgwqAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHgyMCAo
MzIpDQo+ID4gPiDCoMKgwqDCoMKgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4
MTAgKDE2KQ0KPiA+IA0KPiA+IFdoYXQgYSBtZXNzLi4uDQo+IA0KPiBBbmQgY2xlYXJseSBub3Qg
YWNjb3JkaW5nIHRvIHRoZSBzcGVjDQo+IA0KPiDCoCAiVGhlIHNlY29uZCBpcyB0aGF0IHBsYXRm
b3JtIGZpcm13YXJlIHNob3VsZCBsaXN0IHRoZSBib290DQo+IHByb2Nlc3Nvcg0KPiDCoMKgIGFz
IHRoZSBmaXJzdCBwcm9jZXNzb3IgZW50cnkgaW4gdGhlIE1BRFQuIg0KPiANCj4gT2ggd2VsbC4g
VGhlcmUgYXJlIHJlYXNvbnMgd2h5IHRoaXMgaXMgd3JpdHRlbiB0aGUgd2F5IGl0IGlzLg0KDQpM
ZXQgbWUgc3luYyBpbnRlcm5hbGx5IHRvIHNlZSB3aHkgaXQgaXMgZGVzaWduZWQgaW4gdGhpcyB3
YXkuDQoNCnRoYW5rcywNCnJ1aQ0KDQo=

