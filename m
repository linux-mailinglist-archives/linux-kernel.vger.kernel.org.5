Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E497AEFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjIZPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjIZPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:36:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D310A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1xTvkHlyI5LGL/zUogMw91Nn5RcasZlWumriyXXK9wtDioSP3h0wegFOD6RNOXv0d6wruuoEUvRDbeVcXEufiSQR0AkZG1e4W8ctmIqHpJ+Y7KdqNfCapTuiNZH727ahFQ009jvQxwTTxE1RzLUznIHVp8GNUG4V/LXuttx3l8NXAdZa3CFU3vaf70/Mgmg7m97S5nCdg4KUX5cJA8pAGCekXRNRCvCKXq5QYeCIFDvKb+mVo15plizk1QxSV1Z+kT/NnjGs6TNTx0FqiwHFJUFANhPzgBH+N8oh8qS2LQfYBJzOXU1gBn77pOv41oRs5L7IzHwJCLfq/N1y8XSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G10nl23tNEE2097DJO3PMwVqISzsUvzMhl2ttwTzBWg=;
 b=TFVmFD91dV8+VpJwaxsNLKjVegIs72JLTLrAQn489dsBgyBnqxKHCqqyOPdC7dn/5JS1CkL0nd6ZmOxKOcqLBV6paJiNcLq9STyr7C/nbpZwwDLbE4UmrtEpWKnEM2FB4i7T/f+Q01SG823MWnAvWsyhrKmKvKUeosYSsEUWr2VUIwSmAvnxo9z6ZsAtL1WoDHPEMAYGSgCdgLbrzgj8OOYUAGvj6KifaPiczfV9HoGUMlGheeBrurgdlwzt8svtcO+1XmlzbAyUVJeRMTiugY/Gs5YpiUaPPILZbieZIUoRG7A7MzDqTxf1xpvtOScPvLLj3APgjzbf/3kETxlyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G10nl23tNEE2097DJO3PMwVqISzsUvzMhl2ttwTzBWg=;
 b=TgUmJor72BT9UtV0YykaCennS0+aAQ7bgSP7fnMa9vL93XDlI3nUGLbyZ0CNIQdeDZ27ynPC8/Cvp76E4YLln6VvsEfOjMuDL2kw4uApDHvlMX71NX9EBogO59DBBgwdM16oYtvnTyQorjQMYQLkUxqyVUzY/8WHIohnjS0jdqE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB9457.jpnprd01.prod.outlook.com (2603:1096:604:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 26 Sep
 2023 15:36:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 15:36:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: RE: [PATCH v3] regulator: max20086: Drop ID table
Thread-Topic: [PATCH v3] regulator: max20086: Drop ID table
Thread-Index: AQHZ8I6YjFD7lOKUy0iL5yFVMsO7drAtPJSQ
Date:   Tue, 26 Sep 2023 15:36:04 +0000
Message-ID: <OS0PR01MB59227E269E915E313109524686C3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230910065444.25906-1-biju.das.jz@bp.renesas.com>
 <ZRL5ahsXZ5u3brDB@finisterre.sirena.org.uk>
In-Reply-To: <ZRL5ahsXZ5u3brDB@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB9457:EE_
x-ms-office365-filtering-correlation-id: 78eeae48-319c-4fc8-fc29-08dbbea64be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oy/PaalrALc2R9CGzx21TdyDGmW1c3FTlYzjUiPoPTix25c+kcMZU4CllDfpySaJO9v2tkIwm4Q5oo8rqsi1NScHk3dOxfPbUIRG2V5YHTmtoLJGtx5SpSIw1W8RKm6nS39ImbTowrzqI9k3oIrP7ukD9cLOPKUpq1SvR0we/azLsffW7JL3Hq2jUfwy1uX6fUkR7hdlWDMv/hibs/MkK19fAXhYG5rosZi4R12V49lLjRPP48m9o8xQMG+wszugIwIqXoOarxDVfVKr1FM2XEYktomredclISlxiZSEqAMsJmfXuw14UxaPVETmzuHzBTYPjpbvBHvbEC32ftC77vg51WE8L6B7yZjlZ1d1gSHN+VSRQvP6lwVGjtea3/FsfFh3GSxmbj72gZ8Vm7Mrgi0iPwrJCe8L2RXmJUgPTVK6xe08V3L27s9oGKxUbYMw1HDTCyRUTUJ4xa76Wa8tXId/WUgy24lzFXw3zh/g9m0li7djbeOxRMvp21WIIraVBwmTIAXSXyHY37Fmd8lhe/j5Yq7c4RLJREycCgQzfHIo5jJPwH/DgxgEIFuIsvCvl5ljkrFUKXsAKhTDpX/wBw8StN+qfWmIohLPvbua554=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(2906002)(4744005)(8936002)(8676002)(66476007)(41300700001)(66446008)(52536014)(5660300002)(4326008)(54906003)(66946007)(66556008)(64756008)(316002)(6916009)(76116006)(966005)(478600001)(71200400001)(6506007)(7696005)(9686003)(26005)(38100700002)(38070700005)(33656002)(122000001)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RXq+V+JRhFZY8flIVatgUyuHcn8FWO+Ymu9lr3tAeM/FnDnbYBfVYxXl21Rn?=
 =?us-ascii?Q?2HmrteV9BAl3bLsRbuEc6jAKbwQHzLPlNdF9rtWt3jljmM7YNfQcwjgruEt8?=
 =?us-ascii?Q?gETWCmV5LX89RaqetoxSm449Wl4qwvOZzxPQR0YrJJB2ZWcD23nusSmbnj0j?=
 =?us-ascii?Q?SF3pQQd6DWX7vk8MdRb4R6DJ7Ox8SrXcvHnxtXbU3BNWCc+v3caEMZQOGB4P?=
 =?us-ascii?Q?CCAekaHm2H3YrF1XG1wx8Xhnvqx4qgvAVN5sDUpp2zX2SQV1KXaun8je5zOA?=
 =?us-ascii?Q?udj6BnQaXovgCqNtSgn9rqmspGPNFVG6OswGD04waGFQkZHLvK8gZYvT6O9E?=
 =?us-ascii?Q?irEs+IRuRP6yOHcDopUudDQmKfsP3cH5gze2wN9JOOf6taOXh9Rm0XKbJ6PM?=
 =?us-ascii?Q?r5uoqFp3WETF1DURLkXLyQbGoVPc377DIS5U/nQKdlX1cv5tMJh8lb/zhpk8?=
 =?us-ascii?Q?xBbIcE4+Ag4zQ2yRpg6d2N22h8pQ419qd+E/w6VnFeyq0HYIvPr95dYZPrq5?=
 =?us-ascii?Q?/uQUDi2+xV4BH6cMDl65LIe5gTtxMyQ56KIm8FrJc+Masq0xyWuh1SgHxrGI?=
 =?us-ascii?Q?1XSo1twDPmzkoEj51ljrBCOBwam/JRcaBSnVryQovCVB6vEWsGe7TGtd2MPZ?=
 =?us-ascii?Q?4Si/XK6zuRItWbfo0nkEPa4uciDF9T+ekXSbDjRsCdE2hZlfPHXZzJwb2Sdf?=
 =?us-ascii?Q?86YhsGFb8Bh+nGIjy3sZCAgChTCnlUpKGnFXuwcgk0q2zWZ1SCpdJ62dqymk?=
 =?us-ascii?Q?kk2suFXTzRpZMTC6a6I7rpKxWQlMn+6zlTCvbWAVBMFsBv5CVtFMojwuCt7j?=
 =?us-ascii?Q?YMNC0BX9Ns5rcs/kaJ09GTiuoJFINIwkB0gJJzym5ZROpUjhpG7rPLBkSXmE?=
 =?us-ascii?Q?p2S2Kbxb9S+oMniizG0oJSOYVgAbrxzFY+zahm4oH+v7EE5ahoxFc391Mymo?=
 =?us-ascii?Q?VAoeA3gP+0GBUNCHn0dUW5YU+Rnc/sofiWS1c38GF1TDHZnuwhS7p7LYSwwk?=
 =?us-ascii?Q?KdXlEDVKLdLXa5/dijdqSVhjvzQyKyBmdqSXWntF8jyCHJcxl8zI1efSA8UO?=
 =?us-ascii?Q?KUFqA2LbqG3pRiQCLzBuQU6iUXoFzqaOWuXio64DX4VvaDqBLG2qJIC3PTxZ?=
 =?us-ascii?Q?5ld5eov0gnuzmQPnlznLbT8Xaim2/Kn61F9qBhe7gpMI5RR2os01ygIm6ZiK?=
 =?us-ascii?Q?HLUAxt3BiyjGbVcTx/Mo4jzOGAm0gW9qsv0vr/Ac4N6XkQu8V+nl8POcR1qM?=
 =?us-ascii?Q?LFLPvJQMLEO/ksPgTHe6LcHsjn+o+SVC3kschi6AQXyz+yXpfbecRU/0BaCJ?=
 =?us-ascii?Q?+6a/Yy4RPwjUQDXII//u3Vh4Pu/ZJTrSC3TCUmEiHOpAEPTfnUiF+Op+HPVD?=
 =?us-ascii?Q?3OQc6yusDq2usW5xrL85VCaCJRvmAvdOMcJI1Snrh+k7HXn57QQfbP28be2T?=
 =?us-ascii?Q?xP1aI/zTh9+FnelED9jYdDJET4UK1vdbnx0Va80N3HX7C90T5mDZNk7Fwt2N?=
 =?us-ascii?Q?IIatTlbWE3dDF1RscjNMTXTZVcRPDlJWpNUjfpEHQRN8crhV6O0ZhkgXUIeR?=
 =?us-ascii?Q?5kMi6evT67GvNqkw2K26+EV+W0xTAcP0bSDnPoAYq9BFzjtjPoA2F8MeDfw3?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eeae48-319c-4fc8-fc29-08dbbea64be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 15:36:04.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcHp65/S5coaALvc+JWf2voFxklhBk/ZOzO4HQec9YT5l4g6zweTKJGAC3teNM5iVBmj71lByVj6EBl70ugb7p2+g4X14ngMp4rObBeggHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9457
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for the feedback.

> Subject: Re: [PATCH v3] regulator: max20086: Drop ID table
>=20
> On Sun, Sep 10, 2023 at 07:54:44AM +0100, Biju Das wrote:
> > The driver has an ID table, but it uses the wrong API for retrieving
> > match data and that will lead to a crash, if it is instantiated by
> > user space or using ID. From this, there is no user for the ID table
> > and let's drop it from the driver as it saves some memory.
>=20
> This doesn't apply against current code, please check and resend.

V2 version is accepted and is in next [1]. So I would like to
drop this patch as there is no harm in supporting both OF/ID
tables. Please let me know if you think otherwise.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20230926&id=3D9d9cd8e6a4572efa328ef72a83bbc78a39deca37

Cheers,
Biju
