Return-Path: <linux-kernel+bounces-12894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC281FC33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B6E1F21946
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30723DC;
	Fri, 29 Dec 2023 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqYg4OyL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9323A4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703810037; x=1735346037;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6+jvdH9KNvghpGbAabh5thUdQl8nh8zow1920uZSGZU=;
  b=PqYg4OyLAqWTbvts5L0RVH54wcHrrUqCBf7G17YJgZwZcMWw7MGntsQ9
   Lm2wJ3HbfCDaFzDPFI9yEzDFrjbWwfpb1IXHlZnH53SKVaT58r8zqSPXW
   Mfra7fvT3rWx0BrL3MVxxANU9+No+LQTj8WJbIGUVEbRF+Q4D1+F9InnP
   jgAI2dqD/IRMBbc63n8OXwTZsYLunAAqWKtFKMrum0lqNcD1ljq5MlaMR
   fsIS2KadF2DBcoUyDBvWmF1zqcjzK1bylYnf8SjAKb4EluHuVI/NcMMk+
   mchzSrTJUdejJBxWl0UwjIWADiwqIv/mxBYv/fmI3r8zSN8bRjSZLSLky
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="376085558"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="376085558"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 16:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="869259527"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="869259527"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 16:33:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 16:33:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 16:33:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 16:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRN/g/o46U4nul5yE0CO9uClHYBbjgxagw+Ie6CL39Fhwy0npp4lPfmjriy3vKoFZPce5qSuXOoxlx8TUYAHEdXXCMtTSFk+6qPhrUcbsiCtVybd3HstUe1cmpoPgY4aKLWaj1HNg46Vmn58lSBsl+XqYS8LGuNmBtB5P/MxB1fLjSX2oA1iecWlpDiaLQ88soevzcbw/YXqx7jKORWVfmjw8R82/KLNnpNUYfiBXF922PEaMmmQgS26K6mdRzPsOSpmBEKGCyIKactQYOzXP9fop42e0wr1L8XPvGIVKcXxdIcwoqZSR0Lar6hgCAIK6bPkAwese4s9I9iAhVMJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtfDx143EXvF/m6QNQ8g1TnUgfIL0vHMmSmP591060Y=;
 b=Ziuc67oofJxqz44hQQuYasxyB3dZwUaaeltw+7o0MMCXKUtZybFA1VXk/T+7nIY2gKd78t48GhM+McRJFVNEXJloZc025tplX0m/B+aabmZmBnOljBP4PapJ8rf8nE41sRdOJnCZT6xWZpsFmwTSzPjUc2OjvqLGcPY8ZbL+vX69l0XVGWN+TnvJA3q1/Hp3JYZslFsSOS2u/xtAkeQnfLeL7oSfoVA7m/LWGPnE+wPCSXxxTH5LcdaTZ/QopP0+a0c1B5J4XebYjSoTXtI60GSeG+B2aIv0PaGkdZP3IhdG9H4xL2+XMzHVwDn2yXxKLP3WAcybn45EcqqxUYOaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 00:33:54 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7113.027; Fri, 29 Dec 2023
 00:33:54 +0000
Date: Thu, 28 Dec 2023 16:33:49 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, LKML Mailing List
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, "Ingo
 Molnar" <mingo@kernel.org>, <regressions@lists.linux.dev>
CC: Mike Rapoport <rppt@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: [REGRESSION] Platforms supporting SGX fail to kexec due to
 96c6b8f212a ("memblock: report failures when memblock_can_resize is not
 set")
Message-ID: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 618a492e-9d05-42b7-e3cf-08dc0805d5c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqFxBPtlJwWldbHTz22zWQtPwQSXade+v6Om9ekPt1PcMnWPISCeSG9698C4ehp7EUmelLBsi8I77wAlGGm3k+tAVqs/vAhgTT3UkQ4cRzLELUsVKsXNTfCBu6IKV1F3xW+KmRD7zv7JaTNnLlyQJncP7QH+ft6EEWvMrZPUFl6lQvc//zwM2l7/PVempdm0Fazczlgje8+bAvdqT20PVbFuvb9ksBq2z4uw5krTebgJ/91td65jAgFWfV/229yW14r/7KW4Rb8DrQdrZ2+yHJCe40xjNEyY48M0wevzWdvQp1aC8NiY+WTFncebcJC0cjfKwnubNUu1UoLdwPgVNdHfIrNLPQg5rlucxgnxDiJ+E/z9lHdPG2xSk7Lqma6WyC0eO7khh4B5pKQlacUPEUhZeYrpNSrkWGtZODaUt/SU8xUTp1bP0FS58fwsZdCWvpaa5wAAfryZCZEZmz7OLxRvXwOYQ2jiNYq7rxedzETUGJsZlkHZo8gwzU6EplIOfbg50FMPqr/g0IYleKXgQrXdeemFMh89J1cMhUtD0twdlGVedIkgyZFbk5cwYFPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(26005)(83380400001)(107886003)(38100700002)(82960400001)(54906003)(2906002)(8676002)(110136005)(8936002)(316002)(478600001)(4326008)(4744005)(44832011)(5660300002)(6506007)(6512007)(66946007)(66556008)(6486002)(6666004)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIk8sb47Xi22Sah8fi6xdRPSlbLiO5UJ0sN01iwAjF29F9nlMpa/ZST2MJa0?=
 =?us-ascii?Q?fIDdIG+cFaR5+wGz0ErJq/eP1JdxHIiFaLHtOvudOuXyHeYMYtnirdacKXLx?=
 =?us-ascii?Q?0UYhDL60JfeJbOmUTnGgu80i/xCCGaQo30376H8kL96cGk6RC92qXLyfG4lr?=
 =?us-ascii?Q?B7P/RikBHbOm4pcDE7hCzxHz2JOWSUzJRj0ydIl5jHqkhSsrPG0laYT4Mudm?=
 =?us-ascii?Q?0zgpPlU4cOAcqR0dURxAAjQTybFM9o+vc66I7k29GJR8cbShYzULmvWQyTFJ?=
 =?us-ascii?Q?1rYU2SRcfXMUJ3XqCz/mRPuVS53uTKyWKBTTs5jA2DZ6rLgH0b2mqYz0J5lk?=
 =?us-ascii?Q?2wBbokzVkwesD2vH6fJbmMilpMFwMcGNR14qywF6QAbD54Hcg2Gl9fbdiZ8f?=
 =?us-ascii?Q?0GGmHfIbOLgWhehGEFlN6kAOpObBushclhOH2n3yicf7U+cRd27SYFnhm7on?=
 =?us-ascii?Q?I2WdcGp5wga1x6xXMqHIHYYYb8dHrmW1RggMOaTf164t1rFV0Xad6t6dDbak?=
 =?us-ascii?Q?kF2xUoxMMhDWiIe6XmxJK/9NzzdvAYwR7XBKrkQBfuR5QyuA1sHlT34mi5OW?=
 =?us-ascii?Q?yMsWcCK0VrRSZdCUBR6Gkis2BmUNhOTq7qoiX+T+eh2wvBuBbj/R2zMFY7rA?=
 =?us-ascii?Q?GT1LAc3OSMQj7TTzZlhdxHMg1HEe47+Xlgevb4nPErQyAv8J8fA84jVHsIn0?=
 =?us-ascii?Q?xhFVHG3A4HheDP+9my6Q8weB0tcwFAqdV0x3uUI4QcxwgXUFtVmtMWxARo30?=
 =?us-ascii?Q?G/Sm6hbMkQUGFz35RrGW0TGa3INW11IvAmg7Ao++EZE0eMpmBcuEB+EjIrlj?=
 =?us-ascii?Q?U/2TSv2fEnhEOYSgnPHfrkUrXqMuUMOiWD8pcSGQlEpmHIoHqbZDT+vt+xZB?=
 =?us-ascii?Q?vkbGDW5D0+Th2qak84343ZM14Xvb5+6KTOV8rN9sO+bH/+dS985mvSs438+7?=
 =?us-ascii?Q?Mr/w2Y9kNOduLGe6JA7seVqZ3w7bgNsKnRwq64E0dH/K0yU+nTOuQbX5jlPl?=
 =?us-ascii?Q?xm2xgcPPUZlLWAv5zcz+HGJwpH1P75kaKPeaHeyRvQqUyP0fQ8zNAFCvocen?=
 =?us-ascii?Q?jXQN19UwxetNE31kmjGOYwe3kwH1RrUUiwZAHONP3bBYPYGeuJ030vBifOGv?=
 =?us-ascii?Q?EiYp/8KAv7cIzyIgrMzlNHYMuD/tcA18R2RsvMgKLrW6eoktHluGeV3W++Zk?=
 =?us-ascii?Q?NLE7LHYNiJEv7dxYmgfxNYzFZf+873sHTbY9LmdJdh8QKaGa0ZWIDDAuV5ld?=
 =?us-ascii?Q?t4djq59umj6f73jcYC35vyuWX9/wYz/lnu49ZeKUFKDaeTyVg9zlKkHhg1Uh?=
 =?us-ascii?Q?OfMUjryBGezD7gTLCrYoabiUNtli/ypY4nC65Gpc5DxXz4AO1lnfS9T0+xA0?=
 =?us-ascii?Q?Ff1jSXy14Tspze4+rHpHijwQUHVZhThLdqHAbwoU2XjfJ3asIWbj2RpeWDt+?=
 =?us-ascii?Q?LsL7jYIb/QMneX+s02LNVV5RsksXG1InnFaBjpst8lmhd67IJRCOk9JFnMt/?=
 =?us-ascii?Q?+iWnc3TDuEMPZAy4sEcj5o8FHhzY1shNxo/KxgPdCt5tkcueE9c5wBwI3E34?=
 =?us-ascii?Q?+OjXV9PGq+FH1KpJoXRFj0783ssW07tNjzWawNNy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 618a492e-9d05-42b7-e3cf-08dc0805d5c5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 00:33:53.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi3M/VFSSoidqPGHbm98iCU1Av8Ud/xh7CaGnSwxv8rh2t+rulcb9RB/xkTDhoeQ6k19ktEttXebRKdPJeJyJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

Hi 

96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")

Causes kexec failure. Backing out this change, kexec succeeds. Symptom is
it appears to hang, possibly hung at the panic. Although I have the
earlyprintk enabled, I don't see any console messages when new kernel
boots. 

Also tested turning off CONFIG_X86_SGX, the kernel with this commit
included also kexec's fine.

Booting from warm/cold reset has no issues. Only kexec to new kernel with
this change included and CONFIG_X86_SGX=y causes the kexec failure.

#regzbot introduced: 96c6b8f212a
-- 
Cheers,
Ashok

