Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E182C793F38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbjIFOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjIFOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:46:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B0D172C;
        Wed,  6 Sep 2023 07:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U82CprMjs9ADaQpFEAk7n7HlgcNgj3CC3Aw02YX/KaKoc5U/EOJUN5DxiGywG5HW0JRhNNwyBnuS96Hr0PTK6XCuS48SCX3Qo1VfxMnTZqjh18HZr0LCd03In2FoLtWdFwv03af84QJASu57fPhHiVnbEOEW3tbKbmqbBUsZeikqp2s6T1RrB93XPT08d3+h0ETIXP04VVo+VKUx9H9LgqmS0PE4HDNIURRZ008fangL7ikGFJYKLpB4ZU8RZMWc+aRPtR6aC6HxqdWt/DZblyKe/VxI1P85z9iWBuAa+JrLz9lqdgjojQmTpLhpkjpm+liUFk7BnD3DqAXCbzvF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCOflL9qYf1Eo5YWtL2dZ13FkDrwyOKKDxLPgi94kiY=;
 b=Dk5uU2GQrgOrELR+5dxTDXHA5v2Sv9iNX3JhUBIbWNN54s1xI3+CvDO8MeZ3Uz6yZP/unGJBTK3UPaOgD/sxeOiDX4wzwJ90oGme4bX7qXmdiksG9FD8NQG+CCjcJCFuaASZ/63cnJELZEGjCkHqIEEfTMaybpBaI8u3XR9Iwhyz1+Y+ebRoQT5JPP1P9jjbG4g8rEh68a/YE8w0wEGcKFWhUyA7WkkElOF29iQayx4fqNNOeGhp3vugRA7WqIuYLWbbwk7JLtfiAGdbH05+cswAytcwvS+Ygq8BS8V4x0K5HDq3qKSEMmGIhgARJVBBPS4jlV5wzPhEBgZD0I2MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCOflL9qYf1Eo5YWtL2dZ13FkDrwyOKKDxLPgi94kiY=;
 b=Epj3fWzJUo/cLGn2wUq1gPIXF7qjWisFm0oOy9mp1xGjVMtYnWuteAP7MQ00BJGzKRGEsZZK8Tj0XacS8GqBaBdfeq7XH7OjcJMLUyNdVDQmgVZl1vo1dXb4bxyhFIMiwG5D+4a8W8h8c+HY4BNFIZFQ6FmU3N6Sm73esvD/wOw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6297.jpnprd01.prod.outlook.com (2603:1096:402:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:46:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:46:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH v4 1/2] hwmon: tmp513: Add max_channels variable to struct
 tmp51x_data
Thread-Topic: [PATCH v4 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Thread-Index: AQHZ4CjM8VnLqJ3pO0KFHHbA6IgPirAN386AgAAAiUA=
Date:   Wed, 6 Sep 2023 14:46:37 +0000
Message-ID: <OS0PR01MB592218CADC2F90290B0B727D86EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230905184252.222742-1-biju.das.jz@bp.renesas.com>
 <20230905184252.222742-2-biju.das.jz@bp.renesas.com>
 <ZPiPVZKXeDfLsU64@smile.fi.intel.com>
In-Reply-To: <ZPiPVZKXeDfLsU64@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6297:EE_
x-ms-office365-filtering-correlation-id: ade956f6-233a-44ab-feba-08dbaee812f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBApxlAdIUBK8uy7S1qhdQCLyWkTJ874KM+75NzisRPyYsYfkPfdnNIsh43kuBSDX6CgD04M9uK6ipH7ycwb8OtJoIV2zwC5JYbcNekBGCiDhdxY1D9l8E/h3o/NZJb9RHzmQFNuMnRDt8o+9tMFKza0cz1gRyU+OhYOolnyMcazO5C4blOO2MtpA3U/wnGp6UF+LzTVI/ptE8wqt2S8GIsvu09jbZTTkK3L6lLqhCdyvEmJSlMzEdXKDS5IHPX2U9gFwsey46SOPTgUGQxnjXnwylwp6lv0xiFH1sInTS6BDxkjBgyWI0GebcVAeRXfZ+cJ2ncPJt+RA7O3nT23GZrovSKPyxvnoWEXpbXpko2Vxt1Mm8idjGqVAndwPfsvg06eJDCXP29XctC9bLBH/Q/Gv6J2qM8nguE07boHQxomzuVOjwCnmQWzv2/zVt5683jBGgL8M6A1qKoBbWP6j25aXdfJHeSvd8sQeIIfopXavl+YpKJgWzj4rz/CzaitCm0O9AkzFsNrC2+jLnMld51/vUEaz+5ygoFw12OU7juXyosRDiteG+Gggcfn6GBJw1rNAAJXva8zpWRGAloJxK50pEAQrpIWj4JTELnRjBU/SyHQtCBc05SYsC7JqB17
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(7696005)(6506007)(9686003)(55016003)(83380400001)(26005)(76116006)(54906003)(122000001)(6916009)(38070700005)(38100700002)(66446008)(64756008)(66556008)(66476007)(66946007)(52536014)(5660300002)(316002)(33656002)(86362001)(41300700001)(8676002)(8936002)(4326008)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GrKD2GJ5O9W33atW09QWDqURP2IkUrdih23G5ot77yTq4qKWhu8sfmGii/QE?=
 =?us-ascii?Q?ibHq3Mm1Y8/ilwPXj/yGtpwN/HQA4NVjwQ6PnzEITAKU/m7aHt+Rq3Cl0S6R?=
 =?us-ascii?Q?UBTMnmrlSjdvBjU9Iz7eKlIxbuS10tAVzsHCDUs7tGZDLKqRDcNCg7U1Z+Qz?=
 =?us-ascii?Q?pfLyYQJL1rDnjKYrMn0bLs9vOHb8IPt5EDuLwmU9kb2ED4qLG+A8MzNIfskL?=
 =?us-ascii?Q?ET5ov9HzqIKX3znXA9UJBMJChTJMYK1eOwEozgFwp6D0TjLkO4AdU8pKm3UD?=
 =?us-ascii?Q?Su+uAOntSVMBWI+7QiZbIMowVvY7rbz8DwdfBQm95gIWQqobKyrTLU/oiyD3?=
 =?us-ascii?Q?Go6ZoNvTYoxDxqnSgMeyZ16Ne6gzkUH8KmQYdaNSktd+2R7iwi9si6NPcayC?=
 =?us-ascii?Q?VmsJMZkZs5Yt/XK2csRrH7iwoxIaiELctTGJB5QeBAccXSET8u/pTLed4cqr?=
 =?us-ascii?Q?A51wAH+y1DnKWY9my9rPKftz1Qac8T1g8J66V6n/pizy2qbQ+ecdnfTxKpD+?=
 =?us-ascii?Q?pMCAHOFxWYaBMZpZQ8emcrZEgtLxe2+2egizlU6mAfjKwHpHOq7Tmphjh5eh?=
 =?us-ascii?Q?MWHA6R+GnSquwPkPEpr9ewAOAyX/xmGKwqA+oCrW/58sWH1eeMquj5jem2KC?=
 =?us-ascii?Q?2bPWwckUHnTvD/vUNJrihVkNXuZPQlbP7NFRC612gDA6zs25Xd8Td7eWSACz?=
 =?us-ascii?Q?H/jT7cBe9hGIE+WbLlGP96h9XWlYscv0T14i2L7kw1aoNiBdkjF7PFsBZolc?=
 =?us-ascii?Q?7uJvJQ1Atc7i6W/knhlziyovMQR9nVaWr3i4rUg9MmNTHZGHtg4Ln173yRO2?=
 =?us-ascii?Q?mTCdmXzDBt+F2Yz37YHntOSRNewIUlFfBSAX7UtOpquKTO+/I3wrx7eY3ldh?=
 =?us-ascii?Q?7a05aKOqXhkhXdml3ESRPmr9z+qAesZ+IsPyRy4XKk66qekp2SXPFNclVTfZ?=
 =?us-ascii?Q?E3cxnrQuQcviOT5NOvt9JSOHCKjGlJkgs+8yxxZZmyZLQrHpnrUXG3GMsbF8?=
 =?us-ascii?Q?gjg6UHWLIPJDSy8KMY2ewSHE7v3KqVEL3eZMhyu2hSmNcsSWUDg4JaJZ5llV?=
 =?us-ascii?Q?yqG8SleHx/YKIGT3/9MnAb5holLEiq46Bq5gO6cm08IZTTmfGFE9aNRP3972?=
 =?us-ascii?Q?jBRuo4eclzQ+5F30hSTysDnCUPg3QrZIORtO4NyCwgJmYyuuwIzBNHY7C4WY?=
 =?us-ascii?Q?TdEn3Mv8N7U9/8TyBuRyjVkxDPBETHVtsR4fcTcrtVOcIRzGZ1hTRSEFGEW6?=
 =?us-ascii?Q?gWZG/IlVsf9/PAPoigwCfPlePs40V+qOGIbb9XXFDPBvrSW6EmADGOw+l7lN?=
 =?us-ascii?Q?b4vHtq1HiD8/KIBqwxvScelJzZbG9exgNuZv+kScuI06SNHqDg4ICxP6cJyy?=
 =?us-ascii?Q?kOgo+LdyMYB1S2S50NgCD7Ve4mZkulV2mecs0O/kQcaWpjo2qXMZ3Hvvn/Cu?=
 =?us-ascii?Q?SnHLs3sYQ6QUf1Eo8+SJ6gmEQyfUo/qIkJnjPn8kuR4R23gdFlEmkBqYtzn6?=
 =?us-ascii?Q?Jpkxh3YC0VjiFFgYvMbWJa7MB+B0lJ8f4vX0XOp5JXW1RsPaZ2tTHfmMA+g9?=
 =?us-ascii?Q?538/N8yCC4sj68pjB+D4W/NEmULODMdxshx9Nz/AxEbfDf8bLUmbrc1UAxQ0?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade956f6-233a-44ab-feba-08dbaee812f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 14:46:37.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7I6xAAshWnf/qMJUd1H7iPkzv1VyriBRIs8CCh92q+KPsOSArnNrf4OcwIBLCk/Hvk+i3OICcz4aH7Gv5eajI8MxymWcypG51JfyANnwS1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6297
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> Subject: Re: [PATCH v4 1/2] hwmon: tmp513: Add max_channels variable to
> struct tmp51x_data
>=20
> On Tue, Sep 05, 2023 at 07:42:51PM +0100, Biju Das wrote:
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
> > +#define TMP51X_TEMP_CONFIG_RC		BIT(10)
> > +#define TMP51X_TEMP_CHANNEL_MASK(n)	FIELD_PREP(GENMASK(14, 11), \
> > +						   GENMASK((n) - 1, 0))
>=20
> Why do you need FIELD_PREP() for the pure constants here? Why can you
> simply define the constants in the proper place?

I think one can clearly understand the bit definitions and value from FIELD=
_PREP.

For eg:
GENMASK(14, 11)--> bits 11..14
GENMASK((n) - 1, 0)--> value 15 for 4 channels and 7 for 3 channels.

>=20
> ...
>=20
> > +#define TMP51X_TEMP_CONFIG_DEFAULT(n)	(TMP51X_TEMP_CONFIG_CONT | \
> > +			TMP51X_TEMP_CHANNEL_MASK(n) | \
> > +			TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)
>=20
> This is better to read in a form of
>=20
> #define TMP51X_TEMP_CONFIG_DEFAULT(n)					\
> 	(TMP51X_TEMP_CHANNEL_MASK(n) | TMP51X_TEMP_CONFIG_CONT |	\
> 	 TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)
>=20

I just used the indentation suggested by Guenter.

Cheers,
Biju
