Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618C17F4C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKVQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKVQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:19:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249318E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuAaaElF8/Lkak7oZEoFWt387cOiTPKVYhc82vgntDvhpNNNm1BfeCovCQxyleYstbsI4I2N/fP7rwlkpCYBREF1IIphdG9K8XxIObM3NTU5ASuEbPOhJToRsYWWDrJNQZxAIUlKz5cSbVxKtDn69sBSlWNco5mBbbPycBerlgv6Y3Vf/6EQiI0J2Dy6/0ZEsYSzFdB9rBcoWDQaTXFDQ/BP2Gy5XWyI0yg2LnwZHE/y4XO1TNraZTlMv+hC0OXjm5blyJIx+XJ1FhKyItCT7CAZghVVUI3pPIiwApe/fLKWJTTij55rLTKbsnBc7BoY1wQymzcLeQOd8QgVQlTreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj1mnREgmjcYx8Mr4M01Kp6xEYBjT1+tn2f6F5TVzGQ=;
 b=RYPPn2zgjoriOYIvCBsIKRs8iFZQLMpdy/tfojAuKaDVpAleWG3tEMFFAJ8Zw5mub7Z4CBM1Xy2GK5lTZBStMcziV3637khNSYiq23jwcmDxcMImkoe5mSvEBsVeCd9n9AV89zjqwP2hg9T3rrdwn64hjkL3UeTsgu4akliLDQLSyv9WpSR4UgpFoa0GD2k0FZokqQtZr8LLa63LfFw4c+XIPKs3UC2dulpYnWlz7FcqaUzxHN4BdZWk+mBuBFzqB6GvBJPsu6P8qe+qp+Fp/bwRCBJTrpmdBiqAYHtFxFS4tK89CJOESdCY2PtIKo8lv+KH6R2r7WkRVHb+yNlj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj1mnREgmjcYx8Mr4M01Kp6xEYBjT1+tn2f6F5TVzGQ=;
 b=GuuJxPEzos30C6tmRgm3UzauDIJJrzW4JqA+ia9kl8aIqvRbk4fH6IreFUSpxbj0ww3zcvloYGyul6usdNDPnLRpz2RTFfU8/MHzCI1kk1iK30x92hsY7pFx1/RXYD69pT4iuBSw2wssk3h/ZVep1YSv503NltveocTxT6tFXQ4=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 16:19:05 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5%6]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 16:19:05 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 2/2] cdx: Create resource debugfs file for cdx device
Thread-Topic: [PATCH 2/2] cdx: Create resource debugfs file for cdx device
Thread-Index: AQHaHRpjoV4ub7/WEUGJr3DS/FT5xrCGCKUAgAB7uPA=
Date:   Wed, 22 Nov 2023 16:19:04 +0000
Message-ID: <DM4PR12MB7765C4CA172C8CCD4516EC1F8FBAA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20231122080300.3727388-1-abhijit.gangurde@amd.com>
 <20231122080300.3727388-2-abhijit.gangurde@amd.com>
 <2023112232-crawfish-twig-0937@gregkh>
In-Reply-To: <2023112232-crawfish-twig-0937@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=75c8ab7c-52ea-40af-aeb9-7e776c002d97;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-11-22T16:17:02Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CY8PR12MB9034:EE_
x-ms-office365-filtering-correlation-id: 45be463d-ef63-4d9d-ca0b-08dbeb76bf2f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMelcXCmHJ/T9rBr5dXHpWskS8oFdK+Rj4sc+fzwFEH9YCiW3m8o0upJdrsGnW7jA/sxZAbWzpqaDGIbmkbeKfxTNkSX28HZopWWJM5X9V5WyqzUQ8ye2PBQwa9AS1fljr2I/GrPucrmnHPjHCd+JYJ2mW+NASpI0j5lKaEEYKq5T8Rp/kef0PxtWaWkvKphaecT7bbrcIEE0GmI4CPqNYy4sywIR8UfzndQYAIgVdx4szfd9nPYmu4HYTjg0QaZnF5hPWaLK+/Jeo4wV25+gnE65s78fmipK6tPmIcu5TPre0Y2fZ4S/oWCbr/0AQMQak26uM1G4f4xvdsNgT4xkKd1hYpN3Iz1fXBhg/vP+e22/5IVhnCGYjYSMEZ4gtlkwgbLFqyKhhkk+Uj2UlliqYUZmiowlHv+1Bgn0AAqoj3hjwC93Xb53tai7KkzQkh4gw9DdAljZ06eL9tPFHZFK7cKNLOly4e4I0pfxtaYP4WX/NkEKF5SfDoZMInO2/GwIJ1pHwLgcnD3TskyaF1XVoXTEaot/R+AzgJpTbmqDg2d82rR6/TdGidiGxdl8omP/nAkZpYpvJ3gU/s2H0Yw2FiGSDMu+cK83jnnnz8Yw3lfXiDFKAzAFGnw5+OhlER1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(71200400001)(122000001)(478600001)(6506007)(7696005)(9686003)(66476007)(316002)(8936002)(76116006)(4326008)(8676002)(38100700002)(83380400001)(64756008)(66446008)(66946007)(54906003)(66556008)(6916009)(55016003)(5660300002)(2906002)(33656002)(41300700001)(86362001)(52536014)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YSbQCkXHFM25eNC5GxaOGHbM63ThnS72EBkCw/EHrxiMOIT54KpX55EE+dwp?=
 =?us-ascii?Q?Nvod6QYbd5q8zL/1kLNgHTHpteu59DPb2DbS6Bgc7tpf6rgT/fONeirW8vNe?=
 =?us-ascii?Q?t/xII68MGpK1YLwuNgnO0uQ/T5gFZBmGDvbSpNU4Lhgx0BDL1WFsfFZE2Jel?=
 =?us-ascii?Q?NxaiGdriE0CH59OznbBfyG/yZYQpJ4HfCEkc0ZCuf9uVD2uih+7GURyfF8jC?=
 =?us-ascii?Q?lYnaNRc2j322CnzBjwoaR4RpRwtylS2jMHY9YYrgx3jOAs5A3RpO2SbJJOX0?=
 =?us-ascii?Q?IiMh6xjeDnKSyH01EwwRTI2YbZBgNh9XvR3a3D15sAXEZkJqEMsBFkB/eRCP?=
 =?us-ascii?Q?ipicCJinFZMZJEahadOHLb3Yv0SXDCRD+pmbtVKtfLuHcxBmBReMoYNxedF7?=
 =?us-ascii?Q?QJPrCQ/njga0HJvNOylOKWyAT6QR5fOB6A3eR2DqE1UREHW6NsceRPkmdGXV?=
 =?us-ascii?Q?9D1fWicx610u88B25g93YNJldxV8Bj+OEWWzKLO9mHJoIQfpkkPo4qomwVO6?=
 =?us-ascii?Q?7SazvvOQu5wUPfF+IyAkNW10OMmRNjz5QvS4rqbjGMK6iOFUTufEC69FNXPC?=
 =?us-ascii?Q?+mqRqov91y+JTnc8Of1kI6hgnfHFeOue7stQH1R7cYkM1qtyWwLfdkQmL2DK?=
 =?us-ascii?Q?nY3PmJucIPt1WXVLFeKS46k2RqCWE8KDpS7UOb9f2Eh2+xW9gYQd8GugnYGx?=
 =?us-ascii?Q?tcqAoDwxW1TBHQKGH9hkeab1Q5lNlPIiEE4AJ7kabKx6l39nUyJfKPId68mY?=
 =?us-ascii?Q?g9piSQm/LrdjYwfc4yCEd0pp6X6ipN5CSEfuyCnQVwve9FnukaX39nmvhdBW?=
 =?us-ascii?Q?V+ttYuZZVpQNbQ5vEYB3/olo0fVhwUo559riHKYXBFQc8CKo5RzG7qezPOMn?=
 =?us-ascii?Q?/RWr0l4sUdP1hRzuYYEGuzVApKkBntbXXBr+NjBl5f2lckwBG14L4w/P9VxF?=
 =?us-ascii?Q?l+m+vpxUqmnD/NOmGQd4ViRi75wR7GmSkEpNUaQHPcsX0OIBXQuTUsdtNs/R?=
 =?us-ascii?Q?bgsFZ7NO42ESS4ga4WOl+CLFDACfuBM6uC6Z0HaHal9TussokafVF5TMAImX?=
 =?us-ascii?Q?+QtqWa+1GSNlk9BEC0O7bX+m/v8q0FPOwxgTEZ3DuA+bLOsyb18muZwZx+8k?=
 =?us-ascii?Q?UWmstkg8bivBMOuQfxUNAI27gQjTvNY0MEtTU21UARDghNtmxb9Lpd5mAFKu?=
 =?us-ascii?Q?7Otn9LW1YbkSa7bXXH1Ar5yueDm8qWBzhCJspwkB0bunjyyknfHLrnkCCz68?=
 =?us-ascii?Q?2SlBe+mCinKeiPkHekLdktFJOSV/V8uP1OAP0d8X6NyF1mFliSvonHIxh50C?=
 =?us-ascii?Q?5+B06r36zSxIcy4SoK/dLrU7cqwKwW+26nCM7mHux/Ad3BIPCiedNLBA6XR9?=
 =?us-ascii?Q?SC0DQwr/cj0Vq2hVH79jusbrmk2HTxNTnzD1N+XhZZUA0yFUeYdQngmXic9m?=
 =?us-ascii?Q?nrNNj6/N6Xs6BwHTD5FgnPBjVZ1TRv0Tedmt5Tz8UX48qJiuvTYGRLwvcq5y?=
 =?us-ascii?Q?UpKn6wnBi8OwvgjOIkQmtX0sxaSS/sNUMHqKAlvMyFayvfcMJw8qcaZcMexa?=
 =?us-ascii?Q?3RYf13Fb3lQ/bDM3hgEWFge39e376OJV+yj5eVOaciutGG7Qs2vrG2zgjEsu?=
 =?us-ascii?Q?IIwfeeqe6uTL9aOdKczi5/A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45be463d-ef63-4d9d-ca0b-08dbeb76bf2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 16:19:04.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5m66bA4LpyZFJsBqqr3y3MKOzBY9q9pzqWL5x1HEtWCHQg4+2I+0dQfch43UPDUeG3by6m4ZCUoeQktO0IYM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > resource debugfs file contains host addresses of CDX device resources.
> > Each line of the resource file describe a region with start, end and
> > flag fields.
> >
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > ---
> >  drivers/cdx/cdx.c           | 42 ++++++++++++++++++++++++++++++++++++-
> >  include/linux/cdx/cdx_bus.h |  2 ++
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index 4edf64f9e98d..e01376272ed3 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -65,6 +65,7 @@
> >  #include <linux/cdx/cdx_bus.h>
> >  #include <linux/iommu.h>
> >  #include <linux/dma-map-ops.h>
> > +#include <linux/debugfs.h>
> >  #include "cdx.h"
> >
> >  /* Default DMA mask for devices on a CDX bus */
> > @@ -75,6 +76,8 @@
> >  static DEFINE_IDA(cdx_controller_ida);
> >  /* Lock to protect controller ops */
> >  static DEFINE_MUTEX(cdx_controller_lock);
> > +/* Debugfs dir for cdx bus */
> > +static struct dentry *cdx_debugfs_dir;
> >
> >  static char *compat_node_name =3D "xlnx,versal-net-cdx";
> >
> > @@ -149,6 +152,7 @@ static int cdx_unregister_device(struct device *dev=
,
> >  			cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
> >  	} else {
> >  		cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
> > +		debugfs_remove_recursive(cdx_dev->debugfs_dir);
> >  		kfree(cdx_dev->driver_override);
> >  		cdx_dev->driver_override =3D NULL;
> >  	}
> > @@ -552,6 +556,34 @@ static const struct attribute_group
> *cdx_dev_groups[] =3D {
> >  	NULL,
> >  };
> >
> > +static int cdx_debug_resource_show(struct seq_file *s, void *data)
> > +{
> > +	struct cdx_device *cdx_dev =3D s->private;
> > +	int i;
> > +
> > +	for (i =3D 0; i < MAX_CDX_DEV_RESOURCES; i++) {
> > +		struct resource *res =3D  &cdx_dev->res[i];
> > +
> > +		seq_printf(s, "0x%016llx 0x%016llx 0x%016llx\n",
> > +			   (unsigned long long)res->start,
> > +			   (unsigned long long)res->end,
> > +			   (unsigned long long)res->flags);
>=20
> Why not just use %pR or %pr instead of creating your own style of
> format?

Will correct this in next spin.

Thanks,
Abhijit
