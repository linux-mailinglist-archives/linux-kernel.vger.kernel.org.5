Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2E7785F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHKDSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKDSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:18:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18662D6D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691723926; x=1723259926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TUg5ADLRiwYppVbjM8CmywzygOOAGarXUvmtPz8lb4o=;
  b=XFwkbphwugzwDBbxE68vk9i6dE3+Je6Kx0nWoUkEUw8c00+z9fJ8scDD
   xknYnv1V0C5dA2GFWkWF7OopPFeB0cUaam3sRt+keRStSdvWoCPj4KXHK
   pdu2fMutGWbV1Ct0dXM7JpgGeezo93Zzjzdc4H2T23S3rbVxtyF3dArky
   HcBaV7FUEqgniNRRpzQ9wPHXNFZnVipnTALQX9FAcGf1mbbXdWIVYsCPW
   oQLjFRnlKkvVbHNKYdD/7cuVUOCGiFv55v/MEbNWt/t7fMmhDVHpGwS6A
   RZitLtIJsb0qTFLaT+VFLS3DZXFBhEQzKZZKsQpNeG2tUsVOeNTasmffv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371588595"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="371588595"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876001002"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2023 20:18:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 20:18:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 20:18:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 20:18:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 20:18:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9ZcipJsA2W0g2ZW9hvR7psrRhsfF/W/pFpu2ikcBv3jQzWlTAqQY9cp2sgXdSUKZcBNi61sbtnAi7Y5e9ls69euvTyiBefFBy2mnL2EqBJ1bCzFk5Wl488LzoWUzx7csLeXlZx8FlYW/5bNfQP+EuzbK/tXCPvDmQ0AdQKreS2PfZ0hUtoBI3mbhpkDrSqEoyJ5i4QorLWli4FnJ3wabRkEsl84qM8dt37gdI5Ly79Q9kCC8UEV6UE7TH4e54wXwZSeZ5T3PYTV4XFlZQvk42m5m9daUohTCdhaUcVZ5+Nmt8jx2OCxLBsuMNytYAWkDZkbzsCTqeCAuSQ29yIe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUg5ADLRiwYppVbjM8CmywzygOOAGarXUvmtPz8lb4o=;
 b=ZhDFkE4/j5Z8G0nia50qOEhPMKEymrKUBL9mv/K1C39TNzgVlFwmetXeMAvPWPatpRbGVrEuIDL9sbQwExsbq/mXF2Gnc+VJDhq18Q7a4ZGWrWeULt3o55vZ44RwxWLdb8VNo7BDC6pUH4ymeRQiRI4toexQpgJS0KV4nvaau8XTcbtZhTVh7Q1AOHnXCrZE1Qa11VbGk1rIx/gvZqhYryGGrn7uvtqXcjjVqr3xhkDfRQteWNeQdKoa/XnEvBsteMxQOwhpll/ZtZVM77DE4H6MtKYyZZErwzKUrD740djlKmDYZLCoswhFGJ6oS5YGnO2eeoJPvAAKFx4uuvdW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 03:18:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 03:18:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Thread-Topic: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Thread-Index: AQHZyczxCRfFMGhSVk2JCjxjKYlmLq/hG1GAgACeSCCAAC6iAIABQplwgACTOACAALMLgA==
Date:   Fri, 11 Aug 2023 03:18:40 +0000
Message-ID: <BN9PR11MB52762D093310D12FE5E5C76D8C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNOH9lPdTnltb9JZ@ziepe.ca>
 <BN9PR11MB5276A5E619DF6638677DFFA58C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUSEiXTYbV7ML6x@ziepe.ca>
In-Reply-To: <ZNUSEiXTYbV7ML6x@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: 7cafaf41-d325-4061-091f-08db9a19a94d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgoh8T9vxGDh3bSztxX32fCCXsK7KdEzJPHrMsLHk/Tg49R4wk0zIY5lyNf02PpRh5+ehSSsqIMxbxFXWkz9K2BpQ7nhH7yLoWapV/CSkeCsBLnjESiBD0l4OOjrXYZL1hUkA/rCpdn+JrwqXdkWBH0KiGQ4LeydESIUKsctvVTXcwCPOEKFDHs+nR44F29L9Ruh9T6Yv6BlMBNRJPU8s3CpolOMje8j/Mgbz5hFWriUBwq+9w6y0kF0SQzc3BPfXj04CiQ5ktQkozwCbE7DgMHEnkPWWN1zBM1wwmAVFlrmn30Q4C/QBeCmQRFh+awiKkDS2KjqrDyVaBcxlfyeoV28B7Iv783OcbpemptEuxlIMoLj+Z2epy3o+8LnTKOLhc9kxmoN9GTi6NQ+8TBAya6MVMM5mlaa31kI1aBmpIte3R7e7F0154sNNv7B1Pnd6idcRjaSg0DnsC1LOdySvm6Pf0yrxC3fKRcqlzQUhfnWzOaKIu2gtY4KlPZytGNSCuW/jU5gEIWnDllT3+3LS4AcWyQXCjfq2vSJbRcTb7CiD/1PbqGmUhkIffYt6Gn9VyfDc6ZygC1FnvJYN3kC0dHWGR1U7F2dkAQq7kbF0PFUHVV3pSNJIWScVZSfjnB/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(186006)(1800799006)(2906002)(5660300002)(8936002)(8676002)(52536014)(316002)(41300700001)(6916009)(4326008)(76116006)(66476007)(66556008)(66446008)(66946007)(64756008)(71200400001)(478600001)(7696005)(9686003)(54906003)(55016003)(33656002)(26005)(6506007)(38100700002)(122000001)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?86z2zc3beYo2Oimsz5795LnRim+cS/KiRIGE1CdZueciwAIrsXHQ0AII5eMl?=
 =?us-ascii?Q?yXI4XSKlrySmFu/rKvdcBa0sYPFQADNYtvy/cyXsNVmadUTols5A+28vZRuo?=
 =?us-ascii?Q?/fhxJe+5+HaqAv/+mmxc5FkDAZNQfOwO3rUk1YcxEGi6KVgXGLkflAdEDjFh?=
 =?us-ascii?Q?Efrh/SRL5DiPNhHD3sxUsp4D1aX9PeDynor2UudoWsWyTK/LphZxk8d1q0XG?=
 =?us-ascii?Q?N/neZZHHhVrzrjiYgKPmURnlfyNy9L3KsKylcjTVKSotCzD2+LSl9tF/pU3I?=
 =?us-ascii?Q?OP34W1wUXNsiqeYHRvuLP4tgjU1V207Fl8LgnG3lkfh6zFx6MffR4ULR0RDR?=
 =?us-ascii?Q?4vwkoi+n6N7m1KCSZNNkcRWi7DL7+/MHTrKtzIfwGAROKkxN2jU6XY3IPkPR?=
 =?us-ascii?Q?zUoqBM6BdpinXYSX4mr/kNSD3YMfDtnemNnlPzn1jATr4PLOWoGyXS6FTaNQ?=
 =?us-ascii?Q?yJeCpeAgq2jsNsTwlZAmUDUFuFsFL6E3XcBPPvQqjJ3K58sE4cQu4K3ZLLji?=
 =?us-ascii?Q?BaAf8ZEyxfxXIGTygnfYqOcUvtKAVNzGUvSJehv/EkL6+5kR5W4dyM8GJ+qP?=
 =?us-ascii?Q?Nigezf+CrlPdQPw2xUfBbWnIFZ6q9odJlJ7meufZ6lzvcFoZM9Z+mSodLeWe?=
 =?us-ascii?Q?Y5kwFkvCC9fb8FsTM9K6N6haulUuRMpTNmbAIf6LOWB8fla0rLqKPGENfsXF?=
 =?us-ascii?Q?hSQV/rl0Hb4mq3TmBJCKNTWiE0HxW/Br/BEMboCG7Bj+q5cHi5Tsm7y/wIea?=
 =?us-ascii?Q?Amny4POAwjwr9QZIBbUj63g6cy0CSD4KNvh7jti3A0aM0SH+0YsWAyPtwND2?=
 =?us-ascii?Q?aX6dcHG6UFJDoVfTkkZEAYJt9tL/y2C60LifB8340EWFLHaLDupiHICrNYrW?=
 =?us-ascii?Q?m0fFj/aJISeyL8SxTUKzn2FNfFckHHyGdMKe8F98CFIv9Cy1uQji8GXOCWPn?=
 =?us-ascii?Q?JMDqj6nTg9ZNDCe3AEsmnne+2mSC7S62BXreVW8xZHfhX7AhlsKNtz8M1eVM?=
 =?us-ascii?Q?A1bMB1kAD+D5KiX1Q+hSKgS3sZ8iWQm664ly5v8NMWIMcjTIV9Lki26wrlSV?=
 =?us-ascii?Q?FJ9yMOWWfwNzaIMgBHf8DfHgf/5+btVAr110q67zvJEX6zVVDFzor7wF+uy5?=
 =?us-ascii?Q?3MXAeTi0og6h76/WHGLECXWU9bZQf4zp0hhqTOspfO8V/W9KFOpBPOjPYN2E?=
 =?us-ascii?Q?Xx0REdDX3oSWy+JvbOQsqjkdWHgRgizVeN1AQfTMs8EJJ+F/ukqUbeon3kNx?=
 =?us-ascii?Q?jT4Sw6WDNsnhUI7Q+ERo7YYVRCMcWrrKtW9LT0SveTx1tLxVetY0XU/QYFjS?=
 =?us-ascii?Q?Nl1RFojmtAboUduhtvALf+LHTzitYGSsRC1iQ8tnF01oXHwqugiUGB8cwuQe?=
 =?us-ascii?Q?l+bM2SW/Fk5p0nDI58nMyQiz0sOZmk0/KtKKOIOXWhPXy6ZtHLgW0hCJOZaV?=
 =?us-ascii?Q?FaaFYkupLgZSlttnuIZ7MwvrUV6BYYGvmUtew6uQwxrbsxMXIseQvPAZE4kQ?=
 =?us-ascii?Q?9hXOycFErFLIQYgw7B8ukpbKJZarV3/v2vRRvNAFrbvysbnitqwc52bypFwm?=
 =?us-ascii?Q?ZcRZm+neSGojhQlzTPb6OhK8SW1zUTCYar1uMo0i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cafaf41-d325-4061-091f-08db9a19a94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 03:18:40.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImI/4ffFNX798bjuQtHHoNOVkzWaIl9BNfOTVwos4L1gqa7/2tTRFyyGrnxpRe6DmIFpQiYjAfbc94ZswTyTxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, August 11, 2023 12:37 AM
>=20
> On Thu, Aug 10, 2023 at 07:52:52AM +0000, Tian, Kevin wrote:
>=20
> > > The driver should rely on there being exactly one iommu_domain for SV=
A
> > > per mm so it can hang the mm_notifier off the iommu_domain
> >
> > I'm confused. Isn't this series trying to allow multiple domains per mm=
?
>=20
> It is doing both.
>=20
> The main objective is to allow de-duplicating the SVA domains in the
> core code. The driver should be able to assume one SVA domain per
> instance, or even one SVA domain per compatible instance. The driver
> should not do any de-duplication.
>=20
> But we can't just store a single iommu_domain in the mm_struct - we
> have the same problem as iommufd and we need to create more domains if
> the domains we already have are incompatible with the device.
>=20
> Arguably this should not happen, and in any sane configuration we
> should have only 1 type of IOMMU driver that needs only 1 SVA domain.
>=20
> But right now things like SMMUv3 have problems crossing domains across
> instances, so we could have one SVA domain per IOMMU instance until
> that is fixed.
>=20

Thanks for the explanation. Tina, please include this information in your
next version so others can easily understand the motivation of introducing
multiple sva domains per mm.
