Return-Path: <linux-kernel+bounces-162732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B28B5FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F38EB230BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B4F83CBA;
	Mon, 29 Apr 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBCSRwRh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721C8626D;
	Mon, 29 Apr 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410797; cv=fail; b=nNwlqRczK/JYamSLuvsE0q7BiBHMickH4l5YCazZ4c+McfzNwK8Lr0lmA6D7hZPJXBlZu6cZNM//eeDhWQ1Z0kLaODBS0Of6qYsF84ZoqRAJcU/AnF3uw4s9T/f+aWiivL3FvgduLfvwAbLV+AsZRx30z2u/UIrFXLyhyFMjtfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410797; c=relaxed/simple;
	bh=q+dHYmn1Q9ZZ/NocsGp3bD+MTOk9AO6Pb21cFty2+GM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=encZZIFZu3YYjOs1ItU82KjciTNhgIdbSZjL+WVF4JnqP+Ee7dPw20/1xqNKuEI1nRHTvsZvHgjRajP46kB93WYyxUFKi+FBerX5yn729hyGS8mpV+KKSbEEt4YVfttlQ5FGlJj5dvMpe9ciemEle/qIH6u1Mr1aw6JxTjOMef4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBCSRwRh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714410796; x=1745946796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+dHYmn1Q9ZZ/NocsGp3bD+MTOk9AO6Pb21cFty2+GM=;
  b=IBCSRwRhMTq9g12Ld8wKUWuRKOEMZBxDnUbjWfxrA1c1Qj+Oo1XuonMy
   HL1qM6GZnNk9WdSgs8sRIt50GtFbuoSTjZEddiZLGW86TgwsHOzoJmiQM
   bZUOTeldm80c8glDYaGcn4CIwE7TOk8qJgdT5Ee3cGDKtviDddG/2UzgF
   ISg+EaCIXupgN66KCJBciKoEqwSp3nLchGUj3NHqv7vNlW45uJ7IE7NvQ
   TZrUchqX4ayJrIT4Ld0C3sRKpFHLpBEPAEJqhYzI0idFcc9pjYBzO2u56
   iyhignP69XCcredDPXpyPZjmceiFXVwgNOC859PeF6Sf3g9PKl/Ze+gbb
   A==;
X-CSE-ConnectionGUID: 8cZwh/5PSg2pfQv8ZC8LfQ==
X-CSE-MsgGUID: Q7oe7gv1Rii05Rstn8Dfww==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10622499"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10622499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:13:15 -0700
X-CSE-ConnectionGUID: vHdNeMRBRseOajd/3rXv1A==
X-CSE-MsgGUID: IYZhUienQU2CSaIVBQ+2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26163792"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 10:13:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:13:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:13:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 10:13:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/BwrawAsioUoutZ+oFi7AqqXvppBWUV0jb6YfKFn8dS6nlBMTmDz/nZJZsNLFWtAVQbVlYeZXgAqyaigSo/UaSuEfowtEAZXJyZb2kd+6eIHE/FwM9LaOBM/kLh3tqqwjAzymvCJ7UZJkNcuTvu9GzBW8a+YkgwkBreaXWfAPQcNJa2Bhdw7sDViUPOXlGU3rDgnnHBaO3NridpljEphwRFnc4ZMSolQ+pQtHPXreR7vUaz9H9AIbbDqTTH7ALtJzyFBkK2qkoJwthdr5FJlAPZEBjumSd7weltllFiKAFwEBQL59eysKeiv2C0I+NkjqtcwDyTWckftEP6GauFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6EL+mftqI6R8ryMMzyRCVWiCAA3/1PuXYy9DcHiDMw=;
 b=nnS2sAjUnGAm7Jp2QBIIgfFpBWBrCHRzBlA+j2xLFYrrGuG2CbJUwv9qKiEgyBdK55vcD6/okkiKnd2GsvCEz04B7Hg4TxInIT1CzLsIgTFdYxyRuBs9qUaOCmYdFZTXC0IdDA4GRyaWyvG4l97N2lNz4uiCm4E7qfeHLF/K8r46KH7F6T3Zec5Z2vTAUiYTBt3KEDM+emL3lgqX1Fkzuxu33nqn0Fu1DFK/DXb7jdWuv+zu0ZppTjDdKKrVH/CQqVkKC6gxILdNlDyff8Zuu779ChTMIGAIgklebnDMHVVBsr0bw1PVzSnny9FTf3vf+DtCBG/4LgZyVdepvEmWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 17:13:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:13:12 +0000
Message-ID: <95e3e9af-a7e7-732c-1e76-680765414ef1@intel.com>
Date: Mon, 29 Apr 2024 10:13:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [BUG] e1000e, scheduling while atomic (stable)
To: Linux regressions mailing list <regressions@lists.linux.dev>, Greg KH
	<gregkh@linuxfoundation.org>, "Artem S. Tashkinov" <aros@gmx.com>
CC: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <2024042328-footprint-enrage-2db3@gregkh>
 <2330c23c-e99b-454a-b195-32c5b4332071@gmx.com>
 <2024042756-lushness-cupped-f19b@gregkh>
 <fd85f305-6540-4551-95c8-f75c9288f21a@leemhuis.info>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <fd85f305-6540-4551-95c8-f75c9288f21a@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd97873-b603-48b0-cb2b-08dc686fa648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0Vic0NtcEFNaGc0SWVteExjNjFabkgzV0ZjdFVlb3MyRVFlSkdrUGpFdmF1?=
 =?utf-8?B?bGlxYkxXQlgxSXpqNURnNkVwNjE4K3VUd0F2ZU5tR0ZpTmZNMlByZHhzQXJ6?=
 =?utf-8?B?aHcrQVlhU3l2Wm9QWGh0UkZxejBYN2grSUxkdjNDN2hraysvWHdzb3JRKzBP?=
 =?utf-8?B?RktrQTBBa3Q5dEs0bFNMT0RSekthSGRoMVdVMjRzUHh1R2V4M05BNUVGZ3hv?=
 =?utf-8?B?RlRwVUFQZyt5ZzdaSUFkaGFjcm9jdFNwNFExdmh1R3c5WnZDci9xeG1TVVJi?=
 =?utf-8?B?Vlc3KzNuTzdRZm5iNkRaVUFtKzhaZnh5bkZyTUUyek1VdWdlUy9XQmZ4VDhV?=
 =?utf-8?B?ZlFqVGVDZjBYekJwdEtnRUlISW9STldvL2tUemRXREEzdm9laWloN0dGZXVI?=
 =?utf-8?B?N3pjUWxoUTlYODFpWU80ZXZXRlJzdmpocjZrQlFRUlVhays4WWZZQ3VXYnhV?=
 =?utf-8?B?OThKdlI3a0RuU0lGek8zTmJ1dU0rR2tnMitoaUcxc09BYVc2NjBMS3BzQkI1?=
 =?utf-8?B?bHBBUHEwQTA2RFh1ZngzMHZkRWp1ZXNpR2pMSDZMSlNzS0U4Wis4eVhDMTNX?=
 =?utf-8?B?L1NSZXF5TjVGNlcwemkxYjR2VUpXMUtQUWdvb2hIcjZyUXdxa2dYeHVMTUlz?=
 =?utf-8?B?cmkxRXg1bXZ5M0dSVjFkdllDc0xqTURvZGtWbzBvRnI5NEc2NGt5WEZOMVFq?=
 =?utf-8?B?Z0poMWw3bUJzM2NmVUdPM1gxazFpZWFvd1FLOTB5MVlJSmt4VUUrcTZmY1dT?=
 =?utf-8?B?MUxTS1B0am1LWitNVW03SkE4WVp6dzYvcWhsbEhNV0hhVG1mM1Z6VmdIUlRK?=
 =?utf-8?B?dTg2UXN3WWZ2bGhWREJkZnFCc2htL3FRb1AyNlFQcWl5UW03VnRZMDlpaUdi?=
 =?utf-8?B?aXZLalVQbFhJdk12MDI3TjVkaTZMbGFkb1pGVWJuWWJWL0h3SVN6Tnl6anFi?=
 =?utf-8?B?RHYyc2FqYkhMc2N0eGd0ZkxhcGhJZ01GOTQ0R3N2SEZVUjA4NW9oUlNQYVls?=
 =?utf-8?B?L1Fsb0lqOE5hYWlJQllycXlmMXpwQUtpTlloSU5TNVJtUWpyNllUemlST00v?=
 =?utf-8?B?Z2RwMk8vSFVkVVlldUcxUGZuRVJQbXl3TGJoc1Jjb1FOelByZVd5SHZod3RL?=
 =?utf-8?B?S25zVU9kc3Rzem5NS0JFYlZLU1pLaTBVOThWTFJ5RTczZ3NUTnhwc0liQ1VC?=
 =?utf-8?B?UUo4bHVwaGpTeHpsVHBYZHl2R3AvNnJUTEgwb05uTFlWNW43MkFzVnlqdGdR?=
 =?utf-8?B?dldJMG03Z2ROcGlmd05PL2VVaVM4VVZNYjNCN0c3L3pYRURKZWlDUk9EN3ZP?=
 =?utf-8?B?dGU4R2swTHBDVUJQZVdReHpmWmtHclJtcFRBdElKZjR0RXdScFgxTzZkVVc3?=
 =?utf-8?B?RmZOWUdGYTZzaFZQZXZjM2VrWkhyNTZrNzFUSG5qa1hSTmc2aDM0ZFRMai83?=
 =?utf-8?B?L2ZlSE5ZcERUNjlDNEdia2lXMmUrbU83dTVpTGhyTmNnRlhQOFBxTm5wMjRt?=
 =?utf-8?B?RlZIdU5BOC82M1I0S3A2dllCcjZHWlNXSmdwcHNYY2w5a09kcnNHRytxMUVt?=
 =?utf-8?B?dUM3eFNDc1NuRzhmSTJmd2lvV3Fnb1JYR0owRmF5RzFFZ0Y3eU1NMExlVWVz?=
 =?utf-8?Q?4Tv+IYILJK76AZRMaGZNMds7AdCFzJpJUADL6lXH6DUI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNROTBwNTM4TWxsYVpHTGJXNi96anNpc1VaS0oyZHJnQ0ZlRldhQVRKdEdq?=
 =?utf-8?B?elRHWVlYOTVnc0pmeDRxUFA3Qy9xUFFuZDVuSzlhMzcvcDQxeFJSVEpJaXpZ?=
 =?utf-8?B?eXFPeEMybTluSTRQR1dFZWNnVXdKaTBWN0pnZ3NEWmF0eHZWV1NKLzU4bFFh?=
 =?utf-8?B?TUZmZTNIdndhdkN6OWh1NkYzeGhzaUZ2aUdKbjgrZTNEZnFOV0Z2cW9ZUUlm?=
 =?utf-8?B?eDhXMWVMUTh6UXp1N2J6Ylc0ZEtEWkF3NzgwTUNhZ3ptNDF3L0k4eTgwVTB0?=
 =?utf-8?B?Yys4aUdvakw4RDdyUUFId0pLVll3L04zbVo5Q3JuQlZqM2hLSnVxOHN4R3RT?=
 =?utf-8?B?bG5kditOejZHNEEwbGh3OG5Sd1lqRDZEOHFIWERLZGY0b28wd1hQd1VVQWlV?=
 =?utf-8?B?M0EyNUgycTNKd2E3WklicFRjWkRud2d4NmFkQUNua0hKZ3EwempULy9BY2Jh?=
 =?utf-8?B?N2pXT2k5ZHJmOU9XQVo5MGRodHhqUmFqMTBueWk0dGpHZmJBY3NicElWbGk3?=
 =?utf-8?B?R3BhR3NxdFF5UGpQUitaczVxM240UEpaUjBRUGRRcTJ0ZmFJem9LV2o3VHdz?=
 =?utf-8?B?amEwR2ZUdGZQVGxxUmlJZHVUMjBiNm4xU1krclA0OXRmdUdpMXl0MU45dTJS?=
 =?utf-8?B?M2lMWmdsaFBIemFoTEdHcmdBRnk3SmdMbEZTN1pNdDhxeEJSd21paXIxaWF0?=
 =?utf-8?B?enpWb0g5L0R4aTF4UmJ3UGVsZEl6aExPblFkSEl1M3NBanNBdFlrdG04Sncx?=
 =?utf-8?B?RCt0dENmMXZrb0RiS21qMW5rQmZmSEIwMGxmR1lWZ25xeWY3eHBFNnZMeVZm?=
 =?utf-8?B?aXEvbysrOTdQQWlaREJqaGpRV2ZOV0J2UHVTenZaNnRXQ05QTitYVFJvMDNX?=
 =?utf-8?B?bDBGTEpabzJZV3ZWUHpqR2ZYMlBXOTdiZ0hrZ0FRK0JPUXdnTHFrc3BYakhR?=
 =?utf-8?B?UDhlWW5XZUFNVXR0UWlBdmU0cHdvTDhLNUdUNVZrb2w2cWFheXlPc0F5QldW?=
 =?utf-8?B?WmMxUnVtTjV6NHRPUVFDTGpUeWZqWXVrendqcWJJWW9ua242N0prWHFMdHNj?=
 =?utf-8?B?NzNnbFBucnlYNW9RWkZKelExVjJOQ1poMGhJZUNyek5DZHJ2bFJicU8vRUFZ?=
 =?utf-8?B?TmVya1ZNZWx0ckFkTmd6ZzdtbWhNRXhXTDRpck5OcTR5eE1EKzJ3S3JsQmZr?=
 =?utf-8?B?dGNRSkNGeFZVcFcwd1BlZGIvZEJzZnZzbXV4SzV6NzhoS0xkOG5PajZVL3VN?=
 =?utf-8?B?YkxiN2UvUTZXNUp4anBtdGZiUGtrQ3NGbUg5OWZxUElOUzZZTzBxSERObndt?=
 =?utf-8?B?bEkrek1xTEU1YUlEd3FvVWFieHVwSlRGRXRDWEN1ZGZXdVh3MGdVQ1ZlcTdB?=
 =?utf-8?B?UWxpWTZzVTJqSjA0cW12Nm9PNyt0Z0RSOGV6TTlKcEZIcng3d09hcmlVcmhJ?=
 =?utf-8?B?Y042b1YvY3lsREMwZlNZTWxvRXFvcFNsUE1Ub1dNQ1M1VC8wQVBmbnkwVEox?=
 =?utf-8?B?Y3ZhaVBzcktBcjBNRG5aeVdvRzZteEdzTE9BUmtqb0VYcmk2eXBkV3YrNnBk?=
 =?utf-8?B?OTR5S2tnZk05VlpvT095c2p4VW81MndhaDJsb2ZobzcveEhhYUtrSWRqQXp2?=
 =?utf-8?B?N3I2ZDVrTGNuUFRQRTJaUGJuZjlTZ3ZIOEY3cE14dUt4cmthYVgyZFo4SW9w?=
 =?utf-8?B?d1dySWhQV1VkVUJpOEZiQStsOFlObUt0YU9HandnczgzN3ZmYzVHZG9seXRk?=
 =?utf-8?B?NVhSK1RDeUdWS2ZISTZqcjdhSlBSS1NlZ3ljbWFZMHpYR3FxVGpFRVVzSmkv?=
 =?utf-8?B?YkY0TnBPNDBSblBnUkJHank4a0lDOG1Jb2FSVGJydURiRjFkeVMxUWFuYXZo?=
 =?utf-8?B?d2creUlockFJTzhCcUpQNmdtaW9rbTI4NWZEaXJVRC9vRGJqdnRSODRROGRa?=
 =?utf-8?B?em9sS0tYWFlreS9xeEx5U0s5T3J0VmlYazhBNXNoaml3KytBN0hQODBZbWxo?=
 =?utf-8?B?RnpJaGYwMVBKK2NOWFkweXFxQ1NQdUpYQjc2OEFocVJ4eXhpbk05T0JDSXFN?=
 =?utf-8?B?MEMvQVZ6R3ZmMTU2a3pDa2ROMi92UU1zaFBpcmJKU0VySVdTQWpHc3NPZk84?=
 =?utf-8?B?aEdQMytFVmhZeGhEK0ROMEhoN3BIM0pUQXR6NHA1QitLczY0ZTI5YTc4OTFR?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd97873-b603-48b0-cb2b-08dc686fa648
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:13:12.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw9V655iDYIOFjWP3apxnEg5hmriMRGoAzVVdHZoNMYhcGtqCYiCopwRYUIR3tLAt6oFvhNpJJtj8LeUnZubdnJYTW8r64fq+xjufencUXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com

On 4/28/2024 1:01 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.04.24 13:14, Greg KH wrote:
>> On Sat, Apr 27, 2024 at 10:54:23AM +0000, Artem S. Tashkinov wrote:
>>> This fix is still not queued in 6.8 stable:
>> What fix?
> 
> FWIW, this one:
> https://lore.kernel.org/all/20240417190320.3159360-1-vitaly.lifshits@intel.com/
> 
> But sadly the review is still pending (and hence it's not yet eligible
> for inclusion in stable afaics):
> https://lore.kernel.org/lkml/ded3e7ae-6a7d-48b2-8acc-c125874ee09f@leemhuis.info/

The team that deals with this driver had holidays last week so that 
delayed things a bit. I was able to touch base with them today and the 
patch has been sent to netdev.

https://lore.kernel.org/netdev/20240429171040.1152516-1-anthony.l.nguyen@intel.com/

Thanks,
Tony

> HTH, Ciao, Thorsten

