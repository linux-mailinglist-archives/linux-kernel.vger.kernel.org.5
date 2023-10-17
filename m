Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CFC7CC1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbjJQLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:24:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDE9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPjMaNqxoPyN0dwWTqy9iyFkHpA6ZN7R7IErSQu8tbWbArUzPi/vyhMo8NLG+A9RgcvJYXOJ2mdu3OUfapXifZ/vT5q+VyNH0N1E4kS33ROQDYIH0ZocQhHtYZ2PqFrmBAMh0qdzPZ1UAwwWWVBuWdKZz0Ds2V2GyszEfPWSxMBNVhUgcHSWRaKzGxsrp/bNeD9gqHAJYpC1Oos8aAnF3JanDNc/r4R44n5OKmaddpbhfcqmTqNB5dNQEfceoQKk9P1202R6no0ZHUgtrmbzsez0f+pbs0J7WNd0sii3TcJuzTZymbPiwZCDSqbO+FJrXk5mXbDzxwTa7RfXD0w9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ox4oP6p7w6EH27hGV/bl+xW8mkwoKBfrLJH8zDSPeI=;
 b=DFC8nX9Fdf01HQu2Po8Z+laS9tBmNrD0ALT+1xr+cICPIsQASNbXxAjwDIHyH8aG16k4EsDkBURSU1v8J8BR+PVb5YuhdM54WCBwZSs1fZb+jZRA7fBCqh6SYiGs4oj06k8ImQltt9diUG65i8kzA0YPhyUvt5kztp2QNaarL3Vq839mls66PJaBkpgDKg/e/L60fV/lgOSSwLty42dnufWDQMRDye4sl5uDsx3do/IdP+tuAQGyUzd9IG2sogkM5KxCfMHJNPz/qxGxkR3vFOhBFFSPwKXvAwn+5XNniUn594YDzbMQwQdkt1VEAVrlAF38I0oAG/kMo9gl6JEfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ox4oP6p7w6EH27hGV/bl+xW8mkwoKBfrLJH8zDSPeI=;
 b=fpUXvGL1yfGXwnDyk+nOY7QtYxEdjAK+sSygRCOYTOdC6cqJSpjs8Z2MmkL9KTIplyoezyVh1SO2P/xQv7qw/u9k12ByBkwyiWoaAU/GcRRbvFDKsg9DrnLTycM6D4ec7GB38//+oJ///SIVHrb8WQuJhoatLy9nsN+awGrLhXo=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Tue, 17 Oct
 2023 11:24:34 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::6d3c:55ac:112d:537e]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::6d3c:55ac:112d:537e%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:24:33 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: RE: [PATCH v4] cdx: add MSI support for CDX bus
Thread-Topic: [PATCH v4] cdx: add MSI support for CDX bus
Thread-Index: AQHZ5Ld0MJVuHirK7E+yMAFiVI63j7A7ItEAgBLqy5A=
Date:   Tue, 17 Oct 2023 11:24:33 +0000
Message-ID: <DM4PR12MB7765E0AE903633FD575E1A518FD6A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
In-Reply-To: <2023100531-matron-oversold-4a73@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=4a10bf14-e978-42f8-a23f-0e8fe7dfc4a2;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-10-17T11:23:53Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|IA0PR12MB8280:EE_
x-ms-office365-filtering-correlation-id: 46a3198f-b126-4d03-50aa-08dbcf03a354
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/3MWziOZj3i3iznNTPadlpv7j5g+CCQ+PP6gVTOsO4pvjHfgyx8hnZXqG2FBLJR2vevStqXhYo/Zi5RIcHy//2lzAe1eL9JZ43tYtALSy3ly806KV2ax+lLTy5NtBc99U9GPpaUj0MJOT+JZPEoT1SSs/lWizS9PjhbccSu9l3ClswVpxJJf+NKeTcnZE1L9G9qn8ROSRvA+Thrv3UCcbaUmqTOvEqsX7RMvp+G2WW0PPtMZIo40XJMN7bnGDlhz8IBXYwExmAr2fFzE2hsK/X2usu4F775fsTgiBSBRAAm8T+byVay2HbQS84Ws7e0to7i2kCYgoEV/b/VL0iQGHPZ7Pb0n+vp24CkSW/+zYj7L76SLAEI0bUoHn1PpvFrf4grMbCiEGpW2KDgCV2mL+Z+emtF28EoEfxLdnNszMO0LzcxxMWR++bQbtD14OrShzh7BVUcJLnmrwcB48/nCm5IQj2ZDQoEGGa0kJKCjwi5dKkwbm8gv9bNK2dZvfDqXIGDuyld5imqW84pyyaxNzmL0L8VG6B2q21U8a/z1FsGfOBWaijA6Qiz15D1iVZ6PCCwG/lsZEbqE2UXJa+wxelH7z4qXyrxv1xQHBCjOCKmvQpPO2MlcBIGYl0p524L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(33656002)(55016003)(54906003)(66946007)(64756008)(76116006)(66446008)(66556008)(6916009)(9686003)(38100700002)(66476007)(38070700005)(122000001)(8936002)(71200400001)(316002)(83380400001)(6506007)(7696005)(8676002)(4326008)(478600001)(2906002)(5660300002)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HOf71twDyX58JPQHelYDCXq30k4KazEgCLv0qF2WjT4IIhqD+gNZ8e2D544C?=
 =?us-ascii?Q?KGBh8Aw3NgDDOgkTyLIatUfH2OMAx9O/A88J5yADVjVRIZoHKExbtdOO18nn?=
 =?us-ascii?Q?ZOyLGGrH4ZpHVfSy3zmxh/YW3qYZQfmkGMx14Lmpybcm5oE7nwzJHN0kdWHP?=
 =?us-ascii?Q?G9Og5L3aov2+cC+VQaqvHPks8pjkOrYXcZ8vD9H2cy7n5Y6sjQTCazGwZN5I?=
 =?us-ascii?Q?WJFdLzV6LTkaiK4yJMA8sfx7e29hF9OaKV2zuF/WuRE9/J/qHUBDSSZwlWxY?=
 =?us-ascii?Q?T6aLdoCoBnOV6ZqbTnCJv8B3JnL4KlQpsOCDJwG2rCKOnRZSXk+1q1sOwbwk?=
 =?us-ascii?Q?hZvQoIsoA6cd7b6phtRKAVQ+uWQgWN4LwMnB9f7/rBZDayCIkiQXLwsDOrIA?=
 =?us-ascii?Q?mVh6NqHsZHwHoE5+AEfvCHIbFQZDsxr2lvXUwD0DAGq/SojiEKLpz0L6J7y8?=
 =?us-ascii?Q?0ZIk7poi8WmFNpNt/B0nJ91Sd5ldU/k77obsgLzo9lgx1Kaouu201Hnw91UO?=
 =?us-ascii?Q?xEoVCf7kgiN6FbJk46tJkvRDmKfJBLsLatAfCVgPO6QxPUJUm2J0yIoKitKw?=
 =?us-ascii?Q?g7UplvYAOb11ausNhW90lh6tZ1PDRBpraLsTdjnIC0U7cNVznnGYRVALPvi2?=
 =?us-ascii?Q?CrodqQZIJ3v8YCwkA1LGFZZx7QAIore18yZY2MLa9ld8kYAtP4o0Lro9GgnZ?=
 =?us-ascii?Q?+gJhQSBsMb/2CQRvfue7mdQSWJMYPT9/gfJDga+qtaCqzWY31CraNJ9x2J/D?=
 =?us-ascii?Q?Ig444Di8weKR23y0fRTmUbSONFdOkueVsmSildfeCqjynBA/C1hw402fRaZ5?=
 =?us-ascii?Q?ll+s4TtALTWPd9b1m6rDKWjKWMbkan39T8CKi4AQ28LHAF28fD/h1uIgesHD?=
 =?us-ascii?Q?iVJmfe1lDdtB54me//7REIj93QEWvr0dUozB33fTyThwCEF6CnyASCM0bMjD?=
 =?us-ascii?Q?D6LwoF/rFVst42aOnURL2SIlFSpbYJgJCU7bc/9Q9lYArPsWTRmbyXi09z1E?=
 =?us-ascii?Q?cMzVDAbjqKZBQRh5iCrKiypFg/TYpg3VcJ01NTq6XeB3Nzg2NUNziCJzn042?=
 =?us-ascii?Q?h0iCp5ToNz3AB9Z1jeZ6HR0fbx3Ml5iBW9Jr6XpqT7rvAenbk20Wk0rhdM3B?=
 =?us-ascii?Q?gyl0xXXh5+ltxp5fzLeu1fenx68cyETt6uqKSVIDb89bMu2QH6u94skSUeaJ?=
 =?us-ascii?Q?JbcoJyP3cOiqmK0IgL0Lb0YQ0DGjfiol6TeFGM7Sbj/n1oSWOCnnBe7i/dX3?=
 =?us-ascii?Q?7eR8wIW0H6PnuEY2IiXCwLss2kPfUI8EFGzowCaB4RYZGBbwgLAARinNOcNw?=
 =?us-ascii?Q?io2oJ9FltrRKU+GKyRbnkG4MQuIqhfFK2Fv6C3O6b+fNEDOs1aCGvGAiysJm?=
 =?us-ascii?Q?VJlR8fa4Bvp3V5I0ny3EdcIKI5Kl6w0TpLSx65+A3eNQPyC+UX29ebFgpMd0?=
 =?us-ascii?Q?9fGCe8IxZXox4/xtHQMFtNbyN5tVLXR5F6I3ZhijRKYlHfR10U8Oj6egaPgB?=
 =?us-ascii?Q?kIUwKSVU5B13Zuvqrqw0wtIZO+oR1WwW8jIuvR43aUEOEgnM5+Y/Dt7pxEA2?=
 =?us-ascii?Q?/P5evhXMGSoOpOrQMqELJo5yZ+0KNX7eg9BrL8vR8JipwxJpBaMprxYRISIj?=
 =?us-ascii?Q?Zhdvv7m93rktDjg6Zsmxg9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a3198f-b126-4d03-50aa-08dbcf03a354
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 11:24:33.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TrRdUDHGQW1iXVHMMhPnh8bwByDVH7RJER8sQkUuM9uwyxT7xXgj7QBWWYCX8um/yrynYEQA3All4fLKKYS7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +}
> > +
> > +static struct irq_chip cdx_msi_irq_chip =3D {
> > +	.name			=3D "CDX-MSI",
> > +	.irq_mask		=3D irq_chip_mask_parent,
> > +	.irq_unmask		=3D irq_chip_unmask_parent,
> > +	.irq_eoi		=3D irq_chip_eoi_parent,
> > +	.irq_set_affinity	=3D msi_domain_set_affinity,
> > +	.irq_write_msi_msg	=3D cdx_msi_write_msg,
> > +	.irq_bus_lock		=3D cdx_msi_write_irq_lock,
> > +	.irq_bus_sync_unlock	=3D cdx_msi_write_irq_unlock
> > +};
> > +
> > +int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_cou=
nt)
> > +{
> > +	int ret;
> > +
> > +	ret =3D msi_setup_device_data(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
> > +					  0, irq_count - 1);
> > +	if (ret)
> > +		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
>=20
> meta-comment, CDX really should have a module namespace one of these
> days, right?
>=20

Will include the module namespace change in other cdx patch series.

Thanks,
Abhijit
