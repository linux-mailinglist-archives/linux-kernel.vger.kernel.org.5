Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524FB79736C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjIGPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjIGPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C88ACA;
        Thu,  7 Sep 2023 08:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcy1rWc7luXI+9el4kzgFaJDIWuXJOXLXzaiInKQh+/nQeslK6KwoI/0rdFacuf3RiAfPkfPJc0xLQxlUhx7zemiEOHZWwX4k0Urof3uDvBfN7LHFV4idrgvMbIbDe5Yo4hxFui106ZaD83cU7+oxv6G/fzOWSv/xjZWM8Sn0QiQtMPySplXCnM6XaZMnD4YWAwdMEnIFnDEMSOApKXc3Zzej2P3Cl39qBalL3Fkas3clEhUKXscF88gHyQ5pd0K8pbix2yKN+aQ0WHDEgZQBYrOg+hxUoT9ViqXel7tNfPjQbxN7f7CNqd2dQQBYpWireOFgNYDbvO3GxLJNpwjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSx6t3bT4KimUzRI1hhDLWFcuwdhoukQNP2Snqrq8eU=;
 b=KolSDC4oO7xPLLxgcyyV2hb6ZkjwL8NtmSMEkSZjqSSX4awWfVejccOMqRJ7QCGGret/Rxleufj1GFp/yQceOl/ln2LIhpa1mZIs4OY223/hysSkxppKHIx1wN4M1MXTlWgsvyjBer3YdAPkK59niMeaavECnqyl3wDzXH8Hq50AUOHA7Txrf0ztdyie8Dgj7m0eGI7wPYnFe6BztJ6klwcaMNyz2o/LIebR6gS5gmg+BUSZFaibMrN2LPhWJEYNvu7NHMUSPxZiAkuzPMVqJe9CYcdqYEaYdJuRS+q0sbMzBSUQcHTLQ/Dgt0dQMvQLbzhIiIANCvMZdq+NSbModQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSx6t3bT4KimUzRI1hhDLWFcuwdhoukQNP2Snqrq8eU=;
 b=uT7yBUJ9RqLISjDzMKFR16MgLu5FkGd4PgZOvaKIvavF518vZTV8sm/AIqh+bl8qHqyE6G6HUE9OEoL8mzZm/RvDmMs4BA6fKUAeFocqpqTMrN7NrjdGMKh4nVsB1/SYks2WkgVCVGqPAkNweXv/QgNTd+PSKYEHTpKVYhVvcI0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5328.jpnprd01.prod.outlook.com (2603:1096:404:801f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 06:46:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 06:46:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH v5 1/2] hwmon: tmp513: Add max_channels variable to struct
 tmp51x_data
Thread-Topic: [PATCH v5 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Thread-Index: AQHZ4O0u2EbbAKg7d0mHQloM6sSWybAONqsAgAC1SqA=
Date:   Thu, 7 Sep 2023 06:46:09 +0000
Message-ID: <OS0PR01MB59225E213906BF426C3AC98686EEA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230906180837.284743-1-biju.das.jz@bp.renesas.com>
 <20230906180837.284743-2-biju.das.jz@bp.renesas.com>
 <ZPjZfK7+4jW3AFEB@smile.fi.intel.com>
In-Reply-To: <ZPjZfK7+4jW3AFEB@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5328:EE_
x-ms-office365-filtering-correlation-id: 19975214-305e-47a1-7eef-08dbaf6e1ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOEX6YEohNZ9b97PY/4DaaAWXdW+ZxO+0MNGmKZh21Z+PFqWYDJWNdtiIsv3QfsIQn5Y8hraIbdQ1CSSvv43cW8DytsWQyP03g9W0GpsStKtvP0XekmQhvRpt/r7XakwGmikpzTUeJbrcyhG/Nx83TTx5BIvdJnbY962qSON1NfVNA0icMgTWmzOOU9XMn74Xf45EauzngWN/xwNEDw3gywsRxoK7O7b7+6RtRZwRkYjpyj+zRyLJKl2cVXUAQzOJgpo+SRIhMYYmOZPRDJd2j8x0WmDNd2L0Oz0RFFhTvMEDe1Rwrm/3KcyBDIX2a91nNtqt7Hof1gOSKWPCCHff4GdAcliTEzY+RbmFd4LVPAuroeStP6lTaAkztBmB+tMN89sCiGMOHGsfo3DvrL5JJTWQ7nqO8m+VOvkwRrg6P+pY58nIVDglR18U2Clz1LtKBNTJ+D/zrfzhRupAObQEsvHv5fUJSR0sCUSVSl0oZhCW6VmfEP88RmvkGLRtfQEMuByWE0O7Adqxlo2CPhYC2cqD6KnlmRZkYneqIZBujr0CH9kNzbtMmGRgwogx1wvDpwrN3oHJNojii3DiJAtUbrYScxAJzlACVCPWb1bqVhcSjB7m6dYgAgBGL68aez4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(122000001)(6506007)(7696005)(9686003)(8936002)(71200400001)(33656002)(55016003)(86362001)(38070700005)(38100700002)(478600001)(26005)(2906002)(83380400001)(52536014)(4326008)(41300700001)(54906003)(316002)(8676002)(5660300002)(66476007)(6916009)(76116006)(64756008)(66556008)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQ9UmJOa5NO2qUcs8XcMdfurhLK5cxyNnJNyq6Y9sYQv+3tlXLA020MK3Zud?=
 =?us-ascii?Q?Ph2p/xmB8slVtkqy1b12qiKIGaFSSPup0nzOlzY8c5mQ6H6H6RXoTHIwJd95?=
 =?us-ascii?Q?A3Cyr+wBTAUyPtNEmoMRPyf3do3meM01T+hAiP8pCUPRBahxqrQFjX8NLotw?=
 =?us-ascii?Q?1be8Dr3UaK5j0MjoratGjIMG/OBGizuccT62uuulVYc7b6kVs8hw9rwjs9rw?=
 =?us-ascii?Q?9geQvVi/enczP6Ix5aMvAKvmFZQLVKdTUeFndQRv97C5NyEeDAJShBoBpQCI?=
 =?us-ascii?Q?/hF2SBRiKkkDVYzjMWmx07kUBgLhcg0EqQGXh/N9djmVqvElbJVarFhTtxAg?=
 =?us-ascii?Q?8Mg3RvXPib+rdKQeT8SwvqlVW/dtmcxuYxYq156gZnZQ0tEt2pPlT0mY4kKK?=
 =?us-ascii?Q?F/DY15ZrMynCtmWjahVeKUse1yqPfBZCK4gNlRlhPb5levPSdqHAfv/sEYVX?=
 =?us-ascii?Q?uR9i3ciI3YXHY+qEnaz0mYmR//eGzVGCNCs3hmv+WVwX0ukelcFMkk4nM32V?=
 =?us-ascii?Q?elFQ1RCCjSGgaEcdlMLMwqqdpYBhsizg0M54aTDSrv0i3aMO8WCp5HnvyD8J?=
 =?us-ascii?Q?tCM3pplRo3Nnk7g/x0UXkDCA735cEFo/Ga8n/qhwws2AJSGH6vTLYA2XOSF7?=
 =?us-ascii?Q?Nr+G/0b1xkFXQEz3A2cKYKLAL5IU6KJufkiyP9hM6KYWHchh4qNdWXFqCJTM?=
 =?us-ascii?Q?QEEdPxLAU54DjFdrZ2MyFZBgciLdg4EtMgqfgapmmaviM9Opt00qjYRECnWT?=
 =?us-ascii?Q?4XoNa+oCSefpPSC8d7LAzQffBilKa8uxFmN8ntL1UKCsH3hdA4Gx1tlEW38I?=
 =?us-ascii?Q?LIjPfSRCxLlkCs/UOuotlj4xIUyG+xBVHiI+4uPGgGAVZXbFOSmzNiI9hahc?=
 =?us-ascii?Q?2X6fKCfjU1lA9LlmwOM5TyCQQ/AWKheMe8Y4lhsewGd25M5V1IQElryrvSvT?=
 =?us-ascii?Q?xSe0oQ2UsSa6kgNCbGQkzoKkMouJwNmPSewmmhe35qzsvrQYU81VSwIbN89I?=
 =?us-ascii?Q?ZiRiDYlHy1aF2ClMPFP0bX+/UXzUOmZ2V5CbWc8gfFzF7Zh9OCBVJMCJ/SwO?=
 =?us-ascii?Q?rg0xXsEd9k5xO+7dSE91JTqdVhomNDxySGHFEJWoMvil65pCj2cUSgy0fcH1?=
 =?us-ascii?Q?dzLeBK8nkvACAEfD0DSPseLf85MnHnKGZDIgBr/ztbOmsx2qsONiwm3dbXX3?=
 =?us-ascii?Q?t+eVCp9wpVMbMw94teArKjiURM9tScFo+O17tJAlCAzTqyaIwi+lNtec/1sn?=
 =?us-ascii?Q?CwGQB02oV7Ww36p6B4ryLM0+h7igPaAp/gL8zyFlHIzJRAxuDKNc7kV9FcJB?=
 =?us-ascii?Q?PlAGlkdNtGlIcsITULKWm6MH/unR/oYF5umrWfrjMD+/XW5jYR68Qg6fbKgk?=
 =?us-ascii?Q?3y4SJOeh9sTy6HI3x+Y9NqxjTCJiKmwt/0n+Yfk3EwBt3/N0j9CYVX17XcHS?=
 =?us-ascii?Q?Ip2wOADVMQ8BEwRxVwqoDrXkdBTO6mr8pq2/tGAcDJPAJVg2z9100yjqyWsf?=
 =?us-ascii?Q?I+h7hxLiuuYK3PBjpOx+OF0T43PAwTWI3pGBg6Z6b1qvHyLowezD+GdBg1/I?=
 =?us-ascii?Q?LKJbic+5YiQzwyYuTQSaHsd9G90ghTBbeCWZXwC35MxNvkwr3uzdNBmfkxEn?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19975214-305e-47a1-7eef-08dbaf6e1ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 06:46:09.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTk+zRbrXLLrlw/KsNZ+d/t29KFXFar1Iq71bGUMMFvsAhcJ2MqRqgseL9XKwYdVKVTZlHLU3agmFmJH11gQLWijt57NzzFEBCuvHbvHmIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5328
X-OriginatorOrg: bp.renesas.com
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v5 1/2] hwmon: tmp513: Add max_channels variable to
> struct tmp51x_data
>=20
> On Wed, Sep 06, 2023 at 07:08:36PM +0100, Biju Das wrote:
> > The tmp512 chip has 3 channels whereas tmp513 has 4 channels. Avoid
> > using tmp51x_ids for this HW difference by replacing OF/ID table data
> > with maximum channels supported by the device.
> >
> > Replace id->max_channels variable from struct tmp51x_data and drop the
> > macros TMP51{2,3}_TEMP_CONFIG_DEFAULT as it can be derived from the
> > macro TMP51X_TEMP_CONFIG_DEFAULT and update the logic in
> > tmp51x_is_visible(),
> > tmp51x_read_properties() and tmp51x_init() using max_channels.
> >
> > While at it, drop enum tmp51x_ids as there is no user and remove
> > trailing comma in the terminator entry for OF table.
>=20
> ...
>=20
> > +#define TMP51X_TEMP_CONFIG_CONV_RATE	FIELD_PREP(GENMASK(9, 7), 0x7)
>=20
> I also commented on this one. Any explanation why you didn't accept
> recommended variant?

I missed it. Will send v6.

Cheers,
Biju
