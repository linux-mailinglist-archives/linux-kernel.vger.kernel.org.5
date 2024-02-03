Return-Path: <linux-kernel+bounces-51011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D7848503
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31CA1C214FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF15D729;
	Sat,  3 Feb 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dx4IQKNX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E935D489;
	Sat,  3 Feb 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706952775; cv=fail; b=JPkdKfEHn9a5+dIl5Lx+Ap8PABdf8yLEAipbN1k9zq68eOvIWFIVUB1e35eg6GfD2yTL3Rv5uJu/t76Otn9T7u7l1srEIETjORCP7lEPBDnvi0nd9sPGjquUzikf4BLNEPUtLiODreWTr3pG/vaXfPuYVJa7A3r3LcKTSfJxEKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706952775; c=relaxed/simple;
	bh=I+yeeGJT/XHYAKDWqMQs9B/vvy686WvPX4HYvCi6UW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=duSlUNaOqPYC/5tKdRXTv4BVpmr0tOrsyu4DjeZrPksP8h6KkHXPSlXZWQulGlGy2KbgcGhqJhe0h8ZlpvH7O9KqLo1ODms08a5vBOEmPp4UBkghzKhYckWSq+gdoI91Ox24QIn3ulTf1p3ViX+8cf+HHuKBQ4B+lGQiLk8exew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dx4IQKNX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706952773; x=1738488773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I+yeeGJT/XHYAKDWqMQs9B/vvy686WvPX4HYvCi6UW4=;
  b=Dx4IQKNXK0oBZ5PLwMOFq/GsN4YVq6g9rCora4GeIzzjcMdQzxnwYcpt
   fVCTfJmlIgJH9g76g3KW09Gj3FBWDlkaLh0w+P9dq7jXJ1a64QDnwBK9w
   /zRNHMOK1dTuHSoCWny1bQe2TcphfVi/OGkNzXCuNemZQD6ZHllT+iQ2Z
   oBxvv2CtLvMIzakKxvSZLyHTdetuJ8j0dN/rpIB/Rc+cRCUa02vjgFGoi
   qJQNLmXJNbL3jS1DmyqzpCw2XLdhkfY68Q4MoKxlLvbkABEL/NWmkkPZK
   BDMgTUt0JgqR1ZRB/Mrj5TkoJjLodYYL5g9+So9wL8axMlN8njV9zekDP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4196234"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="4196234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 01:32:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="5039088"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2024 01:32:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 01:32:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 01:32:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 3 Feb 2024 01:32:51 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 3 Feb 2024 01:32:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJNGPtbhcZDb2Ub625Fp1Fg4zg881TsLRgx4h0Hx5k+4/dBr25bgR3Qehn22/gHzhk6Qd7qjkQ/Og0/nzDi7dJB5yzwS2d/9ZMJGJClTl9F2KHdewUoyzHOmqcxaqMrHwE4mlp3hPSt/vxENfXRDhat8tj/6mntqE+CAchAiuikXPyMQ8lNGitYEwChT8ZQdiumPsVXnJKj82Nxia748Oac9OTAwojz2Y8bNkgzM7ulFMESAkhOkri7u4CzLWxYp2A4giwuycygKImu6wHHY+H0FbLTt5rY83/IVX0ni1dN8SN89dWIMI90+aWTFa3Aq7nk3bBow5EM1Q/3MBiZdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+yeeGJT/XHYAKDWqMQs9B/vvy686WvPX4HYvCi6UW4=;
 b=RmnpAm3dWMbQzsnYAFOCl5Jyoni21DY9s/ihZmy/vOko5PqTOdmn/DV5gNrwmFHV+V6AgRVeCFiwasdni1sRk01qaHpnzLY2qODwS2FPPzoCuocwMQjLjpA/9LZL3UNas7pwNCfZtq9u7i9Hob8piTcf/MRlxRtnbNRmixFm72KF2OTRwKmJVv+gr5zesnP5P0Sk4htpW3aZTzokAm/a6iKukh5Kd4MHy/Ynv+hSHFKzT54B1sLnOvcWVS/Tc59ynS2z+ufT8cE/W8ApaYl2ah9k4d7F0NhYXbEFARdbTBpFZvpMyytQjV6xkLUtgWWYd7CswK1aQ26lthhLrt3NYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SN7PR11MB6656.namprd11.prod.outlook.com (2603:10b6:806:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Sat, 3 Feb
 2024 09:32:49 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 09:32:49 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Kunwu Chan <chentao@kylinos.cn>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Kunwu Chan <kunwu.chan@hotmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v3] igb: Fix string truncation warnings
 in igb_set_fw_version
Thread-Topic: [Intel-wired-lan] [PATCH v3] igb: Fix string truncation warnings
 in igb_set_fw_version
Thread-Index: AQHaR40BtTFSmqu9aUme+0gC8FyxF7D4dtzw
Date: Sat, 3 Feb 2024 09:32:49 +0000
Message-ID: <CYYPR11MB84290E3D62D157E0D00270A0BD412@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240115082825.28343-1-chentao@kylinos.cn>
In-Reply-To: <20240115082825.28343-1-chentao@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SN7PR11MB6656:EE_
x-ms-office365-filtering-correlation-id: 0f018aee-0831-4e9c-3f13-08dc249b1635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EpAMgIz+2LTDknMFG95XH5TbOS40VWmBPvJMKDOHujJCEFs1t8kP9fQ6NXPbBzdfo3J6pgzcTMNJ7f/SQKWw8ChJCzJWD6NVsOYTioDhKkeqgmhhvB0KXXy0EbErGbNEU+yXblBQmQw/ixhhgcnkM8vtqFw+BdpSeTjMh3Q+P2O6v0XBdObPYQUlbRYH0xbQKdbwKeFOtutVcauD+2ef0riqNLKCc6qCzypi8rVsrtGiracuDJraK+xvaSh+HM9XjjXp/EhVGAirRihrvrvGeNOxJX7DXYePxdYc7KZksVZyML6s98ktCuGRKbendeGIKRnP0MaxIncsLr3e8ey9nvXnRout6QviZt1xexirTJOqUgPevIwLIwkMcmoyalbpV8z7mtKpxxP4eHMEiblRHBi3XLsxQY5fSx+HlAXhnHYB2DyHrY3j6cOG/oF2e7iHi+RhkN8x/gcOj2iZ2cGb+3g3SBUl+L2D8pN8l1x7HrF14FfKQBVGLcRWc/7++pTMLn85KXmPToGEaYevO6kyCSadV5bsSdndjU9A3zYhaUVrnASQueEidpunAyUt3AoZGg2TegtruZiLwfQvwaFOjKJNuVSljYCszGoItxClOOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(55016003)(38070700009)(6506007)(38100700002)(9686003)(83380400001)(71200400001)(478600001)(107886003)(26005)(110136005)(7696005)(82960400001)(53546011)(122000001)(76116006)(64756008)(2906002)(8936002)(52536014)(66446008)(966005)(66476007)(66556008)(8676002)(5660300002)(4326008)(54906003)(316002)(86362001)(33656002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d25DcTFSdHI2c1JMcHcvcmRUMHdvQXpmcVZWT1hwYTZ2enZpby96ZC9PSUVX?=
 =?utf-8?B?N0hjWG9xWWFLekZERUY0UG5xWlZCVFRVWWpWY3BiMEwzUmZUb1RGSXEybGhM?=
 =?utf-8?B?eVg0aGpVUFJsWm9uN21VYkwvbmRPK09ZYU9ZSm1QcjV3ZTdkTG1nNFV6QUMv?=
 =?utf-8?B?R2twdndIZUN6a3JhWW9mU3dMMHJOL1JpVTA3bDNyOUs4UG9KRWFJRldsVThz?=
 =?utf-8?B?Nmxlbkk3Z3BTaFd3eElCYjlOdG9tOU9QQ3MrYkVwelAwUkpoR2d6VHdDRGZw?=
 =?utf-8?B?SHE3TGlnQVY0bVFucmhJY29QQjRkNUt4Qk02Y0JYWjNWaStSbXlRYnNHajJa?=
 =?utf-8?B?dkpUZ0Q1eWw1RlgrSkxTM1VzcGJxWDJOMzV6MGV4WFB2clhET25WcG9YKysr?=
 =?utf-8?B?Z21ManpYWk9YeEZLNDduaGhCRlBHbVJ4U1ZhalN0NDU4UFB0NWY0MXRjTFBi?=
 =?utf-8?B?S1BCMEd6Z2lTV2k5dVhLNlVrUGllOFFHN0g5WGRRcUZVdVN2UDVWY3pEUkpG?=
 =?utf-8?B?Yk5BcnFHTE5qdGFPalNKM1VRUEJlMW0vakcxbE8vWUxkamxLVWQvNTBBQzBi?=
 =?utf-8?B?RFl4YjRyWGphNFovVE55dUkyN2JDeCsrUGVoTVFXaVF2dzYrc2VWc0lYU0c3?=
 =?utf-8?B?UThsNnZPSHFRN2RXQTFkUTZRYlpDaWovaGVWc2JVWkxxYUhTSjVQeDlQK3pF?=
 =?utf-8?B?TlUzdEJjK1kyZk5GWERuRFc0d1Bkb0p1cjFEZWZ4em8xNm1rc0lCaW10V0NO?=
 =?utf-8?B?UmFxQ2wvcStkQnlNc0VFOUc5UmhlNG5GNEtidmkvMHlCdmhZSytBbEVWVDVE?=
 =?utf-8?B?QlNaWVpkUFFYVmFkSHRNTE5CZWNiV1RCTTRUY2dZM3Y4UDVxMUV4TXlDbzRZ?=
 =?utf-8?B?QitnQ1d2MC9JWGNNSWI3TlJHQkFDTG1Qa2d4Z3Vra0VRQ04vamZFQlF4MVBS?=
 =?utf-8?B?amlrUjZjTnJyUXZhSVZFdnN6aWpCUFI4OXJac0E5Sk9WZWNMUjZwQWJIVXl1?=
 =?utf-8?B?c1VtanBKTS9UamllQnRSRFVFZlFpekx5ZTU5aWcwQUlhT3N1a0cyUUR6UXJi?=
 =?utf-8?B?ODEvVUdWMG1LbkdtOGZlSXN6ZlhNZXp3Nll1SmNUR2xTYlMwa1gvV1plODZa?=
 =?utf-8?B?MWkrRzNlVks3TTRabGZKekxGaFpQZDc1b3lCZUFIVjRqaXFqL1JBM1g1U0Rp?=
 =?utf-8?B?cysyTEw4Rm9OWjE1VFBnL09SZWNEbXlCM3kwcVB0Witra0dEaUFBNStsVjMv?=
 =?utf-8?B?Mm5GVENTWWVsUmw2VFJpUmc0NWIrbXBHbUFpQVdiOElxY3BrZ0F4eG5XVWhT?=
 =?utf-8?B?eldTRVVHUTFjTkpGTWI1OW1JYTlRREptOG9sc1JXNWJVdFo4VjBjSktWbzhB?=
 =?utf-8?B?Nnl1dWNkMldST2o2V2RwK1ozVkVwbGhoeG5RUzkxN0hUNGRIVVpuUkgxb01p?=
 =?utf-8?B?dWV4bVVSSVlrb3ZnZnlQMllhUGE1OEo3bEthRWlwQkpqWnJkcExrY2ZOaDF1?=
 =?utf-8?B?eGpZTVp1aE0rOU1hYU5ZRlVtUnVkOW5odDBsYytqa3ZkZjgvR3FUMVNsRlNx?=
 =?utf-8?B?Mm9pN3ZWN2dIVXlMMEZYWTZuVkhBUTBENzdOWE9icUM1cmpKQWJlVjF0ZkQ3?=
 =?utf-8?B?RWZjcmtKQWQ4bHRHZS9WUkI2NTNHcVBuMU5zMGdYdHAwa3p3T0xkNGw2UldE?=
 =?utf-8?B?dk4wWGJOaThFMU5FemRBd215OStWZzAvb0NLNlVJWVZxMUprZERzbUp5dURm?=
 =?utf-8?B?SWQyWkJseFk4aU1sRnBIdW5LNkQ3clczTEVRMUVsQkRVeVpaVk83a29YMktE?=
 =?utf-8?B?YVQ1Tjc4NklqMXJUZHNQT0dxeGhRSEZ6QUVzMDBYeUttejVXaXdjNWZPSmNk?=
 =?utf-8?B?Mml0bUs1bnV0MlJnQXpHTjljdmp1MzJHOTNUdUgvczdMdE82ZVgzUjRIMy9I?=
 =?utf-8?B?M3BQZEtJVFZ6V2hLdnRFQmVUWnNQSEZyaFRpOHRqcnJBWkUxNHJJcm9KVi8x?=
 =?utf-8?B?ajc3VEd1eDhiSjNGNHU5dFpYTjZ0bUlMalRBSDZrM3FNRkpYV0RlcSsvbHdw?=
 =?utf-8?B?bXpZZERuZDJBZm9QRHhBdXYwZFJaTmlpZGVYajg5OGdBTyszSFJlS0VxeGxR?=
 =?utf-8?B?TW5rWENGUVlya1lWZjFyY2orY3JuSWxVcFo0Sm1vUkNObld5WStVVlp5R2hX?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f018aee-0831-4e9c-3f13-08dc249b1635
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 09:32:49.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6Ohty7x6u5rje2xTIRuAr47golv+4oLF5LLoMzSwj4BKJiRx/Sht9N3jMcCDyDbpr8aDmZ0ka3hILdLRtrEZvg5j0l+i26dGhk2IOnKixCmf8JML/wNAWrdpayc5ccD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6656
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBLdW53dSBDaGFu
DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCAxOjU4IFBNDQo+IFRvOiBCcmFuZGVi
dXJnLCBKZXNzZSA8amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkg
TCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tDQo+IENj
OiBLdW53dSBDaGFuIDxjaGVudGFvQGt5bGlub3MuY24+OyBLdW53dSBDaGFuIDxrdW53dS5jaGFu
QGhvdG1haWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGlu
dGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBs
aXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBLZWxsZXIsIEphY29iIEUg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIIHYzXSBpZ2I6IEZpeCBzdHJpbmcgdHJ1bmNhdGlvbiB3YXJuaW5ncyBpbiBpZ2Jfc2V0
X2Z3X3ZlcnNpb24NCj4NCj4gQ29tbWl0IDE5NzhkM2VhZDgyYyAoImludGVsOiBmaXggc3RyaW5n
IHRydW5jYXRpb24gd2FybmluZ3MiKQ0KPiBmaXhlcyAnLVdmb3JtYXQtdHJ1bmNhdGlvbj0nIHdh
cm5pbmdzIGluIGlnYl9tYWluLmMgYnkgdXNpbmcga2FzcHJpbnRmLg0KPg0KPiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkyOjUzOiB3YXJuaW5n77ya4oCYJWTi
gJkgZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgYmV0d2VlbiAxIGFu
ZCA1IGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSBiZXR3ZWVuIDEgYW5kIDEzIFstV2Zvcm1h
dC10cnVuY2F0aW9uPV0NCj4gIDMwOTIgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiJWQuJWQsIDB4JTA4eCwgJWQuJWQuJWQiLA0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefg0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkyOjM0OiBub3Rl77yaZGlyZWN0aXZlIGFyZ3Vt
ZW50IGluIHRoZSByYW5nZSBbMCwgNjU1MzVdDQo+ICAzMDkyIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIiVkLiVkLCAweCUwOHgsICVkLiVkLiVkIiwNCj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jOjMwOTI6MzQ6IG5vdGXv
vJpkaXJlY3RpdmUgYXJndW1lbnQgaW4gdGhlIHJhbmdlIFswLCA2NTUzNV0NCj4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmM6MzA5MDoyNTogbm90Ze+8muKAmHNucHJp
bnRm4oCZIG91dHB1dCBiZXR3ZWVuIDIzIGFuZCA0MyBieXRlcyBpbnRvIGEgZGVzdGluYXRpb24g
b2Ygc2l6ZSAzMg0KPg0KPiBrYXNwcmludGYoKSByZXR1cm5zIGEgcG9pbnRlciB0byBkeW5hbWlj
YWxseSBhbGxvY2F0ZWQgbWVtb3J5DQo+IHdoaWNoIGNhbiBiZSBOVUxMIHVwb24gZmFpbHVyZS4N
Cj4NCj4gRml4IHRoaXMgd2FybmluZyBieSB1c2luZyBhIGxhcmdlciBzcGFjZSBmb3IgYWRhcHRl
ci0+ZndfdmVyc2lvbiwNCj4gYW5kIHRoZW4gZmFsbCBiYWNrIGFuZCBjb250aW51ZSB0byB1c2Ug
c25wcmludGYuDQo+DQo+IEZpeGVzOiAxOTc4ZDNlYWQ4MmMgKCJpbnRlbDogZml4IHN0cmluZyB0
cnVuY2F0aW9uIHdhcm5pbmdzIikNCj4gU2lnbmVkLW9mZi1ieTogS3Vud3UgQ2hhbiA8Y2hlbnRh
b0BreWxpbm9zLmNuPg0KPiBDYzogS3Vud3UgQ2hhbiA8a3Vud3UuY2hhbkBob3RtYWlsLmNvbT4N
Cj4gU3VnZ2VzdGVkLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gdjI6IEZhbGwgYmFjayB0byB1c2Ugc25wcmludGYgYW5kIGEgbGFyZ2VyIHNwYWNlLGFzIHN1
Z2dlc3RlZCBieQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEyMTIxMzI2Mzcu
MWIwZmI4YWFAa2VybmVsLm9yZy8NCj4gdjM6IEFkZCBkZXRhaWxlZCB3YXJuaW5ncyB0byB0aGUg
Y29tbWl0IG1zZyAsbm8gZnVuY3Rpb25hbCBjaGFuZ2UNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2IvaWdiLmggICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYyB8IDM1ICsrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPg0K
DQpUZXN0ZWQtYnk6IFB1Y2hhIEhpbWFzZWtoYXIgUmVkZHkgPGhpbWFzZWtoYXJ4LnJlZGR5LnB1
Y2hhQGludGVsLmNvbT4gKEEgQ29udGluZ2VudCB3b3JrZXIgYXQgSW50ZWwpDQoNCg==

