Return-Path: <linux-kernel+bounces-33956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4BB8370CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5891F2C2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710263DB87;
	Mon, 22 Jan 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaFBs+13"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009533A8E2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947492; cv=fail; b=K0VXMX3asVXwpf+TrYioN2dZf8rpkY9/zVNLVSDG6B7wPqY/DdBV7JFMISfmCCZFOLva93dBu/8WaOVfWzqZK2XTRmlN/Lam5qtTcSHMhkT4X7/Ry9vdTilGFrMUozbgsWgUXwYTMSEOB7pvTxbFByCOXXiFdY3PGvqXxHJGEi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947492; c=relaxed/simple;
	bh=p18kup6GE7yIk2HLawIkLJlBgV7ngksy9jDVPsxrSsw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rni2iEX6QH1yg5GCa1udPFywqBDAZVAq63m2KmQqmdDYtaj8/0d54ilZ6q3bsNjwGteG7K627HHeXw5J8sc8YSw9nZurvgirQ/DY2LuvCmttyKftAcbbZlsE8xZO6e0aISREs4+Hftx76aHPhhhN1+S6Cw4402bpcdcaaTEOVaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaFBs+13; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705947491; x=1737483491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p18kup6GE7yIk2HLawIkLJlBgV7ngksy9jDVPsxrSsw=;
  b=PaFBs+13tNfr7xtpWo90SR1saK5Ssfla+aD11G+fX3NWpd3Uc88TL5a1
   dl9YVs0GGpnnMo14b29+sTJ8Q73EAvt4Z4Dhd6Nezs7o83CaPYdLzOvJ7
   /L3lb7bzhmaymTt1C8N8Sb8sNB7StiF416UVq7hakM7JMHKlKV7NOFF2f
   EeyXDPA3b+1+UW5QlyP5CrHopVflbNA0fL/T87kgLO5PDr1DJv2dEXVB6
   P/++hSvm16YVtR4Ff9h5GvQYulqglG9XC3yTZeesUZGYW9MEM94otrmOm
   pAYSows7VMINYt7TnZN+dIXq/a2R7A+Z51Rgvfi2AIhN+S0ahcC0fzYcF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="22765116"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22765116"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1275653"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 10:18:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 10:18:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 10:18:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 10:18:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 10:18:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DetAUE7QIrQB74zs7U5TX38u90xiXZLKkeU2TczJx02+roiipMVELPgSo/OivfzS5ittn3df17lsS/nyz0crtT1M4QiJ/2U87MaJN9ueKsOo7p4Av/BjF5VoHdoaqsV9cl7PgT3vL70fEXeBSsrwHpkuH7rj2af8DcZblRBc6zkJxE+ergYwIijk8V59gII7BRwKtXz68wSwu5x61E61t4gWYPYocvOuunmN7P+32TOzfqya7p1lHt+msgDUe95OesZzH4pYx8MyJSCzlfXaLdG5f+8YNWhDzKA1S+rZmP6WOOtdNCTM54Zr4jkoCjd1c8x+PxZ0rJ5qBqBmX9A1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYkW1G2yc/qkCARLfx1JhW+n4b+L8bmYc4bWz3+3BEM=;
 b=ii+CdGl3UTnZfeW2D5Hncz4zNt8MoIAZs6m+Yu0jToNQFkLJhn9eM7/UkyYmfsDtib4qsYyeQa6qA1p9QeBqN0gVgTOl//L3zXtJyROhUggrvSZ8eion3TjcdDLIvuqLUNrB8UN/WfwS1LvLtQOjypKhEmvJdSOPEJAGKKnpCa/Hqd/b1URUTBLzYXJjbjUkKwc0SbjXOqm52i41CBy0Llr8KItRigEWed50ivgwZ7k9k1ac42fmyC6446p2EW/j2ix1qs8UVNt4peqhqlBuBvt+weX6NMYXb9nExVO2RmuMhuCQ4rjay7J/ghXOCmb0M0oUwtHVMdExEZdx/PjPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:18:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 18:18:03 +0000
Message-ID: <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
Date: Mon, 22 Jan 2024 10:18:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>, "x86@kernel.org" <x86@kernel.org>
CC: James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>, "Shen, Xiaochen" <xiaochen.shen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cca21f-1445-428f-86d6-08dc1b767946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+JyRwpeHlhOhLMUq78mz+5ebioa44rlRFbIB/58yJtDrXjiBJmiTrm46YdX09PzO5J/h5qizgT7XZJDexSXgynrbtLdvfvcWcQwQ1vv24MbfNi5eBr2OQBbsd1c+78YcaQqc2YFKkfvodE+R6SEhkxzJmgGSNBiaEIMQVFWuB/ML5iFyz68s0yyUXofkecl4Iii9GepGTdOErFEchksQGbItK3dOkiLaH4tg0ZrM/S1tRcY0+3mC1ak9bnNNchnV9m2bK+CyOMisU7z1peger2BKOl+uPFiEgubY57MMrdD92C4BRTSH9VAz/YwGVe2A4S/f/E2HkGZH1OTiRDctxbAljeC2vsdL1dN4Ib/nxjlRo3mqnUd5O8EYkmMqbWzO9eOllNlN8Bw8Fm89IdNwgNqwa7b0nWt8xJQIhK/6LCGDeE/yM2WQ2ago+Qb5KVmFAhbNFLCu+YVfPQTbcNvZpazM6Mr/lst/jhpSTIUWOtuw4VLQeYIH33Plr7l+2MW3qcUazQbV3Mze4IyxUmjbQwsv6B+gbHtRAiOrZ5EtYRzHTil8B/xhSdmMqNlKVykdbHOGLvPEqne1Yyy/otpZRwN/DV+1rmFF5W0+6zT1/mhhmePKi2JMI4D2z3aDm2nVk7ByEYibBIfAubbl30nwaEiHJi6n7aUA85NjI2xap0DNr6FmS6pR7rgKs1s6ouwSmgp9/sDeBKLZ5pczWz+UMEE1lESig9/tc/PDna8C1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(31686004)(6506007)(6512007)(2616005)(53546011)(26005)(82960400001)(36756003)(38100700002)(86362001)(31696002)(44832011)(66946007)(83380400001)(5660300002)(2906002)(41300700001)(66476007)(110136005)(4326008)(66556008)(8936002)(8676002)(966005)(6486002)(478600001)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFNd2pKbC85eTlQbFdiQndxeGUzdlJER3BIY01GSlkxV3BwbVJMTVRsMk0x?=
 =?utf-8?B?TVlRSXpPMlFVWDZhV1IxSTdGeG1teTBpZkMvMWdWWG5scVlkNUQyRkdMRkFv?=
 =?utf-8?B?elQrQitOWDF4cElNVDRpT2FxU2poZEhCQU42dXMrYUc5bTlleUZUaTErTC9F?=
 =?utf-8?B?VWpyTnF0bnZUYmVMeXlqWTY3Mkl3QkxqbkVicWhuZnRBVzl3Tm9uR0trc0Nn?=
 =?utf-8?B?RUVuWTlOVTNzYkVxdlVzdThBMEIrSkRuWVNHcURwZEF0U2R0RDNDbGFIdjRa?=
 =?utf-8?B?M045ZnYzRGRuaWd1WG9TbHV0RktzeUdnUVVId1FEaENkVDdzNEJ5ZzR2bFhr?=
 =?utf-8?B?YlpkY2YzVG9OTnBnTlhkTEkxU3BDNTlZRVhoL2xSMmZNRHdTeUpBaDhuMFZJ?=
 =?utf-8?B?b0tzb01UK2xTKzJZL2EvSFBlRk91bzdBenJFdGFXSHc3Y1M4MWlieks0VFph?=
 =?utf-8?B?bVZ1eFk0QmNrdW5sZE0zYk9iaWkrUWNLNWRra2xwRTVRd0djZzBYaUlLa2VH?=
 =?utf-8?B?WGp3djhhUVBMQnFsWjJvV01tbCtHTWZlSkhCS0MwdDVDWjNMaTdVcVdTSlNN?=
 =?utf-8?B?M3RmZ1k1L09vbEJQSlNBQ0Z0K0Zkam8rbytXc2NRbHB6dG1yYkNpMDVwYUF4?=
 =?utf-8?B?cFpDd3Y3U2orY240R1hmZmJyM01TUENuUFFxSzYrYXllQWd3TnFCRVlGRG9I?=
 =?utf-8?B?QUtEaGhGYmdPWFlQTGdvcVFsV0tvcENDR3daNlFBVzFYdURHcTdJYktkdSt0?=
 =?utf-8?B?ZmhCZnFRLytnaDZtU2IwN3ROME90cE5mYmd2NFcraFZKcDJmWFcwRzlDYXh2?=
 =?utf-8?B?YkxnUzA3N0lpQnFyM1JERy9iVHV0VHlSV0N3OTRsdUpCSHdBajFKcFlHUGVW?=
 =?utf-8?B?QlF6R0NHamN6TWhGTWVEcUJxc1lDQVJyZytQNENKKzg4NldJYjl4TFNHaUZs?=
 =?utf-8?B?Z1pjaEtvYnVJZ0RNUUgzdG1WbDlPYm0xeThZZ2FwbXppSDFGaEdhdHV4Vmxl?=
 =?utf-8?B?RzhzWEVwdm9mRU5yT09xbnpQV1RrWlVhaitnOWdwVHRja2MzNEhwOUpkMHUw?=
 =?utf-8?B?Q3I2L2JUTnlOOXpOL20xZ1JMV0tYb0Mwa0ovUUtzQndncGdBd3QyaitjMTkz?=
 =?utf-8?B?aG0ydk5DTzVyVmY4YkFFYWdHNXNLSU5VRFV4SWpNMFFhazhwTjlEU3dPUDQv?=
 =?utf-8?B?N01IQ0dDeks4QWZUSzdxZ0ZyWUxTaWdzbUdabXYyY0p3SkhvSkw4OWdvbVpx?=
 =?utf-8?B?YjBDdlZaMlBnSnJqVFJRY2U2SUNUV05kVTJYbklmV3d1NjZOQmFWNjJpR1N2?=
 =?utf-8?B?WlY2NGErWXl3SUZ6a05TMGpCQ2F0QlZsS1hGQVhLMGpMaEdTUjIvT1k0NGVh?=
 =?utf-8?B?eGx4V0s4b3hUN05yRm5BRm1TUmRPTCs4U3pCT25MNFJGeWU0OEVZSHB0SXFi?=
 =?utf-8?B?djFrdndUL0s4V1F4aHp6dndYdE1oNUxGRjJVRnAvbktuRDNyYkd4Z1FId0Vq?=
 =?utf-8?B?aGFlSmRrUmIwaGwrbkt5Vmpob0ttUXA0Qmo0QUdMNFF4YTVHMHVCVjNxWlIz?=
 =?utf-8?B?RFZiZENjUEpoalpzT25kWWNxZ2hmNmZsNzdFNElPTUZVQ25TcDJkYXpWT1Rp?=
 =?utf-8?B?cWlidkh1eUpUaVJ3VHdXQjJUejlNcHFJWkY3VXk0MUFqT3NsZWlxNGdkb1ZJ?=
 =?utf-8?B?U0o4UDN4V3VyU2dMS280dmFCMWtwblhqOG5BN2JwKytQb0FNMHRSYUd2Sksr?=
 =?utf-8?B?ejc1Y0RPYllTOHBORVhybVRuVjJsMXZ4cFZqVWYxamt5ZjF3cjZreUQ3MWVW?=
 =?utf-8?B?M3kvOGRtdHJNQ1p0Q3N0bVUzWCtmNGVsSk9aVmMyd1JLMDdVZWxMemVLbEtH?=
 =?utf-8?B?bGZBYi92YVhxYjBGUzZlRlFBakYrREFha0s3M1g0RW8xbVh5aGNKU3dZdm1o?=
 =?utf-8?B?VUovSURjaGxLd1hUT1BBbllkMmE3bzFQRHRUK09pYWdwTmJ6M2Fnb3kyOS92?=
 =?utf-8?B?V2RyYjBhRzcrcFl2NG9HVU5OZ0ZPYzlDU2l4eFZiaDA4UUNzN000S0wrSVFN?=
 =?utf-8?B?bU1QbUVUQktSMnBIZFZ2cU1xSDlNdUZwUmlNZEpENE9xZHZzeG5WTnRxWEYv?=
 =?utf-8?B?aGlLbmpNbUI4MnNqWkh4OFh3OWY4aVN5YzN0MVZYU3ZvbjcwZFpvVGtaTWh4?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cca21f-1445-428f-86d6-08dc1b767946
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:18:03.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVZwmtOXGfbs0tjiw0HYL91g5ZhzocvaovCXx2qF21tg0QmPop7527HjmHss9VlIhTj8fskVGG3uRYEQYg3Wz8pOgncd3fjvjsE2hI5KrKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com

Hi Tony,

On 1/22/2024 10:07 AM, Luck, Tony wrote:
>> I am sorry Tony, this reverse-fir breakage slipped through. I only noticed it after
>> trying to see how best to present all the pending work to x86 maintainers. Could
>> you please send a fixup with this addressed? After that I am planning to propose its
>> inclusion among all the other pending resctrl fixes followed by the SNC work. The SNC
>> work will need a rebase starting with this snippet, unless you see an easier way forward?
> 
> Reinette,
> 
> Thanks for catching this. I can send v3 of this patch right away (just fixing fir tree order only
> needs a compile test, not extensive regression tests).

Thank you very much Tony.

> 
> What are "all the other pending resctrl" fixes?  Since the SNC series is invasive to so many
> files & functions, I'll need to re-base SNC on top of everything else that's happening this
> cycle.

The fixes I have as pending are:

[PATCH v2] x86/resctrl: Fix unused variable warning in cache_alloc_hsw_probe()
	https://lore.kernel.org/lkml/ZULCd%2FTGJL9Dmncf@agluck-desk3/

[PATCH v5 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
	https://lore.kernel.org/lkml/c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com/

[PATCH v5 2/2] x86/resctrl: Read supported bandwidth sources using CPUID command
	https://lore.kernel.org/lkml/669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com/

[PATCH v3] x86/resctrl: Implement new mba_MBps throttling heuristic
	https://lore.kernel.org/lkml/20240122180807.70518-1-tony.luck@intel.com/


Reinette




