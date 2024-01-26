Return-Path: <linux-kernel+bounces-40164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FF83DB73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41909B280D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F641C28F;
	Fri, 26 Jan 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YO7wJtnD"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA421B968
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278121; cv=fail; b=Z0DK+UXDPNNOhNSBeC9LuzJ95CM0NdiP/KwVsbmqb3IGv/zrVMsVh4jZf1kX82XHP25ou6qmyRpGK5aZvO8gRlPHokGvAzhSoBSnO04C+flJQpC+NOV+JimzlN2Fr05bevFuL+lClURnDn/F/2JuwDNb9P617zdaV3kvNVbHNQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278121; c=relaxed/simple;
	bh=WYfG8WkiTDQ3PZnDwgK27a6qqHwFvCHRq37dFIugODM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ju+x208Ccmwa3YUzlzXrMHUmZkQ9PX59SN+eTYQPxyLG8Bhaqr4/55mUMySF66nDlZpQdOrR3JkIxZdsSuvvffSJGzRFVbIgTP1L0Y96wDm6ciR2PjFowBaFd9eosMcAQ5Usa1/ZZ/Neo92LtwRYmQDDFCPQWV7sBg4U+8F9skQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YO7wJtnD; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706278119; x=1737814119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYfG8WkiTDQ3PZnDwgK27a6qqHwFvCHRq37dFIugODM=;
  b=YO7wJtnDarLofFWOGEtUYPHQJTIGo7+9LSuUNuoBjYHz7OlwZ0fHclZg
   mPkRBBjJBVKFB8Nka+1/3ng3cMzJiTEETyYEZG4EVB4SQvq1vU20Po11I
   KX5+Nz/6LIp8jjuxTnDOxjlr0LBL7nRHQ68DEEB20zW+2tCVz1i0NDe8L
   wh+eJyg+DinwaqkrRqbIdP/An0Vsq/i3qGtvfIMtaEJnpi/ItKhUq4yve
   2YE5nrKWB7Ly8UToZ5fAs8T38MvdcG+wbZRmxk9q/lxdRTUEY9M+DRlzD
   Rc4iucsvGl5WI7VdSX3gtwAJJrpRGO1Xill0XWXPX+BLL2e78gDFWgbMH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="392911799"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392911799"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28831297"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 06:08:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:08:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 06:08:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 06:08:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cugOT0zTqn6kc85p1CYByi7wWKKq9IE3u3v4rdU7u5DU0M885ZoNkz003By9gZCpXQiGE1JPPMgxDJt+fQ7MF7dmUEpYkxkiQpzmSOzv1vCtJS70VGAzPMBPrgEelMLda9TJiU8W555O00cPEOtLFs3DUPj/3XDUQNy8QmibeGQkxz5ocl2MrCKQ/H7Yw8a1dVqqSzxVD9u11ZOLTBlKoo10yQUtvdv+zd7r4DMNmvhKcOOeysGWJYS3EEQx7iEgfoVKsmkCgJxg94MFeZE9s+A1aLDi5PQeDYeEvta1VORV1pW76uW2DDiWtNiOpRV8jadHCy36QQzSo9JnXXUBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYfG8WkiTDQ3PZnDwgK27a6qqHwFvCHRq37dFIugODM=;
 b=oLldi1upV6wrmtAzNSl0C/hsKIjtwa+Ev0N6ib/1VoARvvPsVo0Oq0WOCDzYGYKLlId1NsxFptaMQMzU+DmGVT3BiflLbAjicQK0VDbIMQsXsGZkHRYEbKwBkRdn7PMU4on5vq8XwX1VAxnCsI9Gw0Udn0zc4RXHF8qWLx+8L267+X1tBC1BtcA759+JEnwohQ01KJcWRrkMubFnXoh+SeobK7mTBukp7+SoVctIykYs+xn3IkpAF5aIUGfFI72lNnYlbDQPcTbmLZzaHVHKLg3n4zWJPMgZCmvetgqGwb6OnNLNPXL9BGj3iAU1R3ZgfMNvL8cbXQomf8s7lZvLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:08:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 14:08:35 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv6 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Topic: [PATCHv6 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Index: AQHaTsTwkHBmL99raEi1zxttIjQCR7DsJL8A
Date: Fri, 26 Jan 2024 14:08:35 +0000
Message-ID: <e2d6aeb8eed69bd9a648de59d7abfa255b503259.camel@intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
	 <20240124125557.493675-15-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240124125557.493675-15-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: ed8ab966-97a4-45ca-e88b-08dc1e784930
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lTQev0Eb/cTbEWri9IfJmXbH6u3k4mLlaJfuyJ4xqBf/f+ZIN/5QegRq1brWCILaCyt6JHdcqO9LTwRWy3RIYaDrzi7udWE1DES1QS9sUBkgyW2sDnsUysaUVH5qGvRepRe4H6BJwHkCq2lDbqLZThdez1PGLRPHNNe5k7PUP/6D+4d71TJldc3PGSa83K8mmGly1M0xXfcJhDMtfu1qbF6a8No/Cp6lYzWTdmEd0PmV8vXToqlqZjDpkWBP8iRTbcrEIZYwk6togoMs9lKrnqF5zDUobbcMNT9Dfyhm9bc1XNGKHCOkZqOs870h4z80fLIAC9CREzN8xyxmPZB4dv6Db12TgHSr8BqeRMYdYwvhlMBjZIh0bO6wvkGZjkomuo3OoA+y5B8IEbiOWss18KGnnLLSz3RYFQz+kl79+Fxlng9ZnWP0+qc6KaPHwKnLS4vdu6wAGA09XNuofbZyNFKAMC04MSp2F9Y7xVTeCaRjljoFtIqvyHaHd/2CxsqfvB1WrPALj9vSG0l3oFltq1lpDH+grIscCK80eb311HH5k6KTYIo2KaoZCGuy/1YUeuEcX6pNk3shcmzqGCclYkHTJIF8m1/1TJ6/3KCTR5d1Vb+I2pKGm8Q86ml27wZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(38100700002)(2906002)(122000001)(82960400001)(41300700001)(36756003)(5660300002)(38070700009)(86362001)(6486002)(26005)(478600001)(6512007)(6506007)(2616005)(71200400001)(83380400001)(4326008)(8936002)(8676002)(316002)(66946007)(54906003)(66556008)(66476007)(76116006)(66446008)(110136005)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2laR1hsRE14MDdxTVZHQVR6RzdiZm5YTzJFZWcvc3VkZXAwaFRTZTJySDRh?=
 =?utf-8?B?UGRWVm5PSEVhY2UzL2I2KzFGUXBwLzFOcW1HRXZ6MkkzWXE2ZVoxQ0hJVXow?=
 =?utf-8?B?ZHcrbDJ2U3liaXE4cDVzamFtb0ovNlhGRFdMemhDcVBGVE10YjJYZFZmWmUv?=
 =?utf-8?B?b1FCSWZOQmU0R0pyQVRrTi9ZUlRzOE8vZER3KzZwNTY5SUxUcmJ5SnVLQWtm?=
 =?utf-8?B?MFdEbW1oNEFuNkRoeVlBcW5JQXA2ZU13K0p2UUxqcjg5ZHZ3L3VNa2J6QjhH?=
 =?utf-8?B?a2VVb2ZkWDNjMGlFdzVtdmM1SS9uMkJmTi90aUxLMDRTR2RRQmJaTGtYN0RF?=
 =?utf-8?B?T2pyZnVYVGNxTG9ESEdPUjNxZ2hoR0JLc1RKTXJpcWMrK3FuZlhBejZnb0ha?=
 =?utf-8?B?Qk4ydi9UTmlWWnBWbk1YWG9RVTQrS2JsTU9MWVZBK3VhMmdJRHVRQnkveTR3?=
 =?utf-8?B?RmpxNUNXNWtTU3MyVUt6MTJiR0xPWGlkVytkMEt4UFo0UDAxTGkzRW1GMzRG?=
 =?utf-8?B?ODRNZmM1UWVJb3NsYVJaeWxmWDdKR0JqOUpqSzE4enhtYU1hNm9zYVFsaG1M?=
 =?utf-8?B?ZGRaY2hGbFRYeDBqRXpSUVE4Y01FMGU2WHlHVDJLV1dUYkJ6dFl5OVlFdXo2?=
 =?utf-8?B?TzA0dkZ0Zk42aU51MzhhdHcrQ0FwY2o4ZXBBTCtHeWRBR2p6OFpQYmpDa2s0?=
 =?utf-8?B?N2pmeTFKZFVISWYvQ3BHTmF1MXJRWE9mMlAySTdEZVdCYVhqbUhDNS9PQ0lw?=
 =?utf-8?B?RmRpUGZOUDNCeVpTNStUb0liT0pFVWtJdE5SWW5zeTkyZUhVWmU4ckd3amwx?=
 =?utf-8?B?MjBSVEhsWDlZdngrVTlBNTd0VTdzQ2VRa1plSnk3WTJUc1BtTkk5OE8wUTV4?=
 =?utf-8?B?cFRGMkF3TUNxYXYyNjF2TEVsUmFVcWtmQUpMalVCNFBnV01aQTRpTGxxRlE3?=
 =?utf-8?B?T3ZHYSs5Vy9MQzFWRkgyUFRVSnZyWjc0Rkp4enJzUU16N2lPSXl1Z2ptVUJy?=
 =?utf-8?B?YkJuRDdGN3U3Yk5LSzRXaGIxWTd0VW9seHlkTDR6dWpGaFc5OHM2RHZEZFFB?=
 =?utf-8?B?VTRrY3RlNktNcVFKUXd4OUJsMloyRi91azB1RXJZYUVEZTFTZStDNFd3aHFS?=
 =?utf-8?B?TjJ0Z0ZVOGtJNmdzSlM5aEJxaGc3SXF1TWFvaXZwZ3A1RVpJbDVFTnJQUG5H?=
 =?utf-8?B?T2xWVW01MXhQN2FPMGpwZnlmZDhDbmt5ajVZYUNIR0V4S0xiUHhFWlEyQk50?=
 =?utf-8?B?cU1rTEZIMVIySTRKQmVUMktKUXlrSDNWakNNZzlzK2hXVWdnbVc0MzRwS1dB?=
 =?utf-8?B?T2xWYTUrdnA5cHJjVE0yTWZVMWtHeW96WHlUZFhGODltd3JnbVNObThjY2I5?=
 =?utf-8?B?d08xU0w0Uzl1WXFlR0JrSnJLZDFHN1RKd2htcUlKOG1scGozVnIwa0l6Z1Nm?=
 =?utf-8?B?S0JLcWpMWU5DQTAwYXRXSHRtSEhJSjl2Ym51UUI0eWV2MEUvOEp0U0JTTFpM?=
 =?utf-8?B?dE5hdVZMVFRuMnJ2NXV0MmF4TW1tV09BTy9DME9SN1Z3ZkZ0cjk2dVBIVVd0?=
 =?utf-8?B?SkM0OHk0UDY3TU5lSUF5bUNjMGdFQjN6RmNEZG5IRGt3dWtkYXQrc2Fna1dk?=
 =?utf-8?B?bnY1bmYreExobzVXQUdlR0FocmI0cXhYWGl2N3NkbVdza1dmMWhxR0M5SXB3?=
 =?utf-8?B?SEtwb2F3R3Y4QlVkNzZqazVKZThMdUllQ0tUdTJqdEYreElISU1aa2RMVUhz?=
 =?utf-8?B?ckZHRHlpOUp6UUtUeWM2YlAzUHdVQzJBMnNQc1NTMGhKSXlZaklXSHhNY1pI?=
 =?utf-8?B?U3RENFI2QytHSGFKeEd0enlOUWU0K2FxMWJ4M0VyZHEySXFHNHB6TE43YUZH?=
 =?utf-8?B?SFlzZ2hPR2hqL3FlTVFoRGZxeDMzUzljSHBLUFFmaGQ3M09TNGZsQTZCcUtu?=
 =?utf-8?B?b3BBYzVYYUJIbEs2QXEvQXRaZVhlZ2Vxc2NoWlFISzQzS1lYK1g2eHJ0c1ND?=
 =?utf-8?B?WU9TY05uemRJeXNxZUh1OW9iamdmQWlYWmVsOXh1cFc4dzBpYTNYSnpJUHNh?=
 =?utf-8?B?SDF3TkpjZzU5UzZ6WFVRbzJNU1hqRkdXcHU1b1lEYllzQys4V000SjBPUUJE?=
 =?utf-8?B?cVdwSVh3b1QvQVJUc3JyZ0d5QjgvVlJNdi9sMDVESUZrdDBvVlFwWWR1YThX?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B293AEAC472F4E49B85318E82AEAB704@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8ab966-97a4-45ca-e88b-08dc1e784930
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:08:35.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtBvhgMa7OV2a+LI2/o4GOrHZW+OxCXkq+1mIDiqs6RwGyogrPd3Cy1JxBNqkzKOCSDUw+uwnLzWOkTlBzVnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDE0OjU1ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IElmIHRoZSBoZWxwZXIgaXMgZGVmaW5lZCwgaXQgaXMgY2FsbGVkIGluc3RlYWQgb2Yg
aGFsdCgpIHRvIHN0b3AgdGhlIENQVQ0KPiBhdCB0aGUgZW5kIG9mIHN0b3BfdGhpc19jcHUoKSBh
bmQgb24gY3Jhc2ggQ1BVIHNodXRkb3duLg0KPiANCj4gQUNQSSBNQURUIHdpbGwgdXNlIGl0IHRv
IGhhbmQgb3ZlciB0aGUgQ1BVIHRvIEJJT1MgaW4gb3JkZXIgdG8gYmUgYWJsZQ0KPiB0byB3YWtl
IGl0IHVwIGFnYWluIGFmdGVyIGtleGVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KDQpBY2tlZC1ieTog
S2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5j
bHVkZS9hc20vc21wLmggfCAxICsNCj4gIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMgIHwgNyAr
KysrKysrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvcmVib290LmMgICB8IDYgKysrKysrDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zbXAuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtcC5oDQo+IGluZGV4
IDRmYWIyZWQ0NTRmMy4uMzkwZDUzZmQzNGY5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9zbXAuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zbXAuaA0KPiBAQCAt
MzgsNiArMzgsNyBAQCBzdHJ1Y3Qgc21wX29wcyB7DQo+ICAJaW50ICgqY3B1X2Rpc2FibGUpKHZv
aWQpOw0KPiAgCXZvaWQgKCpjcHVfZGllKSh1bnNpZ25lZCBpbnQgY3B1KTsNCj4gIAl2b2lkICgq
cGxheV9kZWFkKSh2b2lkKTsNCj4gKwl2b2lkICgqc3RvcF90aGlzX2NwdSkodm9pZCk7DQo+ICAN
Cj4gIAl2b2lkICgqc2VuZF9jYWxsX2Z1bmNfaXBpKShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFz
ayk7DQo+ICAJdm9pZCAoKnNlbmRfY2FsbF9mdW5jX3NpbmdsZV9pcGkpKGludCBjcHUpOw0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9w
cm9jZXNzLmMNCj4gaW5kZXggYWI0OWFkZTMxYjBkLi4wMGMxYjk1NzQ3NmQgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3By
b2Nlc3MuYw0KPiBAQCAtODM1LDYgKzgzNSwxMyBAQCB2b2lkIF9fbm9yZXR1cm4gc3RvcF90aGlz
X2NwdSh2b2lkICpkdW1teSkNCj4gIAkgKi8NCj4gIAljcHVtYXNrX2NsZWFyX2NwdShjcHUsICZj
cHVzX3N0b3BfbWFzayk7DQo+ICANCj4gKyNpZmRlZiBDT05GSUdfU01QDQo+ICsJaWYgKHNtcF9v
cHMuc3RvcF90aGlzX2NwdSkgew0KPiArCQlzbXBfb3BzLnN0b3BfdGhpc19jcHUoKTsNCj4gKwkJ
dW5yZWFjaGFibGUoKTsNCj4gKwl9DQo+ICsjZW5kaWYNCj4gKw0KPiAgCWZvciAoOzspIHsNCj4g
IAkJLyoNCj4gIAkJICogVXNlIG5hdGl2ZV9oYWx0KCkgc28gdGhhdCBtZW1vcnkgY29udGVudHMg
ZG9uJ3QgY2hhbmdlDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcmVib290LmMgYi9h
cmNoL3g4Ni9rZXJuZWwvcmVib290LmMNCj4gaW5kZXggMDU3NGQ0YWQ2YjQxLi4wYTc1ZWZlNTc5
YzAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYw0KPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvcmVib290LmMNCj4gQEAgLTg4MCw2ICs4ODAsMTIgQEAgc3RhdGljIGludCBj
cmFzaF9ubWlfY2FsbGJhY2sodW5zaWduZWQgaW50IHZhbCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
DQo+ICAJY3B1X2VtZXJnZW5jeV9kaXNhYmxlX3ZpcnR1YWxpemF0aW9uKCk7DQo+ICANCj4gIAlh
dG9taWNfZGVjKCZ3YWl0aW5nX2Zvcl9jcmFzaF9pcGkpOw0KPiArDQo+ICsJaWYgKHNtcF9vcHMu
c3RvcF90aGlzX2NwdSkgew0KPiArCQlzbXBfb3BzLnN0b3BfdGhpc19jcHUoKTsNCj4gKwkJdW5y
ZWFjaGFibGUoKTsNCj4gKwl9DQo+ICsNCj4gIAkvKiBBc3N1bWUgaGx0IHdvcmtzICovDQo+ICAJ
aGFsdCgpOw0KPiAgCWZvciAoOzspDQoNCg==

