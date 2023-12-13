Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972BA810914
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378503AbjLMEWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjLMEWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:22:08 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A5F4;
        Tue, 12 Dec 2023 20:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxoQv/mdVF3ZTn2FkOYXZLH+w+Bg+kMCf1m/q0JRnNCfh/ep+W/NLgDTRkY8wMntd2JaELwbu3ZTHOF26vaGHap5rAjCIGK2iC4TAPnDrspVS/goXDeh/FteRnFXJ5t/OabPLSpxOYc1dLxdszSl4vmx+zgqOYmwxOOonqYl/aSE9gyAnLBadVLYa37h2ZYcfmxeKeuneb1OCnFg46NzG66F8VSJKAPAAT0rZ/GKQgi//pFlVheeghbURovBz5hkENEkgkh84vWWxd8C+g/SJX8eq/EefyRC6f1FXbd37DnLL+N/htPyj70tWmtXIROSYwU+IDvyj3t9/DwmqA8qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBKXS3YfxWDgUQLQza8GdL1yH1nu1sHn0eMMeHfbY2w=;
 b=aUgqaZMwrUyrkqEp0GSAkDbzTCgOwOUYX6BOTZPZPVPaujnuWDlz2ml8NCujf6FHWDL/0J91sEXF3UFUDKvt0VAOi+/v9rQsHIZtyX6Y9xKgn/g29sKuS/U3XiQQC5lMBDDoKPWqmbYjDDtSbfJzCstG+8xeCrjrUg2dGUh6amYl2VLPgv3JrEBVYDEpOYf2cGVTKc7B+SE7mBxshgQgBkiWWBiX7V+acHvstbni8hpiUwp09/95EOrLK8w2/TenJhUVloHFJAcZRM0oDwneX+uf7DapuT1qILCKmCtgRxtwPDi2Kf+1lLoM88ofr5r3YouxF2hWXzRGPzaC/UUYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBKXS3YfxWDgUQLQza8GdL1yH1nu1sHn0eMMeHfbY2w=;
 b=2+MQ2h+OhWt3/Rh8hoSzf6rp2sLnj/LD+dWmGao9PWmorQF/sszCnicaSWbsoTipFU6Zl84KMPi96Vybim8XzcAOa/fZmT3eHdwZkk2aObXSRVrfPd22NoFb+vGOXIVRAHv4ReGNO6MDn57sochewNZNomLngm/YltXeyc3D/LI=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 04:22:09 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 04:22:09 +0000
From:   "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
CC:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] cdx: Unlock on error path in rescan_store()
Thread-Topic: [PATCH] cdx: Unlock on error path in rescan_store()
Thread-Index: AQHaLNx23xt+wQ/Wz0q04USQgdvg0rCmnc4Q
Date:   Wed, 13 Dec 2023 04:22:09 +0000
Message-ID: <BL1PR12MB5333F431C1E6BEB13CCD9E269D8DA@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
In-Reply-To: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=47ba61a0-17a4-471c-b7de-5f69a29992ac;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-13T04:21:18Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|MW6PR12MB7086:EE_
x-ms-office365-filtering-correlation-id: 4d0415a7-b1ab-4292-ca9e-08dbfb931281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKVbbKDkGPrNoT0fF/P1Acyzw/wg24GZn9G245vcWv6t0Zwi6ShFE7o7o8I0HWIU26Xpf4jrwvv+g+kkOm90HCvO6WaLdgnsuSY/lJU83JIuzu3XKyR3l4iG8SKUnR8GmArhFcLjTA/0ZNiPHaSWWi36nydVCqg3BFOlOwkyO7TQbYV79Yg+F57rIe0Mjj3UguoOl8UCof8m1GY75xv7zYoVCh+4Zw6+yj20RS6SqfQLJ0WWxR5kO43nhNQeZRer/5JdLZ5eJQI4mP3JKhaGfVzoNaeSq7nIO9qIo5P140iElwe55VP0bWUPs6dyxVge3DR9Ms6RzfYkdSuKxbN5M6MCg938vxRWIxWOJ4NF4cTmek2F+9uoR6oILnPKhTW0nSP4y/148/oxkOcel3MT99dgS+qNJZhF6g93wXoQDltKa1VKf5xdPk53qOeasW8N74sXOoME12bJC02LorxgjBSOkBp0N1ZzzCOsyR0YViNF2JwVb8pxWrlvk+8VRyji3f/KI98vcR9VoLKCjrfSQQbY1DZnyR810ghg8B960e+zNKCEqBCiFjziBvnkpwUuhyvcmuIeRdMyZa5i9oMz2cdfLqEDZKQOanK/YFoTYSc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(4744005)(2906002)(52536014)(5660300002)(38070700009)(26005)(83380400001)(55016003)(478600001)(7696005)(66446008)(6506007)(9686003)(33656002)(53546011)(71200400001)(86362001)(38100700002)(122000001)(66946007)(66476007)(64756008)(54906003)(110136005)(66556008)(76116006)(6636002)(8936002)(4326008)(316002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NkQdVowan+I5pMUTUCEgQFYSa+j0ScII/XQY7lEvjFBnGn+VB4KAyICj80+b?=
 =?us-ascii?Q?EJFUiKG32lMBHcDWVVC37HpKet/8AKcIKmG/pnoPm55Sdr+KkPfZulEI4jwQ?=
 =?us-ascii?Q?jSpgLvc5SjDGjnFYj9zrPYmyH8fDGcQP3H+xovtF29gEoPCaX8jyRb0xOwuj?=
 =?us-ascii?Q?m8fMbLZ8UwETG5KaN1qa5ZBv7r9T5VylV50b+b90RjFGUYRnw3Ow9CYrCIOG?=
 =?us-ascii?Q?3hmB/DeyCNDaq87g/+JklWCu5colEOZTSnOD70dLQ2bQcoIXFti/CQkd/LEF?=
 =?us-ascii?Q?ylotTYGmgOyVGZbbZmPqGBGisdr6tFGBvqYKUea9dtlCZDCWMWT2TvhoB14u?=
 =?us-ascii?Q?WGFsKQCjug0HHQacJwD6cM5JzX4uWSP03CXExKc4sjo60VI+DRZJqJmC5yb1?=
 =?us-ascii?Q?Kj2U4JNjoZXYPcmlsz7QFBojH9v+nwPF1tVtwohVZd2kynWXZp9dmlUNCVzD?=
 =?us-ascii?Q?XFNuKcfMCa2EDMRSfSIzuz/Pt0ElYgPrUEkzgrLwcBdyBcaxY55GRdiez8m4?=
 =?us-ascii?Q?jXGfH3ofWERP/FTrEBGCds7WKOF11PmoxlsusSpnQtaYSDtvvGJgB7lZZuM2?=
 =?us-ascii?Q?UrtbkA+WfetpEpXOTpcMgYMGm8Ri/kTaWIf8tHnGjqFEtX+5RlfgV0igFsZN?=
 =?us-ascii?Q?hSPnh74NlGxCqmCOxSyd3mivbpk/zGWhT6dYJ19iDjjru43OvTr53VwZ7bPh?=
 =?us-ascii?Q?JPBDo5aQlNU9m3pQg2Vjb2ah5o6554VzZmIelcPJBOGU7diE4xuCk/TRYJWx?=
 =?us-ascii?Q?M5CMlWcB1QQWnf/lVpRSWUPJONZGFwjFEmpO+gmgZjmPKRBRk5k9mVMiVxiO?=
 =?us-ascii?Q?lMdJeIXu2XvrndEqnZRJIkirNjydhgo0CIZLp6rKDIIwkU5iPKE99ssAGe2h?=
 =?us-ascii?Q?G01YxmW+ubHdxAbBm7eGelJcwOcLYUsP1tz0+lsiDjh+B+gT+ibV22eLGE3M?=
 =?us-ascii?Q?0dT+E7j13Bpt7OvCqe+Kqg0VgrkZsm1e4Uw31ifMKQNUQ9JPkRVe4t7ne7Hh?=
 =?us-ascii?Q?b3VjAUwrzFnZCKUtgz+IEeYsXE+of+YaxRgZjj0Sh+CfDCPStD6SxlESCoLV?=
 =?us-ascii?Q?senP0N+ION8lzPgbmr08Ymba0F5Q6iDEtOK0wY+bgs37qTSUZ428ZLXRYAFz?=
 =?us-ascii?Q?RKlKyM0SNrWNtbeQj8yPTCGMahzuK0yVaPWBy6p1IzWUBmxfo5zkEvV++Fns?=
 =?us-ascii?Q?4S8NFAAONVUwY1m9IhtDQaZ5liNYrYZ0Iub5wc4dlkJTBABbivEy0wRXMkiA?=
 =?us-ascii?Q?sQt3Hi9+7uWgKxvf0yZ0RNUSl/OXBnvluPw16fj7AJVLTMC+XcGalcqS/ikd?=
 =?us-ascii?Q?dDOtYuhpscaX5YuiV40iceMdIt48I/9c8KCLwSco9pAfzRxQFOEH1Kzw6ptT?=
 =?us-ascii?Q?wWHVz4OUW9nT3p+aH7liEKwArULF4L44Y0YfmmFUwMFPDSmB6N3WFlHtxeoD?=
 =?us-ascii?Q?n+5C/L0GSWhT5GC9aRYS2uxwk853la3wvfd/M/WHJoFtikix88dWsdGoSjEw?=
 =?us-ascii?Q?mc77Pg8ahAE76UgWdeqduZ0xrYxtrAyonoaU3LgCQGjSh/j8eOqw6U+HkkJ3?=
 =?us-ascii?Q?TqDJC8n4Z5WeznQkSic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0415a7-b1ab-4292-ca9e-08dbfb931281
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 04:22:09.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzzeypcuqmCdfiQ4cpMMREoAdYo2WkslNHXqfbHbj2qru2bVGK1srSppQ9uiU8PJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, December 12, 2023 2:50 PM
> To: Gangurde, Abhijit <abhijit.gangurde@amd.com>
> Cc: Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH] cdx: Unlock on error path in rescan_store()
>=20
> We added locking to this function but these two error paths were accident=
ally
> overlooked.
>=20
> Fixes: f0af81683466 ("cdx: Introduce lock to protect controller ops")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Nikhil Agarwal <Nikhil.agarwal@amd.com>
