Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C067B4FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjJBJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjJBJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:57:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D877F83;
        Mon,  2 Oct 2023 02:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePcKkKIeUtAYHmLHkBll3iuqJFn6bxYuQna7nlRC1mOp4lbItNjMHuYA4v+fjsXY0qv56AOBAmEa/LUlBlaLXuqer/jJVzX4NYFOsExJCAmJtelLk6Dt+6fq02rfDS6yHOhWa69SJMEif7JlvubAgA+gkDLHGkV8fNeqrhjxbsi4EEyR07TjNgL3W+Kq30ES8YXBoYbrpBvW2mv33sax9a241YFv8t9LytO80OaBSbVe/7JdvwHD8rQIq9iW14mn7cFEwZ/Vhw6SPCfclSxAo6vgJTMhWHZaQayX+iN5YJBJ7TytyBHQaCPyUCI1b+iPlfSCvjNYoR7hqFIJQ3bJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibym8w1KwOtSwtW7YhENaMaSufvXnwwXZQt0gNCwDKY=;
 b=WaQ+UfBPB9PAWClGiiVIaNgmGjHnY/1RJ7hwuW8+pOjZQ0RvMJccHUVRA0JTJxNsKcwsjqwwEfDv7UCIuZsGRO9nlahcp+Nw59iUt68LxQcvEwU9Vf3FwX/HXl+9w9wXV/ydsX4SkXTo4dlCGlifs6KY8MxaEc9nbXjltZk3jHwccjSPWbWeJvl4R7Y/HJMr4jHh0cpxWr+rmfcFWK1kwssP4DYa9XieHpB6mbGe4WWNHAtK0phIhymR7Eryc5tShMA2bKH7mRetnCcdC7TgjA86HRri41jhpQqHxYQ82r5o8uirs63QQY3sn8PEgP7w0C8NSVFKj0FNoxcIz9lrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibym8w1KwOtSwtW7YhENaMaSufvXnwwXZQt0gNCwDKY=;
 b=v5FsaNxa1zzlkjXLB3NppwW6jCmU+ogwsQhyGU+rux6cHJm7WsE7yhnjIdM6/qs6dd/Fa06l8+2aq7eApdNVXe38fQ90OLrbFssXWNG3oQFApGDj6Vpf2mIC9CI8wt1RuYRNi+8mGyd3xc9DmETs6j9s7JebI6dnw+J3i5Ud5gk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9483.jpnprd01.prod.outlook.com (2603:1096:604:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 09:57:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 09:57:09 +0000
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
Thread-Index: AQHZ9IHazMX7YhLcF0uqntJC6sFjerA2PGKAgAAB24CAAADD4IAABRIAgAAATqA=
Date:   Mon, 2 Oct 2023 09:57:09 +0000
Message-ID: <OS0PR01MB5922036435F7B4E2DB83B9F386C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
 <20231002102745.0000540b@Huawei.com> <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
 <OS0PR01MB5922C468BEF67BC2A19F87D286C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZRqThAuMogtcMtHI@smile.fi.intel.com>
In-Reply-To: <ZRqThAuMogtcMtHI@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9483:EE_
x-ms-office365-filtering-correlation-id: bb882810-7b19-4dd3-b9e3-08dbc32df139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AVKugqNM3Z08T8IKY3b/pON0GvS/lrcrdSex9343wSBWhEaPVVbvUty05OuBpmD7asYJSXzv7UhlUGccYvOjFHhl+YFPn/TbYV9IscoBiJ+KfACsIYkJQkxlCnUrIJ+p0nARJCP/QzCSihGWQZ5J4L4+84jZ+rUFCUX8GuKR5In3XN9Zl5XTtfYLRH66wKMASn9aKxMvHSoQbgz78XnMfdtQQbje3gy2pfaiq2fYYH7e5OaktQwzrThuVRnOilutlhoYBZR8kqrKXFqY4B5XHZS3cMY/vAxZTWUi6GNuPP1/yvy8lJyHhEiN1yGwoK4P+xxdTMehHQ0Da6V+yUdBww5HD93Tcv+rVTptwnQTtLzAnRCOxRqIwpl+exgOcvMY/dSeYqICndWwIKcve+SxdGVUnOS7/+zGjZjrDrvha8Yz6d4Hd2eUvAzYHE2GoWdoJwAHLdmxXbVa0pCDfQdCN2Dknh394qihM+gvqM4BkA14Elghx9wyYsNtwYFKb148iBU0Z/R4KetsfpUI+ZG2IdAVUFhDtAAIPG1Bd0NJVMlHOfGqdkQmgSiRD+GBh0o2TNea8hC45J3FQ5WEZdFXqfG9X9Zzk7yEkmLfhHYaZ/5QOiQA8WQG18LSmKic2iA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(4744005)(478600001)(64756008)(2906002)(316002)(66476007)(66556008)(66446008)(76116006)(66946007)(26005)(55016003)(6916009)(41300700001)(38100700002)(52536014)(86362001)(38070700005)(5660300002)(9686003)(4326008)(8936002)(8676002)(7696005)(6506007)(122000001)(54906003)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EoXuCkTI0lKDVHeJ351dYsmGqFgxIX9MO6nVSMYYlt036Z/AcLA6tFJNai?=
 =?iso-8859-1?Q?FPL3lRkU/GhtasbsZWAcHizEHbGBZNTvPxLwtaJMm3Ko3L1kK5BJG8ZOTR?=
 =?iso-8859-1?Q?66PbyTW5rxJAv7mm28RXuVLlnPwtqjGD+pGVHuXGrE+4sBmadMM7BRdgvF?=
 =?iso-8859-1?Q?0sbbJywKCjqpaqhNeuCkiBN/zUFOqE/Eza+wMQ1eB2t134wRL8Brwp/XEd?=
 =?iso-8859-1?Q?wq9PmqmRsP8rURYsA0RA286F5jqi796M+mNFZbLgEDzfp3xKDaleuy19i1?=
 =?iso-8859-1?Q?l+mz/bONohRQACGHkiasiMqmui1i6z5DVUywTNmG3zLl2KgmRhGCqSYv40?=
 =?iso-8859-1?Q?fkzXUb5CE3X63SbBHnnrEpAPZ+88HY3RRCOTG0gLuAazALGj2ec+z3kyh9?=
 =?iso-8859-1?Q?4+MCXDG2I2XcHAWfaTKBBo+oRxV3ihbHiAkMm0s/xI+J9NFRv4VP7eGqLT?=
 =?iso-8859-1?Q?dUwH4OyrsrbO63+/kzgBh5dvQ6k0ikRUwXga4tMqe8sVdUCmTjLp8FZ+hr?=
 =?iso-8859-1?Q?O7Yq6weMTylZoWotytn6zOmq5LkDuGU61wpzcONYSrD5Up/r2FslZBo1cX?=
 =?iso-8859-1?Q?eCTqUdDLHjan1UzLdvPgu4S3ulc9ixZdLFTY+MU7/g1ADWRHxeNIq8mWGQ?=
 =?iso-8859-1?Q?FVYy7Teehh5gCMvbUBB5D7E9giitCiROCssUSSJg3lWnbDO4uQtcFqXuZt?=
 =?iso-8859-1?Q?BsrZFXYHBTbJ+OvewI9DPbBPp96T81xeT/2+ONr2y92vKLUAoqZ+cHvfLK?=
 =?iso-8859-1?Q?y5ticlEkQfbcZzAgGE8Rya58nBlmKBUFFVm1BUq18HdwYMTRjEBzhhds4R?=
 =?iso-8859-1?Q?cH4S+L0Mi9DbEmxq9HXImHMZzwLmQC+TJhBTj0zevAyzc6oLyW2Eq1zXW+?=
 =?iso-8859-1?Q?PfW1Do3SdEzBc2reJ1sNS4yE83gif7aQamBkILYO7jLMdMlKUnglr0I5zq?=
 =?iso-8859-1?Q?YatiZwLU6PVxWdGsyIbB5nGnKxd/uZHvgJlFHyI7W38XLFctayRrRPWfk5?=
 =?iso-8859-1?Q?UFHm3dVTOjC/aW5EFf6x6VXTKd7poVY2BFzGnRMTSb6aXu5kEz9LGzQwIJ?=
 =?iso-8859-1?Q?5aOLpn1i/qrFwGm+dlLrKbXJEfl6xbNRDVyg5rsvN9gz1k9iQqBM7huQA2?=
 =?iso-8859-1?Q?RZ7vI1lmXICjWSHBna8UxS5tYFaAUxkl/NMKygU1tzVYDHjvAKOjA0mPmX?=
 =?iso-8859-1?Q?ftJeeZGf8AhSYhYiHFxOqN89K9wPeIM+E9h+l1HKdqxvJKYQHvs13Ew85a?=
 =?iso-8859-1?Q?/yKA1DdyFyTf23jFcEW72N0chmxcJMTRxx4kbVeH6sShrhEAI9XZnjFm1g?=
 =?iso-8859-1?Q?wxJx05gFx0hQk6MovbyQpWqyt37veqyCdZKzD8KNlycCNvxsTolM5luL29?=
 =?iso-8859-1?Q?0TjzdxP4WjQxTuvtEFqnTTC82UOHFoUD5zunARNFXMGZVfKGccrqiqc5/T?=
 =?iso-8859-1?Q?XXLqv5zEIBw3LHpizD5rbtZRNClK6Qw4Aqds2J6W/g3AwQzHmhL5lHxkyf?=
 =?iso-8859-1?Q?RGs5ETMUQ7QdvoxCsGGBBGmD7ufp7uecl695YmRdgudy2r22vcUYvG8NGV?=
 =?iso-8859-1?Q?3/5c98bEzUAIGOExi79XARmI7POfSLn4KeA2FPUbPftKDavEH5+1Ine4/3?=
 =?iso-8859-1?Q?UoeE9LHc5sg1yPW2Q8jEddT0L+UmpzR/P8J8wd7hqsFvz0PkscD/ebBw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb882810-7b19-4dd3-b9e3-08dbc32df139
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:57:09.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ol04CL0V4T5uEkVlrwk15ngCJQnd972uH/ODnKUGbrlmxxjcG3ibtA5LN+PiQBmwpqyEOJmxiq2zl+FUVhwAFfMqqKMYsPt3kov3Dr3oYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9483
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device'
> error
>=20
> On Mon, Oct 02, 2023 at 09:38:17AM +0000, Biju Das wrote:
> > > On Mon, Oct 02, 2023 at 10:27:45AM +0100, Jonathan Cameron wrote:
> > > > On Sun, 1 Oct 2023 18:09:56 +0200
> > > > Andr=E9 Apitzsch <git@apitzsch.eu> wrote:
> > >
> > > > > Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert
> > > > > enum->pointer for data in the match tables")
> > >
> > > ^^^ (1)
>=20
> ...
>=20
> > > > So we need the spacer until someone converts this driver to use
> > > > pointers instead for both of and ACPI tables.
> > >
> > > Isn't it done by (1) which is in your tree?
> >
> > How (1) can trigger 'Unexpected device' error??
> > It returns match_data, and match_data has correct device type.
>=20
> How? The enum starts from 0 with a AKXXXX and ak_def_array starts from 0
> indexing, it's classical off-by-one, you got the driver data for a wrong
> chip.

Got it. I was about to reply. It just needs mapping as Andre did here.

Cheers,
Biju
