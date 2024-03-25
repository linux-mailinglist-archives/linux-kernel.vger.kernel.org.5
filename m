Return-Path: <linux-kernel+bounces-117082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247788A6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FC4322F63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE066024A;
	Mon, 25 Mar 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUdawA6u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6512E7E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371893; cv=fail; b=ou5Wu6SRWSP3oKZFndGIhnJcMV5l3Azkew2ypL0SBthBmsMT+QEBO9Y+CipkCVoP+f/aHBIApFZFL+kqe5/8bZC5lIqp7NQwNqnD+kG2savgyMz4ryDDZ/Lk1DSVOvr6HQcrTQbmALxAA/vtHWv4RQnyMr5a24c8K7HxWcDy5v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371893; c=relaxed/simple;
	bh=LudY06sOpEvspFaMkJ+p9e/fC7WvBNFlR3OOf8ql2po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fqx6OvFIVyxOF9hbDMK9nSz9iTqb3S03enjLbNJzTyrjul8kd9PIknL/4VajTD5gUDp6Jo5M46RSn80IN0jneTlOjXKGRAptdGo/RTlGghFiM+Rp9vIlEvD9mSo9WqM5M7vFfsJ3MmpkkHuSx6nN8cwqwfs0W3IyLZwZQ46dZmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUdawA6u; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711371892; x=1742907892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LudY06sOpEvspFaMkJ+p9e/fC7WvBNFlR3OOf8ql2po=;
  b=WUdawA6uIMCjVWI6HyoQWWlEI5c8Um5qLqsci6XX6K7Mea2M2ADSpMpK
   zZF3RzC0O5PRvD3mJcP688XOQQGZi+KKjuHGqdplpvvhSR/iXXNivJe3t
   1pgXTc/KoWSSVlfyVFI2P8YpanjtLlLfYzWEBg5PDengfhcVQitz7QHV4
   JfuNIyM/QTSNG7yBvvR3wF76iN2BeujPfdv9oBCXZsH848n2cjnsVkcgf
   gbw1bczvqG4PgYybegb3/r1tITHft6KucNVoouNmBya1eZICExdLlT6zM
   E2l6z/4dxPo3PaG34I0COZruLwYmVSJpfCjyQ9KC9KD2sY2MmubyQC8S3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23819628"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23819628"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15523691"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 06:04:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 06:04:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 06:04:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 06:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQT0vs5dSKIbSA/Fk6Ft+dTEyn6WA/p52nFRMQDxXolll2z8msXCilYTRiMIJd/CgqR3nPDfwvu/A1G0REz1p1Ej9PYmfSLTv+Z28xTK4WS2b2AmfDCgLLyphqJG7gtFAEF5nF5VlsoQclC3SqKQwRe973QlINlz5WwYJ7Yud5+oGNy1FclqEn/rW7Ib9Ig5Oe/N47rCOXt6jge/T9No7LomkWVzVEdvKC/bJjaHGj6tl37bKtOo7oHtG2s9DAAoQ1p+hVZXadsvBwIcqREzPIiHLtYZiyT4MzagaGJiwSv5hr2+OjRypdvx2TjSIBpSoCg+1X7SS9BjauQsziGPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LudY06sOpEvspFaMkJ+p9e/fC7WvBNFlR3OOf8ql2po=;
 b=BfIxwxebQyogQOHsNkxqFGen8nuWSZ6bpW6iwMHt+cdgVxcOJ+1xD++9o3/nTCMpDTqa0en3V0zNR9yDf4K5+3+3thdrMfXu8Ug8XqVlC4G0F2UPXKH8S5mzFCO60ouF+StBMPWM4Q6eEZkAkyJNe2YVZ0d/HWqpkzr73Bq/5QbFqWZnFGQQxC0O+kHc+tGMWzEJSseEPbM0vdaIv1k9MOcLQjVQZh2a9HgSH0F97eh4y70VVceWbkX5gnJbOIHf8dJ/M6tdtsjLBK8FWyJ3pMQKn4SFG48FNigiXg8f0dl3aDxCyPXbegGT/ZfPIfhBvdFBKWEEFGFeKuqHAn1vQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Mon, 25 Mar 2024 13:04:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:04:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "luto@kernel.org" <luto@kernel.org>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "Gao, Chao"
	<chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Thread-Topic: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Thread-Index: AQHaeZ4rWTyxlb7R8E2AD6na+zVPXrE+6c6AgAA5LgCAAHBpAIABFFuAgAB07wCAACfDgIABbmeAgADkvQCAAEXPAIAEmWEA
Date: Mon, 25 Mar 2024 13:04:47 +0000
Message-ID: <144a6a5bb6f78966611b42a526e587c3daf4fd9f.camel@intel.com>
References: <cover.1710811610.git.kai.huang@intel.com>
	 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
	 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
	 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
	 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
	 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
	 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
	 <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
	 <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>
	 <glorzobyf42wylp57izgiukbe33c6ez5mgiwxepgn6pt2h4lr3@aqdas5q75mcb>
	 <9679cc44-fb90-d1ca-7c9a-10d0f6f5d3c2@amd.com>
In-Reply-To: <9679cc44-fb90-d1ca-7c9a-10d0f6f5d3c2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6472:EE_
x-ms-office365-filtering-correlation-id: 7e811c32-7729-4fde-c246-08dc4ccc25cb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EICsu1Cazr7ZzIFSG0t36ZeLUZJTvmuEEsD363x8YKIM2bpFUY5f312MNnMGiJXEYixmM7/g6jLSbv8skZgb4/iZ3MQk82h5+ijOJyS2pYtqa2SA+e/IRjQILIwCpoqzW3N4iWh5+czn2KHO6DQobgdURoZ5hymYFywCeXQvbCOffRwx9aL5SoLnruHGARfyrU3/CCXmz3bwhIfe8g84NNyEGK2so8TcjnyFFIFjqqQWdQpeKOYIFnHOfVPBIG3ZnN3xkStk425ME+z26nP0EicNPgr+PmkiKycEPeLRhP428YpbWolXlloNxfvlYZD3BFRlyN7ApKKy/KiAqRXAMbQhG9hhCbSAs5YgE4CbsKapRI31vROrGbmS4Uwg4Kuk6AKeqwKfJcIyXSqE/FWOAnV3Tzk0FbP/+A/hNy8cp+BNZsloiPd1JKdzJouWq5W8Pm1++XHQ6+YpMmbwbFP3mOLPEePHnptQ9z1j+6Agm1or6wUVqIPcgtScq3G1NpJ3ei7hxjlQwQfGoBmnNnbRg4chybqjC0ZSbr1bLo0drttyx4fH2SMn7zTF/17ctBGrReBi3C9DswUk47FcMLMWwDZoCdr4rR9Yn6nhuy34e4zg6E8lR0kiyf6EpeZkJVhBRkDVarqj9knPifi7T+GYNVGa8W9nZG770jsiWEYs5n4KO1etlrmscY1IorO/GySIFBl5O12iBdelcWtCxPOWb72BxZnphZwBoK+b9PaOlJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzVMTU5neDVuVlZ1VEt1di9sZmwrVG1CMlkxS2hvUXdHS014RGprOVIvV05s?=
 =?utf-8?B?a1JtOVZuV3ByYTJsdzZVZUVUMkxlWFhrZDFKZkhNMWdoVkZNeHdVV0VYeS9z?=
 =?utf-8?B?MmRsTDRzcTJ3Vm5kQlRNc0JvSzJWYUI4cFNLMWRpb0lJbXlySGhNOVNPNXR5?=
 =?utf-8?B?ZlVkODhBbnBabEV0Z3FiWDVLU3NKeGg1SmQyVm91TlBIcncwbXhMd3JPbXFq?=
 =?utf-8?B?V3Q4K3Z2QzRSdCtueGxQamhHSm9seWN5V0lnUkpCdFA2VWM1YmVkcm9ZeGFC?=
 =?utf-8?B?cldaVVQySndNd0pOUWx5aXRPVnp0b053ZHp0RklUaG9OZFdkdGlrR3lxUC80?=
 =?utf-8?B?N2NuTm5OSHFVOWg3OGlRSFBLT0dTbnVxL2hNMitMNDhoYy9oVjZsMkhiTGVE?=
 =?utf-8?B?RVpiVi9LNmlvWlFGS0xIZTdDcWlyNVArd09NNnl4UUt6aXBxMzBBM01lQm83?=
 =?utf-8?B?MjlBMWQwOFdjRGt2QTVCWUl0UHNXcDhmeDRuM0RHQXVnYzJaREtjNGg3RGpO?=
 =?utf-8?B?emFLR0dIUjA5MjYySGNHNHk1NjYwZWZBY0RteE16Vzhnb2hTcFJtdHlwK2FS?=
 =?utf-8?B?azM0dkc0SXY0elpwcDlPZU5FRTJhbC9rTWtlTGFYek9ibG12WG40NElzYW5h?=
 =?utf-8?B?UjZpdzZGR3lnVGFLbGEyKzdTT0YwdGg4TEVYV0NpQkZlV2ZuY1IvNDJpVjJZ?=
 =?utf-8?B?ZjRxL2VPY2VwNHpseVlaWFFJWG82UHFpb1ZoQTliejhXY0RJYzFIMFdzdWVQ?=
 =?utf-8?B?dlZXRyswd0ZETys5Q2hDa1RvNzRnbElSZ0dEK0U4YStsVGFzZG5SRlJnblZX?=
 =?utf-8?B?MW1pZlZmU1lLZmRVYmdBM3Fwa1U2dWRwTENXb2V3bkNMazBWcmJXaWZrY0s3?=
 =?utf-8?B?R2s1UU9MY1p6UzVIZ2lUOUlITlFRTis2M0tZNC8zYmJ6eThVMkdXRXF6Ylps?=
 =?utf-8?B?SzZzR2NLOCtnWXVIcGk0NWNXaDc0bTVqSy9wSEdYYTJGQjJBZFp6ZGphMVAx?=
 =?utf-8?B?RkpocU9DYUhhNnpUZjFJeVJTY2pIcDBnVVdXdVd4ZjdXR01xRTN3KzRxQ3or?=
 =?utf-8?B?OFBtYkRsOTFCWE8xcTVUVmNpMm1MZU5lSFVGcnBpQ3d2c2ZwYjRVUjd2YTUw?=
 =?utf-8?B?dDE2NFBCU1hMQVd5aCtOSkdldjBBeXNGdHVqTXpQVXRaWk5LU2E0MlV5VGhM?=
 =?utf-8?B?VVdBM0RweFdMbUMzVWwzU1dCNkJxcC91TGcyMjdvTCtIVFk0YnRKVWx6SkJy?=
 =?utf-8?B?a1BtbUtIZTZWMERhMUp2NW4yRjFPTnYyN1NrWlhDUUtpMENiYVdNdC9DcGFx?=
 =?utf-8?B?K2xEL0I1THkzNlJwanUyUS9QNHQxZTRIV1hmekp6SjJDZnVrUzdPU2lmWnZM?=
 =?utf-8?B?SURjaUQ4ZmZFdGtmSWVSQ1RwZS9IVkNwcExyV1dOcEk1bjdEMytzb3JCbmJE?=
 =?utf-8?B?UmIzV2U2KzhFck9TRkxXaGJaR2NQMjdkUmF5cWw5K2pybzZBNWRaYXY5aml6?=
 =?utf-8?B?bS8vbVBkQ1dDNDB1Y3pEWUUydEJmOHFZczFmUmJ2S3NrTmVLNWdEWmVjdGN2?=
 =?utf-8?B?YTY4cUJZOHpRSFZ5Z1VBMEM3UDN2QmgvWUxmOEYvV3p1U2lCQ0NEaGlzK0RB?=
 =?utf-8?B?L1o1ZVF0VWxFVkdmbS9KYzYvWExLZDFaVTlMUnZGejF6cE11MnZRWVZ2RG5U?=
 =?utf-8?B?WUV2NzdRL01kKy9pK0FWZFlwbkNvZGpwcHA1NXZJVVByNnY3UmhKM2hnK1Q5?=
 =?utf-8?B?U3BKeERPWUlIKzFDNkR0c0lSejJZbWttS3RKMFEvSW02NXM5WS9PYnprVHM2?=
 =?utf-8?B?YmYrTGM1ditIYlRYakZjZHhSVm1DM1p2c25PYmMra1Y4a0R5TzZBakw5WDlC?=
 =?utf-8?B?Q2xWSnRTNG9zNVJrVS9JREkwWUNLclNKVTlsYUQzYTBLaERlSXcvREtMZnRl?=
 =?utf-8?B?ZmVPVlNtK3hkOXNvQmlMT0NVS05mcWpjemhYUytVQVVEZ2FpOWU0NTFLY2tq?=
 =?utf-8?B?dmVpbUVxMjlreEZDM29mSFpRdnllaHNSRE83dlp3WTU2K2xsMzc0WWJ5SDBn?=
 =?utf-8?B?Smhob2xodGR6RlppOVF0RkErTGFjVzdKMVI1SlBBdVpOcHJtWldsekJlcW50?=
 =?utf-8?B?Q1RnUkhHZGhzaDVOMms1TEpOSHgyM3dCVi9JTUJyR1d0ZDV5U1B3NFJXRGMw?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F687EC6D0AB284586C95B4EF1DEDB1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e811c32-7729-4fde-c246-08dc4ccc25cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 13:04:47.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2VVBnJYyJQ4JTsWdu0Mn+HsBREkYedcWzs827A8H4H4hlYEKaqQMWJHu33QUxK1S5JRoQT6dVxfu+kMG2CcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDA5OjUwIC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IE9uIDMvMjIvMjQgMDU6NDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPiBPbiBUaHUs
IE1hciAyMSwgMjAyNCBhdCAwNDowMjoxMVBNIC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
ID4gPiBPbiAzLzIwLzI0IDE4OjEwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiA+
IE9uIFRodSwgTWFyIDIxLCAyMDI0IGF0IDA5OjQ4OjI4QU0gKzEzMDAsIEh1YW5nLCBLYWkgd3Jv
dGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEhpIFRvbSwNCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IEkgYW0gbm90IGF3YXJlIG9mIGtleGVjKCkgc3VwcG9ydCBzdGF0dXMgZm9y
IFNFVi1FUy9TRVYtU05QIGd1ZXN0cy4NCj4gPiA+ID4gPiA+ID4gRG9lcyBwYXRjaCAxIGJyZWFr
IHRoZW0/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNOUCBndWVzdHMgY2FuIGtleGVjIHdp
dGggc29tZSBwYXRjaGVzIHRoYXQgYXJlIGN1cnJlbnRseSBpbiBwcm9jZXNzDQo+ID4gPiA+ID4g
PiBhcm91bmQgc2hhcmVkIHRvIHByaXZhdGUgbWVtb3J5IGNvbnZlcnNpb25zLiBFUyBndWVzdHMg
Y2FuIG9ubHkga2V4ZWMNCj4gPiA+ID4gPiA+IHdpdGggYSBzaW5nbGUgdkNQVS4gVGhlcmUgd2Fz
IGEgcmVjZW50IHBhdGNoIHNlcmllcyB0byBhZGQgc3VwcG9ydCBmb3INCj4gPiA+ID4gPiA+IG11
bHRpcGxlIHZDUFVzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBQYXRjaCAjMSBkb2Vzbid0
IGJyZWFrIGVpdGhlciBFUyBvciBTTlAgYmVjYXVzZSB3ZSBzdGlsbCBoYXZlIGFuIElEVCBhbmQN
Cj4gPiA+ID4gPiA+IHRyYWRpdGlvbmFsIGtlcm5lbCBhZGRyZXNzaW5nIGluIHBsYWNlLCBzbyB0
aGUgI1ZDIGNhbiBiZSBoYW5kbGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhvdyBhYm91dCBw
bGFpbiBTRVYgZ3Vlc3Q/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFdo
ZXJlYXMgcGF0Y2ggIzIgaGFzIHN3aXRjaGVkIHRvIGlkZW50aXR5IG1hcHBpbmcgYW5kIHJlbW92
ZWQgdGhlIElEVCwNCj4gPiA+ID4gPiA+IHNvIGEgI1ZDIGNhdXNlcyBhIHRyaXBsZSBmYXVsdC4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGF0IG1ha2VzIHNlbnNlLiAgVGhhbmtzLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IEhpIEtpcmlsbCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEb2VzIFRE
WCBndWVzdCBoYXZlIHNpbWlsYXIgYmVoYXZpb3VyIC0tIHRoYXQgV0JJTlZEIGluIHN0b3BfdGhp
c19jcHUoKSBjYW4NCj4gPiA+ID4gPiBiZSBoYW5kbGVkIGFsdGhvdWdoIGl0IGNhdXNlcyAjVkUs
IHdoaWxlIFdCSU5WRCBpbiByZWxvY2F0ZV9rZXJuZWwoKSB3aWxsDQo+ID4gPiA+ID4ganVzdCB0
cmlwbGUgZmF1bHQgdGhlIGd1ZXN0Pw0KPiA+ID4gPiANCj4gPiA+ID4gTm8uIFdlIG5ldmVyIGhh
bmRsZSBXQklOVkQgI1ZFLiBHdWVzdCBjYW5ub3QgaGFuZGxlIFdCSU5WRCBpdHNlbGYgYW5kIHRo
ZQ0KPiA+ID4gPiBvbmx5IG9wdGlvbiBpcyB0byBhc2sgaG9zdCB0byBkbyB0aGlzLiBXZSBjYW5u
b3QgZ3VhcmFudGVlIGhvc3Qgd2lsbCBkbw0KPiA+ID4gDQo+ID4gPiBJcyB0aGUgV0JJTlZEIHBl
cmZvcm1lZCBvciBpZ25vcmVkIGluIHRoYXQgY2FzZT8NCj4gPiANCj4gPiBXZSBjcmFzaCB0aGUg
Z3Vlc3QgaWYgaXQgdHJpZXMgdG8gdXNlIFdCSU5WRC4gVGhlcmUncyBubyBsZWdpdGltYXRlIHJl
YXNvbg0KPiA+IGZvciBpdC4NCj4gPiANCj4gPiA+ID4gYW55dGhpbmcgdXNlZnVsIHdpdGggdGhl
IHJlcXVlc3QuIEkgZ3Vlc3MgaXQgY2FuIGJlIHBvdGVudGlhbCBhdHRhY2sNCj4gPiA+ID4gdmVj
dG9yIGlmIGhvc3Qgc3RyYXRlZ2ljYWxseSBpZ25vcmVzIFdCSU5WRCB0byBpbmR1Y2UgYmFkIGd1
ZXN0IGJlaGF2aW91ci4NCj4gPiA+IA0KPiA+ID4gV2l0aCBTTlAsIG1lbW9yeSBpcyBjb2hlcmVu
dCBzbyB0aGVyZSBpc24ndCBhIG5lZWQgZm9yIGEgV0JJTlZEIHdpdGhpbiBhDQo+ID4gPiBndWVz
dCBhbmQgc28gaXNzdWluZyBpdCBzaG91bGQgbm90IGJlIGFuIGlzc3VlIHdoZXRoZXIgdGhlIGh5
cGVydmlzb3INCj4gPiA+IHBlcmZvcm1zIHRoZSBvcGVyYXRpb24gb3Igbm90LiBJIGRvbid0IGtu
b3cgd2hhdCBjYW4gaGFwcGVuIGluIHRoZSBjYXNlDQo+ID4gPiB3aGVyZSwgc2F5LCB5b3UgaGF2
ZSBhIG5vbi1jb2hlcmVudCBURElTUCBkZXZpY2UgYXR0YWNoZWQgb3Igc3VjaCwgYnV0IHRoYXQN
Cj4gPiA+IHdvdWxkIGJlIHZlcnkgdW51c3VhbC91bmxpa2VseS4NCj4gPiANCj4gPiBMb29rcyBs
aWtlIFNOUCBpcyBpbiB0aGUgc2FtZSBwb3NpdGlvbiBhcyBURFguDQo+ID4gDQo+ID4gPiA+IEFu
ZCBpdCBpcyBub3QgZ29vZCBmcm9tIGhvc3QgUG9WIGVpdGhlci4gSWYgaXQgZG9lcyBXQklOVkQg
b24gZXZlcnkgZ3Vlc3QNCj4gPiA+ID4gcmVxdWVzdCB3ZSBnZXQgZ3Vlc3QtPmhvc3QgRG9TIGF0
dGFjayBwb3NzaWJpbGl0eS4NCj4gPiA+IA0KPiA+ID4gWWVhaCwgdGhhdCBjYW4gaGFwcGVuIHRv
ZGF5LCByZWdhcmRsZXNzIG9mIHRoZSB0eXBlIG9mIFZNIHJ1bm5pbmcuDQo+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IFRvbSwgSSBhbSBjdXJpb3VzLCBob3cgZG8geW91IGRlYWwgd2l0aCB0aGVz
ZSBwcm9ibGVtcz8NCj4gPiA+IA0KPiA+ID4gSWYgdGhlIFdCSU5WRCBpcyBiZWluZyBpbnRlcmNl
cHRlZCwgdGhlbiBpdCB3aWxsIGdlbmVyYXRlIGEgI1ZDIGFuZCB3ZSB1c2UNCj4gPiA+IHRoZSBH
SENCIHByb3RvY29sIHRvIGNvbW11bmljYXRlIHRoYXQgYmFjayB0byB0aGUgaHlwZXJ2aXNvciB0
byBoYW5kbGUuDQo+ID4gDQo+ID4gSSB3b3VsZCBhcmd1ZSB0aGF0IGZvcndhcmRpbmcgaXQgdG8g
aHlwZXJ2aXNvciBpcyB3b3JzZSB0aGFuIGNyYXNoaW5nLiBJdA0KPiA+IGdpdmVzIGZhbHNlIHNl
bnNlIG9mIGRvaW5nIHNvbWV0aGluZy4gSHlwZXJ2aXNvciBpcyBvdXRzaWRlIFRDQiBhbmQNCj4g
PiBjb25zaWRlcmVkIGhvc3RpbGUuDQo+IA0KPiBTaW5jZSB0aGUgbWVtb3J5IGlzIGNvaGVyZW50
LCBpdCByZWFsbHkgZG9lc24ndCBtYXR0ZXIgd2hhdCB0aGUgaHlwZXJ2aXNvciANCj4gZG9lcyBp
biByZWdhcmRzIHRvIFdCSU5WRCAoaWdub3JlIGl0IG9yIHBlcmZvcm0gaXQpLiBBbmQgdGhlIGh5
cGVydmlzb3IgDQo+IGNhbiBkbyBhbnl0aGluZyBpdCB3YW50cyBvbiBhbnkgZXhpdCwgcmVnYXJk
bGVzcyBvZiB0aGlzIGludGVyY2VwdC4NCj4gDQoNCkkgZ3Vlc3MgaXQgbWFrZXMgc2Vuc2UgdG8g
bm90IGhhbmRsZSAjVkUgZHVlIHRvIFdCSU5WRCBpbiB0aGUgc2Vuc2UgdGhhdCBndWVzdA0Kc2hv
dWxkbid0IGRvIFdCSU5WRCB3aGVuIG1lbW9yeSBpcyBjb2hlcmVudCBmcm9tIGd1ZXN0J3Mgdmll
dywgYWx0aG91Z2ggaXQgaXMNCmhhcm1sZXNzIHRvIG1ha2UgdGhlIFdCSU5WRCBhbmQgbGV0IGh5
cGVydmlzb3IgaGFuZGxlIGl0Lg0KDQpBbnl3YXksIHRoZSBjdXJyZW50IFREWCBndWVzdCBkb2Vz
bid0IGhhbmRsZSAjVkUgZHVlIHRvIFdCSU5WRCwgc28gSSB0aGluayBmb3INCnNpbXBsaWNpdHkg
d2UganVzdCBkb24ndCBkbyBXQklOVkQgaW4gc3RvcF90aGlzX2NwdSgpIGFuZCByZWxvY2F0ZV9r
ZXJuZWwoKSBmb3INCmJvdGggVERYIGFuZCBTTlAvU0VWLUVTIGd1ZXN0cy4NCg0KQXMgbWVudGlv
bmVkIGluIG15IGVhcmxpZXIgcmVwbHksIHdlIGNhbiBhY2hpZXZlIHRoaXMgYnkgc2tpcHBpbmcg
V0JJTlZEIHdoZW4NCnRoZSBDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUIGlzIHRydWU6DQoNCglp
ZiAoIWNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUKSkNCgkJbmF0aXZl
X3diaW52ZCgpOyDCoA0KDQooVGhpcyBza2lwcyBXQklOVkQgZm9yIHBsYWluIFNFViBndWVzdCB0
b28sIGJ1dCB0aGlzIGV4YWN0bHkgaXMgdGhlIGN1cnJlbnQNCmJlaGF2aW91ciBvZiB0aGUgdXBz
dHJlYW0gY29kZSwgc28gSSBkb24ndCBzZWUgYW55IHByb2JsZW0uKQ0KDQpBbHRlcm5hdGl2ZWx5
LCB3ZSBjYW4gaGF2ZSBhIGRlZGljYXRlZCBDUFUgZmVhdHVyZSBmbGFnIHN1Y2ggYXMNClg4Nl9G
RUFUVVJFX05PX1dCSU5WRCwNCg0KCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX05PX1dC
SU5WRCkpDQoJCW5hdGl2ZV93YmludmQoKTsNCg0KT3IsIHdlIGNhbiBqdXN0IGNoYW5nZSB0byBv
dXIgbWluZHNldCB0byAiZG8gdW5jb25kaXRpb25hbCBXQklOVkQsIGJ1dCBub3QgaW4NCnZpcnR1
YWxpemVkIGVudmlyb25tZW50IjoNCg0KCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hZ
UEVSVklTT1IpKQ0KCQluYXRpdmVfd2JpbnZkKCk7DQoNCg0KSGkgQm9yaXMvRGF2ZS9Ub20vS2ly
aWxsLA0KDQpEbyB5b3UgaGF2ZSBhbnkgY29tbWVudHM/DQoNCg0K

