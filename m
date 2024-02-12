Return-Path: <linux-kernel+bounces-61513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E093851316
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F581C22716
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5B3E47C;
	Mon, 12 Feb 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pq/kSllr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC03E477;
	Mon, 12 Feb 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739488; cv=fail; b=NrGt3cbksnQc+9JPJ6ptlDE9JkSz/xVJJV/JIOvUCLczMv5Z+D2RlKoMbYtHTUR8DJdKjUTCXysyB0+pslXSlAFl41B7XQnFOlGNWX676P/TlHz2DDE+rXKUvJklWFf4o5rDXGKXKr47VpCUYyK2aasb/i4xjGIOaLNcxUr+8OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739488; c=relaxed/simple;
	bh=LW84lYMuJP3kPA8sPrWh8H/sgNMEglNzq9ACigPsbCo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hIEt6l65FsSykYdw0AyVX0GCOSf8uo7TaH2yYOxoyeQVh7cgtAsT0tqwQEt9i0uz8yPl1B0LyvhZK8HsBk+OkthKcWm8DzS1qg3jN2GBIfNf/3Y9GxQb3uVjR5dcf4sU0Qljz99aZuP7tCS4CXy7x5z1FchQwB8PZ/ruuekB8js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pq/kSllr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739486; x=1739275486;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LW84lYMuJP3kPA8sPrWh8H/sgNMEglNzq9ACigPsbCo=;
  b=Pq/kSllrSxasA2cqNQ4E+KDzIOtCvv68Bg4aSai/w2Z8wjvzralG9zZm
   VWV0wvCyKKI8R8ff2fEqWK9VG8MoFeifkL09ZwLUhpBCsoLsTZSjQo3al
   GyC2a7xv3md2bPvzZ/zuxxdCeEbL9j7SpWnF+l496SPfWk1MT3H/3BIBY
   eetK5FV72cFNDh6f4FCSwcM2bdvAiJsuWwtStvbvPdFpg650BC1dEd4az
   +8LXDoRc/w7YM7gGqL3Sq0/OUAiqDbmFKJV7JNcgDFS+WTnvhdt68FrBf
   ubnkNLGiC9OC9/FKlj+9+lYca29Hn+aUy1vDHOituZvT/SX7oSXfSXb/i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1615629"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1615629"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2886858"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 04:04:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:04:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:04:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 04:04:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 04:04:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVtr5WzZVPeVAWFCCrEWofmfJTauroCjO1/Ik2VnR9vPYUkILqtz+PdJd5iee/5mF3cY/5AqQalEIqs97hlYJFPB1SmOIMFuY+uHxnZ1ZBttbJorxTVnNG2Qt6dj+COKb1Tr9a/tZRNMIzb3QWVmJldsxV+/vttVc1SBz4wTJW/FCg15X6A2/mR75xXXl9qBvO6C+9shqYw2AnkT1MZUckP/xoPhnQdQdxfQU+D3/DAtH0RtW1rx+0DFL+OQYlfeKPfR4Dkyw4OJ63/5Ca4SnC7fS2lN60YfvY+CNmm4KQy2PvfeDL3rl9wCtQkPsnkwCQGg/uNE4qovR39kJ2lYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/15GYmnvEdGEsK00L4v/tPDzzg5Mpm66TP/AWbhkn28=;
 b=NEjqpgKu3dJr3qcKmHg7dw5bXyqpdQRoBr3zV7YHwrHnzEgXZwY1jj+koawx9X13nVhYcUKJ11lMGsba0XvdNl3MhEI4VHmw6TupftUnYl4exaUGre9R2HB+wh6bPjReBFO3UWDGWOTdTB9d8XSC7gMscPCfl/oS66yJBBcEUi2QK0djauLEllc/BjTkA+yr1E+ZXNJxe7fs4tFLn5orsvYt1HdptY++07diSuUK1Vv10VRLpWuoRgV5GHiNJ68nxb+b35Qs2nvYmM/DzMAtjsVEXathYcR5fMPtU+tG5+4MMyHZrijJ1JtNY8pVAbRr5ImLUQEQ7ev/BbkTc1wxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 12:04:42 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 12:04:42 +0000
Date: Mon, 12 Feb 2024 20:04:31 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: <oe-kbuild-all@lists.linux.dev>, Icenowy Zheng <icenowy@aosc.io>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dalton Durst <dalton@ubports.com>, "Shoji
 Keita" <awaittrot@shjk.jp>, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 4/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <ZcoJT8br375iDj2v@rli9-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240211205211.2890931-5-megi@xff.cz>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: a747895b-b1db-4139-16d9-08dc2bc2cb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWvrlKvNBlBSfqZNTdUinMdiUMFmnrzaUv2OcD/HzNTBlOWDnPOUq7kExqyBEXngKQOf+vvqJWsizAFAUZyOetY6phsq03yCEmEj1qOW94adOab/GbMxcizhBehcNB7CAHrCT+RX03ictrEh+lW4NI7jFFbOtHW8J1PmDMGmbRmcOgogjYdj5ps0noODiI30RW3na5f1UGOA8mydNWe61JTYHdBcTj9lICEvkDwdo14onMWlyJGLpyH/xPvLcm0i2i2vUp9Lcj2JC/WlTmEt2/G+YpQyo6AEKEsj1XBUoWiHbgG3m/JGJOJcR57FlZBxUOY2C2Alfv6Le1a6mWb0EkwZ5OEIxjHfHvPUgadgt3S7t/gs/BkYAkHWFCt+XOHm347a0IMg8+iAseIdrcStmMYTPiCWnN3R2mFUunVZ80QkQxvsl2XdJacUVW6yhQEjpkZmQbTQ8eo40KofF3Hym50kOlPB8uDxSnw87ZSOFjf9gz4iRINQE30VYHCl+8moUR6a2pKjYqdVHuPkc7RSNp/XPgDEXakhA1xz2QTBDB2qa0r+1G0ZNBOawwwZYqOboOJSSpn5R4Ds7WDE2fHNXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(9686003)(478600001)(6512007)(6486002)(966005)(41300700001)(33716001)(7416002)(8936002)(4326008)(8676002)(2906002)(5660300002)(110136005)(54906003)(66476007)(6506007)(6666004)(316002)(66946007)(66556008)(83380400001)(66574015)(86362001)(82960400001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFtVGRUZmhveVp2cnNrMzlPcFhZZ3ZRUEdOb3hoV1dpY0NsVThTNnpJT2Ew?=
 =?utf-8?B?L3RGYng0T0xWSmMvT3hrUm5adWIzZkl0Wm9objNiSWVIc1RMNjFDNTJTU2hw?=
 =?utf-8?B?SWlCRW9QZDJRNXRtT0RjbnRsbjYwTE9IWlRHYy9pLzVkNW9oNmZjRU9OWnJa?=
 =?utf-8?B?NllnSDNYVk9BT01VSVRsQU5qUkI0RzNaRGdtS3huTTh4ZTVmbkhURDc1dHhX?=
 =?utf-8?B?R2ZyQ1JrU3MreEpsZEFrbVVrNXMwQ3NZZlNjbFJ5RGg3MXFVdTRZUkhhbVIw?=
 =?utf-8?B?YVdLdk1BZXN5ZGFRZXliUzRVeSsrRHRmK0V5ZkN3NWlGRCt4S1FEdjRJcWU1?=
 =?utf-8?B?c1RpKzVMZ0Z0cElGdXNScDZJRkYrOHdmL0g1blNHa1dpamgrVSthemtFeFBj?=
 =?utf-8?B?d3lZa3JkSjIxeVpMamVKczM0ci9KYkt3UXBqNDVOWnZLRVpNbWFOYW9MSTJa?=
 =?utf-8?B?VkkwOC9DdWd2MEtsWHBQU0Y1UzBQVDVXQVFGeWV6YnM4VjZkWmp4NWVSZDFz?=
 =?utf-8?B?YW5YVkRONVN3TkQyeHErRUtpU20rWm9YV1F3dVhHODdvaFdnSkI1RWRLUGpB?=
 =?utf-8?B?K3YrMUIwSjM3amI0N2Q1WVpOR200bnhLQmx2OTZ2UjNmUkNic3BLeVRhZlRj?=
 =?utf-8?B?NVgyZW50d1p3SlJtVU5VVUdPbEMwZEVqVTV3UEJweDlrNWwvSFQwaWVMMGFH?=
 =?utf-8?B?WCtaa1VvL1lxR3lQUVAxZlorUGRjenhXQ0JOSVpCbEFQd2NtcHJ0Ui9XZGN4?=
 =?utf-8?B?cGJoTVRJeGRObmNyWFZpbG52Rk5uNVhocjZyU3d3Q2NlWUREM21MV1UvQkF6?=
 =?utf-8?B?RWhjeFl1Zjdoc2VJZGNzdmZobTcxemlSV0pzUVBkY0xKWW95ZmNMTXFJN3RC?=
 =?utf-8?B?cXR6MklMWDZ1ZnZEQ25JelV0T2JZRERGT21Kd2h4Kzh4dTlac3lSZWZ4clBo?=
 =?utf-8?B?Vjc4TmxNLzZ5R05lS2cvcVNTVFB0MjNRSEx5VFpWdDdHQ0dXV0hoWVVGTEpk?=
 =?utf-8?B?OVBUZjVYQm4wZG5oekdkcHpvcjNVTWZGRFBTdWRtaE9ic2k4ZHY0ZDFTd2hS?=
 =?utf-8?B?aVdYRzBtVkRmVnJYcmMyeDlVRTJTYk40V2NSKzAwRUhOSWoreXJuZE1RZHY2?=
 =?utf-8?B?dllZUzRwZG1DTFlZNjJObCtlNTg2aGtUQjh3R0pHYndieVgvcytKcFZwMVpn?=
 =?utf-8?B?WjU3OHJVR2dKYW91TmxuRVNmQUFHMmlmbWxyVTdiODBrRHR5cE0zd29VUTdD?=
 =?utf-8?B?KzZDQjNLdnhCS1V1dE0wMlhWcWJYSFk3MWVMUlpBUlF4S05ZU2VwRmNWMG5u?=
 =?utf-8?B?OEhuNzkzamRlSUJFSlUrbWJuSElabEZGSTV2ZVJpYjBvYzJUM3p4V0lyd1NQ?=
 =?utf-8?B?aHFIZHdwMUd4UkRHYWtUTkc4cEZaMGdLa3pTWjRzZ2RMSEpGZ0N0SDR2SUVm?=
 =?utf-8?B?QzRMNEZwOW04TUFvQlFJSHFmcy9icWxlZFc3VC9zaVZzZnBrOHFjWTJ6ZFBV?=
 =?utf-8?B?OU5Ec1I5SVhyK3JWR2ZJclBIS2g1cFBHWTN1YlJ5RldpeEordVl6ZmZTTkx3?=
 =?utf-8?B?MndXUHN0ZEk1T1Z5MThjQWs0Rm5GNm9EdlM2UFNqdlJqZEI5UHdsYTBneTRq?=
 =?utf-8?B?RUV4ZDJxR2lpNEZuOHdaTU03WmxSbC9hZmRFQVNUbS94enY2OGNSQm4vcE9k?=
 =?utf-8?B?aE4vai9hVUdRSndENWpDQ2RRSXFkZ2JxcDJ1cU1meDU2cTVyOWdyMDdIMi9B?=
 =?utf-8?B?cEtKQ1FsL28xUzBXMDBnZWpKTkZ1dm91OGc4dTQwbDVEeDFBSysyS2dISTVl?=
 =?utf-8?B?QTllL3RBMldCR2Qyc0tPekpwMDRyTXNELzVKaTBuSkZ5WjZ5MEtFSks3czZq?=
 =?utf-8?B?WXYybHpnT3ArdUVjZXRMZml1VGxUaGhBSnJrL2V0RjQxeHFqVVFDQlFDbE9t?=
 =?utf-8?B?WXFPRllaMWpYZDV2dWhkbGc4a2dSM3NhN1ZUQ3h5dWx6bjcwMnVTcUdWSUI3?=
 =?utf-8?B?eHFLaXJCOGNnQWpDTzN3MHNwVU9udWRQcjUrdzdpVGU2Zm9IQXR2NHRzVThk?=
 =?utf-8?B?OXZYd3ArdTBocHE0eXk5UTd2K2krYkVuaW8yeURYWnNISVU0VVJIV0E2Wmxs?=
 =?utf-8?B?Y25adjNNU1k2QlBHbDdQSzRNZ1cvNWJxRXk3MnFhQWhrY1hjc1gyTmllbkRs?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a747895b-b1db-4139-16d9-08dc2bc2cb7a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 12:04:42.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Xv7Q95tiQBFpquRrVRlUFBve4/Ww2ao+bC7bfiEgLBhv7WG8jNlUB8KrZsSGtRybmxKvCHLyS8rraF9D0hwfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com

Hi Ondřej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.8-rc4 next-20240212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ond-ej-Jirman/dt-bindings-vendor-prefix-Add-prefix-for-Voltafield/20240212-045510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240211205211.2890931-5-megi%40xff.cz
patch subject: [PATCH 4/4] iio: magnetometer: add a driver for Voltafield AF8133J magnetometer
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago
config: openrisc-randconfig-r133-20240212 (https://download.01.org/0day-ci/archive/20240212/202402121800.Dk09l1F8-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240212/202402121800.Dk09l1F8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202402121800.Dk09l1F8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/magnetometer/af8133j.c:492:25: sparse: sparse: symbol 'af8133j_pm_ops' was not declared. Should it be static?

vim +/af8133j_pm_ops +492 drivers/iio/magnetometer/af8133j.c

5f47c80d82e489 Icenowy Zheng 2024-02-11  491  
5f47c80d82e489 Icenowy Zheng 2024-02-11 @492  const struct dev_pm_ops af8133j_pm_ops = {
5f47c80d82e489 Icenowy Zheng 2024-02-11  493  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
5f47c80d82e489 Icenowy Zheng 2024-02-11  494  	SET_RUNTIME_PM_OPS(af8133j_runtime_suspend, af8133j_runtime_resume, NULL)
5f47c80d82e489 Icenowy Zheng 2024-02-11  495  };
5f47c80d82e489 Icenowy Zheng 2024-02-11  496  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


