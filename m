Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2757BB05E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 04:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjJFCyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:54:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3346D6;
        Thu,  5 Oct 2023 19:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLPUP/85UEQZEehh9yO//ePqM73cdXa+5Xc7oY0CRa+c6myp7wyoT2teF7NXv14j8ogQz07m/5fAUS0QRSlNQqR0klrlQwrRI5XVnkwSBwUmi0h7qjbKthCvryNfbnPGpdjNV7nyL34GmCEunPf2po6FQJQKDm2CYLeb5tbLW1H7U5CqCJkwnti2YSgsmOPcVNr8CzCC7h1MIqgueYcGRWkVABu9RlUU012eKjQfSxUnJi4UQxO/D2Zo6WGaqLPhNjU8lsCtqKKY2yafKqcJmUoteM5JfxE/BmnkEmNx3G1HLaR8EDNLRWNtgmly+cr1hoTrdwLTCTwUexur/i1YNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R2jpvhhNDjQimRPibyeob6fSEVthLL0sUItRIid7tE=;
 b=hC5nbcErQtLIhgD00h5C5bBgMPX4NZWwHxW42Msp1P9JuigH3o3tPdSgb+OgMc7GthZs8wV0nlDzEKl94RbqGFNmhisyBAIyRJ+cVfPxE6mdFyu7MwP8J2o1LM3veEFLjv1mFalMuWzNLMsLuIjqumnkFM5eRryvSD9xHoTq5Mt5UgeUweLJPgb8vZaRpYXIU3iP3p7kmjy1Vd0h9ldSlREHOFaWUxyRpzEMbtQne92JKV8jToY6hj+s52Ws70FHqi5/2QP/SKMyw0oXuNpAIw1BJu3iv31OSwiED1ShCet5Th3pGLayzjOh+uX9bfnign+l21XGQzkp+FuuLJyvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R2jpvhhNDjQimRPibyeob6fSEVthLL0sUItRIid7tE=;
 b=YW1vNEFax1ZEyoGytxKmGz6hTN5uvObENs8PC3Rb2PMaQY6IrSPZQcAWxsMblleBpO9PpwbFNWhmlj+QJf0c1COhyDtvZaaXS6fTfuEOYtPYxNH/OTIiicNm9XYB7V9ICu7T7yds2VPiJASfSTO7+LLyUhZCDOIRPsn2HRvS4dw=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Fri, 6 Oct
 2023 02:54:04 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 02:54:02 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Thread-Topic: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Thread-Index: AQHZ9ck4D6pW8hQcKkquQ33NBhhYBbA8FNXg
Date:   Fri, 6 Oct 2023 02:54:02 +0000
Message-ID: <MN0PR12MB595373EEE62FDFD58025B93EB7C9A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
In-Reply-To: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: 12252da9-5d8c-42b1-92de-08dbc6177f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/mwLYRzJrygqMbUP7wYITw6OG7tqSiUW6/pJAUinQA33qv9xnL3IRrBLyuEza4kNJ0AbieGbqwQaaI8RIyZFMtoaC6U58ME7JETtx7IcW2L3QKTZxWk9SfCRk6koCZsxZMz2+g0s36dpE0ErPEy+k+EeT/+kagpagglkTbwAOKVH7htAHG9h0PGzer+o+XBtcHCD7uSCChhsu7jNEFI5VF6CmSAR5loewoUF36wnwUkyBRW4EEunsJhyovIErGTqdo7SuiKF+Ix0Jgc8WC205AS5o5e59X1zvISImJbL7+4310IpbIvS04Q6kAFmtIWGh6bNL16qYJLIwWuT2A3lWv0hVwejmwwNZ+Ri26gO4YpY/SCwAem/5rA0dwhj9dofpfRqkYkz4i+2Efm4hqUBl0JB2VqhJ7tTn9W29T+RXlX4ErC+sOlLpR73d2m025/Um2agLlFM6i3u956ddu5e2O2+ShwVRC2CKRhPIk1mPEgoEw9TiU/PsQIszkl7EIGBEq/ub8bUUfewxfKGSdb8i+85L3iVXr6+2wxyBCDQ2ghohJL8+zxplR3kd/XH7dTM4OsJy4yPAUYWp8vZnYGm0Gmk4ZKBUPB07EGacex65Mbgo3jJ0xSU0UMmFhnWyucYLVrIW5pY+RLQv3MY/v3Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(52536014)(6636002)(110136005)(2906002)(64756008)(8676002)(66476007)(8936002)(71200400001)(66446008)(66946007)(76116006)(66556008)(5660300002)(316002)(41300700001)(478600001)(122000001)(26005)(9686003)(55016003)(83380400001)(6506007)(921005)(7696005)(53546011)(33656002)(86362001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GG/CGYCTr5R64f8ZbvsKWTKdxk7V1Zkj3lkCwxvSEo0XlD3u4iRP7/8prE8C?=
 =?us-ascii?Q?EedjYVCNMohRhlIKFgF+bxggvl1Xz0MuphJr84GmDQBKYeaPxsM/jp7Snwp6?=
 =?us-ascii?Q?5ZnR8UNM8S1nNspES4G9k4phYd73QM7mRPA9wIcmfqMQl0Sn0GqW30hH2POa?=
 =?us-ascii?Q?D5h6pmRn8TpTf4F6ytD1jLtS3l7HH7Ue51iJWyjUw6lNxMwBWML/8dbYJkRx?=
 =?us-ascii?Q?rHwg2c0fWbT8i+cVUKEuG80I6YGqXrVtAA+h9uJCJ6QQnrCtf1dfGzxbAwnr?=
 =?us-ascii?Q?zRRo9jv1fs+ucCATNtmMeG2CCdi4JRd7cAdH+iHroQI6vvaLk79qTcQCOIEk?=
 =?us-ascii?Q?PXh48TWPTaKdkiANdHcBYS9TKXfJjhPSGLNZYTmxrDHexVSe1dfRzg/ugtCS?=
 =?us-ascii?Q?iXPMhuUCpRwKh1Ejz7j2geaoCBPyg5wxXHdxaZ2Hm3++bjuTlaztWQsz4VhI?=
 =?us-ascii?Q?qncQy4JaX7BWhkZPWJA7Zd86R1CQQ8azXpuEGy0K3fuOBvZv2eawQDB4fBWy?=
 =?us-ascii?Q?RawwFK57sO1y0wKaYTQQBL0Rke7tyhPn8XsibbiNNa3CS5VPtNKAzeZxVWeg?=
 =?us-ascii?Q?fRGnqKNfy6OvU+7hTCa14Y0JHHIee5ZJ2Xl3qY9IJye7Dg+hB/zQly5wxtZA?=
 =?us-ascii?Q?/GnEMZ3PGMBT+pFs6oUnhPlbIDMcD6837kT2MMk4D7e2bS/EnwDNFC+VsRIq?=
 =?us-ascii?Q?yYKMijZV+JCMnNC3EUV7Se+SZ6g80AptyfCWldTOUpFMN0U0EQ1rq0dA7MNF?=
 =?us-ascii?Q?4OJWRkrSZqPT+O/ifcD/SXXP9JLOZmpOjZKKVZQLLuKUQrGfEosE74NwyKwB?=
 =?us-ascii?Q?BWtPyuGYD0ooaBpCMhJRKDAyyH+CTQyKw/DCXJsVxn88L/N7jDTKQuBqT4XF?=
 =?us-ascii?Q?E6DBF0E0lyY0idou0XaukL+xBVHzhjUg2kE/0AkvPNQSVuvEt6DE7eCmSmw6?=
 =?us-ascii?Q?gPcgF4A0OhHnf14ar3aEGI8elffXiK7DmVX5Kxw/8boKnIm5z0bXMTV3hx7m?=
 =?us-ascii?Q?Yjeo0VLYsUi8qCcCkRpgI6L4eadEtsD5G9lpihWvIKX6XCN6Ek6fvNH6H5my?=
 =?us-ascii?Q?Z3f1OxCbwXiYRGMkVlfKic+zOW9qlPOUT46V3zyQwMBU0Fb3hFFhmo+fOxRW?=
 =?us-ascii?Q?yyjP6dO5zN7oGdfSzdYYuGt+pYqsq7Q4I2mzafJt1Vde6RIG4ypt2cl5UFqk?=
 =?us-ascii?Q?UsD75IARIY2bfvOfT8Hfttb7auACv68ctS7dhtclmAIuZgrmZPvqo9nGtddX?=
 =?us-ascii?Q?P6IHkX2NfwJUsaICrQRIyES9brK79wQu2xukhmM+JjQGjy7ibAwE/ICwOuLw?=
 =?us-ascii?Q?1xu4aH05imqIIFEq3UCfGaODyDErV4GZnJdeE3N8SkV1LkroFDfQIlm/H2gK?=
 =?us-ascii?Q?M6e6KPg7pibso/36uYJXhxh/+PP+GPbO+Hw7pJYU25fxta/JPb4zZQ9Uurn9?=
 =?us-ascii?Q?3qcbTT7hRiZvcZvJJ988VtZfGA8ZriIGYFcdydPaC8Jb71zfCmZshXBi7uFY?=
 =?us-ascii?Q?lAKVLQ9JyqNCHPJ7gkonQf3d/TxYiiSNw3TdZsavgd5vVw2qfdErQ+Q6V7nH?=
 =?us-ascii?Q?hmB4y3q+80PP+zroMR8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12252da9-5d8c-42b1-92de-08dbc6177f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 02:54:02.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFB5F3bBnvWsm9jp4RuaUD9WaUFAwGCY4b0WV5kgXGk10MI/5wNJT/0Anp56Y7Sm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Sent: Tuesday, October 3, 2023 12:44 PM
> To: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> trix@redhat.com; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Subject: [PATCH] fpga: versal: Add support for 44-bit DMA operations
>=20
> The existing implementation support only 32-bit DMA operation.
> So, it fails to load the bitstream for the high DDR designs(Beyond 4GB).
> To fix this issue update the DMA mask handling logic to support 44-bit DM=
A
> operations.
>=20
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
As I reviewed it on internal list - adding my reviewed tag here as well.
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>  drivers/fpga/versal-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c inde=
x
> e1601b3a345b..3710e8f01be2 100644
> --- a/drivers/fpga/versal-fpga.c
> +++ b/drivers/fpga/versal-fpga.c
> @@ -48,7 +48,7 @@ static int versal_fpga_probe(struct platform_device
> *pdev)
>  	struct fpga_manager *mgr;
>  	int ret;
>=20
> -	ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
> +	ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(44));
>  	if (ret < 0) {
>  		dev_err(dev, "no usable DMA configuration\n");
>  		return ret;
> --
> 2.25.1

