Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76BA7A78FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjITKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjITKSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:18:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48D1AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgdXUMQyGf7Lux7K4htciuyxMsh+zZhMn5kh3hDp6m1M6XnDKtIpnrJzgPTm2ZbJzoS6nOWCM/E0JeXFXuCorYUMv+dTrdRNfVl1iOG5g0yhQeHUEJa7lYP9XO7PVCHaIKIm53wqYW4m798vxiSWHvVuCUnWyh2yKTPhL+Dgw4inXjA1Ti3YF7tNSk60gnX+jJuJdbL6eLulM0Wyv3Nj2HFENdKRbpRSGInpj5CQvtfKSVN+tpL0KtZMbQV7ROCiE47EGeFlff3ziLMdBHEyUrCeilG0VyD02mnzNN29hCBK+W2DC3ngcytWFzsiSkYXWP4g8qyJf5l8FX2qhVijQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCTNBsCpZtjPX2Mm+WCQOweUJw01/xtDvdiZEnWubnQ=;
 b=PcOhUi/Z+vWIzaY1vA0P2Gk+CJA/pGv0xpmjWLy40vzo4MnM0d1P2WX1R2DESYxsIJC/fOshW/lyd9j3ewxGZmFBI4xtCQbttXidvsNZWE+bf5N4LTJxQrgOvavB+ppLMeNxY8RunXubNvrh7mncLMeF80fkZT4gHMX877k2OqhOM/R1fLypbohgVO2O2LLOQL3a1aVYJMWAVJ1Nd4fBzeMwTXk/r0YvUesFRUP3TJ4iqNMkhr5m4wpfBDeJM+Z1y2Idh8k7y6jTYlJF6B4W2nAcCbo0Oq32tCbdHbXNkGLMG0Mntt9jZiwUqsfcYDJV/QRpTKDGH6RHtSvHMTnQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCTNBsCpZtjPX2Mm+WCQOweUJw01/xtDvdiZEnWubnQ=;
 b=LNAkm+mN8A5T+iGVOt08BSeprN1GGDpXIFtbgPDxSPmwfGXrVI1BeDd656n3ko1xQ6ZI4Nv379MgIGgAq5pjGlyndVGeut91HxyChnrIgy0m3NCzTMAVkpwhxkFE5cVY0BluWQGLM2rYG8O81ED+D1moxUB8DMet/T1+FUwhn8fFZCaub2pkwN9CFrjJ7ZXG075yPeRbLykgS9P4NAAMhpE6mE7JvhiVdGjnzln24XImu4ijeYISND0HyLATuJmyu+4iCNP1zdbtkm0KXJ/otwl86GAh69V+N2rlrZ3MavznYgTMMvjvwssmWelbP8mys/bay9eLUWvxGwBPwJdTqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.36; Wed, 20 Sep 2023 10:17:52 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::705a:137:c5df:60e8]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::705a:137:c5df:60e8%6]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 10:17:52 +0000
Date:   Wed, 20 Sep 2023 12:17:46 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: map reserved memory as cacheable if device is
 coherent
Message-ID: <ZQrGyqQ7K96PFXQ1@orome>
References: <20230914125258.19640-1-laurentiu.tudor@nxp.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l5ynBMd9YR5I0Y9k"
Content-Disposition: inline
In-Reply-To: <20230914125258.19640-1-laurentiu.tudor@nxp.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.10 (2023-03-25)
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfd795b-e640-4205-038f-08dbb9c2d91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqtJUg1IpAqMu2o4XXdFiR6UZl1snuY5JaWT5ZQVNSe1Ih39p5dkecaqHFwbnV7G+43ABcJdeLoMlriw6YrW2/0NsV42IbiZkZ03jBi8iIiJNCjwNK1scDYAgQq0QIPpPmk4nB+nSkmzeKeLRtzEFvRMhozO6HQ1T4C84ajfdcr9oMc/t6AII4vh7SXrYgj7LDQIP777646nAwkmjoyftnGFHGUrERUDetj9Ht9924gKeh+MGYaDSUS4ZkSt0of+td2dOhw4/Z8H2JixNosOPRRP5n4DOMVwVwBBSxsu5eObtEaZKJBPiPTezj0Jno05yevJMv01nxerCCehQfGrvrqQQlo4s6tUhmI2cB2p2YTQd/yFgSxDFhjIfvAwVMZilFoeC0LHc8BgScOQ5j1NbMfwHMCQlNByMMRvK76oDVuqe+v9vWoL3rHAFWRxrWLMwdKHDhrSzk3UPR+Wa5zrhi0e2tfFflS9+2aIjBx3zQEhdSYCKu4/PUmphrg3wVZwzeuyFwUWwKbHjm+aQguE2Vq1nB1STzzkSlO+Uy2QFHRh5tnK0R1i8wJg9cC9EX8svrwlufXNuwK/ZP0kdWvJ+sImQUcv9sw5RBaOVgTmAoGWtHNU2crXj+PTHhpeM9s3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(38100700002)(6486002)(6506007)(44144004)(86362001)(21480400003)(478600001)(9686003)(6512007)(6666004)(2906002)(8676002)(4326008)(5660300002)(6916009)(8936002)(41300700001)(316002)(33716001)(66946007)(83380400001)(66556008)(66476007)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jF4FreU2NmKPxl53nDFXganDEHGSyYbk3Y2xiTCHfInE5U25oMITrj68Bvr?=
 =?us-ascii?Q?Vxo+hMQdvH575vNarb7JJpmpycr/fQ9LbeRuvpdqdlzCOSdNIYUQ4MxJldB4?=
 =?us-ascii?Q?Tu/uL51o5feAjrFp7LIH2SmP6EfJlKs6EBQKfXWX20ET8r/2nfYe3A0Z2sXi?=
 =?us-ascii?Q?o69e4SHJ/7LsJx1rDELRIKt090t3W+KUHy6M/kqmczwcdRCM4jIrc2vt4LIY?=
 =?us-ascii?Q?K6n17JOlbNGmhpMUaXUJHw0qjrxF+qiVqJLWVDccrjMoFEjoIrpEK+JzUzPw?=
 =?us-ascii?Q?5Dzg3eBQQlLEa2yEyjx3eYTaeS0QUP72ehHV64utOkANnH62jCVs8O3C9Ne1?=
 =?us-ascii?Q?LKN1FI0qjKldjurkdqNhudlmlQ44fZ7bMzhP53PfIiZmWsgb2PcLUJ6f4z8i?=
 =?us-ascii?Q?xKyZdS0Z6uGE865ZR45LQyoQY6LmXKqtCR2cMj5BdAxoH3aGyKRqNMZS1ZXr?=
 =?us-ascii?Q?ThWmdnu81cJ2UMLGKHwkZICbB3G4n+UTIRL4kBBlxgKbok1qgR13tqf2CrWf?=
 =?us-ascii?Q?ILJEYt3sBwXJa2N20Q1dZt5vhdN89X+r1F4zLsspeNNg6cG9xi6TV8qPctAv?=
 =?us-ascii?Q?pLtERkkMeusUPTNqLFOR9qz4F97pTm7Ty2eNg3JRZWIb+Go+VqSU0LO6oEfk?=
 =?us-ascii?Q?QSCenbjm6Zh2s8H85v/gylMIK0XNn+lMS/Hu7z1O6Wsx6v2x2OVTuIfmtNAY?=
 =?us-ascii?Q?ni+/NAqocLEKbFPOAiB0NWOONYb1OEVhgw0N1mBpNa8GAlzvdOe96kXVadpx?=
 =?us-ascii?Q?fNIUph6Cpglw3Vwdi5n4xycnJzcr3aI474ZwuozF3PEKTFEsxZ9yqtVAtrTC?=
 =?us-ascii?Q?Lab89Q5yJg5FeGukRQOCc9Pc8YLXoYPZ2VBzV1g4nINFP0VTYBaZw1QQcM3b?=
 =?us-ascii?Q?4GJe0dfbIhoed8NeTB1wYkVBuo4lQbSnakRv8jaJ08Kaa1FMglqvfalWWFRk?=
 =?us-ascii?Q?qYVx3GAQmN5I95TyC1EO4LaH+mx2mP16A+xdtFn75G+zMQkmamL2SQZTq2ZN?=
 =?us-ascii?Q?B1lvlCoKJ3GOSCuJW8fPxDxkUef1o9N8V4L7CC9IayaWe1AmlbnSk+OHhlUP?=
 =?us-ascii?Q?bv1gUl+oJqQEzcP0pXzDjVDYaVGbC92zKcjmLSkttgpLPWojxwXnVRAmYwrW?=
 =?us-ascii?Q?8+mpX2A5OsdAvAoBp/iMRmHh13FsDqnu94nXNKqR7W/XleOK1zPZvvw+8oCa?=
 =?us-ascii?Q?2waeaXZEIvGeSckpbRA3Tsbe0p5jnqpCEt55T3WULszcks9WINU9veCf/BMV?=
 =?us-ascii?Q?ZEhVQRV7QN5ZLhoPeHxI5Ty6v4uUWuqdhIgWYxFBgZUmPt2hjGxKfnTrZOOc?=
 =?us-ascii?Q?fMDdnMwEA8L4wVjj4wC2wgxdtwjoPptLoWp0sB6xKoPTlXmD+lqJ/fLKqEq9?=
 =?us-ascii?Q?3P6VXh++qw0FkzX/N32k42H5JTUCTLQKiE73wyt2Kvl11asnvEugAA8RPsuy?=
 =?us-ascii?Q?q473Pv4DTYT1rb8Sv0v9Oh5B6IdAKcKOMhALSToZnrlfUSJ3UQkvqiVwePK0?=
 =?us-ascii?Q?TsJiVR0O1ohVoq8hUhN0X5BdUWqLZVXdbnjaxMhv2T3KG136oUBI6uvjnJ59?=
 =?us-ascii?Q?YQo2gaO1n+jsGGacmaPaicrZ0Rk1IZTD/wZyZXlPHMzlYyflXCSyqNyZiS0n?=
 =?us-ascii?Q?sowzbBdhCoz5k5J7C7OzcHDiC+G9ec7FS2RC3U/XvqYS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfd795b-e640-4205-038f-08dbb9c2d91d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:17:52.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/fCsqlfFE9DoaPyAKWb14tZotlhQC1DMs0W8t4/jdpfHHNtyFmrzqoi0PouvwY+kQizvbvCpLNXCjWYK+5TcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--l5ynBMd9YR5I0Y9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 03:52:58PM +0300, Laurentiu Tudor wrote:
> Check if the device is marked as DMA coherent in the DT and if so,
> map its reserved memory as cacheable in the IOMMU.
> This fixes the recently added IOMMU reserved memory support which
> uses IOMMU_RESV_DIRECT without properly building the PROT for the
> mapping.
>=20
> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> Changes in v2:
>  - added Reviewed-by tag
>=20
>  drivers/iommu/of_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--l5ynBMd9YR5I0Y9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUKxsoACgkQ3SOs138+
s6E5Nw/7BYBpHpklVqYfz0op9mksacRAPuGUax0iogiYThKoFV/0VWg8chM1GyFC
xNnC6JcKc99NhAlQaz9HSY7haNGaJOcmSHzYzs7HSPycOEPj/0JgkNnQmlZfZUFv
2cdwYDsYCkIQCKGoyq63q/RF18rlftkMO99lz9X3gVSCbbn2k8A51llbCxt5V25U
XE/894KiVW1Yst+jUiwzmF7D5ePjp18Z+eDjxKN9ZeyP4f4KioAwe5YFKZvTSQ5P
0UY1kZFQUXiaVjP0Y5f9Bk8bmdhHJ2/Dpzax1CbaFIAp91NLRCHCMEodZ7yYwauM
Z7AjcRsvdfSvoXCi4wjOPmqLGLI14kFAc5PMT2sHQt2zTENydqoD5TabGdiKq7nX
vfqvMWyDQVkiLUZcJaxaxpzimmd5IsEKblFOor2VM6EYx6M0wk2xgFDsZWqJuRo6
HuiOpZC7BZ7kA1bvjGcPwJXjHlQWRiTr0R38VpRtUTjdEi1jZG+COvqjJP+Ghdqw
YUlIuOBf1R/b8NgmpI0ZV0EL1l6NrLX5zuo107J/Bpomc5VDmusofenHo3sS8/4A
5osFG4TurkcoR/MHyMQfcSmRuCz5Q+I7EVWAHhRsNjxMGIUz8yXp5ZDfIEncRh+1
K0Aqa3qJhZkVjDyOXhMILehIN9N+gHbVbk7hXH48B0q+Um1mlDM=
=xEFx
-----END PGP SIGNATURE-----

--l5ynBMd9YR5I0Y9k--
