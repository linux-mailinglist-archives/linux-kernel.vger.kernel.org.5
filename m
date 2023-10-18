Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09D67CD33F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJREvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjJREvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:51:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16A59E2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697604230; x=1729140230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hgDJchtcGwurWuYV+j30JJnz04GaFzKHZuTHnOuSzSQ=;
  b=dwlMB0zCfhGMe5CB4e71XpXKZlGQo4kqKFEOGIS61orvn8qjx0WL1uh4
   BRleXG2iDwK7rvdY0rJiWrXgCmlkgYT4qLqADi08/vYbp1U5MQx5MW7T9
   vIA8KjJ25iYY4SMfAPG8opWVkQRV8+wjrXhCx6zpv6scSPveQdxdNPmOq
   Nx3RcvkB0jdH39VPtdnKbByQ2VI0v7kSa7s5dW0KdcV8hUMCICGsIBZJ+
   o4JjuTrJO6Y9RfitfX6ShsCXModToVSocY+u8ciTaf470pjCZyb0ug0oR
   7ZZVdA4JAvL91kqCotC/XCjHoDGJSSIFySwz5Dy8dIo8n4W7a06kxTSfu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366193854"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="366193854"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 21:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="4191457"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 21:42:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 21:43:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 21:43:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 21:43:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 21:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpRBtnCxkPjVY8Hm2v8sRojPRHbuzchGu6oXA/6Xx/bzyd6iTvrRH9Vc4IenOoTR6A2Z7YsSuF8ssSZAc1+FzxMZfQ5SDxIK4kgoCxXVX1Ak1kOUxWOkW36G8xruqRNhINIbzeCABVOKOao6dsI/eJVqiGPMf2i8MRjwApFI9SeybDcIV4ab129cG/CBDGO2l9VwuI+mE58XdMWjmrPNpm9jzaxEu4hIbZ79T2Q/YZynLfaRCXOTO22v14l4uN18flhoHjzCxGM06UI5nfcf4vIdyUv+tfoceGWrN54Mc10DY+XhOiLP/nCycrs/HAybyTa4MFM70xhuT+uwd3OBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR5kPJxZsYey5fJM0RTnHB3gWBImgNQsLhFbw8Okhlk=;
 b=Iudlo99MrzWg2uqqlXGtIG+tsYDc9LKsKyPS1sn+9Dy1crRJ4dnNU6+hx8wDpyqsO2daYFRbYjmRPTm/qamVFMIFuzENU9Ga4wXcNu/VWbHyETmxjR/BgdtvuI56asT2eT87soXakg3UI8Hpr7cxkTc4bEGgrEWpvDGyt8/BYFEt1BPhUXgYLLhJ2bWR50ocamkVBiVYN95IIzTCj66sDTD/nhr9lNM0aNjN2u0eSkUFJUE/wqY76XNEbWDEAYscMEWuMDstC9JlEc9RRlRsjsTvpXtKsikTdYOnT6yB4OM5gnJsSLjfyk0OQNA1c28bWXrW/fcQ7d3xfX3skgGZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH0PR11MB5492.namprd11.prod.outlook.com (2603:10b6:610:d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 04:43:41 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 04:43:41 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: RE: [PATCH v8 0/5] Share sva domains with all devices bound to a mm
Thread-Topic: [PATCH v8 0/5] Share sva domains with all devices bound to a mm
Thread-Index: AQHaAJO2VqePiK4FsEOuJbSheMRPMLBOMH8AgADH82A=
Date:   Wed, 18 Oct 2023 04:43:41 +0000
Message-ID: <MW5PR11MB5881EF500A27E87D58E5111E89D5A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231017004802.109618-1-tina.zhang@intel.com>
 <20231017164150.GF282036@ziepe.ca>
In-Reply-To: <20231017164150.GF282036@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|CH0PR11MB5492:EE_
x-ms-office365-filtering-correlation-id: 78e82aff-d5db-4561-d064-08dbcf94cd7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XK11zl1FlSTd+KG7r6i8/vE6FqBzL1KksEak8rQ0LreMwTiSteNNag0X3B57y1833BszSWBpOSu+WToVeTj1/McMZWxBiAKKUfMcpx4mRi3c8Q5zfrw3YZh3L7+c9kcWQFPOEiW8wwuHMtY6ED86+fgDyVyQkAfm3CBjkIMt86MQJN1W3CAsCEFHJk1csQeroMlfhDGYXaQnzfrTxNQXhGE1IpJ0wPlcyUNlEvDbDSOjrTjvv3bpaLMDQ33DjpO2nR95vsMhthZVJaMQ8YFzZgUSm13Zf3sSarVk+DZ1DogN4PqLu5tp5hAnMkY6HpudJYH/tPGgIQgt2i1v1bc/jU7VncEtIl0bhgVuKAUw9KkbgcVhFBzXeUdna590sTJjT2qgPAhasIFjlXQXIeDQ0TTVnTOupVNr+M3SRXDjDcyfKfIERGDV1mZEcNEnIooMlEQkhplQ1ziQ42E/UBSYZ/wEywOdkCu7L/i8GlOjTEw5/4ATN5D7/C3obExlZlzttr4eKZNUalyE1NfXEJFcbdVP06G4Ejs/kMrVYGnQtxcCtCy8e2RO2pHebFQXN3CsPA6Mq4yAHqbtkkYmlEegIbtZBnSoSSq72Ryc5bZmxd6waVpNGEtz8UpLZSP9YxBw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(83380400001)(26005)(53546011)(5660300002)(8936002)(4326008)(52536014)(41300700001)(8676002)(86362001)(71200400001)(38070700005)(55016003)(82960400001)(122000001)(66476007)(2906002)(54906003)(66946007)(316002)(7416002)(64756008)(6916009)(76116006)(7696005)(66446008)(66556008)(6506007)(9686003)(478600001)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LL6+itLhAZorMYxpns4D0BiKgIszhtmGtdYkrwAGLRcz6kT5iJRicZ9kPcL8?=
 =?us-ascii?Q?zN73GnZn86oy5a7Jq+ULMZ6AEraUCX475sJJytWZDbWDxNmtdfebAth8pKCK?=
 =?us-ascii?Q?c2ZwyzFKQSlB6g2IzXaY+YwNpX1uDRhKLec4vBsH8mEJVSu94ABpk0pdKM4v?=
 =?us-ascii?Q?X+n5vU3wYHnps79iDaQylWFKg8ZuSiY5dwZtfqCwaApFF65Z+tVBxG/m1gzO?=
 =?us-ascii?Q?OSozoW9OnDEEldVYKW/ydkIG7fKgwd3CDhkff45gGto1YsuzxRUudAPNOEo6?=
 =?us-ascii?Q?QMccLe8W6ccMkpVPjF4MuInfmK+KNLhh0X0tb6+QXLTQARl6Pso9pJWfzJSR?=
 =?us-ascii?Q?3DBrwruwb0/cu0J9HNz6ne4J6RS7LpYEwi8DFVjFUaU/s+N6TrH89dHm5/Vr?=
 =?us-ascii?Q?81ryS+MQ3GeC4LJ42WSAYaalGZCaHjycaT6AjiuiTS8+BhJu/CXTm1ZQxLic?=
 =?us-ascii?Q?zMxgtRfqpeMyVaQUtdpmi2sUe/8y19MPPIivPGWlqF6uk6K6R6jaTYbbkeUF?=
 =?us-ascii?Q?Ngg6/TynvjTw57M6ZEovJzuQVkYnH7hWc5mXlFCiSPwiIuVoEH1lFjRUVU0l?=
 =?us-ascii?Q?WDqekozPopr0MCi5KIJrhiTpF61gy0VE22wnvZiAsBAlMii9uAFt16gqMg7L?=
 =?us-ascii?Q?7qccp5p0I72gbnGAB/DeIIvHUp6J6n4T7niVn5iOTXvHWpwXuY0aERUiI7Z2?=
 =?us-ascii?Q?cf+KStUMy8jqc0Ce89a/gcBlpNcblCC0SqiM4KqsGbSXfyBKeTHqGu2J0Cxr?=
 =?us-ascii?Q?86fPmYMAZ9FoyAxv60Tlg5mFiOKS1xS/qZlj+6j+qq0xaSnxTOBoYf1ny9GL?=
 =?us-ascii?Q?Im6SxT+1r0zXYPoAHrI0Oz8tP41d/FitHHJLspUAQdA9YPbTT+vEARqWpGUm?=
 =?us-ascii?Q?2X5LaP+yYEnP2cZjQNFfsNF04SWnm2ma1bEhp1dPXzQfxBMk2VJuUiZNrENR?=
 =?us-ascii?Q?uRVpgmXbSJyhRfm2p3Anwcw58zyYp+Vyaj1bbK69CFrqZvNLYif862bKmv4P?=
 =?us-ascii?Q?Bs/rmU4d+e4TEum5TEQs16X3R9mbYV+5OBMTqurJTLDGMPNnM1bn/Vwb4klK?=
 =?us-ascii?Q?Y3MitONxD9cJne3jg2BH+8J/kU/empL661yED3occwiPZkzcOgUgNj4t/usx?=
 =?us-ascii?Q?aZzFutBPaqa3q58Eh7Td925BPdZnTlFpd0qNoTLPz/VfV+9gWtaf2OH/ZZuN?=
 =?us-ascii?Q?Cs9c7ChGB4ZLPKCLoQ09X5eIcuf23t1lF0AtIL78RgEmssZWYeQXLzYVPDNB?=
 =?us-ascii?Q?zXfe/eno4gPmJwKJmsRHIf3HFJE4yUBayTSecjradtu3RlwfPsME4vLEtPUI?=
 =?us-ascii?Q?JosxIZ7B5mA4gCLnz4Y4EHzLwq6fROQC+0dkDNBzEypZx5fy9MvGBw4yRTUJ?=
 =?us-ascii?Q?9G44wga0mfpn/LtbkgyBB4qHt4S62UhdTIqn6M7vNdKxClepwv1euX5o5wiq?=
 =?us-ascii?Q?kuPV8RlBISydQD0lHvx04Aj8Tljxez6deKgipiDg3V9U0dN+Vk+EZ25tYdUJ?=
 =?us-ascii?Q?BxS79l7R1lb4ewvGrPDCOnJPYGKyVRKZ4PgR+7j/6iU0rhWyCNnBZ0Kq8Ozh?=
 =?us-ascii?Q?P2nyi1Xc8ToY1qaAhjzpNueeBgdViORTezCR/x4a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e82aff-d5db-4561-d064-08dbcf94cd7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 04:43:41.2294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PXWmbqElYBJc6GAUZoP6riZmWfeorTyEY85+m406NMFHgh3tYYqeKOBP1rnLg4c0/lQYthPLdSIDQXxzzVxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5492
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, October 18, 2023 12:42 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; David Woodhouse
> <dwmw2@infradead.org>; Lu Baolu <baolu.lu@linux.intel.com>; Joerg
> Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; Tian, Kevin <kevin.tian@intel.com>; Nicolin Chen
> <nicolinc@nvidia.com>; Michael Shavit <mshavit@google.com>; Vasant
> Hegde <vasant.hegde@amd.com>
> Subject: Re: [PATCH v8 0/5] Share sva domains with all devices bound to a
> mm
>=20
> On Tue, Oct 17, 2023 at 08:47:57AM +0800, Tina Zhang wrote:
> > This series is to share sva(shared virtual addressing) domains with
> > all devices bound to one mm.
> >
> > Problem
> > -------
> > In the current iommu core code, sva domain is allocated per IOMMU
> > group, when device driver is binding a process address space to a
> > device (which is handled in iommu_sva_bind_device()). If one than more
> > device is bound to the same process address space, there must be more
> > than one sva domain instance, with each device having one. In other
> > words, the sva domain doesn't share between those devices bound to the
> > same process address space, and that leads to two problems:
> > 1) device driver has to duplicate sva domains with enqcmd, as those
> > sva domains have the same PASID and are relevant to one virtual address
> space.
> > This makes the sva domain handling complex in device drivers.
> > 2) IOMMU driver cannot get sufficient info of the IOMMUs that have
> > devices behind them bound to the same virtual address space, when
> > handling mmu_notifier_ops callbacks. As a result, IOMMU IOTLB
> > invalidation is performed per device instead of per IOMMU, and that
> > may lead to superfluous IOTLB invalidation issue, especially in a
> > virtualization environment where all devices may be behind one virtual
> IOMMU.
> >
> > Solution
> > --------
> > This patch-set tries to fix those two problems by allowing sharing sva
> > domains with all devices bound to a mm. To achieve this, a new
> > structure pointer is introduced to mm to replace the old PASID field,
> > which can keep the info of PASID as well as the corresponding shared sv=
a
> domains.
> > Besides, function iommu_sva_bind_device() is updated to ensure a new
> > sva domain can only be allocated when the old ones cannot work for the
> IOMMU.
> > With these changes, a device driver can expect one sva domain could
> > work for per PASID instance(e.g., enqcmd PASID instance), and
> > therefore may get rid of handling sva domain duplication. Besides,
> > IOMMU driver (e.g., intel vt-d driver) can get sufficient info (e.g.,
> > the info of the IOMMUs having their devices bound to one virtual
> > address space) when handling mmu_notifier_ops callbacks, to remove the
> redundant IOTLB invalidations.
> >
> > Arguably there shouldn't be more than one sva_domain with the same
> > PASID, and in any sane configuration there should be only 1 type of
> > IOMMU driver that needs only 1 SVA domain. However, in reality, IOMMUs
> > on one platform may not be identical to each other. Thus, attaching a
> > sva domain that has been successfully bound to device A behind a IOMMU
> > A, to device B behind IOMMU B may get failed due to the difference
> > between IOMMU A and IOMMU B. In this case, a new sva domain with the
> > same PASID needs to be allocated to work with IOMMU B. That's why we
> > need a list to keep sva domains of one PASID. For the platform where
> > IOMMUs are compatible to each other, there should be one sva domain in
> the list.
> >
> > v8:
> >  - CC more people
> >  - CC iommu@lists.linux.dev mailing list.
> >    When sending version 7, some issue happened in my CC list and that
> caused
> >    version 7 wasn't sent to iommu@lists.linux.dev.
> >  - Rebase to v6.6-rc6 and make a few format changes.
>=20
> You should based it on Joerg's tree so he can take it without conflcits.
>=20
> The conflicts are trivial though (Take Michael's version and switch
> mm->pasid with mm_get_enqcmd_pasid(mm))
>=20
> It looks fine, please lets get it in this cycle, the ARM and AMD SVA seri=
es
> depend on it.
The V9 will be based on the next branch of Joerg's tree.

Like Baolu mentioned, besides ARM and AMD SVA series, we also have a VT-d s=
eries waiting for it.

Regards,
-Tina
>=20
> Jason

