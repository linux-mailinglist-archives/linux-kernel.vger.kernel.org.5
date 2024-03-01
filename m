Return-Path: <linux-kernel+bounces-89151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC786EB29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DE11F2330C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA75B58222;
	Fri,  1 Mar 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9ZK6Lb+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887863D3BA;
	Fri,  1 Mar 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328744; cv=fail; b=OIm+D676H+w258L7UpEMTKPnS5SI5VVEemE1dxp+oLSk3qf0Wq20PPX+RhN+/aCaBnXuDy4GQ1GlYi9kJz1qXh5OeF+IM8nSOXoVzIcOH4DM2VXyuYhAN8LB4BgDmOFwpMqJqd/QsGnpCM7317UF0eWypucuGwRDiJR8hI035Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328744; c=relaxed/simple;
	bh=eRa+eOy2JWJybn4pelBWlanuOuxZACRmS9HngFJ7+yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6yCbHzjXejMf5TZS3X3lq+VJL/T294FNeiSxzxNUlUh6jLC9PgnvqlLXpMrO02wApxI3WiIJR6AEFSlSQPBRGCFoa8lHYTD2Bhme3U1K0fvcT7PpMAAxsWFT1l3FdFIUh3bJ8v/gyl9ULw0Xlaa6DAPZMOqaEiCskgb0bpa8+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9ZK6Lb+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709328742; x=1740864742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eRa+eOy2JWJybn4pelBWlanuOuxZACRmS9HngFJ7+yk=;
  b=S9ZK6Lb+Vz+hyfeExT/UkfF6qV7cF7VtLG6vcrIkFvX1Nn4cMSfGvGeY
   ubVtrXQtA4viaLIXRbwTwl7ipGKR6SELRu5cWDjLRVEjG0Fvx0F2gc5KU
   xMZBpWatd8P2XfFnBIJeg0kMAVf0H/m2dScUHpGz0OGWou8KCUxsam+1a
   1ESfnFA9WS2kPN1lKrpN4DYoYEcN7QNvg0KQ4f8vGu/cgjjN4TwNC+jvr
   LfufkCMeceSdr4LO8hr4URJ444AlEx9083Y0emSR294tnT/T69kkcgFca
   rIqlUlHUeFWpvQV0SoOkuFNAJgggdSe/o3XJ3Ga/4+YlneUiTPc04SWDY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3750864"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3750864"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 13:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="12887414"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 13:32:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 13:32:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 13:32:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 13:32:20 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 13:32:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWhnhh2duUbn//Fqzq9oapGx5BI2yPe+pDkHg5kfAnKXgcdLpEmamYIZ7o9CvNICYjIKjZWHo2BtJWYdNrhJkJl3x6LFgEILa4KYYZINVRyZTTSl+ZzIDDaF+JMX+keqB6+U4anWj49QaVMVKvxtUWKFfuPElviPvdf2UuAuBnvItLkushR17iuk33Zvmbvevyeyxtji1Iji6/m2/q671J+jSY7yBlzBA+Dpz/cj1DuCnFgX6eQkioCKG3xQJyxd3nhl01zJqaW/ZExlHRNM6GSKsG2586E2lXUC7NyPaqidK2ELldXNZIE6jL59/047DrnAUY0a+I1ONelOTrOuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRa+eOy2JWJybn4pelBWlanuOuxZACRmS9HngFJ7+yk=;
 b=PWteUMIVB4Q35Ul9PdE6WNMncqgQFItdncInm7HO9WfVQPEbOJNf4HQU9soaep7TXG1EK10hMeNzsRxkFxfh4il9KLVjisNZhM3/c7mxOCx1QxjBaQUwzlhSqID9kVNLnSVcn4oQ3xhRoF6U2AbzDqzjVoPsWyKO0rPaRy8vxnlbelpw4S28xqttRN2VmuO2LQhXqrZE+6T7ejbqa6XU5YDMlioBbuync6kE8t9p3Y+aa3ucv49qW3wH7VMBzQr7kv+JADMbucP8nmUxLij/8+XfUEZYIpuksDJEnXyyjgEbBdRR8l2zaA1Kzye9GNueqx+T5Hx8d96gkHKf/M35ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.17; Fri, 1 Mar
 2024 21:32:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7362.010; Fri, 1 Mar 2024
 21:32:16 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Roger Quadros <rogerq@kernel.org>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
Thread-Topic: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
Thread-Index: AQHaX//LPoew9v24LEywSSsZfjSfdLENBvCAgBXFEQCAALPLEA==
Date: Fri, 1 Mar 2024 21:32:16 +0000
Message-ID: <CO1PR11MB5089BB1C2C43E1616FAE3342D65E2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <20240215110953.3225099-2-c-vankar@ti.com>
 <3e81297c-2821-4af4-b13d-dc33ae8f85cc@intel.com>
 <ef948e8e-b1ae-476f-b07f-4bda6d33c51b@ti.com>
In-Reply-To: <ef948e8e-b1ae-476f-b07f-4bda6d33c51b@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB6429:EE_
x-ms-office365-filtering-correlation-id: e214403b-265e-43c9-cf23-08dc3a371105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iy8GironxCuvm3/1fffhrFGcZ6zc1wN61cTyVFEYa8BGrgvctG3zUz2aAt+D50awCxqjKGauhOo/GOqre1ZX+pdNU7ijIs6Ca+/dYyX1anzu/CmZY4u4hu8L5ZmcBr6edWcZcBCQscKktM2sLNwMuauoyOxfyJU7AxZop/Z0KJl7OG4DGYsAhTOfi2uUI3XeNeY7N3HijBt3WaNDdWtHpoy1KyrqwVfQR3T3DPpmXMN9Gchn5Er4L1kd2iwiV13TQWUBYpV5bGz/oAsbUWsT2vztl8PTOv9ifz2mCX3St8LFjWMvVrqAzSvJFLABCkuywle6dBd7dy0XLdiyhlC+Kkw6F7kfZMy78+s8HcSWXRXH7RrFBrVWMk9N0087wZusa/FMUfVPrFzprqSlKM1GldP8HzV7BW9X+6BFl07+9NxXvy0MIowJQmyailudo/ZYViWmSX+QukIDlPocqEgSmYK0Z+wEK+LsjnxUcq1uxxpLuO+kw4ADxE9FsT6d/n7CI9KLnYwuLbnC+JpB9EK8aiTh8qIVSICD5gAE0LseSq0xPcQvzjwf/JhJj8eRHuLcCJO6uwELc3LreLAdkgpNTJ1UrH5+BdzImHEpIaLjLiKcGCyLOny6ItJK6NpyCMeNj4EZPNs/+71FmJaMDFQFCxTlLUDrw8Td1XY2zbYZWYPqu+5TK0ugeN6jJyUzT2N/DG7Y1C7jKM+nWY2/uV/va6VfX/jk4UfNQNbXizLfz28=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1NiZmtzZ0N6dFNyemk4dlVjNElXUHo5Zi9zYjZIdmFKVkMwTTdoZldOd2xT?=
 =?utf-8?B?Vnp2enBDZUlGMGFCcWtrL1ZJZ3h2ZmtocjVaKzZsMUgyNHYxdWVzbXlzUC8x?=
 =?utf-8?B?YUlnQXg5bHdlOWFKS2tXck9zNC8wakRhQ0crM2djcjhwdWQxb2toSWRnbGc3?=
 =?utf-8?B?SjM0cXBjenRlS3F1V0pCV0lvYVdQMTZma29FTmhYcDhrWVhUWWhQd29sYTYv?=
 =?utf-8?B?TGRHN2RySXU1TnFqU1VqNHluOUxSR2hvK3JDQVA5SzBieFZNMTdzdDY0STZy?=
 =?utf-8?B?ekp0dFkrM3pScVc5R1Nyak9va2NQTUo3ZG9hMmw5Z1p3MkphV2E4TGV3dUZJ?=
 =?utf-8?B?TVNUY2p6SzdtQm0wbTRiS04rcWV5T3F3cDIwR0E5TlRIWWV3TjBFZ1JqVk9V?=
 =?utf-8?B?UXZZNVlVNW9SZmh4VXFndFVCVW1ySmthRnVnaFNUU3hLYktEdnRQeEEwSXMy?=
 =?utf-8?B?VlBVdk9sTUU1ZW5mSlUra3FuZmlManlqMzc4WXg0MkJOK3ZiYS9Ib0VJWUJ5?=
 =?utf-8?B?Ylp3NS9QMDlzOG1WZjZ2Rmcvak5ERDRkRUpWNktwMm8xSGYrT0RVT2lxYmxu?=
 =?utf-8?B?RW5BSGxwRVgwRklqWXZtbGpRSUZIYW0yeW5iaWt0R0JOWE5JL2d5NEVwK0ZJ?=
 =?utf-8?B?ckFieEF3MDZVOS9tOHBSMm9kT1VMdVdteXNCSTluK2Jud2xTL2RJbUllZDNu?=
 =?utf-8?B?SVlQSWJ5YTBSQlFEeThzd2JsVUxqWEg4OEtEUzJGa2o5bzU0eUd6ZmorS0gw?=
 =?utf-8?B?ck15WTUwQXNWaysrQWpGWERJcCtmaU5pSlpmWnhiSlNMOXhERHkxa1Rud2d0?=
 =?utf-8?B?eG5Wb3FiMXl6eG43cER3bWFTbFVPdVdBaW1DbGtZOEtGVVg0RmY5WGV1VTNG?=
 =?utf-8?B?UGQrcmlxSzZJWDJ5bHRQemJseDVnMEV2eXo1QXVSZXAzQ2x6a2lnd25DMHVW?=
 =?utf-8?B?RjVnK3RRaW9QNFUxTmRHUlN6QlJzemxkRlZqaGpjVTNsUlJMeDJRNS9GVWhr?=
 =?utf-8?B?c0JOenZFMDgvUWdVOWFlQ2RGNTd3bGZHWjR1bTRINEo3ZHJoS1JMVk1iRERZ?=
 =?utf-8?B?amVOeFVLQks1dDBGcS9ZZ01KQ1NhNXU3TkZvcEJmYytscFNuWDFvODJxL1l2?=
 =?utf-8?B?WUdQQTR2NHpxRTdyUFp3dWxTMGNTU3dQWHh3Z0xKNC9OaGt1WWMvdURscmtY?=
 =?utf-8?B?ZWh4dG5Wa0I0bnJvK2hBUnpjbzBtSEMxajdVdmpYVDFjNE5hRDB4ZTlwL1pV?=
 =?utf-8?B?ZmFTRHMrWG1kN3doQS9lVUtHU1pQRHV5UzZocmRnbExkN0pQdCs5aytzb3hK?=
 =?utf-8?B?SHBMTllqTDhuVzgrd0QrcVk3bG1qREcxbzNBK3lwT3lIWnNhOFErYnk2UWdi?=
 =?utf-8?B?TGVWU1JBeEVkNXpKYnVXUkJ5NUd3QmRyWnBXOUkvM09keVo5NktvZGk0Tktp?=
 =?utf-8?B?UGNQQmFtK3hlWkppNTdYSVVJRkgwbzlQTEx0L0pndll1S3VQZ0pQaHh1WnpM?=
 =?utf-8?B?RWdPSmwvaVVUTkJKQm5ySk5VTnVzWjFUSzc0RkNYUjdXZEExVzdocnYyT1ls?=
 =?utf-8?B?VkN1Nk02STlxeG8zQzI2KzhLTlJrOFFjQ1l4SEhIcmNodnl1TGkrakEzTklD?=
 =?utf-8?B?YzhEUFA1VUplRGRaUFIzd2NOQVYrK0R2d0JEeExrdlhkYUV1YzhWREI3VTVW?=
 =?utf-8?B?bFl4QmJqanhtcHJ1UzYvVE41NkROZHh6bGFET3liUzdkQmEzZ1hMeDlFOUpB?=
 =?utf-8?B?MGFaTjZBMFNRMlVvN25PblB2QjdnS0c0Q1dPMG43d1JPeGhKZnNmWTJzZ1JC?=
 =?utf-8?B?REQwK0lSampKVFZLWFM0NjhqTXZjTVBJb1NQNDUxQzFZMzZrOUJ6Z1V2c1Vp?=
 =?utf-8?B?Smp6Vms2d3NQWVhZdThDUU9MMDBNV0pFSFJqMU5LbHZWdlJ0czdyVTlFRTNK?=
 =?utf-8?B?eTh1TmRNR0EwcUVRRmxPYWo5eHZwU3ZlSTNDcjdBSFVyc1djOEpIVEdPZitz?=
 =?utf-8?B?T0JhdHltMGozYkNmODREV2ZobU8wazBVZU5zNDdQbXpZelRFN0VnbEtXcTBQ?=
 =?utf-8?B?QUFOOHZPcFdCajVsdERtVXBlNE9DeW4wVzgxRVpsR25Ubm41RUZYS0s5WXJo?=
 =?utf-8?Q?BvyaxTjhnL33vrFDSkyOcPtbS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e214403b-265e-43c9-cf23-08dc3a371105
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 21:32:16.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpvx5ZKXXsHWbSOQE24FiM3RX8oTCZVf72ZyY19PHZLuhkDzduHV0q5Bi9zsFD0nq1aELCw6srN/5MyXA0lkjRXjJIwolLcfnj7eZFvyviI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hpbnRhbiBWYW5rYXIg
PGMtdmFua2FyQHRpLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxLCAyMDI0IDI6NDkgQU0N
Cj4gVG86IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgRGFuIENh
cnBlbnRlcg0KPiA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPjsgUm9nZXIgUXVhZHJvcyA8cm9n
ZXJxQGtlcm5lbC5vcmc+OyBTaWRkaGFydGgNCj4gVmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5j
b20+OyBSaWNoYXJkIENvY2hyYW4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47DQo+IFBhb2xv
IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBEYXZpZCBTLiBNaWxs
ZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5l
eHQgMi8yXSBuZXQ6IGV0aGVybmV0OiB0aTogYW02NS1jcHN3OiBFbmFibGUgUlggSFcNCj4gdGlt
ZXN0YW1wIG9ubHkgZm9yIFBUUCBwYWNrZXRzDQo+IA0KPiANCj4gDQo+IE9uIDE3LzAyLzI0IDAz
OjUxLCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDIvMTUvMjAyNCAzOjA5
IEFNLCBDaGludGFuIFZhbmthciB3cm90ZToNCj4gPj4gVGhlIENQU1cgcGVyaXBoZXJhbHMgb24g
SjdBSFAsIEo3VkNMLCBKN0FFUCwgSjdFUywgQU02NCBTb0NzIGhhdmUNCj4gPj4gYW4gZXJyYXRh
IGkyNDAxICJDUFNXOiBIb3N0IFRpbWVzdGFtcHMgQ2F1c2UgQ1BTVyBQb3J0IHRvIExvY2sgdXAi
Lg0KPiA+Pg0KPiA+DQo+ID4gV2hhdCdzIGRpZmZlcmVudCBhYm91dCB0aW1lc3RhbXBpbmcgb25s
eSBQVFAgcGFja2V0cyB0aGF0IHByZXZlbnRzIHRoaXMNCj4gPiBwb3J0IGxvY2sgdXA/DQo+IA0K
PiBUaGUgZGlmZmVyZW5jZSBpcyB0aGUgd2F5IHdlIGFyZSB0aW1lc3RhbXBpbmcgdGhlIHBhY2tl
dHMuIEluc3RlYWQgb2YNCj4gZ2V0dGluZyB0aGUgdGltZXN0YW1wIGZyb20gQ1BUUyBtb2R1bGUs
IHdlIGFyZSBnZXR0aW5nIHRoZSB0aW1lc3RhbXANCj4gZnJvbSBDUFRTIEV2ZW50IEZJRk8uDQo+
IA0KPiBJbiB0aGUgY3VycmVudCBtZWNoYW5pc20gb2YgdGltZXN0YW1waW5nLCBhbTY1LWNwc3ct
bnVzcyBkcml2ZXINCj4gdGltZXN0YW1wcyBhbGwgcmVjZWl2ZWQgcGFja2V0cyBieSBzZXR0aW5n
IHRoZSBUU1RBTVBfRU4gYml0IGluDQo+IENQVFNfQ09OVFJPTCByZWdpc3Rlciwgd2hpY2ggZGly
ZWN0cyB0aGUgQ1BUUyBtb2R1bGUgdG8gdGltZXN0YW1wIGFsbA0KPiByZWNlaXZlZCBwYWNrZXRz
LCBmb2xsb3dlZCBieSBwYXNzaW5nIHRpbWVzdGFtcCB2aWEgRE1BIGRlc2NyaXB0b3JzLg0KPiBU
aGlzIG1lY2hhbmlzbSB3YXMgcmVzcG9uc2libGUgZm9yIHRoZSBDUFNXIHBvcnQgdG8gbG9jayB1
cCBpbiBjZXJ0YWluDQo+IGNvbmRpdGlvbi4gV2UgYXJlIHByZXZlbnRpbmcgcG9ydCBsb2NrIHVw
IGJ5IGRpc2FibGluZyBUU1RBTVBfRU4gYml0IGluDQo+IENQVFNfQ09OVFJPTCByZWdpc3Rlci4N
Cj4gDQo+IFRoZSBtZWNoYW5pc20gd2UgYXJlIGZvbGxvd2luZyBpbiB0aGlzIHBhdGNoLCB1dGls
aXplcyB0aGUgQ1BUUyBFdmVudA0KPiBGSUZPIHRoYXQgcmVjb3JkcyB0aW1lc3RhbXBzIGNvcnJl
c3BvbmRpbmcgdG8gY2VydGFpbiBldmVudHMsIHdpdGggb25lDQo+IHN1Y2ggZXZlbnQgYmVpbmcg
dGhlIHJlY2VwdGlvbiBvZiBhbiBFdGhlcm5ldCBwYWNrZXQgd2l0aCBFdGhlclR5cGUNCj4gZmll
bGQgc2V0IHRvIFBUUC4NCg0KT2sgdGhhdCBleHBsYWlucyBpdC4gVGhhbmtzIQ0KDQpSZWdhcmRz
LA0KSmFrZQ0K

