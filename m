Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51B78CBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjH2SDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbjH2SC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:02:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBC132
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVpawDiX0AORGl4gzbcOS+0E5LG7Umw+l6gD75MujOklCsoDe9Wjv5DqKmrVlpY4h3fLl2la6/Li00XaDgCd1T+j+EbnJFkroOZ4+hNptIwGw4E2QpZKByjhDFo67h6HgQgPX6oeO7KeFs6xNdKsZ+uqjXycg3bvJgzDVQDBdY8MrjAAA2Sn1VItnkTOfZjhaORcKZd++DKAg+8CujHOuvuZcV0XyRa8X757qmdZ0n0zQKl959/x2Mdql40A5W1RZuNs1CVzEdzgZncsXwQfNNx4CuwTUYdAjy0tpP7E5y870c/gql2lPdAOXF5XLvT2jouspwWBIuCa3p+iaxgyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP75Ff2VBVHUErdagOrSgu/7BXZ3U1MrFUXB+qMvgdQ=;
 b=WNpDmYYi5wDK+vhFQou3fr/RCTVL8ny+wqwm9Y/tPPOgyy4j70L83U6ZngKQaNUkvzthp545OFT8MspnsU4+Yt5yVmDdV7RdLYEi8J7evW//qR61FgsgRg81C7jYU8vsbOeQIrc5J5LuHOtKSjtVV+bOLXGigXA2lTnuPc6YVLUdyXETCimvkGAOtqo5GEqe8GnrOqUmjkNDJS0ceU1JEQyH6TigDHF+cpigHztxN+WyK2XwhPKlHXCtqjVlDxaq3lfJWwokn9ePrUfC045n/LAOoYdt3a6BgkOefCZPEDWr/U3XAkp66osuj6Jvst1ick/kNRvtRPMR1bUD0x9H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP75Ff2VBVHUErdagOrSgu/7BXZ3U1MrFUXB+qMvgdQ=;
 b=SmK5PW3rNyCqhdm2qRu/AGonH9LEIbn182jI59ubYiRLWlUeT7IgsevFdXgGNf9jKyTgywXy33nov+GX8DAQzU6N9pjwJtTLXgWluZd24h04typxCMWnWFvE4LI0dUBzpyL6dHR7wEmOWN+Kj2eMO/g9i5wbfUJ7eg0Azygc0fk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9656.jpnprd01.prod.outlook.com (2603:1096:604:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 18:02:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 18:02:51 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: ak4642: Simplify probe()
Thread-Topic: [PATCH v2] ASoC: ak4642: Simplify probe()
Thread-Index: AQHZ2dl8p/yjHeISC0K+DbA1I4R5vrABZhuAgAAr8TA=
Date:   Tue, 29 Aug 2023 18:02:51 +0000
Message-ID: <OS0PR01MB5922A08379222B0DF6D0323286E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
 <ZO4NrT36gbwc27+0@smile.fi.intel.com>
In-Reply-To: <ZO4NrT36gbwc27+0@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9656:EE_
x-ms-office365-filtering-correlation-id: 727f4960-68aa-44e6-d8e6-08dba8ba2976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvc4i+TwH8iQ6f/Tm0I5mnjMOamjbUcWpRPGwdJUne0S8uQ6Xgvyuswmxmz9JntCoaoPfYwCr4qHcUHAOseI3gxPCureP8JgJ8+v1TWGDMsepipMwzk1xhC4QsrS8ZLwQf/le4o7L0OQVFVkVkPJFJZI5m1AViUft9S1YgjS+vYApE3Vhs+X6P5EnLpJNMm2Yfdr3rRh/yujpPmGTY/oQ9IHHtUSpnPeOpbU4FS+HEV2tJ2nFRnqdDhtvEJYn9eTBRcCprkuDJ46QmJRWwB5h4ZslliLrYQX5Nm+k80hOlr8MjumlJEvgJRYeE3z3TKPB5KWG1pNlHD0BjsCluQ1n/PJCdiqVTLLexoXJyBZ4Le5GjiaI2y8kJAAmtl30I2vnym48BUNZhqfWDQ/jvrOxPZzmPDyfW4mI5eH0Miqd1ghpbZ7LhCPs93kNCzHwBNDggvX9jkB7kg/bvbMD4uCd7hCfXCZOV1K/uB+IkYNqrk/laGXKEQi/i1d2YQpGkOMEKnC+/735nkoIt1sQ30WeZ+0eNzj1EFrQnvS7vbz2v3P0NN263ylwew8hYEqf1p4gLf7nniKzEtBLL+FkU7qe8aDYIMP7/6UFdXfcJebbxYuNHhvn4hEjmRnmp1LORCV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(1800799009)(186009)(451199024)(4744005)(2906002)(55016003)(54906003)(33656002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(5660300002)(316002)(6916009)(41300700001)(4326008)(8936002)(8676002)(52536014)(71200400001)(7696005)(6506007)(9686003)(38100700002)(86362001)(38070700005)(122000001)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j7b93yReUqeNmzXGAQWipiJCH90JWcnJtbhXp7QLrJ0PzLBsUCkbUnIVM2?=
 =?iso-8859-1?Q?25IznkYVjvauZVFkRiKVjvc4fJ4LlYiAv1KnTPJ5w9zrfpYUmEiXeaGpGA?=
 =?iso-8859-1?Q?5W3JH7PLZdiQukamgFgjBGnfRfa1Qx9UWIlEThiymm+LDcrTEKFIVOS9KI?=
 =?iso-8859-1?Q?RErfWkzE15qpnleKsPc1cx9odCWY6dYvimE90yA4zwRkk0yggmQLeoBwkZ?=
 =?iso-8859-1?Q?QjRIDDbidVG/QGmJJn8FiciGthgxGj8pmhoQuoaNhYKwM/ivfxiYEe2fYt?=
 =?iso-8859-1?Q?tzELxYC4tSvnwZZpKPsxckv7sJm9TSrpq8ZFGm0f6EUvVbryhcTWlvLGAC?=
 =?iso-8859-1?Q?uLBwUDeYnnKQE6Or4vCVmY5DCCOjv5u3XZ/loNFHPlEAzMx7+C+GVJOZ3H?=
 =?iso-8859-1?Q?lHPk6EWFGAZfP2m5NyKfm13IQoT8wLCvVsKusg5whSgiKNZ+YuQ5w9E3m7?=
 =?iso-8859-1?Q?W6SCrWI9sMBrJ2mSSVZtSSAn1kRFiW7KpQypBxWwY4idIE8x+TKGdS0QDC?=
 =?iso-8859-1?Q?6iOsbOucxympHP75O58TpvjvKDPXb+upWWhRjIv+fxxCca69QXijv4igFv?=
 =?iso-8859-1?Q?QenL08ElOllbgaozUjjpDExBEhu34TIokWVMmNxRGop4V8jPIEW0LHl/gK?=
 =?iso-8859-1?Q?GkTvZgQ9z3qFXxrm0kLY4htBYlGPOcOVN3Qu6eWknqlW0FkE6+5m2jdapI?=
 =?iso-8859-1?Q?4FO3zX0ENgJvDZs3qEpZZrCIOkBR67XITwMMZttHadRb+xCV+BNR9PXl2A?=
 =?iso-8859-1?Q?zKxkBguKYXUQjTZT6e+2akE1l8Z/6JpaTJOXQ1r+1kvlUOtp15Z+tn283a?=
 =?iso-8859-1?Q?VzvWlimJjnk4zpqrgjbyqaUOoX19IkSEbKOs9WwUD/29RSU9dq2hicMlHk?=
 =?iso-8859-1?Q?CaCoAFhCo5cwC8oNolMvmeJETplioAAbuVaxKgQUg5ALM/8rxk940zebqm?=
 =?iso-8859-1?Q?rbw3IBb3ytEvZYnIMirNPlkC6mDzXQgUFLhDH71cEUxiwsNfHkp89qbSgZ?=
 =?iso-8859-1?Q?4DXS4dx+xLSaXm2h+JS983TtaZvA1g3MQstDPt37YsJ+Vm1SvGFtaXR5/a?=
 =?iso-8859-1?Q?pGOL7pfhgv/fTKsUUEAcgP0i78wNvBng/ZN4tPOninWSZxtLqL3irjB+eW?=
 =?iso-8859-1?Q?uSovalDPxDk62LKFE6HdXW6wwxUznIorUdxwOLCI06aVZDW/ORnP+QQfT7?=
 =?iso-8859-1?Q?zBBOMSkhPzp+FnvE4pKQvsastlcfyz9h/mFpSjtsN+Tr6eIt5RtDdSs9Zd?=
 =?iso-8859-1?Q?UxGHYLClrUJWQcvLf0bW4JFHo6HlBLKCSpi3kCTOjBT8HwtAx2ELoDhuo1?=
 =?iso-8859-1?Q?PoKzJn1YCm7QFhxyFfz6KcWy2D5R/OpU2BSdZpYN2pJLQfA7CTTej0T4nX?=
 =?iso-8859-1?Q?U1FKr701E2yoIFe4AW6CHyt1L6XkbIHu1mgYkwb7Vyf39EqYKRkTXJKnL9?=
 =?iso-8859-1?Q?FL9CjaEh6HIwDyd+HHbRdVVCD3aBa7WiuWTFgenLBBH7fmeMxgRq2VN1VX?=
 =?iso-8859-1?Q?A4nhuKXt6/3/4qvBg/tAyt+wW7J0WQ1WC0csBqGlZUIxYtvtCNC7YcgEif?=
 =?iso-8859-1?Q?KC4A/GgJyheOarcVXUlWba/m+fHTA7v0PWsmVViO3bMtSgV7/KONsDCWzQ?=
 =?iso-8859-1?Q?XChSGHiXTlMbGjuFDPZNZPFo9z+IQ7b78aoEDaXFR+dLVjA96fYgfftQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727f4960-68aa-44e6-d8e6-08dba8ba2976
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 18:02:51.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wV+9xEGNjNDZJYScslF9xY9y/wkRBB4e5GXv/gKE/X9Ep/MWvQzKwBOPUJACDl4iOoa9DUCwjqrngaIk7TtSpSRR01jlqLDLGoj1K88fMmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9656
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> Subject: Re: [PATCH v2] ASoC: ak4642: Simplify probe()
>=20
> On Mon, Aug 28, 2023 at 07:00:03PM +0100, Biju Das wrote:
> > Simpilfy probe() by replacing of_device_get_match_data() and id lookup
> > for retrieving match data by i2c_get_match_data() and replace
> > dev_err()->dev_err_probe().
>=20
> ...
>=20
> > -	if (np) {
> > -		const struct of_device_id *of_id;
> > -
>=20
> > +	if (dev_fwnode(dev)) {
>=20
> Why do we need this at all?
It is replacement for np.

>=20
> >  		mcko =3D ak4642_of_parse_mcko(dev);
> >  		if (IS_ERR(mcko))
> >  			mcko =3D NULL;
>=20
> This can suffice on its own, right?
>=20
> Can be done in a separate change as a precursor to this one.

Agreed.

Cheers,
Biju
>=20
> > -
> > -		of_id =3D of_match_device(ak4642_of_match, dev);
> > -		if (of_id)
> > -			drvdata =3D of_id->data;
> > -	} else {
> > -		const struct i2c_device_id *id =3D
> > -			i2c_match_id(ak4642_i2c_id, i2c);
> > -		drvdata =3D (const struct ak4642_drvdata *)id->driver_data;
> >  	}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

