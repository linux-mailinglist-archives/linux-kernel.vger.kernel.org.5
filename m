Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6696376CBA5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjHBLUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjHBLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:20:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C426B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN4sFykq0NVZUy0RBGEu0ONYxR1GDw9HZF+tZxroG9eiyjEghyoWawQUz2/gW8UkIPovpBVZjxCOn3RlGdpeDZUxc7DmylOitarlMi8ani0x8n4nrhTzWlAolH9hbo6x82OBH45vKMsx3GXqr2tBiviK4Kz6gyIR+nUNdC2SMDCf+Gs9+oHFDPWGnnkb20cs6MIwr1a7gbVlCnycl036LrkOkwY817KzbXIGbFJvRxT0xq3bnKOH7xyZtYytRWh2YWVAXc5yyzG0Eq9tn5VbeMFUXVaCABUknawp5Pi4a3rfJQKEEZPSLp/514v/triG5Q3JbatwGduzGycjmVoGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQoFvlnbVzbk12Q8nhH6muSG3a8DXQQ1dYe6m+cY4M0=;
 b=U0g8v+MF1BO9I8jj2IGNjgpWX6CwnhVUxZrI8eKRvasZ4O6y6tCjCy+BSsT6wB96b1UuLQNH5k5uHmgojLPIF4nw2FmLLjCEKMZTMUGlHe+XKaJJlpRm1NFoJpAYlOcW0/3PdxGShSQ3bDvVVgSnOoQOnTHoiRYKSDy514WJ/RRzVd0eX5ej9D//I/ZagHfbHQAwkUTW8D5t9kv52E+r+HcwIlHlTqqksUJisZyniXS7r/h2uoxbJnAsTCmTA4xRmds3CgYFzu69K6Q9esKS5N0fSwlDZF+NfQQxEwM7jTSIemi1GrXzog2BNA+UZdehPuCFgxV4Im3DXeGPW+3WeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQoFvlnbVzbk12Q8nhH6muSG3a8DXQQ1dYe6m+cY4M0=;
 b=HlFT8SBI74+IKC0/9yIFk7Yz/Fyd5QiPLR0IHLiEFPigycu+3RYrApLF4oaoj2rngJXbzWDfqq/YGh4iyl8UuDy3YRU97o8EbXQt+VOiTM5adn7njh2FVnVJZ9qlEMvhvL4OqreUxuJMAh1T/R+JRR2zZzdsRgwCwlTFf7s9uso=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 11:20:17 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:20:17 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: RE: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
 controller list
Thread-Topic: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
 controller list
Thread-Index: AQHZw6fpekS7+sewHkWP9KKMIHa4dK/TzKGAgAEccwCAADdNAIABuRcg
Date:   Wed, 2 Aug 2023 11:20:17 +0000
Message-ID: <DM4PR12MB7765B6284FD9BC113C8482FC8F0BA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
 <20230731120813.123247-2-abhijit.gangurde@amd.com>
 <2023073148-carried-unshaved-77e4@gregkh>
 <DM4PR12MB7765398763E00B565AB1C6DB8F0AA@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023080105-eggnog-probably-9ff3@gregkh>
In-Reply-To: <2023080105-eggnog-probably-9ff3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=48ed6a3f-1dfc-4bfa-80cb-7ea9f9a01748;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-08-02T10:59:32Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CO6PR12MB5428:EE_
x-ms-office365-filtering-correlation-id: 0c7ea24b-94de-431b-88bc-08db934a7341
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jXiWs5Z8uv/KwnmEusJaNCL+HEi4NM4b245uu0mwX6pz78fBBreLcAE8D2zbLGfq2pH2qdoaH6vmlyVwTl6+caDVxGOqlasRtOIFtorw1BrjXJCu+hEZ1QmDjacFxTzXx10Rr/h6yQuZPdeeFokiVHojQrzprZ8oT5uZOOCIgoGOA/Z21OSlkxmTp8i2q8M/nKwo4gWwJwy83DUKkbqbszxzUACWjEuvzx64XJH6kFrnfJVbhQyOt4kG+zame+olLjdbDOG3qEJ9pPDZt7IQqvw5mYXxvC/V0ZKmY1jJPh4Y9g2QYdKmJb3gwbUIKnbmYiGJJMVDP1Mdqg3whdhV54CXKbpnnBsUpz0CVKY+/I38puoJaTFq47W7CJR1W9vl3D/pX7Lr/w2kWUdOUS0ReIMfQmaq7cgFvet0o9JNvfSwr1EVlNYJzHr9Gt3x0iPyEUzHIeYcuFj/IzJrmdrdz+93jtMxkzT+DkvK691R48SvJNaNTMV5q4WGqqn2bnq2JkReXUMB05FWkHWReZjV70ijZf7LD3PWHzyYO0tTZqLxIqs1apHGurA2UIWzd7It+AMkvD/unieUsIqcG0+1evcC4FnuT0Ak9Pp2DaPv5olYtnvj+ffQ0rpMdbqbuOY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(8676002)(5660300002)(8936002)(52536014)(26005)(2906002)(38070700005)(83380400001)(41300700001)(55016003)(186003)(122000001)(478600001)(38100700002)(54906003)(316002)(86362001)(53546011)(6506007)(64756008)(7696005)(76116006)(4326008)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(6916009)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9S8fC0SHVlesMLZDh1x8AwBTBOkyqjehaFIXiyx9XK79FNYRMs0xwRF7gj9K?=
 =?us-ascii?Q?dAYDhVDBsWyyBCjoZfjwVbShkwFBPqkV/5At1ilSFEUbCZwgvAmt2NNMaxes?=
 =?us-ascii?Q?ZpMNWDO3OUln2ZSK809tF1Z2iPNcOukWh7z86iBBWuRP6m9ieR3XKSYUZF5P?=
 =?us-ascii?Q?j93dzTGolEdeWlXoOStH9P8Te2o/sGo7yxPPDCuzFfQOYkuNjPzFTQiRsLsn?=
 =?us-ascii?Q?zVKf55sdZOrjemehlF6uK0tguowf2VeESxYHEZP1TQ2ScB63d/WrI//zmOHX?=
 =?us-ascii?Q?cpNnUxXvE/pqaQo/b6/f+4TQOqD6dJoUl9OVQRwZXOrlK8NzZFisDB1QkH6m?=
 =?us-ascii?Q?Z/eLYRIml+Zofkgr7M6RabzoCvJIOeMbXKAZ4dwEHULeNXPeu4SsXlXO8AJZ?=
 =?us-ascii?Q?KTZiQpsIcyKfwWtlPmSk8+z3leaJI1LSuP3peG3u1Nj9HkaZKZeQg19t8MjC?=
 =?us-ascii?Q?ZBXU+WklhM3g9BX9zfo0L5ROu5RjaxOphZcTLHBXihb9hhbu5cAtqM+fuMT7?=
 =?us-ascii?Q?NdKySxfN52ciknZRlEFAtSxq8qwUWzS3mQwpl44td9N0mLp2IHiLlSmT7+LH?=
 =?us-ascii?Q?KyC9+Nk+pMxn9OrlRbxy8xieDrYEsc44r8pWezb7YGhJkKuMAUZX8WMk3GiP?=
 =?us-ascii?Q?e18YC9ht58sppQZgZNNkep8nM3dte5xw7A02i/jf+s4EuuTmnbBELwjsPE/K?=
 =?us-ascii?Q?SHTf2J6xXZ5GQ/96HpyBOygNsF2qaQS36nEOV9+fKa8OOeIuBBV5XMoGoAkR?=
 =?us-ascii?Q?Yp95Zv7fzMoFtnMkO8o8r8kuhL6VUJ0i5VxZpxHVTCIswvDttuUDIjFIXdLM?=
 =?us-ascii?Q?Syu19u8PpXOEmvZpI8QNF7EVRoUc/H6g03J32G/Bh0I95od9x7puZX1xSQIK?=
 =?us-ascii?Q?tYzaPFeOIC3lJgh0CjbYBFbRcmOkDCzLMNoAmRnwsZvnmSDyUxAXh1nlq+5o?=
 =?us-ascii?Q?LuHXFpTNwdYdpBkBBzp5Gt/9n2Gfp46fQ7Lpn4vWC7kIlx6UvMTRLW/zOEPg?=
 =?us-ascii?Q?94jhzx5vIq19OFDI7Q2+5ulfWqvbPDZxTf1XmAW1HgB9n8/8eIQvxurTC1MK?=
 =?us-ascii?Q?n3odrycK84mSSQafr6ExFTiQbBfQAjWyMZnAZI3BFcYRj7yI0H6/8WG3vBsX?=
 =?us-ascii?Q?71N4NGqX7d9t7ckI63b7e6ROpNtecxgAhaYsEQDCt8/xVmxOLiXNaaQLrRqq?=
 =?us-ascii?Q?dBlND2bWTn8zhgIxqSvRxfwS4IrOH4Y/AncRYba5As9/Vk+IMTHiA+Wz93vu?=
 =?us-ascii?Q?sUsbZlOL27WBn7XeeU5xiBFEiwARV3K62ImBRf2wPo2YGVCrrYWi2hhBwxIi?=
 =?us-ascii?Q?WasZrX7VZcD+mgFv2P8efZMG1VMHpMGX06vD8+FoREfjfZ2blx74qwo6/ptN?=
 =?us-ascii?Q?32SRozMvvN8GP66JXKQZVuf+fLND5xGjPh/esHEOEMosCDf5hB7BtSpmI6PI?=
 =?us-ascii?Q?Vj6ZuTU7bkvzhaQpLQUbdy9l04uWFC/7usa+8rwqoKFlvBptFJ5kEe0UFlgG?=
 =?us-ascii?Q?uve4c4vx653vCieNR/tpv/INCTfrM1jjsf+hHK29Ug+KYnjt3ot7rKSeda9J?=
 =?us-ascii?Q?F0olDKkJhetha4z6gpc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ea24b-94de-431b-88bc-08db934a7341
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 11:20:17.3264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjbZTFUd7+If1RSP4DdXhszLeMkB6P00e8YOEOeizD/NloKO1WPtp2SPghMatC/f/rXz3Nk9fBLfCte7wZxbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Monday, July 31, 2023 5:55 PM
> > > To: Gangurde, Abhijit <abhijit.gangurde@amd.com>
> > > Cc: masahiroy@kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > > <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Agarwal,
> Nikhil
> > > <nikhil.agarwal@amd.com>; Gupta, Nipun <Nipun.Gupta@amd.com>
> > > Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect controller=
 ops
> and
> > > controller list
> > >
> > > On Mon, Jul 31, 2023 at 05:38:10PM +0530, Abhijit Gangurde wrote:
> > > > Add a mutex lock to prevent race between controller ops initiated b=
y
> > > > the bus subsystem and the controller registration/unregistration.
> > > >
> > > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > > ---
> > > >  drivers/cdx/cdx.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > > > index d2cad4c670a0..66797c8fe400 100644
> > > > --- a/drivers/cdx/cdx.c
> > > > +++ b/drivers/cdx/cdx.c
> > > > @@ -72,6 +72,8 @@
> > > >
> > > >  /* CDX controllers registered with the CDX bus */
> > > >  static DEFINE_XARRAY_ALLOC(cdx_controllers);
> > > > +/* Lock to protect controller ops and controller list */
> > > > +static DEFINE_MUTEX(cdx_controller_lock);
> > >
> > > Wait, why do you have a local list and not just rely on the list the
> > > driver core has for you already?  Isn't this a duplicate list where y=
ou
> > > have objects on two different lists with a lifespan controlled only b=
y
> > > one of them?
> >
> > cdx_controllers list is holding just the controllers registered on the =
cdx bus
> system.
>=20
> Which are devices on the bus, so why do you need a separate list?
>=20
> > CDX devices are still maintained by driver core list. Controller list i=
s used by
> rescan
> > which triggers rescan on all the controllers.
>=20
> Again, why a separate list?  The driver core already tracks these,
> right?

As of now, cdx controllers are platform devices and maintained on cdx_contr=
ollers list.
CDX controller devices are not added on cdx bus. IIUC, you mean to use driv=
er core
list to find out different cdx controllers, in that case cdx bus would need=
 to scan=20
platform bus and access the private data of platform device to get a cdx_co=
ntroller ops.
IMHO, that would not be a right approach.

Or as an alternative cdx controller could be added on cdx bus as well. And =
we can then
get these controllers from driver core list.

Thanks,
Abhijit
