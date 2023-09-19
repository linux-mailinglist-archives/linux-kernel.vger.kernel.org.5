Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAB7A6232
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjISMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjISMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:10:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A3C129
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2NtyV5klAHs/ATakYZpae5jvcQTeoVyVZhWs3jYItKa0JYuFN4Ii3Tsm9oN5Is14PvEn8YJQDDIgHZ/WMWCSr1gYqexEBgF5ccJdXl91y9FLi2/ulisj8r7p1vI9TmmIms4Z4S9lKDeRWX1mYaQEcCbeMmnTu1cg2r861Xczg7gj4UmX8TS5MYGOJTQ+q5HQ6QzEuD7I8qTSMTSB8wuborZ5xuILdlPU65XaBouG4nufLbMj6ktiKz1fm7kUXoCTxImH7VPxAD8gC7lvhd2G/F1JgLXfweqxzFiRBnsHxBAapdvQgyiyHELUi7dy5sN93glNEP0SHiUdxPR50jURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/KtRBvfxog2jgRVngufeJvN+rWnvKjZJXziAzh/m9A=;
 b=aFiFzhTyjp+/qMFGH4MQEOoL9in3MY1fca4BzyIxJaqPCbC/qeDznzS8HI4eC9wPCTwjV1rcBPdAf0goiEV16Ecqd+SGI7ddLLogV0u/WvGzFw1PCxo3YOnJtzCW1OWMV2ttvSnj868fyuPlMrA4zvnyJTbKJLh019pBhUeOG1M/EYx/yF8VRkqXz5PiuB84QpTpGfpTf6Cgo3mwU4M9T/lgsOhDT/71eeCPy6uKYeTZetMHazrKRq20nxyHaVKh+ogcAMMD5YHHzFz5c1m2Fhx80/WLbaEyG1otPKq401zZCaOuu/8UsaweSakm5t4kfYqYN17FQcDwJBJfmcI24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/KtRBvfxog2jgRVngufeJvN+rWnvKjZJXziAzh/m9A=;
 b=MMmsiYtlLY9MpZYBqJJ+6wkYYoPXV8tP4JTKIIUkZqMLvnk29RpITI65PW8NsauvEvLUCH/szaMci+FBYQjUEEXYhjjBsSuF3YafTjJ5Ymux3TyUZr0nPfBVceOlrUMiIgY0lD0p2QePfzTl+BxHDUOi2rULGQXaV9S8GzPXIt8d/1KS6INVIa2o2n1udmIzBnAV3GnXhPFA58jsq70UzhqT4T51sT4nsw6zWdmu/3uZ/1W8t1Mk0nLt/FwsdlcK3Ec7XLeJPUO41XEDmAw/jbgoa0g4vtA7GaJQY0k6mUHvHAdBAsNW45knTK7KzBegUC71rOvXKPFTDVTeAowBpA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 19 Sep
 2023 12:10:29 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:10:29 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jiqian Chen <Jiqian.Chen@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
Subject: RE: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Topic: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiChaQ
Date:   Tue, 19 Sep 2023 12:10:29 +0000
Message-ID: <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB9068:EE_
x-ms-office365-filtering-correlation-id: 1dcb5b23-55c4-4426-4b30-08dbb9096a82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HNdwRzs0zZ5RtPyJcxSXN8EODgvgZ5YOd0BDS/d5CS03cKKWAeH2upRreSMPr25/rD+mW86atOgC3MpsCccKapr39RAQQMSeShZI4xf81p1phXu97Gd5FlnMIqsot5nJg6rUl6oz5EPbTVI0hSbsFWUPPmuuSUhKBeYG/AkYG7x1mLOPV5s4hXOB71zUdcGQbGuObtWmPiQWr1JSswftKvrKjQC/sPJDd3mVVzRfQ8eZf7vA+TfVEYlbN9nAqSYVpir5gmaJzCA0N019s3M+p03J9t/j5PGzOnWuouH+nm3Rfrmik40muqqHVsmbhL+F6yZHMyeY/5d/yMdT/EZfbjCQCKhueowed/qGsW1JVx/j0w6DuntV2Iz1/3wJgPFnt4ZuO2Uw/ASY7adPXESeZNCSwJsrja9/g/FFQQ790N4S7Y2v9T6BOeYrZAkut5WiXulDXeJmSlu0I/SExfLwBP2GiHMxqIINgFGNvyHhNisAo+qTsMSk7Ryt33ewBDEjpKAqzAz7TP9gKE/KJULF76GTeFX6PV7IQ/JzVukB89l2Y4ivFZw9hGvsZAUVgAX3gKQ7hjQDLDDLpsebV4MEKEnyzFocYwsB0r1I6xsdueYDmDQVIV2lDotQQV8GU2u51E/01sEuRNKmvHr+u6Bb4MTyJWFmD/SC+DQGY6iiX6iJmnatH5Nq/Bw3TaxINaCD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(186009)(451199024)(1800799009)(64756008)(54906003)(316002)(110136005)(66556008)(66476007)(66946007)(66446008)(76116006)(26005)(83380400001)(71200400001)(55236004)(7696005)(9686003)(6506007)(122000001)(921005)(86362001)(38100700002)(38070700005)(33656002)(55016003)(966005)(478600001)(2906002)(7416002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+9SiMlEqhoOL3h/XbCkZ3qVagvsBp5LtC0dxYabmBFSuV7da8gCNd3MrjR?=
 =?iso-8859-1?Q?+9e3KlONJvo6c4Fz2UBT33jdMzk1kSywDrcPqHEEiWRqcob+iEBW8LZl8x?=
 =?iso-8859-1?Q?6YNdW8xb3MlnoeEPngewXpChGnois+yI/9/K1mBUyevBuE5dvvRlOGvero?=
 =?iso-8859-1?Q?ZoZVVz+OJwASTNJE2wu/OnI+amMcNyn5eNvLpjcBzgtw3DKoPRW1ZdGUVT?=
 =?iso-8859-1?Q?aAv/PYE0eyTyve4kTbcaiZWT7jNEOeCIWHBSa8DAcnc/13EL6eKB3loBUn?=
 =?iso-8859-1?Q?pa53hVHB7G2NYZK2Qgyd4XmgpCy53Y04sqWcdA9VDxSIsrfmcnwNWjqd7t?=
 =?iso-8859-1?Q?r/57h5cpyga8puUTfDmQH6XZJBD+9hmyTcxvMwZ9rtGUIr3X/y2s6mfCWX?=
 =?iso-8859-1?Q?/dq7W2tfQhIHXV2XVtBIPu58+XnMaG9gK837uQPj1JR8bS2YbMw88H8N6x?=
 =?iso-8859-1?Q?MWsgUTs8oXq6xPraYCEDR+IqUNgTCcv/JZC2YkZLr5UoOcmG+78NHAOSjd?=
 =?iso-8859-1?Q?qEDvZO8zGl7P0bVW/iVpz0QYFRf62MqKT+wLP4BCfaCqtiPQC8zKCyZDxa?=
 =?iso-8859-1?Q?ZQNEM5loUNa0yzf9TQyT2plsDw4XqfsrE0rddziCEEFc4xjVCrAOYWK/4H?=
 =?iso-8859-1?Q?r2w4u9v08x1QizhNsvvakYuWKvBGmRV5nUTjHbu9ROOdzbAZvsP+OUOuiV?=
 =?iso-8859-1?Q?y4pkCj+Zi5Mb3Z0P1pGTvzDkvpzicNRGBZbNit/dJdh3T+ebHujQrDIWXw?=
 =?iso-8859-1?Q?oYGsLlx2zZuAmDHJNsEvO2FCIdsJ0IYWwDkJNihwzhvggpacQIXGfSEEXt?=
 =?iso-8859-1?Q?38plE8mIo9D9Id5tHjNGSwpm+sd6fOvy3VtKcDvYRYzApF5d8RzIbTJFOK?=
 =?iso-8859-1?Q?/oSiBbXiORqii70oy+9W/ne9k5kTgFaNNrEbqEhA4IlozvoTc6jkDBphRX?=
 =?iso-8859-1?Q?X9uq9vDE6MSExLY7/Sbdveri8IxYkVjPtWGjL1VmfzJ4tVKI4ZPp4e9u2x?=
 =?iso-8859-1?Q?DAPYTWHowWkBvROlhKHWRj67civKoWTHCnetxnCFCEueH9e3+FCmnXJpN/?=
 =?iso-8859-1?Q?y+HLmR5fqxyoXLHMbUQe3DlR/4z6ORmEAm5n9HCBErdAvw0MnIxfzoRH5c?=
 =?iso-8859-1?Q?sEVC6XxufNKM5BtNFb9ZTltFg6zH2GOs7Gut8wKn7n71ClQEYoMD6y/xV3?=
 =?iso-8859-1?Q?KiGVe2Dblya1Jb4GdcWgTwAY68EA++ieHotHuZxM+JdFl+WRi2mQMBoecJ?=
 =?iso-8859-1?Q?dZ3A318PQyDcWYZ9bmjDxdTDi3Hn6yN0kplzIrCx8zumxcb/PIfgRnOHi0?=
 =?iso-8859-1?Q?rBRVexPlioXt5+y5pWsueUpCo6BzSHny0nWx3nOKf85xNehoQX4lpEcDe1?=
 =?iso-8859-1?Q?kBGbYU1sei7NrGeFa33OwP2M9UJRiEQiPPelLfM7NvAaevE7c9hJbB4lC3?=
 =?iso-8859-1?Q?nA9SRKcETYkH3eDTluERmNEwIDHO0AuD6knG3fvnvyo8Wdoxo4m5bdKJcu?=
 =?iso-8859-1?Q?PhTupf+f9xpC2NV6SjxZ6TCfqummR6NZYlNjCIOYHVM6ImqUMTIl1p57BB?=
 =?iso-8859-1?Q?786qENS+hAXNhwYpCcP7jGOLgH8Kjf4wiAZU/kGis75kLOeAwNdTH+79Qw?=
 =?iso-8859-1?Q?g6hcXbcJUNq2s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcb5b23-55c4-4426-4b30-08dbb9096a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:10:29.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+NRsLpYM8PrnU1XXbunbntYXAl8Iajn2hns1IPpVEDHBdHNR/RiHwmGgKvnN5lKzMB9IvlwzrC3y410AZ3Rvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiqian,

> From: Jiqian Chen <Jiqian.Chen@amd.com>
> Sent: Tuesday, September 19, 2023 5:13 PM
>=20
> When guest vm does S3, Qemu will reset and clear some things of virtio
> devices, but guest can't aware that, so that may cause some problems.
It is not true that guest VM is not aware of it.
As you show in your kernel patch, it is freeze/unfreeze in the guest VM PCI=
 PM driver callback. So please update the commit log.

> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
s/excample/example

> resume, that function will destroy render resources of virtio-gpu. As a r=
esult,
> after guest resume, the display can't come back and we only saw a black
> screen. Due to guest can't re-create all the resources, so we need to let=
 Qemu
> not to destroy them when S3.
Above QEMU specific details to go in cover letter, instead of commit log, b=
ut no strong opinion.
Explaining the use case is good.

>=20
> For above purpose, we need a mechanism that allows guests and QEMU to
> negotiate their reset behavior. So this patch add a new parameter named
Freeze !=3D reset. :)
Please fix it to say freeze or suspend.

> freeze_mode to struct virtio_pci_common_cfg. And when guest suspends, it =
can
> write freeze_mode to be FREEZE_S3, and then virtio devices can change the=
ir
> reset behavior on Qemu side according to freeze_mode. What's more,
Not reset, but suspend behavior.

> freeze_mode can be used for all virtio devices to affect the behavior of =
Qemu,
> not just virtio gpu device.
>=20
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  transport-pci.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/transport-pci.tex b/transport-pci.tex index a5c6719..2543536=
 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>=20
The new field cannot be in the middle of the structure.
Otherwise, the location of the queue_notif_config_data depends on completel=
y unrelated feature bit, breaking the backward compatibility.
So please move it at the end.

> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See=
 section
> \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>=20
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and vir=
tio-
For above names, please define the actual values in the spec.

> pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +
It cannot be just one way communication from driver to device as freezing t=
he device of few hundred MB to GB of gpu memory or other device memory can =
take several msec.
Hence driver must poll to get the acknowledgement from the device that free=
ze functionality is completed.

Please refer to queue_reset register definition for achieving such scheme a=
nd reframe the wording for it.

Also kindly add the device and driver normative on how/when this register i=
s accessed.

Also please fix the description to not talk about guest VM. Largely it only=
 exists in theory of operation etc text.

You need to describe what exactly should happen in the device when its free=
ze.
Please refer to my series where infrastructure is added for device migratio=
n where the FREEZE mode behavior is defined.
It is similar to what you define, but its management plane operation contro=
lled outside of the guest VM.
But it is good direction in terms of what to define in spec language.
https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia=
.com/T/#u

you are missing the feature bit to indicate to the driver that device suppo=
rts this functionality.
Please add one.

>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated.
>          The driver will use this value when driver sends available buffe=
r
> --
> 2.34.1

