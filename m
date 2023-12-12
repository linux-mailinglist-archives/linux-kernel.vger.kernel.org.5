Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2357280E367
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjLLEkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLLEk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:40:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E552BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:40:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhvA/D3xRa0r7Jg87sH8GKHS7Yv6CKXz18ZTO/8I8Vn9cUfkritKUv5lqcMw0esB81b3gheM0IQElcgZmH9sgBLjfMAiaNA3A/iI0zSlyawxfH4KpyJ+uAThT3KGoLXfAnneaBADKDTeprBQT0k0+dkWUYA/g+3d3JYj5ngdgoFe9bZfxFmyPkiaXrk/0NhvCjR1ECdkeTNu7XmPXth85OInckQEW8YgFB0uMu/Pn3DYw8g0E/WzPtGqc23ntkif0ZyXBk7KJlLkGvSeAix0K/r9Xy9lS9rnbfwI2fUvlpMWBEJVwK/atq/mWk97ZWaWgevNPBpIiyox/1WzkIYqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP4y5V3B2b81wOh1hAMUzQBv0thFnNWMtMUPomMHoQM=;
 b=Ga1LC4Xj93HJJGkjB/HhXo4XvCAefgGoUmEcRYnK6ksNLiPbhKgQ5xPdqMkFm8o4qT8XEDd3egdNdlyJG47cAUZmnmaRm8+qdV5NQvEWF89SNyZ2AafymPB38OhLUP738Vv4kNEGRZ5Qm7UtCbmoGaTuSsWceTlUTacGvDA7+0a2vUKZA2yrx40Njcq4Q+2zQR6YMqAVd0gKm3fHtRYI4Vcbod2wYDqALD6qe04aDfuxxNNpf3PTbhEQCUHa0wuY/LMd3dDcjM3tMu2JRq1yb+0fUCuXVuIyzrHaECeWYOnVeV2xPD04qcU7Srr8AGZDNsahEhLZQE+Sy9SfvVauCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP4y5V3B2b81wOh1hAMUzQBv0thFnNWMtMUPomMHoQM=;
 b=TzzaPBVrHCPH19s6oRlmdt8VgpD8/qlzRcsvdqJhX0OEzMNv2lnz0wWg/YsQw/r2t6geGrqeqrkEiPF0ffZnjsSGCURDPG6XhgDjudf2xE4L5y/a2i6Q7jvuYIs+EnryELvIRckrOhx5ZtHgVunRgeYktGxLZvtq0ufpS/JR2Ks=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 04:40:30 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 04:40:30 +0000
From:   "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Topic: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Index: AQHaKSrfK397vJpt0UG67Mqdeevb4rCkBF1w
Date:   Tue, 12 Dec 2023 04:40:29 +0000
Message-ID: <BL1PR12MB5333564B386B8273120FD0109D8EA@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20231207163128.2707993-1-robh@kernel.org>
In-Reply-To: <20231207163128.2707993-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=c76f8e8e-e5d6-4a07-977c-4559ae79a486;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-11T12:13:19Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|MN2PR12MB4192:EE_
x-ms-office365-filtering-correlation-id: de28b4f1-4b33-4bd8-690e-08dbfacc7814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8idvDzeML9sriM4F3ibdEYEbCoDEQiVJMDPYhlkeVo7IZOmtkOvFw+Am1TmLClUWLGhmvrbCDbaTmpXZ1rf7z4TaxMLKdsu0wummu/2+iIylJcsZIj3X4+wGIsixpKgqIBs75FQnwllLbEmBAvrgYYBywIAiKrffrNPUqhWSqXGY6z/wxF79LD56NfDJhVLjrqSozbymPX+9s3xvHMx+jsYoQnF6W7W/Ce+q0ZEjbSz4DzNzr9XkHUXhTCkga2GBwwNgKIl0bEzCgjpHmi5esWJ35/nJgVzPfjdJKHRon0wzoDotLUaDRkSonK0AOYbt29gFdJXth84OHCI0SCmJorfQ4tzmMDhTSaskKvF2MxFYte4INHPEEAUdKXhbWclCUv3BtDsWiLlIC+S6JMg+UUyH9SlRdtV/VShbaExCGUcpfVM6VUTBMuKZBaHlhTFhWYPKtDqmPfvE75BDdT7l+qCgfbeDRI6Y+rFyO1KANLEb9ANDHXGjWoqJXLBE4D1SL1GEAFFJI3K8DE4ZLOLuN+mH+2eZ4MlGXDqoVkgEW625Zp4CPp/WhXS0BSLL1Gpf5x493LG4RXC76B1OvO2ii3lGQqkUbj7KEsJPDe5XMzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(83380400001)(53546011)(7696005)(6506007)(9686003)(38100700002)(122000001)(5660300002)(8676002)(4326008)(52536014)(8936002)(41300700001)(2906002)(966005)(71200400001)(478600001)(110136005)(316002)(6636002)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MIJuqxtkBs8S8HpWtXvsDgXk14pyqo4D1SVxHFSrnf84SneLt7Mpy5sEBXfB?=
 =?us-ascii?Q?jkfYtAi5xcBCDuvzhGOFoK8NBwaR+cooz3fQscHNKKs9qvj5nW8thRIRmTL3?=
 =?us-ascii?Q?otBleyml8fSZyXMI/c8l/LdMSFfw0ev4tglTgq2loIBy9SpSkeQpAOGarUt8?=
 =?us-ascii?Q?c96WtJDwzvzGrpi+eaw/L3q+i1Tp7AdOCcDw1X99NsHxnN0SJigqO+DhJX3G?=
 =?us-ascii?Q?23rPNPDQatt9GHGead74F5SgYdL4oY+mUiFFSVfRCH6OZXGXlD8mWl4nlCQ3?=
 =?us-ascii?Q?MigFXOiPnFOvmeuIJ9hq8oPhT8o3DGF+qy9uZeinJF7kQ8OV7uRoO90VE95Z?=
 =?us-ascii?Q?Xew92i+rqE1HfwnRvrgFmDwuy7m2wUAmbcrh/yKUs6dRjWFT3OyKrALF2JW4?=
 =?us-ascii?Q?tfDhyPhVTpzW+zzBzxN5v15CUUSMOwo3N/TuRgCJylAn+ReCinuZz+DyGirT?=
 =?us-ascii?Q?VDE3ijFsV3jCeuccxKPUe8y5t/3xsHEUZpUIJaIvnsQivOByxiDdhx4onc/X?=
 =?us-ascii?Q?lZBTHKmqRprL/qAnC+exNMxOvlF6Kqwe5+T4E8WdspMYIVos7QKq97/Tnl91?=
 =?us-ascii?Q?qUqpBxHEBF+421od9E8Xj79gcZ0EWOSDvcCFI4uzaZXrP7YdvK7GX8eqZY4U?=
 =?us-ascii?Q?y2AoWYrCLSbXDM8d7Ivc3fQxv2trLIKTLnnNWyi6VFDTQJNSj12xdl3KpJMT?=
 =?us-ascii?Q?OHXvolY4o2WjeLrZXfg4uiRHE8wjtm1Al8YBVzUXN/8oh6f2r8Ttj9wihMvQ?=
 =?us-ascii?Q?BPIus7xZXm2i7o9LXvpiUkIV6fTiXgYz8s2eyEzaZEmARrwI5+jjgTdpk4oo?=
 =?us-ascii?Q?8UQn+ngNZ7URlI+0e/C60PZU0eeRgdQGgT3W5w6IfMc75skYgYMrnNpXH+jN?=
 =?us-ascii?Q?28iHUvXRih/P4uyOPILPv3hKslUyu7z36YuXRYwpdAuFjXwYjGy3KFBvQAtE?=
 =?us-ascii?Q?CoMSwestnDC//Hpw5xgToG7WwMLlMmmXf1AmaOpRmgVSpX7Ob+AdzpMFRT63?=
 =?us-ascii?Q?//zaBUL0DtZLzhLUqhIi5GAroUKadJsMCnRAE+WIKsw7x2fOTfaWTP6keqYz?=
 =?us-ascii?Q?KaQ6X5ctNfpT/g+kTEFi0TMzD1q2TVeUv5Bu0Z6zb9dcwgm2mvJ0r7KSwk6t?=
 =?us-ascii?Q?3ddKDG2BR6o1whwfoZfFEmyG8WN3iIkEW8Gc8qwXDICbAwme+OgjKrZqBj9D?=
 =?us-ascii?Q?TkFLGSk8CydWRZ7VBAfE3PpjvdcuD4eoEf/7Tihm/PM8ADjP+Ml8idgp5I3h?=
 =?us-ascii?Q?YDaE/KDQCuycgTTZUWX89MOoH9QQg0XGIJlAWFUDEi3XAqf9J+iUgWsLjuQR?=
 =?us-ascii?Q?G/gHapqLbVWgmYO1P5ICW6lqT878yaOGoyjE6NmxEiv/KNJvdjZOgSZBRg09?=
 =?us-ascii?Q?y3us2U5J4vWeDZ2k5xokDyvdnV7VnEi0Ec5dZLm/TwfBTXoBa2GbBArolhCl?=
 =?us-ascii?Q?GGSOxxcqiUv7l0M1u76iLxMW38m6y95WP7Idm/5y+2bxkPL+SHI6AVt3L11I?=
 =?us-ascii?Q?5KAzs3MAVaWZI8p4e+dm8UJgEl3Bo5Vzb9OXHy+dpzVjoRNcFr/WRRf4+ewk?=
 =?us-ascii?Q?ZWw4uGxsfbCKENRa06M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de28b4f1-4b33-4bd8-690e-08dbfacc7814
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 04:40:29.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUDAxJYCyhMHvu7mNl1/EnyQbuLLJQseMuFe0J5o14BwuVSVTwSk3su+G/v9rfLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, December 7, 2023 10:01 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Gupta, Nipun
> <Nipun.Gupta@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] cdx: Enable COMPILE_TEST
>=20
> There is no reason CDX needs to depend on ARM64 other than limiting
> visibility. So let's also enable building with COMPILE_TEST.
>=20
> The CONFIG_OF dependency is redundant as ARM64 always enables it and all
> the DT functions have empty stubs.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cdx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig index
> a08958485e31..7cdb7c414453 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -7,7 +7,7 @@
>=20
>  config CDX_BUS
>  	bool "CDX Bus driver"
> -	depends on OF && ARM64
> +	depends on ARM64 || COMPILE_TEST
Hi Rob,

There is a CDX MSI support patch
https://lore.kernel.org/lkml/20231116125609.245206-1-nipun.gupta@amd.com/ w=
hich is in
review and is dependent on ARM64( msi_alloc_info_t definition differs on x8=
6). So, the
COMPILE_TEST would break once the MSI changes are added.

Regards
Nikhil

