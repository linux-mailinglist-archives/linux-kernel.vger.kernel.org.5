Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7778F130
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbjHaQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjHaQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:23:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6188E54;
        Thu, 31 Aug 2023 09:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avTI1dHEmS7PfcaJLW6te+dYU6rmp+J4xDycYgEsi9wriFv7KDmLbVXAkmgk+dsH2tA46jgjVOjCXjLGJddnYjBPpT3NwfCMIJ1DjwC4LrJgzf/d3nuSPd7zP17czHWNMn8QUHoxmJRkN3H6oSoMbeK7J3nSQYbkf9gseXYAE6ioiFvL+NyNv6DQqxtVrqpjiOH6MUKNkcwuZmGaXC9aOX05a10mHQl7RoJ/HIRwik71DBp92S/ga90g9vM9hfTuETZdrzcTtPiJr7A1PXpM5/LXGpyKh0F+pxQsDgUT8UnzKxr2g6mygkjCYM0eWU/vBnv7bQtSGCjnAM/cc/wROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqSxHxSFdbTVPVpw5DsYPUY6EDBilamyRruo2vTU0Iw=;
 b=i30818RdsYui23o9ZkTAHvb2nwTazQ7hT2C1ZA5PZ/9inwthpmDpOGRSWYR6Mc+Ou5AzDR9JMc4vFqMI0Q8xtvrguiiulKaYXqjvkU1zY3wGG9r+J+bqj+iwoxby287zD+l0fHgCv0stxqBOv2GtzAOHwGPLPcCsQAJQXHjfAQ/TBC6BTHvQp5NCw/+Eja1TGxP7ZJZnz+CeHeqeQ5R4fK1nGd2wIElxXsrzLIV3F8iHEzpom8VBBM42k+upbJYQR/8B5oZSur6sU0nAR3D+pzfo90h0pRZs+F203jggpXKquzqL2wx4t7BooTOQdGxQFs9QfHJQ+SlDAt/LaSeXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqSxHxSFdbTVPVpw5DsYPUY6EDBilamyRruo2vTU0Iw=;
 b=qFrcdgHRVT08wn4zHmTvMRPTLzaPuLXwFqcuuRXtHbAT9/aPqh26cQRj2zzllDTmVlQOqGTdFZ/kNgJ3xwH5ck49z2cZW/w9DfdApC+nWOvIuN71JJWr18ZiiNVvugiLssy12edzqVeuWICfwPrwPAzAVf/maBkl2V9KFsxbnro=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5457.jpnprd01.prod.outlook.com (2603:1096:604:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:22:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 16:22:58 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] usb: typec: tcpci_rt1711h: Make similar OF and ID
 table
Thread-Topic: [PATCH v2 1/5] usb: typec: tcpci_rt1711h: Make similar OF and ID
 table
Thread-Index: AQHZ3CTsra9ql+uuxUmx7Ni7UbOgl7AElTqAgAAA6uA=
Date:   Thu, 31 Aug 2023 16:22:58 +0000
Message-ID: <OS0PR01MB59227A84A00B3C3C3F205D7786E5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
 <20230831160501.55081-2-biju.das.jz@bp.renesas.com>
 <ZPC9TY0kisFt47z8@smile.fi.intel.com>
In-Reply-To: <ZPC9TY0kisFt47z8@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5457:EE_
x-ms-office365-filtering-correlation-id: 41ebbbec-a156-4d83-560f-08dbaa3e8a0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhB1ySlXoaca+vo3IOKdJkq3G0bStwZfGLc5IWPTnt9l5imYtiyvvotz2BbPochv/T7rT97J8jwcQmATkfnt32hNYrLmmbCY/iCKh/MhLmrP9HIALdHMax+fqN3HNtV7bPLuGOUjKnhlrEvDjvX56z+olAO4qJ5TE0VGKlfjTpQXDALRp57fYxhLGmQIBqiDKALtNGwTox5y+inSrSztJao7mY2TWql6pqJDs34aqsYEHk9pSI9UN/A28+7uZePWomKYAb3+MZS4IJ2JkLRp4I//fkr3RLKTq4xAAE9cIhgqUqrTvxHS2fkD4virvgOyrlUedbe3TNbrQbWAqvqo7XMXHMPesFdJ1VOQgG9o5Yl+Y4nnWG4jNJL2xhIvreXGcKldI21dmP2Z5X25Ghz8btRpCn2QDVUxJ9cfcUbsXOmdmrt1Je8KQJQEPZgNVMOJZ1cVxKt/5dN69zA/ci9y0VV2YeEtNHTuxfIffxUsliCEMKsCkNSnEXOaHBvrvgu0tMkNPuF1QTQuidAlELqTOLhawOBccMU+/2HlkMHlOIIL+3ttijnOjjXD9pBqCXQfZw4M5g1RxqUAnlqygVKULbvqHCpTj9YfgyzcNwHlvCKzZnD+EkSFRgX15LpJr0e3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(1800799009)(451199024)(186009)(33656002)(55016003)(52536014)(5660300002)(41300700001)(86362001)(8936002)(4326008)(8676002)(7696005)(6506007)(71200400001)(9686003)(6916009)(478600001)(4744005)(64756008)(38070700005)(76116006)(2906002)(122000001)(38100700002)(66946007)(54906003)(316002)(66476007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1oM5XTMumdRkK45qdIGMXm+FtnAjAOsn1O7VSVLzMttmBCPUeA+BxvnL+nT3?=
 =?us-ascii?Q?IHhQfAmsz7uIio1kNcWTTUsfaFjUUF18NElwrI4A57ILvsUhBJPUecTZj8JY?=
 =?us-ascii?Q?t8MLPfbMj8zyxqRI+lNFlHL972lFVJFkM49EBfV97tpgijrhdMSi8xoPCUk+?=
 =?us-ascii?Q?3Sn0l8XJtPXJ4DmEvCkwdGyMrRqz/YWI4xpahSOVPjmPPoEFQ4BjdzPEPN1q?=
 =?us-ascii?Q?LTZardL7h2+9iImsax/i6v7wzoZobht+SPZwc8r1Gg9v/GK36u7hp68qG1KM?=
 =?us-ascii?Q?Ce/QKXT1eEzcunLORZXVuRLMqYcBMayf2cWKN8xYDhY8M9Dja58P0KvZAsnG?=
 =?us-ascii?Q?6/7b9kzRvXamOJjmpNs2NT0hW0UJMIK9zksY7vp0by3c2dL7MdJexRmVIWfs?=
 =?us-ascii?Q?uGlJ+gUBpYbl1rQzjyQGTVjYrSNxIGdTsayRMcbrvjaVI0dH4LZ9s56zIxzc?=
 =?us-ascii?Q?Ufhd1N5z14ArU3afteCMWT7BlVHrXd6wCV1bBGkZmrm7ooDSHljfnw3Sstes?=
 =?us-ascii?Q?alrZOVdXvGPy2OIiVg18wgC0a4rYZ2fLFAdiE4KOZ4LVRgEqw1UVDyYs64uj?=
 =?us-ascii?Q?UXeNEf/lkKoW6t5FuO9fcnlsG7sdpcHeakpUPOp5XDmOG5gCP4wKF0VVlLkF?=
 =?us-ascii?Q?qWnvg5KFnZ8mcuyd4TCeEwbffcnE8Wrfvsut8h8GiTUnkpbykh4Dy/djXx19?=
 =?us-ascii?Q?hEtMxj2qwSI70nwc3hRpjbh+yhcOfTg6AGT7J2e5zdmvI5jrl5sbv0SymUtT?=
 =?us-ascii?Q?RwCdoS7Vb7nn3awM4+v8NR7nCelaa6y17q6C7xFvtSJs+8cX5Kr5vUc4xPYX?=
 =?us-ascii?Q?n7xoR3AnG95YvUiWOFpJbk2DbLyzk4f6sogYbwNpUENkur+9a9xkU1t6qUhk?=
 =?us-ascii?Q?Yugp3H3iRltpUGAlw2Xrx0vR3U1/MWBhLWp2I4Uf9Aa4bdh78q2T2D87abyv?=
 =?us-ascii?Q?nmGUGiS9Yn1pYV3fou9Y4YqeFW2/x2IQT8040vPpw4wzDEc8UwmyJIGRcHUO?=
 =?us-ascii?Q?G3e0ZPQ6PMBKwYwbO3E2nfMaTDEcPcbacGlyl77bKKufYhBm6ghjAmVvud9e?=
 =?us-ascii?Q?1Xu2j173wJ4szuDl3+SXq32LmF9qIp5VMe01W1il00dbAelMtX28YTd/K0SL?=
 =?us-ascii?Q?QceJXrHst3hmKdozr3KceUmz59luXOhcBlLYszTOCiyoL4D7W3kZihSYV4zi?=
 =?us-ascii?Q?6un/UkosHjoozQEKlyHjDB3gMDMPDs7upsACVgwSfIU56P/HQAkbBfZ4zcGs?=
 =?us-ascii?Q?0iBku/IkX8cRIr+sYRZGdhxjKGw6gmdF92/0Df1VYxJ4VPVvMetU6npFqPT/?=
 =?us-ascii?Q?T/jd6QYg7mELk+Ueg/sQRMYkVGhxa8O2RZvTEdqzis3ojqB6YkWy8i2IFqcf?=
 =?us-ascii?Q?IttzsX90fDCmJwgj3zoUYsbFeuqsobfHAUDA5z6MMFUF51kmcE+fgWM8U2JE?=
 =?us-ascii?Q?pEj9gnNpY2+rYuOvMrCR9YFXiV46NLvttgQfxwNGNN8qqndS+W2bJ5Bx7q8N?=
 =?us-ascii?Q?2xz5AiLHitAZyVi9g/jwQazy10IlqKvdm9z6ieRvXodZvTE5HDXrtBPzZ+m+?=
 =?us-ascii?Q?EsHap6pr3eBHPj8nwlU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ebbbec-a156-4d83-560f-08dbaa3e8a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 16:22:58.3336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUvJR29/TqtLignrqu0xrLhxPGVBgq5rR10TJsG2+V3VDYXc+sARn4YMqpVGTNe0/C9GlOLHeTUmgVl44O+IjD88ZwfgIxcQPSu/MalJ140=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5457
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 1/5] usb: typec: tcpci_rt1711h: Make similar OF an=
d
> ID table
>=20
> On Thu, Aug 31, 2023 at 05:04:57PM +0100, Biju Das wrote:
> > Make similar OF and ID table to extend support for ID match using
> > i2c_match_data() later. Currently it works only for OF match tables as
> > the driver_data is wrong for ID match.
>=20
> > While at it, drop a space from the terminator braces for ID table and
> > remove trailing comma in the terminator entry for OF table.
>=20
> Just as simple as:
>=20
> While at it, drop a space and remove trailing comma in the terminator ent=
ry
> for OF table.

Basically changes done on both OF/ID table.

Drop a space from ID table.
Remove trailing comma in the terminator entry for OF table.

Cheers,
Biju

