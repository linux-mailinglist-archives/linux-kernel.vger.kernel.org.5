Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A144782A64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjHUNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjHUNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:22:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75CB4;
        Mon, 21 Aug 2023 06:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXQXYBJogHtpKHOiczJVMDdLpVcKGCEpuMtD5FiDj5VlGF1o+AtVQpH/lC0RralN7UcOm8GmFK5wo+ENSumCm08y6JEsaLZHrUuSkdHPpx2dGv+RdhuZWnlKYvhzjTzIfWnwxhp38bFncNpSkeTbOXWfzocgwjEMU1CZOV1BgmjRdpBqpq7TdsDA8ansu3/0hL7wgU1/ABtCHcIN5sQefmhamQUqzy1Q+guzPuvMTRpS1rnvlTIrhiqFSAX/OVyaQse22GSg38GBqzrVPBR90fS/l6ZJLBZOg8SZS16VWQlk3NLkhVahHSL+IxjTSO0fJ1VtxUZXcphmucE7UkvWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7VZmrtIa7quUdwT3nqOGU6/vLzhqylM+o+xejs/fgM=;
 b=VEV0HhBiTLCQrSDj8paQb5Rc/lGYGjc1NoKZl76+41K6OsT6wyB81tCG7uBzMveZNLyfav4656Ync4r3Ryw6YUgnqU2oEoYxZUM1q6zcRzn28TyseP3jVkjq+pthvGSSfaX6aB8mKMBO2tD095t5jraGa209BAalByw9oTVFauuLpz8edoXAo26By35znZBl7Bz92fhrEC9Y+fqIzuzbnYq2jkQaEw5orxRCCDlM4Idfg+QiEByKxVgkEE1FoUaER7iQfHbUatrEDMXS+DO05+D0hhdeHX0lrGeNSvogkqyIOenO4hbb9Pk4F7rvJm/OZUNY0xqJ+2ghDaygP72I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7VZmrtIa7quUdwT3nqOGU6/vLzhqylM+o+xejs/fgM=;
 b=U8UiSqyqDZJ9O+nTxU1df2jHLpXuP8bQnvPdJbrPO+ZXK3QkjE9yf3CTHnOnpnqxJlPgfRQYTt7ol3PWDAxd4jTYeT+eM8Ys7Mwyn8F2684bRbzydbs6eETrdY4cb51HtU1WtcO4H2hPSeedzpXZaQAzCQhNRsWrUPhQRLx1WSo=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DUZPR04MB9824.eurprd04.prod.outlook.com (2603:10a6:10:4dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 13:22:50 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 13:22:50 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ1DKVlmuct1FdqkW6dkezlQtrJw==
Date:   Mon, 21 Aug 2023 13:22:50 +0000
Message-ID: <PAXPR04MB91850D8807CE374BD7C30CC5891EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
 <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
In-Reply-To: <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DUZPR04MB9824:EE_
x-ms-office365-filtering-correlation-id: f952da94-e547-49ed-c111-08dba249b7ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52vlQqFzyHu312bbADJfVr4z7NRsXKysxqEXNhuiNQ94T0mAdyvjd1KmZsALd+rpS6uR93c+yG8AoUUe3EfJ32APjMy9cuFCWXAndSwIJSEF9i5D+vgzM4O/3kAKuj8UqWgYzt0hTdPOP6McHb1M79HlXioDwxPC+zN4trvVxu/aRUwQDLzDUvVfNmw2tYV1/145B2KSxG/58tGX1bgxcUm6lgq6QJGYQak8AbOa+MxDQa8yQrKlyZ/z+IwIysudcy6+R1cmQ8gODvsHCihxKHY4GLP0bgpp04LLQvT8J6INHEvwyrDYwh3ijdaitmvlT4gwDgiF6qCEJAhoxedVlpP9Gw6uUfL27qxI27ewU04Vjkuc4W8SvzBwlE5Urve5bfdzTSaWnejucHtO3ZdgW92MJnvzdxBJmayC54RKKi0sJxpZbJd8Ud0NmK6sl1AuRAoNAPNorI62X/Yz46yJ2xn/ZovMi0GxiLF3et3MmrusZ26gk3h/GAHoXWKUTovcv7QvXgrA5iCKjX+Br2Xrngd9JDhgnlyZsxGAjVQ/anka5nCOt846u1ud++h9voC8zxPXsUJg6ZPhQW9SaDG/A1c45q3twwF5zw+v9v2rAQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(45080400002)(53546011)(55236004)(38100700002)(38070700005)(6506007)(83380400001)(5660300002)(44832011)(52536014)(33656002)(26005)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(54906003)(66446008)(66556008)(76116006)(66476007)(110136005)(966005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZdJQfJSIuyPj2n2R+qK+WR2wdEJP2RJ2DkpRhi3XSVC1eZgOc4qJJp2fooJ?=
 =?us-ascii?Q?UqAqA3D6QMXcwNlAG72PjYe1AxkdVbLEjmPQyHOPaQtJ9gOSwwo7s4C8vfoq?=
 =?us-ascii?Q?FXV9qRw8qRQwAVNnQzs4ZjGAcM7ntFyChjLZnVU71D9OZJC3IYIZ3XiFdzna?=
 =?us-ascii?Q?bYCUsZ/2xyTwbO9Rt9xoLFCLBzfNmR9UErKklHCQe6CupMqhIWt9ZkXjhtAe?=
 =?us-ascii?Q?EdtdQomdmySEFEKM1ylyWrL1IUIAdvV0H71+DK27urTmT/kfyfQvC7udHTFk?=
 =?us-ascii?Q?e9Z58PT53aOzfh1MnZh6VFb4IDexnfbb5f/fBlRKhoTRvVCemyFhMc1Q1xsn?=
 =?us-ascii?Q?F1Qg+UwHLshysVl8Z2N40xNAvSfpYFjPHj3cegrDMbk5yj5/P7+ItMnrF1ny?=
 =?us-ascii?Q?ybFbsub//afIp23/5k6mkm/jnH+Kpv3ThlwbGBRjtMm8JWDDrT6SDTi5jZw9?=
 =?us-ascii?Q?asr8NSgXV59uxh+llD1difPhM4S4TikvFSVWuH386InsuQh3P85sTlHE2qf6?=
 =?us-ascii?Q?QmnnuBNuhOSpVEuij7KkjP87E/syaEEF0rrs0jG9rC8G+7oISVSGYH8Gi2VY?=
 =?us-ascii?Q?1zV+0J5cLT8JMkI7AdRi6pPB+Sfs6lABzs9IC0PGDbAJVrljvKjKWwWsA3k6?=
 =?us-ascii?Q?BihFzXpvLZoiP5+VpiUHHUDyDh+DeGq4o0hyLbrtSWv50ZMFE/1VL4leWjyq?=
 =?us-ascii?Q?7WxjZbxD93tsyQtr/u5ptI8xyFsMAx0pchvLv5wvRxpEyQJ9rtFoH02hbRaU?=
 =?us-ascii?Q?3yQov2RytAtwzB3LgSTdBa5BaUcby7w+CqL3SoU9H3fgCbVSut912pRLxGcD?=
 =?us-ascii?Q?2zpWA2eoX1nH3VosoIx+HcEoVskJQjtED6jh55ph8Jioe6d7cHrMPHAE5DZ0?=
 =?us-ascii?Q?P9QuVkeyWBCpvw8UNd83Ftvz3YeunBBHwnOAQNZO93rsZwTfCD8Uu+E4QJqC?=
 =?us-ascii?Q?anus2A1aHBWzNv6rPiPOiXgSYFj86XFeE7s4nvB2kPIImCyeVYoe+hp5Rpzu?=
 =?us-ascii?Q?lWYG0Whdgod98esL1h7GzuSzyG/VneYFu77AcqLavpITL7iyopnMCJLX3amC?=
 =?us-ascii?Q?6nzCj28zgQR8QH9xzrO3zvLQEe0eoVKchjcCj2lUz6Z6U7hv18Yb73F3hTki?=
 =?us-ascii?Q?D/V5GU6aI+johTWt1ibQ9LFqEvWJkQ2mqvNhA3cDKJy2cD/DtRjc3T4vdx0l?=
 =?us-ascii?Q?TWlAf6TgIcsSJQQ8VTVK7awyqJx5XlCcpbJJb6nJq7jO73BwuDBwrk6X5Mmc?=
 =?us-ascii?Q?7eQeULddz2JTD3rYj5cjEQSZ/POdqsQIAWu0c3wAMPUaDcc1rzxVIOteUQb3?=
 =?us-ascii?Q?XiYEPYzc5ljhNiJ/xYr/FijCn6AanCzrXEQygBqq3J2zYTtSqWrqdSr427y+?=
 =?us-ascii?Q?aqCw9zHl3vS0PM7JU62QMZkx10NtRGu5gbqoacYRhOEHNe5ygmDH5K9ho3qz?=
 =?us-ascii?Q?Tnm8MFN8tpss9kPJm6iOdRonwPOcNbx8fh6wHHxgN8LtXn2yDV/7w0n4gN/H?=
 =?us-ascii?Q?YqdKBmcDnsncDxBteCDEvjRvKM6+77Ny8Lw/WpLFIs/Fw8PTrvg4UUV2b8wL?=
 =?us-ascii?Q?5bRHhFb2gHxvscIBNH6GD8EhjhMLbf9MlXS5LLWv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f952da94-e547-49ed-c111-08dba249b7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 13:22:50.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scGoqU+uwSUc0LCwgTRe3ig+sUDx3YPdBwlFS7u8Ey2vj5kIiVt9dCmoItPdXDPqiIaZEcOcpR1nz/akZjD4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9824
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Saturday, August 19, 2023 3:04 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; Rob Herring
> <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Liam Girdwoo=
d
> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml =
file
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> >>
> >> This needs to answer why we need this.
> >>
> >> It looks like just an abstraction layer to make regulators look like
> >> a power domain.
> >>
> >
> > Yes, it is a wrapper that allows using regulators as a power domain.
> > This removes the need to add regulator operating code in each consumer
> > device driver. As a power domain, the regulator will be managed
> > automatically by the device driver framework and PM subsystem.
> >
> > This is very useful when a device's power is controlled by a GPIO pin,
> > which currently requires using the fixed-regulator to achieve the same
> > purpose. However, the fixed-regulator approach may have to add code in =
the
> driver in order to use it.
>
> Why do you start discussion from zero ignoring all previous history of th=
is
> patchset?
>

Thank you for providing the link. After reviewing the entire thread, I stil=
l don't understand how
to proceed. What is the conclusion regarding this commonly used use case bu=
t overlooked feature
in the upstream kernel?

Thanks,
Shenwei

> https://lore.kern/
> el.org%2Fall%2F20220609150851.23084-1-
> max.oss.09%40gmail.com%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%
> 7C2cf40d23202c430302c908dba08add2e%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C638280290493921016%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000%7C%7C%7C&sdata=3D0O%2FIytE6YbJL26je7hoxEu0ayZYs07PBjfZkBDVaC1M
> %3D&reserved=3D0
>
> Best regards,
> Krzysztof

