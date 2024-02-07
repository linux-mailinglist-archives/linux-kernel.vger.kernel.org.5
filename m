Return-Path: <linux-kernel+bounces-56112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BC84C60F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB7A1F25347
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277C200C9;
	Wed,  7 Feb 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0P71nVd"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF4200BD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293691; cv=fail; b=mgpxVphNBCHd6ICAeNKPT+vxLXdS4JNiaQLqWyJVnARy9PpcAm2W4vVOb0KchLMKlkiGjvhn2Gv4VpXJ96ArOr9MiEpIAdVBA+nFNofK/WPMLG5i9UrT2upOgT9lW9UOXFi5pybnF4yB6pg0MuGuyxuBEenD85jehLpzexo8ejk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293691; c=relaxed/simple;
	bh=dA7DJKiKgi9j6wNF8qNvvRALT5KK1jlaClOdFDR5NXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQeqEk5I1LqNuj6DhC+FmxCumi0aHXNRDzLvkKrDzpIp1WSCpcRWIekU4qt96Fn6G5pv6Wf7nkq3mpo3OW0Yjl42zEUHc5DEpbllbF50T4GW1qTfc/6e/ksr7rmU2d+kdObM61L9FupRI9ulM4oKdJFdWvX25daOgxt11rttor4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0P71nVd; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707293689; x=1738829689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dA7DJKiKgi9j6wNF8qNvvRALT5KK1jlaClOdFDR5NXg=;
  b=Q0P71nVdzGGKqj4T/uBTJVF7IopAJAXYgrS8F4iRI4MCYmSTDxk9apR8
   FMQpKV6za2RIgHJuoFUJT2Ws3ySmI1pbDKF2sTBNQxSS3vqeq7StVa/Xw
   B96ItCScQo/nEf/Cw8r8aYKD1+bcOHqE/thm7stOHdCPXEEeLNjutgD70
   /71hgQJqfzyahT6ML02VKBq26ek5SEkGZbGP37ZdEsq2nffoRLI29uKde
   n9AkRnYRMDDg6eg5q/MNxq+fTKsEIMkZhAovFTpkRUSKXpmDQOSJVz6b3
   JR0soNibg9rPB1cDd9TyLa5FS9D4V4sASOWa15EuZdFjpnO6T/lnbEX1V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="395352449"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="395352449"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1255200"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 00:14:48 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 00:14:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 00:14:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 00:14:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVvkShh2WemXmg2wAJHXY8h/e7MalG3MQU5NAW/QyKh22Txx0Q1XfaAMdreMxz9S9x561r9JupTJjbdOT09uAzPMlo/ztzvRRf+nJttYYpccmKM+RUAsD3Q/I61PXfjgUSnEgVF1f+UxvnHBuj12pN0xIAXCNAKhULimzNhrI5SpLMg7A5YHkucAYuA7OJQezCmG2QhLszz+ssix12fKbKKW1wBACCXybAXC8ZSpD1I7mcrO7QV6F66nYyP2RC5V9gkJjQbYzFMxMNdaaVvW6awq36VJn3vrqT0iy2g8aePxx8yDJGR9cckp+lcy1eFa+K8AcIpJea4YQYnq9gGZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWZNwVTIiLhZvEpDSIWRH5OFXYkFf37qRkDWU9+vpqk=;
 b=Iy7EiFyXPJfLKS19M32gx68K4Bh3t8m3lvvx5MdxEljeeIp0KN5SMIuvebVGAJOal1aDR2uM4Mtp2roLmUdMjw+ETTRU7fvbQBO6R7Ydras2tw4LLDSvZkYYlxgjLGGFjeofgzqfz9pibD1LdZ39B8ReU3TAfdl5x2oMkLoXbD+8qY+bcBX0mhkERXO5STHEq8l1u1qR4KIpWT4f13mPOH9nTx/Sy8RbJcR9R3fIyD26QB1DLmMxD8xwuep1lytGKxIXwHO6sLR9xu+HPyGn+ViFVlHyrLaFwsWlA0c5ZABcpCgYtZxcO5kLDduokbXLT6np9/Bllp3sKWwFWFPehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 08:14:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 08:14:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Topic: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Index: AQHaTQbqwLhJnfitzk6uXjNWAeudGbD+oR7g
Date: Wed, 7 Feb 2024 08:14:45 +0000
Message-ID: <BN9PR11MB5276C0BA42924298B650A5C28C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
In-Reply-To: <20240122073903.24406-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 7612949b-c219-4167-cbc8-08dc27b4d874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwamKzjXTFt/msXDDE3F2MLz9xpnHbo99pxIxWt1CM5HoARiLW2uhxIm8XThwaWPzuOLUMMjOJU7zGPzvPNub6XiBiOZmGdFHTvLtfjWvno+zsE+gwpkZmdjvhPEgetKVW3u+DzM7VbtvmJNPQKAe9vRZ2dssgroDibeZ/0DoyyvJ4HEzZAXqwAt8m8ybL5MFX5U+J9QLMSJCcFejc1YeaXLqKDT6dnl6pg3szFjtlqcUiH44IBJciebPD81aCNZ2rxU9Z38IqTUp40BTw0McuBOdqVbxphBSkaWT8Rr+X5okVR4r61+TaibuEiH/pdY5ADLVXG9/NPQOFEUi5EMaUu2BufcBJTKa1LJJvcJGmZiA6a57Z2s6EkMHO8wyBu4SGRw7Z3wyVmB3ZrfkeqmZAlP7NR+4+xUMn+/7flNv9wFQ3wVd4jskHw1SIbbjGsKmMeuOJJhQ3VAO+3+Gos96mhKoxypY1XTikMVBgCkl2kmtgSiJFWc7uxh26B6yz8ppOxeyvVKZ6OW2lOJGkuNmLkIMlZhoADmZSmqSiwjgt5uHFyLqoaIdwJnbfe7wtDvqdvacBaOGGN9WD4vMyKhAgLotQBk5wy5X4ImQwH0Nes1prrJSUtOfVi0SI47usVAPaUzM6iqCiBlS8/ADT/GYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(41300700001)(921011)(55016003)(316002)(66476007)(110136005)(66556008)(64756008)(52536014)(54906003)(66446008)(66946007)(8936002)(5660300002)(8676002)(478600001)(4326008)(82960400001)(33656002)(86362001)(7416002)(76116006)(2906002)(4744005)(6506007)(71200400001)(26005)(7696005)(38100700002)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FHu5wek4Sy4eT+pSOFsSWX2FefibCUAQcwIU+rN6wQR/STKiBCgQNIOgX/2I?=
 =?us-ascii?Q?nC/oUrixafP9T0E8pv+1XLBJu+8JLhPcyPXPV1MAN6s/8eB2gSXp52PcLSbK?=
 =?us-ascii?Q?16WNKq01oWyXYhAwMyOrrbG65WHHI7cOvJnA63nmYYQOShjk0R0iDFQ2s0ez?=
 =?us-ascii?Q?Zi38BjpXODBA/Ekq3yO3Y/E9K04bBkFlkSFAHkWMAAuEskrqT8HREqMRqJ75?=
 =?us-ascii?Q?o7MjAKuVUoBWFgmZI7Ge6z4PzxxGeSt6q4Mx2t6w4dER2Mmc6Tej5D6dul/G?=
 =?us-ascii?Q?j/dfKpAQeePHCDoOfXGhjWSG7x7VvUERqU6IZOFMvV7xAKb31EfGhSLeGL+r?=
 =?us-ascii?Q?ZmvgyBbai8WOqtMFyTykMwMEk463jixySMFtWH9rXg9eR2RAFCbHUYhjSPIS?=
 =?us-ascii?Q?CY5vuV4ABbXvd4z7w+lFPM2GLxQXYo0NuozZL+Qv4whK3bWF3BJ8myMOPaBB?=
 =?us-ascii?Q?zIPZzMuKDVxPPYHB+G2BkAWIuWoUdOjAgDZlAMLiEBGeOkAGWf7QBm6IXff9?=
 =?us-ascii?Q?9shg19QcB92d8SLB0Q8RhqyYwDOtrPubUUOw6flbJF4b0RPcvVWQj2Yrj+Bk?=
 =?us-ascii?Q?77AbK3uT9wQVrdzE1yrwg+ipXWz83JKwYLaWFArJAGTauzNZJj+uLEXwhr20?=
 =?us-ascii?Q?XpLKejhNUi9FCAaoU3Ws4Y0k7TIoXBntzEl6EFhonYd13N8ThWJqTtuGaIyi?=
 =?us-ascii?Q?sRMr3zfPDM0WsIV0QIZb94imbeITiLgGIKRLcDZuUbb4v9Ro57tBIH8BBfGV?=
 =?us-ascii?Q?EBh08NKfEOplMo9XUJY92UtNQQOQxHBYnElWSmNlJIH0E5NpGOk2XPaV8+C8?=
 =?us-ascii?Q?n73vR/IFtLDlGn9RFi9L4IMYga8j1CmT6wpmxVh4iB8evTkES1QDjfXqoLIT?=
 =?us-ascii?Q?l80tlFDg14k7fqROSOvIqwqpNESTE/7DgTHdYBMhcVaLI3qk2FYGCqnmC/7f?=
 =?us-ascii?Q?d2kFmSj1Zf/WMgauV/CZdUtHT/XJnovJZuv81DmVmoAbIWWAVlVPhd+CTMs5?=
 =?us-ascii?Q?3OPW4Pcj7XFKWsj6Z4WIrt0Uj5qRn1IKrQ2ZomziSSwAxEDxNKCPw2qvhhQ4?=
 =?us-ascii?Q?qJPI7PXpkuvytuEtAdDZVQMz+Ze/MuktwjUQsszBW21+v6AYwhgqkTF2Mge6?=
 =?us-ascii?Q?NWxVZW97Pv5ms0HcbuqB20Iqc0TQRdwnFTToevWxuyN2l3Bt6Ed8QtaFvlSg?=
 =?us-ascii?Q?NAv08oisfYZ/2IvEi2fxgp5ihjBBAN76174PLY0kAOrEnCbCKAGUyVbi8nZZ?=
 =?us-ascii?Q?Ums7LO76oOJVC147rxMg/DEagj7cpZgYH5E5pz0hAONdS8UJlbnKG5LzdhpC?=
 =?us-ascii?Q?6XB4BoZKPCbL6t2qzmwccFoWkWNGMHwqhHRNdnyb23b/daBbVHPzhnScU6cU?=
 =?us-ascii?Q?Z3ofrhbIUuJ/QzleUotWZxxlWniU05xnqGgg+xyVU34yQnNnoT31+LBdtGnb?=
 =?us-ascii?Q?+xsJ1hfgSSoOvjH2ozmFAwyxPmF6mFHVeMMq7y4VS1TuZq+B7wDJvZF2VH1o?=
 =?us-ascii?Q?Jhhtr3A/fX3Z73Um/J3r5a39yrTZ3Bc7mTw5NCtS8S8NBeCkkd8DQqqRAmGG?=
 =?us-ascii?Q?is+937Ho+UUhzKwgcjqEJ3Xlp17l4wO8SRsnJjNu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7612949b-c219-4167-cbc8-08dc27b4d874
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 08:14:45.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnwz73Mc4pJpZgnMkc3aEMAaXoHay4gSSf/rWuGNawYPsPnyFvmXP7+7RwaVecRTPRxn2+L7SQf7qSq3DmZOHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 22, 2024 3:39 PM
>=20
> +
> +int iommufd_fault_iopf_handler(struct iopf_group *group)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D group->cookie->domain-
> >fault_data;
> +	struct iommufd_fault *fault =3D hwpt->fault;
> +

why not directly using iommufd_fault as the fault_data?

