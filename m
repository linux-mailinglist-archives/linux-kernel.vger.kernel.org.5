Return-Path: <linux-kernel+bounces-107944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C848803DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7B6285315
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265925776;
	Tue, 19 Mar 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvEUSTTC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BEB22F1E;
	Tue, 19 Mar 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870626; cv=fail; b=WJmiLtTrPKSRvT1uHuQVMr/2K3Qj8cSGI23wIhTtD8vLYyteHNLadzoEyfyILI5Z/GRpSnG7W6IahICczOcTpZ2mxo9jFxUa2e4Q6BJXGZC6EfW5vUIvJCzUE5rd6cCFm1vT1ijCVp42Z4mOG/gknjehawUK2Y17q7zDvgIGRBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870626; c=relaxed/simple;
	bh=ujiX0XX72V64j4xRL55/ZRof1VXdumkY78BueOFhHxs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rygcQLs0CV1/S1fmb71SBEL9mR7Fpzc7iRR/SlG5ml2DWhn+uZbj+y0aTn9b392Scr2NrZN0himBF1ZK+RSfXDpaB0ACneQl8HIQLpG9rIC9e6Gd4H4UclLpeTMvCaskJmOMRRuK5XtVPQPpJmqglLLFEL5n0UEmfFWlNu7otZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvEUSTTC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710870625; x=1742406625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ujiX0XX72V64j4xRL55/ZRof1VXdumkY78BueOFhHxs=;
  b=fvEUSTTC4d0Da8zQ+kdFJTN+ygVfLtvOJTxfv7KF1CVwfPlnhd1K4S6k
   sQvzY+MUuRJmBf7tcg+QZUKGVHedcv6HLH809an3C37ftTYZ8bh3QP+dF
   HFJaohaPgEZf1tvnpSwsEowpQR9A+80FkaANJT0ISfJ7RXPXT1y0jwMF6
   +zvtoX8A64+1wr3ZOhdCLBmVbPf4qB9hjTaVczQnrH+q7ORLiccBfRRn4
   qPpiYapfYGksPwxNLmv/wed0yZHfwDMoDLbgWEAXiumtKallwUPO1Faop
   YJ30sMOVdoNyfaZO03VeMw9ePyhdjQG1KPyIO/SOLge1FC8agEbU5++CR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5971811"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5971811"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="18541670"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 10:50:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 10:50:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 10:50:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 10:50:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 10:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8ughwpoM4RBb7IhMoV9yRpyMD7JVJzo8jyQv4iXKTcgRyR11bOpvT2g1oG8C0YSI4fM2ulrWz6WSbtnN5YATmp7lv72+Tn9ciK7oj+QLeTSkWG0R8QFr3weLMeQzBDa5eI3G+4izo9Yx3FL0dLENLlsEY3jQRJ45QayG2tGH8MY8P7D312ROXf3jf8yCMUdJd1Z/6QXsvfwKbTXB0wAugYNp7K2WRWFJ/HU2EBHU3qJzZjY1ivtLAlf1SsgYM4fVKhur1Kcj7Ig59sweeNrOSCtSrrp/atqYIabGlCowI+ZzQCpKUcGl8dKI6re0kaI736ev30He0Uml/hD4k+XnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoozdiSKF6oRYRBx/6WPIGzJ9xcdEogxR0rK23HdGGY=;
 b=JNW2QSaRQNlOgGGkivOuCw1cKXG4AwW/ojAOdZ3oQDJQYFCH/ON9p+C147wfZDu6XN1IXaFGD58chLnmprM3usRbQqT9BZM3Hcr5BFQreNArZV0dhh7T4dFhcJLebCPZ763bqH4Wi6yugJ++1BY7bDEteWW2x/FP8jOPxomJYCxfnVXG65bvJVPMKmjt5zZrpQMa1UMGFHzhF6FTiD2qlUulvypk0egLv3qAOEqXlkwV9rSkrZFSJyoqtDdRdCB+BYJMP1RTCg0ZG6I25wCwtY+Lw3cz7sYTOMlgU1BwKmErGUnrAnB9POv9enDsfUM7RYWH2GawH85UE8HnQmBkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 17:50:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Tue, 19 Mar 2024
 17:50:12 +0000
Message-ID: <a9462db4-bd41-4254-b11d-239ba6aaeff0@intel.com>
Date: Tue, 19 Mar 2024 10:50:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/9] x86/resctrl: Prepare for different scope for
 control/monitor operations
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <20240312214247.91772-4-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240312214247.91772-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dcf230-6d93-42c3-30b7-08dc483d0677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZX5LzPQy1/ijxvzE0NJih8Wducdh8JtaXDvcYviiGQuqfYLm9MvRYEge7ARAsf7z31dBe7Cy13N7L/TVwkiCO0Hhs6JNoqB8EH08YrOkfnoMNjkcm6nxORDXRWlvod1EkTOGTtI5KH+a13XFCVuJegqFRzqwrTFZt9L37evWZ4nToC2Vd/sRD9fLqUiYs7F4/JWLqk2ZSu69J7V48dilE7yRNTRJR/cXTDlE4TzRhVzZo8J+Ekfn9ogNOIeE0arxVF9M8u/KYGpRQjssHJtcubEGtxTLdEI87SsBQWSa7AcQA/oa0iEVmPAKpoG/itcgo2YXavNq6WvxbUx0+7Esq/Rsyy9rj29EvD6Yi2asJP/Litk6R3oOV9Wf7tyzOX/Gj9rQIOKPAOwvPPiaq4Yymz7F4d/+kxfWYCZahx31+2JINAC1pEBCAc930IP2+y7JafSgnziaKTMO/7/ETIxd1BOb9rmSsH9yuMMbvwudxk0ZPbZ0Wiizo9BL6WJoH0ldEx7TKUJYAjocfQQRhNOl2QyTkp2UVBQzYk7H/nECxX0p6yo2Dk8RZdfYQJorZA8DJ8PX5Ic9UcTwd3kfvPXdSZ6nsZc6ZRaXMZTOCEbR8O3tPDYAnQkeESF894TVW8MHPanmx5s4rWfDy/M0bCN1NyV0NYQRXnpuBP4LqaPPPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFxY3pkWmJxUisxbW83b241bXBNMG8vY09HMFJlSXVveWwreVQ5MlF6L3Qr?=
 =?utf-8?B?Z2Y4ZS9CSWR5emxnOGJqdzVucWN4RlZtWlRhODhZK0t2RE9FbUw2K0syelhS?=
 =?utf-8?B?NXZtZW5EZ2p1a3AwQ3FqUmNPbHBDVURDaUNwSGlCQ2Nqb012UEtEWDc1QzRZ?=
 =?utf-8?B?ZG5PbGpycHJSRndvY1JORk9pbnJ6UXZHNTlueGZhSFl1Z0NlU2pidlYvQ0Jn?=
 =?utf-8?B?N2FLMjlDdE9VY0piWHN4aFdQNElmdXZ6VlRSMTlKZnpUTlZheS9vcG9KdGd4?=
 =?utf-8?B?NWlCYWhGVlRGWG9QdTZHM3B4WjN5UmRCZlI2am5tTW95eWtZUnc3UU15c0NT?=
 =?utf-8?B?Y0RFOFpOQlV5R2hnNkM4SjVsSWFzMUNYZnM3OFYvQW9PbXpvWXo3RE1uY05Z?=
 =?utf-8?B?Sk5yMWVnRUY5bWgzQWlaM1VNeEpOa1R1VTVsMndrZThJeEVpeEVOOXBlR05p?=
 =?utf-8?B?bUptbHhBWkU2RXRrcG9aRXJXWGs1VFhqbWdUdEcrNUFrSXcyMEZGUW9TcEs2?=
 =?utf-8?B?TnpvamFwMStvK0xCMFo5UUI0M3UrZ3ZQZVNocVRNbk11ekNIU0hxeEphYURL?=
 =?utf-8?B?MHRNWmFLbVUzSldrSTNWeWRjN1lzNnRwV0NzTFMrcVBDLzJqckJvS2EwL3RP?=
 =?utf-8?B?ajE5RWxtUzhoTHlpbjUzcHgzREdPeFlZS203NS81NVZDVmxEL0hYQ3pBdmUx?=
 =?utf-8?B?dHdJU2NqeGNBdVpNOW8zaGNsemRCaGVIcEJmcU5LZTJ5K0JwOHVTdVR0cXVV?=
 =?utf-8?B?TlEwWXBORjI5OEFuM0RiV0tCQ2lIME5MTWtlazEzU215VGh3aGE4aXIxQWE3?=
 =?utf-8?B?c0o3QWl1WTdLZm92UWJtRkdnT2pSYjV1NlduUWJhR1U1elZmRWhMcG43ZHBP?=
 =?utf-8?B?SEJIU2tybkd1K3I0MElYd1hNeXJ0eXRWZ2dyeWRUMFRPeDZQVTVHM3VQWlN4?=
 =?utf-8?B?aXY0TS9wc2JPeE1lTDhDK1h0UGtnTjRUUU1KeWpIbkpVdC9CYVQvWnNEekZs?=
 =?utf-8?B?QUNlTlJLekpxQW1qOW9BNjRyZlBrZ1gxNWhUblBiSjVyejFBWTllRnpYYlhv?=
 =?utf-8?B?UC9GTlhaVUFxcldDUS9QWUlreUh0VlhYUHZhMlk4b0xDbENGcHFCSTRka1J6?=
 =?utf-8?B?Nk5rU24vaXBIQmJlbjF3RVJud1ExUGxWRVR4WGc3UFY1b2FVZVZDckdCSDE2?=
 =?utf-8?B?Z1lCclJBVVV0djhUZ2k0d0tMMHlhU3M1QTNmdmNBaGp4TUZQQ1lBZWhTK3VO?=
 =?utf-8?B?VkNxNGo5eE1PeTU1QWFwRk95WGc3Nm1acUd2UWNabnhNc2xCMDhMUDVqM29q?=
 =?utf-8?B?TUo3YUZmL3FIV2d4YkRFeDdoY0E0UTFoQzkrb2tHdi9mR2NEQlhQQ0RkMFM3?=
 =?utf-8?B?K2dSaXVMNTZGS0RoZXBxNWFJcm5JSFNsQU1pcUdidnNEMEVUd2lUellDSFRW?=
 =?utf-8?B?dytNT1gybVVkVXVRT3E4THpmeGJKMVhJMks4amVsdVF2Q3R4SlNsSTliSmh3?=
 =?utf-8?B?akR4Qm90TmVJaUJtOERLMkdjSTAvR1RiMkJRdEVXcmQ4cjZMQzZLM2hYQnRV?=
 =?utf-8?B?ZnZOV1V0SmZiQkh2MXVNUkJzak41L3ZaYnVSWVVIaytRMkZRRXFyU0J0REg2?=
 =?utf-8?B?L0VOQjQrN2pQcGRKWkVQczJvczFWTGlrWlRuQ0xDd01DRTdrVC9tUWp0Y3lT?=
 =?utf-8?B?SWdqa3JaMmF1SUFycis4Qjl3UzRvMFFBTFMzR25pa09EQ0w0dmFvS01McEQv?=
 =?utf-8?B?dncrWEtkOVY0Lytla1VlZ01LQm5oUlkxblUyTEdwMlEydkkreVBIZ3A5QzQr?=
 =?utf-8?B?bnIyaDFJekNDZVVDaitVR3J1WDRudWtrUzFrOFZDUndrV3dXNmVaOFhQZ2s3?=
 =?utf-8?B?KzFYRGx3Z2tXWDEwclJ3YjVLZmxzUGMxYjJwbUsvY2dVTEszaDA1ODFoL2Rs?=
 =?utf-8?B?N0hrOGRzaW9SZmR4Y0dwRmVPcHE0U0xVdDB5VzBFSlFVb3RCcWlzMkVEYlB1?=
 =?utf-8?B?WDNpd1gzdlU0b1J0eHorOXMvZzFSU3VLR1Nudi9RNXlDRUJtMTRuMlVZM0Nr?=
 =?utf-8?B?a0tMMld5NTJrVUhhVlRMSlMwVFFyT1lYWGpsWnpCNExpTEU3d3ZOMEo1TEpa?=
 =?utf-8?B?dmZpNUtRL3RXKy9EdDNPU0x0YndKUjhpWjJacWZKb2xyZUUwRjNORW5jemo3?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dcf230-6d93-42c3-30b7-08dc483d0677
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:50:12.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAJML26b9A/jzP1bSix+R35UyMphtjh2n3+fWI2zw24cj2qcHozURz+RsX4M0s3z6a4gGbP9CUMNIcas/yWH48Jcj6AHssaYQJxx0Z0VplY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
X-OriginatorOrg: intel.com

Hi Tony,

On 3/12/2024 2:42 PM, Tony Luck wrote:

..

> @@ -169,10 +176,12 @@ enum resctrl_scope {
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @scope:		Scope of this resource
> + * @ctrl_scope:		Scope of this resource for control functions
> + * @mon_scope:		Scope of this resource for monitor functions
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		RCU list of all domains for this resource
> + * @ctrl_domains:	Control domains for this resource
> + * @mon_domains:	Monitor domains for this resource

nit: could you please keep the comment related to these being RCU lists now?

Reinette

