Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD19757138
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGRBGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGRBGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:06:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F69B5;
        Mon, 17 Jul 2023 18:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6kHCF+ZeaafqnK+j6nfepA0XO7RHhbpsTpLwU70uVgsD6S8HQjWoJ6/jpqIpDbVTFjm7l/AB7d1A+9ey4URvv0kkUWmHHooiesQ6Rp52Sn4OgbH+tDa6OyteIM7qemxBN8cPS4kmYhbg8EC/+VMPSzzzck1jW8VmqDSUUz6W+ztg3pposSWqGjGYliZVY1Cz2lGkWgzMo/W6qF+5GREPssaczBYdh/bKujj2D2y+6Ecn5VQBynX3oYHnftUDHAOoNRc6LaHBnJlBqgo0N5qJfoiXcGaFA7ccNTX6zGAJEfPgncfmKVFwqMKtf1OkSJmR+30SVpO57C3qie93s016Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDqF/MeCExOSVRMk5f8sRZoxWIMWfMu0y9A4+Ftei80=;
 b=LHidXv9mm1NIN1RoxlWGCdNGURTWaZpbBEmoLihYIaXGxkM7Iq34XHQS9ThNTZqxtbFPIsJiXo1aSjIpWMjSU0jA2oNeu1Ua/ppjc0fJFfsDS2wND4cineQWMyQ6ljqSvdUKyFMFImX4Me7CuUt8JnWoJro85hJp92Itvhx7j90ZG0VEcBSZVEaYybAPPd8Bz1fWFIUTauxhRETYKLzHmeo1Q1NwQJOoWAaMcUAC+tqfxiWMWtkhB7gk7yuWhbMzciuT7S91Mfv9uefIlCVqsM1untdFg2VwFWbs8bK8idLidAyLya/UPFZ6auDDDNepT3tNFa7amIPapJ93uUS7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDqF/MeCExOSVRMk5f8sRZoxWIMWfMu0y9A4+Ftei80=;
 b=cE3qzQKG+9CTyJPGsYqAAbS74tPEK8ZWRK3q9M8+5bNxJswj4Rw9ib/71JWzQzqM5EqL2ATliLaTn42KPJyrqdAdMigOfKaTDcQ1Gvmwum34E2TJ5EtdVaVK5oa+cM5npC0bq3+3GlfvaiSdXn9050uZ2WVNCuCpSAs/e8nfu/E=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB9360.jpnprd01.prod.outlook.com
 (2603:1096:604:1d5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 01:06:36 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 01:06:36 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ufs: Explicitly include correct DT includes
Thread-Topic: [PATCH] ufs: Explicitly include correct DT includes
Thread-Index: AQHZtnu0BF8S1Q5yGkOLZV4P7Kxbba++uXGA
Date:   Tue, 18 Jul 2023 01:06:36 +0000
Message-ID: <TYBPR01MB534108F7223FA2CA5BC70E73D838A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230714175018.4064957-1-robh@kernel.org>
In-Reply-To: <20230714175018.4064957-1-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB9360:EE_
x-ms-office365-filtering-correlation-id: b02095e1-14f0-4923-7384-08db872b3c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYTwG/+Cph/B6MjDepMNWzLGAtmlWpgIqrHsZKlMGrH7Qg49u9ko+Z4SqO6jJAIFsD+Dy/olkKIsn6JMkGJZL1PbndDO3NPZLRDz7ZUMuD/DOGb/QY4YJ6RuGttnw6V4zlTn11byGMwevmYYwpw9XJGVgr5jChc1hhpAlQ57ITBfeheJIF6EMMbiACWusY2XosuCDbBqr3Seq4HJZln0wc6pJ3sLEnvcv0okSFzFBjEHgv3rGqxSA2AGoJkwyOJtJi61tZFE/7S2Bw2ViaYEQy/LF/Fsy0fPWV1c/E4ezsGpmoh9A99ojbqd+9eYIsJyZyc3gEMIVIySO3jn6EPNRCKBnWqWkFTQ71FLtBH4k7gMuYpEA3Vb6fIYq7LvzybL6QSmk/Z0uJ4AAynzGBGFo3L7I9UtwhTLdaiwDCZLWd2lhXjSGESH87nmZPAKH4KwOZ4rdIPqsh0Fst0tgHdRCdo3gMRbdU/ZkmG8fhJoGxcYA7HN7n0TiEcOdU0Yf67krCsi7Bz+TD22FJoTuNUoysCEWzARiNizsmt72ivvlPOjul26u7u3BMbUc5kYUDhLlgMZHG1QT60pNyy6ya1S3cO7GSzlc5pPUjwqaO2y4FqZjw+VKpLziatIQNn3aicN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(2906002)(110136005)(54906003)(478600001)(7696005)(71200400001)(8676002)(4326008)(7416002)(41300700001)(316002)(66476007)(64756008)(66556008)(8936002)(66946007)(76116006)(66446008)(83380400001)(38100700002)(55016003)(122000001)(9686003)(5660300002)(52536014)(33656002)(38070700005)(86362001)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y3VCAAkwPMiOQaQU8vgvweKnmHamhFb4+YkFc9WTr1kqD0k65kFBgb5pd7Bp?=
 =?us-ascii?Q?/06uywyE7LjXaCKL0jOiwFLomN8q998ndG6zduKoxDAh/sj579SI4Oorh5BI?=
 =?us-ascii?Q?My0YrhTRUVt5e7UdKMOmAjho75DECLJY0AIKlFU2YCFMyZKdQCT570Yczt2B?=
 =?us-ascii?Q?LFkD0LOzRM0Ag4zYERsUJLiwDLTNYxoHoaKffVaG1G0rXubm5TWz630Q70Sk?=
 =?us-ascii?Q?3HbRkzmcfcvLq6H7/2trylSg47p9427Au77/T6baKoZrCh3x8VxmVlw9w0ji?=
 =?us-ascii?Q?CPJUgibDoLaM/wYDG5qs60GfwJ7bZoBljXNKjVJoob5T0WRcjrzsdh1MbgBe?=
 =?us-ascii?Q?B6xeN88av8bSKYz2YrJIrHZxoBVKvHYouSDT++yXgizYWfwawUNGbg9Qjx95?=
 =?us-ascii?Q?V52roj2NOFPO84xHgUxr3Twrg/05O+ZM5nfidkioS8gmxqOyJtjoEfH8pWxb?=
 =?us-ascii?Q?CzPh0NdZddtM+6WSasunoA1+S4z5Sd54C/w8aWARzcs5NsIV9qLKV+iwUg3c?=
 =?us-ascii?Q?9e+hSY21yyp7PDD+Wo6dYuVVLq8ewxOfKL3n5ZObGwH0ovuDp1DwQOoGOpC+?=
 =?us-ascii?Q?63hlksxMTHcBrznpk5FzcNmT8ccPqzrJQSpJP9EPfMqUWdYKvC6lduFDI0AG?=
 =?us-ascii?Q?WnFtjXJuH2rfGdEgZ3Thm2G3ftWneHAuUcAnsvXE0mtLdBq/Z9vGLIz3tHA2?=
 =?us-ascii?Q?rqwKAjgKFhcTHDAB6TO+oQ2nQPmsB16pW1wCx4uDInEnyG9ewz+0Z7EnMHx3?=
 =?us-ascii?Q?Owur2jPE+o5SS3ZcbWYOHYUO5j0eVcLOGtNYzK4Qvhonx4EZzZ8CvF+/6YhI?=
 =?us-ascii?Q?bUCvB501kY/y8AvaAnqpakbaIajGxfBtmDxaHfpMlCJHd30G/t0vZQD7NjGz?=
 =?us-ascii?Q?rmNbj9HTS6KOqYzj7VEoecLHlxxo3YxrFe7aL4x36OhYtGXxv/wZJPj/RsU6?=
 =?us-ascii?Q?jEsddqgdW9ZNxE2GSa2Dj3pwFkdBlOlpsTv6eGyej9JPTIEMxiL0jrP+48bP?=
 =?us-ascii?Q?um71S6gYr+bc/mfpwwAX9oth53qkA79jndvjhwEDLfYcQ+/A1xHsVgIJbgju?=
 =?us-ascii?Q?GRuhXYl4ykNb7k87a/GiPOqzCK7BmgikzPybSgFHg+Qyt+J/Upj/zHLyBbnW?=
 =?us-ascii?Q?Zg2oaaTOPBYJe3xuy/au06LIhFc65hyjL7/Lqyq/t2mWdODE6VEZLYjAV90e?=
 =?us-ascii?Q?16NKj5sm9t2HSAC8jWkQEf0B9jMX0hEaIg9sHAQy4+MvtxUtPMRDQO7JxF7H?=
 =?us-ascii?Q?2YZ706st3np6zX17HDXHqC6x/EX5zO2nyEembPdmbBNdgNJq/Cm8rEmA6ZtX?=
 =?us-ascii?Q?weUIfEMgvqiSH6TWchezpNRD8xGJv0hLhX3+3CLh12XMB52c45tsj1W521fA?=
 =?us-ascii?Q?MzbHInkudAEk8R1qL31Wi5C86NnF7ox6lBtR/UX6iZ+AbsXg6ocXTOTiBfSE?=
 =?us-ascii?Q?Qngk2IUmB2A09CLEy/fQesFqtsz/FStfIGpyWQXgM3oOYMvMUsRn96/tdS7s?=
 =?us-ascii?Q?1wYjDGJFGam0uNqcd/atgci2nYMLJp0o+DskQZB5GmtXo2UfpNxaFCB2/GpO?=
 =?us-ascii?Q?p2ABvCHSZFTDdrcwsYqYkITY75IOT7WP2t7S8aI0rlnaMj5qWfU8nipUCZx0?=
 =?us-ascii?Q?Su83VQonFloyBhu7lTsGv5yxuddcvqy+FpNCj5aGDM1aUg8RJtWLifSIpMco?=
 =?us-ascii?Q?S8acNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02095e1-14f0-4923-7384-08db872b3c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:06:36.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYYBnSUXdOrwxAZ15SkUFrAT925gVlxeqXNhCudOKcBqtGKbIC5Z81Ygkm5eZznqpoqhSax2ChQ06LMZKljN6YB4nGrzwF00y4tAHjXVhLOvuAe3UxVLK/udtFk8Q4By
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> From: Rob Herring, Sent: Saturday, July 15, 2023 2:50 AM
>=20
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
...
>  drivers/ufs/host/ufs-renesas.c  | 2 +-

Thank you for the patch! About this renesas related file:

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-media=
tek.c
> index e68b05976f9e..aceb3747f7b8 100644
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_qos.h>
> diff --git a/drivers/ufs/host/ufs-renesas.c b/drivers/ufs/host/ufs-renesa=
s.c
> index f8a5e79ed3b4..49f7bafc7d55 100644
> --- a/drivers/ufs/host/ufs-renesas.c
> +++ b/drivers/ufs/host/ufs-renesas.c
> @@ -12,7 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <ufs/ufshcd.h>
>=20
> --
> 2.40.1

