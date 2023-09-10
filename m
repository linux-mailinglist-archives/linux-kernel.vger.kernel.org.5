Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52924799CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbjIJHwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:52:40 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2139.outbound.protection.outlook.com [40.107.114.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3A119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 00:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG3VBGVVOV5sQIyyR18quMgjXqtIyYH78wOex8ZC3pxize2JzQ6Y7Mbp1r8LDtWjiESJQsW35c2BbbcUUh5CXsMBspNbh0W90Ij3UxSvpm+8YkqcL4Me2O6vZsWs/ywlYNsWbUzl7Q7FKWTO/XW1wIejLarfDx3W8IkEi9uEdr/zLw1fkH8YY7g7dm/jLKDS7djczuQz+I+5kbkJ+QlCP7tHqSi+j+kAq7XDlKReWbEHh2xDkIyCe+bTr5aAkDSkXZitpcVW+lRWmNPWAajBuJnD14R34uYPsnaL/+vjplHGxpCCigs3fkASI7257o35EM/qgg51avE8U1uNVB+ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUW3jzPqs2ZJOI6vd6dLqwelHVIk5gbyBwSKHe4kr4E=;
 b=Nusl9bWZUDxoJ7YmPxsY+rr23LFtCS4hDy4ySr7ycj7E3ZYgXy+8xIO2+QqiwlBH02DP5EeW6ZHW8F3FfTh79/AfLkrWfC9Hz9IC2RmGw7Ltw8J11wIhZi8S5dGEmLpYAttO4xFVDbUmfhl42jjr//TTCTZ3YY4zmXl/35hdfEsfV+dNNxNBajSpn+VHy/RqRI7V5e0RGbspuC2jJK7JwgA0tsjRSL9P8wtiCPEuHx8MdzTLRVDvYvxg0UhDc7p9187Rvn3HJTg2KDS0rtPDgkn7BfPki51rr198uNSchtGrzrd+znShHvsWM16p5iJwGuHp7zvp9Oq6D3pEvCwtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUW3jzPqs2ZJOI6vd6dLqwelHVIk5gbyBwSKHe4kr4E=;
 b=A9dEDuCEv+5RL1WMLBvrqdhb4xNYMWYBiLESmI1taT1nOWNAZEX+uEjKIxA471C2qAq5kMOkSAu81ClnfPrummWE3K7gMpug4+fFxDHfgkhig1mxHrIE5+6NpaCA6raolxw4/wjt7vXYBedkyke+pTULmXi1PIyJelOlliAsHk0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11594.jpnprd01.prod.outlook.com (2603:1096:400:374::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Sun, 10 Sep
 2023 07:52:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 07:52:29 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Shenghao Ding <shenghao-ding@ti.com>,
        "tiwai@suse.de" <tiwai@suse.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "kevin-lu@ti.com" <kevin-lu@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
        "baojun.xu@ti.com" <baojun.xu@ti.com>,
        "thomas.gfeller@q-drop.com" <thomas.gfeller@q-drop.com>,
        "peeyush@ti.com" <peeyush@ti.com>, "navada@ti.com" <navada@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gentuser@gmail.com" <gentuser@gmail.com>
Subject: RE: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and
 TIAS2781
Thread-Topic: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and
 TIAS2781
Thread-Index: AQHZ47iZwJO7TO/5+kSTHw1BiSGD2LATqquQ
Date:   Sun, 10 Sep 2023 07:52:29 +0000
Message-ID: <OS0PR01MB59222A9E3B642799B308379586F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230910072704.1359-1-shenghao-ding@ti.com>
In-Reply-To: <20230910072704.1359-1-shenghao-ding@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11594:EE_
x-ms-office365-filtering-correlation-id: 45f082e0-f86f-4b41-daeb-08dbb1d2e1b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3jkFaAb5pfSTWZTC4Zs2Zp0fMvjGmasIoaBrzwTHu3D5gQsthXA8QnYSxaM7hoSH8AN/KOrLdVT6QOVuRBCeDrdDAdc2xvSsAR+0cfbdPR1VPM+A5F0gmYc+0J7hNohWyHb9zNihsIIKtObaQuyE1tvy2GJ/p7HwZyJHzPfl7GeH00u5KnMrkTHvw874IhwsgV2ZceNZN5YLXU3EmDDOQvmcCmrtb5QbydjkiMtWbJxCzPOgE9S+hFXh1VAG/3PQxDfdBLAhanDzgN2tpPkxHD5vGQiWC5VoVnXVI04Tdt8ePOAEn4ay+owQG1P1udkZO1L7dmYUgBENDVMS2M/rCugUuqJhVyWXnNNQu6oUFcSRrtCuoPGNIjs3edF/boMhCjubV12HixVSMG/OVKjkMBWuONtlGeMZwuimA2NTcPOznRQFIF4NP/7TKj79yNi90ZXc5XXIP06Dr/f0ghMFq5HyiZ7DWCcl/vRjJ2HEYzIdfrno9CsPpbwg/GF++hrZu7ibhTiJTLUoNQVId0F86USD87/Z7B2jsdzPqX0javoVR87kGJvL4e+Te6u0WtQvy4+emAN3kj9ehGP1AirBa38tgpGe8A81XP3R7gKoiTzZoDlNH0VRkvh1NtY27er
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(6506007)(7696005)(9686003)(71200400001)(83380400001)(122000001)(86362001)(38100700002)(33656002)(38070700005)(55016003)(26005)(76116006)(66946007)(66446008)(66556008)(66476007)(64756008)(54906003)(110136005)(7416002)(316002)(41300700001)(2906002)(52536014)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9+SPRBvMD3CYswwF76jK4daUEOyJzuNYZMCtVV8ok/DwAhMV3bHEiHKqc26?=
 =?us-ascii?Q?T98GhURB5Avj5M2qSOLDuRIVaS4iHgoEAjrdKdGR04JG/X/1D+CMDqZUKren?=
 =?us-ascii?Q?8l7oriY7V/E01a9pFTsi5mk71Liz1QE/GxMv9kAOxEiYVxtJVQJP3NDP3/Xj?=
 =?us-ascii?Q?MSokth9wa53cwE3bTrDrAe9vkLRCnG9/U5FMA5wI5PjSFMVqC6gFoCvB+cKq?=
 =?us-ascii?Q?MAZ+tV75HHHGh04AZOA1MKqh1lIYVxMKowkddek2JutW8GwYRkJ68ZWcC0QH?=
 =?us-ascii?Q?N2V1KQTqH5c7clDD1HDWoAGD0ist45H2FU3tRwUf8LVMAjq/nblQJEhaWtee?=
 =?us-ascii?Q?EWrzT1XheytGelMQXYstL702l2HYS4GgHHHb61EsadtlGH2qqDFvrij+G5jF?=
 =?us-ascii?Q?4gP6gVwp8rWqIkUFwZts80prcGxxhcc0OsCZJhpVY014FHhZ869D8jpNYC61?=
 =?us-ascii?Q?oRksAObZ3a5ldoDuD2Eu6y41GIUVgHPbG0KwfgWd2wWyV5/ksotHN5gBaOQy?=
 =?us-ascii?Q?A4zlsjF/0mjMGmfmC8la8l86k6UCuppVLR95fVrXVFwQZsKWOe4PkcZcH8JI?=
 =?us-ascii?Q?Pj+JHdoJiCF0HhYGH8P6mWI0Ra1mGNLVQlOMkQBQwRWHhQgvGopNitmL58IW?=
 =?us-ascii?Q?9FxqZuohX0s/PBu5xhK+xhhBhU+qEqRHX+7VTL7M689da7tq/RL4tvU82Jrs?=
 =?us-ascii?Q?srqmsxiU31bKNz9VsYoi1RxW67cmNIstTmXgntj6wH3qopmk6H/ufItfvauR?=
 =?us-ascii?Q?vqJj+q+/QgaY6PZ2hUT2/yE30tNyOc12Y/sQJRRrO/AMp93USLIwUIZNaRJO?=
 =?us-ascii?Q?Egl6+OoDhEDHrRSVywFna8fA1G4/Vyth+Y2Phx8YG9uyy5PiFe7333GodrBD?=
 =?us-ascii?Q?LWX2uinqJrREzbem4hsvtpP3uQrHdTvwoEmCCl3i554EK0P4qniKVVtcnCEz?=
 =?us-ascii?Q?YV58wX9WkxHDV7woJnMzcbCKkhaHV0C+kipe4cv3hHWYcrrBmxVTRLD13eY3?=
 =?us-ascii?Q?Hs513NsWEV9xpmoJWtjj8OfIEYHZRM8Xm9Ro9RucNCcMJ2zbPow0LIWMiDD0?=
 =?us-ascii?Q?FCSzjpxAQ6Y4baU+k0iznlfDo1qz7ZjQp+pkMIij27ljNBIBRzCUck0MgqK4?=
 =?us-ascii?Q?PQ5deIkN9irCqVhh7ZjOKJj5ix60j1PUIznsuraHU4bjax4wzS2jjaySKVYN?=
 =?us-ascii?Q?Nkk3mfrZMpqxxhp78wJGtjytpdTgIwpOUxRM+b+rQ6VOwevi4AWZAXtS0x1A?=
 =?us-ascii?Q?VeTN1aZ0bExsMn3xD/3MtddZ7/ojeqfrhJBQVOuesh3tOKpTObT0wGwbvSBc?=
 =?us-ascii?Q?VhM8ojbroCxSG8yWfTs9lPoRTOrusaCoihtHOLdu5EBRWVDgRtCn1pn3pPSc?=
 =?us-ascii?Q?7pDJNHE/2yJrkVZQUB7GA4nXZMDapcQogCjZ4BrCURm/IUXRFy1gaoCvKm9u?=
 =?us-ascii?Q?2XyOuObpFJDY+sWvx11iHrdVgsfAZ5m++lj+w4cegVnvPC156hMSxPtGIHar?=
 =?us-ascii?Q?VPs058YQND9vG52hhnH/YR+Al1TDfkQCeJxVwBzMXycB025u+uJdki1GZtvA?=
 =?us-ascii?Q?UyZRet+ZTfPEkAD6mfQ9vXGDFYWWbV6FPlezDdpNCKEUoneXISDRPC0fMK9j?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f082e0-f86f-4b41-daeb-08dbb1d2e1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2023 07:52:29.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2P7EOWbT6yZa8xv+3cBMI2QH4QmZtGwvavCSglTQDAx92M/SebIF8NcLwtmmCqaY1FBA+aln2nrftPqLgaYdlRcYb1d13kpI9dWU+/8Pv0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11594
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao Ding,

Thanks for the patch.

> Subject: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and
> TIAS2781
>=20
> Support ACPI_ID both TXNW2781 and TIAS2781, TXNW2781 is the only one lega=
l
> ACPI ID, TIAS2781 is the widely-used ACPI ID named by our customers, so f=
ar
> it is not registered. We have discussed this with them, they requested
> TIAS2781 must be supported for the laptops already released to market,
> their new laptops will switch to TXNW2781.
>=20
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>=20
> ---
> Changes in v1:
>  - Add TXNW2781 into tas2781_acpi_hda_match and move it to the top
>  - Redefine tas2781_generic_fixup, remove hid param
>  - TIAS2781 has been used by our customers, see following dstd.dsl. We
>     have discussed this with them, they requested TIAS2781 must be
>     supported for the laptops already released to market, their new
>     laptops will switch to TXNW2781
>    Name (_HID, "TIAS2781")  // _HID: Hardware ID
>    Name (_UID, Zero)  // _UID: Unique ID
>    Method (_SUB, 0, NotSerialized)  // _SUB: Subsystem ID
>    {
>        If ((SPID =3D=3D Zero))
>        {
>           Return ("17AA3886")
>        }
>=20
>        If ((SPID =3D=3D One))
>        {
>            Return ("17AA3884")
>        }
>    }
>  - Add TXNW2781 support in comp_match_tas2781_dev_name
> ---
>  sound/pci/hda/patch_realtek.c   | 36 ++++++++++++++++++---------------
>  sound/pci/hda/tas2781_hda_i2c.c | 33 ++++++++++++++++++------------
>  2 files changed, 40 insertions(+), 29 deletions(-)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
> index b7e78bfcff..6dae58a8ef 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6770,24 +6770,35 @@ static int comp_match_cs35l41_dev_name(struct
> device *dev, void *data)
>  	return !strcmp(d + n, tmp);
>  }
>=20
> +/* TIAS2781 is the unofficial ACPI id, but widely used in current device=
s.
> + * TXNW2781 is the official ACPI id, and will be used in the new devices=
.
> + * Check TIAS2781 or TXNW2781
> + */
>  static int comp_match_tas2781_dev_name(struct device *dev,
>  	void *data)
>  {
> -	struct scodec_dev_name *p =3D data;
> +	const char c[][10] =3D { "TXNW2781", "TIAS2781" };

This you should get from match_data().
See below.

>  	const char *d =3D dev_name(dev);
> -	int n =3D strlen(p->bus);
> +	const char *bus =3D data;
> +	int n =3D strlen(bus), i;
>  	char tmp[32];
>=20
>  	/* check the bus name */
> -	if (strncmp(d, p->bus, n))
> +	if (strncmp(d, bus, n))
>  		return 0;
>  	/* skip the bus number */
>  	if (isdigit(d[n]))
>  		n++;
> -	/* the rest must be exact matching */
> -	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
>=20
> -	return !strcmp(d + n, tmp);
> +	for (i =3D 0; i < ARRAY_SIZE(c); i++) {
> +		/* the rest must be exact matching */
> +		snprintf(tmp, sizeof(tmp), "-%s:00", c[i]);
> +
> +		if (!strcmp(d + n, tmp))
> +			return 1;
> +	}
> +
> +	return 0;
>  }
>=20
>  static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, con=
st
> char *bus, @@ -6824,24 +6835,17 @@ static void cs35l41_generic_fixup(stru=
ct
> hda_codec *cdc, int action, const char  }
>=20
>  static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
> -	const char *bus, const char *hid)
> +	const char *bus)
>  {
>  	struct device *dev =3D hda_codec_dev(cdc);
>  	struct alc_spec *spec =3D cdc->spec;
> -	struct scodec_dev_name *rec;
>  	int ret;
>=20
>  	switch (action) {
>  	case HDA_FIXUP_ACT_PRE_PROBE:
> -		rec =3D devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
> -		if (!rec)
> -			return;
> -		rec->bus =3D bus;
> -		rec->hid =3D hid;
> -		rec->index =3D 0;
>  		spec->comps[0].codec =3D cdc;
>  		component_match_add(dev, &spec->match,
> -			comp_match_tas2781_dev_name, rec);
> +			comp_match_tas2781_dev_name, (void *)bus);
>  		ret =3D component_master_add_with_match(dev, &comp_master_ops,
>  			spec->match);
>  		if (ret)
> @@ -6888,7 +6892,7 @@ static void
> alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
> static void tas2781_fixup_i2c(struct hda_codec *cdc,
>  	const struct hda_fixup *fix, int action)  {
> -	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
> +	 tas2781_generic_fixup(cdc, action, "i2c");
>  }
>=20
>  /* for alc295_fixup_hp_top_speakers */
> diff --git a/sound/pci/hda/tas2781_hda_i2c.c
> b/sound/pci/hda/tas2781_hda_i2c.c index fb80280293..8493952305 100644
> --- a/sound/pci/hda/tas2781_hda_i2c.c
> +++ b/sound/pci/hda/tas2781_hda_i2c.c
> @@ -65,6 +65,16 @@ enum calib_data {
>  	CALIB_MAX
>  };
>=20
> +/* TIAS2781 is the unofficial ACPI id, but widely used in current device=
s.
> + * TXNW2781 is the official ACPI id, and will be used in the new devices=
.
> + */
> +static const struct acpi_device_id tas2781_acpi_hda_match[] =3D {
> +	{"TIAS2781", 0 },
> +	{"TXNW2781", 1 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
> +
>  static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)  =
{
>  	struct tasdevice_priv *tas_priv =3D data; @@ -644,20 +654,23 @@ static
> void tas2781_hda_remove(struct device *dev)  static int
> tas2781_hda_i2c_probe(struct i2c_client *clt)  {
>  	struct tasdevice_priv *tas_priv;
> -	const char *device_name;
> -	int ret;
> +	int ret, i;
>=20
> -	if (strstr(dev_name(&clt->dev), "TIAS2781"))
> -		device_name =3D "TIAS2781";
> -	else
> -		return -ENODEV;
> +	/* Check TIAS2781 or TXNW2781 */
> +	for (i =3D 0; i < ARRAY_SIZE(tas2781_acpi_hda_match); i++)

Why not aviding for loop as it can be retrieved directly
using i2c_get_match_data()?

Update the ACPI/ID table to use pointer to the device_name
as data in the table.

Then,

device_name =3D i2c_get_match_data(client);
if (!device_name && strstr(dev_name(&clt->dev), device_name)))
	return dev_err_probe(tas_priv->dev, -ENODEV,
	"Device not available\n");

Cheers,
Biju

> +static const struct acpi_device_id tas2781_acpi_hda_match[] =3D {
> +	{"TIAS2781", 0 },
> +	{"TXNW2781", 1 },
> +	{}
> +};


> +		if (strstr(dev_name(&clt->dev), tas2781_acpi_hda_match[i].id))
> +			break;


> +
> +	if (i =3D=3D ARRAY_SIZE(tas2781_acpi_hda_match))
> +		return dev_err_probe(tas_priv->dev, -ENODEV,
> +			"Device not available\n");
>=20
>  	tas_priv =3D tasdevice_kzalloc(clt);
>  	if (!tas_priv)
>  		return -ENOMEM;
>=20
>  	tas_priv->irq_info.irq =3D clt->irq;
> -	ret =3D tas2781_read_acpi(tas_priv, device_name);
> +	ret =3D tas2781_read_acpi(tas_priv, tas2781_acpi_hda_match[i].id);
>  	if (ret)
>  		return dev_err_probe(tas_priv->dev, ret,
>  			"Platform not supported\n");
> @@ -822,12 +835,6 @@ static const struct i2c_device_id tas2781_hda_i2c_id=
[]
> =3D {
>  	{}
>  };
>=20
> -static const struct acpi_device_id tas2781_acpi_hda_match[] =3D {
> -	{"TIAS2781", 0 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
> -
>  static struct i2c_driver tas2781_hda_i2c_driver =3D {
>  	.driver =3D {
>  		.name		=3D "tas2781-hda",
> --
> 2.34.1

