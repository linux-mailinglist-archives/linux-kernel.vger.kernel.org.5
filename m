Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB17B4FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjJBKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:16:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0BD9B;
        Mon,  2 Oct 2023 03:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsvCBVk5XGLck8M1IxqPBccAoUe6wB31Mw8fo6UXpcJaLP6e/9rMlSbNyDzil3tZ3jD1VvM+lTkjjulj6X3skDYMznT7NiGYm4yGnk6Kc4EMPzVZ/1gN/r+0nqH/NA+xyJtmLE2BJRPz8H7/68QquZuwkINym7VSbepZSg9wPyLEbo1Qc+kqy1Rj/Pi9YU987i4bqTE6AoPsKyk8x+qk2J8GA7zEcUnrogeO+bmRiTdVTFdFgaopD8cdQflEkoa5lnxWb+zyRQhdpeLOuD5n0mJNPXaANd26p65dZRPCZZILcpMBs+9fSjY0PTnIqtLSa2ZV1PjESci34ajUk6U82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVEiNs9ZLpsp5Iqi1srDzcf4YuaM+T+9wEv09LB5W18=;
 b=kkqUrVATchUJp2w5NBe8oCWYBtAt6jpI5GVo9INkeVYrC1PWhRQTX2tvQ5vMVNgfq4W7+QBsCjncy9TyVsvP7937PDnacOW5KwyCTgBqaZmK1O8CnRKgaFL/nY/cAMAUwCDdwTC8csftwlx1lyk+u5TEonKBUKHMx6xaBNBH2l9H5OaTnWdBFGU2aedBs5Hf3Z8rz33eP/l1anWtx+SIIrmuA33z+Y83DDp+VIQq/azHHWTL2tuFYSQI/UE/OWxYt2L/xvhMvjI0eXaviBKGqu/jeNJOTJm2SG4nAWFIuHQXNUsfRc/pld/0ngyJR/kA4VmzCpUpHNzgBQvXqX9GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVEiNs9ZLpsp5Iqi1srDzcf4YuaM+T+9wEv09LB5W18=;
 b=Wi5jQUr3gKbeYfrJDg2+eDTgbeEFaUXb1buZmTQxhaJZQ/Mvd2ZWdLBnV4/X80Haa23SQHzVOWJ7agqLlouOGU1oNQYGj5xsFN/zbbK0lpR46/dX4Axwvgs8D6qt1Yf2lCDSovp9efvc9FojNuq7usjGlewMsSsQBPU49R47LEk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9886.jpnprd01.prod.outlook.com (2603:1096:400:236::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 10:16:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 10:16:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?iso-8859-1?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Thread-Topic: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Thread-Index: AQHZ9IHazMX7YhLcF0uqntJC6sFjerA2PGKAgAAB24CAAADD4IAABRIAgAAATqCAAASGQA==
Date:   Mon, 2 Oct 2023 10:16:05 +0000
Message-ID: <OS0PR01MB5922DB512AA15526C138351986C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
 <20231002102745.0000540b@Huawei.com> <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
 <OS0PR01MB5922C468BEF67BC2A19F87D286C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZRqThAuMogtcMtHI@smile.fi.intel.com>
 <OS0PR01MB5922036435F7B4E2DB83B9F386C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922036435F7B4E2DB83B9F386C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9886:EE_
x-ms-office365-filtering-correlation-id: 1470ee63-66ab-4ffe-a763-08dbc330966c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M29ftkjwiLpvA5Ojp/RXRndSqVk2ljH3gna61R0Nbtc9D956DgNEUWVYdeMc2AgoQXvst8eRlBlmNrzlfq8NOhumX1psj8uyyvKpauthlb/Jq0Z2/IZ+pT/tZ8bveW0MO/hAUssg+u0ZZR5Zn8j7bVwJqFjjIHQrweC+/5Vcea2Rp0QABmZBPXT24hO/om1RCrTxfvgJUHoQ91X+TuWCbA3iLW+f6MsAAy4wzeS5FNAxIL23jM2tArP40gUfHV8+3MMtvpQTYmwFT6FS4zq2vb2zRB9In2FM1GYso07ojrfM3b4UPngpt0EGuhN2iMzRuFa8CYbH/UXodXz+rFfSq4POh+OqOZDCLhnHvx5DK72Yzc86MpWuEpaFXyFa981HfVNbBhmvPUoit7MueDCx6d5b0zqUrGEl6/X+Lqs++hd9X/Ld80w/ZOKnnulb6wFOw2RXV2vQT43j/h1BU9tpU/r6bX4xWa24xfG9z6QqSZVPtZPd5Un4hku4EmGUg5s+Al4W4JO34zFi//t2UpWh42PKWWXqMDbL2qvrGCw6H0lqIoevuT9QSZlI6vyJ8a+6B20uVDJUtGCxeHRf9iuF927rsfyl8wtmlRnyhjMJjNyy7P755SpT8BosketM9CAe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(6506007)(7696005)(71200400001)(53546011)(478600001)(38100700002)(122000001)(38070700005)(86362001)(2906002)(41300700001)(2940100002)(83380400001)(9686003)(26005)(33656002)(66946007)(64756008)(66476007)(66446008)(54906003)(76116006)(316002)(5660300002)(6916009)(66556008)(8676002)(4326008)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qXhNFG/SyI/9nOXTb5lCJlj4LsGandnbrFh64hGnEXvFYDbdmZDA7BteaC?=
 =?iso-8859-1?Q?dY/5qlYWH090TLX8d+Ftw7S91De4Oqg/ktnI/AR6qTK2rJ6OZJv2qFr+I0?=
 =?iso-8859-1?Q?WzZVlsU70ZDbaAvKDn29JGrTsmN1E96KePD4wXELCk9FIiUF8+CDzpYbgF?=
 =?iso-8859-1?Q?Qx2QAWsQ4ZlL84z4rBXOTj1BZqy6GnLJZzpFojYtd70mwieNy9RRraWv9L?=
 =?iso-8859-1?Q?Z67hAuSAVZYE4CIoGB1V9wKEV3JeTQxATqNhToqQ14fQPcH5cbTisICn0D?=
 =?iso-8859-1?Q?KOIYLOzHm0uOl9QV4FsK+qmyJ49hmPkhcATLNkbP15aQeZXRtQ3me0G5S1?=
 =?iso-8859-1?Q?/8GBAL/lweMjNIrc/E8haT+AMQuwbS0vHRjnb+0IHvEKbYmu/Jl7fMxPLF?=
 =?iso-8859-1?Q?IXAv255ikvucX9LGtbqcrH9P2d2woR4wGMpbKBAhuj3dG1gS/riM6UqrIU?=
 =?iso-8859-1?Q?cHteC5tFKg9jaWXQ4cqOOvJTEJ8QHTcUHbSDHy5cuv5f+Xbmyd7k72EdKa?=
 =?iso-8859-1?Q?/VJsupTFO1RasI94d5+p41QygFG0tkxiGFLVqdXLGq8wy/Fc/ljG4YDWqJ?=
 =?iso-8859-1?Q?GsWzCcbCRny3xdGw2eit6m+AzORrrZu4OndISeY/sry/zg5KW5nN5Era28?=
 =?iso-8859-1?Q?0XjCf5N1nkT126pfstsh7rMRE3LFx+KNYdbgWDqIISjMjL7kJxQa3BzzNt?=
 =?iso-8859-1?Q?Ll7ifgYVBFlPZBHohSm7JiP/L8XbiHQnxbM1vK8NbsWIMHZwJed/wZi8FU?=
 =?iso-8859-1?Q?oWvDkogfL+iFtGpUxX2hUgBK5VVevFYnx+sLUpRnesUZHhBWH5xcMkZlWR?=
 =?iso-8859-1?Q?fF/xdZl1fmTl8guSo9nJQu2cqLJ9G/k3dduZ7XvEiE+OaSyEZudQA7LA3K?=
 =?iso-8859-1?Q?FEV/tgd1EyC8THvmS+Jmfbyq1AMLNf9sCYJlxYjBefCR8jdGA5XoSMuVQb?=
 =?iso-8859-1?Q?f0RjZJthNQqXVEpLQMgjRYOTppQv8iWmuZA1c75UTEnT8rn9EEg+5s9Gky?=
 =?iso-8859-1?Q?72DpsO8A59IZC6CZr0h/LY2ZBAZmQFjcEIXb3eGPrMd8MnHQOZ5gO12yBR?=
 =?iso-8859-1?Q?HqR3pqfPWVYT0/b1ON1YvmvKQYntdXJspA7zS/o5w5VPsJtDN1mMQFbR43?=
 =?iso-8859-1?Q?qXgxVfB2Gwxn0LrGL2XZm1iZgU8z5gN0r8z/l5+IByw2SaSP+woBP7C/GC?=
 =?iso-8859-1?Q?I1Yy2hVcFts6TpzqFZFS3sEcOsfaaHW4HXb/XKLyr5O7JJVHccoijogZ9W?=
 =?iso-8859-1?Q?9xrofH+fINrwWkjiT5noPgwWz1n7x9s7OF44+4fgirm35wGN8JC8RFNUhV?=
 =?iso-8859-1?Q?U5Zf93XVjhnNPOV8NIWpMS54e42eAg/07LNiqTbwPQgvlFqcuo3yZR8zw2?=
 =?iso-8859-1?Q?Txfyf+VlwS3pt90KHoH1X3JqzumFaeCSBNSDT8zmXikL+nWYIiTgz5QOFG?=
 =?iso-8859-1?Q?k0lU6tIu9NIGEUtYByhxuyPViSdAX5f0CeBZ1Kv5lcmYFqSY2wggQSsllK?=
 =?iso-8859-1?Q?JF+UGPmHgTFuFI5tHoT3pgTmGhII5EChgKNNCdeWGymMElRrz5VpR69YDC?=
 =?iso-8859-1?Q?1QRxdr8OGJsfpD0/o0Mf1ixlYNsv5gFiLxtpQg5P90iOy0YzgjlglQdkzl?=
 =?iso-8859-1?Q?JViywaOklrrWzVQpC+r/Iur1PFVTl285leiPnvNAU15or6xXmjlkodXw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1470ee63-66ab-4ffe-a763-08dbc330966c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 10:16:05.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2Qltf448n+UCR4+3DQfMEjz9FEofug1KjRNzIsieNoL3ilHsM00ld/W49rgj2+vcmdV3DmeF3jgXA8MwuuQFVq7ud4bW6MCv62uCivTlqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9886
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Biju Das
> Sent: Monday, October 2, 2023 10:57 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Andr=E9 Apitzsch
> <git@apitzsch.eu>; Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clause=
n
> <lars@metafoo.de>; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.or=
g
> Subject: RE: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device'
> error
>=20
> > Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device'
> > error
> >
> > On Mon, Oct 02, 2023 at 09:38:17AM +0000, Biju Das wrote:
> > > > On Mon, Oct 02, 2023 at 10:27:45AM +0100, Jonathan Cameron wrote:
> > > > > On Sun, 1 Oct 2023 18:09:56 +0200 Andr=E9 Apitzsch
> > > > > <git@apitzsch.eu> wrote:
> > > >
> > > > > > Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert
> > > > > > enum->pointer for data in the match tables")
> > > >
> > > > ^^^ (1)
> >
> > ...
> >
> > > > > So we need the spacer until someone converts this driver to use
> > > > > pointers instead for both of and ACPI tables.
> > > >
> > > > Isn't it done by (1) which is in your tree?
> > >
> > > How (1) can trigger 'Unexpected device' error??
> > > It returns match_data, and match_data has correct device type.
> >
> > How? The enum starts from 0 with a AKXXXX and ak_def_array starts from
> > 0 indexing, it's classical off-by-one, you got the driver data for a
> > wrong chip.
>=20
> Got it. I was about to reply. It just needs mapping as Andre did here.

Or split this array into device specific individual variable
to avoid any mapping.

Cheers,
Biju

