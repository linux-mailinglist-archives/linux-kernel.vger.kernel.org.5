Return-Path: <linux-kernel+bounces-136199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A191689D100
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D722FB217AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D1757F6;
	Tue,  9 Apr 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPXysh3f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224974297
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633059; cv=fail; b=CuSscaNEZHPVL4reTIADY76S7c3RN5awckTEDEoigkoM9l2lDvSVs7sv27QTjQCC/c+oaTpv4jQMUM//0un4I4+FEw/U36JrVujF8KBNWZG32RKHxG+u2A3UstdRi+phEoza2W/I7q9eSgURxubwVIbEu7le9LdGFmrk74KqhBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633059; c=relaxed/simple;
	bh=olUpKGHpBuPqqabY8IQq02a9PdvMYzwKKz9S6HZFKjg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxJaluuw2Tk0EGjUOPoj2aNvQF99ganiEahRZWrgFQ9T6H3CURHO45mImj1n6NCeVOjgoMWnDZXvSFub4H/R3y5cFXWAtvYgHf+RgSIJnKovaW/cpBrix+AdvP+df+yN+ZGa1nOjBXOLl7Giq7ubURKSSrWQ0zxdA0+4NWdakVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPXysh3f; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712633058; x=1744169058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=olUpKGHpBuPqqabY8IQq02a9PdvMYzwKKz9S6HZFKjg=;
  b=BPXysh3fR39vn3/7zgz2wspFln0LKOvt4vcSVTqRdM+jybJQeGjO11v5
   cQ3TlsDnMgldN/fCdaIphD2OMttBSdcyyNeAhpz6PKZKPKo5NrrfYU6FX
   kgIfWbg9ILlMyIKxz7TgoRVM8N3vcNI93L95dRyH0pQShzwveT0RRajOa
   t6t1CozxAHsLoKC3UAwWLqZGdmxth3TyqI51JDNStVWafJt9OfJ0REqYm
   vUF7PKclfhcryvO3OleuMWOFs6PYnU+oSNg8AB+SJzbP6+684mS1dV1bf
   PYJUvBwTppXrMbyYiYtC0B9ViKO4Z3Py0+F5CLEHoGR+TUkjeC0vG1umx
   w==;
X-CSE-ConnectionGUID: 8lQ9rS0mQheMtjCtGxNOJA==
X-CSE-MsgGUID: wZkSwnOvQtKVj2vPJC9fMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7847862"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7847862"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:24:17 -0700
X-CSE-ConnectionGUID: Or9lpjwURZ6AJRhXfcYzoA==
X-CSE-MsgGUID: iuVMxVdhSPSCwrVJ7Tt0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24730355"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:24:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:24:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:24:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:24:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOWceFEF4zhL4eHYayyBK89GeBgrI975kPRM5Mq5tc18/g+tdmF8chQFlXyfzTVuHIil7rtvpTuk3elmOZn4yvxdNejJw4xsca4rn1GDMxRPH4OX7HU8hyPBbM4oCKSUU/rezwUmrWsHYWXoSEXw/uD+QxoIVZ+lFZkBibCYgM6uiqf89RfqK8QbJBxGijxWn0nThDlrUbiuZ9yWP73LoTWfp5QDXvfK0sShGYGT7f6chBTviTaFt3fqzEVUfOyg4IUC58qP1OAAQzvvEkMAU/UOJ1PUA6PuNhJQ1joB4LEsJUZMcQuQBjYNwKbiOXDMs/Ho2WZTECDyOL4l9kF1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngBaiy7lnyLshLGnTQ4pPpQZVSfGu+y9tm2aUfub0iA=;
 b=GyQCtguGLKAP+XbT5evAZ0V/m2ttQqCRUzhzLG8InN3HBrhA2geOsNBMAbnYtatM1QQZT+AVN6tWOdseOeFSXmkBCriFJn0d/EYolscZuwWNGaL2nEpIaHP1ljLxQdcbAM/Z4hxb7/sWXVwbVNfOGuWAs9L3GeynnzInX8OhVd3aG9vmdYThvgxS9n0E2KgTb1EwsrMRR6597ERLNZnQd08SrwOYYLk0Ot8AxY4HQv1BoWFUfRjb6vOcWcaLON05e68BI+43Hxup8K6UtRcnhKfERRskc6yIyVy3UxJlqJzKx2uDfPU36pDsQYROyyZ5JDCs/UFpcpxOrxIbxPVF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:24:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:24:14 +0000
Message-ID: <6d563361-87c0-474d-812c-b33e79eacf3a@intel.com>
Date: Mon, 8 Apr 2024 20:24:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/31] x86/resctrl: Allow an architecture to disable
 pseudo lock
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-21-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:303:b6::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W24edgky563i3z8KB/WhQh4y+B8mTONynjzkr+QOaHj4dp1SgeNhV2YhK1zBva2zy5eh2T9Xdg7GEKrssz+5ezFSAkmSaf6V+PQTE0DKP8HM/pC7AWp+hepVLlIhqfooDe+7vMlOlhtxQTWwU92wAqa2XVyClkSK/rIAyoGZP0CgfvgCyjnVB3Ny6QuAaBle6PPnOhIcm0hwi/0prEDRZQnMLT0qYFy7z9ktMwpHdIab8fxqb8ipjxBd+nUi9JMP/ZnS4Jgz1jnNymeJ1bWQ3vwT4/nZBkgHbbZOqY8YJR9g24kJ30xmXQd9WMJ5pZbTDJhEGK2sHx2X/ePzTEcLcnqwKrpYtPkMZ8/ZdjVpUmNtb3y71zn/xnSKK1JutupvesZBqK7L1isIexEcsGXlYR63uUsoJKkH2gEqXHSGm3H/6zNYCpfKrjzZW1dm2boYqHnHQtiPrXHLl5IwiXgVdTfyutuQlDScCqNtpDlvODAUZmRoXJl3UHM5fjnZ/S2IEWYNMKz9d+8L3BHqmOdN9+64DVkXBqOWnuPRx4YEfjrPXquewlPgkwPRlY6EEPp7VyiFfdR+5Akdh2JNBVlpb6f1OtZ2xEgxu/O0FcMDs+9oxMoxmIGDR6iscQsP90HQkAz4MbGT641QX8onJPA7NClnnvaFXTpeytVJDQb7PqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VzN2Y5b2oxTVE1aFNVd2NTcUZ3UWI3S3h0cDdCVGxTcEdESHBhS3k3aTNY?=
 =?utf-8?B?SVB2QmJ4Wi85aW5NUTc5L1NxQkljUHZjS0EyWWcwS1hhV0VtMHBldEZ3dFg1?=
 =?utf-8?B?VXdxOVdoVndKWHZ4THZuZld5RUJmaGVmVjlhQVk1c0lKcEEzQVdtaEtEaWhL?=
 =?utf-8?B?YWU5T3RGNG53dTMwNWRXNi8zWGltNUpSS0tPb1JjckF1RjRQUEJYNVlvdytX?=
 =?utf-8?B?c2cwc0dnWDlqb1ZTMUhJMStOZTJjbGxOZGpybXB4RGw0aTRNbHdCZVNRZVVR?=
 =?utf-8?B?aFVHd3ltVkt5RE94aVZDL1gvbkRaR0dpODd0TkYvMjFxaXJnQk5jN3I2b3Y5?=
 =?utf-8?B?M1BwK3lEam1JK3l1T2llRzBLeUJtY0ltNldPaWZWRDd6elRqRysyeVVaOU9r?=
 =?utf-8?B?b1U1Qjk5T2lnWnBiS0t2bWJFSGJxcDIxWHFnM01lUERUNGcvRkJpRUk5YStV?=
 =?utf-8?B?OUJqMER3YnkyelNPZ2hteXlSLzhBV1pBQ09vRGFGRDlFSDd0WlhmT2RCR3Jj?=
 =?utf-8?B?cFQ5VUtwOGZBQkJWNG5oMnR3WmU4Y1ZiV2daMTVDQTdHNXJFdDUvSStCamJJ?=
 =?utf-8?B?bklkMmFEZXB5U2dEMTkxSHhlSk56SW9URWduWG5qMk5EbmhlcUNkQU93dkFt?=
 =?utf-8?B?OHlEUHhUeFQ2VUhRMlVGSWMyaUZCWDhMcHBCMDhwMStOR2NCZUhzTXZibXBq?=
 =?utf-8?B?am5KTzVPRjdQQlVLdFFPQm5xQWo5bFRKVnhVaGNPWkN5QUJnUWJIa0VzVk1R?=
 =?utf-8?B?cWFqSTEwSUExaG1YTWtYNGZUZDl0RWdQMDdwSmFrSFV5aWg1SFdiaTFvUW12?=
 =?utf-8?B?NVEweXVIbTd4aFdzUnJ2TE9nWGV2WnNjdXhGQTBjSkNsNUYweHJaWCtVbjM0?=
 =?utf-8?B?MW1vd3hmRjhnSVV2VXVncmo4cGJXMDhWNS9ZTXZwSVNjdTd0UXdTbTF1SmdJ?=
 =?utf-8?B?L2EyZUtqangzQkFCV2pKbGw1MHAwVzE4WkJkQWhSemZ6U2dGR3JOMjVIcHor?=
 =?utf-8?B?TVg4djlxNy9IbEYyam80MnlHL2M5WkFScnFWWnJ2OVYrdTR6THVxZmd2ZjZQ?=
 =?utf-8?B?UVdKbFBXMkpYZitHNC9BcHlBMXMwY2J4YmE2bXRPVTRqWkZsNDVxNWJLbHl0?=
 =?utf-8?B?QzZaT2Q2ZW9OQ0dNNVYvc3orRjM4MTVBOTV6V2JLYVU2eGJ5bWp2U1RacWJj?=
 =?utf-8?B?K2ljOGNsbm9sREx3RTVhRDlFd3RxVFVSRk4ya3J2d2tHUEo5aFB1TW5QOU44?=
 =?utf-8?B?b204SGhWQ1l2b2FVOFllM2c2Y0FoUTY3alQxWEE1eDVBQ3hXLytPbktoWnh4?=
 =?utf-8?B?Lzh6UENSL1ZiMy91Z3k1YkgwWjNaa1hNVmV6TWVoNktMMXVTODdicVppemZM?=
 =?utf-8?B?MnNITzhQb3ZRTUp5Z25qODJHSXh2N1kxSFp3eWdHRXBFd3o2bWtoQzUyVmxx?=
 =?utf-8?B?bXRwT3ZJUm5JRExKeXdrbzJ1S2ZqSmt6dTlSNFRQQ0hWUm42WElIeWJ0bGgw?=
 =?utf-8?B?QlNmUERGaDE2b0ZIaEluZVJCTnRldUVZRndySW5UaDFxanpQUllTTUlkMHU0?=
 =?utf-8?B?VWZFeDJSOWhMUzQvbjlpQTZEcGtBZXRTRWY2T0V6djlVYVVoTDh3UDJBOEpL?=
 =?utf-8?B?NGRMeG9CMDJIV0NsTmU0VTJYdVhIYlBBQlVXblpIUU9GUzJHa1ZTS2ZFUDhv?=
 =?utf-8?B?aVFWbEtYblNsbWFDRnlxMEJGR2NvczhWQmZxbnFoVW5TeFBIMWhrRUg4Mmsx?=
 =?utf-8?B?TUNtK2ZzamJyQnZNQ05kT3J5Y2h4T01LZXBDQUo1UjdmN1N3NVNORC84TnNx?=
 =?utf-8?B?VC9NUDN4NEpqUUIwUGt3MFZVZkxDMWtHYUdBZmpreGJKbUZMdktNaU5qR0lI?=
 =?utf-8?B?eXh1UGFzWFdzQm1hbmRhaXhoNGRrMlM5dHpLbjRNQ09Rc1gvM01JUmtOend1?=
 =?utf-8?B?MWkyWVpKOXoxcFhJT2NlZTFZRGtIVzQ4WFZoa2ZpMG5Ma0tjNnFsaFRPZ2k5?=
 =?utf-8?B?TEN0SUdkMW9aT0FFTVJReUxBblArWXdNNjFNMVREQ1Uzbi85RStlbm04RWpS?=
 =?utf-8?B?WlBEUGdjYldrNzhWK1ZrSnMybW9wRGprcDhDQUFob1hGK1FuTk4vL21oeDR0?=
 =?utf-8?B?OVV5U092YVhORnFrdExXSG1iUDBwTTN5L1lRUUJKQnlqY2xKTGRBNDY0ajYr?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea33e12-4566-4cc9-5123-08dc5844882f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:24:14.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psa6E8hMzlDA4AARGaIFYexrPdUq3QkxCvsn0ZLaIWdIPyHVTzQ+WmdJoKIh65qse1BRIp5V/0t/f95l8mGaNf21tLHPzfZliYSAiK5Yvug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> Pseudo-lock relies on knowledge of the micro-architecture to disable
> prefetchers etc.
> 
> On arm64 these controls are typically secure only, meaning linux can't
> access them. Arm's cache-lockdown feature works in a very different
> way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.
> 
> Add a Kconfig symbol that can be selected by the architecture. This
> enables or disables building of the psuedo_lock.c file, and replaces

pseudo_lock.c

> the functions with stubs. An additional IS_ENABLED() check is needed
> in rdtgroup_mode_write() so that attempting to enable pseudo-lock
> reports an "Unknown or unsupported mode" to user-space.
> 

I am missing something here. It is not obvious to me why the IS_ENABLED()
check is needed. Wouldn't rdtgroup_locksetup_enter()
return -EOPNOTSUPP if CONFIG_RESCTRL_FS_PSEUDO_LOCK is not enabled?

Reinette

