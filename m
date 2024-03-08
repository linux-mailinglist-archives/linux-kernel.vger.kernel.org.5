Return-Path: <linux-kernel+bounces-97483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB373876AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF224B21364
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5175E2C6B2;
	Fri,  8 Mar 2024 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0xe+UAS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3851E499;
	Fri,  8 Mar 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923853; cv=fail; b=shIAyIJ6KXRljdbHWxJdZ8H/NphAANTXyLyK3LoK7f61jO7kh5vBAZ2rc8X47hpp3F3QNTb3meMup+CMKVtn23VOoUYHTkIBH4R2wuHOevTqxM+mLRWj07nckPStusaY1HAm6Af2iaUd3bhinpBOJsKIv1a1kzQvOXiEvc/2DhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923853; c=relaxed/simple;
	bh=vrIhIcJUP+pUCh6UVqZCs/tpGIuU2AtGzGMjHYZqd8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LK4aPd1bozjejsAjQ3R3QWOG4tt9pLebwJToouVr7uWDWqxz9/FdIMs4AeXNVBuOOB54GnVUvqvH3AthEHoYha5CP0dMkIlg8xzvH2q2wvXq8P46SBfH2DZuS2r+/DSRFC+ulZII3I3GKidCJO2YJiKV3xcty25qpOr+rqBNGFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0xe+UAS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709923852; x=1741459852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vrIhIcJUP+pUCh6UVqZCs/tpGIuU2AtGzGMjHYZqd8Y=;
  b=U0xe+UAS8pcAdrIw87HXkI4hBut0+vZ5x8P1//CzXk6Hy/+Dd/b6Yd3s
   kLSl1PNJgvc2J76TvKOx4tFBbE0zAFxprIYBvVaeRuNyxnTdFqJy4cfaH
   +MHRUBhFW0zbYFE7Ix/yg6sSlBuNB4opeoLBAxt9WkwpKx0dEbixtIFtV
   ARG2mloMr2z/4yEk9XwEe7aUIw9QCgybMS5N0/eEXnQfXxntbhDtKmyfe
   OweyZr4CL++c48BDkZSPOV80f0FtZKS2TIDCs/OqFZWNnlQBZzDGeS6mr
   +WywYZf7fqikrZDct83HDreLlX6JPwQeo3bMDTSBsxdU68RfZPN7IhCFh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="16087048"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="16087048"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 10:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="10459084"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 10:50:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 10:50:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 10:50:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 10:50:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 10:50:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP1dM14PQcwG9K3VqvIF4XkYm4/oBX782lWHb9RaZRealvfEoWaI/hfKaX/GXWX0cKDX9JrZXY43xjFN+3TcCZsAD4eQVWNEgSocsBC2r65hVd/ML3VJixOsIu9Oa4fjbE4VF7LkqRxwIRylq5J21zkAqJ/O2IhLBs97ZjRYz0JKbVZTb+BzsiuAZrGF40NCVMKIVhafKJgSZDVdToIamtVhSYIahw1K4utPnoDiJNYc1GK0k9u2mhs0mC70RV6xZG1F/H+EqNZcmQDi8OUquDOsFS/VIq9Ff/qIDcc492kh99rM2MOyuG+PfITe7R6ZPPdFFKtPfhaF8Aj3AWpZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrIhIcJUP+pUCh6UVqZCs/tpGIuU2AtGzGMjHYZqd8Y=;
 b=eDH9aN8F9+DJRxR1UedZLlGG7pFilHC+/ILCBMuRte9x1c2+KZbfZkp7Nl3Pg5+GW7lnQT35WTs+vhV/MKCLlb6F4yU6BoUnCCjWvpjou8RhvTlw8FjGgz+QhKF/ap3hPcLbFoOD7NadkuqgfFSSGCXDDapZO2E0qRj+y8qpQaeSYv/ZMnH0ynYh0qyuvX/k7Jnt5D9pySHzeKEUjQvuwTpl23YTTGmHLII3DzM300TxN6m9WOdnHlF7/T/tuig1hcttdG1wcPLroibii8Fi7k5DT80O24sOJP/Wa0cCq02x7LFzypNsb6BlmAmSFOFrx6Q7FZL4uYSkJP9vsYD+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 18:50:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%4]) with mapi id 15.20.7386.009; Fri, 8 Mar 2024
 18:50:42 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Thread-Topic: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Thread-Index: AQHaan2PyoBPXNeezkGw1htb4OlYn7EuN2sAgAAFmUA=
Date: Fri, 8 Mar 2024 18:50:42 +0000
Message-ID: <SJ1PR11MB60837F47723BE9B41B1F05E8FC272@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
 <26f23ba4-4ca5-41f6-b920-08515f494ae5@arm.com>
In-Reply-To: <26f23ba4-4ca5-41f6-b920-08515f494ae5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6437:EE_
x-ms-office365-filtering-correlation-id: 13cb6937-c07d-422f-04d9-08dc3fa0a7d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCqN1IZjREjljETt0rLmENxCBn66QMb381yYQ6dRqgTC/qxPESEm4QkwbKNxOMYMVNEceXLrQXTA1dhnMqGMVtG1wahYIgVXy76uS4zXZS2nyYXenca+wxu9P+/3/liiNGHDr5zleeZlFwTKLhsjr0JqJrWzYOwLjG0jBxOaT8ZHaSDdjBEF0EMLhY3dz/Y74xyL2y1Ntsb6kLf8UH9s+1yOXd3kd543kaQpvWwuRDNnMEyaTV1sDwP4HoIaowxlNgbC96FGmNHU8xRUOiHJ8us1EB343bWNs0QNpOqJq9tRkKduOdx8aZLPpFMy+sSMsRYWsot0ngSUrWp0FdbcV0rUPc+YQaf69HJ0dOjCQyWBFuL22qQTxMDGAY0Yk9lQ5utGnt3uOCYc+BOnqDEPfoFFYRNX/L8AveT196vp42PFTmnw+ChxXsfhFE/Kxy6aSa6t1AgySiirhke30QBUreMdnQoe7a0i726fJLAmFxU9RZSmG5PIJ/0B1/GTyT5chqFaQrdfnnuUpSgggYHe5aGE8CaTTMIUdESmvKa4W2dyDpj8Y3siin5h3v3u/ejVyW82PG/i9DF0A08FaPVc8doM/cyx0rm4vyChgbDeod83mhCjtoGZyq7PiEgupMo/M1bDkWWfEtrx7kp2k+jQXxWU7gOQ9pSi19EQ7Fe59FwaINgix74mFu/99VbTe+OezNy8nVYiin60sDlG/MkEn9X/eJg2xrmMuBiHVMvHnpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFPcW1zS2xkK0w2R1cwMXZCSkJmOWl3Q3VsdHdTWStPTno5K1BkMTVROXpF?=
 =?utf-8?B?dWZSQ09nOXp6aU5DRndKYk1kSG1VT0xiU1FTTzdabzhUQS81M2dUSDE0YWN5?=
 =?utf-8?B?eG9rbFYxSlpRbDVTYVpFK05JRUhBRUgwa3ZVY3lwQ2EweEsraDliRGxlaUhs?=
 =?utf-8?B?S3pzWXhsN1cyQXlGVGVVMU5GZjJDR1lCaExHSzUwbEc1dDhWNXpHUG9DaEpE?=
 =?utf-8?B?WDlQZCs4OWFadGQ4VmxsOGJJdW96aHpuNXdUV3MyY0k5QmVpTnRBbmVab2xl?=
 =?utf-8?B?Wi84L216cFp1ejU3eXprMlQwZUxQU01Xank4TndCc1FZRjFpUm16azFyMzJ5?=
 =?utf-8?B?WnB6dGxnQUVMSUdheE0vQ21ZTnhQVm1sbStJOTVRbVVrKzhtRVQxYStCeDds?=
 =?utf-8?B?QVdmZzEzaTlvQzhFSXcwcWFDbThobTZsQ2I5c0ZUQUVZeUozQ0grckwwNFFG?=
 =?utf-8?B?cUsxTStnbmR2MHVlcWVCSGRvVTg1ZHJQVXQvR0NBK3VYc1UyQnVtNkpOaGZ0?=
 =?utf-8?B?TngwYk0yZHR2TUZFM2dEYy9DYmlqM0ZlamUvc25FZEZLSVR2RGZzUDFFc3BG?=
 =?utf-8?B?WHN1bGNlQ05rZVcvOHpWeGlPSkQ5djZsNGdicjNMQlJHdzg1b1EyL29IMnh1?=
 =?utf-8?B?TGMwN25TbzRJQXlmUVB3K1VKWjV1a0ltSCtwc1ZuNmgyT3ZERDNQZ0V2WjlD?=
 =?utf-8?B?M2JYQ2FIbFI4UlBGYmNFdExzdlJ1cmZQeS9xVUZZMWs2aUZiTU94dWV0WDJ5?=
 =?utf-8?B?T2FkU1lDc2FnWEsyTFRDemovSTh6WFB3cXM5RTgvUXZSSE9saVdCQnAxOTBl?=
 =?utf-8?B?WGhiUTQvaE1XTmhyMzNjaU9TaktFZk5IdkV4TFNETVgrZGVBUlRPSzF0U3lC?=
 =?utf-8?B?U0VmVGsyaGpuRVNhQTNNTnB0bk9JMVhETDhGNWlySDl0cWZBekVUNFFubFd5?=
 =?utf-8?B?d0JJV25mdkhNRnA4bUtPVjgyV3RYZklzekZRWk9wSEkvYWZ1WGRpUVpTeWJr?=
 =?utf-8?B?dkdNOUNac1pGNGpTTzh1NGJwRUZLMU9YTUh3Q1p3OEg0NTV6S0pRWHhNSFRv?=
 =?utf-8?B?cVIwNWxna0RSNnhEeTNzZnhxeXZEVUNwRnEzaWM4ZEFsdWNRZEtjeXFDaWJM?=
 =?utf-8?B?a0FhN1d6bTcvbkY3enFiV1JySWF1Zm1HZFROeVZ1dDY0UkRhMXo0KzRRcG1B?=
 =?utf-8?B?c3JQUlJUeGxnclJqa2NwOGtKNnRxUDMvajljckxKZjJ4WW10YkY4MklyYmZF?=
 =?utf-8?B?eEpHTmNOanpPTm82YkNwZ3lKV2kwWnVVUTFhYy85NExBa1FmSkE4SDBtUTJp?=
 =?utf-8?B?enFCVi9ReFBia0F5MmxSWXB5aDVOMjZnTk0wZUlSTU8zWlV5eFlwdmh6U0dK?=
 =?utf-8?B?NW5BT29CUHBvR2xDSjQxdXJzcUtBQTJmdjh5RU5mZVZjQ3RvNkVocjdKVG1C?=
 =?utf-8?B?ZGNEZkgvWDA5VS9PcmpUd0xtM3p6cTd5dEg1MDVVeEdOSmlwWDRxamRtTFJ4?=
 =?utf-8?B?NHlNbVBUSXlqWERqanJGWHdsZnQrYTBFSTZodWx5QWZ1RGUrSnZzeXNQbW11?=
 =?utf-8?B?dkxacmp1dUhPZkZZc1ZBNWI0RDlOUlpZZi9Vc2MrY0plckpnK2NmeUhBK2pH?=
 =?utf-8?B?UDVUeEFKUUIvWE5DRy9YcWx6TEpUOVdnWWRJTExvd3F2UExIOG9nUk40Ukt4?=
 =?utf-8?B?NEdPN3hSQzVoT2J2aWVkQkc5czJkbWZqM0JTenBHcERGME9xZUhQNWt2ZUZ0?=
 =?utf-8?B?UDlTWEJvR3dxTHF4TnZULzU1RjhFT3RtTUN5b0NJRFJIRE9NekNkVVFtaW93?=
 =?utf-8?B?b1JvaEdWU0puNEIzRDlGRDN3dnV3bXJXVnFsTy9wZGM0Skx2Sjd1dmlySFZP?=
 =?utf-8?B?OEMyV0FaU3E5dGtqWnVFSHNDdXRwOVdDdW1tVUJmMWJHNE5VeU5JM0pieHhy?=
 =?utf-8?B?eUhvNGZ6bEk2V0FqWnBFZHFWbHRKMW9zdTBrSG1OTVNnVjNFNjMwSmRrQlU5?=
 =?utf-8?B?ZkJub3JMVWhiQkE2Q3FSL3RaT1lCZm1wZXB0WktEbUxjTk5yTldJemZvcHdT?=
 =?utf-8?B?V0gyeWp5Mjg0SHB1VFVzbjVaUFhsQVArL2YzbjVLNFdJNVc1Q1o1Yk8xb3Jo?=
 =?utf-8?Q?1HCeLOL/un3jbElrMwz5zKB2p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cb6937-c07d-422f-04d9-08dc3fa0a7d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 18:50:42.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RayLcuLSjEu86VFwbQ3SfUBX+h5xpRBCN4HK4+AjjHgi4ziaWHIWs/i3EIVcamzoqVl7pzzpchqK9E+lqoOinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com

PiA+ICsgICAgICAgICAgICAgICAgICAgaHdfZG9tLT5jdHJsX3ZhbFtpZHhdID0gY2ZnLT5uZXdf
Y3RybDsNCj4gPiArICAgICAgICAgICAgICAgICAgIGNwdSA9IGNwdW1hc2tfYW55KCZkLT5jcHVf
bWFzayk7DQo+DQo+IElmIHRoaXMgQ1BVIGlzIHBhcnQgb2YgdGhlIGRvbWFpbiwgdGhlbiBjcHVt
YXNrX2FueSgpIGNvdWxkIGNob3NlIGEgZGlmZmVyZW50IENQVSBsZWFkaW5nDQo+IHRvIGFuIElQ
SSwgd2hlcmUgdGhpcyBDUFUgY291bGQgaGF2ZSBkb25lIHRoZSB3b3JrIGl0c2VsZi4NCj4gc21w
X2NhbGxfZnVuY3Rpb25fYW55KCkgaGFzIHRoZSBsb2dpYyB0byB0cnkgYW5kIHJ1biBvbiB0aGlz
IENQVSBpZiBwb3NzaWJsZS4NCj4NCj4gQXMgZC0+Y3B1X21hc2sgaXMgc3RpbGwgdmFsaWQgd2hl
biB5b3UgY2FsbCBzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUoKSwgY291bGQgd2UgdXNlDQo+IHNt
cF9jYWxsX2Z1bmN0aW9uX2FueSgpIGluc3RlYWQ/DQoNCkknZCB0aG91Z2h0IHRoYXQgY3B1bWFz
a19hbnkoKSB3YXMgc21hcnRlci4gQnV0IEkgc2VlIHRoYXQgaXQgZHVtYmx5IGp1c3QgcGlja3Mg
dGhlIGZpcnN0DQpDUFUgaW4gdGhlIG1hc2suICBHcmVhdCBzdWdnZXN0aW9uLCB3aWxsIGFkZCB0
byBuZXh0IHZlcnNpb24uDQoNCj4+IC0JCWNwdW1hc2tfc2V0X2NwdShjcHVtYXNrX2FueSgmZC0+
Y3B1X21hc2spLCBjcHVfbWFzayk7DQo+PiArCQljcHUgPSBjcHVtYXNrX2FueSgmZC0+Y3B1X21h
c2spOw0KPg0KPiBTYW1lIGNvbW1lbnQgYWJvdXQgcGlja2luZyBhbiB1bmx1Y2t5IENQVSBoZXJl
LCBzbXBfY2FsbF9mdW5jdGlvbl9hbnkoKSBjYW4gaW1wcm92ZSBvdXINCj4gY2hhbmNlcy4NCg0K
V2lsbCBmaXggaGVyZSB0b28uDQoNCj4gU3RpbGw6DQo+IFJldmlld2VkLWJ5OiBKYW1lcyBNb3Jz
ZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCg0KVGhhbmtzIQ0KDQotVG9ueQ0K

