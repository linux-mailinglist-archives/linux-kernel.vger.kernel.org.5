Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3697FB1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjK1GC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjK1GC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:02:56 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27CD6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjQNYlbI7hgRXEXIVPCErTiujEEgldF0p5NcHAHw3+ahyKD3ML1K5FujerajdCAQvjyJvzyr45PQsu2E3iciPGKPOHpyqaBDZUrOp4iDOuj0z7Qf3n6hhV30tKI+hGx7PEp09XcT+aPcCOvn2+qg9zGa9md/2hgwPCUZQbRitdKUo7p1ZaqONwm+Br5m8bklmQuy1mH5ynGGQoLRZZ4q91ook0ZceeLlXYDDnheqiHFzjN+V9pgKMstfWYFgtUMpg8qGyCmZgXot6+KOC0613GhqtlVp625zIHAt36QjrraJSeQk3VQp0PtxQ0c0/zQxn681rLkVOISdxA/NPAgXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DHrp/dDyHmP5K5nO1IUiF8l28fc0DfJaGeu1VYXJcU=;
 b=Phg7qIauZLBSatkN6NiugSdpABXlVEjRitKnn5pcndYZsMlyNZMG9OnWo/9u3G4a6/7ntA79DKKf//wNn481SX2yDEcN8iLpsHHNhcH9mP1WT9YpLVNGoPeKU7ZHxwjLa2NP/npcOSHCmunRHkDBiCuiN14uCXREJeQxXtRTD9QT30SZE1ngV8qTlkqP2ShxELLK0EM/2TE1ez4ea8vFUlC7ocVvzya/cCWZbgOAvUOU640ZkbpBErpgPJIgeCJl+ER8tkfz//bba1Y2yMtp36CJ0y8e9mc/3Cu4QcqAzHuIjB3QdVAk7Y/qXpSULLBJuD7/GuYGwbynj+E4j6tzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DHrp/dDyHmP5K5nO1IUiF8l28fc0DfJaGeu1VYXJcU=;
 b=plzlClgDvfyR+c1eg5vo1gNiHmkrr+9FCQx98fkNN3J4xXgW67ZH6clH/2t67COOfc8aoNqqPkgwhPAzobfNALb6qp1p95hex58NcHJK8zu77xCiICmxIbXpc0nNE55jLjNXGRd89fn7Gx7rzujxq4IRioVWPBsklT/99KuZoIs=
Received: from BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 06:02:59 +0000
Received: from BN9PR12MB5196.namprd12.prod.outlook.com
 ([fe80::ddc2:f808:3cb3:2e7c]) by BN9PR12MB5196.namprd12.prod.outlook.com
 ([fe80::ddc2:f808:3cb3:2e7c%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:02:59 +0000
From:   "Boyapally, Srikanth" <Srikanth.Boyapally@amd.com>
To:     Pratyush Yadav <pratyush@kernel.org>
CC:     "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
Thread-Topic: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
Thread-Index: AQHaHdCRoIA/OqSAv0G0P0pMPvY/Z7CJjvlXgAWzNsA=
Date:   Tue, 28 Nov 2023 06:02:59 +0000
Message-ID: <BN9PR12MB51966705C3E306502ABABA6E9EBCA@BN9PR12MB5196.namprd12.prod.outlook.com>
References: <20231123054713.361101-1-srikanth.boyapally@amd.com>
 <mafs0jzq7dx8l.fsf@kernel.org>
In-Reply-To: <mafs0jzq7dx8l.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5196:EE_|DM4PR12MB5818:EE_
x-ms-office365-filtering-correlation-id: 0e021c1a-e66d-42c5-00e0-08dbefd7ac6b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ipo65BjpkcynMiMwM9XMEKW/ibiF6k+ZSzsShzd1jCxCMZ0KY8Nnboz8HkTRYoOI31bkWyGGB2A3nkuIMN8xnmMYRKf6yrBxBuoTCGCmEQb77sAcTENsTKUoxYLoHPLmMYnrjfZCe5Zj0BNQBOZM4t8C9ztAY8rqnsfkbVAYdGVzeejWXhwd/12BinAhWOhhT2dwNsFsaDw4ySac5pBRUbWiTmUcdmTyLvqGgV3JQyg/Tgd43gx7suNwlJGPL1Y8Zl7y7yB2YjrQ80M5CV+5AnZplSN7WG0Dwpw4+w61e9JN0GNcpS5Z2qTD+32HOGYlIdWgrnhoSDSOBjIO9bo4yKJVquu/lY7boIcLdUPFd6UdOueDH2zIMIPtcxlQW3LT0K7VYM90SUCzqwKJ/v2xFZ1tKzbim2AED51CCrz6ziiw6rbnYoviE3+oo0YCK+dBof026MrfgN56Jk0KwyEicggnYyg7WG7TeqCJzMcsKCWs04p9j0oCNuD1vweoglZYUPqMijt6NWuIwOvDGD5mwPBffYkN/cGgPNpKGkdqxr0EiNVT4hDHGtSWEt5uG5iUVCWrZB29eAsEfrKWtax1lYKTcLr+aMhTkxC956oYX1dbN0/DqWANBbMfeBlnOSKGz5/OUb5ThOzklWBs2rT6V9l4Fpa1Nrx5R51M4gy4KWhQTYXtptI06OvEwEfmefR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5196.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(86362001)(38100700002)(122000001)(38070700009)(33656002)(478600001)(6916009)(64756008)(66556008)(76116006)(66946007)(316002)(54906003)(66446008)(66476007)(55016003)(26005)(7696005)(6506007)(53546011)(9686003)(5660300002)(4326008)(2906002)(966005)(71200400001)(41300700001)(8936002)(8676002)(52536014)(83380400001)(138113003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z2nTFeLlis3MQ5JK6W3QujmDhjgFi6USnhq0YhCiR6/jrHllYybWV6nQNOun?=
 =?us-ascii?Q?LUT0oGImEU1PEOq9ziR7NOJD+Wg7dlwbDKU/1VRTS/VUOyaxM7/O7Pm91l5R?=
 =?us-ascii?Q?kxFney8S/aU6BgLpUs7W/TcdDXoFdWFXBrmcmvOZioOlnMgs6Wl1SSc460J6?=
 =?us-ascii?Q?45HgDC/NsJYM9nhQMaNi6Ot5gG72I/sejN/PYXzPfgXrl9FEZBgEyQXDG4Zv?=
 =?us-ascii?Q?pHF8wSinE0A/QHsJt++Fhd3i/JeE4tLvVIvEgIlp+GkS1AbtQ7NK2j7Sq4gY?=
 =?us-ascii?Q?dm5Zt+Uez69hrs+eQpW1q/Jbbmy6OJRpASPXxDECkZ+ITUE0K1vfhNPOqbiw?=
 =?us-ascii?Q?Hh3qVEokWUU4SjxoXtpJv9uG4AASy51iaCblBSmey8mOaWCSJDD5UKIp+Onm?=
 =?us-ascii?Q?cNGCmG8/1hmIvqFGHxOZUc8vosUX4cYZFuGh0dTElzvaopajALhV3V4ID0RU?=
 =?us-ascii?Q?bjXwbhd4i+xJ+6ejgNmtFfuuUJekBKyZG86FQX3XBdk4c9GA4Wy1omwkXut1?=
 =?us-ascii?Q?quCgNlcCFUSVwRnwp36WhLk2SVmWs45AMqbXyR6HKx7cSw8Bby1cNXrHWrBl?=
 =?us-ascii?Q?pXSy/F065sU6SSVm6wSQ7ZNHZaKi9T6Wp2oFpj+1GselIKqy0kbVfAL+MCHZ?=
 =?us-ascii?Q?0ao6qWpKbhalm0Zs0DxVful5r8Uwi+tn6r6ny3NQJ83Ls6u+pzU7cTmRzl5x?=
 =?us-ascii?Q?aBwnnhQh8piSy3YaYk8W4R/r37BHyrv5BJBpcfKydyugbzs94fkEAH9R/D1o?=
 =?us-ascii?Q?65dFz1SPHzUxT2MVGKbJCYGozYP4gguZL3+095Vf8ii3hqhzbteqB+k02y0R?=
 =?us-ascii?Q?R5cYvaepy78M3fKqsZnVjxGZwJPef7AOUunxkq084n416Qu43NFWiTjV3A6V?=
 =?us-ascii?Q?YF3K01Sg/7I2tXFg1KJAsVMiYaT04a22gXYoMPi/IqAoch0SM0laZGwe/RZu?=
 =?us-ascii?Q?5Zi+7Z96461Ej5rIQRyQmBR7Vo18T9gM69QG780LwdckCq0q3FJVQim6KBx+?=
 =?us-ascii?Q?ibz7aV//e/1VF+B7Ha6GhVmMhLcQ/8lcdD7yvFRdYSIBXDtXmfReund/Kyhu?=
 =?us-ascii?Q?3G4Ms2BnHshPvCTIvvELerKfmtzXNxGmfba403KXu6p7sft7P+1cbvFi7T58?=
 =?us-ascii?Q?gW1dafhktKB9zWSOYTgTMoNxLnZ4p7INXQTGrnPsYIrSwezDnNcm60l0VO1W?=
 =?us-ascii?Q?2RWZICnQgndaTHVsgcUezb/lZgYM0yuvUvK741y8uHtnDFDxd3RBcFiOwBF4?=
 =?us-ascii?Q?TbUQE6ZYc/DnxwpETx3chH00m/29hX9UJYY0OP5XZ0RNTg9fvwnoYefqlROm?=
 =?us-ascii?Q?OUeR6L7/JzeFEgmDB+jkoaeDQ61KqtHwPUuZz3uZlauLBZyA36r+hKup5G18?=
 =?us-ascii?Q?wpjWJfuFJop1acRVzrXVDYm6YfKk2VAfO5S4fHuqgMgkiIkkw8Hl3pNNV+ZN?=
 =?us-ascii?Q?7S3cxR87tAo2dokwClJy4tL+y2b+hbhaicw/qG1gUE8btmtprnkFPpcgYme+?=
 =?us-ascii?Q?A6vhX/h2zcxeKOKIoUX0la/y82Ovo7olWT8/mSymUC/mujF8iDymU9WGcH4a?=
 =?us-ascii?Q?+0GgZFNNdrAPYjSEECs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5196.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e021c1a-e66d-42c5-00e0-08dbefd7ac6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 06:02:59.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sajArJJrlk9oH6UZJNeBlkcb7XHnpV1kLL9NAg7K3raao7sUjAZhHUj6M8MgB5uNf6uQYK3r98dig7Cd57MyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pratyush,

> -----Original Message-----
> From: Pratyush Yadav <pratyush@kernel.org>
> Sent: Friday, November 24, 2023 8:17 PM
> To: Boyapally, Srikanth <Srikanth.Boyapally@amd.com>
> Cc: tudor.ambarus@linaro.org; pratyush@kernel.org; michael@walle.cc;
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
> On Thu, Nov 23 2023, Srikanth Boyapally wrote:
>=20
> > Add support for issi is25lp02g.
> >
> > Verified on AMD-Xilinx versal platform and executed mtd_debug
> > read/write test.
> >
> > Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
>=20
> Based on a datasheet [0] I found online, this flash seems to have SFDP.
> And since you do not add any flash specific fixups, it likely does not ne=
ed an entry
> and would work fine with the generic flash driver. Did you try using that=
? See [1]
> for more info on contribution guidelines.
>=20
> [0] https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
> [1] https://lore.kernel.org/linux-mtd/20231123160721.64561-2-
> tudor.ambarus@linaro.org/
>=20
I ran mtd_debug read/write tests on this flash, without adding flash
entry, it worked fine for me. Please ignore this patch.

Regards,
Srikanth B
> --
> Regards,
> Pratyush Yadav
