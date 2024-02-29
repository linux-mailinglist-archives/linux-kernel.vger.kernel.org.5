Return-Path: <linux-kernel+bounces-87597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CEB86D656
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E619281850
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E96D51F;
	Thu, 29 Feb 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JbiH++lo"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2041.outbound.protection.outlook.com [40.107.113.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88416FF5D;
	Thu, 29 Feb 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243285; cv=fail; b=sMOMcDd0u/3krRB+Xwry4wRTUlPwSjxqmd0rd1p8L0dHU8EX4rqQC7BrlL+eIhsJa0/ZmDnRxe+DBwgUcEC+n2rIIusZks5XsMMHcSA2Hiuso3m25TT8y+rg3thQlfguNVJ/8tmlI5Tf4cd11pACOlLu0ZvIPADjEL634XZwxvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243285; c=relaxed/simple;
	bh=IU6badSHaI7c/t3PB0hQWDMoNHbDmPamtaH/PF6+SYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gUVbrfnuQ1xMhktq19nB5ymZpfo+atb6IaAKuto2GlLDiimJhGDBSsg+06bnZbduYMi6ZezwjuI+bdHbiZ+iHCO+Lnax0sYOnb4ZJLSveXsqm6wPPMsQbPq1U/XzQ7Wjc7QE6HFhtikzUXm3YAyNImCsUR+ICQX8WBhBqM2K2tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JbiH++lo; arc=fail smtp.client-ip=40.107.113.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wfo7MHMXWTfFX9gJ81VxB2QnVInCsyvaxhCuQxed5My/BDTaZ07CTdi3Wp7Iod6Hm4jb1m1+ShQb+jNN/t4YiYK/M0Y5O/f+OExmjpFbQcMUus0NSFcrE5xHCkrWfLDjkpd7kwxty57ZcV2YyxyGw/va82ywpdRQB62Yyux/Vdyzgy3qpkm6yLB1GK5zQoqHKUZfrW6mPSAZBsWBSdoRO7yBK1RrVKPiTuqs8azITdiNIpogD0jihTWf2jUC/QViBhhDjqb98Mch0kWzFlhm4NgdTLxPHcl8+9/cpHAUF3yDSf/NS0m2hqw93+orUaUqIbM6la1/8rXlwaBQgyegnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTq+rHiXb7C+pWETwCSxsmXu8wMLd82Bs1fOBG44KzA=;
 b=Ma2yW/vI+VQtaA/WeVyXg3CaSM1yINZcCPfthMqeAgj0Yb/4pIbkwPUM8FlbyUh/fCGM7SQ/A6aPd6M+QLDhytPcmuQLnLJbPnK9ovq4quGqLzs3ibV6vG0DX+uxKIIJJOwl1Z6SY/bBp+6rEqyagp0iscgjj1tq4hFiicH5LB8VLEig0VSsBN5xirITI1wVzEW68F3Ro7qubyOLZjC4gl1bNwAp6Ud158PhYdHcwTLEyRkGpUMZaxoncFYhZDzKqvaj7QgMlIlhf2aIhCLBY+u7pt5aOTHXa0a9a546AwwMkktYctI+yNYSuOYBXLAnvwV0dGMztXN4iJZQLasIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTq+rHiXb7C+pWETwCSxsmXu8wMLd82Bs1fOBG44KzA=;
 b=JbiH++loIOvrk2riUjkJsdez/xY+SPRU+3mHPupteNrw2wflLD+LpVeLDe9LtLBlQWRDWy+LM+n0SIiH9L7EwwQpUsoK6FTjbm1tHRK4QzAFuBi60Ygq4GzCuHefTC+o/2FGqa8q1eSxC6B94qkEqBxf5/Q+xwW4jmpuQU62ll8=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TYCPR01MB8085.jpnprd01.prod.outlook.com (2603:1096:400:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 21:47:59 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::675c:58ac:9054:36c0]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::675c:58ac:9054:36c0%7]) with mapi id 15.20.7339.031; Thu, 29 Feb 2024
 21:47:59 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das
	<biju.das.jz@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v7 1/4] dt-bindings: pwm: Add RZ/V2M PWM binding
Thread-Topic: [PATCH v7 1/4] dt-bindings: pwm: Add RZ/V2M PWM binding
Thread-Index: AQHaXfdwpEIWwazNNE+Aw//o2mi8M7Ehmt0AgABa4wA=
Date: Thu, 29 Feb 2024 21:47:59 +0000
Message-ID:
 <TYCPR01MB1209313213684A44E648416CCC25F2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
 <20240212210652.368680-2-fabrizio.castro.jz@renesas.com>
 <jubuf7nz65onuqrdrnt6bejplexvodsldqvqj527fxcotehxl7@z3kbhkhlnaxh>
In-Reply-To: <jubuf7nz65onuqrdrnt6bejplexvodsldqvqj527fxcotehxl7@z3kbhkhlnaxh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TYCPR01MB8085:EE_
x-ms-office365-filtering-correlation-id: 9a29b35c-5f2d-4748-97a5-08dc39701887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N3fsn/JaOy1m4FjFfOutcRsM5svQ9CSe4Gy8iX37/2fHY714dD7o1GWmFlrUmkOReOaABAwOCnlqtAykOWgSLzyg/krsKIHqaZdIDsIxXSc1CSVzk4wm1eHLVShYMXeV5oqtRw8dQ1CZq1kVywJSPdMkcPpIcj21DdPRXQJgIxlohXxNGUunUqp0T0/FSJiPRrFPsWuu+tBpCMtUMwa5VmulVb4BYHtuzesnjVG1ICh8BE6h+aU2izoyH1GRib+bcD3JqBFm0+bF7wACclHnP7MGorZU7Jqz1OlLQkObbKiLiK9QOaxL+Pws8mLEtRiZKO/FPS238NzMQSidJlDkJxClcs/k5UXqp10cTlQJ5B1ooI80YPqcGSMyRF1Qu8H4OKYxaN9VRRc1bNpJ7QuebTHfKvxWGs+H+RASAwu33gP2TewPdJtw3okIkmPKEwhO86/7HpmNKOKpihneKqjlWBLR1AAe+8tIotDhUrzp6SJdG5STOanO5BlEMu5GnrRslSvGmXyICYC3D0tB2zGTvAZqdRe1f4hBpMvtXB9ACKAQkDNJygFzjrnrHciFB9yA7/XYHgZsFBtJHIZ9t+a+wrDYecTb/qsg5Othq53ZUxgynETcbgxWlab5Co0U/o4d2cs4euSXvqQ9IMdo7LMLBR0XTJcF+3NDIr2PQ73s18w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?piiBFi1huD4ENdFHxPWf3BbgYLBndhTTkh0XmvgSIKYyR2FP8cemvnGlNo?=
 =?iso-8859-1?Q?m3viN+SyJIa5sLdbCvPBEcSWNKHt2G9c71EABg8P2us/j6PxjIfGdCnRD7?=
 =?iso-8859-1?Q?oLV0q+6g328KXJpKsuLktQ/CEkucyKVGoeDgk4RsNW/wytvN9jtQ3b0XKj?=
 =?iso-8859-1?Q?MgpsQhQnEwjobSN9yYJcIz3LRpr26UEs5D9Dhunb6MY3+7ptK++as6asDt?=
 =?iso-8859-1?Q?N9BYu4iIQZpc1+mKiiXSEBQ/lAeNKyizIy9H+XwX2gAOaAWKrMkYf1FGKG?=
 =?iso-8859-1?Q?AWaU6RgP1P+pwcqQSKa4yVD/SUbLR/AWYCDAq7ZV9KvK9EjfiCsNPU2Aab?=
 =?iso-8859-1?Q?i08oUvwXsYfd+EfQLNQkzOIeR5XTLYpASZDFKuYEKkNueH86QgcFGBMhJU?=
 =?iso-8859-1?Q?/c6vOwxC5ozNdCIGvNs150yocSgkd9zqtUWp974umPJjsz3hlZRaAW36om?=
 =?iso-8859-1?Q?srVg3/gubzdiOInaRk5sCAtDAMQiwYUf8kcewf1mYKl0ohhYtzcOAC1lAj?=
 =?iso-8859-1?Q?sa9d+tvPGQV+K6kaNmyaeNbAFCER4rKeEn7w7wVfx0Zb0GXNkrkIu97Ekh?=
 =?iso-8859-1?Q?QIMgQdtorBi54n46xeaevXeW0+RBLKT/jxebY7nSIUV78zKhp2gRS3IXeG?=
 =?iso-8859-1?Q?dKAmiVgPYcp54Qukfd6XHKOpFM1+SqiLoNDOriuuuPYRkWXRQlkKvs377o?=
 =?iso-8859-1?Q?qPUX9Zm1E8MhqyG8uNUAnQFwnf1Hd8xHWMkGBC6HvcmoMsIqgbUP4bA6e/?=
 =?iso-8859-1?Q?9bTEw06fsvJIcPtR/sEA2UJeJ4ySRiN7BMcL9vrO+qYaZzNOwZDQzutmI3?=
 =?iso-8859-1?Q?SCFSREvZSJdJvzRW0jAjJHuUxzQTVGI/UDTd+LbAxb9CxiDjIQZgrj/0E7?=
 =?iso-8859-1?Q?+AanYDQcrRUySeXzQCRj9xOfPJdOdJ2u6Drt+MDI5CndxbUjudmhfwpzY3?=
 =?iso-8859-1?Q?t37cnc/vwQnY/VB92im9LGXGlANUQgsc5l7EOQv5hv6h1LwDWlMmKRENkB?=
 =?iso-8859-1?Q?VlNC9F7j5r+yTw2wq7xh8OwYzf7On+9ziAhfZGR6BTA5WsiNxR+rvLzwo0?=
 =?iso-8859-1?Q?2tjdxlJFoFwQ+vFnH/MC75Oh+liHpAR2bggC8WHPQ+sn9ePiURWGAIRGdJ?=
 =?iso-8859-1?Q?mDoqImgAN0rQBk12hxgysDUlEhiFg8v4FvGMewONQ66B2d5nJmfiUDS/od?=
 =?iso-8859-1?Q?/wlE+YNsD54YLA3Y9UM0GXB7Q5ajOQE6lVby5qQ8FEBDS1gPnJd/wCIxNe?=
 =?iso-8859-1?Q?zqjhVjEBwgp3rSkGy9wIJEggsUJyaAS0EISb1oWP12F9z4H87quh+wVMqs?=
 =?iso-8859-1?Q?/5dRw0PULxaVGG14c8myw9VYpa8zswlKTRtUVSDfeopSl8czy6L7Y3oQob?=
 =?iso-8859-1?Q?9qoD8uh7S98mTcBl4DXjz/vZcBUIjRKpMl+LphR8A60eNeYInUQReHkZIw?=
 =?iso-8859-1?Q?JZcKXXWh2oq6VC1wZU7ub0z7PUUI9yzslzVY6Am2I7iU1J51MVCJryaTe1?=
 =?iso-8859-1?Q?/zFt7ZchpbXXaAf56M9nfbGcnzEHeZPh/5CLcL9deTGhXLMmi/S/zk6Rdc?=
 =?iso-8859-1?Q?+pCaRAyIXUdPvi7zQT0Uu15CqFyMay77jkUq5zZTGop07yREMk8cSEzrZg?=
 =?iso-8859-1?Q?BuMllTLELyCZ0Mnoh6D/S8agCPykN9od2LXAhybZobaAyBSEbI0hkCQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a29b35c-5f2d-4748-97a5-08dc39701887
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 21:47:59.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exwAyOP2ZifGjlGvAJ+aArYvu1zwuLIyN/kIxbWbPsEtzu1njcWcRnb53HhPh0xEaI1DzlpuuttBENvXbAuA37NJOl7H8MC2wsNYBcAo4s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8085

Hi Uwe,

thanks for your feedback.
I'll add my S-o-b in v8.

Cheers,
Fab

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, February 29, 2024 4:22 PM
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Geert Uytterhoeven <geert+renesas@glider.be>; Biju Das
> <biju.das.jz@bp.renesas.com>; Magnus Damm <magnus.damm@gmail.com>; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Krzysztof
> Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add RZ/V2M PWM binding
>=20
> On Mon, Feb 12, 2024 at 09:06:49PM +0000, Fabrizio Castro wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> If you send a patch, it needs your S-o-b. (Though you could probably
> trick me into applying v6 :-)
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

