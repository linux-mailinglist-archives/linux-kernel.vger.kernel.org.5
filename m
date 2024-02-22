Return-Path: <linux-kernel+bounces-77530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470908606E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D85B22087
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905D1B7F1;
	Thu, 22 Feb 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/9dz9oO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01E224E8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643943; cv=fail; b=Mmk3m8QSTwRPr4U1773JQw0H76AiPPVZ+0xCgZ/Rst2fqsx1QGEoKQ1fqi8L55z0jQ7MZmwrAUybwrzsMFmkUllZJdy7k9EOjfQJiEtGGtqyyxhE+5eJGfppaa3AzQ2RXJxXnLybnqygOj9pDH15jREKVTPI/Bq36dmlpVXafwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643943; c=relaxed/simple;
	bh=OYLTn1OYD46XmbvFPAmKr7g/O7aUO6QeoKobQSbckiQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZUenCworB7Lz7Cciu/3yvTitOCpRuqmxK1SzN57BneH2ld0o3LGCsdCWQEzfclSiRZYp0N+vBfK4Re8qAtdPTzqdTnYElh0M8Nne06+JpkCRZQU1NGRyQ6sOxWlWbqXjJMyvy0bE4eHyC9TSAsEJCAFeV//XXaK5JbU3/nIkRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/9dz9oO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708643939; x=1740179939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OYLTn1OYD46XmbvFPAmKr7g/O7aUO6QeoKobQSbckiQ=;
  b=S/9dz9oObyUeIflQhEDzVvwsf/glWaGWsKRorfq+97uSn9lCK2gDdk8p
   sC+L61TRfivXL1Hu1m+ZuYRlrqCcPiFWUalTnhr1kv8EPVBpQ1i9qTnjX
   oHSboC2ODYdPi86dG9aVHSclVyesG/u/+bWGTN9eRI/KwZZuR22X8ATHG
   9+UOrzthC5qCa+cIaOHDjDFTRmQlf+UznG8IEcRwVhPQIS9Q/pFre0Q3o
   9dExKuZ1A7xQ9PK/duYAc/f9su8d2JTxnvV/G1cFv5YnHwk1D0Aj7Ns2e
   Ft7mk3QvEtPNXVm1RhsjLsQtJSc8l+ohSkqg4uRN34myI6bnmtvLD+gf4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2794509"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2794509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 15:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913609807"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913609807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 15:18:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 15:18:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 15:18:54 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 15:18:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9iVTIJ6gdwrNtks1BVRsj1JbZ48SixiR9ie1aY1tYvbtQXjZe4cqi+qqRA7zwn69USsTOXcxVllVEmceiY34Cyiuqg6wl/Sf/KIVsDI53/93cTGDVPX6blE4At7BHNive8cnRMSQYAaEThE7+547yfM4iX+qQEi04SuObsjSHTyMaxnZaAkBwFG0EofEBq08umzkjzBUn7MoTNypQSiBNPq3+w7UTJrj8X08R5icvMCXynNWHEJZeP6lLpjKjOKodt/uesHcOeDWNlZ9HmSxtQQPnTEVke31iMLEcIjozYVixgvmaeWLTqrMHrH2Wk1u0rbTQnU/mmW8wyH5txNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scIOk2nned4hspZE3eLDairM5riO80IA0kE1CPArHg4=;
 b=X51ijOrqsjfSjha7QepCtNEWjj+KPFmA+r7CeA4GEZWW4CRol5lDrgrF4GWOjTqpHI9e3sLtvS1alN4qdHq3n7t+hyjygKtIG+DNJaqYjGpiWU7l5VVGB15Es4NcODU/gU6a2FvzW5Jych5/Kve8+aQaW6mqgjWmCJZD3HTjgzeXtSFSOusrWblUejw233JretkFKjxioFsvXqiMxz5qAx1UvW1buJZlFMuA+9i+4NSb6osUHEdVgytMpHHSzj3JuGSeSfM9QJ4n47MFsWmZuU9z3mP55uRGS+QPRagghNMCS/e/RTDVY1mt9iBW3iJMGRlyoOONF87OCqVgcol6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5381.namprd11.prod.outlook.com (2603:10b6:208:308::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 23:18:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 23:18:49 +0000
Message-ID: <19d3087a-dc2c-455a-b225-6ac114631f74@intel.com>
Date: Thu, 22 Feb 2024 15:18:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] x86/resctrl: Pass domain to target CPU
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240222185039.72201-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240222185039.72201-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dd2de9-3a98-4963-5b01-08dc33fca079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcFIo8mC4Kzu+X1U6gvbLlqJSqlQRdi/dGK1iRTI/TT+TwepOOW7CgY3q+PtCKJs6POYRfvnT7WzAWhoK2V77UcFrRoqnTizQiHhXXgeH6LHkDNQqjP0of26+BXiTibHvMR+qpXrKeD5fmSa62rxW3YJEHmp6yyCVbUn6POTTJBtSUIKFCI1V2tCs8zhZ7DlxVgOUZmWXutxC9YaqSaYPnH7HCh7zhzYBreHIJu+CkmHY5dCX9IGnhV9UsJheJUTH5z0f47qiYOrlgcr7L0T0gk5gi8sRlwWnpHMyyDEh10DmTXttzaq8PO030l5c7ludp+sqSOnfF5SsKVyPoetngEWLkYIhMzYk5FchZlrSdC6tPPVikuKDCMXVYpY73cQcI0hP/nHr+GyGZvKqOOMMtVAbPE1Wiwz6kCUcddPXB1yIDqy2Aat5nkfXaVoHmGzxFPylcRh9CPkJSyryPHkDI4HfNQAH5uemGAZs7akjul9DuoMGufJjkvGdnN1z3RTjp48Ac2iN5Kx8L1RGHO0yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3o3TmJ3U0pOS1paeUptSHNrbnJna3l0Q3VmRCtPanY2QjJNL3RSU1MrbUpF?=
 =?utf-8?B?S1l4aSt1NkhVOVpFb3BVd2ZMYzhJSW5QdFZsV0xnV2g4dHNMZktsdElHTzF4?=
 =?utf-8?B?OGRTck0vbzRKWmxCOUtxTTV0d0ovaHd1UFJZTEhCaFJaV0NtZDZjNi9FdlVw?=
 =?utf-8?B?aU9LK1JDYWdsNWNXSTkwRitZQ1hVc1Z6NHh6dmxINVRablc2cy8yaHRma1FY?=
 =?utf-8?B?amRVUHFaK2grVFB5SG94UDhDNnoxVy91V1Z4cm00VzhRQkNmQ1cwc1BsNkFZ?=
 =?utf-8?B?aGhqV09yTWo2eDA0Y1pGOUxmc0FOQjdEQWRaYm9ueXovUjlERGh4UkpaNGJq?=
 =?utf-8?B?by9vQXJwekxPQlZaUlY3Z01XbzFxdU1wY1lwUzZjWGtOZGhWSHI0OENHOXhi?=
 =?utf-8?B?NXlNMndIS0FyaGNWbmpBUEpOSTNmQVZHdWhqczM4QnZ6cjJjS0pML044UG5E?=
 =?utf-8?B?RXp5cWs0bm1hZnVlMmdDanVYQTVtdzlZeEJ3Z2dxcVdBTGZ3SHd1SVZTaWU4?=
 =?utf-8?B?ZGJoM3kxTlJlRTlPVnVCUGNmV3QzNjRib2hTVGE5NzQ2QXNFRk5Lcm5WUllu?=
 =?utf-8?B?RkhycGRDbVdXTEt5UThGYkk3ZGpMalMrOWd2c1VzR2xiRjV5SythN3BOdWJM?=
 =?utf-8?B?MUhzQmIxcjlTNzBRZER2M2R1OWVqcng4aXZVaXpWRWI3empGYmZuWmdhRzMy?=
 =?utf-8?B?Q1A1ZU5iUnRJSHVkQlpYbXRjdjdheW9ITGg0dHF3OFFkQjNyVDR0SVdJSEJJ?=
 =?utf-8?B?Y1U4WTlmQUUvSGZlK2FzSWlLSUFLQWthMlpPN2ZWS2pueGhQRHNiWWdVR0Jt?=
 =?utf-8?B?TiszK0cyT1g5T0pmbEpwZm1nTDBjMkFSTUNGdURPcW1xT1RjckJraURoNm5S?=
 =?utf-8?B?cktKRzcrZlR5UHdGQjZIdVl1cEdhWDNGS3N5SGdPVEM4Qkpkb09BZnVlNVJl?=
 =?utf-8?B?KzlZTXIwa1p4eDVDVXhORWJzVVFUa01zbEtwSDVXdXlVUTNBZG8weXFYaWgv?=
 =?utf-8?B?Rm0xclhJZGJDSDd3SUhvWUxTWVhQOHdqZ3YyZ2x4Rkl0S2N2NERQUzNMdVBv?=
 =?utf-8?B?QmdITTQwSVNiTzNtUkU4V1dLN1NBREhRTlZ3dTFYTDRWYjlVYlRXRHJuLzlC?=
 =?utf-8?B?a1o2YlVtMzFwRFN4R0tob3NMbm9uUFNyM1ZhYnRJUTRNcFVTNWRubVMwSVN3?=
 =?utf-8?B?Qmh4b3FKL0JGTFBQYStTdkRtellFbWpTVUtySEYreVJlbFN5S0ZFZ2FKN1VI?=
 =?utf-8?B?akVFdUcwRVBvQ3dwaXFjK0RzU2ViNWtwUTQ4OHU3ODJWNTd2ZlBoNVBKbFZ2?=
 =?utf-8?B?aG53bzJDRkJXVlBURFQ1NFZDSEx1clQ2YWNwZ0hxZTIxOXlPRjc5MzNOVG82?=
 =?utf-8?B?RExBNHFHRmtyUXdhaFpONS9UempyRDAwN0M4MXBIVUVkTEhpVmh3dHMyMzVL?=
 =?utf-8?B?QUJ4cUxYUGk2MkJIRXhId0FCTUJGc0JZR3ZVTG1URm0ydjVSUmZQU1g1QWJr?=
 =?utf-8?B?QjhxMVpKSVNTTXBZVjNzaGFOY1RjRitwMllxQWxReDB1ZG5PN2U2c2hma0Fk?=
 =?utf-8?B?RHQ0WjQ0ak5yb1AxMThMVGxVMmxKNDRhZEkzS2FPQ0p6RXFzUW05VHpKdzZB?=
 =?utf-8?B?SytPUFQ5dCt4M2NkdlhSTWlSeGZWSVRodkxVZUZwNGM2NGpaYStJdE81NnV3?=
 =?utf-8?B?TDljZ3c0Q3ptUU94TDM3MTJCYmJYY0plbVFNWDBsY2RVVWNhRS95eUxkOU9N?=
 =?utf-8?B?cmc1ZndmUlNJUWlHek5aSjgzdG8zcHdKRXBIRE0zUUhJMThPOUxFOE9DNFhU?=
 =?utf-8?B?S1BYalhmVHJrMFJhTXNpV1VGb0lZU2FuNHErcXN5OUdwTUJzVkNOQUprU3lk?=
 =?utf-8?B?eUJ1eklhb3U2d0crTUlvV09EKzU4amJlY2NJWGV2L2hMSm80Uk1FcU9GcEVM?=
 =?utf-8?B?QVBPUmhmM3pwb0M5MXN5QlE2RmhScHBuRm8wUTNwZndLeElRelZEdVgxNXJ2?=
 =?utf-8?B?dDZ0YTFSeWg2eWE0TVc3TFc4bkFxREdiTTdPbnBwbWlWVXp0UnRDeCs2WVN0?=
 =?utf-8?B?bDl2WmUvbUhHWXJOUElRaHBMcWN5aDV2TllaUzdpYjVxZjk5YlY0Q1NUVzNR?=
 =?utf-8?B?T3lpd1Z6L25QYzQ1Y1lDaGpXTmtFZlZKbTFiMGZ6bnMvYUFYNndDbzFYLzNs?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dd2de9-3a98-4963-5b01-08dc33fca079
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 23:18:49.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFDVAy4nPACKM4y8tbeHHp/o6UiYqFntIWqxnhC6tul742sZme1OJjhrSOspudblG1zH7IXw9+F9Zar6GIwm0VDsWTOEDxm9c/nNZ1ptM6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5381
X-OriginatorOrg: intel.com

Hi Tony,

Is sending new versions of patch series in response to the previous
versions a new custom? I am finding the SNC thread [1] to have become
a maze and now this thread is headed in the same direction. My understanding
of custom (supported by [2]) is to send new versions as a new thread. 
This thread even complicates it more by mixing versions of different
features in the same email thread.

Reinette

[1] https://lore.kernel.org/lkml/20230713163207.219710-1-tony.luck@intel.com/
[2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

