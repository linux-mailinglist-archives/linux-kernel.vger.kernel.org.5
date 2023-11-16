Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6471B7EDA38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjKPD2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjKPD2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:28:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA99196;
        Wed, 15 Nov 2023 19:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700105277; x=1731641277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Rh8zDKmgfTosReSybSQXqAW3vKVPu+oco4qmkvTWrg=;
  b=lYmlfVrapfIoeCOvd9cq+rEUCPexcMHDXCSq1BRzy49uXpzLf62FbWHy
   RT5lKf+NFCEEkQxpIKKTxxN2/mj4oAyjD7L+q0CQ55TYrMJlUh9d9krSy
   lVytErlhoyt+mo9RC+HN/uptjUtUmGfXhicolgQCuAXNCEyAkB30iS0Ll
   ROgmlfQLc8xKVTDypQi1DrBTckFQ8rRaI4iP9130ZyD+ZiLHR4KGtFOUq
   EUf90ZS6kQZmCDcDB8xdm+ORakvMpvmd7UBABbolRjJL1BKpjOOIHHmKi
   xxzCkP+QBljSWIKr0Af/KQtvj+AKefhpr0lC7TfgUMUaRaP5jRsUurQwg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371190783"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="371190783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:27:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="12982571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 19:27:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:27:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:27:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:27:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 19:27:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNSnHCKqls3txAeNw5TsEuWmC0IeZecjfBTxZ9eRmTa8521x0DJKWpNvYV2DJ3Oh4UYWPB7i/8qt9kQ7MNZo6Ld2MGESqgfvkzGgaeXtJFYBSH28qLXjfgeYvUOVmyUiThjdv1Lu9z8buTBLJ3FBLHggvuMJnhC8AJ8uXZmQnZb1IVMP156jScqu2t7ZmarJM0ZMFLMVmlLJijp5VkOZN24SIQ7tkjuaUujobGtfMF09c+tx7ppZtBMGDJ0ed73NfyrBO27rLResLRb9efLA7fnVZwdHDgJVSRx2IDa+E+IDjLRX/Skftc1XQW6btlAcw/UeqxE7fKfPka/0J6y3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VGyoxsXk7P5vMhrYmngvn0GbxGbO6VxpWAWFTLkuZ0=;
 b=PHpX092I6WlyFaRknUkW8Gifi4WmWg2BYUo50l4HERGMDTUBBNrGf/kULv9y1NrONODODKWcMJWTidbWKm2ddZGgwEa6vEetF/TBEE1nFC2zNH3zS1pVE2H038SKX+jpZ12INt71NbgDc1NeAAh1/XPZ3+ZFwC2Z65w2fhDkMXOpCcuFdFeJaYuZ+i4dGhJxBWNAXt/McfF4XLQ1oDmKK/hinIcgdWNVTr2HDr8ztD5Pv9hyzIWXmpg7Y5G8s/5sJIOUQFyUnaKqPwVDKO2f/KZb8i+EaASYe282rfqje1pPBo5RVszWEqdL8f61gDpQU+qSUKApy/JXjIJl8jsVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5467.namprd11.prod.outlook.com (2603:10b6:408:100::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 03:27:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:27:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE
 disabling
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE
 disabling
Thread-Index: AQHaGDSPS6uE3JB1iU+hol92LQE6VbB8R58Q
Date:   Thu, 16 Nov 2023 03:27:27 +0000
Message-ID: <BN9PR11MB527667F09E2FAD729AE2BC2C8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231116022324.30120-1-baolu.lu@linux.intel.com>
In-Reply-To: <20231116022324.30120-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5467:EE_
x-ms-office365-filtering-correlation-id: c77b2ce8-4ca4-4a85-f169-08dbe653f53d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BUHVkUjkr2eFvfZcRQySBWOBc9xbPgnh4ZZjhrbnW9sv3LKcdiW6UvPZhD6aNQxyvZAxRmw2ngE+2W3xUzJNEMaDGpGbna4fCRcYT1hMp6yvtHuZpQQN42RGjGTwhAkwD8faiQeAv5aXkWWK6lzp4GTkIKZudC3DnoSjfJL6tE/r6rlUBonvZ8Cu/NHH1UKrq0QBBEd1DTlrTr9V+ND0NURBsWC04nI6IoQu6vQKlQsrCAY0WUHSVn8ZAxhEtQYbyNHs4knWIdpi23vkNHGRYAVKu47IwgR5oFhvXPL7Rlh/tS5xtKXycvTty+EwVp4h+fM58hNMKZ9+hMooB/O86l9DDBJ+VaMO3z7SQ1LcXRCrla3wFvlQGS9lv1ds4WDjj+Ro06QDY2vrXm+Q+I1i063i7+es6ORu8ERKoP/mImXdMWNdei4+Q+/FVvVCvxKRIib3uiaGW3ITznOvXgM1dPBGPFAfwK9mQBjFWyYW1o/EuxFyterhvxNkHKatcSM/g/o4w/63sNuLBF+gjfmOa/ROWtPJAQTepGwdvDG+Vc5q0YQFWgDCQdbZgBWk3jV6niPuGVtERdXwHDHPy41pzAxZ5LYou93RB5PMukmcT7R2Sb3LP7cARTVsiBbcwMP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7696005)(76116006)(316002)(64756008)(66556008)(8676002)(4326008)(54906003)(66446008)(110136005)(66476007)(66946007)(8936002)(52536014)(71200400001)(478600001)(41300700001)(86362001)(33656002)(5660300002)(2906002)(122000001)(38100700002)(26005)(9686003)(83380400001)(82960400001)(6506007)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aN+0DoEoIEEfVBC7piCQDIJ6AR8E8MUKg/OMZCyjbBxUlesS4q3nTHX6Kbf5?=
 =?us-ascii?Q?nDtPxf5srkpJKapKO2Qf7vH4e7gZ2owfaBIJiAxnhU+BzuEsjSIbJc88ucLm?=
 =?us-ascii?Q?VqRuq+Fog/Fs1u0lGsLllFxOAEbMk3a4KgLz/Q5w+jOOkreEhbBZCeph9Ssh?=
 =?us-ascii?Q?dFpIuBGNtRfFx7nBSiaJ4lbgW0sf/fnDUjcc7PO4MpQf35oSh/oWoKIRjiQQ?=
 =?us-ascii?Q?uiRX5V4WRRvtIHpZ6PnsE6pv49dZQ6mubnfuwmOMqGC2hrAyexoxZtf9O4rw?=
 =?us-ascii?Q?yDeoOpJeDvfnbbeuF3O9o1T/6YwM4B7x2fe16imWSiyzabc1poSbze1v/38E?=
 =?us-ascii?Q?JWqF8pultyWlEbhu5+fWXjmIKogHu+/o0m486UrcWmSVNhPxD/c37XmO8b1g?=
 =?us-ascii?Q?JfMzCDStpJU2DMc5/qiRjvskvzTzHwmmlSnaervGH5eqMySekgu7QLfcCoVz?=
 =?us-ascii?Q?kOHe4fuWcXg1L0JHGIm3D7CMZbMzJ5sbGbTVcMZD1En+LUDBul656Ubf3oAr?=
 =?us-ascii?Q?tlPrgLA7qBRDmyO+A5MA3YXnYaULfX6Xs2U/vb35k6f7f8JE/+QEDC/2kYh4?=
 =?us-ascii?Q?K0PDEe5RoLHVEG0xIEkx1FSy54MDY40PB5MifpDFpq9znxTcSo377z12OJRK?=
 =?us-ascii?Q?EX8NXgDPKGyB1Ty+j0i7MRfnDU47PXbQnERYIUsG17snztCPAeNkjjxb/1W0?=
 =?us-ascii?Q?QC0u64org06wV3yNxGbnctYyHFw5N8WeWa2YoWrmbuHR9z53IZNNolS3lg/t?=
 =?us-ascii?Q?Kp8nXYTbKTM1cCEK3afqh2ZZBuO+9TijlH8/LdEydUIgJl39MPXH32hNFlSD?=
 =?us-ascii?Q?eVo7rqQeOX6XfpT2NXYJoRa67uAOgfbZgu+rtbv88UYB2Qd+lMptD1KUtCmk?=
 =?us-ascii?Q?eax22RxZhiaQZDxjTPjSM4Kz3D9nPQfSaDzk5jB7nLTl9ec/VcnqygZi3LEy?=
 =?us-ascii?Q?lRUch031DJZP7estcSNffrCkevArIoN7rXJ8wzHqI9f6G4iJPS6l8uQM1Ejj?=
 =?us-ascii?Q?Effw83p6HVt/iB0bBhJjdAaPcYYkM4aPb6PhtfN21m4/Y+N8d1MK/qHm/8ND?=
 =?us-ascii?Q?FI+ELbPqx1AOLy0eDx/TjH2agLILRia+OG/77SJhbtpgJMWXUCGNBk5nNHXV?=
 =?us-ascii?Q?0rHLGxdpWfvK2EcQjWdiSaU2HsGFQmsoywGKggC8rxkn5goGQWAbPTwo/bPZ?=
 =?us-ascii?Q?5gbOH6cypebJwABwpVe5OkAbLPHPW4kXQjTOlhAudr51Tvczcc+bmDMjic//?=
 =?us-ascii?Q?Q0Khvy72GUBoOmUuWm5xbLNKxQgrEr1YIG8f3JvnjpaptzF1Uh+V9RB1YQzl?=
 =?us-ascii?Q?DHKPsSM0RRO3/wirfV1w4M6c5aqJB9uYu1PVVNYU5rvFf1DPbPJRyxmY2LJs?=
 =?us-ascii?Q?9iJhOIp9KM0vFdz68ppHR9HefdTuvuko4XoIRv/48DWKRJDIEJzkkuY8pP4J?=
 =?us-ascii?Q?jlWWgCb9Ta5/ApVIVwFzIT80PB7QJ0fcNIehl2pGWaBVaGgaIAR4OvfKCqK1?=
 =?us-ascii?Q?KBnsHnPo+av8JFxlogQiPURKhvhZWsL+dz+QFc8vjGNMrZ/52ltHkqus2fPi?=
 =?us-ascii?Q?EMYD9abUWtI2F2bK6ZFqbECrfo8JEGHpJdd4gq78?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77b2ce8-4ca4-4a85-f169-08dbe653f53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 03:27:27.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I71ePRxu8vI73MXav1MlirhEilfj3m+jQTC9us/4yzvHg4MMvDUONkhBSwVs0OEvuxoydOb7gkpIp7UnFdUDfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5467
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 16, 2023 10:23 AM
>=20
> From: "Abdul Halim, Mohd Syazwan"
> <mohd.syazwan.abdul.halim@intel.com>
>=20
> The VT-d spec requires (10.4.4 Global Command Register, TE field) that:
>=20
> Hardware implementations supporting DMA draining must drain any in-flight
> DMA read/write requests queued within the Root-Complex before
> completing
> the translation enable command and reflecting the status of the command
> through the TES field in the Global Status register.

this talks about 'enable'...

>=20
> Unfortunately, some integrated graphic devices fail to do so after some
> kind of power state transition. As the result, the system might stuck in
> iommu_disable_translation(), waiting for the completion of TE transition.

...while this fixes 'disable'. wrong citation?

> @@ -5080,7 +5080,7 @@ static void quirk_igfx_skip_te_disable(struct
> pci_dev *dev)
>  	ver =3D (dev->device >> 8) & 0xff;
>  	if (ver !=3D 0x45 && ver !=3D 0x46 && ver !=3D 0x4c &&
>  	    ver !=3D 0x4e && ver !=3D 0x8a && ver !=3D 0x98 &&
> -	    ver !=3D 0x9a && ver !=3D 0xa7)
> +	    ver !=3D 0x9a && ver !=3D 0xa7 && ver !=3D 0x7d)
>  		return;
>=20

this fix alone is fine, but I found this quirk overall is not cleanly handl=
ed.

Basically it sets iommu_skip_te_disable as true, leading to early return
in iommu_disable_translation():

	if (iommu_skip_te_disable && iommu->drhd->gfx_dedicated &&
	   (cap_read_drain(iommu->cap) || cap_write_drain(iommu->cap)))
		return;

However the caller of iommu_disable_translation() is not aware of this
quirk and continues as if the iommu is disabled. IMHO this is problematic
w/o meeting the caller's assumption.

e.g. kdump and suspend. We may want to abort those paths early in case
of such quirk...
