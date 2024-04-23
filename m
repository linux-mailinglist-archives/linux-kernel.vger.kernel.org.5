Return-Path: <linux-kernel+bounces-155642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DA08AF526
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D95B29629
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8BE13E895;
	Tue, 23 Apr 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aI+t+WDX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC013E058;
	Tue, 23 Apr 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892125; cv=fail; b=Fux8V+CDngOMoAgHfpv/vrgD1/uh6NJSxo0GIv8h9uTYXvsyQCPENFFx5CUbU0CeX9oLWSIFCbsl3NkjHI++lopARl0gU4mHBUnZXcGtFmLuH1Zfn9swcs0sFFVVKfdMFHOkcTECE09oeTEE0hAW7qKW3dy592udnUELImKCO7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892125; c=relaxed/simple;
	bh=72pkg3qaHqc1YLKkNHOtOELRYZY5agMjwsbZLi+Cepc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrLU1Xq1CnaDUHu8le8FsjDTgpW18m6XraPMgblswUU4eZXYLQN+0wlYnxvAoPkA2hLuYQ49kgYL5qUc4AxizslUAXXX8gbqGFfmkQj8cBX8ucLJ0uFA6tF4hGW+5a9YJJRPYxkF8CQzkXX22aBLNsKPhdmbpz12h/sbphAbdxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aI+t+WDX; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713892124; x=1745428124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=72pkg3qaHqc1YLKkNHOtOELRYZY5agMjwsbZLi+Cepc=;
  b=aI+t+WDXp76vj9+Lum9A4O3Dixc+Nn8F+W1d2vKAS098e8eMSD7um0/S
   e1ezGrVn++4txluoSccwwQIGJKDr6FGcapNii7hgpyo/Ulg3vMc9D4tr1
   YtR7sJygnmgHIVrosK91HlYNuCSnASdw9wFgA1+33nUgYIFZuyqWQlAkf
   tmkUNDdXnHNr0Cu+KmVrLShllzC9flPPZjSXyZnKnu9rsZbuZjHmeBsdf
   cVhXUMRXSXD5ZvGfLv0aLs3TzyNqfKS3ASVqaaLiK5xqkzsVlpuMnZJ6T
   QI6Tot0h9L3t3AB3qzatjyVlFO/HJbl7BKpfa4+aeprccmQv31hcVLoS6
   Q==;
X-CSE-ConnectionGUID: 2YQbtM8JTGq8e1u7FTOonQ==
X-CSE-MsgGUID: 1bCt7xX7SHWuUijd25CDVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34892815"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34892815"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:08:43 -0700
X-CSE-ConnectionGUID: /HeHcZYcRceNfx5Iv09/aw==
X-CSE-MsgGUID: W9loVppPRFCAfFkST9OHQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24468804"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 10:08:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:08:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:08:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 10:08:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THad8lRGJNyTMBYL+NWS4BbHIzYnQg8usWQAZAB3cy657EJK0qfOi2LanbmzZC5rF8Y5ZK/DVUOPujZNgwGTFihA4/OSf8VZpqTY1z4RlWkidJXwO90HrJ8HpKKeEKetrJX9rbtMCpnjugvCguQyj3PeiH1CrbOgKFeHlZbK3nIbmgcG6hL+HVt9kVttp6gh8w5I6qmSBebuYbOEi/zxaawQfOk5t70rvGELO10gxZ/ScPGYxU248S6pHoiEykjgI0H5g8p26u6AHfnJMjkmHJJO41HwO2864HzHQYu7QZg6tFrIEHRFIGhl8zaaKzpAXXwjYhbS+6909RCXdohjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0aHAYw6sbgFQo14e9hUEeZQ2ysrzrGAT7O4hip/LVQ=;
 b=hVSEiClqLETdDm5Tk6fiPlxbkaLU5YcQ0BntrDDYBrj2njoZP5cduP7AXOsGBD/LgvU+G29qBEa/xgFD12RdblqRZvK5ysKcoqyUw+gnUHxtf6/KvtHsSui5odpWY0v/XJP32XwvnyN26k17XGD+luDlY/ykn1tNkRZZSWoPrl95F4bS2+vJnuooeqeKLun6WkTEqENVBdohiKjY0nyw5oFFggjddKIP4oX8N6QM0WbbTsu4EZsJJrxGu2S6RFQT3Pe/4hi0BsSMUQLdRwxKFKxSlHcyyA+4YnTH4GpSPkWv2yWNn7znDeA44vy16oaCNByWUY2VeOB6XJN4cOUZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5063.namprd11.prod.outlook.com (2603:10b6:510:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 17:08:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 17:08:39 +0000
Message-ID: <bfdb5787-65db-4c64-bce1-d39f37ad09fa@intel.com>
Date: Tue, 23 Apr 2024 10:08:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
To: "Huang, Kai" <kai.huang@intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "zhubojun.zbj@antgroup.com"
	<zhubojun.zbj@antgroup.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Liu, Shuang" <ls123674@antgroup.com>
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b6f7dc-9d3a-48ab-8c81-08dc63b8051d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnFnZ0owaXJ6MCtORjJMWWlRSkpqcGZoN1ZhSVBBWmtkeHkzMmFNMWtHTiti?=
 =?utf-8?B?TEp2aVRuZnlpd3VVTTJRMW80Y3pCUGlNUnFzQlNRdXNxcnE4QkpCbkxvaE9X?=
 =?utf-8?B?TFNMdEd6UjMvUGl1d2I3RkplRXR4N1dhYzJDeCtsSy85NjVNZzZZby9BVGtv?=
 =?utf-8?B?S0pGanY1L3V4aVZEeDFib0xKNlNSemo3a2dBcVplbTk4ODVQSWFPZjhqOUZR?=
 =?utf-8?B?MlBOODQyczFoYzIzTEZ5WEdjVmVOUWVPRUZHQXEyZXF4a3JCWFJCeTlwQmpH?=
 =?utf-8?B?dW84aWFUdFdDMmtMM2UwcC9GcVRxK09sOUEwYW5aWUh5bWlubHdXY240VGV3?=
 =?utf-8?B?SVcwakdaM2Y4UFBQdGdUVUd4QkwrOC84UkFYNWthd2pMK0hkRlZxTlI4RFJp?=
 =?utf-8?B?b1ZFa3ltOWo3OXl6dXprL2VUQ3c4M0VJTDR3OGJUazZwSzF4YnpFTk85ZVl2?=
 =?utf-8?B?TEtTdmVHMmtVYStpRi84eHJDVE13MTVMU3ZJaTY0TjJyT0FKUVRRT2FCV0NT?=
 =?utf-8?B?MERKa3JRVEpVNzVCMHF4SG5JS1B4MXdldmlySWw2QUdDTGxLdExGTTBId3Vt?=
 =?utf-8?B?NjFNZWhpWFZKYkxiMlU5Yi9YNjdaOVN4UDJnbjhEbGw2MEpZNXIvSlEvL0VO?=
 =?utf-8?B?WitzVlJCZW94d1YxNlJwY1hzWlJGcXU3TDQ4cHAvbHRzNGRBa0lSUEJyQnRr?=
 =?utf-8?B?aFdia1lwWFBpbzBlRnBRWTZxQ2VDUDFRUWs5aGQxcU9nNTNBZVlGSWlTUmtQ?=
 =?utf-8?B?T0FKMys2SWhtRVBPVW5UVUIrYjY1d1FLZWlneldIK2JhU1EyTkxSbVZYTUR5?=
 =?utf-8?B?VVRBNzh6OTYrNVJtakxIdjJUQW1uL0dXZkwzUU4vR1RVSjAvTDZrSnc3Q3A2?=
 =?utf-8?B?dXUzdHE0Mkt5NW4yZGVKVE1DT0FER1lZNVltTGhxNmZuRmM5MDNjTVlMQXFG?=
 =?utf-8?B?RUFYK3ErZE5PVm1uUUNGejE1WU5XaVRTRmFtZ0RxSGpsaGJCeXpLbUx5Vk1R?=
 =?utf-8?B?alk5M0VmZkpxZFJVMmZWTmRBd09ETjhHa0RXb1NnU3U3T0hzQjQyeFRWK2hR?=
 =?utf-8?B?OGFrdVlmbDZUQmdSZFV5cFpkQkVYTFNETzIyTklFVng5eTBUbnlQQVFwaThU?=
 =?utf-8?B?bWF5YW9TcGduaFBPNkhUd1Z2TmxmUTJwOHU2akdYeUE3U1BHTUJWSTg1MXlC?=
 =?utf-8?B?anVFZkNxSXlxeE41cFltZFYxaFFDU2lxNVBncVRZUHEyMU8yaVgrUU5MV2di?=
 =?utf-8?B?M1hndTFOMnA3ZU9sNHkvT0NwRnNsUG1uY0tqcFJ5bGN1R3BlNFpmU01zT3or?=
 =?utf-8?B?YWlrcWNUMW15Z0Nab09hMHA4djlnSU9uZ3lnU2JVTVdEK01tV2FraU4vVjhs?=
 =?utf-8?B?WVJLYkg5ZHBTTmRLWldUZkFrYWk5cTZuaTR0cFBMcTRQTlZLT1BJNWxDQjNt?=
 =?utf-8?B?MWtQWmVXb0dYTS9zT3JFbE9QTE1kRGZxaE5seVZUWmdJRXpZMXYvYStDbHp3?=
 =?utf-8?B?Mm5vMEhPTWt2WVpBVklQTGtnaHc4ai9rcTduWkUvZnl0WWNxRjFraE13NzBG?=
 =?utf-8?B?YTJwQXdSaEFaRnpUcnAzSVl0V2toemxuMEJFV2NyTzhQazVvYVl2MnVEbWZF?=
 =?utf-8?B?UFpUNGxtTWVSVVhtRWZsSDdHTDFLbTdnQ0FydHZUYnY2ekhtYUVkWkx2VTYw?=
 =?utf-8?B?MEhkUzRTdnpheTBEWk9OaXc2aGtaUEVPdmtrNFdRMWZ3cVVKYVBPQk1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0JaMGl5dStIZ0Foa0FmZUl4ZFh0Ykd5WG8zc2JjckkxMnRiNkg1KzVnU3Zr?=
 =?utf-8?B?cmxydDlKSjYyRmVjbk5RMlpUTzJCRjdqUDVVYWljSFFTdWpvMjZkakduTXdp?=
 =?utf-8?B?cld2QXRkOGVIM3lkWXVDWEJ0dThQeVVXQjF5aFQxU2dYNVpSQ28wKzhLckpQ?=
 =?utf-8?B?WldXUUhQZE12UE9FSXJXS1dxb2oxMHpKcjRPcHQrWC95ZXozUVJQV2tMUXg1?=
 =?utf-8?B?Y2JKOGtFQWNZTmsyclRHRVFzK3FReXZuSVZPRnJmSGI3QXVsK3NTWG5vZGF4?=
 =?utf-8?B?REZoeEsvdFdmOXR1ZXJsYkk1dWk0TXk5a1k3MExuMnU1NVZUcmJyakNUTFRt?=
 =?utf-8?B?M3ZBOGJ1eXFsSFhqMm16Z2dxM1p4U0QwYk5GTDJuRlBwVFdLRDBqSG5nWXYr?=
 =?utf-8?B?YzY3ZFJzaXRFRXZnK0RnTXZ1U2kyODZlUWJmc29yeVZEVk9tSVBOSXVuVGFM?=
 =?utf-8?B?Qm8wOWJjckRPbnFZL1AvU040N0tvMjF0dlFDM1hWK3NvM0wwS3JrUFpOQXhP?=
 =?utf-8?B?U01pNjREZHN4WDFJNkVFZ1Z4d3FPQmlpbnFCdHdzQUtuazI0b1U4NjlOSHZ4?=
 =?utf-8?B?WlQzUG9nRjJZdlVmN0grSTRIbDhkbDlhRzgvRHFLTHJBSG5XY1N1WHQ2NXBN?=
 =?utf-8?B?VVowOVorSWpVSmZzQXdobzJBTytzdEVHTDl2SEQwUHBoSHhrOVhVUllVQ0Rp?=
 =?utf-8?B?TTBzMVhteVJiK1JYNEwvM1VIeFkwTU9ieUJVQnc3MVgzZFZsR21uWmRocW0v?=
 =?utf-8?B?Y0RvZGZ5L09pWHl6Q3RZVjBLdGt0ajJyYzgwckJweUM0dWVFVnI3QkZIdk5V?=
 =?utf-8?B?eDhoZTdwL1FnUXFSK1RNajNsb1hTZ0xOZ25FTVZHakhXbHdLMlZUcndnUVd1?=
 =?utf-8?B?a3gzenJVMWIzWXFUQ1QyU0dNRmJlemV0ZW8vS3I5ZjJrdm12ak1CZlJTZmRl?=
 =?utf-8?B?MEVxVzBuUit0bWdLcG9FdHJKaURubFBGNjF4Y1d2YkxmWVcxQzdFYWJWN3Jx?=
 =?utf-8?B?b3oyZXdVMWV5WXVaS2ZyYkFsTDZMYm5lS3pBcUIyU01IK3lSV0p0R2lKOTU4?=
 =?utf-8?B?QnFWSUl1Tk5wNUpYSDlCdjZDUE80b251OEhqZGtLOWxwNGpyR0gvVGVVRjcx?=
 =?utf-8?B?QnhsOHhJa2Jnc1lTbFNWbEVtZ29LVllyK0s0T3VHd2IxdHFXdWRpdDYyd1la?=
 =?utf-8?B?aGVGTCtKNzBqanFDS0ZXRlV5QStpN1ltUmJDcDRGSUsraUFTTlgzWTdBNFdW?=
 =?utf-8?B?allSQjVwRFNtdmZGMVQvcTBrOWhDZEhsNzNlZUZIS2xsajdNbnV1Um9PeXlB?=
 =?utf-8?B?WFhYV1U3UDBrWjkyN21yV0ZtcnMxUVJTd3lpWjRCRXl4cEpTay9CK3JQRHhB?=
 =?utf-8?B?WWxVL3RuK1pLSkQyc3lPamo2R05HVkZhTUJTVjhxbDN3RmJZYVZqTktKN3R2?=
 =?utf-8?B?V2gzYmd0YzdhbG9FdXczekRJRWFSbktlUmEwV0FYOTkraERNdkpmVUlPVDBQ?=
 =?utf-8?B?N0ZadGhvRWJQYlppNlBISithSDdGTEMxYUxJaDl6cXJFSm1OUnVHY2czRWdD?=
 =?utf-8?B?RU1rT0o1bVF3Y0pzbWxodEt6RURwN1pmRE9iajhzVEhVZUJRS3Rydzh3UTJh?=
 =?utf-8?B?MmVpelBEaUE4aHd3ZWtJODZBSjV2MDMvN2xlWmo4VUlTU3dETVVUWVR3YldH?=
 =?utf-8?B?MkVLbVpJeGdPU29JckFySEhmYlM4OTNiUXNzY1l4U2c5blFPS0ZkK1RENlRB?=
 =?utf-8?B?c1hJaTh3eFRZUWMwSnNyQ1huMXN2SGpqd2ZSbDJ4VFBLVVVKQzdKV3kya0ti?=
 =?utf-8?B?UXpYWnRtMjFzSUJiTXpFa0d2US9FQ3AyK3dVUVpSREM3MStMZ3c2YUpIWjVD?=
 =?utf-8?B?N213OVMwblFxMG5hVWZOZndHYjFCc1B0TUtQWERmT0paWXhQMXRaUmJGRXIr?=
 =?utf-8?B?dVJNbjJyK2ljWVBJYWFvcm8wL2Uwd3doVGF1Umd5ZjA5blFvcStBVWpNd04x?=
 =?utf-8?B?eVFHSHJ6b0ludFd0eldvRHZBN29HUkZobnZEdHFQSTdHSXNCY2VjZDcvUTNB?=
 =?utf-8?B?ZDRVNm1vNStBUkh4dlFNaElmRDRodXZqMmNGVk9VakJaRXBhRmFna0JJL09X?=
 =?utf-8?B?RGRPU0FQOE8rSmYrYmFaOXZ2VThMMGhmQ1JYRmhLTGxkVUh6K3E2akZDMndk?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b6f7dc-9d3a-48ab-8c81-08dc63b8051d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:08:39.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54toL8EbY+v+CTIaZ+zBkV242qQ7lUyVS26s50wIKxwLxbaDCRE0ZHvXn4BjlqVG9tv0x9luPvfYQY5G3qn0jtlGr3gRFwRZLGshOw742Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5063
X-OriginatorOrg: intel.com

Hi Kai,

On 4/23/2024 4:50 AM, Huang, Kai wrote:
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index b65ab214bdf5..2340a82fa796 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -806,6 +806,9 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
>>  		}
>>  
>>  		mutex_unlock(&encl->lock);
>> +
>> +		if (need_resched())
>> +			cond_resched();
>>  	}
>>  
>>  	ret = 0;
>> @@ -1010,6 +1013,9 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
>>  		entry->type = page_type;
>>  
>>  		mutex_unlock(&encl->lock);
>> +
>> +		if (need_resched())
>> +			cond_resched();
>>  	}
>>  
>>  	ret = 0;
>> @@ -1156,6 +1162,9 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
>>  		kfree(entry);
>>  
>>  		mutex_unlock(&encl->lock);
>> +
>> +		if (need_resched())
>> +			cond_resched();
>>  	}
>>
> 
> You can remove the need_reshced() in all 3 places above but just call
> cond_resched() directly.
> 

This change will call cond_resched() after dealing with each page in a
potentially large page range (cover mentions 30GB but we have also had to
make optimizations for enclaves larger than this). Adding a cond_resched()
here will surely placate the soft lockup detector, but we need to take care
how changes like this impact the performance of the system and having actions
on these page ranges take much longer than necessary.
For reference, please see 7b72c823ddf8 ("x86/sgx: Reduce delay and interference
of enclave release") that turned frequent cond_resched() into batches
to address performance issues.

It looks to me like the need_resched() may be a quick check that can be used
to improve performance? I am not familiar with all use cases that need to be
considered to determine if a batching solution may be needed.

Reinette

