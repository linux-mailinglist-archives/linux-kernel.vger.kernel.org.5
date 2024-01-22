Return-Path: <linux-kernel+bounces-34102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5283738A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198521C26F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1F40BEE;
	Mon, 22 Jan 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQ6wY2y0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA43DB86
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954246; cv=fail; b=GfmwIp6llwb5bE6naZQlvYZnEImnKaiUAL2K6TdKIWWZ56+lin8z9TnlC530ckxkpT+ElxBJyz7vFEbGOvN+1vMY6+VyI9YaWCpti+qXFSfkPRh/5UcKw+l5Y4P+rGCaOH1O3If7vu/0xyvVnJYNGoFB+XdkxXdKLO60Y/kT7QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954246; c=relaxed/simple;
	bh=8Mjp4I8IQrvGplmOLAp4c47jOxJw/GpqxKXsqRzy/OY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WeapUP51f+M9+CwxnhGigZB9TNtV1J9OH2uxupMcx0mlosk14otNWio1xmcOKhY+1ECyzkgEXQOeszbSbCEZ7hNEQxBSuPZ9OlP7s07we6jTLVjG3AhJOmJmJvKTZSBB0/5WkBnBS2bnXXJLa8gISo3zX7aDniC3CQPGRZy/faQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQ6wY2y0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705954244; x=1737490244;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8Mjp4I8IQrvGplmOLAp4c47jOxJw/GpqxKXsqRzy/OY=;
  b=iQ6wY2y0Qjcz2YpCSX9bflH/DQ1nLotJNOBIZj2wYTt4XwTLdmAcuitC
   cEXFg/ev4XSVZLlFbPdQ5VqjmSvKQVl/57BnGnP6HZ0E+unHrlUr4Y/uP
   kO9jhBintCCSs+FpJ1YDWUI8cUVSXZu2t66Cy9nPWVODc7Voa34nzPW1B
   jls25htbVXkagpNn1IucrD7/jvtIme4rurLHp5VtKGbIh/h333w93lrY/
   N4zGPlZX03w/dEdHHC8dpgxWTKqrZriaj3iQUQH8wEbWVc0KkzsugLEy6
   FaDhtdTsN/sQKXMNZqP0i4+khlJt8btV49h/X7Y+Lofs6w0URV5xwG6nx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8683710"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8683710"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="819831939"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="819831939"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 12:10:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 12:10:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 12:10:42 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 12:10:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv0JM9o9E87RHxZR1sRrJ5gUX4x+WN4Z5lEiYE9CRDz5Eq40s4/uZjwyfbE6MsWfysEkRFowlsjg3nqFuI7wqODCYrV/rcojVnuTKYH32qS3FYx/jWfDUKJUWTk8RM+LV3WdXvBlDz8KGLfvjh8P148YRvIEegIg9/YDC9I27D3zVrAH9fF9RzflU/aZGc8PuHrjBIrMB2CvrRaV85aBLwpYaOSsx7kwpfFXquVO0VjZbZdYGm+uGU4RhCEQQklNqfTHDn81jfV1NOLaquzQdrSxKR/mAg7e9nL/G3zLTIH/OOP+kpTZTvKDumOLSj4BbJkRHthY1H2QJEPos1P7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tm9/wax7jCcDJ9puHfrscWKZTEOShv6luvpC8Sh/fM=;
 b=SlRkXhi92+snmCNi6KaGonJ772KWtoCl0YTwBcj7Bgve6URjz+77wk0ONo3K0BNU/CF4Ppk5K6UITuErqPxHV1bDIlc3eR8igU7YqudkMJH1kJ2yH6pnG2+sMWhRvfRZ6VSemjPU/QYANw3W0Ua7ap04OqotdGr8Opyeukw7S0UvF09FvEfnr175Shcq8uAcOCDUo4yBTaTgP7auf6k/sFEMUSlTp06Awjm/lq/J5S4+Ej1TbnT5OYZn5uhepY2+K2bgWu/PSMsJ0LuuV5z86sDaYe3mnQ63giYpat2MfPTK6qUuXzk7LgL2b3jCv6dazkOKhU+CsS7ergPDu8GtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 20:10:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 20:10:39 +0000
Date: Mon, 22 Jan 2024 12:10:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Yao, Jiewen" <jiewen.yao@intel.com>, Qinkun Bao <qinkun@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>, "Lu, Ken" <ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
 <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW2PR2101CA0031.namprd21.prod.outlook.com
 (2603:10b6:302:1::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 89822853-1d64-409e-e4b0-08dc1b8633f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmyETvkaO9jlIUhA8IX5Y0CIWTyiBJ4Icua2LT8M+TePo53ghoy4N5C3WTNvZJo4PPk3rTD8RDbly0RfdhcVcPjTjsf/b4NKn24FOTXCPI0E1DqYfps8ejsQO8VaAO3ahnbwt+G4qm7T8NlE79DB+vEZ0A58mPcao7q5C2aGwUI1NfZxJdXVidqVuNC/gypIFS8JvWuyiciL0iIWoHxcdw8UT8c8pfuR4dQrZEy7r7yVWyDCa0kCo1rhWw+21T/5ABn6epd+5JZ0R5TLiyztJLPpnkaLezwZxajQiKufdytM/Nw+tFzk0d/8nYCCJj6U4uN10z0NiNoNquWhWKgxK7ESEE3g1ceaOzNPfNKuma3ySKCm6XV9ulY9cQc2ORIespPeijqOp0ogkdIlq3w0ii3++gH2PGoIxQn7LlRtb9XIL2zAVdnk1tAwjDNLleFNYFY6v2PpuU+1CMSLMT21OlNBWYvF8lK32LjQT4NmRg0wiLNTGOnVsW8bNZivW1NHad4d6UjFl3miIm1oiFMxzI1ZWMG496lO+3h4zdHrHfrDh1ud9Pd7HHUaxca0RZnLVmvTyffVyr0Jii0BYxtYfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6666004)(53546011)(9686003)(6512007)(26005)(38100700002)(82960400001)(86362001)(41300700001)(83380400001)(5660300002)(2906002)(66476007)(4326008)(8676002)(8936002)(66556008)(478600001)(66946007)(966005)(110136005)(316002)(54906003)(6486002)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZFWWJra3cwS01ocllXRGM3NWpNOFBndG9TWVNRdXlQQkd6YmFxb09sS0dq?=
 =?utf-8?B?TVRiNExaNEQ0Z3FzcXdybU01VkYxY2FuWG9xUmkyNWw5UndLZ3JuM3VOQ2tt?=
 =?utf-8?B?ajlIZUNmZDZDeXNRVk5mNU1BNnZBcGUwbTlUNmRidjdIRm82UC9PbkQ0N1pl?=
 =?utf-8?B?V3hrakthMGFWekVrSzFLeGViWENnY1lEa29yckJhQnFXTW43ZmVJOE80SGJF?=
 =?utf-8?B?a3BDNHQwa0tTVlJMMzVmamhkYzhVRmsvbnFCTHBGSlUwWE9ReWYvbDlvZTBz?=
 =?utf-8?B?U0FReC9kYWZrd01USy91cVFrVFoxQ25NZ0FIVnc5QVdkbXhjNzJzdlppYWx0?=
 =?utf-8?B?NEkydEtGU0Z0SGFTaTZQaGhXVHB3UVN5a2NxcTBhR2RnQUFBNENuUEVsRy9C?=
 =?utf-8?B?TmVmVCtHNmwwZFVWWjJzRU9vaWx4UlFVTlp6czd4bjg0UjJxblBMdDR0OW9D?=
 =?utf-8?B?c2hZUFZibGZtSUZ4TG84MWZLWGp5OEtqdGVWazV3ZzM1SklmT2ZSbEZhM1lB?=
 =?utf-8?B?b3JLc0lCNGhKOVV2dURtQ0dIbUF0TDZsMjNKYk1ack15c1M1NU5jbEQydmhG?=
 =?utf-8?B?SkhVY2RGZFMxZ2VRbkYrSFovNmFSRjRIQ256d0twVzlnNTdYcDU1aVpwT0hP?=
 =?utf-8?B?SXhuQjZQdEVmeUd3LzdJWjlLbjdIUE1oclozSGd3Mi9WVEdWQUdPR1hTYS8y?=
 =?utf-8?B?SEtvcXlZU2RaTUJMNkNCdEpTOHNPOStPdWNBYWhwMWRsYjhUTDBkSkFPNjR5?=
 =?utf-8?B?cG9EblJaQXFyaVBwclVlcmt3TXpYVHMxMmkveXhXOWFjVkpnNXFQK2taV2pw?=
 =?utf-8?B?RHJyc2pPMGY0bmJSTzJ4dW1LTm40U080UkJKclRDZUg3bVQyLyt4SElZTm9E?=
 =?utf-8?B?WDUydU8zOFR4S2lxbzlKT3MxL0pHMmNPTEZ0NWJGc2hxS3ZEZks0djlQZ3JG?=
 =?utf-8?B?bjNSK29udFpnMExzemFyeXVac204NFdwcGhlSzV3cG81WWVyMFBHY2tmNENp?=
 =?utf-8?B?cGk5ZlJJaWpzdnNxZVZUMit3R2FRUnk1VWFaNTRtSTBLQnlGZmQxOE8xMk1m?=
 =?utf-8?B?bDlxbUcvMlMvR0gwNTBZclpETk9WcFdabW8yMjloblNuNC9JTlVJT09rVzFL?=
 =?utf-8?B?MnQ2RnlQUW1VR25qMEVoRVJ3NDExR1pKNjVFSUl2VUNFWXhyUUhXVmNiRlBv?=
 =?utf-8?B?UFlIbTdaU2JFRUZuNXFuUVhUeDQ1bDM4aElUMDJSeVdpeG9TYmEwWmd6Yjdi?=
 =?utf-8?B?SUp1czZab2VpcDFjbzZNQzFKUFRNNkN0R0t6cDVmV0pEdWY2Q016ZHVRODBQ?=
 =?utf-8?B?NjJ1OXk3OVZKTVozMDM1eXh3TFo2UVNxSTlHaGVWZWNkUTd3ME5LcGo0RHYz?=
 =?utf-8?B?S1Fvc0c2dGVFK2srdU5KUEJtbEo4OXU1aUh3bUZEdjJ2a1JjOUI4bHk1UXky?=
 =?utf-8?B?b2Y0SzlyRTViWVFFdHJaNHVZdnR0QnZuWmc2akVaWnN3NENDbWVOdjk0Ni9k?=
 =?utf-8?B?Tzg5QzRObVZQVm9CUDZJd1ozQkQwc05JU3ZkZUEwTkdTVFZaVGthbHEvUmJS?=
 =?utf-8?B?bWx3Ti9OQkZQdVFrQjVBZ0Z4bXFRT09PdlJKZGlkUU9BNzFBWWFmU2YvcGVz?=
 =?utf-8?B?RWZJb3dJSjh4Ymp3NHgyV2hOVWZwbVMrT3QxeEtrWFJoblM5UVNYdk56eFE0?=
 =?utf-8?B?YWljcTg1elVxTTBMenM4dnI2NXFwWi9zZy9zQUl6dHFWejcxOEEvam9GRWJn?=
 =?utf-8?B?ckFabFhpaU5TcFF4c0xHd2ZWb1lmcEhsVUJnYUxWdDJaNHBDL1RMbE1zalM0?=
 =?utf-8?B?dWFUNWNTUEltU3NnUUladEtOYjV1T3NDMjNrbm1zZjBRWG0vLzY1WGRHMmNP?=
 =?utf-8?B?dUppbXI2dVRWcWJQWGhmQm5iMzhhcjZqbWRReWQ5Qm9RNk9maG9KSHgya2Zn?=
 =?utf-8?B?cEd0R0MxQldkV014TjlrQVE4d1Y4Wjk4MGRBVVJzcXd5S3dsOUJvek5LQmpt?=
 =?utf-8?B?aTBaeGJpUmdCaENuOW5ieVA2ek0wTG5uVlNZeFdJdTRZd0JCYzE4dmJ5T01r?=
 =?utf-8?B?dWswTGFSNEZLUHcyTmUwZXhJVEdvK1U1aEF5d3pUQ2Z2Mk9lbjVNa3dvQ3N2?=
 =?utf-8?B?bThOY0FFSVdzS2g0YlVFcGlZV2FRZzJKYW1BMU81aEIvSjd3bFV3bllDb2g2?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89822853-1d64-409e-e4b0-08dc1b8633f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 20:10:39.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/DUdVE21pOqMkq/ZUz5T0mWmnyZmcpfoABMJsQo67wYyd7VfoMeBPd0uv/fc78yc15HfishO0jdIgQir34KuhmriJu3k7f+hR3gNRu0ryI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

Yao, Jiewen wrote:
> Comment below:
> 
> > -----Original Message-----
> > From: Qinkun Bao <qinkun@google.com>
> > Sent: Monday, January 22, 2024 10:13 AM
> > To: Samuel Ortiz <sameo@rivosinc.com>; Yao, Jiewen <jiewen.yao@intel.com>;
> > Lu, Ken <ken.lu@intel.com>
> > Cc: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>; Williams, Dan J
> > <dan.j.williams@intel.com>; linux-coco@lists.linux.dev; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
> > 
> > 
> > 
> > > On Jan 21, 2024, at 8:31 AM, Samuel Ortiz <sameo@rivosinc.com> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan
> > wrote:
> > >>
> > >> On 1/16/24 5:24 PM, Dan Williams wrote:
> > >>> Kuppuswamy Sathyanarayanan wrote:
> > >>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
> > >>>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
> > >>>>> expect a Root of Trust for Storage (RTS) that allows for extending
> > >>>>> and reading measurement registers that are compatible with the TCG TPM
> > >>>>> PCRs layout, e.g. a TPM. In order to allow those components to
> > >>>>> alternatively use a platform TSM as their RTS, a TVM could map the
> > >>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those
> > PCR
> > >>>>> to RTMR mappings give the kernel TSM layer all the necessary information
> > >>>>> to be a RTS for e.g. the Linux IMA or any other components that expects
> > >>>>> a TCG compliant TPM PCRs layout.
> > >>>>>
> > >>>>> TPM PCR mappings are configured through configfs:
> > >>>>>
> > >>>>> // Create and configure 2 RTMRs
> > >>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> > >>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
> > >>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
> > >>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
> > >>>>>
> > >>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
> > >>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
> > >>>>>
> > >>>>> // Map RTMR 1 to PCRs 16, 17 and 18
> > >>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
> > >>>> Any information on how this mapping will be used by TPM or IMA ?
> > >>>>
> > >>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
> > >>>> user to configure it. We can let vendor drivers to configure it, right?
> > >>> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
> > >>> has no idea whether they will be used for PCR emulation, or not. The TPM
> > >>> proxy layer sitting on top of this would know the mapping of which RTMRs
> > >>> are recording a transcript of which PCR extend events.
> > >>
> > >> My thinking is, since this mapping is ARCH-specific information
> > >> and fixed by design, it makes more sense to hide this detail in the
> > >> vendor driver than letting userspace configure it. If we allow users to
> > >> configure it, there is a chance for incorrect mapping.
> > >
> > > I think I agree with the fact that letting users configure that mapping
> > > may be error prone. But I'm not sure this is an architecture specific
> > > mapping, but rather a platform specific one. I'd expect the guest firmware
> > > to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
> > >
> > > So I agree I should remove the user interface for setting that mapping,
> > > and pass it from the provider capabilities instead. It is then up to the
> > > provider to choose how it'd build that information (hard coded, from
> > > EFI, etc).
> > 
> > The UEFI specification has defined the mapping relationship between the
> > TDX RTMR and TPM PCRs (See
> > https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-
> > domain-extension). The current RTMR implementation in the boot loader
> > is “hooked” in the implementation for the TPM.
> > 
> > When the bootloader needs to extend the PCR value, it calls
> > `map_pcr_to_mr_index`  to retrieve the corresponding RTMR index and
> > then extends the RTMR. Considering this behavior, I don’t think we should
> > allow users to configure the mappings between the PCR and RTMR. (See
> > https://github.com/rhboot/shim/pull/485/files).
> > 
> > Add Jiewen (owner of the RTMR changes in the firmware) and Ken (
> > owner of the RTMR changes in the boot loader) for the visibility.
> 
> I think the mapping should be static and determined by the hardware architecture.
> 
> Allowing user to configure the mapping just adds complexity and
> confusing. For example, the user must understand clearly on what is
> Intel-TDX/AMD-SEV/ARM-CCA/RISCV-CoVE, how many registers they have,
> what is the best way to map it.
> 
> It also adds complexity to the verifier. For example, the verifier
> must understand how a user configure the mapping, then get the
> expected measurement register value.

I agree with this, what I have a problem with is that this:

https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension

..is vendor specific, especially when the kernel enabling is being
targeted as cross-vendor.

So, yes, the mapping should be allowed to specified by the low-level
driver, but at the same time every vendor should not reinvent their own
enumeration method when we have EFI for that.

In other words Linux should enforce unification across vendors and
consider waiting until the RTMR enumeration is promoted out of the
vendor specific section to a cross vendor standard.

