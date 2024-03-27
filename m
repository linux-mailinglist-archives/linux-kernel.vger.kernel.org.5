Return-Path: <linux-kernel+bounces-121469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59C588E853
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEEB2C253F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CA13F424;
	Wed, 27 Mar 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebuCNCTm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8CF1304BB;
	Wed, 27 Mar 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551266; cv=fail; b=Lyx4uJU3r3y9bJcVJOqMHjfPNip15+/zlhB9mdZjfvtaXlK5pV8NRsQDXIHf9uwdoa8+A6IldCyA9EZhND+GKkN5JHS00Od3QlXZUfNn4qA9LdcFXDLt6BMu7thiwppukEEzXm8jQqIrE8xypXWtevBa7ZW8sxgEf41L5S79/iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551266; c=relaxed/simple;
	bh=KreXbNCMKyniovO+nT7P361hCoKKM6ML85pAyWU6Xa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQY29gocAGFm79hJNSBw+gETIDguCr8GpojHO3QvVwT/YJN73Cl2FFijAHRO1a3wbmF41E0pSUoIM2s4D9RjVMP2PK8RkNaowK+08C+KHSo0WhfoMaaaIDeZ37srzGggalVkaqigWzC9lgCQa7CQ9DxT+k9RZjoJnsinZRlLklk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebuCNCTm; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711551264; x=1743087264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KreXbNCMKyniovO+nT7P361hCoKKM6ML85pAyWU6Xa4=;
  b=ebuCNCTmVcKVIAIH/7PRQzm1dfJWpK0yB8ciZM+0t+KNKJp4XoGDqeHy
   KgM14e/E/0z96NRGc1T2qvMxSKWhV2fkjaMNPSEBI7lW0k5oTan5bgeFV
   lZmEwuVx/sKA0STgoqx0RA+D8WZMs/QWupvijoYTdupRu+wFuYU/neTLS
   J3qFJZhAIbTcDJqIw4uRsS7yW+1y3k/C3OVotlL3X5m/2KG+HDaZ41fkE
   sR3jj7cJGrn8MFvi4pYXgeSgUha4PfN5Rw4waARP/VcleTJ4gLDPdb45E
   np6UAbZOz+fKhyj1H7lvpBQs+DlRcmW/g7vKE8bT6R88TaPmiBfmTol06
   Q==;
X-CSE-ConnectionGUID: rYE2ebc3R42gZIT9P79G3g==
X-CSE-MsgGUID: de3qAVFHQ9+eDVeswqLkPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17291980"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="17291980"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16407956"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 07:54:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 07:54:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 07:54:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 07:54:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 07:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD9soMeelQTpSjJmPntzsTqXxyX3asvqhkzNLfRdb3DmXxu68wSX5CcTbVaTJNTgTffTHQzDxRBxxDp9Udw5sMnsYNaAm8aazvyAxNSGT5FlfAARuCLQzFYvIuoA+Qx8IpQVPCPDm2atXAxXwhiMG5NqqakWqq/9BTljlE9Hv9ZyVjPLHVAgR8H9xcEOC32829DfVsLW4dZlUup7H4NVyjZZyG0ZP6FktZ92GGlUyNt9RdL5MdhhWrhGLRS/S48WeX1GrgXfcpxBTJd1KTstQbdOd46mdMQVE1HuLHvQf8tPw6TsjEN4TO/QFI5LHtH+wz4c0VMY6jZAtQYiiSuQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KreXbNCMKyniovO+nT7P361hCoKKM6ML85pAyWU6Xa4=;
 b=LdTcE7Gc0kUkxdSIOnzCdLRMrHinq2U/2mS8Kp6CnFr4+6SXOHT6ApBC5r5ieU4fyiVSHENaFpCq2GDu+lx531ec23Q3wQYDJTPE3A476NKoulNlBz4yh/sjNlOFS5KVAMgMsYsth95W6xJoltIblJDiFXFtp4qi1RnlExmxNsscH8OuRXbykLwPa9CnBPPVEpphsILcBz4yrmNZ92dBEHKF6OphHS8CFMl3ghslGYuC6gWD6itBIhX0j+UNyHqVjDhcGZaakk6wGRtIX+1XnJ4zbN0PsqbO1rKjZvbUi1xCICabUD61aJyX5QuctkVvW0dfFbzGtm7tATla3qIc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 14:54:09 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 14:54:09 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@google.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Fijalkowski,
 Maciej" <maciej.fijalkowski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [xdp-hints] Re: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware
 timestamp request for AF_XDP zero-copy packet
Thread-Topic: [xdp-hints] Re: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware
 timestamp request for AF_XDP zero-copy packet
Thread-Index: AQHaf1vDcRX66gQlB0+gJtjiHFgRbLFJ/peAgAAUiKCAAV/bgIAAN/Jw
Date: Wed, 27 Mar 2024 14:54:09 +0000
Message-ID: <PH0PR11MB5830C7CC397B0B5CB1CB34ECD8342@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240325020928.1987947-1-yoong.siang.song@intel.com>
	 <d2623ac0f1cb07a23976416cdcf9eee1986747b0.camel@siemens.com>
	 <87h6gtb0p0.fsf@kurt.kurt.home>
	 <PH0PR11MB583028B2023E1E809B45B51DD8352@PH0PR11MB5830.namprd11.prod.outlook.com>
 <ab114fcc84c50723bb88d40ccbbeedf7b48dbe0e.camel@siemens.com>
In-Reply-To: <ab114fcc84c50723bb88d40ccbbeedf7b48dbe0e.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DS0PR11MB8135:EE_
x-ms-office365-filtering-correlation-id: 1aa7869a-9cd6-4c3a-6d7d-08dc4e6dc255
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3nynhD8Gnn5C1c9Og4CoTNeJDcjqtmmm4Hw+2Kjsw9pWa2ho0XZ18aBscGCTzw348C7TC7zqPe4+njX5O7htEXpDCc0vkUUlM8fssV0gVR5LhiQ5Rblrgq0Tx+QCW+g+GHcsfe5WYzVHmS1YdBBwtO5dST4mzEmnjE3v68z7sy+JMUdmm6d49BC1PJMRZ2i4/8nfV+OzgpFBtNfk9VuT40+K0yZILFh+6RGWiv3DwYL5swp6MYxev6W022FCU9/6x6ydFYAx6usO8jKnLTFPCLBk6nKHpvMh84GkcECNzyaeaMOoypRF8PG4KJixMeoBW7gFDA2HKNNJ/PypdboZgPaN2/3u3x61SFHPAd87iM0xtdhiv5gfex7MFWgk4L3NemL65CDLmUFLv7HXIRmSnF8ycTlf7peHtrHAkcbSHpNY9tTu0cvynCWnk00HHfqPqVUdGg217xR2WxEop4Yb7b+6YuenIGPd46EoaX9tdfhtjh34BFnWMo3NXDkSXYOMiuPxiVUbBFgCw25bRNpZHnDL3IXZxGcroSkl81qnJKNzQ/Hfc8tQCmN8VMlybbkt36Mb/lBmpTGqLpuTv2EH+U7w+uX3Fjzkz5Y5kHggwlewqT68/7F7ndewrs69FzO5hflxaPCfP6BpsmFwgHjs93Buzjmp1vb7bSjY6dagT5hvI1Xjvd+gsJqwXr9vXEC2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkhkaDFZbElUNmRIYjBNYS9jS3JmR1JFVzhBTGd5MFZOMlIzM2VEcGs0dERE?=
 =?utf-8?B?aXhmQWFzakpEb29BbEo0T2lmZExjRlF0SWVQdm1uVFQrcytDWXlBMENMSDFw?=
 =?utf-8?B?dk9FMDhqSEk1djRjekI1akNXbDAzSW4rMkgxWHB1WEl0b3ovZm5VTFQyaUFy?=
 =?utf-8?B?UUVUaS8wYllrNlNuQ0JkZTlSME5LUzkzMkxDN3Y2U3hoZ2hKMzkrSE1QK1ZV?=
 =?utf-8?B?dTBWMFlvbCtqVHFMMDJNRFJPeTE0R2wxK0FXbE1Cb016YWxHWVhRSlV3cU53?=
 =?utf-8?B?cHMxbWxKTm5wV05LS2VCbUxZMEgwWkpRQ1VLbC9WSlRPRlBBaStKMFdyNTla?=
 =?utf-8?B?NC8wRWNrazVqYnZlejBaQzJFL1plb2hDdEpJM2lGNC9iVExPcUdIQUFQU1hJ?=
 =?utf-8?B?cmlwdnJST0FLTVgwb1lKQUtLVkxla0g5ME0rd3hJQ0drRW5ZSTRxLzBwMU40?=
 =?utf-8?B?dUYwNnJqa1Z2VDB1c0lhZWg4VUIyZ0E1WG9NY0d1cUNGRGkzZVNVRTRDZzUy?=
 =?utf-8?B?Q2JVWWRkNk9VbkhTLytvRThDWWdISTErdHFtK3lNUlVVamxGaUEvZ0doZ0Vv?=
 =?utf-8?B?UkdESFloT2Vab2NSVTFCWFVWUS95SVA1bHlEU3RzdWJlaVRVc3hWcDIwWXgr?=
 =?utf-8?B?dUQxTjgrZ3RKcmZZcGk4SVhsQzIvNkczaS9rWDB1VDZDYmVBSUlqdDltZ3Vx?=
 =?utf-8?B?cnlodFU2bTUyNCtZNU1yckxQSlJPczRUbEFHdWhabCtjWGhKVnNkTGg4Uk92?=
 =?utf-8?B?K1VzdUU2Q0d0V3p6eDVHWUI0dzI5czBzdnZiNU8xdzlMTkowU0prN2hPci9K?=
 =?utf-8?B?WHQ3M3NTa2pzK2NxbjdNM1dKYmlMSzE5dDFJN1FZMUtveEJjOWFwMSt4OGZJ?=
 =?utf-8?B?QmtKZHJ2TDZUbWFGTVBPdHV4U1gveWZFemdtdTN4cUdVMTBrMVowVXpyQkZD?=
 =?utf-8?B?eHBKbCtMd2dSdDc3T2d3TE02QTg0bVBOZEhKQ0VzU0p2MGxNcWZwbmxIeXls?=
 =?utf-8?B?MmNqS3I5UmFaZGpEZG9aNjRod0U4UDF1OTNUZmFuQWVEK1FyZ2MycGVjVWRK?=
 =?utf-8?B?OU12RTVDRHNGV1FvNTByVnd5R21Md3orZ3V2cFROVHM2YTNwd3RCU2NuM043?=
 =?utf-8?B?YjBZTHY5VUNqK1pCNmFGYUlzOTduV0xvSVhJU1JhOHliTjBkSWhvT1RBcUFh?=
 =?utf-8?B?ZjN1QzYybXMvdXo5bkFzbW1sVDNkMG9GZDl6ZDQ5S09RN0pyK1lOUmFpTVhm?=
 =?utf-8?B?NjN5bGxBYkVrTy9jL3RkeWxCZGdMaXdoTUFjNW1zUFQ3bFBKdkNBY3VleDBK?=
 =?utf-8?B?RHhqd1A3bDVicjJzTTRBR0RiNzFTN2NEeG1qbWN4M1hKbXowVWFoVHp2SG1T?=
 =?utf-8?B?Q1RyNzN5dUVpS2E1L0l5WFlXaDI5cUI3ZU1tNTZJcUJWaG91V0Z5c0lObXBt?=
 =?utf-8?B?ZHd4UllFMm1IbUM0YmJOS0hML3k2WG5VdmVMakp0R0lKK0VPa0N5UVU1dUwx?=
 =?utf-8?B?Mis3T0pXa3dUS2l0Q29nZmpFdFVJZWkyM1RsQUVUMHBGd2xOVEtud2p4QWxP?=
 =?utf-8?B?VVpwOVdNMlF3UVU5OXZIRWN0dVRQYnNxbDFCSWgraVNVUWFqdTFCQkdyemxt?=
 =?utf-8?B?NDhMUENka09yNm5SMEVKWkVQRnFwSUxKRFlib0RkalpVdUxHR3NNRzRINERR?=
 =?utf-8?B?VytRQVhEbjNpcktGaG5YVlVXRUllbk45ajB6T0loaXEza0tmMTZHalFLL1NP?=
 =?utf-8?B?aEhmSHZGYlA0Mm5QQVRESHdTNW5BVkNHZllBOXgwaFQ3Q1lmQmIvSy9zRjJ1?=
 =?utf-8?B?dGRyNjI3VzB4M3EwK0NQdUxjY1grNk0wT3JCMmE0K3JUb0JJSXpQQUJ1TkEy?=
 =?utf-8?B?VmxUbXIvMk8wNm9oUW5GeUVmclBicVVPUzBwSGlDY1RqdzMya0M1dyttYzFt?=
 =?utf-8?B?VUpDY1pXOHBDUXQ3L05YN2d3VXRpY1RENURsMVl1T2FEcjVxL1F6RHc2ckpw?=
 =?utf-8?B?VFhFSTFCR0R4bmtDREtrR040QXlWRmtMMlJabk1qWEpFc3hBcWJra3I0aWRW?=
 =?utf-8?B?b0FFQ29mS0d0SG04V09FeFJUWUdQY3dPaEVpaTN4RmRLSXdsSHp2aitsaG1F?=
 =?utf-8?B?b1JlOCtzU3FYYVlHNWszbFQwWjVldTBYYWE1ekJHSThIZEd1NlVGbWFIOXN6?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa7869a-9cd6-4c3a-6d7d-08dc4e6dc255
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 14:54:09.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFbeKMGaJ8aJtrVieNuAAGRsy4RLIamPnabAJK9KH/HanQaqXnUfItGbfsxsUCyzLC/+rTkO/aOKXTC/F4RLx2AIRtfg1CJdEi40mdRD9Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBNYXJjaCAyNywgMjAyNCA3OjIxIFBNLCBGbG9yaWFuIEJlemRla2EgPGZs
b3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+T24gVHVlLCAyMDI0LTAzLTI2IGF0
IDE0OjU1ICswMDAwLCBTb25nLCBZb29uZyBTaWFuZyB3cm90ZToNCj4+IE9uIFR1ZXNkYXksIE1h
cmNoIDI2LCAyMDI0IDk6MDggUE0sIEt1cnQgS2FuemVuYmFjaCA8a3VydEBsaW51dHJvbml4LmRl
PiB3cm90ZToNCj4+ID4gSGkgRmxvcmlhbiwNCj4+ID4NCj4+ID4gT24gVHVlIE1hciAyNiAyMDI0
LCBGbG9yaWFuIEJlemRla2Egd3JvdGU6DQo+PiA+ID4gT24gTW9uLCAyMDI0LTAzLTI1IGF0IDEw
OjA5ICswODAwLCBTb25nIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4gPiA+ID4gVGhpcyBwYXRjaCBh
ZGRzIHN1cHBvcnQgdG8gcGVyLXBhY2tldCBUeCBoYXJkd2FyZSB0aW1lc3RhbXAgcmVxdWVzdCB0
bw0KPj4gPiA+ID4gQUZfWERQIHplcm8tY29weSBwYWNrZXQgdmlhIFhEUCBUeCBtZXRhZGF0YSBm
cmFtZXdvcmsuIFBsZWFzZSBub3RlIHRoYXQNCj4+ID4gPiA+IHVzZXIgbmVlZHMgdG8gZW5hYmxl
IFR4IEhXIHRpbWVzdGFtcCBjYXBhYmlsaXR5IHZpYSBpZ2NfaW9jdGwoKSB3aXRoDQo+PiA+ID4g
PiBTSU9DU0hXVFNUQU1QIGNtZCBiZWZvcmUgc2VuZGluZyB4c2sgVHggaGFyZHdhcmUgdGltZXN0
YW1wIHJlcXVlc3QuDQo+PiA+ID4gPg0KPj4gPiA+ID4gU2FtZSBhcyBpbXBsZW1lbnRhdGlvbiBp
biBSWCB0aW1lc3RhbXAgWERQIGhpbnRzIGtmdW5jIG1ldGFkYXRhLCBUaW1lciAwDQo+PiA+ID4g
PiAoYWRqdXN0YWJsZSBjbG9jaykgaXMgdXNlZCBpbiB4c2sgVHggaGFyZHdhcmUgdGltZXN0YW1w
LiBpMjI1L2kyMjYgaGF2ZQ0KPj4gPiA+ID4gZm91ciBzZXRzIG9mIHRpbWVzdGFtcGluZyByZWdp
c3RlcnMuICpza2IgYW5kICp4c2tfdHhfYnVmZmVyIHBvaW50ZXJzDQo+PiA+ID4gPiBhcmUgdXNl
ZCB0byBpbmRpY2F0ZSB3aGV0aGVyIHRoZSB0aW1lc3RhbXBpbmcgcmVnaXN0ZXIgaXMgYWxyZWFk
eSBvY2N1cGllZC4NCj4+ID4gPg0KPj4gPiA+IExldCBtZSBtYWtlIHN1cmUgdGhhdCBJIGZ1bGx5
IHVuZGVyc3RhbmQgdGhhdDogSW4gbXkgb3duIHdvcmRzOg0KPj4gPiA+DQo+PiA+ID4gV2l0aCB0
aGF0IGFwcGxpZWQgSSdtIGFibGUgdG8gZ2V0IHRoZSBwb2ludCBpbiB0aW1lIGZyb20gdGhlIGRl
dmljZQ0KPj4gPiA+IHdoZW4gYSBzcGVjaWZpYyBmcmFtZSBtYWRlIGl0IHRvIHRoZSB3aXJlLiBJ
IGhhdmUgdG8gZW5hYmxlIHRoYXQNCj4+ID4gPiBmdW5jdGlvbmFsaXR5IHVzaW5nIHRoZSBtZW50
aW9uZWQgaW9jdGwoKSBjYWxsIGZpcnN0LCBhbmQgdGhlbiBjaGVjaw0KPj4gPiA+IHRoZSBtZXRh
IGFyZWEgKGxvY2F0ZWQgaW4gdGhlIHVtZW0gcmlnaHQgYmVmb3JlIHRoZSBmcmFtZSBwYXlsb2Fk
KQ0KPj4gPiA+IHdoaWxlIGNvbnN1bWluZyB0aGUgY29tcGxldGlvbiBxdWV1ZS9yaW5nLiBDb3Jy
ZWN0Pw0KPj4NCj4+IEhpIEZsb3JpYW4sDQo+Pg0KPj4gWWVzLCB5b3UgYXJlIHJpZ2h0LiBCdXQg
YmVmb3JlIHlvdSBwYXNzIHRoZSBmcmFtZSB0byBkcml2ZXIsIG1ha2Ugc3VyZQ0KPj4geW91IHJl
cXVlc3QgVHggbWV0YWRhdGEgaGFyZHdhcmUgdGltZXN0YW1wIGZlYXR1cmUgYnkgc2V0dGluZw0K
Pj4gWERQX1RYTURfRkxBR1NfVElNRVNUQU1QIGZsYWcuDQo+PiBZb3UgY2FuIHJlZmVyIHRvIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYw0KPj4gb24gaG93IHRv
IGRvIGl0Lg0KPg0KPkdvdCBpdC4gVGhhbmtzIQ0KPg0KPj4NCj4+ID4gPg0KPj4gPiA+IElmIHNv
LCB3ZSBub3cgaGF2ZSBhIGZlZWRiYWNrIGNoYW5uZWwgZm9yIG1ldGEgaW5mb3JtYXRpb24gZm9y
L2Zyb20gVFguDQo+PiA+ID4gQXJlIHRoZXJlIGFueSBwbGFucyAtIG9yIHdvdWxkIGl0IGJlIHBv
c3NpYmxlIC0gdG8gc3VwcG9ydCBFYXJsaWVzdA0KPj4gPiA+IFR4VGltZSBGaXJzdCAoTkVUX1ND
SEVEX0VURikgUURpc2MgYmFzZWQgb24gdGhhdCBjaGFubmVsPyBJbiB0aGUgcGFzdA0KPj4gPiA+
IHdlIGhhZCB0aGUgcHJvYmxlbSB0aGF0IHdlIHdlJ3JlIG1pc3NpbmcgYSBmZWVkYmFjayBjaGFu
bmVsIHRvDQo+PiA+ID4gY29tbXVuaWNhdGUgYmFjayBpbnZhbGlkIGx1bmNoIHRpbWVzLg0KPj4g
Pg0KPj4gPiBKdXN0IGFza2luZzogSG93IHdvdWxkIHRoYXQgd29yaz8gQUZBSUsgWERQIGJ5cGFz
c2VzIHRoZSBRZGlzYw0KPj4gPiBsYXllci4gQ3VycmVudGx5IGludmFsaWQgTGF1bmNoIFRpbWVz
IGFyZSBhY2NvdW50ZWQgaW4gdGhlIEVURiBRZGlzYw0KPj4gPiBpdHNlbGYuIERvZXMgdGhhdCBt
ZWFuIGV2ZXJ5IGRyaXZlciBoYXMgdG8gdGFrZSBjYXJlIG9mIGl0Pw0KPj4gPg0KPj4gPiBUaGFu
a3MsDQo+PiA+IEt1cnQNCj4+DQo+PiBGbG9yaWFuICYgS3VydCwNCj4+DQo+PiBZZXMsIG1lIGFu
ZCBTdGFuaXNsYXYgYXJlIHRyeWluZyB0byBhZGQgRWFybGllc3QgVHhUaW1lIEZpcnN0IC8gTGF1
bmNoIFRpbWUgdG8gdGhlDQo+ZnJhbWV3b3JrLg0KPj4gUGxlYXNlIHJlZmVyIHRvIFsxXSBmb3Ig
dGhlIHBhdGNoc2V0LiBUaGUgbWV0YWRhdGEgZnJhbWV3b3JrIHdpbGwganVzdCBwYXNzIHRoZQ0K
Pj4gTGF1bmNoIHRpbWUgdmFsdWUgdG8gZHJpdmVyLCBhbmQgZHJpdmVyIG5lZWQgdG8gaGFuZGxl
IHRoZSByZXN0Lg0KPj4gSW4gdGhlIHBhdGNoc2V0LCBJIGFtIGVuYWJsaW5nIGl0IG9uIHN0bW1h
YyBkcml2ZXIgb25seSwgYnV0IHdlIG5lZWQgbW9yZSBkcml2ZXJzDQo+PiB0byBjaGVjayB3aGV0
aGVyIHRoZSBkZXNpZ24gaXMgZmVhc2libGUgZm9yIGRpZmZlcmVudCBkcml2ZXJzLCBjYXVzZSBl
YWNoIGRyaXZlciBpcw0KPj4gaGF2aW5nIHRoZWlyIG93biBsaW1pdGF0aW9uIG9uIGxhdW5jaCB0
aW1lLiBUaGVyZWZvcmUsIGFmdGVyIHRoaXMgdHggaHd0cyBwYXRjaA0KPmFjY2VwdGVkLA0KPj4g
SSB3aWxsIHRyeSB0byBlbmFibGUgbGF1bmNoIHRpbWUgb24gaWdjIGRyaXZlciwgYW5kIHN1Ym1p
dCBuZXcgdmVyc2lvbi4NCj4NCj5OaWNlIHRvIGhlYXIhIEtlZXAgbWUgaW4gdGhlIGxvb3AgYW5k
IGxldCBtZSBrbm93IGlmIEkgY291bGQgc3VwcG9ydA0KPnNvbWVob3cuDQoNClN1cmUsIHdpbGwg
a2VlcCB5b3UgaW4gbG9vcC4NCkRvIHlvdSBtaW5kIHRvIHNoYXJlLCB3aGljaCBFdGhlcm5ldCBk
cml2ZXIgeW91IGFyZSB3b3JraW5nIG9uPw0KDQo+DQo+Pg0KPj4gS3VydCBpcyByaWdodCB0aGF0
IGN1cnJlbnQgbWV0YWRhdGEgZnJhbWV3b3JrIGlzIGxhY2tpbmcgYSB3YXkgdG8gZmVlZGJhY2sg
d2hldGhlcg0KPj4gdGhlIGxhdW5jaCB0aW1lIGlzIGludmFsaWQgb3Igbm90LiBNYXliZSB3ZSBj
YW4gdHJ5IHRvIGVuYWJsZSBsYXVuY2ggdGltZSB3aXRob3V0DQo+ZmVlZGJhY2ssDQo+PiB0aGVu
IGRpc2N1c3MgYWJvdXQgdGhlIHN0YXR1cyByZXBvcnQgZGVzaWduLg0KPg0KPkluIGNhc2UgdGhl
IGxhdW5jaCB0aW1lIGlzIGludmFsaWQgLSBjb3VsZG4ndCB3ZSBzaW1wbHkgc2tpcCB0aGUgZnJh
bWUNCj5hbmQgImZvcndhcmQiIGl0IGJhY2sgdG8gdGhlIGFwcGxpY2F0aW9uIChjb21wbGV0aW9u
IHF1ZXVlL3JpbmcpIGFmdGVyDQo+YWRqdXN0aW5nIHNvbWUgbWV0YS1pbmZvcm1hdGlvbiAobGlr
ZSB0aGUgVFggdGltZXN0YW1wcyBpbiB0aGlzIHBhdGNoKQ0KPnRlbGxpbmcgdGhlIGFwcGxpY2F0
aW9uIHdoYXQgaGFwcGVuZWQ/DQoNCkkgbm90IHN1cmUgd2hldGhlciBkcml2ZXIgbGV2ZWwgbmVl
ZCB0byBkbyB0aGUgdmFsaWRhdGlvbiBqb2IgZm9yIGxhdW5jaCB0aW1lLA0KT3Igd2UgY2FuIGp1
c3QgbGV0IHRoZSBOSUMgYmVoYXZlIGFjY29yZGluZyB0byBpdHMgb3duIGRlc2lnbiwNCndoZXRo
ZXIgaXQgd2FudCB0byBkcm9wIHRoZSBwYWNrZXQsIG9yIHRyYW5zbWl0IHRoZSBwYWNrZXQgaW1t
ZWRpYXRlbHksIG9yIHRyYW5zbWl0IHRoZSBwYWNrZXQgYXQgbWF4aW11bSBzdXBwb3J0ZWQgbGF1
bmNoIHRpbWUuIA0KV2UgY2FuIGRpc2N1c3MgZnVydGhlciB3aGVuIEkgc3VibWl0IG5ldyB2ZXJz
aW9uIG9mIFsxXS4NCg0KPg0KPlRoYW5rcyBhIGxvdCENCj5GbG9yaWFuDQo+DQo+Pg0KPj4gWzFd
DQo+aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9jb3Zlci8y
MDIzMTIwMzE2NTEyOS4xNzQwNTEyLTEtDQo+eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20vDQo+
Pg0KPj4gVGhhbmtzICYgUmVnYXJkcw0KPj4gU2lhbmcNCg0K

