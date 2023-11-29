Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD57FD6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjK2Meq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2Mep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:34:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB68BD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqI673Lvs3iikbNBJK+1PZy1nUIFqmg2sawp4KdKJFiHb2QfinAI36fVOZv19BxLmhQ3xeHK0WjReTeKwY3B6r3ez/2yC+XlsFDYd7825jFFDHTA2mk+Dlc/iVkYhi2mkkGdb+jmqz5gNkeSx44CMrvvRFVk88HBZJI/Cx3MgMDSRR8hb2fLEf0MG3pRQQK9V6K711vY4p9lj3sCzxmSYNtONXssp+rp+F+gUZ+66c6kY3+O/6H576wVtOavwQ1MgoVmW2x1rpohgpIH+HN2fkD1LGcH5TLViyqbxpUUWO0abcdw5yXxOSo/Gy00Pputc4kndi/p5VlJBz1oetbXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Sc6eSlpkt+LbXnxUmxb1NwV8Yyhukt5D/crvXzelCQ=;
 b=BohpcW7qdDWomk4WCkL4YaismohA9wZ2psg/riZ0OltLu41nTKM+z2IZGg3Ky+dJw8I02IXEPrh9GnwoV7tRsqscl6WdxOamO551R+tSu1MUEvFsb2jdWK9sRyINM3zN9jMAz74mJN2OGrH3fOkGwQlCLIFpHSZOeVtJA56Xa4ncHx5ujKqiLUafruGvnqz4YCzrpEl9oLS2+1EhXYSdax3TqkvSyUzEfxWP2aCxL/Tk9XfaEobWajV90XlMD/ugUqrlPzOu1GPo4Q2jPrxCCjQIR+nNiUs0FclALeKYlvAEIydkHZP6nmy2Od/1IGyqoR1i5MGgd5u3fxidp97rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Sc6eSlpkt+LbXnxUmxb1NwV8Yyhukt5D/crvXzelCQ=;
 b=nwKL5lrxmKgiDzC1Ii8+9DPZ4ky4CjrXuW0DjSBG+0zalYzx3wshJp+4z0gf1Fht+On2J8eHOIu61RAN6kJP7bHmhhZAHXmqQvQmIeE3TmQcriwRuX85umrAcObdtC+yBMa5ZEVrqke55kKmXqFCHtL4wcKeQZVOr6mfE9zL8gI=
Received: from BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 12:34:48 +0000
Received: from BN9PR12MB5196.namprd12.prod.outlook.com
 ([fe80::ddc2:f808:3cb3:2e7c]) by BN9PR12MB5196.namprd12.prod.outlook.com
 ([fe80::ddc2:f808:3cb3:2e7c%6]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 12:34:48 +0000
From:   "Boyapally, Srikanth" <Srikanth.Boyapally@amd.com>
To:     Michael Walle <michael@walle.cc>
CC:     Pratyush Yadav <pratyush@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
Thread-Topic: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
Thread-Index: AQHaHdCRoIA/OqSAv0G0P0pMPvY/Z7CJjvlXgAWzNsCAAC4kgIAB0uBg
Date:   Wed, 29 Nov 2023 12:34:48 +0000
Message-ID: <BN9PR12MB5196EF2D4EFF36F6FCD7BDC19E83A@BN9PR12MB5196.namprd12.prod.outlook.com>
References: <20231123054713.361101-1-srikanth.boyapally@amd.com>
 <mafs0jzq7dx8l.fsf@kernel.org>
 <BN9PR12MB51966705C3E306502ABABA6E9EBCA@BN9PR12MB5196.namprd12.prod.outlook.com>
 <6342ad8a798ef811d37775b7269623a3@walle.cc>
In-Reply-To: <6342ad8a798ef811d37775b7269623a3@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5196:EE_|CY8PR12MB7241:EE_
x-ms-office365-filtering-correlation-id: 936a25e5-f8da-4a83-2271-08dbf0d7936f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bD8FIz5+phi/BNIvoaiz2L4xQsJQV1vQtT6eEVbnC4AT7mr79xkqArNBZ51Fp2883fyg5leLGRaPod4JSZ/s3ndIZvzyjqCvZkW+J1W+UmuCp4dQ8TSlj6ypmsVEy4xpvz/ffXoExfUDGvyUCVSxCRzaGBOXdO2nol3Xt+pQTqzudXPxDJC/Yw2GfaPoWeGYt+saIYIl3VxvhmBd+eVwR0wsZoGtPNgGPu+zxoXuRHRNgY2W+hszrJ4aZF2kc65pndAT8XmpC86fnDoOG1npTZT14E2aZYPljP8hzSumgdymHgfFBy5YjwBFKGY/V63UyxeLrQAnMAtMsr7SHERZ1eaF/eUBiI35GS7eZKy6gICpVLZuHnIK+70quTp5/RAgML+1QGwFGDdJ7BsFhJuhcZw5Tz64Ie8S/IAT051Mgb0/GOJDQItzfOnKIY4Sis3iSFyHBNUL5QOJeiXCS/TesVVKkJTq9rFqbYLMbqVuf/XsL32HEHFMHbXVxm4k3Bqr7BpSZTpUui/xsaDlgsfn4aZElyYMPD3HJq6Z9uSpwyM6OfIdxfDL5GKv9m5OoVSzVbnW5SDzCM+0CJuBpMi+kafDT9faVVpSCNksWh2E3P2Q/TkidLhqe7COGm4xvd/CZ2H1E5Ng08+VEuVDSCAWuzUpErqPgLinyePHggyimC2hmDzMXn1Kfau/g34mIKYn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5196.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(38070700009)(52536014)(71200400001)(86362001)(38100700002)(8936002)(8676002)(55016003)(5660300002)(4326008)(122000001)(2906002)(26005)(7696005)(6506007)(478600001)(316002)(66946007)(66556008)(76116006)(66476007)(66446008)(966005)(54906003)(53546011)(6916009)(64756008)(83380400001)(9686003)(33656002)(138113003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d/8ND9Iss38TjJXGLjbjfjVKLiA9UjTmKamnsaUn1sN6D4pgoU3lLHG2j331?=
 =?us-ascii?Q?NBo66SCk3ujiXFPVTBIPIOzGsuNQNGEnohNdKrYVd+qHB6Cz+TDWgrJCr22/?=
 =?us-ascii?Q?cfpi2QgWnLOo7tAZzvvY0yS6u3tuOocxUwMMgOnon/+CDMvU2VNIcDRgQA5b?=
 =?us-ascii?Q?Y+kzyzMq9RZgnbpfTxjh+ed4+EGDmbpYFEnXpDGNcuxfr1TxzHixCJVAsq7F?=
 =?us-ascii?Q?DFvIfs1gvAXddRmE2C7Q2XXUvlHqzdbG/tHJooPp8f2tIQF46j2WIhlgRAZu?=
 =?us-ascii?Q?DGYXknpXJbjr4Yx0pnMVEuJOuoHfIklLP43bfsz6JTe+1ie+VX7SiVH8BPU3?=
 =?us-ascii?Q?XHMt/wbisr4B7lc/JVi+RXX3T7nTJdW3pprvZP3tzYnOhdSe2z1upQIdOrti?=
 =?us-ascii?Q?Pjzl2Z0RN94XUD9VT/QJ2OQGJ/N8mCjebNsTIGmvw63Hils1QOsGL0dhnFPd?=
 =?us-ascii?Q?l7oogy9Mj9JE+ovahsNXzhWMvLFjUtXdsTl09dmKHVxXvlNGfbHs6NlWTO7A?=
 =?us-ascii?Q?b6WeTzHnw6ymvIytWU3kAs5PVSeIT1PNX6NbyTAMaU71oc3Ge2BxaZFjfFjr?=
 =?us-ascii?Q?qCvN+J+/OoFz3WBYlEVvhtuyV9H/7gr6KNtob96uJhu1U/Yj+Bj2kGVCtVM+?=
 =?us-ascii?Q?XkQ+FUAQ28xBPul+DNXOKFJDIxX8x89r0n9rciWxYsIncr3hr2eBbXagtS1X?=
 =?us-ascii?Q?Tyy1/ykQW5p6L4G4HcLZ/LlMDvsNHrCkzifSNdhHNF0Zu4Yy33hudYgW90im?=
 =?us-ascii?Q?FM0SYIRenUjN632mHnHFArZmowmaNi00Jfx3AgcM1Ktgq/jie2lGNJ6jZ4zC?=
 =?us-ascii?Q?2jwN7HdIsOyUuO36ZbqFWD2Wekgwzx5QNSTvdYT07LjkxmRyPk/LJf92YrY3?=
 =?us-ascii?Q?S3WEHB8n93K66ljtd6lgpXiIGp17+ZqLCKfDO9xRPTuPmlIPFinYLHCQ+UBA?=
 =?us-ascii?Q?rBAvR0CVCVVTox71iQv0pr2rtAM/4taYQ1t8AuG/L1G6qTkZ15b4bFzFUzpT?=
 =?us-ascii?Q?ID+IVE7sGEJmeFtVR0+WTRfdC0KqzB4xO4irDhZoGMjsvKQ9toytHU1FrrpY?=
 =?us-ascii?Q?pmvnzhdiRgF/GG251Sa3oS9sy/robs1dIo1jFx+C5bNDyV5YmbaFsClL6jec?=
 =?us-ascii?Q?9sd3AsGnlB+k6RKTHOTb7oM76KsBQrg30vYwUvwWptXosqXLuZA7YxGFFryk?=
 =?us-ascii?Q?JXNM3UakzoYO96V7K7dmN9GzH4VU/hpuBGdukL0j/E7dPEBqvnnBf6zvDYSk?=
 =?us-ascii?Q?uYaS28xxj9eGfyukbdHGgc3yk1okMVb8T2Ny4xKJxB7Eo9F7kPXjj3DTEq+w?=
 =?us-ascii?Q?SJvINgkWyXeVnZ7lJHPsv+Bv7CTu5V2QxATeq4sGc61EEP0J84WkWrKSi3aV?=
 =?us-ascii?Q?97dMb16W5y00Xt6utPPdhgND8mKOOVs37BM4nrtLx/vxT050JoZnAAEnUZ9f?=
 =?us-ascii?Q?G1ptMLY2e+cLoqv9WvP+cL5M0jfe/fK/qQTsH/O3Du/x+Xco+RE9mArhRDpL?=
 =?us-ascii?Q?k5Hl22IXD7K8M48QpTOOJMMZC3pWhDrNnEy8AAq9UKn3MaJ6I3qsjnLbPNvz?=
 =?us-ascii?Q?dEPsE5JFelrqOC8Aaj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5196.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936a25e5-f8da-4a83-2271-08dbf0d7936f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 12:34:48.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3JCswlhFnDnINUb0/bc0/omDcCYg9RU3BYwVdgwC/yCnHV9G0qwGJO5xjw6s7pU72xoZcNuq1ftoZO62FlwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, November 28, 2023 2:06 PM
> To: Boyapally, Srikanth <Srikanth.Boyapally@amd.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>; tudor.ambarus@linaro.org;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> Hi,
>=20
> >> > Add support for issi is25lp02g.
> >> >
> >> > Verified on AMD-Xilinx versal platform and executed mtd_debug
> >> > read/write test.
> >> >
> >> > Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
> >>
> >> Based on a datasheet [0] I found online, this flash seems to have
> >> SFDP.
> >> And since you do not add any flash specific fixups, it likely does
> >> not need an entry and would work fine with the generic flash driver.
> >> Did you try using that? See [1] for more info on contribution
> >> guidelines.
> >>
> >> [0] https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
> >> [1] https://lore.kernel.org/linux-mtd/20231123160721.64561-2-
> >> tudor.ambarus@linaro.org/
> >>
> > I ran mtd_debug read/write tests on this flash, without adding flash
> > entry, it worked fine for me. Please ignore this patch.
>=20
> Great! Could you please still dump and post your SFDP just for us to have=
 more
> SFDP of diferent flashes? See [1].
>
SFDP dump:
versal-generic:/home/petalinux# hexdump -C /sys/bus/spi/devices/spi0.0/spi-=
nor/sfdp=20
00000000  53 46 44 50 06 01 01 ff  00 06 01 10 30 00 00 ff  |SFDP........0.=
..|
00000010  84 00 01 02 80 00 00 ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000030  e5 20 fb ff ff ff ff 7f  44 eb 08 6b 08 3b 80 bb  |. ......D..k.;=
..|
00000040  fe ff ff ff ff ff 00 ff  ff ff 44 eb 0c 20 0f 52  |..........D.. =
.R|
00000050  10 d8 00 ff 62 42 a9 00  82 64 02 e2 ec 8d 69 4c  |....bB...d....=
iL|
00000060  7a 75 7a 75 f7 a2 d5 5c  4a c2 2c ff e8 30 fa a9  |zuzu...\J.,..0=
..|
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000080  ff ee ff ff 21 5c dc ff                           |....!\..|
00000088

regards,
Srikanth B
>
> -michael
