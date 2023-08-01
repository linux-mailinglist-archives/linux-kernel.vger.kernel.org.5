Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7351876AB28
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjHAIeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjHAIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:34:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C010D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQaACctzhACAUU969WdkKD+c5mNIB12aL55c+SgTRxZSJ0npySdokogOv/ab/K5AjWtwEjOQiJjjDHUNZG6+beYgxvGypX38VCt4ky29Ntow08IZNDte6jNNixDVlZ6AYCWB+2AinKrC6pRFgE2IKRDjRImFtlXw9dTUX/cF3w9FLubB51A7MNi3keCKq8mlLw1FdIQE48KbIhQl/L9UyxzYkqV6VoL8N2IHYylW0AAXmg5FiwQWrKUAmbgZflqMVh9gadw3+1jVtmltpJtGFBF6oISDYepVnkt+fIwqfQdkx23FW1JmoLYNL6JUJ3pjSZPgxRFa+ocngJAobwkXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uckk4+2TBpOCnnWXX2AZ24Brv77n1ndYhIJlimYpzvo=;
 b=j71YIdXUq4EX1ejA7CwWtQ04mI9ULutn6RAOkdkFxLQ8BKPJPz1I+laOCjMsx4F3hA/Ee2ZPgvINHGhLCx2yBZ1/hPfYWi6eYgOgBJY1D8gbtpPwkMCbGGtq5WLSInSrAg7RoLBzzjkGuodwTl8Ym/h9I9+3TeergaGhqqj4PrtE+8UkZFj6CCSXYx2iYFniw1rTgEi9Jd1Q52a2gf+sU/zu6Qu2dp8Utad6FHKRYlwm2K9NxFHRftA4QdIS6B9ga/ysWJMhkCIpRHq6tzLtvHTfOjxgOxlSy0XKa6Dw9i6/TAOtRAvy3UBt0ARxU3fhuQzXQRhVmzljsprJpkAruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uckk4+2TBpOCnnWXX2AZ24Brv77n1ndYhIJlimYpzvo=;
 b=A3Glg7VJkpd1yfLPt3TikiyXjm3RehHL+HhtT5zmXovDSV8p/9krubu5CM0cKOkkyNIf6dVpBpk0+POcQQIDJOssFd0iYfx0uIjU6kMw2rwjm9QJ7GEdF9oqXovkdd0tpOoTGgyFFpRj2842Eci9aZ/ElIH5eVOuWcLVj2Ph0wA=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 08:34:01 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 08:34:00 +0000
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
Thread-Index: AQHZw6fpekS7+sewHkWP9KKMIHa4dK/TzKGAgAEccwA=
Date:   Tue, 1 Aug 2023 08:34:00 +0000
Message-ID: <DM4PR12MB7765398763E00B565AB1C6DB8F0AA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
 <20230731120813.123247-2-abhijit.gangurde@amd.com>
 <2023073148-carried-unshaved-77e4@gregkh>
In-Reply-To: <2023073148-carried-unshaved-77e4@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=9db3b4d1-987c-454d-bf85-82ebc4c40750;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-08-01T05:23:11Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|MW6PR12MB8959:EE_
x-ms-office365-filtering-correlation-id: 81b9860a-15cf-45d5-6104-08db926a0dfd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcjjgDrNBGX2x7I+AfrgUX7EBFh9nR+KKv7u2KQbxuM7WfzbjQCwKzDLUbbtiEnG908piKytms1EZsKfpW3BDPV9V+8yYWdD4m0tv/qMmF4tFLu9Ar+fIMtpnZug6za/ODY6NuKhruqySjg7WTWPc5JmbceiHm98zu9HkuzpyXwCiK39vyAAWEo6oPZrUV1MdnSIwZKSakDNG9H71ulZnBrJRve9YDI5LXIRqAxIG0T9L3Sf9ETeWoCuQOdUl/SyZ/l4mGcn6sTDQdmyiBHfGLrexMNE7DssRUKAOxO5OvTNBwsxihq/7eimiwAQfW8fBdDBjM5z0s8X97gDEsTemnn9NO/Ydl0DgNWe5VzUHWjESKIkvI27pCRDf+afz/QkwtWE+vAj6YHJ5zi939yltH2oaVhzGFfFGjRAQtrwDUrtG3f3btm1Bgi+lCjfzdjXUruBruEiCBqRH8HjCVO0vYo5W8xtHjvlWQUmo4WJGBv5DO0+OkPCKvKfcGxBkv7OyKYXIZSYDjvLQRTxrAZMXR/6kBOm/9+TbQEkKWTNwQUMdtXSVTfSvRIzD1yL7YnM6EDIj8p1YtVlcN/FyxJwdDUVz70tN6xREYZ0bzwWHr+vxla16ZYCqmZbQK3vUSf7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(26005)(83380400001)(186003)(76116006)(33656002)(66946007)(52536014)(66556008)(54906003)(122000001)(38070700005)(41300700001)(38100700002)(86362001)(66476007)(316002)(5660300002)(66446008)(6916009)(4326008)(8676002)(8936002)(64756008)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0DHHiRH0RcjDPQg6CTYuhSDwBWDJnAQIMpseIXE5J/G7saP/pD1lwFqMiIqL?=
 =?us-ascii?Q?9lYAQK/qm9HPoRtFP+CD6PKfysDxkZFm/ExSGD/6P1iFI7yqsnwZpnf6ej/d?=
 =?us-ascii?Q?irZbIoFkvtzzI8IQ0EU8iEutEHgcyfPn6TWveko3yPAlStfonkQfnHj9btn5?=
 =?us-ascii?Q?Cx/W8qq8rZDJyeh2NjSD2GH/pNdf2waV5X6SuYD0Pa5hgxKaZsDq25uWmYu3?=
 =?us-ascii?Q?GCRul4kHYEdjBHsoDwT2R93rabPcdoCywKmEACmN0yqIr6q7jssTbDVp9+pW?=
 =?us-ascii?Q?5eiQteMNV7+cRFgtSvX3fsZOPIIAVwMcYmVdTUFMKsDLUFOfjRxMBVPXz+m/?=
 =?us-ascii?Q?VRBN40oCxEeco51EiRRWtNyFn5I3triwFtQQo44JDvY/aBy1SjGX3vvsmdt8?=
 =?us-ascii?Q?ZD5Xg9Rh3Hi5IztsyOcydxBnZ2cFFcmr4p3B/ypMKXPd/AMUncizT9/FoQnR?=
 =?us-ascii?Q?w6svWA4cX1R1P+8DhAcC6AfINzX4lgGaEihVeSxcn5k23nwpsvW0ZqmyK58I?=
 =?us-ascii?Q?x/GQNp1QvqnZ3uM9t6GRyaf6bZPyCxcLiIW/oCFlv6XdD0r0lcPQDOQzz/WZ?=
 =?us-ascii?Q?2kVNIkA1OQ950VlbIteqhaReu8BDtW0iTTsj7QQ0pKxWZWpLiNutE01/beZF?=
 =?us-ascii?Q?dskCRbibWWP9LygWFKiA+mIihCpxMjradPxYGzM/QYMkqP+Q+HyLdRcHMBN0?=
 =?us-ascii?Q?eoU3SoxDox+RCgcTQILsbXuUTFdiQ9EoLsCtrOdc6hZV7LbvajEbEGfew7KV?=
 =?us-ascii?Q?+mdTmjgpJnFJcO3HF+9nkVa9gdHQhqe1l48xB6yQFMLLW7/Z+1QC79FM9db7?=
 =?us-ascii?Q?aM/udbrBeENoyuetdaYrQdmJiJZyU+Kauyc3aEwjpGU4TOesbt5sz37wPjnA?=
 =?us-ascii?Q?XSVif3ZkKwutoubY/Dv/4IcxAdHIWNLiNgmb/y7UoGn0XcI1V/EsdInRDwQV?=
 =?us-ascii?Q?N9GKIB2apzLyWrv8BZIIV3On1GaZvxuAT/hjHurTGNruMwsidKSWI0HMB1QC?=
 =?us-ascii?Q?BGRhoghAWNbxlFRNPyMzkrcCv2o8bmDk6o1dHbnQwLyGX5qlDaYzis5lrwaa?=
 =?us-ascii?Q?E/Fl8/m7H3fYH0GLZugDolZafeXLfOB1yNe1XT2G/ndroH1uVAgXW2j27Bs3?=
 =?us-ascii?Q?wPKN2UWOOXVfbdnrqEmO+fGjZmyRHBPj3o3pXweD+GYoR9gus5BvyBNPD+8s?=
 =?us-ascii?Q?6VFDykDNO2cd7TWQJ0kr9l8Uug8oB5xU07jBVX3xyAizgPFH+kuTWPwV8u7G?=
 =?us-ascii?Q?P8jrtpMCtuliQ+1jE8ArMnkf5KSbqWyeTlUkn1rzF131z2rhs8L67Zi0RkS1?=
 =?us-ascii?Q?g1YBMntKXyU3tcUZTYEprtQdy2DwlwRkK77nVOQhX+P4BukFfevQuXgnu4ki?=
 =?us-ascii?Q?jCC8JtQmBQ2JBJDKdWlh3Hp+0XZ2hdZUn4wsN7eJ3Zh5WXHAa9gVuEZ3Di7e?=
 =?us-ascii?Q?/mNO0CindM7YjhwEz2pvBQetKOeXzRU3PPu/RA6NnFf+VantyBeWW+KhYw/2?=
 =?us-ascii?Q?chU5J5GJJdSExLKChpA5vWGNwlnNqBM6gbSk3KLSCcDkOejo+4DQbRDC64hT?=
 =?us-ascii?Q?B7FDLbW1iT8DcuDRCUw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b9860a-15cf-45d5-6104-08db926a0dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 08:34:00.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fh/6o/cHlRy8kDeq20hM8zl2AK/M8QxlzH0uqxqMTwwqiENx1iTQYw7HbzlGmirxWebB8Bcn+RZPwJcMCPK4jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, July 31, 2023 5:55 PM
> To: Gangurde, Abhijit <abhijit.gangurde@amd.com>
> Cc: masahiroy@kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Gupta, Nipun <Nipun.Gupta@amd.com>
> Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops=
 and
> controller list
>=20
> On Mon, Jul 31, 2023 at 05:38:10PM +0530, Abhijit Gangurde wrote:
> > Add a mutex lock to prevent race between controller ops initiated by
> > the bus subsystem and the controller registration/unregistration.
> >
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > ---
> >  drivers/cdx/cdx.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index d2cad4c670a0..66797c8fe400 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -72,6 +72,8 @@
> >
> >  /* CDX controllers registered with the CDX bus */
> >  static DEFINE_XARRAY_ALLOC(cdx_controllers);
> > +/* Lock to protect controller ops and controller list */
> > +static DEFINE_MUTEX(cdx_controller_lock);
>=20
> Wait, why do you have a local list and not just rely on the list the
> driver core has for you already?  Isn't this a duplicate list where you
> have objects on two different lists with a lifespan controlled only by
> one of them?

cdx_controllers list is holding just the controllers registered on the cdx =
bus system.
CDX devices are still maintained by driver core list. Controller list is us=
ed by rescan
which triggers rescan on all the controllers.

Thanks,
Abhijit

