Return-Path: <linux-kernel+bounces-48931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543AC846350
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784721C24FED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A14405F1;
	Thu,  1 Feb 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJjmamwc"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFA3FE24
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825818; cv=fail; b=SrVYM38WVq4mAHolcgAihjv06Okz5vDvUjeCsysQONUFu4p/J9uXAnSZAOQC9kBCnfxKtEMLyBdwY/9tcQV76eTtUQTIDft8SC3o2jg+nLdcjzwBLKUAy97HpW+/8PM1Pxqwrm0TpSH4qiYRoiZ1H99Fv7FRiwmmdiwn3xho1SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825818; c=relaxed/simple;
	bh=z+v06i1yVmsOYqWJOXvVA1J17fgQSuai8xo7mYjYvkk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+OyV2A4GkK2n1YY8liZGeEi3jsjyzvomPC2VGJH8k1ytJUnz+mjPrF1XztjqHsLd251387ay7EUnQtmyILA0NzYe1B1SD8TmJRPvqlqxyChw3KW2nh0rS9Lxu4NoyloCQ3ekIbnkVIIFTVEwxE5lFaeOjKsS4T39OGQnGpMViA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJjmamwc; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706825816; x=1738361816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z+v06i1yVmsOYqWJOXvVA1J17fgQSuai8xo7mYjYvkk=;
  b=EJjmamwcS7lk7bVAAJuwGcr52aywXBN9lfm5qrew8yOStI9G1+gmqcIR
   ZR8SGxr2IJCCiSqCNFX6uNe4LngSVlRAzuXYXs/m1ka3zRPx9kkmpyKeY
   syq1dh+4QBwTweZgvY4nz0m/N4wTZUY3xXS/TqXZaUXMyl9+NWYk+Gb+0
   6RcTjAOlq5We4NSR2gFr9yFZDh+FApU4+ueYFkI9Nl77tpQ9gyrsgha8D
   mYCA/EqN5oGlA8cpEyg5Yb/L5Zb/QMZJjVZ/DI3AG/HB89KT9LZ2efSgE
   g5lMIXeJqY4W19P0e46cOfJyoosCRtESBet7Ha/gP611u+bzLXCg+8nrH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435173418"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="435173418"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 14:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="4642732"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 14:16:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:16:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:16:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 14:16:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 14:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXfKWQSMU+2z6un0iA5Jt7IMcIGAbivRNstL+Mrj2R1YM14E9NcuR75aUwhmLGYBynF5hAE0Uu2gxsSZGN6hsY+cAeP4uhqSea3pS6pYLpBoMefMIv+f4TcVrlpeq/b0DgXoCbYohBxcftOvyStlVVv8Upi88l0v4lCo0flFb5N9/lsZshB1c2G8FwpYMFcFFBCGKEAEvG8/4nkXbEwJvf6ryBgnJUBkSWaO6FFyqcCNCgAsOiWWnKtB6xrsi1pnYyH63AxhbpcnIEHWZ8Ln8Smb/QBdUyN5slTXttN8oEHL5mbowyiR5L5qRIc8Bx2al+l/9BzSY1l5v4CRI08rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SRYwi/l+lQXFAiQDCz4NF8mcUzXtEfP/dHfCLDOS58=;
 b=arwAg4lWtpJ/qLFkYknOrIln59hVTm4oIB5w7BNrxgU3DxJZj5vwhDSJFvJGrYjz6mTZLN8lntBBg+u3q30Q2jsCFq1nxZDwFGnN+hzk+J85GqIvfMGXr0Fzi2JUrZ4/FjRVaQk6xwbKJNkOa0rPuKx5OCLwlWtjI3ResH9WP3enKW8xtCPdJ9aDMH4WVltCH7cZoR5JODNM9Dgehymims+1ja+PcUd2YL/kQsuSPZvZ0KlrDuzlQzgpa72uBE2FTHLoOXmOI87gnJdND4h5Ajh/LN2LOiXC4uzbCoIzsd/TKOu9PrTWNUi0fRH0JKM6iT9AqknfmK/0XOK8CMSxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 22:16:50 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.035; Thu, 1 Feb 2024
 22:16:50 +0000
Message-ID: <4468be08-1496-4092-93ea-1967aa667c4c@intel.com>
Date: Thu, 1 Feb 2024 14:16:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v5 02/19] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Arjan van de Ven <arjan@linux.intel.com>, "Huang
 Rui" <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>, Dimitri Sivanich
	<dimitri.sivanich@hpe.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, "Andy
 Shevchenko" <andy@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.410413470@linutronix.de>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240117115908.410413470@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0254b5ec-ad52-4049-adf1-08dc23737cea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xe6/JC7JhQY3LyTOw4jotDsA3pH0dLfPGgnBIMtfZN9NPAcry+pQNQm+oEvuRFBd+vrdQ21uHNw0mg3O9UWQhvOT2qiMZvmRYipELuVirihy7oN2unnQYbFcEPm+qwqG3cYTnglD1G3PfFIZD6FPDC16Dcy45Y3bYAYFG9EpxA2ZOm3Zm45MdyLRTZ4PKaY2qoDsDcCY3yi5P9kQjuEFzkvpNpGoH1Lb4oZefUIW+vxaszmb2eDexaP9kfovyWNT+cACnMTVHjeFBW4HK8W9BM/r5ocM/r4eg0TnJIwpsGGl6O3PyF96nsrRCi9z65Y24TdQ4J+EH2mdKLpsNF14QlZpaPVnkF2lZQvVFwiTsXx+Wtkr+AMWnpapI2IwB91g0ux4YgFqtak6L7FrYhvzKiPZYlKxMYaE7njoqvCdQGKuTpOg5pGusIf3Zytn6fslkg2dPs2RHoXKHoR4m6QTsgp0kKBvTX4xOV+iHiBqjyeIK37rb6eJZwlrI8xIy6EYNZ5lQHn8Oy1aFhSXAu4f0sX45/lx0UGvedgBb1TuRTcEsx7ufKAy5GVdbPAYC1rp5nNwu4nY4cfUw2BZW4O9KaqRvIVT1QiHTq+XEPiQkPQuafDyinM84NMoqa34k+aGrW/I0KmfKvioIAm1B/lDjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(2616005)(8936002)(38100700002)(26005)(6512007)(6486002)(44832011)(66946007)(66556008)(2906002)(8676002)(7416002)(316002)(4326008)(54906003)(5660300002)(66476007)(6506007)(4744005)(478600001)(110136005)(86362001)(36756003)(82960400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2FEd1F1OEh2cWFkWDJ6OE05WFgzVzZDSzFuY3I1b2t1QnRSV202Y0FUbkVz?=
 =?utf-8?B?cGlxTERSR3BORlVYWWlCK3dPV1lRUnNiM0puMElWZ0tlTTNyakUwWU5ZKzZ1?=
 =?utf-8?B?bWxWaTNhaFlGb0hXMXNHOXgxMy9GaFUxQ0FLUVQ4aU1aMGk2NU1RbzNMY1A0?=
 =?utf-8?B?QlFUQUROTE5zMGlST0E2NzdTbm40MlZFeVV0Z1pFZzIzZTNvTy9GbXpHNHBt?=
 =?utf-8?B?YUFzaHFrVHF6N2tSRjdScUJjMG1rOG9meXhGV1hjKzJ4QzFQMkNMN3VHbUEy?=
 =?utf-8?B?VmJTUjkrRVNlVjM0MmxoZmg1elNwZzlnZnFDZ0R1aU1SUkVGUXpFeDN6TnYx?=
 =?utf-8?B?NnQrakJ4TFRtYm9mRnBWNUlrdVY2ZWh6RDhQTVIvMmswM24vcS8zTGVPSkJl?=
 =?utf-8?B?SkhFSDRuaVAxd3NzOUczU3lEck5rYlIzeGlva3JhOHBudlRyWEIxSG9UeHVJ?=
 =?utf-8?B?d2hDd0hlR3JkbHF3MkI3bGhCLzFucWQxaTZQN1dGT3BlY0FZb0h1ZXh3M2t3?=
 =?utf-8?B?bGYxMUNUU3RINnRlaWxpdWdNUmpyUmYyQ1h6dnQ4YjNHUm8ydjNpb3BwRnZC?=
 =?utf-8?B?TFR1dHI0cG5NVXVKa0R6WnozM3dXUUZiUGRRbDV6Zk1yL0x6RlFDcjJuY3FE?=
 =?utf-8?B?dXhYZGJiUGZ3SUdxODMvQkhFeDV2ZmJPNnM4VkM3YmkvOE9rNjIrTXlHZW1s?=
 =?utf-8?B?UzFEREhtbjI5ajBQdUhDN3dtcm56eUp5V05yeDZBSGgydjl5Skg2WTJJdDB1?=
 =?utf-8?B?Y3hVWjdyRVdYVW9Od2RiYmhIQUFzc2dacW4yMW02OUhNK3o0YndmNFl0dUpH?=
 =?utf-8?B?c0NyTnJzSy9DYy8xNEpXeklwcnFicVlHMDgzeDVpUVdJYzZSdWdIcERsYkdU?=
 =?utf-8?B?bFZzanFoRktSVSt5eUQzQlJKWktVN29BOXdVcEV1TlpRSzgrbU5RbnpsN3BV?=
 =?utf-8?B?dnpkVk1GNDk1aEtpWGdGSEZlQVJWeFFNYmZZSFQrZ0FGbkY0MnRhaXZPdFhx?=
 =?utf-8?B?SnBOck85V3E0N2JLYndkaGZ1Ym1KdUJGSXZpcW1BZ2ZFb2d2Y29RVjB0WGM1?=
 =?utf-8?B?WVl0T2lPV1VYcWd5elFFWXd4NGR4UnRqZWpDNC9BaXNzeTZENTVDSnZwUDho?=
 =?utf-8?B?elJIZHhob0hyN3VzYUdEVmRQRjBYcVIzTE1uMmlOWU1uQ2k3MDBHYUR4VWFs?=
 =?utf-8?B?MGVwT1lmK05LWXBhaEdQWkRSbEpOWGIvZTNOaVprS0NzTWhaWHo0eTQwWjYx?=
 =?utf-8?B?SW1rK041S0FuVUwrN1gxVzRGbUMwTVhUbGgwY2tUS1g1NHlmbXdCU0tNQXUz?=
 =?utf-8?B?eEN2aUtQTkJXeEZrdm1wM3BJZk02djN1SDZBcVMyUkcxM3lvcWI3Y01BTUl5?=
 =?utf-8?B?MTNEb2wvVVZjNGJQNEpxOE1ieHRTa1o1M09VZU5SUTUxOWVvdFBZQXRLZmhn?=
 =?utf-8?B?N3Ard2tVTmE2OTFNRFQ2RHBjVGFsczRLMXUvdk1ScGQ4Y21yclV1SWxTWnFG?=
 =?utf-8?B?REhhOGE0VGFJdWZHTHQzREljRlFWd3A5UXliSTBmWXhkR1hwVkpQU3lMdzFR?=
 =?utf-8?B?cU5IbzM0dGw2L0Nza2o0WkFEdVgrcW5rR2VzY0psQUFuUjNIZXQxUmNJYkcy?=
 =?utf-8?B?UndJYnBwby8wT1pEMzR4cStjTUdpQ2I1MDZtM3lBZ2pYdFZXVEt3d20xT0R4?=
 =?utf-8?B?RTFpN1UxVWtsL0pNYWRzY0Y4RDZ1cGR1bWxIbkJVVDZiQWgvTHNrc2tvTU9Q?=
 =?utf-8?B?dEZ5UXZndE8veklaTzlyWTZUR25ORzFxU1VaRnUxSVJwMHJXdit5dHQzb1RK?=
 =?utf-8?B?d2NwZE14REtKRThPRVdCNTlYSkJLbmhvei8rZjBHS2F1TjhwYUFpV0NCM2ZU?=
 =?utf-8?B?WnVtSXAvUFArc2xoOHUxMk9lRXVYWUwxREZOckhCNEZNOFdhWHN4aFZaQ3Ri?=
 =?utf-8?B?bTRBbXo0R2ltYlRDODZDeDRaNjBnNUdvZytZaXpHSXRHMVdrclR5VkdGVmZN?=
 =?utf-8?B?aSs4QVlyVEFITVVKbktZSDZnb3VCaDdCVkp0Vy9ReXQzOWp4SndQWEk4TVN6?=
 =?utf-8?B?RE5BTFluTVFhazlib3J5WnZKaHh6d2NiaHNtQ2xQL1NGQ2hsb2R1RWo3VmJx?=
 =?utf-8?Q?KLMJNEftlFWpEIgYGqO7umPh7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0254b5ec-ad52-4049-adf1-08dc23737cea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:16:50.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpD/BiLsrWEoTlpvGFX3KKcU/gkeG5BoCiDptTP19+kJxrGUq4PR9AIc0DU+ANc8Li3o4Oh/MqmBpeETrBMjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com


> --- /dev/null
> +++ b/arch/x86/kernel/cpu/topology_common.c

> +static void parse_topology(struct topo_scan *tscan, bool early)
> +{
> +	const struct cpuinfo_topology topo_defaults = {
> +		.cu_id			= 0xff,
> +		.llc_id			= BAD_APICID,
> +		.l2c_id			= BAD_APICID,
> +	};
> +	struct cpuinfo_x86 *c = tscan->c;
> +	struct {
> +		u32	unused0		: 16,
> +			nproc		:  8,
> +			apicid		:  8;
> +	} ebx;
> +
> +	c->topo = topo_defaults;
> +
> +	if (fake_topology(tscan))
> +	    return;
> +

Need a tab here instead of 4 spaces.



