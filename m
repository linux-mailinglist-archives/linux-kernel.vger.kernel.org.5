Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648679B9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378588AbjIKWfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbjIKMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:02:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F552CDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxnKoLUdWEflqpCofOEzN1rhyfuCK9GG0Z7waDtTbVq/T3FJUvVePxiNEHbuWCH9BzGUFCh7jIe0bGJhflBqAfpND2h60Ng9X6wLxsGPg3X4dDZBSUX1ywn5cKwhU2LlQfWgHMiRquGP/XL4l6UNUR9w5ld20iIJQXQFZuqFKwU+QgDGx7WuhqfToYKqRM5z19QoSMbKTVbwLepE7T1Bhx2wB8SNY2kxJtA5p/YQptTWGvwvLIzd5ctWmXOIA2t5bNGRSQumeDuscEtKFM8EJUjo9ca1/PVbhl4KeA9PUK44nR90Evki1DGnSgWHAb5oIakSUEy3VdmNMCxaUC/nMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGJFhUHgcQiEVIqMTcoXfYdaxNvd9l5E0Iq/EeyYOFI=;
 b=LZIvbvMUJC22+6ZqX/t1LeHta2KwSsVKkY1xrp55bKSdBcFTKRWVpKU8vfoZSsVseXCNaWp997leZVAVKX0hUjFFzCybRCa7hQzsz/fBJrcrLNjWDtVdWpZhcTJFI1zBtv751lPZmUnjmlPtMeKILcnVsJkCZBczHVnkRiaWtXxbMuKqjGzqGwEo9EQ/H8foyMfdAtDO3QUf/n09deVXaNoAkljaG38EhpFNXUG5i3rjl5C8EPIOYDAfWk4KSURrAyOAjLXxstbBDnF/1155J06jNOIxKJtDrkl0+g7nYQIV7zYYv7jpG5b9ahIydNg+s1oiqVeJiLAOExsjWlbQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGJFhUHgcQiEVIqMTcoXfYdaxNvd9l5E0Iq/EeyYOFI=;
 b=nuxAFKv4XqM6q/x/XkIOhHrV3pRlhu9Z02cI5gAqUiIoPIVf5T5IvB05FBfoKO3xj4d2WBOVXdDOg2Okl0wG36PcMH5fm8DcphLhM7nQlL8KbpByLYexWKhxOCJaQ2jbgxxqlaym1h2JTLSWSHAjDOsYs5VVxLa+uBMDJA4dXxQ=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB11043.jpnprd01.prod.outlook.com (2603:1096:400:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 12:02:17 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9f88:8e:6f3e:640]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9f88:8e:6f3e:640%2]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 12:02:13 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: RE: ld.lld: error: relocation R_RISCV_LO12_I cannot be used against
 symbol 'riscv_cbom_block_size'; recompile with -fPIC
Thread-Topic: ld.lld: error: relocation R_RISCV_LO12_I cannot be used against
 symbol 'riscv_cbom_block_size'; recompile with -fPIC
Thread-Index: AQHZ5HTgjRz0ZBWpfUmCVDf7JeMlRrAVdvTw
Date:   Mon, 11 Sep 2023 12:02:13 +0000
Message-ID: <OSZPR01MB7019B9CB51DAE22757845D02AAF2A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <202309111311.8tcq3KVc-lkp@intel.com>
In-Reply-To: <202309111311.8tcq3KVc-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB11043:EE_
x-ms-office365-filtering-correlation-id: 1e9e4f70-98d3-4455-9b6d-08dbb2beef52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dS+mB9zr5WyI+kdCGSSHFAKSgPdWGNt+M09am0ykeNUyHQl1nf7GnvHizWQFir7O9vCSPoJRTWUND/Hu54XMqEnGv0s2CUq1bCo6cAXLuIGFbVD9GtslTPx3EYbCniqrBDgT+G3I4VHU0LJBajBFwVWX4MR4BenJliqrt7AhE41vQC+l/txPM//O7+9a4WHWKo+uXRHnHkT1AfPY4U94IkYCc5vx1Oyy6PwBaCbdFSUpxi72y59qz+DNqeKBlZbS/El9qZM+nDcMm9MmY+dmoZ4Il5UUjrxU2tesps8v75eulz8SFJ8uS8C0aSO5CkjR56ir2HwoKmuRFPBjiy+FxWYuReL/J8pi9r3wSG6HkKjmuQrkwMmDDXJPt59E/Eyf9+YiS39nGgNl/SYeBrlptieE6mHebUrSiljtmLSsIGRfMWmDIWeE33/+oOD/OIzPrT+r6j1lKPDj2kh9LKpiea7IhsXMWsQDFP/2ezIumuBQ8fVInMwdOnMtkEInWdhVbfmcHBtUuEKZI0EXINgJM2aTi7Q5/Uai08EPDtXP/aIE+BTa/F1RUBqPBostGX++fO9tg62dTg4VBzm6Spc9xhdN5yTN3meetsVscxup3Cw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(6506007)(7696005)(71200400001)(9686003)(966005)(45080400002)(478600001)(83380400001)(26005)(2906002)(54906003)(64756008)(66446008)(66476007)(66946007)(66556008)(316002)(110136005)(76116006)(41300700001)(4326008)(5660300002)(8676002)(8936002)(122000001)(86362001)(33656002)(55016003)(38070700005)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LXGSolZHdnikJSoGdChFdUXmAhpqEUNgdqlQhzhHVFHSs4qrBHx7NXB4m5Xu?=
 =?us-ascii?Q?awL7eAtHzVWUEJdlLfLzhktoZqOZbEwCauwKh77n5Ao8HppBefeeWfb3v/3E?=
 =?us-ascii?Q?r/didL+mpopwsuuEaybDdC23giQrmWNhlxbeM3iNo2UUKZokCvRJjpOGQaN6?=
 =?us-ascii?Q?S/Rj80KJJ5fcYEJovxG5KjaeypS+esTASyLqCfITMVUUbQ0BEDob7Z6vtkAg?=
 =?us-ascii?Q?SefaDLjUvu+3c7G4bsFUF2VicMpON99cymZ/1HWwTrevWvREHlTGVWXyij+1?=
 =?us-ascii?Q?2263iGcXALPk2HYGpxy+2HtaEuO6+kTguFbXvwm5KaJ8fj/VO60FzNLLcpTC?=
 =?us-ascii?Q?EIH2wHPAL6gwhFpnda0nKkDwMri7LAMFrkzmWWH1w4cnJkuh6v6nH5LWsC3V?=
 =?us-ascii?Q?fpzELkPvPgypTc69Caze0rxFF7hYsUpV5ykjY1Fcsn4PqdEP6ZBTCiX2vMpc?=
 =?us-ascii?Q?paQTJd2FsADlFcKLFj1xvwO7r8cR0S7YhY8eFvHPq+T25icHA15IGVoFVcFz?=
 =?us-ascii?Q?8RPJDlKJd85k7g5rlKgNI1HWxsWhGOS3NCdtglu/wkiJVKYm2cFFwYO1Hn9G?=
 =?us-ascii?Q?tZTTL9ZzsQ26B5gjljCAXnkiWJraY7Oms73x2ew+20KYFAvmMn/eM4qgOIri?=
 =?us-ascii?Q?xt020R+pkCqLb7tMQZUX8w+H0/Pc0/C1QMd2krByGyCRt19wknXgmmAxXHBH?=
 =?us-ascii?Q?6HMy6wA3NUizXlQSg+ums5oh9uZ4XprQxVQ20wA62rHscUjc7AtSKQV8Gyp/?=
 =?us-ascii?Q?Uf/LZzmhyQoO/BJWGe2zvdXZ3h4EXwVyHzbRumbFN6uHu7RtSqchIumQK9Ay?=
 =?us-ascii?Q?adu2d1/oLWKGq3Ktf/m38k1SePQugjnAUXAFyQkYZPqsCvDmSZ8jYpJE74xy?=
 =?us-ascii?Q?Z2H6x/6h4bUNDmTL43X7xtsecuUQNtJNSVkeZvilfxDxmA7bwqARbEJg3O3V?=
 =?us-ascii?Q?GdV/yGPT5lxSILE/xxq/Ed+Eja20R62ELDdNaWLXg2YkwQLgwKZXsuBBQ+pW?=
 =?us-ascii?Q?krzBB5UUStDRl/0WVka5iiSTeuVHS+raeamRzMjyegZzkKBs/MJXr69t42La?=
 =?us-ascii?Q?PyN8b24BCxLq1pvyoYOFsVEkFmx4kazorkdwFTZ9zrwz0Dd/YUUwT2bW97eh?=
 =?us-ascii?Q?f/fUsazcw/7672klpPmiKp4M4vh8Uwh6n6Sth6s2iO1lLJ8vQY8jW7YDDZw7?=
 =?us-ascii?Q?gnfv+dc/vlEcoZhIM5nSbkRFkuu31PBFzqiwjkfAk0HdYUmOq/HptxjXo0Gu?=
 =?us-ascii?Q?02DJk518BqZiITMv4NsIr71FjttrXV9R6eL/Y4QeYlMHF1Dl0d3gsVUjicJn?=
 =?us-ascii?Q?vEiLb9eXPzEoQcY9tQxQGP8wTWLn7RWVUzUaHt7Xo4a67OaAWj67LY4QZOYk?=
 =?us-ascii?Q?ZthYcODCQqHcsV6mNzBItAfbzd/QYUaTPbchpWYOUTrcPCRr7e3/PXI6BzQw?=
 =?us-ascii?Q?HWkebc8GUX04PCTN11k9wFV7ozmQFZFQxXjfPlmYWHBkIXsIR1GBISy1BiKM?=
 =?us-ascii?Q?+00dhoMKh856mkMl/ORubs93Z8nggZuIS7epP+9tcuesgJGNyBzVuRoiRhRp?=
 =?us-ascii?Q?ysb0IQgpFwoNqxJTTg5l9hdWClIMSe9YW6lY6gRlmQ1kTW06jkySDkKdbxdH?=
 =?us-ascii?Q?klUi1C6FkFYNGigH/y8H6s8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9e4f70-98d3-4455-9b6d-08dbb2beef52
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 12:02:13.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65vGQ/otUfjnOWQKP+S1f1EsMoHkctkp7wDGSeLBUXtG//57ZiQ45mTzc/ezk1mDYIX4sJKP+7pnc07JPO5Oe8xOrh7SLooh8T3ZDRLZ9QqpImiH37k9OU14cDPthiMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: ld.lld: error: relocation R_RISCV_LO12_I cannot be used against =
symbol
> 'riscv_cbom_block_size'; recompile with -fPIC
>
> tree:
> https://git.kernel.org/pub/scm/linux%252
> Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Cecec6b2c35b049d7fd8108dbb28c01c7%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638300086620501123%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DxoUqGHQlVoylBC9zBnMRblMOE%2Bt9rDia1H4WC=
kBkxCQ%3D&reserved=3D0 master
> head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> commit: e021ae7f5145d46ab64cb058cbffda31059f37e5 riscv: errata: Add Andes=
 alternative ports
> date:   10 days ago
> config: riscv-randconfig-r022-20230911
> (https://download.01.org/0day-
> ci%2Farchive%2F20230911%2F202309111311.8tcq3KVc-
> lkp%40intel.com%2Fconfig&data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Cecec6b2c35b049d7fd8108dbb28c01c7%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638300086620501123%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DaRG4VodlKMfr0bONuloMO1w6MfUR38dzZopDwfw=
hS%2Fg%3D&reserved=3D0)
> compiler: clang version 14.0.6
> (https://github.com/llvm/llvm-
> project.git&data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Cecec6b2c35b049d7fd8108dbb28c01c7%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638300086620501123%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Drsx5fturDhSNLJMpH0%2B4Zw81HUTCQhE4F4ozq=
FmFHic%3D&reserved=3D0
> f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-
> ci%2Farchive%2F20230911%2F202309111311.8tcq3KVc-
> lkp%40intel.com%2Freproduce&data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Cecec6b2c35b049d7fd8108dbb28c01c7%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638300086620501123%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DGqbK0Gqs5bZx%2FKH44rtc8OW81JPDXx%2BjrTM=
rPTdnF80%3D&reserved=3D0)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same
> patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore/
> | .kernel.org%2Foe-kbuild-all%2F202309111311.8tcq3KVc-lkp%40intel.com%2F
> | &data=3D05%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.com%7Cecec6b2c3=
5
> | b049d7fd8108dbb28c01c7%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63
> | 8300086620501123%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> | 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Drk6abxEzT=
c
> | XeOYIVw0WOJ8IvdTPwPC94r68eFcIihEs%3D&reserved=3D0
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against
> >> symbol 'riscv_cbom_block_size'; recompile with -fPIC
>    >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
>    >>> referenced by errata.c
>    >>>               arch/riscv/errata/andes/errata.o:(andes_errata_patch=
_func) in archive vmlinux.a
>
I did reproduce this issue locally. The andes errata is not compiled as med=
any. The config is RELOCATABLE + MEDLOW. I can see the cacheflush.o is comp=
iled with medany flag.

I can fix the build by adding a medany flag as below:
+#ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
+CFLAGS_errata.o :=3D -mcmodel=3Dmedany
#endif

But I am not sure if this is correct approach. Any pointers on this?

Cheers,
Prabhakar
