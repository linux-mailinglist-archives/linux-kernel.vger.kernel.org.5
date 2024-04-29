Return-Path: <linux-kernel+bounces-161685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9118B4F78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AE31C20C95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B98472;
	Mon, 29 Apr 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AifSmsL+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EC79E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714358364; cv=fail; b=O9/ZM6ZKuwxxih0oMOIluBb87mh+oRoLhlbHZVOx+apzghwo4QNdTHE0L51GCkql7P2EqTx7wfnTnRjdT+1I3LbpJ4j/7sWv3H97gAOUMVPaX5XhUV/HZBi1yJ/aRwavcsddl/Sy+xmIWt2w4oU9FIlav76NBTElliGS/8DLDfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714358364; c=relaxed/simple;
	bh=7ET5IlGkzXeUWHPyrBw8KugmsPw5sPzoDNysiEUua4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8csQ1RLI7K+PysUOe8sRdKhnMH204ujtt6BkAP10F+YNkSYhmSY3SLl+XFO9Kn9qvEpd5m9bP749Udkmgqv0NUdVgsB5dpLd3zt3InNTkwrNG39ekkD8ufs8+rfnD5yvJHUGcAEm0Pz3q37bNKaUBEBXYfDdjk0Arx/U4bri4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AifSmsL+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714358363; x=1745894363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ET5IlGkzXeUWHPyrBw8KugmsPw5sPzoDNysiEUua4c=;
  b=AifSmsL+EkGHJKw9nAkDHZRQT9qb/zj16Jl44B/rBQuK+feywTiwneYO
   X+Bu9dwg7khVmD4L7M+EohpFjwvF9++ZzPMkYLyIjuPTVcA3PKTPBRQkA
   ELuB/Y5mvLB9C3INMABffXExMMw7x8RR7ztW8XptaXj2TAhYsUq6hN4mr
   QlaK1ezD2wDX8SDs5f605imi9w5w2YgJczqIvxS7xUoKghl5gTq4tK1lP
   gtfTql9dq9hDC48QVJQiPInBfMScU9k6gjC3/jh1knuO6cyTFWfnah2VI
   23r39slLPFcXDSUfLC2hJMtXdksRtKFZASC4ckWltQMmNtbTWnXm2STGh
   Q==;
X-CSE-ConnectionGUID: xxrybdOJRYuk4FliJxAksA==
X-CSE-MsgGUID: rQBfqPmLRyaz/sK7mJnW7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13782109"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="13782109"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 19:39:22 -0700
X-CSE-ConnectionGUID: mWJiWzrGTqyb4B0gdNsXNw==
X-CSE-MsgGUID: gdUhTsSPTeiushoppQNjPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30642390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Apr 2024 19:39:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 19:39:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 19:39:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 19:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/xwIs/Y9tnJ07t3wxFO06fYKLYez/cWMHrhTuQMvo6fIU1L98sYTgUz+0TqWY7TWoWVMOSNbJ5vu/zEfzsA2SY6nnnmcZftm/FquZ6hQmOxZvF1Tp5aEAimvl+kmvQFVE+aV0OOZh5QrPusAA8UHGPSX9HcdJREH+dK1VSIx6qXyuKgtG4JLU+335mvyu9z8+Q6mtqAo/zGL7Mb3ZpEolILtenBNKnbltdXNOd2KunggtnknxncluchfVEMYyNwGms5Cqm6X4PmZbGI+4doFTlEHVn4uTCjWjLkEKWoOusW1Sc+aYR3rXd1KXoRuD97ynm3LoQGeb9wZsauXs5P/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ET5IlGkzXeUWHPyrBw8KugmsPw5sPzoDNysiEUua4c=;
 b=fvp8XpXhLJT5HS/sSWwl5wcsMoXi0Ys5TiEXBJtXBA/w7R7WfRkbfGVtL9gUDVtPdyG0MhAeD96EBhkfYIybIwW4j8/5JWwK/ty32ARZrf1/5E4S0b3EtggDzzGOimnvpcvjjuZV5bf69IkO5/maN6GgRAeaNOTL8O+WL7tp8p1eKvPoTBeCfx0Ohp+BwSpI5fMjPQRcLHqO6VmW9xNuzrecovStOZlrNj4bFLG0X2eyQVzzyp6w53rnj3ldTM3YQw+KKcD4H02c8lQBViTg5J7Tjekd2Z9roRXuOyAt/wybgd2Ej97aNh2cmCWLRtHt9bf/gAOGsDWbsnLgCY+dPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 02:39:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 02:39:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Thread-Topic: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Thread-Index: AQHahWSVLO069+spLU+TvRmgEFYzzrFWceeAgARVTQCAA62gAIAAxtgAgAFqQACAHPs7AIABD8FA
Date: Mon, 29 Apr 2024 02:39:18 +0000
Message-ID: <BN9PR11MB5276F89C1C21BD03207A044F8C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
 <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
In-Reply-To: <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4654:EE_
x-ms-office365-filtering-correlation-id: 0e978b11-26db-4442-b403-08dc67f5917b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dkFwY0VVTnZKVFdqU0o5eERldTQwM2RXZ3NEbnQ1alY1QnFyaU9oMGUyd1k5?=
 =?utf-8?B?OFRzUDkvRi82OEltSnZ5RUhVT2ZOTEVGTWJSc3ZzSkMzcGlTaTFvWXQyUUJK?=
 =?utf-8?B?cVVGNFAxTE9pYjNkTEZ2WDBwNHZSSnBkL0J4dEtaOHFQK2FqODNacU1WNVVF?=
 =?utf-8?B?dWh4ZXB3ODI0ZS9ra2Q1T1Z3cWcrVXhraWE2SGRYbiswOVFJMXN5Z3FUVFJP?=
 =?utf-8?B?TytEVlhJZ00vdjA3Z214OHVTY1dSU3B1Y1hVUlRpUUJlcHUyMlAvY2hpTkYv?=
 =?utf-8?B?d1RrMFkrdk9xS3JvZ09NWXpaZ2Z2aFF4ZUw4VnJLU3JteHFtYkxSczN3VXBF?=
 =?utf-8?B?VlF6ZlRldGFUK2RWa3pNSUNhK2I0bUJrWVJqaDVUVFNsQXMraXk2YmNjcHVs?=
 =?utf-8?B?b2VVdkt1bWdtWjNGMDZ6SWgxcmJPZ1FmaVlCL0JFQm1iQjV0Tlc1UXl6czFp?=
 =?utf-8?B?VXB3dUZ6Qi9acUZSMld2cGs3Vmg3N2MvOGZLdU9PNndUZzlCS2p0d2VxT1Va?=
 =?utf-8?B?MGFtL0VqNzZmNXV1T0h2RzBRV2NIczdyRXhrR3lKS0dkcmhMVGRZRTBnNzBo?=
 =?utf-8?B?STk0RGh1RW1DdjJsMnlodHNIakdmQUp2ait3RnN3Y2U5TXF0ZnlWMmNheTdZ?=
 =?utf-8?B?MWVEaEhTWFRtdEV4N3JTdFd0WmExUzhBcFVweTBUc0xhVnVjTElKU3R2L2Vq?=
 =?utf-8?B?aWNiYllVeVBHQTZhcEM3VERMTnc0SkFWazdqRTFBRzBvSW4zTmYxSG1YZ0ds?=
 =?utf-8?B?TEFiZXE5RUI3a0hEbFJTT3dSc1Y3RDJzNGxzTk8rSldCd3Z4T1lrV3dOVjlo?=
 =?utf-8?B?ejBwc2kyaWxzNFkrQVdORXFjS1VWdWpDQTNXT1pLTHVXYzlPOHJzVzFId3Jx?=
 =?utf-8?B?dlNXYWdYWFJwMlorTzBTclpkb1o2WlBubU5xOHVxamFDbDA2QXh1VmlLRTBS?=
 =?utf-8?B?L3RycURNckZmQ2hkNW1IVnhIdHk5TDltM2I1cVYrRjdoZHZ0T0QxQnkzZXd2?=
 =?utf-8?B?bDBLcDRscEtpVTQwclBRbVpaejU0SFZuVWdvYU11NVZWa0dGMkhjNDd2elVQ?=
 =?utf-8?B?YlZ0RXpjWmpieHIvWE9jSms5aEhhOXRwWVYvbEpZYzI4Tlp2VGthYm9oQWw4?=
 =?utf-8?B?U096TkJuWUQ0R0ZTdzNVMjYraVp6MjNlem8zbHFBZVJ3U2JYNzdVSTdLbkdS?=
 =?utf-8?B?NjhqVFE5Wld6QnhzM292OWg2REpPUUdiV1ZuVFhBb0tRWnM1bDE2UjFWV21k?=
 =?utf-8?B?YTRLMWtsaDNRNVE5ZDhOU3pQU2lPejJ1cWlIQnVEZUJjL2VFMXMrT012aHpD?=
 =?utf-8?B?VzV3WWFlSmxCZy80M0tjMUVPTzdxd2E2bTFUNDVlcTJORHY2a0hYTTdCVUhq?=
 =?utf-8?B?ZGRBZm5La1lVc0d0blNUaGc1eWFIeW5KMW1qcmFlczlVckt3WWJCeWdyWlhN?=
 =?utf-8?B?ZjZTTXVwckQ1OVk0K1BVanZkZEJCc2RlcFNXSG9EaEJ0aXIvS1pQMWRXV0NT?=
 =?utf-8?B?cHFBRGExUThDdDQvdExPVG5tdURleUo1bk44N1gzT3VHMzZFTEVLQ2FLMXZL?=
 =?utf-8?B?N3NWSmFLTWp4MUd5UHNkNm1jdyt3SmF6V3doRWpINEU5Qncwem1ZUlB3Sy9F?=
 =?utf-8?B?Q3FDeHVVSEt4RHZLTnM5d3hVRk1hTTF3T3VsaE4ya3FNdEZ5eVhqK3cwYy9D?=
 =?utf-8?B?cXFaSGVKZHNrUnhVcGdyWksvZDUvRUU1Z1FxNVlFak9Wck05VVBrVktzT1Nr?=
 =?utf-8?B?cWZLUmVDSDgxaC9PNVVwWGRpVW16Q0hYMm55d2lJSjFndnlWMzlPTlZXdEly?=
 =?utf-8?B?U1FlbWtwQVU5K2RoOEtLdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE4zMitCTitDdkcrV2tncitRUjRhekltMWVXUlo4SUozT1JVSldxejkxRTVH?=
 =?utf-8?B?eE1CaVlPRFJ1Kzk5OFBSRjh5eXVBZ1Y4ekgybi9wb05uTVlRK1hURXVTck5V?=
 =?utf-8?B?bGJUVmk2OHp3QXBISDhBaFhyR3ZrUS9OQzhySGpUejVkbTdzaVlUZENuL3Bz?=
 =?utf-8?B?eHJqTlZCUHVmVXA4MjN2MTcvSTZJVkZkMm9PeUhhVVhmdGFCdXFBVEVMVksz?=
 =?utf-8?B?ck1kV0ZlRFRVcmx3bXBaSGtmUDJMNW45UUh2NDVheUZzL25SOVJSbDRBYnhz?=
 =?utf-8?B?bjFOVUVNYVZUQnNxbXJrNGlDSFQ1NGt1UTZqbi9QWkRIdzhmd1A1dVEwTDdn?=
 =?utf-8?B?bTZ1b04xdzBRTjNOb3JCK29EZGlySGUrWXIvVFBNWGxVOFBHejRQWWlUUm9M?=
 =?utf-8?B?NmlueVZiMitQalkwZFZ0YjNldnZhZzdPSU5vTXo0blVJR1I2RTVHQkxIWjlJ?=
 =?utf-8?B?KzJpQzRiR0NOMWxhakZvUWlTTHIrNlphRURWSzVWQWZhdFhHWkpJY2R4V2xD?=
 =?utf-8?B?WnN3NmtpUnl6RTdqTnREMm1CM2NnK0hIQzRZaUFidk96VFpCRGdOQThuazBL?=
 =?utf-8?B?K1NCeFRHMDJYWE5wbTBGakhuQ1haSEw0VzJiNHFQamZGSmhBRmN6SXVFcWUx?=
 =?utf-8?B?NGwwNk4rR2tsR0xqVGZDUUtwTWxNUGRxVHZXcUR1cXJGaTR0WGpnZGlIZXdZ?=
 =?utf-8?B?TWhMU1ZKejhUbHp0YjVNMk0xUzVwRlB1VEZQSTE2YS85VVhxcXVmU1RSWkUr?=
 =?utf-8?B?Qzg2SG1wMWtKYU82ODBpTFBFSnVTaEVWV3k4Vko5WGwxbFQvN2NXdUlnbTNI?=
 =?utf-8?B?SThSYjBDUUxPTVoweFJNM0l1L1o5T0wxbDk4N2VqSzM4ZUwxRTN0ZEhaUndL?=
 =?utf-8?B?MU9vRkZ3MXE1YzZvRlBielZFdndsTXI1enVWa1RldmkwWGwyS2NCeW85M3VH?=
 =?utf-8?B?RmZrK1h5a1FIMHJCV1pxaThrVWNwek4rcGhUQkFyQzFTNFBncTQxa1p0TU9a?=
 =?utf-8?B?cm9YMHRQVVVmbmwvRm13czN2Q2NLTzVtRnlmNE1JcWZ6ejBtbXZHQjQ5cUhU?=
 =?utf-8?B?TjJwaDcwZTFTT1NSdWMyYkkrMUFHV0JRcmRSM2t5VzhKWVB4S3Z0cElSbEVY?=
 =?utf-8?B?N1I3RElNMmRNNEJFdVJXYjNyWDBoekxJM1FIb2RZL2pzVGEySUxKZGo5OXlC?=
 =?utf-8?B?Y1I3N2dZaXpwNFNGSk9lTmlSbDBydDVOczVzcHhoNm5KdW1tNlphTzVycWRN?=
 =?utf-8?B?Q3BDQWZ6WWNHSWk0d0JWNTYxejBhQlRkZzlyYWZTdmJ2YmVXbVV1UGZkcmZD?=
 =?utf-8?B?Zm95L25wZEVrQjU3dU5kQnZaUWUrbmRVaTFGcmVmNVVPR3Q5NStzSytwZlJK?=
 =?utf-8?B?ZVJZTmJlWnVDWWhpWVVqTllvZ3VpUFRMSy9NeGp1Syt0Q0sxa3RvOWZTMHFB?=
 =?utf-8?B?cituSzg3c01jWjRvMktxcTNmRTRWM0g5U1pXWENETjA1T255dHVxMGh0bVEv?=
 =?utf-8?B?bXRsZjF2VC9rVlgyMzlaTTIvWEJzdkNMZ3hiM1hzbjJqZWpMeUZhN1BtL2JR?=
 =?utf-8?B?VUdCOHVmU2ViU3d2dWtlMEVESkMyRkk1a0JjYTd2SE4vWXpTaG1QUG1hb2JU?=
 =?utf-8?B?MWZxelVVRC81bklVdFo5Yno4ZW5GUlRCUnF1SVNENytadFNLaUxVTnhTTjAz?=
 =?utf-8?B?aW15MndQTUxrSHhJK09UQk9tRzNuSjMvcWFFTmhVQWhlZ2FYdUMwc0Jtc3VB?=
 =?utf-8?B?dnQ4YVE0U2pYUHhTeUtGZmtFTWZOMktzS1FIWWxSeE9EYWRpMllGdUlaMDRK?=
 =?utf-8?B?UjNwbHFFcTl3RGdmWHpSbGRFL0R0anVVSXRTL0FMT1dsVGEyS1RMcU9PZlFK?=
 =?utf-8?B?ZmxvWE9DdkxvajM0K2dBdnNsM0N6WXkrNWJIelZxTlFyNTRnRWNTV2szYWI5?=
 =?utf-8?B?N2I4ckpJNkhlY2RkTDVqelEyS0JWTnZxeTR4dk9qcTZNYURkM0FaOVpHbXZN?=
 =?utf-8?B?YjlIMmtvMkovbndYMDltdUd4OUpZeWZSM3ROT05CeTRyVk1WQlFDczI1enRZ?=
 =?utf-8?B?cy9GVHNFSCtJU2tOU1ZRa04xVU9NMi9WQXdHNmg1ZE8yYmlCbURadCtvSHJC?=
 =?utf-8?Q?5UPuELD5F0dcwwKsHCPIspaNR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e978b11-26db-4442-b403-08dc67f5917b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 02:39:18.5180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dQhXqgvOdWTMtgUET90CBCBHWDjlkz3FxdCrRPDo21kb8VW1EHXMSwIIJZv2006f8XK0fy6dkEBVXY/MiDwnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDI4LCAyMDI0IDY6MjIgUE0NCj4gDQo+IE9uIDIwMjQvNC8xMCA3OjQ4LCBKYXNv
biBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVHVlLCBBcHIgMDksIDIwMjQgYXQgMTA6MTE6MjhB
TSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4+IE9uIDQvOC8yNCAxMDoxOSBQTSwgSmFzb24g
R3VudGhvcnBlIHdyb3RlOg0KPiA+Pj4gT24gU2F0LCBBcHIgMDYsIDIwMjQgYXQgMDI6MDk6MzRQ
TSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4+Pj4gT24gNC8zLzI0IDc6NTkgUE0sIEphc29u
IEd1bnRob3JwZSB3cm90ZToNCj4gPj4+Pj4gT24gV2VkLCBBcHIgMDMsIDIwMjQgYXQgMDk6MTU6
MTJBTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4+Pj4+PiArCS8qIEEgYm9uZCBhbHJlYWR5
IGV4aXN0cywganVzdCB0YWtlIGEgcmVmZXJlbmNlYC4gKi8NCj4gPj4+Pj4+ICsJaGFuZGxlID0g
aW9tbXVfYXR0YWNoX2hhbmRsZV9nZXQoZ3JvdXAsIGlvbW11X21tLQ0KPiA+cGFzaWQpOw0KPiA+
Pj4+Pj4gKwlpZiAoaGFuZGxlKSB7DQo+ID4+Pj4+PiArCQltdXRleF91bmxvY2soJmlvbW11X3N2
YV9sb2NrKTsNCj4gPj4+Pj4+ICsJCXJldHVybiBoYW5kbGU7DQo+ID4+Pj4+PiAgICAgCX0NCj4g
Pj4+Pj4gQXQgbGVhc3QgaW4gdGhpcyBjb250ZXh0IHRoaXMgaXMgbm90IGVub3VnaCB3ZSBuZWVk
IHRvIGVuc3VyZSB0aGF0IHRoZQ0KPiA+Pj4+PiBkb21haW4gb24gdGhlIFBBU0lEIGlzIGFjdHVh
bGx5IGFuIFNWQSBkb21haW4gYW5kIGl0IHdhcyBpbnN0YWxsZWQgYnkNCj4gPj4+Pj4gdGhpcyBt
ZWNoYW5pc20sIG5vdCBhbiBpb21tdWZkIGRvbWFpbiBmb3IgaW5zdGFuY2UuDQo+ID4+Pj4+DQo+
ID4+Pj4+IGllIHlvdSBwcm9iYWJseSBuZWVkIGEgdHlwZSBmaWVsZCBpbiB0aGUgaW9tbXVfYXR0
YWNoX2hhbmRsZSB0byB0ZWxsDQo+ID4+Pj4+IHdoYXQgdGhlIHByaXYgaXMuDQo+ID4+Pj4+DQo+
ID4+Pj4+IE90aGVyd2lzZSB0aGlzIHNlZW1zIGxpa2UgYSBncmVhdCBpZGVhIQ0KPiA+Pj4+IFll
cywgeW91IGFyZSByaWdodC4gRm9yIHRoZSBTVkEgY2FzZSwgSSB3aWxsIGFkZCB0aGUgZm9sbG93
aW5nIGNoYW5nZXMuDQo+ID4+Pj4gVGhlIElPTU1VRkQgcGF0aCB3aWxsIGFsc28gbmVlZCBzdWNo
IGVuaGFuY2VtZW50LiBJIHdpbGwgdXBkYXRlIGl0IGluDQo+ID4+Pj4gdGhlIG5leHQgdmVyc2lv
bi4NCj4gPj4+IFRoZSBvbmx5IHVzZSBmb3IgdGhpcyBpcyB0aGUgUFJJIGNhbGxiYWNrcyByaWdo
dD8gTWF5YmUgaW5zdGVhZCBvZg0KPiA+Pj4gYWRkaW5nIGEgaGFuZGxlIHR5cGUgbGV0J3MganVz
dCBjaGVjayBkb21haW4tPmlvcGZfaGFuZGxlciAgPw0KPiA+Pj4NCj4gPj4+IEllIFNWQSB3aWxs
IHBhc3MgJm9tbXVfc3ZhX2lvcGZfaGFuZGxlciBhcyBpdHMgInR5cGUiDQo+ID4+IFNvcnJ5IHRo
YXQgSSBkb24ndCBmdWxseSB1bmRlcnN0YW5kIHRoZSBwcm9wb3NhbCBoZXJlLg0KPiA+IEkgd2Fz
IHRhbGtpbmcgc3BlY2lmaWNhbGx5IGFib3V0IHRoZSB0eXBlIGZpZWxkIHlvdSBzdWdnZXN0ZWQg
YWRkaW5nDQo+ID4gdG8gdGhlIGhhbmRsZSBzdHJ1Y3QuDQo+ID4NCj4gPiBJbnN0ZWFkIG9mIGFk
ZGluZyBhIHR5cGUgZmllbGQgY2hlY2sgdGhlIGRvbWFpbi0+aW9wZl9oYW5kbGVyIHRvDQo+ID4g
ZGV0ZXJtaW5lIHRoZSBkb21haW4gYW5kIHRodXMgaGFuZGxlIHR5cGUuDQo+ID4NCj4gPj4gVGhl
IHByb2JsZW0gaXMgdGhhdCB0aGUgY29udGV4dCBjb2RlIChTVkEsIElPTU1VRkQsIGV0Yy4pIG5l
ZWRzIHRvDQo+IG1ha2UNCj4gPj4gc3VyZSB0aGF0IHRoZSBhdHRhY2ggaGFuZGxlIGlzIHJlYWxs
eSB3aGF0IGl0IGhhcyBpbnN0YWxsZWQgZHVyaW5nDQo+ID4+IGRvbWFpbiBhdHRhY2htZW50LiBU
aGUgY29udGV4dCBjb2RlIG5lZWRzIHNvbWUgbWVjaGFuaXNtIHRvIGluY2x1ZGUNCj4gc29tZQ0K
PiA+PiBraW5kIG9mICJvd25lciBjb29raWUiIGluIHRoZSBhdHRhY2ggaGFuZGxlLCBzbyB0aGF0
IGl0IGNvdWxkIGNoZWNrDQo+ID4+IGFnYWluc3QgaXQgbGF0ZXIgZm9yIHZhbGlkIHVzZS4NCj4g
PiBSaWdodCwgeW91IGhhdmUgYSBkZXJpdmVkIHN0cnVjdCBmb3IgZWFjaCB1c2VyIGFuZCB5b3Ug
bmVlZCBhIHdheSB0bw0KPiA+IGNoZWNrIGlmIGNhc3RpbmcgZnJvbSB0aGUgZ2VuZXJhbCBoYW5k
bGUgc3RydWN0IHRvIHRoZSBkZXJpdmVkIHN0cnVjdA0KPiA+IGlzIE9LLg0KPiA+DQo+ID4gSSdt
IHN1Z2dlc3RpbmcgdXNpbmcgZG9tYWluLT5pb3BmX2hhbmRsZSBhcyB0aGUgdHlwZSBrZXkuDQo+
IA0KPiBBZnRlciByZW1vdmluZyB0aGUgcmVmY291bnQgZnJvbSB0aGUgYXR0YWNoIGhhbmRsZSwg
SSBhbSB0cnlpbmcgdG8gbWFrZQ0KPiB0aGUgY29kZSBsb29rIGxpa2UgdGhpcywNCj4gDQo+ICAg
ICAgICAgIC8qIEEgYm9uZCBhbHJlYWR5IGV4aXN0cywganVzdCB0YWtlIGEgcmVmZXJlbmNlYC4g
Ki8NCj4gICAgICAgICAgaGFuZGxlID0gaW9tbXVfYXR0YWNoX2hhbmRsZV9nZXQoZ3JvdXAsIGlv
bW11X21tLT5wYXNpZCk7DQo+ICAgICAgICAgIGlmIChoYW5kbGUpIHsNCj4gICAgICAgICAgICAg
ICAgICBpZiAoaGFuZGxlLT5kb21haW4tPmlvcGZfaGFuZGxlciAhPQ0KPiBpb21tdV9zdmFfaW9w
Zl9oYW5kbGVyKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUJVU1k7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+ICAgICAgICAgICAg
ICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgICByZWZjb3VudF9pbmMoJmhhbmRsZS0+dXNl
cnMpOw0KPiAgICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmaW9tbXVfc3ZhX2xvY2spOw0K
PiAgICAgICAgICAgICAgICAgIHJldHVybiBoYW5kbGU7DQo+ICAgICAgICAgIH0NCj4gDQo+IEJ1
dCBpdCBhcHBlYXJzIHRoYXQgdGhpcyBjb2RlIGlzIG5vdCBsb2NrIHNhZmUuIElmIHRoZSBkb21h
aW4gb24gdGhlDQo+IFBBU0lEIGlzIG5vdCBhIFNWQSBkb21haW4sIHRoZSBjaGVjayBvZiAiaGFu
ZGxlLT5kb21haW4tPmlvcGZfaGFuZGxlciAhPQ0KPiBpb21tdV9zdmFfaW9wZl9oYW5kbGVyIiBj
b3VsZCByZXN1bHQgaW4gYSB1c2UtYWZ0ZXItZnJlZSBpc3N1ZSBhcyB0aGUNCj4gb3RoZXIgdGhy
ZWFkIG1pZ2h0IGRldGFjaCB0aGUgZG9tYWluIGluIGJldHdlZW4gdGhlIGZldGNoIGFuZCBjaGVj
aw0KPiBsaW5lcy4NCj4gDQo+IFByb2JhYmx5IHdlIHN0aWxsIG5lZWQgdG8ga2VlcCB0aGUgcmVm
Y291bnQgaW4gdGhlIGF0dGFjaCBoYW5kbGU/DQo+IA0KDQpXaGF0IGFib3V0IEphc29uJ3MgYW5v
dGhlciBjb21tZW50IGluIGhpcyBvcmlnaW5hbCByZXBsaWVzPw0KDQoiDQpUaG91Z2ggSSdtIG5v
dCBjb252aW5jZWQgdGhlIHJlZmNvdW50IHNob3VsZCBiZSBlbGV2YXRlZCBpbnRvIHRoZSBjb3Jl
DQpzdHJ1Y3R1cmUuIFRoZSBwcmlvciBwYXRjaCBJIHNob3dlZCB5b3Ugd2hlcmUgdGhlIGNhbGxl
ciBjYW4gcHJvdmlkZQ0KdGhlIG1lbW9yeSBmb3IgdGhlIGhhbmRsZSBhbmQgd2UgZG9uJ3QgaGF2
ZSBhIHByaXYgd291bGQgbWFrZSBpdCBlYXN5DQp0byBwdXQgdGhlIHJlZmNvdW50IGluIGEgU1ZB
IGRlcnZpZWQgaGFuZGxlIHN0cnVjdCB3aXRob3V0IG1vcmUNCmFsbG9jYXRpb24uIFRoZW4gd2Ug
ZG9uJ3QgbmVlZCB0aGlzIHdlaXJkbmVzcy4NCiINCg0KVGhhdCBzb3VuZHMgbGlrZSB3ZSdsbCBu
ZWVkIGEgaW9tbXVfc3ZhIGxpa2Ugc3RydWN0dXJlIHRvIGhvbGQNCml0cyBvd24gcmVmY250LiBU
aGVuIHdlIGRvbid0IG5lZWQgdGhpcyB0eXBlIGNoZWNrIGFuZCByZWZjbnQNCmluIHRoZSBjb3Jl
Lg0K

