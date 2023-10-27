Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3A7D9342
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjJ0JO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0JOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:14:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E697187
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698398063; x=1729934063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aeVFBN72jUygqggykQIX+m/7BF2uiNKPzvaiQqBM7Fg=;
  b=PofFBkC2gfHk+wwaZFvKzoXIZBRKUYfYayqvuAbaGGdQ4n+ejkk2gc6+
   1o7r85/I1X421F1njnLDVaK04b6ZvDo140xjQRXAQ4dOWG9muZ8poZrBC
   C9cXbNhJCMuiYmBoKzYI4mORs/rgiV0h1ca5yi3In1p2LDF3XpHqv5xEe
   K1Ndk8/LUWOdvHE5uoTH0gXkOhLp/aJzTuDIZA9ZL8OF09ASnZX83bTFO
   L+fSlFhmWZ77fawlSf69/Mc8Ndtmk39gMpxv7X27ktM0x4cDGkWGVEG5x
   4ucU+4nDK7T9UNmYOPBL3z5dKB1h66D3IE8ElAicptiqCwGrDAZjcxH0c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451979074"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="451979074"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 02:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="751121"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 02:13:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 02:14:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 02:14:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 02:14:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 02:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhTtNUxoldA/1YjlSvvsEGvLmSironXsmvNPJMOAuW5862EZN5iG/7dpja+hCvIpZ2EWFDQFAiqAaMDX7vN2X2WHlk9D4ntR+z/EINRGi9yqzpat0SFV9KXVVwk6XZcCNYeeQP5YbTSn1DBSZofR4JxOzOwBjT3uIZwNZarm0RESl6ygNhRXmjmN6IMeAn84bMCY7hcU6AYwKigWuzeauJTpjuNCYhQrGLynOMyDX+AwFG2olKDuWKbHhGKgNTvXnHgQVZKYzsXOp43TqpwfLYigXFSNBLmZMwxKxPWysHX4FD15GW9AYadnlddfQwpxg09MY1Dpely0c2tG9HhuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeVFBN72jUygqggykQIX+m/7BF2uiNKPzvaiQqBM7Fg=;
 b=DVS8m5I3eTuS2O3CvHEIsQ5jrr4QYnN/bNlP80ZBOKXmUTF+YGEtM4bytdlCMLrVw32hCI0V/aiI/nuxa/v1wCbGg1C8aIr0cCBSVrTuijCaJXaH4erLBaJaG2oJDebbVPJ6PxvwQf/rCwNvB4MrG6M+E8un8678l7tUjP78Qsl+7DVb3VcYFQ/Pp23AGpJwHsNyg6YwwOa6C+aUrJFL/T6v60RcbMeZwEy/oCjEWvpqVYFCZEXhPY0lt2AFFHmKAEo9GYQVBrxy+y/icQ4qFZZMMZupPzs/gKGf2dOiP6i5zY9MhrnPaWRBAVHBqnhXeZaz2OBrUCF1/M34MUbAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 09:14:17 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::9d29:3f63:cecc:9102]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::9d29:3f63:cecc:9102%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 09:14:17 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Thread-Topic: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Thread-Index: AQHaCGlk1cvAoUzubk6PoTMGEq8RvbBdOPMAgAACSlCAAB3GIA==
Date:   Fri, 27 Oct 2023 09:14:17 +0000
Message-ID: <MW5PR11MB5881463F11D86198291EB52989DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-2-tina.zhang@intel.com> <ZTtixEgSkBI-TRro@8bytes.org>
 <MW5PR11MB5881E07803D25E3588FFABB789DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5881E07803D25E3588FFABB789DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA1PR11MB5780:EE_
x-ms-office365-filtering-correlation-id: c77cee18-5359-44a6-3d90-08dbd6cd18a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHquVHwJvHSThZMFe3idapKKIbEp0WF3xz8Fk0wR4NqBmEBHx5oqcVdsS4oS2G1w6oJFuaekvMzp0PiUi8hCiaQPYuZTBU0ZJIVgXKOR7cQBkneyzFQGWBtpufDCIQLNrvh0Iq9kWOq+NLdS8d3G4MiNB4vm7tXFBOrPxdEib226K/0IoQIYm5h+0BI+0dTK4dNza9hCcvCQs8YCMGGNMXCbSHb+QlkAEQ1iOKlQV64gFLeuUc/xFunoof0PKrvulT6hIt4s4Xs/SRGdROn2KN2zG8vFClch3uIR7vAe4C7nR5Y6TjWK/Gf2od6VxmCldKHnpUDQMkD++Fb4f6/WpivsTsoFooP3rwiuYf4PbfBM0Iem+fbvVSd2uCqn3JKE9q7v07Doqb+6+x0rkL0FmqOEOTzrOfb4sI7TtjlJ9+uobH7Gd+7XmoPMuKaktfzKFsKwUnWvy2XoiKh96ePUsySiuOa1U/iSBnJwvZn9C6vdXfm1WNWhGaPsX7amUlejKezzSBsd4BCshbuyqwO8YA/OuvUUuh6ipMKj5/p1yat/EPB6gaQr+35KzbT/WKEoNxtC3n+6O6CHm9Nqq3NaKcoxC7WmcO0edeEnwkEtFVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(66476007)(2906002)(86362001)(38100700002)(41300700001)(64756008)(54906003)(122000001)(66446008)(2940100002)(76116006)(478600001)(71200400001)(7696005)(6506007)(66946007)(316002)(6916009)(66556008)(9686003)(53546011)(83380400001)(966005)(82960400001)(33656002)(52536014)(5660300002)(4326008)(8676002)(7416002)(8936002)(38070700009)(26005)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pHF7P9BDehHzdybyb30ziINNpy9LDGpzs2I0vw/SP8ICKPPgtdwjBu+qhTJx?=
 =?us-ascii?Q?BI4XCqXOGjwWOO4oXYF+i9FLpqNs1VF01KwMG+YNWSvfwIb5oCd4nfbfhEK+?=
 =?us-ascii?Q?kSQM4Jn0Fanh8UDwDawOT+FuXlxYtg/vamsMkdjyotmvQ+D12VTCoUaVhjrj?=
 =?us-ascii?Q?GPe+Ta69fEVKX9csM7FCH/06te07aynOIXYusjJ92umakOLUmeR5gPq+SACR?=
 =?us-ascii?Q?h5+3+oaOIM/c/j2dDPD9iVnXblawprnBqiiGVRF+1etkaq/nFYYw8PNKVfAx?=
 =?us-ascii?Q?XpFo3mocpD1OduphLRhNHdfymTmF0ruLgjFduiALpuN62SK4l//bdiSEhT5w?=
 =?us-ascii?Q?x0zqxd24V9kaEOMGRMvhlyHDBOU0xn7AQVMEkDlvaqEsI32BpFV5lf2o45JX?=
 =?us-ascii?Q?rc7ylquqpmKlTwIEiI0JUnBD2UTCllgV27zRXFgyFXCDnoWrxkf+00sVIXdd?=
 =?us-ascii?Q?y2C6SB4ps8W9OqcrDmBsodxZagVDUzxKBKMXmfvQKrlfvbMZQR/rYO4RqWhy?=
 =?us-ascii?Q?U25F0KLHH6MEOmXdDI/WaYtOCsIbTHxi18Qv5GpikHNsBqKplXEyGr3pGRFu?=
 =?us-ascii?Q?a/ecDJM0WXcHTyNwnoqvEK2Vvf1UxCcIRwON+ZzvhyEnm2PUnq8OYE831GE5?=
 =?us-ascii?Q?kgy/l2Ida9ilwUq/UtREpz5OpmiV/tWtVLanEUbQvX8fLoPXL+j1E2J0dZYD?=
 =?us-ascii?Q?S6NaEKrYKy6MS82tRu9XiMIodlG3dGA1WhOnb+bKWbKkmJ9FHnPdyfm0DQAf?=
 =?us-ascii?Q?p9CwOWep5qQguNvtc/iPRPDOqC5GBsXPR6716Uhg+9Buj37IrshchA7jGidZ?=
 =?us-ascii?Q?q5jEPcBT4c4K7kPxweKl4I0z10y+2OeOO7yMA10WcJELeNqoVkthPBWKsWDk?=
 =?us-ascii?Q?eMbmY5+89i7ZYu8e+9XC71E9LGZ/Tyvmkq7wld1nDR8E7jdwDkRGPaCn/WlN?=
 =?us-ascii?Q?T9O0jDZy3gZs98byuTcZZGc7iAJXau0s2LZy39lJAw1salfPelltRfI31pKe?=
 =?us-ascii?Q?JjOMy/SwUO+Q5yjmdbz8iGAwuZdbcPvXRLJ3zmf1CjJP2G0ruzY2Pj1Y0Fnh?=
 =?us-ascii?Q?abXEL1behLBf28/HairTZPv9ApEBkT5lWvRm1LNpjEclRLNjYkhXu+LXLenb?=
 =?us-ascii?Q?W46MCbPftqJEYhs4QhHMAmBCS7f+Vt5bcO3WNTGaw7bt0KovCvgzarvH4IAD?=
 =?us-ascii?Q?d9rxaCsp4Za/HSEMKlswsANqgb6SQmV5KTEPiHr4M/K1pKa9Wsl68lqE6VJI?=
 =?us-ascii?Q?TI1SafNlsho/ie0QV/qj6o45CGI26maYKb3HxuTPIeBQ06Tg4rBViHkubm4G?=
 =?us-ascii?Q?VKPToAPajsplodCwu8ZmprY7WMwvYNmRTAbAxmyHuqXEBT8+7CqKx+egCh7f?=
 =?us-ascii?Q?vofWMymYM0DiGf/d67Gitcu3ofP+QsYP2GqXdom8kMpIHIHiZJNu9wUnapyb?=
 =?us-ascii?Q?NTfKA++rt3ciBriJZug/b8BK8yxDSLiEEJQVrpuqMlFoWwA+fs9gF5f4Rkts?=
 =?us-ascii?Q?iQPu9A43OxzipG4cW3E6CZYXeZXGkTkPsR5FyWpyoHKr/l38qi55I9kB3QcS?=
 =?us-ascii?Q?XrHAeX7wBKmRODFn1dRXiQ+t1sTHAPn4NApzSy95?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77cee18-5359-44a6-3d90-08dbd6cd18a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 09:14:17.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dd8HPluB6GQ5Ca4GpbPYI25e1tUM7FkOBhkg0IDJd+oug8Bg09SpFv/7IBDk0xhfYji6oc2uqgDVuDsq3lU1fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
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

Hi Joerg and Jason,

> -----Original Message-----
> From: Zhang, Tina
> Sent: Friday, October 27, 2023 3:37 PM
> To: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; David Woodhouse
> <dwmw2@infradead.org>; Lu Baolu <baolu.lu@linux.intel.com>; Will Deacon
> <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; Jason
> Gunthorpe <jgg@ziepe.ca>; Tian, Kevin <kevin.tian@intel.com>; Nicolin Che=
n
> <nicolinc@nvidia.com>; Michael Shavit <mshavit@google.com>; Vasant
> Hegde <vasant.hegde@amd.com>; Jason Gunthorpe <jgg@nvidia.com>
> Subject: RE: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
>=20
> Hi Joerg,
>=20
> > -----Original Message-----
> > From: Joerg Roedel <joro@8bytes.org>
> > Sent: Friday, October 27, 2023 3:12 PM
> > To: Zhang, Tina <tina.zhang@intel.com>
> > Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; David
> > Woodhouse <dwmw2@infradead.org>; Lu Baolu
> <baolu.lu@linux.intel.com>;
> > Will Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
> > Jason Gunthorpe <jgg@ziepe.ca>; Tian, Kevin <kevin.tian@intel.com>;
> > Nicolin Chen <nicolinc@nvidia.com>; Michael Shavit
> > <mshavit@google.com>; Vasant Hegde <vasant.hegde@amd.com>; Jason
> > Gunthorpe <jgg@nvidia.com>
> > Subject: Re: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
> >
> > Hi Tina,
> >
> > On Fri, Oct 27, 2023 at 08:05:20AM +0800, Tina Zhang wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > >
> > > Linus suggested that the kconfig here is confusing:
> >
> > While this patch looks decent to me, you forgot to Cc Linus on it. In
> > general, given that it touches a couple of core files, I'd like to
> > wait for some more people to have a look at it and not rushing anything=
 in.
> Make sense. I'll CC Linus. Comments are welcome.
Can we separate this patch? I'm thinking about CC more people for review. A=
t least, we need to CC all the reviewers of https://lore.kernel.org/all/202=
30506133134.1492395-1-jacob.jun.pan@linux.intel.com/ to this patch. So, it =
seems more reasonable to separate this patch. What do you think?

Regards,
-Tina

