Return-Path: <linux-kernel+bounces-3499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B050816D19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE34282F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C211B281;
	Mon, 18 Dec 2023 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3lnbnS7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7C1BDC6;
	Mon, 18 Dec 2023 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702899967; x=1734435967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CtyfFxb09nqrZFjlOBNtXW7yrI1q+YOHAtbfpbAUl10=;
  b=W3lnbnS7RO1ozmzLAG2x4g2UcjyKKbPGlgFHX7KneKW8pPyxmsBMkmbM
   UMuk/PdxJ2e+A2MQ9LelOXScvmivmkm+mDL/2cQ/1gBPm+7kX7JF73bpC
   uEOptGxHp7dsExzfg/ooR1NB5uCNmlx5GM+j0Ij3kSp3oFlrMT21wXmdN
   5ZZ2gZ9WSToqwCjxESC+eYEjKmK/UgKehYUSPEZQv76osqzyNA0EpgDYs
   /6jFJeukwomlY8LmU+ypjT6eDtOv/l2Zwy2VrW7O3H3ZkljGlEc7kDROY
   3vTRlVtgie/XcKIzPbGJ88CF3Uvn2zPG3nleqv/+fLRlWfKkdlPaaqQ/R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8943484"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="8943484"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="845921274"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="845921274"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 03:46:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:46:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 03:46:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 03:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHzQG/yT2As1Kltq9IRI1sHXes7cunXvzuiTfZM7rnPaShFowBnZfIMrQNM9k38QetyT+3z4bRbPVHVlXIhOaFrHE2JKZfYHCgw0PtpWYHEXLbFeMrRVANJdBideEFRcHI1D6m9rkRYBnsCv9HD7mILtBimwsizyVvJ+WtbMMHsVYvKGwMas7euEM+7DMAjW2ekrFLfz4dU2WQNRf9K9k1S30zBdETPhP0VbGAn5RHYjPfPe4h9ze9yfwFgxHxIK4CuA7H7ejjjrbTIsSf80VU3d8O8zeqbs/+qrNsxneT4SJ3Fj1wV3x7jI0xxLTe1VMf8DUtYwh4Dxqt+nUL8a5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFfs201+DKhWEMxNjZfZ9xI7htNEj7T0hqBbR6eg8wA=;
 b=UzjG/HZh1BLKfi1IYx+wJRNBir4FnwV4BAZ9ZDekH3Y3X6SF13qbxo/4WqKSOVjCeLkTGpYe6o7NDawVgrm5IJtkBeGVNdn3t1AmTVhcYLisvRdMgZs0ML8IdRz/fgaU+xzSE8XBZxtBVLaR9I39PjyAf7Iwl1LXjoZ6TxYvKEDXMq5dCikbagvZqu+AwI+TQyMatYOybBe/xbS7bZs+nbJKtf75jsMOVZvlhaP/ngR00nO5HOMRgM5Bd5uELAiIP5AxnMWwG8Wb2IuByJw8LGPiC25fbwMHe+FPzjW1i0FWM7EbVmqoWbQq/MmeFTKVnEGwrly+m5aSXJZT/W3Pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 11:46:02 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:46:02 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Kunwu Chan <chentao@kylinos.cn>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: "Michalik, Michal" <michal.michalik@intel.com>, Kunwu Chan
	<kunwu.chan@hotmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kolacinski,
 Karol" <karol.kolacinski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next] ice: Fix some null pointer
 dereference issues in ice_ptp.c
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next] ice: Fix some null pointer
 dereference issues in ice_ptp.c
Thread-Index: AQHaLKTQHcn7O06UlUGdSLeuOTcfUrCu1ykA
Date: Mon, 18 Dec 2023 11:46:01 +0000
Message-ID: <BL0PR11MB3122A578DDB85EFFCFE6D933BD90A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231212024015.11595-1-chentao@kylinos.cn>
In-Reply-To: <20231212024015.11595-1-chentao@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ0PR11MB5117:EE_
x-ms-office365-filtering-correlation-id: 89ef2cc7-a31d-4d85-c44c-08dbffbee8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZEChIDLAfh7FwQfx5usPxWRk7MF3hZasZ6wk288kZsC3yZeNdM0ejIlaSn13jU2OxBMyEZn6G4qk78W57xSHjzwltnYAxwj2ob0SQu53cQZ7qcI+WFBpqotf4E0kMe/m+erpUPMW52cvtYHT8aQx5oCMNF8+4hyHv+WW6sUkw5L7HmuKT1Kz+ECF/poPC6YfdPJQA6qpoJZ9Fv24+jjQRiFxAcyrsRHYV2e8f6LYBXOLEnCLtLvdaOsYrU9/YZspUScpJg/JR8lQ8dY5vhVy2J1rARJGx8FJbFwNc5c9g1Rb2+ii5NT1UZPWMugMSXvqPzKbCWdZql8AEIdqimi//s+j/kq5rSs2FRCfNkbCRATjMRsOaIA28936uMdtuxvRAYsqzFSaBHS6qRPlEIuomARppsXp/4HBC+ncIvqA87rK2Qqu09k0EYNg+eSZveQ5Z1jTEeiEC6wGCKtfowmMeddDpI3rHYrs5AhJS4u1J1Igby1ZlcvTFrN/DEw1jSM33qVENRWH/ypKLKwe7Xed31PMDV86JSXeLARubQCxC+AZ9q5WrZDHOMftm84Lvo/H2fsMgsLGwdA0xxAsTNdhx6LtdOGhF53nFOXHab3JWu2twAXbgh2Y54UQFlfcLd+xrm/8vyWnZnQmvvWiNPwxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66446008)(66476007)(316002)(52536014)(4326008)(66556008)(6636002)(8676002)(55016003)(8936002)(66946007)(76116006)(54906003)(110136005)(64756008)(41300700001)(83380400001)(107886003)(38100700002)(26005)(5660300002)(4744005)(86362001)(33656002)(6506007)(7696005)(122000001)(53546011)(71200400001)(2906002)(82960400001)(9686003)(478600001)(7416002)(921008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tgi4gnoFHeuoJBJT39VWy0vdqgUO3mNt3EW4e8IhKuc/ZaYeYornQ3ZdRRJv?=
 =?us-ascii?Q?GEC5w8G4La9yWLpKUGUAf0Q5CZAdiPL6rMQ7xbsHiPGBCuNikuZO8OWfWJOV?=
 =?us-ascii?Q?Bs4TeeHX5+E39lbEwFHC9Pxn8zLEd7ij7ZBsbwwaEWqtuiXcTX8EVV3zKm69?=
 =?us-ascii?Q?ox+v9fFaEcEf7inOzInFUuV0jHGv2Veg+wtcabd1oyzASvDuln39cydeiS3W?=
 =?us-ascii?Q?1j55nK+zZ5kMEB34NYLd+spB81px51XIpWk7V2Y3Ytufg0TcSYRIrychKrG7?=
 =?us-ascii?Q?ZVFBX5DvXCiNymguIZ+aiIJEnbaA4OmozQfbD0GSOLr3HNgQYCXjJ8NCHN5T?=
 =?us-ascii?Q?KOffEV1KZNtmcf4l5Bafpvqyc1ui0m7rnDaTYBV6zW+Kh2/bwgKPr4xM7u7A?=
 =?us-ascii?Q?6n+xUhdQFt9fcybVcHZzYYYIsWbY4+VcAVXYq87A1AbXU0WO4uefo7nz/KNm?=
 =?us-ascii?Q?iXTTO6lhK5lNjXkEmCmaMwpyXyrV1TaZrEcOy802NDuC/x1qPjB3u07m1+Vf?=
 =?us-ascii?Q?C+xCd8y47GKbQxGSQtpkEQyDAkER/nQWL79K3+ytALIRki7SANxb8+udbNoF?=
 =?us-ascii?Q?AxlgoLHfbiip4irwAO1L/mH2rp/eYdHEgBS/k3k7COLDld7yBn8BIteMvWsd?=
 =?us-ascii?Q?GmLbaOnY5PP+BRW8NQTot0KXKN468qNXGbadFiDCRmawns3CBrBgtxPK7yL8?=
 =?us-ascii?Q?lxWIeG5mYwGmyhIeadPh6Qh84mYZJWSYYTYRYaVK5H4Xb9k6PgfDVJCUmZMd?=
 =?us-ascii?Q?pxW3nexgAE32tE7S6qidpyp8evk/OQGHsCY/BmcVqQvepx47RVCcWKQEYZoy?=
 =?us-ascii?Q?JVv+lUQf9T/sTJYGKYoFK7BfZy1SpaxAPM8y88m8X7HT4se8DtdjXZcZkWvH?=
 =?us-ascii?Q?NIag+jxMwtyEPHAZRtV8VWZDusX+W+ooJ40082lBMlkzXkXIT21RxFV1UquS?=
 =?us-ascii?Q?hjU/Rk1NcHHW3ZA+qhrCi9x6bIokIiFjDHBQNg7gO+1YglgfOCEZ5iF/Adz6?=
 =?us-ascii?Q?6gvQyHCxfnq8qScOELFGFANJKWFbotuD/2e2fG0eos2vHPcqRQPY4y4v9aFx?=
 =?us-ascii?Q?cJ0D8gHClbWt1TTgCwDEepzgkDVzkGw5AEorYaKkwzKrThW6T9gmwJ1rCG8K?=
 =?us-ascii?Q?3c0LtgTc/IJvnmu7+CTRA5f8kGyl+TVYIxz/l5mf+fwOb4Y6JvYF5dIVxKsv?=
 =?us-ascii?Q?EIEGBROnO5ICz6bQIcK8Qs6sX6iyNSWtI6vCJr4iMSsnnuM1LNtJ6B/3EAnX?=
 =?us-ascii?Q?NU5iHuqpcp72sE7ZSfDCvwUPrTe5YBSWjO5MH8b63hTdjgI6rCBS6d+hrG18?=
 =?us-ascii?Q?cS/FplPIGNUDqr3zSiZQ7fYMD88SD08gmdKhxAYRmzAJxCZP7Uw5EO0kj21R?=
 =?us-ascii?Q?yO0VUWYX99KK+Htej7l+/iq60JiuUo+NWboaKuCN0/V2Im2CqDxUfaIL/N8l?=
 =?us-ascii?Q?v+xOOynV+MYI0Zx/rVMJt4y13+ylWgYq4LUo3npvXpbwrhxP1CIFwtnjDeC5?=
 =?us-ascii?Q?09SNLN3RsAhRv/GQ3ix8oYPSHF4UxttArXlCwrNc2Fee+zpMS5se0kG2JFxb?=
 =?us-ascii?Q?yd1V/G18z7b2Jny2ITo2VB4mBgriYYPKkMZ+fTvW3Vda68DKplQGPqCVZMCV?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ef2cc7-a31d-4d85-c44c-08dbffbee8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 11:46:01.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHAQyAUtx++qxRZEOghldlaSRr1rpv6O9vZhXHmCG5Qae55ghlaIZpaWWpCfQy7duvBrnMyWEoTewQGx+r7Ja7n13vWnsTp1JjuvBHWpxxKSzBX9XUx5eYDoaFZ0w+P+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
unwu Chan
> Sent: Tuesday, December 12, 2023 8:10 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com; kuba@k=
ernel.org; pabeni@redhat.com; richardcochran@gmail.com; Keller, Jacob E <ja=
cob.e.keller@intel.com>
> Cc: Michalik, Michal <michal.michalik@intel.com>; Kunwu Chan <chentao@kyl=
inos.cn>; Kunwu Chan <kunwu.chan@hotmail.com>; netdev@vger.kernel.org; linu=
x-kernel@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com>; i=
ntel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw <przemyslaw.kitszel@in=
tel.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next] ice: Fix some null pointer=
 dereference issues in ice_ptp.c
>
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
>
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


