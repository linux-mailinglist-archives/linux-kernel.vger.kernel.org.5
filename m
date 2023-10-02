Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE67B4F22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjJBJi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJBJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:38:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB983;
        Mon,  2 Oct 2023 02:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF6dZ6E1u7YHXxnfP8UgDK3oVverGCCHhhRizFfesMvstWmN4ct1ZNHT3ikg8xzpJHkdnSdlnzrLlsDUkgV33jZrU5aUBpBikSzc5OL+XfQPd+KvQ6vCb+mPPSYXWXBk0YKjh2Oz4xntz3UR3+zIweZpX3qw9csZuqulMZpsKDToZGvL9heX7UWsxjJlSH+AIfN/J7lqTPyRDR5OjOIXuZ4dzKkcL7AfzII7/VzJA6ENkhtxnmN+sOqvl51PVj3ziuUdH7dz6rJLeTI/YX1ldipnlBbM1a4IIZIRTuJmQqNkuIy2iKAJP8roQjC++v1UEn7JatIsn8/kiPa//vEb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qzRaHo5+OkPhtyhqhmI5dAm+iW6Ydp7tTFNpb5vSEw=;
 b=T7+4zzqh42io6DEExemJcUlSSv5Ux4cwL/j0MpNfL/bINT61Lfn7kWHKlGy6Egj5ddzKKVtK5lG9wc7fIzrYFsi+lqKWlP2U0HH3JSUKMSLbzpPGAxO2vJOdCqplQZBi9rrnbdH0wwGXEpFty04ATscBiVhlxyJCebAYkGPTfZwQaM1yfhh5rfetryn5uZ9vgGM6DEizObnKwKh3SSlNYuXePFqmRO+anRGBb2YchnZQjQ+n/4pROHHBXAkRCaYvVG03/yA8So5icl39ntHmJ4ULRDEHuVIgItGvlomfwR/noULFMRXLfyB3xUMetTYBI46dte1kUqiVndySiMPgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qzRaHo5+OkPhtyhqhmI5dAm+iW6Ydp7tTFNpb5vSEw=;
 b=GNgdLEyzaPAe9tN7sPINpY4gKCyv5DMKOv0ET1cgExPi+29VhPm/rcpioq9RoFD25o7JVlPEVR71wwZdN347dXn/ObxD4bt3kYNSO2p7IklK4rr/7/pp3s+0LFx5oIdIzzCgw0DarsO2Aprm5eiRNhZRfmYLAjHnXGTsVlBpcZc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11103.jpnprd01.prod.outlook.com (2603:1096:400:3d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 09:38:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 09:38:17 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     =?iso-8859-1?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Thread-Topic: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Thread-Index: AQHZ9IHazMX7YhLcF0uqntJC6sFjerA2PGKAgAAB24CAAADD4A==
Date:   Mon, 2 Oct 2023 09:38:17 +0000
Message-ID: <OS0PR01MB5922C468BEF67BC2A19F87D286C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
 <20231002102745.0000540b@Huawei.com> <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
In-Reply-To: <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11103:EE_
x-ms-office365-filtering-correlation-id: a07f4a91-d7f7-47f9-061d-08dbc32b4ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBNaQYzigufmzCBfjpj/cfNhFUmpxojCS4KdLQ7RchG0epXhIxZedclpTtfXD4GcWc4G1B72PM3B5ECHROfdrj8O/lVrtoTFsyakkOBFwpb83JaNbCGHcgdvA224m6CkIXFSyIvLMeLv/Aj/iggM1H9NZ6lp3YjnPckLsv6Tc6BPYY5Oyxhj3IyUSgU9xrYrQ2iV5bm5WbQQtf8qwrlXlbRwxMXyByvzofxbx6XRaaxXxoH4dpIi5xCehRcEIiNkbPRc4PAd/cgFLwOdVoh4Qw6v2NR9vyDB7oa5/DcWrKKuFTT1WLGsCTEOmUc/EmhJzSvVohnNiS3CNy89G10Q/dwNqXtAISn2Up4xYn0cshqKFrwKNEk0Yn/sed7AY6/DZLQV4k0kLdsEeXad9c6w+KkFoEcJofnq696rOzVLM98+NP9rjxKIh0JfIp2X0H88HN9RfVs/KLfxBVJ4p7m973t1cabYxnbrITEaZYO1tV0XWwmrcZmEKi9GuE4JfKS+yIsCcfZOMtMjxMDt56ArQjAzVmI7i1CZ7Vui+WtkJtD8NR27xK8xX0DUeMggQfGU5ByLQgoPFsykA1Yn4UHVvdPSkIgdidVC4RlI1Y/bC5mN0iggOIj0/A2T1biP2BQr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(71200400001)(6506007)(7696005)(478600001)(9686003)(26005)(4744005)(41300700001)(76116006)(5660300002)(110136005)(66556008)(316002)(66446008)(66476007)(54906003)(64756008)(8676002)(8936002)(52536014)(4326008)(66946007)(33656002)(2906002)(38100700002)(38070700005)(122000001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RhEOX0DjjQ2X/kNkVNj/R0mT4Ob0oeHZCI3mwlsDDy3thjk5bAllZHeVgQ?=
 =?iso-8859-1?Q?ds/hhBG3f4/oIQ8L3rqmVIBXj+WU9NyxlWHwoAGJsx1Omo7qdcmOebuLqD?=
 =?iso-8859-1?Q?ejIiACWeHd/LKCcPU9XLYP+3UAPLX6q9RFzeJ5Nv4d7uVWDHP51V2vYXW3?=
 =?iso-8859-1?Q?aqwIfp23Pgjh58YV741QVZfJKLS1rMJQq7U3Jrap36EPj64I0dyGlUP4xS?=
 =?iso-8859-1?Q?5Ij5yra5Ebk9WIV3IF7NhW1hR9XMIcOv33H+HG6r/+SX0ZnyloCLasrSn7?=
 =?iso-8859-1?Q?al/v35Y3XkmFyG+SfnySvT9luIp/Nmx68UlHmSdqsqIh0PavtoSM1uChO4?=
 =?iso-8859-1?Q?JDZ5HuaZDq2Jlv6H+OGJGTCLZW3BEAxooDDptMFi3vNLUE2uPk76LLsTLO?=
 =?iso-8859-1?Q?Q/MeYCl7kJ8TuzqdGXiOYrenASi103zXaDnaLdUhMRZeUHaF6pXPSwGnFw?=
 =?iso-8859-1?Q?ftrP//dEYcodfdHkDCIIZs1cJxmSig7gYsMuDD4Q99nqLaetA+xahYitUx?=
 =?iso-8859-1?Q?ekWKhkg/djOZeaiqjtGS6+wD9J0zf+MMJ4/+TD/a5W85lif/5TIRT1QURe?=
 =?iso-8859-1?Q?E7Zcf8MnWTrLR3+a3O+FupmTqX/5xwsIOq4qUYu2tksrhssCu21cKbqxfz?=
 =?iso-8859-1?Q?48+0H6vRVNJ7jSmTYAo/LMvQON1RhZcUta0Qj3fXx5SsGvj9IyPwMPElXD?=
 =?iso-8859-1?Q?9XpCkdbVjRCXC12tlneEVAiqgzfs25KM4le0x1EiVIIrUdlM+Hh7tE9laW?=
 =?iso-8859-1?Q?iLtTk7+40JDHdvHNt++dZG331mX51bL/A32MTxTVHuWrLSKntqyCqUPpCK?=
 =?iso-8859-1?Q?8tL1aX+bEbKL1K9/SApNK90AGu5ssP6N4Ty4cbJCrESlwQmDagUeAW7/MF?=
 =?iso-8859-1?Q?WsH1/XBw5i/IyNHIn/LDZBdr6EiYV48S6Pc8At2F2PGyt9JQ1H4o8f294k?=
 =?iso-8859-1?Q?REXxrqnPUN+EQfmFZ+FocdAK+GTErBMW4IAm/QcNGlHp2/oJk0qx9djzr/?=
 =?iso-8859-1?Q?zT6V3PyDNAXD4OmzkAVsoSONhXWzhHx6lQaEOdjPq4e0livFa4q0WSYY3c?=
 =?iso-8859-1?Q?FMofUV4lU4lW4i6/46fu2Z7tg/CtRqdHVNo3GSTEXTU0ZiDaKvQzlB29cU?=
 =?iso-8859-1?Q?62C6/QSEA8H68tprkFK5jIFLnhXkGPp2XGj9VR5NXqTH6IzLUNfz66LBw4?=
 =?iso-8859-1?Q?zrMiJj2lv55V7UkaEGytXOs6lzAnQMDANyvqJOu6MnQwFWtDBSHRQPVXxr?=
 =?iso-8859-1?Q?dZryCTpN5ET2HoI/WO4a+XnnReagpUx3D7rzIuMSg3aFw6KOkY59ScnBOi?=
 =?iso-8859-1?Q?lXhetkPaNNEgrsLb661nYqTfJmdUCUp6R+FHgffHqxzpaOzgkRKtEcIZYn?=
 =?iso-8859-1?Q?ptBFz+DYxNRQdXhmnUeeacTkDx0BY8GKldnjXwZlxdlDKJzGG/zYzNXzvO?=
 =?iso-8859-1?Q?SCGMSRDexCMSTlBr27/mcaZsQ/KAlecU3EREz99hQHHVFS8dxG1LO9xyN0?=
 =?iso-8859-1?Q?us/y40d4TvP6EyZbwo7cPoWTLtbFW4zmN40TFeZi0Phj36BRbRyprZWr2O?=
 =?iso-8859-1?Q?zeszZhkXEXgpSLIO22OKpbhMld+nBvBtGQ/nTdmXncgO26DlzBcRhpVTng?=
 =?iso-8859-1?Q?SjG4w6ZkD1LI8ffc/XJrF3/WU8cpFuLjqtGBpT3yHZDat7KIHBIGZU6A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07f4a91-d7f7-47f9-061d-08dbc32b4ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:38:17.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfRE4up03Ho2EsIOdeVv/c243utPLSRIFDJcPPdwFsmh2LFcbEl0MiX5AQZcfMNbCRa8DyzspRUADgmo/H6VzTVRzVEKbZrO6bZzoBzbAEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device'
> error
>=20
> On Mon, Oct 02, 2023 at 10:27:45AM +0100, Jonathan Cameron wrote:
> > On Sun, 1 Oct 2023 18:09:56 +0200
> > Andr=E9 Apitzsch <git@apitzsch.eu> wrote:
>=20
> > > Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert
> > > enum->pointer for data in the match tables")
>=20
> ^^^ (1)
>=20
> ...
>=20
> > So we need the spacer until someone converts this driver to use
> > pointers instead for both of and ACPI tables.
>=20
> Isn't it done by (1) which is in your tree?

How (1) can trigger 'Unexpected device' error??
It returns match_data, and match_data has correct device type.

Cheers,
Biju
