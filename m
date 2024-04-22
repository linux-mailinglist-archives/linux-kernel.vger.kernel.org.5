Return-Path: <linux-kernel+bounces-153498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879E8ACEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF340B21CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7401514F3;
	Mon, 22 Apr 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQFU97Cu"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161C1509BF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793885; cv=fail; b=kpMf+BOxfP9iIxVLjbRVELGAlY/yO7sK+G3gvL1wnlj7f3WFj5v30b4stpWyKW1D/GyAbM0/iJ1VCgYhnodpqPIZk3VyRt6/GOLGXcP4Vwkqcj6m+7Zx/ggbZQcHJjl+ro5W2JBkfTqqurubk+cGDW4Nxdf2hiOuSrM7bh6I4r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793885; c=relaxed/simple;
	bh=jKYIn951mNPKLWZpkdkHfXFg6sJIh0eZBQvc3qQMfrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lEu1qNY1kZICdYZwDO0t7XSjl5wASo/2XzrftGH4kUWhsPl2GVxyAeWgiE5fBr+oDQWeXD2O7rVO6m/sOHOLseOx1KWLoMoM72lHTIb8QtKyBHb0EU2/kSX9Cp1vcnwYQ6J27bjtc5n+1GGu8B0ME2JEQE3+XLmxQIAv0KjKgss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JQFU97Cu; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw+iu2my/ayKdryUVRTbRqdlTAgGJF3B5imJVgD2HXmAefDBS9o2jKMe4O8a7fZEUEJ3oXHOUCwdT496HEkYYYGRXsKJGo3N2SxJmsy/4X9gr13UJvPzXfnTP83yXVpx7sqGEtPf05eOK+GBnhvezPCnFOE5zke1AU1Fjo6lu2mGoe+IvLF6YRJ9jKCnNhE/rvCy4gHGVPp97YKX194XLLotwzP1nJ8+tkrfAUDBIcXIHZ37omxb4g2sI8LXOh59CXpqzsrtPMJYGlwG9g5okfL/a1rJmU8ZVfto8Nar1nb/7O6+kq3QWcTjWuwwP9uIPVG74jjpI8Ob7T6rwrLtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipdilj7IxjoKYXRFYrrPtythXilB6w9Ob2j19mAJ+ro=;
 b=X8LzsZ3aDHAVkXMqt6oirVgZPaWQqm6j2IHIMSoKa03IxoUfoxKwFD5RXposDGNev0G5SAp9p6u4QqNgPgmLxKEYR/BwA0DshH49dKdd8mZuXTVlrfMOm7Qhhps+p3RVcmlaHdCK3NB2eKnoGcVQP3yap4L5NnDD6sOr2LAevSgUfrL+JyqBUiR3sVwz0SrMtU3w68egOKhCLHnoI2hirOfIIFW4SGGNRm+E7xsTW0ltFY7cFicpqosVwkIfONDbO4I5r0PqKzhYNUxMZOEMDjDjnwfqDi7juFiRJNo1jT3I4IetH3rJufK0snW5Xx399gVki39yeaFtQEqHXbUFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipdilj7IxjoKYXRFYrrPtythXilB6w9Ob2j19mAJ+ro=;
 b=JQFU97CuWj8i3pw9qr+CSf6zJO6HQFnrbYSRiwWxt9OGCClFSnMLJC7MmsZc27drRSDllKoDdlnLo9JazINucwtzqpr9ZifRStVtBmcmDebwsj3savycZsaJnPqhK3I2y13mHE03QuuWgU0s0BSOY7Px3PgWnGcL/ZsmYPA5i+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:51:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:51:19 +0000
Message-ID: <94c3bfd0-e221-46c7-86c4-f0545e66f17d@amd.com>
Date: Mon, 22 Apr 2024 08:51:16 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
 <ZiE8/oXyjBef2qTy@e133380.arm.com>
 <acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a4d7f9-260b-41e6-9a0b-08dc62d349e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjllVmR2LzcxTHhDNTJEKzhLdE5tK0xvYzdWL0FOeDYvTFAwbktON3RQRFdt?=
 =?utf-8?B?Qk4yL3JjWGJPOEFFSFRILzBuTXpkSWtRbnl2YUtqZC9ST3pXQ0VXR2R0cVJU?=
 =?utf-8?B?ZEwvMGR4WExrWHE4OUhINkVaczdtUWZEZlJwSjg5R09KY2pkSGxkcGMxVUMr?=
 =?utf-8?B?Y040cSt0R0pSZUsxNTRGMTFIMEgxZjBiRTVKM0ZoV2pjbjYxTWVrbjlubE91?=
 =?utf-8?B?bGVHSzBCd0VTOTcwSzlKVVcxMDMrT3M2ZmRiOFpBUm0zMEFhQ3FkYXdZd0FV?=
 =?utf-8?B?dlRzRVpJQ3hka0JoSjE0UXorTHdlVGk3Q0lpTkY1N04zOWpFMW5yeW1yc1kx?=
 =?utf-8?B?VU1HRU1kcyt5NGVMeHdSZ0xvZkp6UEhSblM5YlVPSnlxcGo1dzVveDl5ZDJx?=
 =?utf-8?B?ekxqUHQwTTRmOGZUUGlMMmFzcXBmVXRaT0VpK1lkbFFjOGtTbTJrbVNNYURR?=
 =?utf-8?B?aHFxLzZpM0poWktMSHVVWU1EVXk5VWdCZlFYeXAyYjg4dkl0UnMxcGcwZm5t?=
 =?utf-8?B?OXI2eFJjRGVSRjUwWUJOa1ptK2FUREc4OW1kdWFrZUNJZzhTODdCOS9oelBQ?=
 =?utf-8?B?NFB2T1NDMThFRjhUMXlrcGs4WGlDZ1VrNDlXL0dYeDNxSUdWSGx1MWpNR3Qx?=
 =?utf-8?B?SjhHeE9MVjhudWhhUVdRY1FyYVZ5QjBHL3pHcmxNamx5SWhQSXJsd3lPU0Ju?=
 =?utf-8?B?TUlVem80VnMxNU1qYi9qRHdzc0lTRnJYTDFXdlczK3ZwWkVaeGxVV3pRMC90?=
 =?utf-8?B?cHJBa3N5VkdsYmNiVlBoazBVTnFFdEZmeTloVk0rU0ZVY0hRS25rclRKWEx2?=
 =?utf-8?B?WEhwRnFPM0NkeVpYbkY4QkpwMlZEQXVCZ0w5TGNqU2ZZbXpRL1R3R3VTUWox?=
 =?utf-8?B?VCtCRVJWcGtZcDkwYXRiSjZPbWtXNHQyY1hDYml4Q09UWjYxRWFuams0ZXg5?=
 =?utf-8?B?ekkwTVluR2wvQjVzMUNrcC83YVVJNVBpc0xrcDZtSFZRV3V1TmkwSHlPYVpE?=
 =?utf-8?B?dWt0QTFhc2w3QlA3bUR3bXU5VDN2bm80Q1UrbEpBQ0p5bk1peFUyZHZsL2p3?=
 =?utf-8?B?N01qM1pHQ2JJMHRxRkplSG1xbWxpZElSVHJhS01nWm93U09JaEJlZG1hMHQ0?=
 =?utf-8?B?NVp6R0JyWHdBellNNFBWN1VyQ2t3eEQybWF5aVplWW1adS9LVFRxQWNjbDVE?=
 =?utf-8?B?UHcycHB6VkxKRzZKUDl1U3QzZzRyNHlqYUhMMnNrcjVyK0hOV05OOUtnd0RY?=
 =?utf-8?B?TVh0MVo0emNKUEsvdExUZVEya2d4VUYvanJrVnF5MFpqdElvdHpwaitxWTlX?=
 =?utf-8?B?L0U4TWZGazJZaDAwRlBNdnpycUpUUHc2QkJpdWp2a2ZxUW40Tm5sVVd4d0Ez?=
 =?utf-8?B?QWdxMG9oOE94VUxRUzcwclN4RmNhaUgydzIzNnR5L3pNdXA5NlhqRXlwZWpN?=
 =?utf-8?B?WUFocDRWa3V1cXFVajB6VStrbStYTitRcXVuU2YzdmJEZFdtK0ZHeWVGTS9T?=
 =?utf-8?B?NS9vZFhFS2RkYmh3OEU5R1lOL3c0aXpyV0lTKzl5Tm9wQnpsWXdqWklQck5Q?=
 =?utf-8?B?VTcxVFQ1aEc4YlFJcHVwYjA0aDR3bDZ1bis3bHJoQUdYM0IzSDRXWWNLOUVw?=
 =?utf-8?B?dWlweU9pZ0FnRkh6NnZlalB4YWh2c2RJWGFrbG0zTmJtWXB6MXhlUjlvMUt5?=
 =?utf-8?B?VWp2aTdLSTkrakdxRnlqUVJiNGE0SGx3NFI5UmxXNGxObFhrRVRLcWFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2pPODlMVFluRHU2aDNwWWFuQStiSHp5ZDk2QkRBSHZMNU4vK0xqeG8zbUhX?=
 =?utf-8?B?dzdnTDQzUDZkK0QrdnJxSVlWM1IyTHUwcG4yeE9QcWJoV1dLR3htV3FZdzh3?=
 =?utf-8?B?SHYwYm1DbVIzM290Mk5zYUg1aFNTV0wwM3NGQTE4TzBtNWgySFAyc3FFTVRa?=
 =?utf-8?B?bExJWTJlS2tJa0JraWtjODZzRkpBU0JHZXFBNGUyamFJaWFDakZCTEZsUFhV?=
 =?utf-8?B?L0hvdm04enNTc3lqQmlvUldITVhiYTNaaEZKb1lGWGhTUTFFWEUrTmFST1Rv?=
 =?utf-8?B?L0JqSG02dnFwR1lvMmFGMFFwL2dJRFRtRGxTNy8ydEhxeXF6NFl4ZXlYU0tD?=
 =?utf-8?B?TXFxN2p6eFN5dVJyV1h6Y2VMa012bmMxUGxoZ3lxQjloS21SbVhMclpOaTBB?=
 =?utf-8?B?NVZWWE5GYTZhYjNlaDJTTUQ1cGQ0SlNBVWNBVG5BcFlXVm93TEMyUG9rRmhy?=
 =?utf-8?B?dk8yaGhydHl2UENJZXhWM1NlUUswRCtobkRxU2FhdldPMFNveTV5bGNtUnR4?=
 =?utf-8?B?WUdSRlZ4VkdGQ2VpbHVDUHhHZUl6SmxOQm9HdFh3TVhkWlYzZmE3NERpVWls?=
 =?utf-8?B?RFMrckRsblNQVUZaV1VhWVVKd09QUUlCY3NPU1VvWFUvS0ZNa3N4ZUFQZEZB?=
 =?utf-8?B?cDF2UlZlV3VodjZYUlVpZnNyUE80YjdjU1NBOFpKaEt3cnFwNzVJV0orRThD?=
 =?utf-8?B?VXJzTkNqQzNlQjEyeUpQcXovWnI3dTR0cytGb2VibUVKbjI4WXV5SkEzcWZh?=
 =?utf-8?B?Mk1FSmIrSEZrdjg1MkF0bmhhR2txbldxNE1QZENHRktDZ0pJeUEwWFdIU2p4?=
 =?utf-8?B?NXo0WUZtRDRGUXhMeTB6VFZYUE1INk1KQUVRRVREdHJQVWhKQXpKVjJZQitJ?=
 =?utf-8?B?ZDdWdW00Sjgyck5ZajJCVThheWo4MEhkWEthNUpmU092azBnRUd1REduQXRm?=
 =?utf-8?B?WXFKMG1CVVBteWVWNXpKTWlVK0JqOXBveGttTmp4a2dQRk9zeWV6ZityNWgr?=
 =?utf-8?B?TmxPeFBqczJ4M2h4QU5xRElMM1d3WDFVcHdCVjU3SUxVVVpkbWFMakNwdk5K?=
 =?utf-8?B?VGw5S1pub1lCMnFYNFZNZ0kyYXpZZE43WVJwRkRKR2o1dDd0SEtCWWxsYmVT?=
 =?utf-8?B?Mk55c1JzaHdKbXVMcUwvMzYzUHduSWJuOW11ME1Wa3d2Y08wa1BqZzBmMGNr?=
 =?utf-8?B?S3JuUFNVVWQwWldmbnFTSUVEeDVCSmtFbnNtYTNRbTIzWkwySGNOSXRuSWND?=
 =?utf-8?B?aC9UQTlsVHVwN05MTFVjVXdOeWthWHg4bVlINndwanJFeHBxUno2VlVJaEVJ?=
 =?utf-8?B?QkRMVWFSOVBvbWNBS0ZYUi8vU2R5N2p1R05NMjkrSE4zREpRV0dsajJjNUhM?=
 =?utf-8?B?UWtWY05jVEhXdkpWaTJkYWNBUndFN3U2c0ZZVWNGRUtXUUJGbXgrSVp5aUJN?=
 =?utf-8?B?SkhsUUNUeTB1WlM1VTNGZU5Ta3pNSHc1N0p6SUo3dFlpVDM2MFhqY0txcXZF?=
 =?utf-8?B?NmxRN1MxTDE3ajF5WkZPRUE0N1dBZU11RjYxMkVIcXJrM2VoaVhidHZsZ2Zj?=
 =?utf-8?B?cXl2SHk3cUtSMlV2dTBJRUtQMmo1SXJPV3BUNk1md0lKVFkyOGUvaklWR21w?=
 =?utf-8?B?ZGFzZDBPcTNDbDJuaU42ZUdkdjlFUjlrWXN6TXBoeTJIcGdoWDdRQkFGdVVj?=
 =?utf-8?B?Rm1DYi90dnNaRGNJTGloTENuQ3lscHBTb0twYlBPaERaY1huRGNrMzdzQnFN?=
 =?utf-8?B?VThCUE9VTVhEb0hBcWNlYUNjV2VqUUtxRWpOMVNPeGY1L0JpQUV4akVtZkdG?=
 =?utf-8?B?Wm53VHZ0bEEyL3lkRWFyL3VuTU12NjkwcDM0TjM5Sm90TE1CblR1SFRWeVdN?=
 =?utf-8?B?RnBiaC9lNkE2M0c3c1J2YUdXbjA0MnkwZVBreXNTdFprdHJKcmw1aW1oWEdn?=
 =?utf-8?B?SkdrUkIwMzRTYWFML0ZnMUkzOGtLSUFqekZ0dlN6Y1JsUVhtMU1lMzVXYVpB?=
 =?utf-8?B?ZzRrSFg1ZTJvWjhRV2xXeVFVaGVtWjV1am5VSGtlanlBWU1GY04rb3VxMGFN?=
 =?utf-8?B?MFhGKzEwanhjb3FWOFVTcWxVampOQktxWkNVZnBEM2hOV1Jnb3lXWUVwdUxJ?=
 =?utf-8?Q?rJIE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4d7f9-260b-41e6-9a0b-08dc62d349e6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:51:19.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vdU6GSFNx80ungic64pfyijqXr2rbRna2yor0fKkSpxSQLtsEIdffKPX+T+5Qdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

Hi Reinette,

On 4/19/24 23:06, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/18/2024 8:32 AM, Dave Martin wrote:
>> Since we seem to be getting to the end of the outstanding discussion on
>> this series, what's your preference for moving this forward?
>>
>> James will be back towards the end of next week AIUI, so it should be
>> possible to apply most of the changes that have been discussed and post
>> a v2 for review fairly quickly after that.
>>
>> I'm happy to apply my fixups branch and post an untested "v1.1" for
>> review if you think it would be useful to see the de-noised output of
>> the review so far, but I don't want to fork the discussion or create
>> unnecessary work.  This interim respin would be subject to what James
>> wants to pick up.
> 
> Please post v2 with discussions complete and feedback addressed
> (unless there are some discussions that need to see how other changes turn out
> before they can complete but I do not think this applies to this series).
> 
> To create some expectations, when you submit a new series it will go to the back of
> my review queue and at this time there are three other resctrl pieces of work
> waiting for review (btw ... one of them, [1], is waiting for feedback from Arm). 
>  
>> Alternatively, I can try to follow up on the string parsing discussion
>> from patch #3 with some real code if you'd prefer to get a clean
>> interface in place for that.
> 
> We can keep discussing that, sure.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/

Do you have any more feedback on this series. I have few feedbacks from
Peter. I was planning to work on v4 of this series.

-- 
Thanks
Babu Moger

