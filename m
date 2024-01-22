Return-Path: <linux-kernel+bounces-32323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD19835A24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7881F228E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4A4C9D;
	Mon, 22 Jan 2024 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tVWcpxZn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676E4A32;
	Mon, 22 Jan 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705899258; cv=fail; b=QuPEyobrVxNQs+q71g+HGe6WCfw7eD8fuGke8od/XlFoLV4JEwJWF+3hfJC3IlQSvjUXMBgczatKLOaC5Px+5Q2VIs5A82truUCdWc5FXd6AQFAREAgDSKN1zSrlN4LlEJ1yaG6gqOjLFJSG0t5I6XUKPwItsqUi/cek10zIeHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705899258; c=relaxed/simple;
	bh=9FdOws/LbObpmn6GafFjzc1gzEJPNWYVZcQWXNfEZyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4vbSAUFoGEScaLENlboET6G+vBXRH16/18FuY5NvEIesSRtgXVDxUBjEohIGgEFpnN4rawr5RPnwLoLWXdYFsIPpWMWMVYHmqcFGzE3PSEmXJ9EhwCFMIpS2CeYjAyrP55jRi5rKDVmnZkAZbJggAcGLYDuj16+x/gXISHrgmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tVWcpxZn; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7SHZbG3ZgdddO12hdal6VrHxq7cvav+zStWAyE7uGX5WgYeqavYNR+qrwuidZ8CuqYYV7wm9/aBA3SCJDMlKgHdGUhM1o5JL+5DNC3DbOTsu8xguY+geSg/mHcfnbTY9yevRrjYNmVsOs3zZ0c/fVtd//aPwUIkvTHuYllJ4K7BiY8I78/JIHWnn3S4GieVMT5mwk0crOlqSw7CLGCzcsvsNPi3WZrBwbijiHlIL/EkNGVt+rVdlYruLOyO0NcSmDuSN2/qGiT6zAURXFT2FMENvDHKrrp4wg8ekqBTyGo3ndMsjtX8IfxveIFovTgIBH65tPrWq3jppvGbbg7DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QxcTLxSJkfLPHPszdtKAxpBW7LaE0zLZKeRdfs1ro8=;
 b=YJf5czgknL2eZdaUtTQVwU3hdbd+SPOL15rUv3yoYzEmLwGSVcbS8/ETnYL+6CA1j6fFcByNL6yB/k6aP+1Km0TdpxAj3XSLusir4UraAW3vZXT1G8tt497fgrSaNknvoUgos4VZ86vwQ/XeILlSN9DwLGTJSD/0+yMaz0d8ZmUZ7IJSFv2yQfCoDb6LpCe5Rqhvqpuutv7bjrFWuhULHNpWvU/VFAtlSSCAYMBZdkX6MareFr38SBaYu8VAZz+HMsV+Ysb5IPUqllJXVEb/Op6uaQp/T6mQia4HE1DIFQhrEM7IowcX3/FM+bXJWGJlBgJ03fxhf3lWDBw972199Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QxcTLxSJkfLPHPszdtKAxpBW7LaE0zLZKeRdfs1ro8=;
 b=tVWcpxZn1XqpvyhjAltXCpYwSVF8OESjqkaOCl4XdBoKUe6E2LiY0YzUTPUeVgn7BDQ4E2dVETVO+M/ecJZfpxttstKvQDA76s3YZV86rNOME89iaXa6B5TGVn8R36feaqyPnOIfgDESS0q+LXCWOuqCyh24k/GsgyRVT6p/Kw8=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 04:54:12 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::affa:d167:8c9f:76d1]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::affa:d167:8c9f:76d1%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 04:54:12 +0000
From: "Mehta, Piyush" <piyush.mehta@amd.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "brgl@bgdev.pl" <brgl@bgdev.pl>, "Simek, Michal"
	<michal.simek@amd.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Sayyed, Mubin"
	<mubin.sayyed@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Thread-Topic: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Thread-Index: AQHaSsvSSnpmMxSc+EyR1P4Gwr3GubDlR8IA
Date: Mon, 22 Jan 2024 04:54:12 +0000
Message-ID:
 <MN2PR12MB43338F6C15D6952B01A3265488752@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|CY5PR12MB6647:EE_
x-ms-office365-filtering-correlation-id: 05d0cada-720c-4226-f3b4-08dc1b062d26
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n/4OLth2PsuOAFMat+HHCAF6nAVRKkshbzYPwfv54dJbFtbhkn70vLNJaT/QzJ5x5yEACLjVp+QCEfMleVUSJAjVNsiaEmY3+Mwcfwbr/9bfrb4ieyiSN/damSenTVYzMwXqByaEPpHTsohoaWWFgaUd05EUGLO/UUD1OGd7xQv7257TDLf8uKvoUVfbKCSGkQUs0rvaM2h/TfWkt4n5Lby8B9/0e6KEDutQGhUCmd9uoHyczHIvtn4fTvWyqvDif4ZiUps8BBdfY5ImrJSR/A0S5p0xaWOaBN5AMU+qPyAZ81rTagSVRY8YBsHwTefkWN6Ksyqzcvd3tqWnsCBgGKfZWknTsemARuZprvVsZdrX5N40RjRI0fC+JeefIYG1DPwJtolORWAhOqjs+Oe1bmasjG3UxI2VHKNgxjozvnahjHQex2VDqlKyPPLaDsNMY9hfebgyfxeVCZipyDDdD2TZXkEUQ4e+fPJmPyc78s46jM6x/cMr0721MfeFdTPef4xIlmc63DayX+7H39UvIs1aDK9+nMbpqgaSzsUI0688tjg+P4rfUHjFM3wA1kOHDfr34hEob6RCvAIIhqIRMJqijQKAXxhkalkTnzkIOQ3KyMQ6n6lwWlr8r8cphHZ/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(26005)(921011)(55016003)(38070700009)(6506007)(9686003)(7696005)(53546011)(71200400001)(83380400001)(478600001)(38100700002)(122000001)(966005)(8676002)(110136005)(33656002)(2906002)(54906003)(64756008)(66446008)(66476007)(6636002)(76116006)(66556008)(66946007)(316002)(86362001)(5660300002)(7416002)(4326008)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IiU7f/Ne4DJmip8mke2QxBrRaHBjIN6sjITRSwgKf+urcCf91O8wZL4vOL/0?=
 =?us-ascii?Q?c2QE1tk+4eUmjel7G6DcVcL+AtJw+ZaTNUwrH4l3Bi/ZbgCSf5TBdrdX3Nz7?=
 =?us-ascii?Q?+mgSJfrEr2tiCuIzYNyQQlZruA0bUaVN+uJ2PbOTbhyxTNtbKXRGsyNeADVL?=
 =?us-ascii?Q?ovsLd7sCpdUgdtTMHbmGBfYVHAtihY3cgq6UunxBapy6hkoK60fNgXX2MdSz?=
 =?us-ascii?Q?feORw1bIW8lmorDybqjLrJJ0IjH/8eJz1dLCkJmGh/khjvSJMifp+HslkA8R?=
 =?us-ascii?Q?mBKBKKXBjGn2YaAhQZZu6DnunB4j+mQbro2z3ohLl2RzkZyyAjbVTQr9xnP/?=
 =?us-ascii?Q?HXPunEONK3XGOxK52oDrObF2FRQK1eAc1HPt19xDZ7VXdm82x5ERrGCZKfnX?=
 =?us-ascii?Q?dND8mt6RlQ/qdpJq2xwsMpqD3meY0XSc90ryDb1FaztObCJORPyyRCXwQ0xJ?=
 =?us-ascii?Q?79uOHT045cyha0IzEen/vATmFeGzD8Zl7xNw7tKtN5XOdKHVG56HKNo4IMKg?=
 =?us-ascii?Q?8AjwCan5GqYI2FI2iumADJazLhX9c1InpTcHGVKNa8cYaS11S/rBoN6b1Jo0?=
 =?us-ascii?Q?YTsC/Vbr2AKfepDCS/kDSznUmXxlF88Wff9JIuMNcq5FWe5Kcz768x1UbhPA?=
 =?us-ascii?Q?R6Lq/oB8LWGv0cwq5u9RZ9D1qJ43YQY72A9GExb1kJ6wEKSl67QHBUdvHWgM?=
 =?us-ascii?Q?FBL6bxQX9pdi3f9IpkBp7Hy522yiIpdqOts4ZFnUZv7FXsS87dtIEGTfjTAc?=
 =?us-ascii?Q?Ibm/wpVuYNqKDo2ncgfUnmJa51XySv/Lk69Iy7J3PojeXtRJqlClNvUda+nQ?=
 =?us-ascii?Q?icMW/TsH8xZ4UGG9Lx7XsyweOElh/wctmt/5+zLpyB6FP+fw1Ykel7IVp172?=
 =?us-ascii?Q?yBKubR7Yi0poZ/5+rEJnHeL1SJ75cUfZjVCzdcbo3JNGIjfcBhKSTxQzERwF?=
 =?us-ascii?Q?BxExWgXQqyCGGIN4s6w4SkhqVhR+RNGSKbZall0lup37Ggd2XNdGuaKd8ePl?=
 =?us-ascii?Q?n6JLqaZUJS+vDFQd8V534PmBGVCYPC2AzKrYcYP7n+MY/mmh8UxAw2ZX3HcG?=
 =?us-ascii?Q?AoE0UdxrLb054Nu58Uvx+8fAdli0iQ/8S78rpSBluDklkD9Iie9Co+16m1Qn?=
 =?us-ascii?Q?fyCsmW2gmxXLBpul4yCB87CwytsB9+3XvZcC3dvOhL8CAxQlyqehB9wH+Yfu?=
 =?us-ascii?Q?i2u2i4CCgvG1kTEQpWVHB0sMv9A5LdNe/a98Kj50hCfQ43UUC485ASKP8n+z?=
 =?us-ascii?Q?yzVBSM/oMLCMbCvaddcMpeMRBsGk8/d+R/wHvSP4+HPAm1oRZAb7eiTsqdx7?=
 =?us-ascii?Q?Khr8a4m0TYKqTWEZQvECvi503eV/6JPTOrHBKj0uj/iLpV26uYLIY5GEo8Px?=
 =?us-ascii?Q?nEd7CYhqS9HNgmE7M910C6ILoxE72E88npyq1DOqV3jvU1LPNSrtXCyu3EM3?=
 =?us-ascii?Q?M0ZJ9baiBC6cHcCob/sKfj1rWZY0nzVupawJsFJTafbAs5hgDGa+fN1Uv0fj?=
 =?us-ascii?Q?4ksHquklc050Np/5ceKgqg1T4iEOO741PQmhasG2+9oo+mrF7yuGvdF+C/y5?=
 =?us-ascii?Q?LIeFE+jKC0bf4lHhd/M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d0cada-720c-4226-f3b4-08dc1b062d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 04:54:12.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dA6M1btzE98zZH2oKWQjKnSM3hWCI9HEWUGZ5s/tWeVbZcCoIDCdwZcyBT5vYTYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

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

Acked-by: Piyush Mehta <piyush.mehta@amd.com>

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


