Return-Path: <linux-kernel+bounces-62279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D856851E02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829A9B2194D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960C47A52;
	Mon, 12 Feb 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYacB4i/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A601E522;
	Mon, 12 Feb 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766869; cv=fail; b=N1JkuQZUlYxd1UvPtYP8tS1BBS9OdBePeacXhCA65xKvvtLIMRRBk2a+jNf2AlzCar5wFJNMKqT8rlWpdZPCCpsMOgr7B//tpKrHpjViEypc++4VyiVjzXiPXzOCgKV/sXA7bmyF8MtTruNQFdI/R2mhX16XppmGmQHZjc5K+hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766869; c=relaxed/simple;
	bh=izB9mcaFUV41x7bhaaxG/GMvnBDlze5hNOlGEdl/seU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLLLC0kgLGO++WK15duKi233xdnnePf4cUjZM2aO6rtpQz5xQnpFSoHPBPWl9b1+hxTYuBcDuqbYoh8Nmeo/0yG4QP1b1r+Qa8FonGR6H+vHP7ST6DLCr0jYoSWMoLALXZmk+fGgrnvKCx5b1xqYmC19WRp9djWtFCk/GTuSlg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYacB4i/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707766867; x=1739302867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=izB9mcaFUV41x7bhaaxG/GMvnBDlze5hNOlGEdl/seU=;
  b=eYacB4i/vqxmWHCzmGn4ObJ9N77+Lv7jWWFN0Iylr2KMPR5zhkUx8Va9
   HLUEsW/YID159ePB+gH5bbo4xHKv/vPbpLMw8+wrTla/UyQdkzz0WgmuJ
   2ZFrckhV21XEYO3D4KAIFqJyBRj/0Jtxu149F3u5D6eRqeAhBnaajj01A
   xcbDCPPf6ZS2pwLK/JPmRwjrHb+JYSWieaFX5ftZA1YV5O+RvGHnU3OFK
   N+qYpCLJwN8P21TzRWPPYLKA2f8ZBxSbAi2kLob3auolQoYRKPmu3jRqz
   F7spzlucEDRmuzjVxksMBN6TNY0beTV93z/2RqEbf1oF8a6NNcKgwdAx7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1612019"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1612019"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 11:41:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7327310"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 11:41:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 11:41:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 11:41:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 11:41:05 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 11:41:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2+0YOEl2bQkVCA/ZYfraSoDRJIoOYkGN9a8jGaA5lF7+Qz8ujN0b69lMhU7jJiCHqty0po+ChSt6deR/D30B9Ph5ZYeP3fAZsw10DLHHtkkj01SmnwgWc61dCa+sGjktnQeJmsho38Nqqb7+epXOohsA/9IoaC1stR8HlBxj9u2I/UKdl4SBjPUYo5r9wWLqG5c4uCe6But+uPvIo6oa7Y/TqIH0Y1xQ68n3xIPLCSGlG/R53pFs7Y8+U9GsVFi9i17PTaO3TolelUudI4ZdCgyosOAMHPjAsZMBHZ45xSOSyVazpIWMGT/7piMeGo2zpWphslp2OJjhhqbpsanRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izB9mcaFUV41x7bhaaxG/GMvnBDlze5hNOlGEdl/seU=;
 b=AoJ8UFEUWS80YggbFtIXCo+GzL+087NT/vgmz7TCNFUV5P0janBE/bitxcjAwsYjzG7MuTnMY4VXF18KaoVX/SEOjZv8eiSHo7G05ZIjLibIz2xxfkE5PLtbUzQKo9ehOvVjm5NbOqcwLeWuOPJVYKKnL//uW9Y6W0cwC0yktzsxo30Msk4cGWK6tjg5jukh14/WCEsT7yRUI2zWenUJmXoZHA7CooQzywmO87aeN+BPSHNDgMAkEosOSlsTnoVclz9rORq9Z6dkwUkfEp+mMPhoSz4RGyOgbXHWkyPgAVGt5ZNdKdgCeSuIuduY5KPdgq3nMTdNl8wNmwZIXMeTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 19:41:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 19:41:03 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Naik, Avadhut" <avadnaik@amd.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAQaDgIAAZZKAgAAJtgCAAIJw0IAACaQAgAALi8CAAArHgIAABYLg
Date: Mon, 12 Feb 2024 19:41:03 +0000
Message-ID: <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
In-Reply-To: <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8554:EE_
x-ms-office365-filtering-correlation-id: b3615dd5-a29e-413e-bf25-08dc2c028c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfGdE/WX6JgL/uOKYstQVeZl7YviVIjduvBBx7zqh/TGmtkbcJHnVIwtU5aIaWtffc+NQ4nEe1RJlrf3YL5RJQKqCSgOxvKsQlTsjNvqUfhjcNf1FNDVTrOPiziB9KmUlgKimdBBiSucE4TdXzpCGbr8YQf70loKV2yuu929xd6Ca5WbpTmT1PWuGyti/WXmgX7Y/sUm+eF+wSFXVAPISuiUWXjeM2h+2AtUZKERPQfGs5fJhifofah6EguWBwQNGIaDVbrB1LKWIouOyK3EJRhsJYH4JfhG/wL2nDMG65pwZPE24aPg66ewHA5YEy3q6jtV6+PBaeCpXxFTUxwvTQGw8GRqBc/WeXGN54dOEAxGbLTw+rPtQPylAl6IODCv3TtDsMxBdPpGUjo+LVla3tzZmuxoSDh42qvc4cmWL65F4Qe/crnbARvccqoQIO2fWOxUdP3krDzJpdf64dBATVu82EX4IAsqTRbrURnyrSmZ7eyZ6NrEKdITskSK+OLY4bxUeT3B9aI16Wq/ENb/ZevbLvhUanO6DeDSsxXYojUktiWyrufoVk7vh8PeDhUTWoNeswJ+m8LVCFD7NPGnz4LTw52Hfqbrk7BCUg8vOKoaRBDpN5MVtldI7VnKphUh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33656002)(558084003)(38070700009)(55016003)(41300700001)(316002)(6916009)(2906002)(478600001)(66556008)(64756008)(76116006)(66476007)(54906003)(4326008)(66946007)(66446008)(8676002)(8936002)(82960400001)(86362001)(122000001)(38100700002)(26005)(5660300002)(52536014)(71200400001)(7696005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkluYkpPNE50Ump3LzVlRm1qOEhEVFNvaG1zQ3VnV3FDNHp0bjVYSGdMdExZ?=
 =?utf-8?B?eUVrMEIvdE4yU3RFeHRna0VuTXdyYXMrZzdZR3lKaHpkS1h0NW1Hd2FxWm5C?=
 =?utf-8?B?cTRYWFA5SjVoeEY1Z1Q3bTBYdnpRVmpQWWo4bkh5RzUrWm40QmVGMkRjQ2FD?=
 =?utf-8?B?VjgxY0lPVTBWaTllZVFSNXNPSUpRUnpueTZRNlJEUFk3ZXh2QldhWS9KbVFB?=
 =?utf-8?B?ZGErakJ3UHJsdHAyakx0Qi94cVBSUkloajl4dzhVVGJINDFwRk81dTkwcmFZ?=
 =?utf-8?B?VG9IZm9xeWV3L0RIMDVqaTErTzdqWS9iemVFS3ZlSmVWS1ZFSjkvNVA4dWNt?=
 =?utf-8?B?QnNtN1laSGxrUFZZV1YyMnViUE52RWk1OVM2SzZVcnZiMW00RzVZSi9VNnA4?=
 =?utf-8?B?ek5GQlJGS2o2UjdLRU03UVhjazZUUnlvYmVZd2VyR1p0eTNsMVlabUs5MzNt?=
 =?utf-8?B?Z25zbkI1WjROT1BGdGtKNE5DOFpIVzMvWTdLQzB2dnNpdEJHcko1L0JoOVpU?=
 =?utf-8?B?REQ2YndSZ0NLMkZUMzJXNW5HdVU0QjI2RFBVQVpyMDlkYStlNmZyNW5IRXNQ?=
 =?utf-8?B?Vi9aV3daUjE2YUNiRThBMGVVS0plbmwzWXNPWHVzcUxwT1ppdDdwVnBZdnR5?=
 =?utf-8?B?WFF2R01nZXJ6M0h6aVRhN2FxZlFrRll3R0p1MDYrSWk2YlI1cS9uTDZtU2tQ?=
 =?utf-8?B?c2lFSlE4YzBFQUFuMmlHVEtMRmQwZ1JTWG9seXI3NG9zN1p6dE1zTmRrb1o0?=
 =?utf-8?B?dWpyMTg2cytYczMxMVoyc3orY0REK0pTdjNBUFhySmE1ZTFKMzNNdGFWajNS?=
 =?utf-8?B?UVlpNGZLZlNJekZtVmhtRkxqQTBIOVk0a0NqdGI0QmNnVFFrbWc5bWU0bUJY?=
 =?utf-8?B?a2F3eCs5MWRHYUo1TkR0bUJ0TllEN0xTcXpUR2h6cFcrYWI0cFVWUmtsR0sy?=
 =?utf-8?B?cmM0NXlIaHBPdlE3TlZFb3hBNmRndWpoclhSQzl0eFVLWG0zZGxZNWZMQ3pn?=
 =?utf-8?B?MjVTQVBYQWFqczQxWkRDVXZ6cm1iU3lHN1RGelp6WlkreFBrUDBROU41bDZu?=
 =?utf-8?B?TFAwRS9HOVY5NXNSRERia2ttVXRXeUJvdXNVWEptZUtvZEUyRWFUM05TajJl?=
 =?utf-8?B?Vmk5all3bFJVak44Mkd0UkI0QWFCNUpNM2syYTVQbmpCa0N0QUxsSzVySHFi?=
 =?utf-8?B?NlBzeEdLcWN0bnhMaXJabkdRbFl6bDlQeGljclcyMkhzd2cwbVdybXk0b3Zk?=
 =?utf-8?B?dDF2Ly9SazAreUtrUW9nTmljUDA1bXRxdmM3Rnd3dlFOZi83UVdGWEZodmVF?=
 =?utf-8?B?dGZYbjc4NWJ4NlNkRDhGbXZFM1pqY0lyN3N4c05kWEhGRnc4d0lzUUtyTEJz?=
 =?utf-8?B?M05oVXRmVEFML2lxOFFDN1RNZXo2dGtqVjZ4aDg2Y3BwVUhUSG04M09CYTFS?=
 =?utf-8?B?VlV3WlVhOUV3OFdUc0s3eTB5ZnNxVi9OU3BKOFdaWmg0TERTVmE1V2p4cVhT?=
 =?utf-8?B?Skp5WjhYakxQUjNsOFFKbldaK3RCTnh1UkplbXBHMEI5QTZKdWJiSXNQVFBs?=
 =?utf-8?B?ckRVTDlPUCtOL3cyN1c1bkNOYkhpRzgyWk5lbVc2QlQzU3dPZnNUdzR4RXpD?=
 =?utf-8?B?K0lPK0RpaTBBRUxZL0hxcmt0N2dTYVFUaVdZR0ZldWZ6SEFSOVp1OGJNVVBG?=
 =?utf-8?B?VGpJZVdlWHdZcERMbW42UHNBU2V2SW1TcW5BaExLTG0rSFFFaUtoQ2JMU3dB?=
 =?utf-8?B?c09hTnNoakVORm5RclV4NVdzRGQrWmdXbTF2Y3JhMTg1NmcrWFkxbW1kNklk?=
 =?utf-8?B?NEJ2c2RoSm5XN1VodjZ6ek5BK0UrUlVqdFVlcm1YdnNOTUhSTGV3WVhZQ0ly?=
 =?utf-8?B?cWsrNHd5eHh5N09xTm9OejQ5ZHkzNHl6NnVKb280dVdoazBPd2FnaEw2eFdx?=
 =?utf-8?B?RU9qSzR1UmljVGVoZkR4alFuanNqTzVLQXZzOHNGQzBLRENPbVQvT3FNejVI?=
 =?utf-8?B?VWpTTXp5b2FxMzVPQWtJd200ODFEd3pUUnQ1QlpSTmZXMTdhc0d5K0tCWk9T?=
 =?utf-8?B?RVNJNXJHdWRuQVVLdUJ6eWN2UnFmRjdrTUpMV1V0ZE5NcGU3bTlFV1EzUldk?=
 =?utf-8?Q?xuo2jIgWOTqdyFnth1F6c7TUb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3615dd5-a29e-413e-bf25-08dc2c028c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 19:41:03.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0NZjEJ90Y77NsKlSYkohJp+mJ7Uv5a6nLefvpEtoobwu/caN3Qov0Sq6GtDL2azuiK9ciCNikWM9ZEsgMyJ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

PiBJdCBuZWVkcyBhIHByb3BlciBleHBsYW5hdGlvbiB3aHkgdGhhdCdzIG9rIHJhdGhlciB0aGFu
IGFuIGVtcGlyaWNhbA0KPiB0ZXN0IG9ubHkuDQoNCnN0YXJ0X2tlcm5lbCgpDQogICAuLi4gc2V0
dXBfYXJjaCgpDQogICAgICAgLi4uLiBhY3BpIHN0dWZmIHBhcnNlcyBNQURUIGFuZCBzZXRzIGJp
dHMgaW4gcG9zc2libGUgbWFwDQoNCiAgIC4uLiBhcmNoX2NwdV9maW5hbGl6ZV9pbml0KCkNCiAg
ICAgICAuLi4gY2FsbHMgbWNlX2dlbl9wb29sX2luaXQoKQ0KDQotVG9ueQ0K

