Return-Path: <linux-kernel+bounces-67174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78711856780
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC95F1F285BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE302133406;
	Thu, 15 Feb 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hp.com header.i=@hp.com header.b="QM+3t+le"
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5F42059
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010715; cv=none; b=I1ZE6OLHjGFyqJ21lrIE67XlLxgSFGI2tR9oN4puuSkAeQAJYlqH2bRJpl+blkCrcHs+6WQlvdXGFZH/506Sdueq7EwjQs8+bXSrXZ+1HYd/zcupsORSqqiix9F3vxo24txzmwW2KbYYg71vSJ2PZQPs3640MVUHgfiyLVaGJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010715; c=relaxed/simple;
	bh=zfKf6YOFPNClMz/WsPi6+JfTtXDu7Hqrion2Mc0HhnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fpgu6Kgitx9IpOkw6DHrhOo4AEDBMp/zS72Tur1S5I+mwLumByt2QemiJiLdHYU3p9ByzvdTU8DBwqNNIQmYCgAuu7Kgmq5cX6WpMb9R5uWijGe2QnJ0lEKYcauuB6CRvavOogPVey3VOENXi2qMixZ9fvl+8Akrp2L9T2wQwJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=QM+3t+le; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1708010710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9cb4Qe0LxhSaPGrTH0X2PnyMbFVlpVCd61B6q4hYKg=;
	b=QM+3t+leH8nyyiweAQfGicI0EcnHyNv9QCu+d3Q0Y9BOdfvYeaikBkEvoDSXvjUGwxuAk9
	DkBgPMJSX2iNui/Ha1048qbBcIVQsiiqvuYMC1yh2Tq5yBS/WrZGmasxMYKvT8WhXFd+Wa
	xrCE9/ixWDvBlTjaWe/iHdc101jYaQM=
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-3sYCxmiwMxKg90OaZin89A-1; Thu, 15 Feb 2024 10:25:09 -0500
X-MC-Unique: 3sYCxmiwMxKg90OaZin89A-1
Received: from DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:1be::14)
 by LV3PR84MB3528.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:218::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 15:25:05 +0000
Received: from DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9727:7112:c46a:c619]) by DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9727:7112:c46a:c619%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 15:25:05 +0000
From: "Zhang, Eniac" <eniac-xw.zhang@hp.com>
To: Takashi Iwai <tiwai@suse.de>, "Gagniuc, Alexandru"
	<alexandru.gagniuc@hp.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eniac Zhang
	<eniacz@gmail.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
Thread-Topic: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
Thread-Index: AQHaX3YE63Fkmi67ykykdCA++KhMzLELXAgAgAAq4lA=
Date: Thu, 15 Feb 2024 15:25:05 +0000
Message-ID: <DS0PR84MB341799A29B99290A1FB10F58BB4D2@DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240214184507.777349-1-alexandru.gagniuc@hp.com>
 <87v86pevt7.wl-tiwai@suse.de>
In-Reply-To: <87v86pevt7.wl-tiwai@suse.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR84MB3417:EE_|LV3PR84MB3528:EE_
x-ms-office365-filtering-correlation-id: 668e171e-9537-4421-51e1-08dc2e3a4931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: n4Q5IkXQYvSaM5UyYpWG1/ItKKAp8g9j6A/BS1NDYvpEpqe/RNp4Frdrw77b1l7UUGULPARwUoPk/Dws2mFu9RbbY6OHUENoS2vSWIECLUy4TBZfBJOJJ8N/nHXe4a6/KtOn3Nz5xMyCGWZP0KtMc43mkn3VdUxfZ+KiciT0cPrah3A9MKsoGvB8D0hy0ivifm8qtY+xlQ0SUUpXn8HKw1aFsnX5W/I5Zc1eMZw+7e9i5z1+jV1nyNw8uJb/CbmPewsgxSKuPTAIY/4x9TmQSIIegf59jFe6wR+2r4HZhXm5tGbtaj/ZGSjnyBUGhq6GT/8LaAVXUe6L8jxOcwi5od0pNhnMgNUCn3jw8l7cJgxtyrBIjJBIXLEEY8VQdlwtgeKaygdUFF5b8acMxxkNMQB4hJZAGB5ue7eJ/NxUrFM+s6lw600+KOePDCEkE2iSF6gIJo+UTCXdg6usZLgdsJwq4SxqIHxoJeMu4mMf6+zAt/q/yGp1USgfWAUmt4JizGohalPStgLTupw/3xO/YE1JlQPXrS5S9R85AHN2ZkRKBw4c3jpe0opePmfpYFbVOsfreCB3lqLGlFK5AuRxTRQ38H79OsaNQyue7ppa0vuiAPDUjAyYAUabgEfc6wPp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66476007)(4326008)(8676002)(52536014)(64756008)(66556008)(8936002)(66946007)(76116006)(66446008)(2906002)(83380400001)(26005)(38070700009)(33656002)(82960400001)(122000001)(86362001)(71200400001)(38100700002)(110136005)(6636002)(54906003)(316002)(41300700001)(7696005)(9686003)(6506007)(478600001)(53546011)(55016003)(5660300002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GtlyrLjEOIFx8DDtBzC6E14knlgfMuygGbV8d7rsfey17mJ3m2Kro/Vut0Cp?=
 =?us-ascii?Q?CC9zxbBUeJe1Oysn9nI++MI/jMimHBnBFIdVVfB/u4oyvr6FXzAEEicASC0W?=
 =?us-ascii?Q?juEh22tQlKe+EQyHcOwcmFRTJnL8xq9BRvW06qM0TM3tf57sL3yj/n8NaDKP?=
 =?us-ascii?Q?Y873kyP6iNkIFX8GHyqc2+3wTlGwNIgzNEqlNRBHs+INPIAXiZCJMl/KVkLA?=
 =?us-ascii?Q?ygmzHAeRtdZnIIqvb1XRTZJLeOWvupdjzO/xKU+O/AQiF3772BFo3jLSrTy6?=
 =?us-ascii?Q?4WAWX2XvLx8F27CAqloC6CItLKZEaw50nE8eH75jEudVD9W34mojxl3NLd5v?=
 =?us-ascii?Q?RJMGaaMOLtLZ57YgqeWOPV3HEhzt4q3iU9ig85S53c4nvl8+GkbP+wV7+9I9?=
 =?us-ascii?Q?BvxjIkU9nqbHkGfMVtaiLjlKqjeViTU4Nwf5V8udGF3NPX+ug5avPi6mhiU9?=
 =?us-ascii?Q?rTG9BrHZQ9XyN0ypUW0cRaFm38BfMTGOUCoIshNqHlCylqyieCHrYrvWiYJE?=
 =?us-ascii?Q?UOB7du2QW7wY6ZG8ZKWg33MX0/FxU3yi5nTkmbU0DZZDet5oxZPeB5Ss13jn?=
 =?us-ascii?Q?xCjkXdxBdzs4CAgR0K7/AQ27BUx9Jlf/6s6UoTjnGWMIF/p4ebAH75kVKoke?=
 =?us-ascii?Q?fw48SMZC7iZCqpW6HqELicU4rU3q4aPdtsO6yN/PSuwoQJ+CAv4k6c51ADFO?=
 =?us-ascii?Q?MN+r04MvG0Gjo9lPuxFQjICOTKofCm/neYouqT5UmGxSyv+Z6RFdmDwaIUqb?=
 =?us-ascii?Q?zLmoQ1RGD+AHUb992PyKgzmFPgUngxrpN2ZnS9qvP2nommP/1O9I2amBm4PM?=
 =?us-ascii?Q?1iLH4uBqO3+essCeW9Jcni+UYFIDuCL7s6qKkoFuMxEahKogZJC0niFvUpWI?=
 =?us-ascii?Q?KnPY6I/bjQRLLv8VlpW/S/HFPI2iM0AKC/ZffXbOt/rBM0R/NQR+6l5hzC4A?=
 =?us-ascii?Q?ChrGj9GnGBUSQD5kqB/kSjviFKswJxrn42pkDCELgTyk4sx+FfuCfKXf2u0W?=
 =?us-ascii?Q?pl5zfIxB+IpehcDR36plloZeiVUEX/svJ50cS8PhoLD7HA22+uSLEfxDmY/O?=
 =?us-ascii?Q?/3goxVgEvRXHUEDfH/lS1meiCv4m/h+H2zUR2h+znskjEcV0JnNcUT2TwdnV?=
 =?us-ascii?Q?IGKx4xZXdX0y+76Gp1xAqYIGj0rZbZzYJgEHPb93RP653hlvTrSab8DskLpR?=
 =?us-ascii?Q?Kr3NEmRxjEUB9oQ9/HWHeHv27tey51xI7f8+5EasJadTSNkOi4StXpoRY4dW?=
 =?us-ascii?Q?e0fnZ7UdwLAmZTj9I+MuFzWv0xprwWgAFMrC5Qz3XmqQihTXedNubLz6jbko?=
 =?us-ascii?Q?OJncHZS2ADV0JjDV8eg7544kMg6OohmlWqLjvgARqK2eUAI0WpOCjYtr0Lwi?=
 =?us-ascii?Q?hSjuEy14CO3TW0LTTCuHKLjrKbWNjT+lPXEa/LD/rEsS4vpyslwkbl1yqJQJ?=
 =?us-ascii?Q?Kd/NH4MZeUSRJ+dbvtol8hwvdcOOy18wzDS0O3MVqrCEYnvFyeg1dOALaoUp?=
 =?us-ascii?Q?LRj4+f1IkduYgBFJcIfQ2EhBlA6M6D+h3zoahHCjC9jfJipY8TVJDqtW3IQ0?=
 =?us-ascii?Q?dqwICOoQM3du/dyCp8gH0A1DMfYor8fB3R4T6Vsm?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 668e171e-9537-4421-51e1-08dc2e3a4931
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 15:25:05.0454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/5adw/HAqy6XFhnqDnteTNyJj+nOgCSC2Uf9uUzSjVl/Mt3PCMIToDaWtUJ5ESd/1eyQPrppbxXKj8UQt0KOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3528
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I can sign off this merge request.  Alex is ThinPro's new kernel maintainer=
  He is trying to push all those old HP patches upstream to make our life =
(and other HP machine user's life) easier.

Let me know if there's anything else I can do.

Regards/Eniac

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Thursday, February 15, 2024 5:50 AM
To: Gagniuc, Alexandru <alexandru.gagniuc@hp.com>
Cc: linux-sound@vger.kernel.org; perex@perex.cz; tiwai@suse.com; linux-kern=
el@vger.kernel.org; Zhang, Eniac <eniac-xw.zhang@hp.com>; Eniac Zhang <enia=
cz@gmail.com>; Alexandru Gagniuc <mr.nuke.me@gmail.com>; stable@vger.kernel=
org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645

CAUTION: External Email

On Wed, 14 Feb 2024 19:45:07 +0100,
Alexandru Gagniuc wrote:
>
> From: Eniac Zhang <eniacz@gmail.com>
>
> The HP mt645 G7 Thin Client uses an ALC236 codec and needs the=20
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make the mute and=20
> micmute LEDs work.
>
> There are two variants of the USB-C PD chip on this device. Each uses=20
> a different BIOS and board ID, hence the two entries.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>

Any reason to have two your sign-offs?
Also, can we get a sign-off from the original author?


thanks,

Takashi

> Cc: <stable@vger.kernel.org>
> ---
>  sound/pci/hda/patch_realtek.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c=20
> b/sound/pci/hda/patch_realtek.c index 6994c4c5073c..c837470ef5b8=20
> 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9928,6 +9928,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
>       SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXU=
P_CS35L41_SPI_2_HP_GPIO_LED),
>       SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook=
 PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>       SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9=20
> Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +     SND_PCI_QUIRK(0x103c, 0x8b0f, "HP Elite mt645 G7 Mobile Thin=20
> + Client U81", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>       SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", A=
LC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>       SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_G=
PIO_LED),
>       SND_PCI_QUIRK(0x103c, 0x8b43, "HP",=20
> ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> @@ -9935,6 +9936,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
>       SND_PCI_QUIRK(0x103c, 0x8b45, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_G=
PIO_LED),
>       SND_PCI_QUIRK(0x103c, 0x8b46, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_G=
PIO_LED),
>       SND_PCI_QUIRK(0x103c, 0x8b47, "HP",=20
> ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +     SND_PCI_QUIRK(0x103c, 0x8b59, "HP Elite mt645 G7 Mobile Thin=20
> + Client U89", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>       SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUT=
E_VREF),
>       SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUT=
E_VREF),
>       SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4",=20
> ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> --
> 2.42.0
>


