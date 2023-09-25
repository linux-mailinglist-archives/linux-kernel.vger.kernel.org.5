Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7677AD050
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjIYGiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIYGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:38:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE68CE;
        Sun, 24 Sep 2023 23:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETDVRRCJtQxjKraWDWrcBiYJqSgtCdZwvnr4GTMQgrKqXSJTjaPNbinf9L/sgUnah6B3ocpt1tqVNVzOfYUMAX2RH9v1PUC240N/x1ZrhGriZk/0uC+Wp6NFLCKmIJLERCFfJsWnALlO6VurotL3/nre6aefCfPg4xqVFgs6g2pl6B/YnLCXmz7hZVErFRe7NVQFAgFyrgNut8Y9fD5pLqrky0GNBAWcQUOveMPMjR2ZFxUhHKMYXXVziYyVUMFIgP/s6zR0i8+yxmG0Ks1Ebpop67VQIgYl4ffRvTs74x3+5x6nQVoR0Ti8DBBnrpUeT4siu6LcFLpykMkj6VSAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxRehP5s9AlODozvEokElWwzCjVZx73pg3XazPOpFMs=;
 b=BNxl9Y2FT2XkNw2nOJdsA0wp14BtzsR/udidvdDtMBiLpLrW9YBEUothk7Wg46zJMCrcv23UfQo654yWR8u4yM3JhUcwWNuTEdF7LoKaJlFcwo0WYDwYRNafmmrzJZYo6l7MxJzhn9BAylvV5BlqIkQ5yy7kXLXyaFZdXBPtEWtBJrsr8XlCc6Msb8ArXNa0P/QzHzmFaxFBF7rVvrtBdqSEAoJYjuVDRzjRo+nMHVLFhQVOBQ8SCXQpOq/ci4OUtMji3Yt/VnKHCgn2ZRrFciBIN8uc52QupNx2PJQzd+2XAbEyhvMgnTF4Vd8lbxHnzmWWc9ddp2+VJ9hL8mV4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxRehP5s9AlODozvEokElWwzCjVZx73pg3XazPOpFMs=;
 b=omX70K+WVgW2N+pUZxs+TqRu96ALgZsasfDzLLdbNynLHPUlpuwhcyuEU0RYTL8JjFrYHJL34wypn4H1t65rX4csAFX68MU9XZJlEhRL3GOLPj4P6lQVHSwlGLIFgcgcd6SF18vDkBTpWasUaTclG5/aTQGzI5jx4NbUvU9ymm4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYYPR01MB7758.jpnprd01.prod.outlook.com
 (2603:1096:400:11a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:38:08 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:38:08 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: remove boilerplate from header file
Thread-Topic: [PATCH] usb: renesas_usbhs: remove boilerplate from header file
Thread-Index: AQHZ7SB0O9yRp/PdAEWsjwzhOE8nirArGywA
Date:   Mon, 25 Sep 2023 06:38:08 +0000
Message-ID: <TYBPR01MB5341DE6A3D18959BDB9C6E08D8FCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230922064551.4663-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230922064551.4663-1-wsa+renesas@sang-engineering.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYYPR01MB7758:EE_
x-ms-office365-filtering-correlation-id: 65462129-2d43-41e5-93ec-08dbbd91fb3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4v6e0PDLDmRyjomjlj1HnUo5OjNHmb7uPmvW6dC2U340xfcoPXiajJVP6VaEFMJxisdfE5uLd9n6yyomwX/4hGQoMhpGd8uuMP4FMkzCO4fIHuEnt5k04uwZiDDB6BI+VHao5PVvGPnK9IMTc8GBERUe6hhvdk/oEG5jqgScLCbKSH+bAFBnKf8RLg+UutU3EIw+fSR9wWefTixu4iehW1UFez+0/z161U3BRtsH9uZ442l0joNDpnE3s3F9c4WIj530yNZcMMf4Mry+mVAPjplzh5BbCN0428rg4mxDNQmM0jxgtiImQa7DJTevk/7b2sEoOBeptpNnzfc5/AJyrRMyJj2m7jJuMn4VR2HZVso+segUkbJTpKlFDyRuairovd4MKWuJdvpZ2lRUYMFoveg+F+S/Kij/Ty85RzPsiLsZZcfPJ4nfvhPcjsBZHW/QWyApDQVcuGeBA4GPyyLdGusOVvc71365WFQXMtGCNRc6HgrMbN5u6+FSOCX8UZpPeGVnfz5PDvJyu+eZSlp/gIXa5PNaKUVwI9M/5PUFJCv5dTI/owtosma9XcSQZr/6QHV/GHNoPI1nRNyiJZBE/tnLJ1bedJWVO3cThp3uIRA1/fmAT7Fs2Nf+TmI+IeopjPyxiySsr282KRnDvUY3dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(478600001)(41300700001)(9686003)(7696005)(122000001)(38070700005)(38100700002)(316002)(52536014)(83380400001)(5660300002)(66946007)(66476007)(66556008)(76116006)(71200400001)(6506007)(110136005)(64756008)(66446008)(54906003)(8676002)(8936002)(4326008)(2906002)(55016003)(86362001)(33656002)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rfI4HSEEaGe+QIYFUwLoo7yJbtRtg4HmA62A1e6yd9dKQ2OXPUqprJKDiggW?=
 =?us-ascii?Q?/FlIQiaEXfccZ2EEmwLdE84qgCPk7TPCMNtgsHlZhq49GMcqr1EZ2lL90YFe?=
 =?us-ascii?Q?nPfAA4tm3GeLojnMQNaiMMtH+1BDP0mhRaTTgfwIYrOWNzJPcR4/HUJ2XxLz?=
 =?us-ascii?Q?Ra94GeC2EBXVeY7dJuAU3Wh5FlfvSztEqbL1q0KudAKrf4c6pvlxaHjdywig?=
 =?us-ascii?Q?3DlsQ3j5ZM+8/EyYUUNZQbU5DMfE5g+Vd2n3CRC84jvwpHkkhWm7x19AUMsU?=
 =?us-ascii?Q?4sXP45pdrqKZ9Rl+/e96mOeOU8JAStIxcYV+0yqvBi2nL4VQmpPUR75BePru?=
 =?us-ascii?Q?i2ha4r1nqr+Ifu6/64Fqn/bD2OlE3rE881U7p8R1U2glTe4nDRImaWOfE1f+?=
 =?us-ascii?Q?UPgvdYNIEd3Xhzub1ZogNoW8S/AlLbquuruZJgkF6pkt/yclwa+JZok9geUl?=
 =?us-ascii?Q?1QT+z5H9Uc5pC+CclmN2JQoMGyIRlCLLqoNBkpY6ypPvv+wZxnh0VjoXXDs1?=
 =?us-ascii?Q?r6ni8a1ofq6sB4WkVBwr+f8/q7B9PkOf6AbsJyG0N7SEMT4TSSFtqKnsyAHA?=
 =?us-ascii?Q?EH0okcyUtgbW4/WUrzKN4t2qf2WkGMOG/1Sk2KI8SDq/OPVxSN3CdL1tP/2O?=
 =?us-ascii?Q?BTpZhHVmX6bbkKgqyUWM2mPBhquzbKTfTW3Tefjf5jyugDSuIOOD7cvbKNNe?=
 =?us-ascii?Q?cvx9Q6sYseMjQKIBPEMEke09GflfsgtefYm3ejKZARM/c+qz9KEruDnVO/KC?=
 =?us-ascii?Q?pWF0jem0hHcPOsqm8ZZhiWF1NLrUXJ2FJxBJ3cKg9KnFgRxdQccAdhS2EoD6?=
 =?us-ascii?Q?Kb6v+Ng5vSbg5cnpUvFaFCHjQLnIAlwXzzXtCvomx7qtDbwsD3qJRcmXY5SH?=
 =?us-ascii?Q?LbXFEAkrbErxuee5kGRGdkz6P3jDswMFq+GOFGyAuN6a3Jl5l4rmCoTsbVUQ?=
 =?us-ascii?Q?BtiLivfNiQQ7h+nZZWJj+12V1lmvpdK5jTOOq5enYhDqwPbUNzNBJauf6PjO?=
 =?us-ascii?Q?m3cou65X1VG/ghsqeKfVWhLIhGnu3WAY4aailE+1Mc7gXtVVjEvwqomdArQr?=
 =?us-ascii?Q?HY7TVcn0XOd4/B1wM4OMjM6DuxIn3l3QrMgWfp7bB6kKFX1zk25uQ5zR9mGO?=
 =?us-ascii?Q?mLD1xF/YupxrstGbYsqkXyhPanurYWdAbL0+7odF3kTXfvu0fvAjBDHRxzR/?=
 =?us-ascii?Q?x37I0oZ9iwgZzTR8rBQlyIztYnkDYqK6XgXlkCBLH6yKSDJtDjUOUXufz5iR?=
 =?us-ascii?Q?tl3GpzHtn0SdUBNqb+TpMf9Z195PMVoIuffBNI5LGipouvShJSviiMnYa73H?=
 =?us-ascii?Q?3HX10/HRiBsMndVzaqxFpYGAjBWvOBAxgthrDwSInmRO41ku/a3Ny0HWfaME?=
 =?us-ascii?Q?d4cL4X2gjP508M7MFw2Klrfmu1pAFsfH7Rkg/aApaZvCMWkQLujt/T/vUlU9?=
 =?us-ascii?Q?9MFUzGMkpLjLamTtKxOupQ6cjMAer6F6absxwrBP2cTD/5znZZiUNGTP+iJK?=
 =?us-ascii?Q?RedaP4Qn2K8pkJO1PqFD3VSYvO0BSPVkbtONK0jD/Q0IncGkqlR5vA/hyZoT?=
 =?us-ascii?Q?KLwYWtt1lb3uYBzNQx5tDrP+TUBhb5QdOuQX/avqX/5haMEdr45YEVEeESHn?=
 =?us-ascii?Q?qqCPtJI3ZTiTGVbSVYktkawsa7Vmzw0DNPoBXBvid4F1sHpgI4sSbEW9r19O?=
 =?us-ascii?Q?UTXaKg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65462129-2d43-41e5-93ec-08dbbd91fb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:38:08.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2B/sg2MPajVvKEF5QgdT8QcMy5t05JZA1kgVtsdXYO6ubvvj4e7D6dJcBA0TBFu1USh3ep8URKonRRtuJxgm/+Dod9uMy46uh84s8ebAbQu4o7Fa59S5RO1XqFMRIDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wolfram-san,

> From: Wolfram Sang, Sent: Friday, September 22, 2023 3:46 PM
>=20
> There is a SPDX entry, so we can remove the boilerplate.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  include/linux/usb/renesas_usbhs.h | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesa=
s_usbhs.h
> index d418c55523a7..372898d9eeb0 100644
> --- a/include/linux/usb/renesas_usbhs.h
> +++ b/include/linux/usb/renesas_usbhs.h
> @@ -5,16 +5,6 @@
>   * Copyright (C) 2011 Renesas Solutions Corp.
>   * Copyright (C) 2019 Renesas Electronics Corporation
>   * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301=
  USA
> - *
>   */
>  #ifndef RENESAS_USB_H
>  #define RENESAS_USB_H
> --
> 2.35.1

