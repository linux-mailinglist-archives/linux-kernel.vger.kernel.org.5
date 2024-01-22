Return-Path: <linux-kernel+bounces-32759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B52835FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FED31C24388
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5284F3A8DD;
	Mon, 22 Jan 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxFFjgOU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368F2AE90;
	Mon, 22 Jan 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919530; cv=fail; b=RjVnyZZ8/JfMnmfJb8gA43UqbNi+5vd0amTz277avfNgAOhUGDO0QgvWi/SJaapT97t1pVdmKIcTbqRkp11YD5nJ93CBsZG8ShdiysdrvG0SuJCzfQrEDHAbnx5znbYKBxbqpqtVTcFwT+beqVGLwIy0ZQ8c151MOK0sR9YiS60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919530; c=relaxed/simple;
	bh=C0jcUvlbYSexw2p84QEP5pHujKKRytl9U+sM5BrH30k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jcx6jYReufJaF6EUnd8u2W6+gJLDNObKuV+LwEBRSYrKvxTH/QvbhpqPrrcqICheoNCv+48Le7IlJSat23vyAw35Dh67xcpmKBnEDDxVG53U5XWCNvMXXFCTRZKy6Bx1RP3k1QY3eiEcr3PJPI1xyMssNsrnztY6EP7l3hzo5K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxFFjgOU; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCbKXgdDCFyiaXh+hyJxRL7F5Rupppxo8XDHxSQx4dFQKIHD/18DBp4I9pPQ7o14IyYrI57vRB37HkVGDfgo7Zsq1WG42OGDpjSA1DRZEPKpNC5LSxJ9XKEjp9/9kyaIA+l/SVBqY5wYth+JWIwUIGROlBQ9g6St81FDLT8NVyL+PO0CKlhyGb5K9G28390waUjlPUTxNWuj+yWYRyu4/KceDYjrMlyFPiEKiOS8JwSewqMPauVvf/2/vYaGic5afg2QvklIlMkb0tUK+S8MdPr3uumIEvJGKZ5i6tJEZ/LYZ5JKVSMAkOwMX0zQIYRMMY/uoMlwIQ2+uJS8fAX8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC73+wYHjIOkN9LZwFnzu7iowRybV7KPW50bgjX7ROA=;
 b=MKQUvDrg7m6JorTin2i1IopILXQqzuwiyx+pra7eVTxJDt17dzxKgXscL/dsI1HWxzL2IHhfCSC1NY8TBC139H3oxEikLis1J7Tr6orRiMwKmFgwl5jaSEt1bfreoaP+jQs4lyWdv3P/7Mk+p3vsvBsYCROkYqnaCT7SIbdVwOghDHW4B6S/hz+DVs39RIBAM5HSWpcmLyKFcOSMhlP576O/DgEe4/e24NXulPEezgw+mPYiLhPkyf4cp4C9k8Lt1N2J9EhpeKXeFbcijqSZWaLGiaK+BfaPlbCTcU9Vs+6oEa73Ym9H+YMqRhl9GsmnoC2MnjF/IgpS4fkJaJ1bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC73+wYHjIOkN9LZwFnzu7iowRybV7KPW50bgjX7ROA=;
 b=bxFFjgOUHOvjhVCzifNogVxaOMHErFBuVuczcFIpfxYkIjJgwLyEAIgHDC/2Ykt/YJLDkNTAcWOjYnwtqI5X7rj3hTpGeAu7pMdBlzbELGYV3y7dLL+tNw+UwsOvh8AUVTwRNC9BBg3oKf+qZDnC5xNKTOGJoM0KU4UIrUwd5uM=
Received: from DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) by
 CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 10:32:01 +0000
Received: from DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::2436:a622:c7ca:cbcb]) by DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::2436:a622:c7ca:cbcb%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:32:01 +0000
From: "Sayyed, Mubin" <mubin.sayyed@amd.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "brgl@bgdev.pl" <brgl@bgdev.pl>, "Simek, Michal"
	<michal.simek@amd.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Mehta, Piyush"
	<piyush.mehta@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Thread-Topic: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Thread-Index: AQHaSsvSozYxmIi7AkmoVI8kTsLKPbDlpl8Q
Date: Mon, 22 Jan 2024 10:32:01 +0000
Message-ID:
 <DM4PR12MB59388E96AFBE5C1AD3A7C9FF9D752@DM4PR12MB5938.namprd12.prod.outlook.com>
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5938:EE_|CH2PR12MB4875:EE_
x-ms-office365-filtering-correlation-id: 23e7ea79-c137-42c5-32ab-08dc1b355eb4
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TFrhBBMnGZeHrf8xH0ToqazzC+oklNOzn9Czlw/SosxfaoT2lnETrMgvfrIaoWvqq71eRqORmw3KCkUhFrcDzMG7rLezqY3jJYcJn99zsC5tEqwYEl7jaisciLdrBU1AXL7kQx5i7N1g/3WFcfhJlHsw7vCik1k/CUMVJTONJtKB7yfGGofirL/krn0GVZ2DsWG9UZ4S4djw+/neN7davcfLeDPxNAUqejqgLjKri1sTphyTh0KkJX1ZA0IsuNZIVVHKHe6L2SX0bnDYUA3AAgQdAVf2OEZ1dJUybux2ZfLbF765rm8xuMDGAGudljbWVsgBOeJlGoDHuYE3VQkAMc9se/t5z1dy4pJLgLNHkEBIVNSVYo97eGzvx7Kff/QC4p+g9aRlen8n5FSzUy1aK6/R4/QgwCQInFPG70cITcdGDO5uqzaBF/ZXkAhUS5QzCaZswwcblW1xa5aTTDYrlaN9u44tuLIEA2Mr4ah563fMESHvmFtev6e8hVz0aWfXh/kkGRVTMjTtCzHZI/1ZswxVazfde7hkJ5IU85dsdxfmtYivZC05MPAazm6tQyw1Xe8ihyXj/tHiiEe9L6oTfnsuSv8ejuz42F4xHKMmOr2mMFYqw+Ok7OP/LE5rHbB0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5938.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(921011)(38070700009)(7696005)(6506007)(53546011)(122000001)(71200400001)(478600001)(966005)(55016003)(9686003)(316002)(8676002)(8936002)(4326008)(52536014)(38100700002)(76116006)(54906003)(110136005)(64756008)(66446008)(66946007)(6636002)(66476007)(66556008)(83380400001)(26005)(86362001)(41300700001)(33656002)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SATEIX7X+jgRdRxXOtXdYt1v67jKHnZZxJyFyBUpzny0jyAPBjJEERZQCvvo?=
 =?us-ascii?Q?JLYKTBRA0p5pED1HBzVBZlW/BAa46Y+1ho0jhDkGGDY5UPqjt0ncaGxkHUY5?=
 =?us-ascii?Q?NdcavuJRVMCHjPbWmodrVDsbH9+4hR0fzRSOIn5oL93SYZmAWqTiT/ChtDfC?=
 =?us-ascii?Q?ui6eKEk4CpKr1tuPcC4wGNz48TZoexHtOB2VOoyvRXuXlmct1yz85qV0yGxq?=
 =?us-ascii?Q?ZA3mtarOJdCRiZDpX6S11AaAjhO/fKvFjAVHjudVrPnEYq73fcAcVhhn6MIl?=
 =?us-ascii?Q?FYftv9WApNWaOu8CebrZ2NiMef1vilsYFGQgtVUF+evUhUoAz2RmG2EBYgqG?=
 =?us-ascii?Q?P4RshIIaQzx8jERNA5N0K9jlr8+86AVwsSgYhltXqsn3U/8NsDNX7GQtMoUl?=
 =?us-ascii?Q?lHiUty4ozmEyAflD6xEp5bnOLmoLRjLWd02M2FpjofHpNKs69splAWcoc8y1?=
 =?us-ascii?Q?RGObphxbMvacP2gG0A5uQQWJtY4xJXxMAUEDXtRNExyXflED6Hy+3KJ0U1eZ?=
 =?us-ascii?Q?PesdF75D6vf7MxE6fZL2ONnZf6ir5o2hGHbEeMYLqaeiREJpSzYdI57MHHzE?=
 =?us-ascii?Q?5x5GzctD0E5cJJJoX2TH5aAVk4YngwjzmOmjjn+IgK0ZcHH2H9Li5N4ruwgv?=
 =?us-ascii?Q?pKJsoA/lfwUjN+Ezy7QX0cuXGUUrxTWzM0SysAkd7njnumVlr9Twy7txs+TT?=
 =?us-ascii?Q?0z0vikP3PLpedxgY5RuPJHrkYQzZxeMi28KoPZNnqwP2chSiDTZWQnrVZvWx?=
 =?us-ascii?Q?Bku/qkJiQ4T5wYLfApt0u7Bl5jy5XHp1KbGFlVI6B2HqxEPVY38eqrDFNr0Q?=
 =?us-ascii?Q?qfmQCA898j5okPxkfe7Xvmu2VESOHF9bb+r0WNfYF5oFY3vqY5GnH2BSTeVG?=
 =?us-ascii?Q?kY/gOyxjUmc/PLeN6Kw37XCAV5rLQKBCeLjCL9CNDztyJ1Ej3jg00dZbxh/g?=
 =?us-ascii?Q?TTecOEtme9iqjK24o0P8pZkyY7U1UWYKXgl2n/OE/6CCmCYlIq1KWgUnNmbU?=
 =?us-ascii?Q?TQ3xdQaEycq9kb1AfDs670S8mIMPqNMwzXv8mCSgir2KDhd4IJ7qTqcSPBuI?=
 =?us-ascii?Q?ZqUhqZ5x7TYeXWm9cDm0/eaIQppgbf16dwVECDKEiImNBqmYlhKUiiu5yLVK?=
 =?us-ascii?Q?JCg2JHLw0IXFk3aWo9GumrN6ly8f8YE7OmgPQsdMg8RvSfFLOkPWuwvOc6LA?=
 =?us-ascii?Q?8LYsWY2130GGx/5suA9DCKhBMO2+oOd2XUhzWvGxSOAenlTAsiSPY4ByXp3h?=
 =?us-ascii?Q?URgVOKhQHlNZ7V04I6APGKP29cehoDQnpOTeW4h1GWaxyVi8bzhtRfJQb+dn?=
 =?us-ascii?Q?p4+T3HoQaG7gTTz/7ILLS8/DfLFmlqwPqwVQKB6fY1ngTfDujdb/iZxz/cCB?=
 =?us-ascii?Q?Ze5+AyXN9ipZQiU0xNbnPq3MqyVdfKdtZrTVFrOPHpaSDmSBQurTkLjAftCs?=
 =?us-ascii?Q?/DUgn8pnfJNQiwGRL8DcenxSwJHwgd0aKIqRkF0JNGgMtAVryef2GpsNddZs?=
 =?us-ascii?Q?F0I03QLXqDRP+YTR+fIKaCZ+9MYcPgCfOTV//fPORYlylwGYD0MdsOPron1Y?=
 =?us-ascii?Q?qME0+vSchA/bLsswwYg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e7ea79-c137-42c5-32ab-08dc1b355eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 10:32:01.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8EwNoiF+NF5gh9YOm7Zxt3PBMInuwetlP2ulmQamAkv83RMBrk5fF8LzoUDtfa1pA7b6Orxe4Tr8L94z7Yr+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875

> -----Original Message-----
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Sent: Friday, January 19, 2024 5:06 PM
> To: dlemoal@kernel.org; cassel@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> linus.walleij@linaro.org; brgl@bgdev.pl; Simek, Michal
> <michal.simek@amd.com>; p.zabel@pengutronix.de;
> gregkh@linuxfoundation.org; Mehta, Piyush <piyush.mehta@amd.com>;
> Sayyed, Mubin <mubin.sayyed@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>
> Cc: linux-ide@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-gpio@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-usb@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
>=20
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and Xili=
nx
> udc controller maintainership duties to Mubin and Radhey.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Mubin Sayyed <mubin.sayyed@amd.com>

Thanks,
Mubin
> ---
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml      | 3 ++-
>  .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 ++-
>  Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 3 ++-
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml         | 3 ++-
>  Documentation/devicetree/bindings/usb/microchip,usb5744.yaml   | 3 ++-
>  Documentation/devicetree/bindings/usb/xlnx,usb2.yaml           | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index b29ce598f9aa..9952e0ef7767 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Ceva AHCI SATA Controller
>=20
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  description: |
>    The Ceva SATA controller mostly conforms to the AHCI interface with so=
me
> diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-
> modepin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-
> modepin.yaml
> index b1fd632718d4..bb93baa88879 100644
> --- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-
> modepin.yaml
> +++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-
> modepin.ya
> +++ ml
> @@ -12,7 +12,8 @@ description:
>    PS_MODE). Every pin can be configured as input/output.
>=20
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.ya=
ml
> b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> index 49db66801429..1f1b42dde94d 100644
> --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Zynq UltraScale+ MPSoC and Versal reset
>=20
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  description: |
>    The Zynq UltraScale+ MPSoC and Versal has several different resets.
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> index bb373eb025a5..00f87a558c7d 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Xilinx SuperSpeed DWC3 USB SoC controller
>=20
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> index 6d4cfd943f58..445183d9d6db 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -16,8 +16,9 @@ description:
>    USB 2.0 traffic.
>=20
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
>    - Michal Simek <michal.simek@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> index 868dffe314bc..a7f75fe36665 100644
> --- a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> +++ b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Xilinx udc controller
>=20
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  properties:
>    compatible:
> --
> 2.34.1


