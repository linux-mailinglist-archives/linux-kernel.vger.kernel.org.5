Return-Path: <linux-kernel+bounces-42108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AEF83FC60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A89B21CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC54F9F2;
	Mon, 29 Jan 2024 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMdo+iUo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD251F9E0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706496610; cv=fail; b=T8qSKcGexlfzS+bd/gwuUzje0glkoCDBaUoVY23Fl9V+JzZgdrAIsXpmSY+PCmkWD7EBiTH3eC7UyAM2pc39l20VH/tYaCqlZeaZk4IM52YsXj5Z7b92ddZJt3+O0MWN7j2avLJ90i8jBAsl/6QMO5BlsiansDe1TLGulQ5qBSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706496610; c=relaxed/simple;
	bh=N2552ijhUN0kmGsU8SfE8rjjngV0cSOhzhiepONFjBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQDtcKY1UI5mqjizoPOzx2GpdrGfgfausukpu3WJN4YSdOiJP4vFkPr3UpxgKoBlSTuZAVsuIprVFuOkMYjIgLud7L28wo8Q9VggQu2TMWWSUXnje3Srj1aWTJwzxF3XknggmU+95LBMN3pxGNnq5Z9SJChtM86tUnDmNdPbMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMdo+iUo; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706496608; x=1738032608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N2552ijhUN0kmGsU8SfE8rjjngV0cSOhzhiepONFjBM=;
  b=TMdo+iUoTouwRMBd5ZuXgyFlEJztU4cqbXMP3oMEXsVcHue3kB+nQGmp
   ztSBnMbgSShcwo91MyA7yFy+k6qWmPYeM7Bp5JrB5cngH8+BztOR4XAPs
   Ja6Sx/G5wKZm2tjWTojb5aH166C8m4fxiFz8i17dyBSPUjV2MYRpVT9AD
   WOVCdlkwzPnHbM5S9d8+opsozis/3W/F7rDYtpaZPEwHGJAhu4r3iZx7w
   NfBIy3XiuutuFfjMxVhfFqVPNQCn2+3rlJtXn1vdQpCMcRAkQ49pnR3fM
   r/41JCUDaVb3BixOtIyLVoeAqdLFAIY0d01CtCJ4zOTVllGaMkY2NX5QA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9508409"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9508409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 18:50:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="821701638"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="821701638"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 18:50:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 18:50:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 18:50:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 18:50:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 18:50:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfaSjuXM8r+DBtFty7SIptnzjTAKdXxgJwQicKGy8zSdr18NNFQvJUGo6nYhiaOG0NaJCmXaDCmPQhrimzoSonNN56ctW92Z0j5LyOeO8HOh/LS9uWLozfHOQI/ITyA1KkWfW+80phAqEDDqau3ZVjq/lveA10sJa7fsSpfHXwwu9Vod6f9tzcgIyQ2PeQzwjLKFAHcEDf64Hxv4ctxKpgMoaDZGF611iHZ/kUzXVQuJ+jCh81D2RJbHN47HlAkTjy7yder20yx7ty//jylkt5qgUJ7W64pKAs0fvSY17cFpOhyhELhwv1RCaaEzbQqCXUn3GOl0xlyes6keQdUaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2552ijhUN0kmGsU8SfE8rjjngV0cSOhzhiepONFjBM=;
 b=H0Pa5QEnpaK3DdiE/4w6g0wv0g7KGQRLxWUVrvriepUjrSuB3JbIOIYDap/v0LrQA4nG2bEyNE+I5lau5oNSTXEusSSwDxejtvxRPVrFzH5n3ZXn6mlNEqQ8rGqmlTSDEK74smRgef76ULLILjaMotIYtvexBoErGvXZN4hq3j17AAFu4cVcqEOTvLI0DS9NpvR8b+XuaQSw34+rq22VqbCL3Q9FOGsaarei5tnZQKSbP9tF00zQe4KAOBQojtNDNcC7+/TFnub+E0af9iHwWrohvKeMXBvtULp7FYaifIEqQh8CRTzGi7TDoPzQgUvDJNl2LXlRVJd+JrWGQvernQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 02:49:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:49:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Thread-Topic: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Thread-Index: AQHaUO0r4vtzMl6r2kquUbnxX0Qw4bDwGbpw
Date: Mon, 29 Jan 2024 02:49:57 +0000
Message-ID: <BN9PR11MB52764D56EB130C2FED371C898C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240127064512.16744-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240127064512.16744-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7983:EE_
x-ms-office365-filtering-correlation-id: aa14ca7d-feb9-44c9-502c-08dc2074faf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ckpHhALKZww2bhE0KjZC8B8dKJknW0G2WaGT+cmT1XjQlAkPdIDVljKC/6cQj4SeusTDC/O/zkagRQCcu84emCbuDdwe7i8Eo9aAeb4LS7cRJCPEvkcxNf4m0AX12NDxxwTYoyNFU2K/BzyrwMPmuuEyFMNfJ86V26CS2wTwBl53aVQrO3bFpKYulqL7WW5KMUOuYfLO6BqLa0QM2P/BM9+S0FXWTG4GKpSrCdRU/xchDUhb6T6gcC5sMY/qL1RU6iMi950pe0iE5q4B3hwNz8FEhSFLI3sz8cmAxp0PaqksEUdjLh4Dp+i/FeweIDSTs8ESQCcRCYnYCynfn7ukUQYSMQ2FBFwL4JQkTrJ7sepFa4XH1r7ESOVSf+PxdtadxSQXqAmafdsoBognbZqERcFbTxE4ik+1bNhzY0kbiWfx+zXm8lQtdsZFepwtLAG3/0WxmhyskNIej+avIA/0jozch++AmB8jVKl1bKxwW+sLQ1SLPdN4pTXQkAMNZ/Lgh2VPd3kILN3emW9cDcHbdsyklvFUd/AB8RA7h8Uyfx+fjlkjuBOBHuJbc9cdAgDZCUnHqq+5py21Il2INqqt9CO+1Zfe/gMQXwXKU4AvS3gfBE5I4L8ANN7oby9tD4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(26005)(83380400001)(7696005)(6506007)(33656002)(86362001)(38070700009)(82960400001)(5660300002)(52536014)(41300700001)(4326008)(8936002)(8676002)(9686003)(38100700002)(122000001)(66946007)(76116006)(110136005)(66476007)(66446008)(66556008)(64756008)(54906003)(71200400001)(2906002)(478600001)(4744005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UqaFUdbjLEhOnSjj9XZzFyL6YZ/q4ekj62ryYY0HjM4PaXPQ84FrljTj471?=
 =?us-ascii?Q?aZuo2Y0d3yRppnBLOwhss9XbA32Sl5mCa69RpH1JFXmc7G7u6QFDy7RNF3Rb?=
 =?us-ascii?Q?ZOrGq6eWzsyAKV/Pz7teYpXBEMlVqPQfONBdDu0DSb5qyZv0o45V+3uWXeJJ?=
 =?us-ascii?Q?x3ZvsTeouv9LDnMDPVBUjIDxmq/KNMAK3gtnNrIbhcaM5AY2U6+VXQSghQUv?=
 =?us-ascii?Q?Tmo3aQf+5bRSqd7AH9whHoyQEli8Kwk/pQAVgOk++nMbECfxsZoxtr0oEfNE?=
 =?us-ascii?Q?3ISq9Af7F7RWE++xQal0AgNEBp5v5pvcpajwqbrUWEdauAnWi0A7Hbw5PJKF?=
 =?us-ascii?Q?GMi6KkPnihqDrWUxmJ77DmgAWWygcmhXORlvUVNIkvxJtQW0PE6jUUmZ/8K3?=
 =?us-ascii?Q?CXUXqH6VE05XqIh430iJrFslxkF8JA5LEO1BUGWSHC3r0LfdyCMhZ6mGMf0h?=
 =?us-ascii?Q?yMSRx5nMvPkLVJ+aZ9Naq78SUywoXbGqTovsu3WcS/aVGpDU5/23GXBHk8pW?=
 =?us-ascii?Q?KaccM3LoYqS01GZktOsPYz3O5xLPlTvkmr+eckCtPFLCeiZgJPi6FiazybSV?=
 =?us-ascii?Q?y/0aY81Y3hiUeN9KIl43YQuoowTZ08lDmNDSH2xYSN2U3NWMiseJUm/SPgOd?=
 =?us-ascii?Q?fQ+ANxzGveJrKul97lAkr2ejZ/hiMh0A8yntUbU3jZ5yDUARRP73XOyDkh2l?=
 =?us-ascii?Q?bqCnLIvGWYYOfJvPGek9wU3ikLY25l93SBIGZa10Kv0nmLtb944D7EMExZZZ?=
 =?us-ascii?Q?8yKNl/4gM3as0iCs56vUQmYbxrziMeXAp42oClDNUxtP3RKVHWrO5fr7V/Yf?=
 =?us-ascii?Q?pfxqoWXgxEGg/DkxC8YVvtvx7dk1HTK2x3MD5OVfNezDC1RwgED6x77PDzkw?=
 =?us-ascii?Q?WckOUTsoOwIwvStQx4bNhc8eizet4nhCtdtkEthO9Vl4TBw6s2n/y9gFDevc?=
 =?us-ascii?Q?PoXMv6RGkzAFds4XEZ7YNZ8y8h8lumIYUawQVhlkWsY6Q5s4q5Xt5q4CitAy?=
 =?us-ascii?Q?4aelzw9cQHt+vhkPYwswJk7RDh2O5gmtO5BugOhk2+xH+lomybAIw+0XdnJM?=
 =?us-ascii?Q?JCsDfVfPB233495WBE6G3f2FUO5FaTV+TC8CGTyGmnrHiZx8foqf8kmwMlVn?=
 =?us-ascii?Q?/QB65QHU3CiGOPiLZfMVmoZJn6v7Y6BFeclkSGYC5RlwnmgujbJsk32+riqg?=
 =?us-ascii?Q?+OOAQdWckl45/aNUvp+YMsKArlCzy53/p+yldgaDTowkSRJ5iA+wX0CFB5Xu?=
 =?us-ascii?Q?y6VSYIx3QoKJOXK1DgzhZUO5enGn6HZovt6FQVvaHZDiQPa2VOt+9ePrOFTc?=
 =?us-ascii?Q?UF2NX1RUE5YmWVT4smemLEcJxA4V/7IIXbctP8TS5a+LU3f9Pcl3SsOJ6AhI?=
 =?us-ascii?Q?5pP4plfkXjPifn9i6qxCjV6jEXuFWnHh/KWo5EhySxXMGymWA7al8gJz6zqG?=
 =?us-ascii?Q?alSA2G2WrXReQ1nzdQAN7IpKNDKYy66SR9h7F+EM73BuIFnq/blaOdrWZGNF?=
 =?us-ascii?Q?rHdQPibj5aeW/bnzgEle6vOrjGh0T7qRL2NRxbOjA2/xOlShFUE6UsEVML4Q?=
 =?us-ascii?Q?iH0jf/uudpihVcb+qruikon+Xq/7Jjo9ZX/BLzLy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa14ca7d-feb9-44c9-502c-08dc2074faf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 02:49:57.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iC0YMeKHdu5RisJSZsgDRAC8lNRaFIQ3JebTjWVF21siF+cR+K7Z/5IfOqgW7usfj+BpDTRaKPkW3kn6nppYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, January 27, 2024 2:45 PM
>=20
> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA
> option for
> broken graphics drivers") was introduced 24 years ago as a temporary
> workaround for graphics drivers that used physical addresses for DMA and
> avoided DMA APIs. This workaround was disabled by default.
>=20
> As 24 years have passed, it is expected that graphics driver developers
> have migrated their drivers to use kernel DMA APIs. Therefore, this
> workaround is no longer required and could been removed.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

