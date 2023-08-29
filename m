Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087978C81C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjH2O5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjH2O47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:56:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5E194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW3ElrJjpVHsKlgkkQd6R4wQrfEOki1NnvSCwOq3ehAd0OGLhzsQLoCN/2OzprEQH8HTKEpvcf04FGq4aZ5BW+TBegj3m05qvaOGn28n0EbRYPLRa0h74jDse6ozmS/zoke8/mYQM29mMkHgxv6CCi3SXbXsQPI0cu+K2RQzD9zUiLfNGoZjiwKArZb18lVhrPgqv6PxP/79lwVLd5TYcVX3P+LS3y7GaqfZw+vq6pmmxDQ7XzgtWP3cYecNbWlYxXQR0/Zd/QigEcQ2y0FRny38+kw0yGvEcPz4wWF2u8BsWwKkrZlgUoUVzry9zc+hQMN5XObP0/ELoSBkQZAb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIZVtq2m4Pccu/hXf4aEcj9r4MrnGMv4MADXjiM4Nyo=;
 b=WiUxbAwmX9RqbD3uY2jzcL2Ws46MHYucA7Zx3suFMDxLY7gpCmz1m2kNnNtub/ezUQrdGsW1PWejWGnIO+2aEyOvZEmzl+1hhZ7rmLXgpF4amPydfMXKRts7bBLj+jXksst9tlkv84R9rhx0zaFEal/H5dUm3fiVVZOej0PXkgeYYF887eRofdoe6gfOmv0rjpUcL3WB2PYVHfqAiIp54dnMjSqJY92yH1OYjeJ14Tv8OkS8cTSOHD9MGzEX8flxyDuVFPSPuny4xGQIcfwPtSJoqygG5hoHGCqbuX3i+Pi2FVP4zphf+JJJLaSQcRX9rdp42b4WBF32BaaxDtOrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIZVtq2m4Pccu/hXf4aEcj9r4MrnGMv4MADXjiM4Nyo=;
 b=ekdnCRyEnG/GqWO9EBQPeKu3OHr/m0Oj/M9Be+bmlgFa6hE9v/XLsujsdzNyZIzmwkyuxJsEHHii0qNYOPyhOncZyh8Zdmj0DKO1WdbmSlLvOZVPHGYYZma3ew2vg5vacqp8k/KexOR8E+CIVWWSIu5LwlaB2TSWuSEYVmCMVSs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8520.jpnprd01.prod.outlook.com (2603:1096:400:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:56:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:56:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mfd: madera-i2c: Simplify probe()
Thread-Topic: [PATCH v2] mfd: madera-i2c: Simplify probe()
Thread-Index: AQHZ2cdFWbfx8YVrikCnOi78ZR9kQLABXRsAgAABRSA=
Date:   Tue, 29 Aug 2023 14:56:52 +0000
Message-ID: <OS0PR01MB592216807E14879DE73F748A86E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230828154941.79780-1-biju.das.jz@bp.renesas.com>
 <ZO4GAorklByxm1si@smile.fi.intel.com>
In-Reply-To: <ZO4GAorklByxm1si@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8520:EE_
x-ms-office365-filtering-correlation-id: 3de50455-f108-4957-4535-08dba8a02e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09Q9zCt3Uua2LiDhQxefC8SE14YVcfJwNW6XVUHp+m+xOl3swVoGXE7JJbWrQBOm8my9ADQiWZi3rvK4vzs6zzHPcxmTmo7YdJ3MDv5bkShnYwRCQwbzShZrZXi0cVVRgdXTdgR5xc5mdToQ7IlfGQQIhpqKV24+2aidE7q/964GMeJo8ourYAvTbm7b2Yk1yrOqiZME6ATNS5kXUTKPB8P8Hc9glyRzkVgBQw/L77GQbig4nEdBZ2OvXnBOC1esKzSykMkjsYkALcM0Pl0MOSptaa9QPYJGpxxN5FzUrZJZEVajhm5rantAr0DCFwitEAJaB7zcCYYBj/fj9OCkZ+3kmWAi4/PtZNOcySngAthVE4NNi+crqTe2KkEsz73GEVO1miVExWNyileaJ599EvRugJmA/BKlIL/XrpVXkHOUR/UWL4tGkJVgO4mfWfODwsaGJA8ApFbmM8ttwnuHvaItR5iG+sbHg9E+EeA4W2JBzE0QFYUaCRjH9FViBSJPTdupIuBwCvoq++iGMi1ugzWbwdKQG0qx2GqCwD60d7TGeDyW242UPFoOsskpAKeEPjRvKCObOywbqK1wIE87AjgFEc3en/Vu/L0CCJ9AozWzehL9Bbb89tKYao3rHhB/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(6506007)(9686003)(7696005)(71200400001)(478600001)(4744005)(76116006)(2906002)(316002)(54906003)(66446008)(6916009)(64756008)(66946007)(66476007)(66556008)(52536014)(41300700001)(5660300002)(8936002)(8676002)(4326008)(122000001)(33656002)(55016003)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T1+LBV/DZLviPdkWJ7pM1Y4PJhNHcyXLsi0ctNHnDY2+cyH4OQc8SVa8gsWO?=
 =?us-ascii?Q?Neb4qCUYdqtuZyrdw0b4R0JasAWSlN+9E/PUyckzrcGUpbCQNB675h5+rD9k?=
 =?us-ascii?Q?Upm0Xr6cn02Y+pG+cMwdemW4CY4gku5KuR7SI5pvaU/5dd2Pn//VI2COogK5?=
 =?us-ascii?Q?v94VOnYpYmiHyP54B3sd4xvezma+srluRDpCd7FRihbSen+HCDQ4J1Bu90im?=
 =?us-ascii?Q?sVv6BL6cummC6ZvSfRKJ4q3YKt4oYGjS2X+8t6Yo415NQdebwosPm0azuH9M?=
 =?us-ascii?Q?oq+4w8n6izf57/JcbOC+f/s9UYtItv4sTe88+8YRZVTEgrnjLhyNAuQjxSNj?=
 =?us-ascii?Q?OMJtY8sfBSVYQGpWLqfvaEXAIuUF/KvCopFaHTNbGzQ42wjs/f2boqI6MGY0?=
 =?us-ascii?Q?+MdoD8HFckA4gPtShJVE51SSrIoCssIBKwKmO8jFCHMpzWzgkzWcjQVEoYqg?=
 =?us-ascii?Q?0eAWzwP5YNvKapQsdh+agWxtgGgD1t7MHg5sulsG6PzJUvkAdSQcPFzct32n?=
 =?us-ascii?Q?yK0gYJrCA3vApiMZW5Z70AUrE0M/Y6A9zS2Iu9nI3oRlQR5jVxPcyG99xvQT?=
 =?us-ascii?Q?TF6KljpulhvTgwVNwFu+SISkl0r7us0dWJERXn/yT1ZuwHFMkvUixnY75xrt?=
 =?us-ascii?Q?FeVftCEmFJso6E2HPn23+bp7t/h/GO9+PdJL/d/HowrKTK0aIqDguCCnxht3?=
 =?us-ascii?Q?VSyi0Y3QHh054RcTZbXxqy42LUG+QyUoXUqLD+HsKQdvO1W+cD9wagaO+fd/?=
 =?us-ascii?Q?FkFQBZEhH8aLcYqt/ZOaZFaOGMD5fZrDVMKnWmagfZ9lUhV50Rvp4V3sFxGx?=
 =?us-ascii?Q?TwwdQVwtLJqZ47Y0GS+9WszR4qwPBVz5MkXZyIOf90HKcJ/xMvs3QOKkZnq/?=
 =?us-ascii?Q?D+qyjugt+qA5LmNIaP9lfuDgTRWbMgq5rOnixKgc9z3KVYpzGJhCj38dJMU9?=
 =?us-ascii?Q?xV4SraGmzclpDA64tV7fGDF1IjuZPuKysyrfE0CYmUxLxA6Xi4dFU++gDvkp?=
 =?us-ascii?Q?YQ8bYjuQYaCP8I/Tt4AfwuKypcH3AoTIjrJ61e8uhfrw8KMjcsLUUvHizEAi?=
 =?us-ascii?Q?vMZbWjPglKnZlBwxRq35RdX7Vmu5/jDDbC7r+AXZEfl5A3fdqlci8OMvdPyI?=
 =?us-ascii?Q?Vsli4oVCxbN9od02blZKFQk7WZGKH3VmhY3xOYF7vAeXbqET0mJQyl7Iu2jk?=
 =?us-ascii?Q?/atHwo4LyVdSFLaxUSTaXgKGnLI2oaaN+KDqRz3KpcCk/H0EzJYCeEr/dGjM?=
 =?us-ascii?Q?YQbwHmMCLAITR+T6LGwEOKXAZTyRVslEVS18k3chL5Gh+JWu2xqISw94y1oo?=
 =?us-ascii?Q?21Wa/GfTaolW8jwYLkx3xORewNL3JOwAtp2/g5SLl2qQRV4F8OgTw9frqK9m?=
 =?us-ascii?Q?U+CLiQJ3O4R3nZbTwUmuKVgBqadrUnfPLDDVui+PQFUqGZXQWOTDvTN7N+Je?=
 =?us-ascii?Q?YA1yLgZa4TlmIFHLQIuBLCJg3X9hYmx0NVX7iMOQh80BaxtYz2iEYcWjkl1B?=
 =?us-ascii?Q?8QnbPTxKTfhylpxaYurGHzacKpt1BVhG+0zQ5lk2mpvh+1ZfSpuGUi1lrAhK?=
 =?us-ascii?Q?X9fPkGks0niH80rs6q4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de50455-f108-4957-4535-08dba8a02e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:56:52.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23quhXI5d/1hW1EEts9bCW4AZoacLTdnY5SWlBHiVX4iiGK9TR7JXijS44IFrACuExPx93xM1yJXxWr+3rjD6Xc+/KGouecbOVhq7S7odTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8520
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v2] mfd: madera-i2c: Simplify probe()
>=20
> On Mon, Aug 28, 2023 at 04:49:41PM +0100, Biju Das wrote:
> > Simplify probe() by replacing of_device_get_match_data() and ID lookup
> > for retrieving match data by i2c_get_match_data().
>=20
> ...
>=20
> > +	type =3D (unsigned long)i2c_get_match_data(i2c);
>=20
> uintptr_t ?

Oops, missed it.

Cheers,
Biju
