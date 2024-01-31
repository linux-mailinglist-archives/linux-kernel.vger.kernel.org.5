Return-Path: <linux-kernel+bounces-46619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ECD844214
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A94E28F07F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254584A35;
	Wed, 31 Jan 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jx86T6IS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188C83CBC;
	Wed, 31 Jan 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712100; cv=fail; b=hHlqM6Ger5XOF8ogyQ8WS2QvzVw6ZYCYIMpuD5qHHkNcekHdOion/TQ5gdWr0GyEe0LNSluOE+mxaqKhuQ+O6TPFuhjCtmKfnxI92BlnwfQdibz8DFPTusAqs/U8NWP4Lab28ALDeh5IvgHjQSWMAKxQEZVBlG0G4URHr0CCXIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712100; c=relaxed/simple;
	bh=7MLuSAOEKr4CAbw/Ji84rNpoAs7x0byvv6gUhjfGsbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVEiDY9BWksiRLd7LriYjccBEKzKD1ItFc5uuEchUMFwtqjLXzXCP0o0b7hnBgmoHBNT2JYVq2w7JLxi3Fpq6hxyEpzRNslpRwk8iEpOrKcowLwtek3LecPdtnC1Yfdff28/Ti+Qh4GCPcRTZyH5kFuoA26eIDxXm5WwY6UyDOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jx86T6IS; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9bI1SGevM7NW3QtRfjXLCP5sdlqecfxK/sOnekN2T+vJTrkJfLFeYGGlFEqxe3n16UkBHxv4o0WSCvpBwVgNibkKFZJ1YrWMIBxc0ZLk/2kYoh1yvxC9PsKXWbOfEcFLsydbqaGS8De5ySMOG8prusDwP1ZsAuiuDvMNc7URIqyFc/aVYr/2GzVhzuUxmhliuMmquuLFKloZJUlnuNdweDB4FnMZxmCAOCXrEFqXXX8GflD4yTeN1536Lt6M3LzaKstHkVCS07NY+E/6vt+uzELaHCk1DllEunAr9KlNHv93jWiNEpQcH+2SlBJdMDEqwv8eqQ0oQWWn/bbquQsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lu0bLVs8L/wth0nvYLHPwPPsiRGDeXR2Edis9f+j6U=;
 b=Hv0DPJL2ZcDpyPZtyXVvz2VZqs0UQZDjBLch2lgd888vp4w4Sd4xj29Bqk5yB6cyDtLGN7FicCwyd2Zji0+LjJ28lU8aWheVwlSlP0NfMb1ZIU5cT3J3oGwOrYDcS5d3TbmOzr9eZZiuGh6KzXURoSSOqRzLA5rzURq2lkrGR8U2EA9Bdley5MaUALjhcjdpNx+PPsA5DWXS0yDxCQAw739GyTuT7t86kNeSmzAwb9qzHU+jWyY5dZpfO9NAQ/oq1L783e1QoUeLyZ0WS7nUfCODNvgRFOJn/B/VxLFAdpi9+mWCkpaRHRkib5mZUgyC3RjzHLlECK/XZfnTPyohBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lu0bLVs8L/wth0nvYLHPwPPsiRGDeXR2Edis9f+j6U=;
 b=jx86T6ISSbe2HEW7ZHnWQKFPltFRMOAGa+flPWRB06IozN8xvigLEXn3d7EdkoY5hv8KUFXTLTi/Bks/vApRir/5hmpYWbX4TfxpQQDzVmeMSzR2dd4Ssf9B9jYjtFzyru7MXiT6s07lCnbXfulwMkZHOoV/yCGa3GVtvXzSnoA=
Received: from BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 14:41:31 +0000
Received: from BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::4a52:8ccf:4402:e40]) by BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::4a52:8ccf:4402:e40%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:41:31 +0000
From: "Cvetic, Dragan" <dragan.cvetic@amd.com>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "Kiernan, Derek" <derek.kiernan@amd.com>, Jonathan
 Corbet <corbet@lwn.net>, "Simek, Michal" <michal.simek@amd.com>, "Erim,
 Salih" <Salih.Erim@amd.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Topic: [PATCH v4] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Index: AQHaU5c+nkT3IaHEQkyv+XHd4tf9VrDz+uMAgAAEz/A=
Date: Wed, 31 Jan 2024 14:41:31 +0000
Message-ID:
 <BY5PR12MB42419E6A113F09403C8261E2E27C2@BY5PR12MB4241.namprd12.prod.outlook.com>
References: <20240130161259.4118510-1-dragan.cvetic@amd.com>
 <20240131142318.GA1091307-robh@kernel.org>
In-Reply-To: <20240131142318.GA1091307-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4241:EE_|SA1PR12MB6821:EE_
x-ms-office365-filtering-correlation-id: c98e3b28-0993-4dbd-8e95-08dc226ab745
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 upORyuKvRSVBQZLYyg2B9PC4/Yr7Yk3OVkMExWw1HATeuIXVru8Gb9pIdYVebrwYSlCk0oMm5W1iOI4l5PxEBFk1h3XOLwXGZclXjKENkd+tLcfd9ztLELO/t5dC+nmJ9TFva6l4JyfmEyO3uYAONJK8Ef1vN7GHSfMUyNLUM2KbQ5AW7DIpPJlzUpejaCWf1YQnsSg/bH1LSGYNtUtDXvkHOr/W4vbtW0ZGhJXirouPWdfr2F1zD4Z7nF4MVe1w4osqCS/7wD6rLYqPzqDWG5JNnWSyKCLy1a4LdiYtyomuNBMA2C3EwuG/T/SYiztC5WMQBiFaEULXfONg/MiVTnbdbDKES4Q/NOn37ENll5q8Xp79oJX/I0r4DIl3DroZ3Ajpr5JMg19+EOWwmfV8gm1EDyVo1qDeal0/WEF5/YwemsiPz6+Az8/pJd5ySohbucjk3iv4wCtkbDrFqGxbwJ0Y+aP7v6XsKjRWcpq53bBPLqg8ZeF+3wZJpnRFeCwa5PvcUsob2Mv7MiM9aszZK+dkTaSSYT36HsgfHDUONDKoaQ5Mrc+tAc7+vKRY/Y1A8QWXFa3B5UI0UQG7XREO+OhOSWUmqom5F/t7NykOCLo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4241.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(52536014)(66899024)(8676002)(4326008)(33656002)(2906002)(86362001)(5660300002)(8936002)(64756008)(66946007)(66446008)(76116006)(66556008)(66476007)(54906003)(6916009)(38070700009)(966005)(38100700002)(122000001)(6506007)(9686003)(478600001)(53546011)(7696005)(71200400001)(83380400001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oGwHgJkxEcK/8YvOK7wVNzaWzflQcQL8JsIBGWKWQD8soMl82zosPYZogodO?=
 =?us-ascii?Q?amaQ/QJz3aPaHKqS0xqjxYh1V3odVwkl1Yr3GvUB9OfurVnybd9cukHrRVFK?=
 =?us-ascii?Q?Ws54BN4nER+f7FWyZV6Rxkit/KFTW2auGCSyQZh9dnJTUpPdqk0TbjGh8Mzq?=
 =?us-ascii?Q?gKcewM3bFvZF1Nj9jxiriPNB4vMnpFkg/Ug4SoLuBinSfRiNAWj+ExTktTx7?=
 =?us-ascii?Q?9AS7AI/KjuhzFThKS4po5byuynSGZEIJ7xWQbKMs47JvnMg5IWykx9hkGrMA?=
 =?us-ascii?Q?kJLiDHBl5HUgrOF8OXnfPqjNPScHfg5eKmd7OgKPHe4K4NI/y6xwQc5eItNK?=
 =?us-ascii?Q?2hn1SqvuLKJlDC14SLjdkRlwReh4E3uiagk/lhVsFC+tf94GNCOOVXQcpiEx?=
 =?us-ascii?Q?qMhfifITiQqOnS8vFG82C7ihPvnLNwZRfL84RTE9ZV9gwqaj5j4hdNISU695?=
 =?us-ascii?Q?lcBqmF2de3AGo1HV+84FGlmwbH8HVrR3TuHOTNeOJXZbOs3/5SPP8k4Gs8Yi?=
 =?us-ascii?Q?uQX8FpCyIvbZxfj5vuMaKsvBZhzwP5EfOU6rR4/36S+kLxa1Q0ZVzPinPRE0?=
 =?us-ascii?Q?0g5i396vpW6Cy9FKlYu1mJUHnqC35YBnmHDB0gBdKFavgkNlzJwCqTmfstUT?=
 =?us-ascii?Q?cTR0De/3vD2WlrqC9AFcIVUYg8vCdfkHhT7C+EapB3JjZIk7i2rabZrR2LgP?=
 =?us-ascii?Q?4GewDKIZR85HpEUvTBUJ27McuNKKWzNURlVBYomA/pGbUDxGlafcFgJMpvqQ?=
 =?us-ascii?Q?R7P2w9hOvHm8QLfY2ATqFLQQblKqZO8hVooyjjI+fKogoZGQL9sr3njYpgub?=
 =?us-ascii?Q?I7Mc5SC+xEZeJyl50at3MKKyguf7uGQeQW3b5R1hh+7bFZHr98DXKfYpPP+F?=
 =?us-ascii?Q?S8lbXAEAyc4zuiZERO9D/IU6rxmSauSltA4WgGIkmlwWoBBh9lUNJgyehZSd?=
 =?us-ascii?Q?5/AfJ5vhNlRpASN6lYQJrGU+6eY2Mid933w82mk/oXOfv20jfpu+gpXQ1a61?=
 =?us-ascii?Q?VKNtl+P+0GLRNlbdhCUIIiL/Xo85eVUFVU47RKNXDqSWcvqOrsXwi/+OCbyC?=
 =?us-ascii?Q?h1XOg9ZFxwjJsPcKgu+RlINkZowEZ9WChHlc5Onq6BoVMpi1s95y7CLCPYx8?=
 =?us-ascii?Q?1KcxIRbf/NkTkP2+NYNyrTKQvoqqFhQl9XwAii3V6dhZCvRGnJLpmPKThWu1?=
 =?us-ascii?Q?/7vFh57UDwcQvlSVRiFqGpHHEStZzb9SVoPx5s5+7SdzepwMYVhpA5byUUFL?=
 =?us-ascii?Q?iWSKNrLZi6eVWNstOIac0rRW1d7ESejfzamRT1Tj8clAi4GptkNtFFU7OL4i?=
 =?us-ascii?Q?UFZLdY76Myma7M472ElJ8BGg5BMR4KL5Y1RySJg1+66zekXq01jyQCt/M5S7?=
 =?us-ascii?Q?8t/3x9oPJfjLAZ+SHuvEU1QlqqRFgVwhfdkhF17zQYXP8LBq+5O2XyCgwlXs?=
 =?us-ascii?Q?RQ605YqX8+mcA5q041T8AqIUV9d8voMK4BOwNDUXriqWEJPfpEP6ZA65EH0k?=
 =?us-ascii?Q?R/LIl4GAoERp/uTc9j0BZnVc9bXRZ3S/EMz1UvjF6XIdVbNQnBnE+niszr8r?=
 =?us-ascii?Q?9jU2+LTlCXyWouJ0+lc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4241.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e3b28-0993-4dbd-8e95-08dc226ab745
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 14:41:31.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoNKhAvvtjPBXohVt/NMKOR6RKq+qfGBnTPaevHAshveL1uaqoqeUDl+V854ZI5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, January 31, 2024 2:23 PM
> To: Cvetic, Dragan <dragan.cvetic@amd.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Kiernan, Derek <derek.kiernan@amd.com>; Jonathan
> Corbet <corbet@lwn.net>; Simek, Michal <michal.simek@amd.com>; Erim,
> Salih <Salih.Erim@amd.com>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; open list:DOCUMENTATION <linux-
> doc@vger.kernel.org>; moderated list:ARM/ZYNQ ARCHITECTURE <linux-arm-
> kernel@lists.infradead.org>
> Subject: Re: [PATCH v4] dt-bindings: misc: xlnx,sd-fec: convert bindings =
to
> yaml
>=20
> On Tue, Jan 30, 2024 at 04:12:58PM +0000, Dragan Cvetic wrote:
> > Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
> > dt-entries as well as any future additions to yaml.
> > Change in clocks is due to IP is itself configurable and
> > only the first two clocks are in all combinations. The last
> > 6 clocks can be present in some of them. It means order is
> > not really fixed and any combination is possible.
> > Interrupt may or may not be present.
> > The documentation for sd-fec bindings is now YAML, so update the
> > MAINTAINERS file.
> > Update the link to the new yaml file in xilinx_sdfec.rst.
> >
> > Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
> > ---
> > Changes in v2:
> > ---
> > Drop clocks description.
> > Use "contains:" with enum for optional clock-names and update
> > comment explaining diference from the original DT binding file.
> > Remove trailing full stops.
> > Add more details in sdfec-code description.
> > Set sdfec-code to "string" not "string-array"
> > ---
> > Changes in v3:
> > Fix a mistake in example, set interrupt type to 0.
> > ---
> > Changes in v4:
> > Set interrupt type to high level sensitive.
> > Remove '|' from descriptions, no need to preserve format.
> > Remove not needed empty line.
> > ---
> >  .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
> >  .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 137 ++++++++++++++++++
> >  Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
> >  MAINTAINERS                                   |   2 +-
> >  4 files changed, 139 insertions(+), 60 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-
> fec.txt
> >  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-
> fec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> > deleted file mode 100644
> > index e3289634fa30..000000000000
> > --- a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> > +++ /dev/null
> > @@ -1,58 +0,0 @@
> > -* Xilinx SDFEC(16nm) IP *
> > -
> > -The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP=
 block
> > -which provides high-throughput LDPC and Turbo Code implementations.
> > -The LDPC decode & encode functionality is capable of covering a range =
of
> > -customer specified Quasi-cyclic (QC) codes. The Turbo decode functiona=
lity
> > -principally covers codes used by LTE. The FEC Engine offers significan=
t
> > -power and area savings versus implementations done in the FPGA fabric.
> > -
> > -
> > -Required properties:
> > -- compatible: Must be "xlnx,sd-fec-1.1"
> > -- clock-names : List of input clock names from the following:
> > -    - "core_clk", Main processing clock for processing core (required)
> > -    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (req=
uired)
> > -    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (option=
al)
> > -    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface c=
lock
> (optional)
> > -    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface c=
lock
> (optional)
> > -    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock
> (optional)
> > -    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master
> interface clock (optional)
> > -    - "m_axis_status_aclk", Status output AXI4-Stream Master interface=
 clock
> (optional)
> > -- clocks : Clock phandles (see clock_bindings.txt for details).
> > -- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
> > -  location and length.
> > -- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the c=
odes
> > -  being used.
> > -- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interf=
ace is
> > -  driven with a fixed value and is not present on the device, a value =
of 1
> > -  configures the DIN_WORDS to be block based, while a value of 2
> configures the
> > -  DIN_WORDS input to be supplied for each AXI transaction.
> > -- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value o=
f 1
> > -  configures a width of "1x128b", 2 a width of "2x128b" and 4 configur=
es a
> width
> > -  of "4x128b".
> > -- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS
> interface is
> > -  driven with a fixed value and is not present on the device, a value =
of 1
> > -  configures the DOUT_WORDS to be block based, while a value of 2
> configures the
> > -  DOUT_WORDS input to be supplied for each AXI transaction.
> > -- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value=
 of
> 1
> > -  configures a width of "1x128b", 2 a width of "2x128b" and 4 configur=
es a
> width
> > -  of "4x128b".
> > -Optional properties:
> > -- interrupts: should contain SDFEC interrupt number
> > -
> > -Example
> > ----------------------------------------
> > -	sd_fec_0: sd-fec@a0040000 {
> > -		compatible =3D "xlnx,sd-fec-1.1";
> > -		clock-names =3D
> "core_clk","s_axi_aclk","s_axis_ctrl_aclk","s_axis_din_aclk","m_axis_stat=
us_acl
> k","m_axis_dout_aclk";
> > -		clocks =3D
> <&misc_clk_2>,<&misc_clk_0>,<&misc_clk_1>,<&misc_clk_1>,<&misc_clk_1>,
> <&misc_clk_1>;
> > -		reg =3D <0x0 0xa0040000 0x0 0x40000>;
> > -		interrupt-parent =3D <&axi_intc>;
> > -		interrupts =3D <1 0>;
> > -		xlnx,sdfec-code =3D "ldpc";
> > -		xlnx,sdfec-din-words =3D <0>;
> > -		xlnx,sdfec-din-width =3D <2>;
> > -		xlnx,sdfec-dout-words =3D <0>;
> > -		xlnx,sdfec-dout-width =3D <1>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> > new file mode 100644
> > index 000000000000..7be8439861a9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/xlnx,sd-fec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx SDFEC(16nm) IP
> > +
> > +maintainers:
> > +  - Cvetic, Dragan <dragan.cvetic@amd.com>
> > +  - Erim, Salih <salih.erim@amd.com>
> > +
> > +description:
> > +  The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard =
IP
> block
> > +  which provides high-throughput LDPC and Turbo Code implementations.
> > +  The LDPC decode & encode functionality is capable of covering a rang=
e of
> > +  customer specified Quasi-cyclic (QC) codes. The Turbo decode
> functionality
> > +  principally covers codes used by LTE. The FEC Engine offers signific=
ant
> > +  power and area savings versus implementations done in the FPGA fabri=
c.
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,sd-fec-1.1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 2
> > +    maxItems: 8
> > +    additionalItems: true
> > +    items:
> > +      - description: Main processing clock for processing core
> > +      - description: AXI4-Lite memory-mapped slave interface clock
> > +      - description: Control input AXI4-Stream Slave interface clock
> > +      - description: DIN AXI4-Stream Slave interface clock
> > +      - description: Status output AXI4-Stream Master interface clock
> > +      - description: DOUT AXI4-Stream Master interface clock
> > +      - description: DIN_WORDS AXI4-Stream Slave interface clock
> > +      - description: DOUT_WORDS AXI4-Stream Master interface clock
> > +
> > +  clock-names:
> > +    minItems: 2
> > +    maxItems: 8
> > +    additionalItems: true
> > +    items:
> > +      - const: core_clk
> > +      - const: s_axi_aclk
> > +    contains:
> > +      enum:
> > +        - s_axis_ctrl_aclk
> > +        - s_axis_din_aclk
> > +        - m_axis_status_aclk
> > +        - m_axis_dout_aclk
> > +        - s_axis_din_words_aclk
> > +        - m_axis_dout_words_aclk
>=20
> This doesn't do what you think. It requires at least one of these clocks
> be present, so then at least 3 clocks. It also allows anything else to
> be present. You need:
>=20
> allOf:
>   - minItems: 2
>     maxItems: 8
>     additionalItems: true
>     items:
>       - const: core_clk
>       - const: s_axi_aclk
>   - items:
>       enum:
>         - core_clk
>         - s_axi_aclk
>         - s_axis_ctrl_aclk
>         - s_axis_din_aclk
>         - m_axis_status_aclk
>         - m_axis_dout_aclk
>         - s_axis_din_words_aclk
>         - m_axis_dout_words_aclk

Will do it in the next patch

Kind Regards
Dragan

