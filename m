Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D2D7AA99F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjIVHBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:01:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFAC192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1r7vHQ5vS1d7479KQj2nbduyU+RKLmtOda1bslu+TUJZeFEFF3qFdB85D1B+PUo6/eCa5+pZZ3quZ6Mo5+j4ayjYf45POuaP8c/hc88ti0CkevTF8rV1wDvvf9NitNR2gsn+s0doX6kzCm569kdgMDs/GX1Nk5+G3YaTMmd+E2tOdL9lMtDFb+JyPV7u9KUtHrtfKpxFFQcImoehJg7EIuj0Fpdb1IAArVUjGMf79Md/aQapVn5s74VJfrG4BkXll2Rt4Z4oN3y9+A2C9v2zzJpujk6VRMdeReUloweqJ1/lKCbH+tqSfE4PFBmqhoRqBBsp4lhz1jfYB/wzvv45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=easPd2BH1MJs+MvP6+AWGgTKKHgiHDT6pxeQTrl1z8g=;
 b=LBOF50MRN2I6Axgoo/jJx8fGcmJG7NVwROQQRLj6+uLGMGzy/WRRcu4fEpkHsWqoLmvK1tu+M8dgc31takTnGflZAZ6qSTpORVKR0joI3wIt9C4sC3KS6WzY+L28ECUB73Xn9waJ0mE4tnvoPPlqF+lcfHT0eX7CqJYss7wwAAcNNz7Y7T0idsO4gnmY29NVYS3MkRvVNMG3BPa+ju8ihhLyWEh+Ux1rNUUeChERGuoR5g9pB4KWeblVqn2rVJWk0dPpoM+PgVqq5DGFfydmW6on/e9d8DnSsUFeeEvGDFtpzvEfIkY5ri5S7iiXd6J/Gln9xZPbO5tNSMtoYC+yOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=easPd2BH1MJs+MvP6+AWGgTKKHgiHDT6pxeQTrl1z8g=;
 b=MQuJrw6DSSS6MYceKUH/5gwJDpM1/sxLAEGTBe7g/OFCAaib9mTSzsSy94Z6kipcdnuvOzYBFzwEn9HsIGuwD3gk7vV7d4kYE3+5C2GuUJOiEHreMZ7/rm6UEZrN8iItHWmOHKvWKRfXTmLhNktoh92LAUz9z/UprIHUi53GBeY=
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN7PR04MB8643.namprd04.prod.outlook.com (2603:10b6:806:2ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11; Fri, 22 Sep
 2023 07:00:52 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::cd38:f20f:5778:a25]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::cd38:f20f:5778:a25%7]) with mapi id 15.20.6838.010; Fri, 22 Sep 2023
 07:00:51 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Qilin Wen <qwen@analogixsemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Bernie Liang <bliang@analogixsemi.com>
Subject: RE: [PATCH] drm/bridge: Add 200ms delay to wait FW HPD status stable
Thread-Topic: [PATCH] drm/bridge: Add 200ms delay to wait FW HPD status stable
Thread-Index: AQHZ7GweslUWm+ZGJE2PFhwGz0oHObAlMAIAgAE7xrA=
Date:   Fri, 22 Sep 2023 07:00:51 +0000
Message-ID: <BY5PR04MB673911136780949CB9FB0362C7FFA@BY5PR04MB6739.namprd04.prod.outlook.com>
References: <20230921091435.3524869-1-xji@analogixsemi.com>
 <87leczpw2h.fsf@intel.com>
In-Reply-To: <87leczpw2h.fsf@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6739:EE_|SN7PR04MB8643:EE_
x-ms-office365-filtering-correlation-id: 282efac7-9cf4-40ba-6da7-08dbbb39a88a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNdpNHdAQ4wGQZlwaKP6m/YOBECTa9lNn+5/gqZgu9l5+g/RQU2oKcm25zmel2Frutq+EIzMFKtItCmYR6vovub8S+sgZ4t3LB2jcnfK3MArnQYVii+Q+MDkl1fEGmZSwPqo9XKJL0fmyOsvtRFi3gdOAvePxeRA+3WBfvlccHK3CbGiZhG8ls+OJwPl0QrEVBBDK/U6KjT3zhI8S0/2VreneYX1mF28IwV3o6NvjwXL6MolVqSw85URYlCtuEhi+It3uICY0twCHHaxrVvh596uh2YSWTnLKxf6KpB/fYluTLST1nGe6d5msbN/yQSckKbcSL2ILTWuD1P2gtTkR3qw6HUO2C8LnE1Oi771x/M/oPFljbW6pifCIoP8glMzSAOeWE9Y2VpUDYwjwQ/Z66IzwWfJuq1gRQOnTDLdWaLlSaKgo1gKgm/Z/DdkNOBxMrTrCrpqrjP/tuDA36qMeCi2SNjDEKExG3BYwY9Tw2InmpOyNHRkZF65/UREAIQ0UlwnoPseIh7BweRAsdg9a+mdZJEbLFyyFCwmoo07Q+W0svaBeW19+zg5yq+aZzBGsn9RGVXVkJipAkK99raR1WtBXZnTjTKauSUfCV+iiqVshHWLeaCmFLW07Y4jKcvi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199024)(1800799009)(186009)(2906002)(33656002)(83380400001)(7416002)(8936002)(4326008)(52536014)(8676002)(5660300002)(86362001)(26005)(316002)(38100700002)(38070700005)(66946007)(110136005)(9686003)(55016003)(478600001)(122000001)(53546011)(6506007)(7696005)(66446008)(107886003)(66556008)(54906003)(66476007)(64756008)(76116006)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9lyZ64n+VH7pAosZXO7CIzT63g62tsnHzDGbmZ3WA5Ih6Qv55tU6TQv2SnjR?=
 =?us-ascii?Q?N5LpQ5BU+jNkR5xjcy9Y1D6HkewBp/NH0cfP13DjfzXxT1NOXmOKURE81mDG?=
 =?us-ascii?Q?d6LZkk1N0fhJUh0yQYqCsQ5VBb0DAUJ9cBUj+VIwoum2GE9zN0LJFXoYEfaD?=
 =?us-ascii?Q?dHxkAW5MIW3qtRbfocQqjwzJ1lC4MFBGOhl8+pJBu0N2OeInUxLz0xB4O03o?=
 =?us-ascii?Q?UITXYA9l6DEFkHAeJe+YesYPuI+dmeQXWRcTKzI0gkznMHk4cmoDShPPeM8l?=
 =?us-ascii?Q?LLXtnYnBCi4y1d9d3z+flDWpN/ekaphayEpEjXTgr1tISHUpw1ehpB1H/fuS?=
 =?us-ascii?Q?FdMj5LRpwMNV5GQ0fjcNsPjd934o3fHq7bjndPzJzlk5/ZfrHw9Vi9Yko6RL?=
 =?us-ascii?Q?pddTxSKcf7pYjBXcphq8g+emPr0XySfYEVPWtb0X9+iz0vNcMmxMkGbfPuWp?=
 =?us-ascii?Q?c5aymtMOZH7OtzhecuKPacz6LSTN+9l5lxcmvTKcQ8x/UV7scI/JPSPWtwXU?=
 =?us-ascii?Q?2t4ZTaUggJonrbrAz8VFim3JqjB1J58b1C0DyNicP3egj+LYHSlY332EmD95?=
 =?us-ascii?Q?XmiczO5mF0hQ6YiaYeRKpyGyfKF/wS+U/gXpTe9gbGpXuqz+eFF7Sgr/+1dX?=
 =?us-ascii?Q?K9nbsXmbvsuRo8uPwEKAKMw6gSa7OX63NVizOh/v0OHGfbP7X+581RIlJRq9?=
 =?us-ascii?Q?Qj5uH9BiuWLRw+NGv9WGh6PnXje9XjqnoMJGvrtrJQkq2TvvqBBzoX2APjdA?=
 =?us-ascii?Q?xiM6OFBDtkitwfrgpW6nwFY2qDTVJMmH35Zxra46x8SgPVC+29xtw+sI4LsP?=
 =?us-ascii?Q?zfU6aEOBvCzHAGPsmKCVFx8OrK2yxQwX2m/ID/zw183d8A2Ql7SqtISVtHN1?=
 =?us-ascii?Q?HshN6CnuccQKWVGGPAv4AGci8dZRqaFeJ7QyfOjndwY0bADpKOHBf6el/Zdb?=
 =?us-ascii?Q?j4XaKBIEpv7EcS9G3WngqHfKFcEJ2S9sRNgXMGbQje6JgtLwmV9rtovWUX6d?=
 =?us-ascii?Q?TrUZBfwN57MZ52FomRKQJXHCTtgtThMcKMK1aLHWLFEpF0Tgj2wgHwHDrwZi?=
 =?us-ascii?Q?JlfbJUduTRENF1xmPV9UH+WuQ6hPw9Ue0YC4vP32y4NJ7HgLAc91OUez8Sd8?=
 =?us-ascii?Q?cd+3/zOVKG9sdgfC2Z+6NW7PbuDjrtpOgItDCj/YaEGCwbrKueoLA+7gN5l+?=
 =?us-ascii?Q?eL+usw+E9mqSMsuu2VWSYCfd/8hvTLPLSmDQvKlPeC23KjtKSshJAwYmc2R3?=
 =?us-ascii?Q?y/li1u1SoCBM0ygkR+udW2z3ZhBeEBS8H9+Qjk4DMtYKgzCzNiGHYFNJAoe0?=
 =?us-ascii?Q?fw9qd4v8ZRiSMlaKLbrY1zcNcnyiOrlfEGShnDoHrWTp0hhOJGXJk624x5Wd?=
 =?us-ascii?Q?KzVqBCytctU3NYYWeGjZmOs4vSLZJj1FtKYFenXFPGILzR8PkuiLD2F30JK/?=
 =?us-ascii?Q?EAbcZSzwcgVqZ0XQj1QRQQo1v63vLGW0oxbmUsvypFNu746cO5tZ5coQAs6p?=
 =?us-ascii?Q?8jJm0j1yIrY6GMeezzdqQkUQ6ul7THtVrvzi9nRuycLZugEqaYJ3D5vws4ln?=
 =?us-ascii?Q?F99r/Hsg/Zj56mEGbxtIGAplXLCB8dyLUGzbUc0L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282efac7-9cf4-40ba-6da7-08dbbb39a88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:00:51.7825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/+aDFua/kr2mzIVJQFb2fyPpaZ89p4hW2XDwnbtwPD7VgaklMOa9plAGq/Gq3Ua+tngjU3pvT8iTTFtMF/LiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8643
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani Nikula, thanks for reviewing, I'll use msleep instead,  thanks!
Xin

> -----Original Message-----
> From: Jani Nikula <jani.nikula@linux.intel.com>
> Sent: Thursday, September 21, 2023 8:09 PM
> To: Xin Ji <xji@analogixsemi.com>; Andrzej Hajda <andrzej.hajda@intel.com=
>;
> Neil Armstrong <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org=
>;
> Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman
> <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>; David Airli=
e
> <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>
> Cc: Qilin Wen <qwen@analogixsemi.com>; linux-kernel@vger.kernel.org; dri-
> devel@lists.freedesktop.org; hsinyi@chromium.org; Bernie Liang
> <bliang@analogixsemi.com>; Xin Ji <xji@analogixsemi.com>
> Subject: Re: [PATCH] drm/bridge: Add 200ms delay to wait FW HPD status st=
able
>=20
> On Thu, 21 Sep 2023, Xin Ji <xji@analogixsemi.com> wrote:
> > For the none-interrupt design(sink device is panel, polling HPD status
> > when chip power on), anx7625 FW has more than 200ms HPD de-bounce time
> > in FW, for the safety to get HPD status, driver better to wait 200ms
> > before HPD detection after OS resume back.
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 51abe42c639e..833d6d50a03d 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1464,6 +1464,9 @@ static int _anx7625_hpd_polling(struct
> anx7625_data *ctx,
> >  	if (ctx->pdata.intp_irq)
> >  		return 0;
> >
> > +	/* Delay 200ms for FW HPD de-bounce */
> > +	usleep_range(200000, 201000);
>=20
> If you need to sleep for 200 ms, maybe use msleep instead?
OK
>=20
> BR,
> Jani.
>=20
> > +
> >  	ret =3D readx_poll_timeout(anx7625_read_hpd_status_p0,
> >  				 ctx, val,
> >  				 ((val & HPD_STATUS) || (val < 0)),
>=20
> --
> Jani Nikula, Intel
