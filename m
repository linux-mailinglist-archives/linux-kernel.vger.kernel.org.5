Return-Path: <linux-kernel+bounces-82818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB372868A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AE282281
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13E55E78;
	Tue, 27 Feb 2024 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDo1D8/Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34E54F83
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019766; cv=fail; b=EhLXakwFUnc6pyfISpcEa8C7DxU669J3/V8ZGIDBUOoC/gFXrWO6mJm+nat/W/SdwEOrqLU4zvr5A7/PDZIp5V2MrdU9yPJc6joCnzu7qKAkz7FgR7uF5/WUosQlPD/givsM5pB/TU3ealK/VM4HgxVekAMvEcoCTzKMkGwOXyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019766; c=relaxed/simple;
	bh=k0hTB5Ki/pnUOzGlKZReeXS0T3ItkqWnukm0OIkk18E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+pTCsv2eAVX1besK6UFl1TXRZh+5JSm0hQOwIAbzsJzUV4HKathiirBaUtnmXLPgy8nZIL6c+Okq2Qra6e2OpwanU3OybAPMSI6/U4MuYrY8HA5FZ9IY+8T/I4PsTb/GE/AGC3cLwMtedAyXQ3zolfJMQZYd4stRZf+2AI87kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDo1D8/Y; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709019765; x=1740555765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k0hTB5Ki/pnUOzGlKZReeXS0T3ItkqWnukm0OIkk18E=;
  b=WDo1D8/YvHcXdGTe0SgHV4oHbP0adXtNnY4ePf4ZWjyUgX1dj2K8lzlC
   6LfRQLV3llB4ZBOIXFtZqz04cwK1AIicna24UcAbKvcpKQj5fu+X5DYQb
   R6k7acl1j+IooiZntxLTFc8bT6AtOff2Q9Ia+/pBvOSjp2GJxPWOsRGnV
   k17Q+5ypXJJwPLrVomTlam40dd3gYx3WlNPDgHharQEBEjVrQ1b+4it2S
   IjPFmI2LYkXWmye7+bNL3i8N2JKEw18I6Czt7XVK9qEvUbOy4K6VirN3K
   uGMNyRdwNyh3CiFc1iEI1UPaAGlK+h3lnaUbeJalrnw4gzDICDFvnI/Ro
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14495451"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14495451"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11535256"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 23:42:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:42:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 23:42:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:42:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGsJ0yOJHLX+GMsZgwGgqcygAMDOakEwOUOAyuABsWN+zc4mCD3YsQAo+hm7Ny+BQDjV58U1L6WuoMBSVku81MvzhAahyV74peEoz69VETlbqYC2OvGunfezb9bho5VM8RaURmVEEab0rQWz0iqLFSDWbaO6EC0pOvUtximJxAFsOEtKDu2z3fcZNMCFbKbwjOEYD2h2G9XOUMmclBQEc4LNT82+IBPtcQ/S3iP8JhUUX3ZW1gIoU2AImc46zWJ+3IJkpYF3yxsdnAbHL+5CzCTnpcySROz0+8XQ/49uht1GlE+2/tGOAgj5SF2Yosaxca8vlYdI1QszPfiToL0tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMngSVul1GEHavp8pTOoXi/xh0LKoWaC6Dyfg2YNRqE=;
 b=KwQKZuPyMLeY5eOcW6Bmd/5Prunr0KetiCsVpCzychOh6f3LfV++YuRdFfeYenPhk2BrKHeXG5WuotTTqxLz6luCFvgqMhvO8jZ3rKGR/t4HViQdh6Hc1G3YjeAj7n7a4kQKaBkecA10SC8MVPDgBPIRvmDXJjOvfy/5sr2YWFkAHNwKt09/16cQ162vn3cgnSztBc1Iw4d62QbNK6Rweai/hlG4cqzmPpS2fvVixRkwiN4WluvGNV5X/f/wSnyG/Iy6YduFRw4ROadwi41wrmJ4pxr5O6yaMFngUTTxJnvCvJE5p/oAEyAuNz8C05yLxUSyXL0pSzR5JdCsIiJFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 07:42:40 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 07:42:40 +0000
Message-ID: <009e5633-decb-4c21-b5fc-58984fbade96@intel.com>
Date: Tue, 27 Feb 2024 15:42:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
	David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@suse.com>,
	<minchan@kernel.org>, <peterx@redhat.com>, <shy828301@gmail.com>,
	<songmuchun@bytedance.com>, <wangkefeng.wang@huawei.com>,
	<zokeefe@google.com>
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
 <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com>
 <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
 <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com>
 <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
 <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com>
 <CAGsJ_4x6Otb9LUvnxAaPLnQ2MPPng0xpG-vJmFL7pNm10FDhZA@mail.gmail.com>
 <CAGsJ_4xndYM8=7v+EV_aWX+_qgA1UPmm38n+ujbQXJLzCPKfog@mail.gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGsJ_4xndYM8=7v+EV_aWX+_qgA1UPmm38n+ujbQXJLzCPKfog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ1PR11MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: b7857986-7377-49dd-6f96-08dc3767ace1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/G/285OW1gw+kLQNGXfWwKqfOYVtE8AcVEp09YB26CMk9qpXz25hH1mRh4u75uhC7vW56dQ9mG6DXlViRJ9spAQ4qKbevaFV2rNseJkZs17Ju+VzuWA+q7ojjeRHNJsu+cPxdysIBYcnhBmtqWzv2/vftOHT5OeUNksqELMaHv0hrocCRNzYLyGc+VpJAFo0r65EoGOAKp8g4EEE6yuQ0Zp4p14+ilkv9eDoY9PBnojQJCWmWsPhxqGnAlxwyiXz/Cu+dvNvdn5rshjJLx9Vzt09xu0VJdmJxjPDu/QYvlUvky211D6gaKKzKYz16MuWXfs6a0Pv3+o4ZtTwzJfSV/qhTw2XyZs5k75E8zNCD2Ld8LsCFDgRUDh6qjMSWsZJhhpRMBVvulkjkogxpkXe3UY3ga+JnORMr1S7glp0qfdZ72BULiKTq8MUaPeXqJbqo3+c8WKlS/ylcbsZdzCLM8eusSdUsgpZnUNqoc4lwPkjmBtrFupotVVktQzJTfs93iTQlXIStdwRtsXbU3hv+anozN4qfxAeDQslVV3x3jc8AOf1CFKQqMSOwgJcAQaXW8iHzwebJfAWCRPh5SwMBuHnNmYOpp4AeoBlWzToRn/Us6pQZ24w8MqPtSZQR4w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpvcU9VRUxqS0tlN1hkQVBCTmRxdGdFcDUvaHgzWmJKMzhJYndsVDFNdkxS?=
 =?utf-8?B?c3RrekxCSGp1TTRWYTdnanArYktMcGFZaGR5cUJLMUFuUFFYN21Cbm9UbkRI?=
 =?utf-8?B?WUVHZmdZQVRzVG9iVTgrQUpuK3I4NDE0Q3RmYms3OWJJYVhPZDNRdnNDS0Nq?=
 =?utf-8?B?U2hTazlHdWg4aFFZMFExdkpDSEdDRmk3a0VSZlcydzU4M0xNUDVnbFNYNXJI?=
 =?utf-8?B?MGk0TDB6REhDalVNZ0J1RldXanV1VVZOUTRkcnAzblFlT0Z1REtCZzBQYk5N?=
 =?utf-8?B?eDlMK28wZEFLZGFRa3FBSDNKL1hKZ29qaDVIeTJzVDZaRGQ5bWRMcERDM05J?=
 =?utf-8?B?T3p3MWNhTGtBUzRmeTcyanU4cTlIbmI5MUFvYmF0M0VpYzRHZ3U3N0lHL2Vn?=
 =?utf-8?B?N1kwSzhsUzJYRG4zRk9MU3dPQ1VzOGN1czlTelFDYWs2TWVINXI2YmJvdEE0?=
 =?utf-8?B?M2xrVHVoVlAyR0tOck1HekRJUWdSM2ZIVmhlU01PM3RrY2l5eCtteGpkdU1y?=
 =?utf-8?B?YlAwQkFodnpRVkZMOVAvTi8wWDF5NlljYkh5RlRnanBBeXpDcUtseFFXUncz?=
 =?utf-8?B?R3dNMHluRzRVaUZuc21XcWFsZEJtYldBdGRURGNLK1N0ZERJK2pTMi9IUlBI?=
 =?utf-8?B?V1lXTlh6ZWhxN1RsM3BucW5oT2c4TXJkczJWVmxyeHRablJ6TDF1TnZEY05l?=
 =?utf-8?B?SndPaHhWQXZXRndtUk1QTFEzdFcxa1JZVThEUklFSnlTUVZWT0hIWDRZNzVG?=
 =?utf-8?B?cjQzOFpSbVhqbHFUaHptZE8zdzVkVCt5VjM2Y2loblp5Sks1TlN6cDVBVVpU?=
 =?utf-8?B?YWpNbDdTSE9KcVBvc2dYWGRsRjBNY1dWUzljTkhuTUR6RjROTGExQ01NS3Q4?=
 =?utf-8?B?czVxUnlaYkN1ZXRWTGxHK2ZmVEJmbnd0MWlqWFBSRkQvZ1VPZnl5Ni8xeTZQ?=
 =?utf-8?B?QU9SK21PMGtNbzFQaVJCNTlvUFRINGZyMnpOVGVzeWUxSXlzdmJRbHp2ZmVp?=
 =?utf-8?B?ZTcyQ0M4bFREWE5XdmpKbFdGa3RNVlFucFVyYmdyVWIyMU82dmlYSGZEb201?=
 =?utf-8?B?SGZHYVFDN1k2WjltTjFMRjlsZEthRmtqZnVlZWd6ZGVUWnVWcXRmNFRac1pN?=
 =?utf-8?B?WGN1R3pHMEtMRHZBY3hGbG5QVzcxakZhd1IzckVHSVJ1OGp6M1MrL1ZhNXB5?=
 =?utf-8?B?WFZBekNaSWw4citRVFVtQU1QNTEzZ3ZwN1k2M2p6UU1ibFdQTGZOSVI2YUNx?=
 =?utf-8?B?NDgyK0NkVHFNSzl3dEVhWHNyZDFjNlhtc09OdUJVS0tPbVFZSUxmZnRRd3Ey?=
 =?utf-8?B?ZkQ1aUlsMVAvMFBBRlhZYW5rSlE0V0RkdGFiTWhZMU1xSkZDT0xNZ1hnUXI4?=
 =?utf-8?B?K28vVUxyRHBpT2NlU3ZwY2xGT2J6NEZwK2xOby9NamNGeGM0akpsSWVFb05k?=
 =?utf-8?B?NXd6enpuNlpPQjhQWVpSZjB2VTVuWTV6OHM3c2JkRDJZckdCU3Jibm96bEN0?=
 =?utf-8?B?a0dJMTdMYjhMMHFDcCtuUDRIeE1vdTZqMDB2WDlXRE9MdHlENUFPaXBlSXpK?=
 =?utf-8?B?Q2huLzRIODhtcjkyWTFIUGdIZy9sbWgxRUNReWNxUk9TVWFReU9odnI0T1ZG?=
 =?utf-8?B?Y3UxY09hSVdGc1JuTldvSmRkcEhzRXdoVXB2c3ltcU9ZbFhVMTg1MjVac25S?=
 =?utf-8?B?RndoeE1TQnZYcG40emNnelU0cWc2MElmNXBYTTVPaXF1QUlvamJTQWk5WEpa?=
 =?utf-8?B?dzVmdEVLV2xaV21EbUR2NGtRY3BndFJsU0VsT1NmRTRFV1FHcm5EVmlXZnI5?=
 =?utf-8?B?aGhHQkk5SkUrYU8xbzVkcXhyZWlZMHJVa1QvU2hCOHFtalg4eGlKeldiVzQ0?=
 =?utf-8?B?T1ZuY25FVnNDbTRaelRWRCtRWFFyd09oTS9reWFJaTZmazR6STFDTmlxZHlP?=
 =?utf-8?B?L3NaL1lXa2JDQ3RVbjdOU1JaUEMzbFhuc2Jvakx2aFpTbVdoRlBZb1BBV3R2?=
 =?utf-8?B?bHk3aTRBWWRuMFljOUMyQnkwRFJHRUtTZEdaZll1dUhUOXVMQ1J3VGEwOXh5?=
 =?utf-8?B?UDZhd0FQcGlQVlQxWjgrM2xyRmJRMERiM0YrMXdyeVgvMmlnb0t4d1VJUyt4?=
 =?utf-8?B?NERYN0tTMG1GL2kwamtKR2t6OG5GY245RHJRWGYyaGtZRVNlN29RWUlYOXp2?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7857986-7377-49dd-6f96-08dc3767ace1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:42:40.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hil3xbWHj9yEQwoGjs2es4Zh+sWGQwbDph4oMUOB6B/J1PVqwm9/OQc+6yj5qbfFcVXgwbp8d2uafWQurbc71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com



On 2/27/24 15:21, Barry Song wrote:
> On Tue, Feb 27, 2024 at 8:11 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Tue, Feb 27, 2024 at 8:02 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>>
>>> On 2/27/24 14:40, Barry Song wrote:
>>>> On Tue, Feb 27, 2024 at 7:14 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/27/24 10:17, Barry Song wrote:
>>>>>>> Like if we hit folio which is partially mapped to the range, don't split it but
>>>>>>> just unmap the mapping part from the range. Let page reclaim decide whether
>>>>>>> split the large folio or not (If it's not mapped to any other range,it will be
>>>>>>> freed as whole large folio. If part of it still mapped to other range,page reclaim
>>>>>>> can decide whether to split it or ignore it for current reclaim cycle).
>>>>>> Yes, we can. but we still have to play the ptes check game to avoid adding
>>>>>> folios multiple times to reclaim the list.
>>>>>>
>>>>>> I don't see too much difference between splitting in madvise and splitting
>>>>>> in vmscan.  as our real purpose is avoiding splitting entirely mapped
>>>>>> large folios. for partial mapped large folios, if we split in madvise, then
>>>>>> we don't need to play the game of skipping folios while iterating PTEs.
>>>>>> if we don't split in madvise, we have to make sure the large folio is only
>>>>>> added in reclaimed list one time by checking if PTEs belong to the
>>>>>> previous added folio.
>>>>>
>>>>> If the partial mapped large folio is unmapped from the range, the related PTE
>>>>> become none. How could the folio be added to reclaimed list multiple times?
>>>>
>>>> in case we have 16 PTEs in a large folio.
>>>> PTE0 present
>>>> PTE1 present
>>>> PTE2 present
>>>> PTE3  none
>>>> PTE4 present
>>>> PTE5 none
>>>> PTE6 present
>>>> ....
>>>> the current code is scanning PTE one by one.
>>>> while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, PTE6...
>>> No. Before detect the folio is fully mapped to the range, we can't add folio
>>> to reclaim list because the partial mapped folio shouldn't be added. We can
>>> only scan PTE15 and know it's fully mapped.
>>
>> you never know PTE15 is the last one mapping to the large folio, PTE15 can
>> be mapping to a completely different folio with PTE0.
>>
>>>
>>> So, when scanning PTE0, we will not add folio. Then when hit PTE3, we know
>>> this is a partial mapped large folio. We will unmap it. Then all 16 PTEs
>>> become none.
>>
>> I don't understand why all 16PTEs become none as we set PTEs to none.
>> we set PTEs to swap entries till try_to_unmap_one called by vmscan.
>>
>>>
>>> If the large folio is fully mapped, the folio will be added to reclaim list
>>> after scan PTE15 and know it's fully mapped.
>>
>> our approach is calling pte_batch_pte while meeting the first pte, if
>> pte_batch_pte = 16,
>> then we add this folio to reclaim_list and skip the left 15 PTEs.
> 
> Let's compare two different implementation, for partial mapped large folio
> with 8 PTEs as below,
> 
> PTE0 present for large folio1
> PTE1 present for large folio1
> PTE2 present for another folio2
> PTE3 present for another folio3
> PTE4 present for large folio1
> PTE5 present for large folio1
> PTE6 present for another folio4
> PTE7 present for another folio5
> 
> If we don't split in madvise(depend on vmscan to split after adding
> folio1), we will have
Let me clarify something here:

I prefer that we don't split large folio here. Instead, we unmap the
large folio from this VMA range (I think you missed the unmap operation
I mentioned).

The intention is trying best to avoid splitting the large folio. If
the folio is only partially mapped to this VMA range, it's likely it
will be reclaimed as whole large folio. Which brings benefit for lru
and zone lock contention comparing to splitting large folio.

The thing I am not sure is unmapping from specific VMA range is not
available and whether it's worthy to add it.

> to make sure folio1, folio2, folio3, folio4, folio5 are added to
> reclaim_list by doing a complex
> game while scanning these 8 PTEs.
> 
> if we split in madvise, they become:
> 
> PTE0 present for large folioA  - splitted from folio 1
> PTE1 present for large folioB - splitted from folio 1
> PTE2 present for another folio2
> PTE3 present for another folio3
> PTE4 present for large folioC - splitted from folio 1
> PTE5 present for large folioD - splitted from folio 1
> PTE6 present for another folio4
> PTE7 present for another folio5
> 
> we simply add the above 8 folios into reclaim_list one by one.
> 
> I would vote for splitting for partial mapped large folio in madvise.
> 
> Thanks
> Barry

