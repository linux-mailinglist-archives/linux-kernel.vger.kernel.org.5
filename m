Return-Path: <linux-kernel+bounces-59936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962384FD91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EBDB241BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D731272B9;
	Fri,  9 Feb 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1C72iFa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20512E632;
	Fri,  9 Feb 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510516; cv=fail; b=GhNJmYUl7sElipoTMRep4MHXbFKosIhbcuua9xbn0JloQXRlauhKJBjJqh7Gc010Jz+VKXT3taytEF1TQj4HrZm8qQI1NoRGGkTuZ+MR+8JdCCBiqBkvJDsiI1teHA16SypShLk9bYAjvZKZydjghKkrkjwW6vi/T8hT6lzl+4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510516; c=relaxed/simple;
	bh=HeULog0HrUMb2W1kCSZEv7rM7uemu6fhAnvMrAuqw9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R8Hf7t6L4xouhrVlqvXR3OYk03+38MmlQ96cl/3C7BsSec6KhGD1TNKJCBg72AXUxIYpe3hPrQo6JLAsr8oX++bLoKwCzgl8Plmp3YVLcDUYEYbeaf1GwPgOeDs39676/ecZ5M6PKINufr8eXx7YQSDHdHeTvkEr1kBPKiEQA+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1C72iFa; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707510514; x=1739046514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HeULog0HrUMb2W1kCSZEv7rM7uemu6fhAnvMrAuqw9U=;
  b=B1C72iFa/CyxanFEwfLOKTkmVSUdz0rko9Yaw5Yh7BSq4JtOFi/kiYd6
   J0dphLDPleJ36XoASd/QJVRATZ4IgbIgLCEUa49JrabxU1JYhARedXVKS
   QuKu1Fu8wpJFZdYD73BLLVBFFDsCQ4UOsOiGa6gqnJmkcsVkPWKr9rhdd
   BhrdhOGjVPmY+MlESGmmIknKgmukFXAsJAnQmyA/KH3+ZFN4dJpbqCwa2
   /O9eNNWDfTiTWw1dO4kT2S1qhfbGdz7BVEyV9W5gMcWQf3WI4j/ff3OYr
   xV50Q1xH0p5lJ92/kHoLtmKpk5SaLbtDbgN+qoKqFLKnWb/l5+5OEzUlA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4475209"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4475209"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934519412"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934519412"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:28:33 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:28:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:28:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KunoTi0gcwsoLiufbUn99+0s30elkvYL37RLSSJd0QdIZ6EqX5Evt/vLmNU9isgkfGAJHwhICSrv8oQWhOGu32OmX6jTNX/9DrIdYTKDGjOfNhBKbaLUacnH4Er4hc07V8bwBf+tUpNqUkQdJwwAW48u9QTtrM5oBoL/ECFpeQxQu5DpSfnrMw/SL+u30ljGKpegEpO6xc5YJAX3Vd43uXy7aUdTrR7TPM2BqlbUYT9E6QnvfTtkB0UAyZkLYAXl34qWDHuZkMgngGuytmQMTfIpUlSGbmDLuzV3DF0b71HmpJuxCd+vjcIDlz3RBH0IU5oByzQ1zYnbRM+pbQGp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeULog0HrUMb2W1kCSZEv7rM7uemu6fhAnvMrAuqw9U=;
 b=SgMhqp7cpIvZzK+wFIwqsgQg+DK+iiiG9Y+0wdB9ElR5F5YZyai/S2eruc4oLBym9kIQphZMa7qn6vT1CFyzmQ5+6q1J+sCRqLD7ocKOvST1Cm+rkjfzMuoF6SJek6k/jKLDjmS6QanqFcA4qe1X11kjeDqbeT0wnHNUsfbcHrK5w20vsNmZMZOyTdfmZcDrAWPvofTHoa2IV8q+i/8DdGpxgqSWdu2jX2NVKUQXx0nGfr993JmiKLnzcrNRw/67HpqjdTs7K0zLCj50iDJzljIJgsopIKyyecvbYalbbjGjtUWzmgAwCbkdPNPh/Cd8wlQg3Q8i1t8TPEIKB9B6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 20:28:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 20:28:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Naik, Avadhut"
	<avadnaik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAO8gIAAApXg
Date: Fri, 9 Feb 2024 20:28:29 +0000
Message-ID: <SJ1PR11MB6083D8390032B7072443F83CFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <ad674def-f129-4470-b07d-b1ed809da4eb@intel.com>
In-Reply-To: <ad674def-f129-4470-b07d-b1ed809da4eb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5790:EE_
x-ms-office365-filtering-correlation-id: 46da2c99-9c1e-4f1c-3b4b-08dc29adad9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZxp4eG7a3wG31OiD31rrq8Y1KOt1DS2JDlzQ8CuHdvGj+p5kLGzjiSSyH+86+M+FBRQaWF4GS6dXKEEqhMRCyQWyVGeAqttw28xskVEWW4Rvi9Wl2P9O6PIC6LyBPt0txhGOt2kBdl5v4m6u2Y+9lv9dbzQGaQZUj/kqwFYitar4HyG8WovmPfycXZVuYe5XNuyZbT24kyYcl/yyIpL4spapWI/cKHSQ+uf7T3KESkzFTh/imp/Ioex0c0VT/3ce39Wmp91cQ83qCqcZZ6vMZrP2cADup96mwJGtEL8YH395VmKTWYc5L/jWaWEuyVdI7xjz4QzBSnGnKYS6bh6cr7ihLE/e4o+WWCROWtJ/8EBYZyCzdZnyyLsm09lMSHV2RtEwT6LIn87reGXDDpHSZpxufbOaD2bRhYu0WgHoZVUrpJlbvxePBK9jpQn5++3mWaElg6W5WORIAE8PD2/HXzRyPZNFBLVVwv0QVP7XAVJnYkEAR6BdlhOhCDyaiWbH4SZCQ8irrO2zz6M7pwzS/HRGZgLUW77b4WDiR14LyocNKf+2htEq9j7yRo90WE1hCeEZ0SAcH16wTHHyDapkkOw9uJpfj9Mky30vXqxrKTKN7TqllFzokY/o7UnK6KC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(52536014)(5660300002)(4744005)(76116006)(8676002)(4326008)(66446008)(64756008)(8936002)(66556008)(66476007)(66946007)(2906002)(26005)(38070700009)(38100700002)(122000001)(82960400001)(33656002)(86362001)(54906003)(110136005)(316002)(71200400001)(478600001)(9686003)(7696005)(41300700001)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUs4Z1JmTFh5b09XRkcwYWZETUIwaFlGajZVczhhT3llN0Q0emR4T1Q5dzBW?=
 =?utf-8?B?YXRkckJ3S1NqT2pvOWwvL1dYNjFXSDdoSi9JZHVtTTlIRTBPeDB0cGhKdW5X?=
 =?utf-8?B?bjRPVVVoTWtIWExlMWxtK2ZVV3lNOC9Ialp3ZUhNYmdPbmRyYlI0VDZjQmdK?=
 =?utf-8?B?RmRwUkd3Z2ZFcG5NelIzWWc4STRpeHZTVHRBazRvSjVaSXRCcWVSV1ViZm1K?=
 =?utf-8?B?Zm5BT3VZeTljdTZRQ1NidE9CcHZoVDJEekZFRGZ5dXhKelJvbmlsRGVadTRw?=
 =?utf-8?B?a2pFS3gzcU81OU10N2FLOVJ2M0EyeXBnbVhjb0NrRHVzRm9oZzY2M1F1V2pM?=
 =?utf-8?B?eVh4ak5lTXMvYzJSWC9DcWRibzZsTmQzcGplNTk4OVUyR2FEM2JCSUd0OHQ2?=
 =?utf-8?B?bnd0TjMxNVZkcFFhOHBXejYrS3BubkJ3NXBxR0dlTTdoS3ZuZ1Y1azd1Y3Y5?=
 =?utf-8?B?SXZ4cm5hV0xxNDVQYTB5d3V3ZTBnc3VnWXBTR21ScVoxb0I5ZkR4c0NRNTVZ?=
 =?utf-8?B?b0M0OEVHdDhkc1ZSU3U0aDFsdEEzckl1cFM1SVlUaStyby9uR2VDa2tuYmtK?=
 =?utf-8?B?eTI2MEZJQkw0VVczRUVwdjRQYW5weWhqdm1WQVo2WEZLQlhVM2ZoTGJGSW5S?=
 =?utf-8?B?ZVYyOUFpWHlGZGZFVWlTS1VkSThjbnR6dEFUaERLTDFySDRiL0hmY29hcVEw?=
 =?utf-8?B?YWxUWGJGRGRTdkZHMVU2emIrbzlEZkRRb2JLZG5qcXZFYjJsTjBRQW5CZVRU?=
 =?utf-8?B?SVJNN09kQWlNbHJtUzJaK2J0b2ZJc1JRcmU4VTJhUk92cEsxYlVvejJncXpq?=
 =?utf-8?B?aFN2WEF5ZWxOVC9QNWVFL29Xcm1veWRvUmdRa3d6ZWtKcUpOM3lJY3FyWWF0?=
 =?utf-8?B?ckVudGlXZmlPZ1d5QXBJQjRxTWNReWlxUHpHdE11QkdMbFg0Z1hQNElLVjJj?=
 =?utf-8?B?NkNVd1BsQlBuaVpRTnFwOE9WUzNCTXJMZk1TQTZZcHdCeXJYV3JOOFVkL2Jl?=
 =?utf-8?B?eUg5RndCWEJKNFlWVFFPd3Vkdi9udUZRRlNrdmNla21oR0pLNEtPc1dTMWpj?=
 =?utf-8?B?aDFIaTVKRVF6RG92TEZLTXB3bUtKdlRwTURmcHVYOHNxcnVaUTVmYy85ZWFF?=
 =?utf-8?B?bDZLZE54MXhFR3VtTzVURWpoUklNd2NqZ1k5YmlUZ0ZiZW1ncks0Ni9XbUts?=
 =?utf-8?B?Mk1OeVhlWVQwUmo1QmcweWVtaUFGalNaT09nNXBlWkJocmVCVFViOWg1STc0?=
 =?utf-8?B?cUpORFREcm5ZMk9Rc3NiM1RQRVRIYlNWLzZZVGtvMnF4UkdFV3FPTlA0ZzFh?=
 =?utf-8?B?VTJzOUFlVVhjcjRTelZ1S1JZVGlRYXdZa1kyczQ4QjhjMHZXOXBzWmxQUklO?=
 =?utf-8?B?VEE4bXR0SmZCUnhKRWh3TDhuNUorZmxZZDVkeHE2OTBMcU5XUU5qTnNCYnFS?=
 =?utf-8?B?SVJRenBHY0xldmVPODJKZjRkSXZsbUFVczUwNnlVbmx5UmJqL0xOZlYrRW9F?=
 =?utf-8?B?Qi9PZS9hVVhGN251NG10MW9zTERRbVgra3VUMklwTlVQcTFxdlIvOWRqcEkx?=
 =?utf-8?B?d2hYZlR1TUY3b3dlYmlvYURSeklacDVFd0tGSVIvaExwQ3c3T1dnK0pXWHlH?=
 =?utf-8?B?M3kvQllmWE40QUEwNFdISVFVanIvcEFJbURlUVQ4cVBTUjVtcWczRDFLalRW?=
 =?utf-8?B?UndvRHZNNlBxUXRzNWoyaGNsWVRHTzFpV0VHeU5xMHY5K1EyS0RLR0pFV0tu?=
 =?utf-8?B?VHBZRTNRVjR4WGpzZEFmZkIrUzFUaFdmL3VHek1oaXNWQjJCTkFqczRweHlv?=
 =?utf-8?B?YnNmelFIQ3k1d1prUU5TQ2ZGZnExbnZoY3JiL2V0SncvdUFOLzJxUWc3aTRx?=
 =?utf-8?B?V0dDeklEWXBCNE9YOU5qWmpsVjdyNzg3LzBnSTdFRFVLQlRldUNucjJlMXRR?=
 =?utf-8?B?VjhtOWNMVFFSNWRnb0NzeC93MFE2WXZnY1JIbGNCN0FXOCtNRWFlTFduL3Ro?=
 =?utf-8?B?c3FURk1GdHhQUWx6RTRPbnNvMklOaE1VM3d1bEJiNmJYWW1nMEFENGVrNHBE?=
 =?utf-8?B?YWNNZVVZWFJMMVVEd1liNUFENU5iRUJDMjNYS1ZYTkw2aEROQWltZ1c5RHZW?=
 =?utf-8?Q?LV1NJmQI9Voa0qvTJvbLw5bNJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46da2c99-9c1e-4f1c-3b4b-08dc29adad9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:28:29.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKLHNIbPKCqbuk03ztM+9TW5gcy87FdfMeSoyjqjMJZJE2W4Ey0qedEmzLRp9xmmFrw+f6pZGFQXNf9BUThSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5790
X-OriginatorOrg: intel.com

PiBIb3cgYWJvdXQgYmVpbmcgbW9yZSBjb25zZXJ2YXRpdmUgd2l0aCB0aGUgYWxsb2NhdGlvbnMg
aW4gdGhlIHByZXZpb3VzDQo+IHBhdGNoIHNvIHRoYXQgd2UgZG9uJ3QgbmVlZCB0byBpbnRyb2R1
Y2UgdGhpcyBhZGRpdGlvbmFsIG1lY2hhbmlzbSByaWdodA0KPiBub3c/IExhdGVyLCBpZiB0aGVy
ZSBpcyByZWFsbHkgYSBuZWVkIGZvciBzb21lIHNwZWNpZmljIHVzYWdlLCB0aGUgcGF0Y2gNCj4g
Y2FuIGJlIHJlLXN1Ym1pdHRlZCB0aGVuIHdpdGggdGhlIHN1cHBvcnRpbmcgZGF0YS4NCg0KVGhl
cmUgdXNlZCB0byBiZSBhIHJ1bGUtb2YtdGh1bWIgd2hlbiBjb25maWd1cmluZyBzeXN0ZW1zIHRv
IGhhdmUgYXQgbGVhc3QNCm9uZSBHQnl0ZSBvZiBtZW1vcnkgcGVyIENQVS4gQW55b25lIGZvbGxv
d2luZyB0aGF0IHJ1bGUgc2hvdWxkbid0IGJlDQp3b3JyaWVkIGFib3V0IHN1Yi1raWxvYnl0ZSBh
bGxvY2F0aW9ucyBwZXIgQ1BVLg0KDQotVG9ueQ0K

