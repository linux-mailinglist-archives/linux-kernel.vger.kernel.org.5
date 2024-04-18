Return-Path: <linux-kernel+bounces-149348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37C8A8FED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCCF1C212B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC010F2;
	Thu, 18 Apr 2024 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ermLnHgb"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2043.outbound.protection.outlook.com [40.107.114.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA8181;
	Thu, 18 Apr 2024 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399472; cv=fail; b=c3M6MwGp7F+7oP6eVXeQ6hnlb7B5h11lDcH491ImjGGdZjwX+/IjyNcFUB3UgLy37m2EIjYttUBANSrQmQo0H8f++mURKjH0m5om3dSet/KWJk6kif+Ir+cC4Wti9opymnXBWU44VnOuhK6PoIoYw7hbmM2KYXZYzaE1fbdawe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399472; c=relaxed/simple;
	bh=Q1wtKmg3RFrfD0yg5tEsOhir1o7TEKVPOKvnX78bG48=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=iNk6pW/qaRUekhqtS1IdcXXxBaRYjx2J0RZV27THk4pZB+Kf7/IWxYFO7zg7hfp+Zg5A267lKUQODtOO2Qr/C9dfXv1J1TlESbXm6KZn3zAR7kMMlBajdCVYwsrQBpxpMnROQUoVygsN9LuX6Yn/KNlKln3O7+09qu0lJ6WUfb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ermLnHgb; arc=fail smtp.client-ip=40.107.114.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPqipMOzG6EiRSYuyaQWixhIC7mbVtB69/HUax3zFPyO22JN71xvnc+VsGcMjjbj4imKYO8pl2+Nl6os5/Hw03ZZNnXDH60M7UZS43N3IJ3cVNvZBEIIN/pPDKaTVlNXF0v7iX9YGUJsmXyBKft6accS4lk2dMk571RpOz9+7FiUBtCGqLIF3J81nqKc5PWPBH0it3/cgFPZjcaFfrDttUoN/AWw6/hZrUwFhG7lr6Mw8VoA1Zs2MxRyw8U3pc4EV9fyjRkSfrENvi2t3bHyuYKMXUC2++6tFm8u5XQYPjfj+iBgQnmNHrhv9Cba0QclqFkOgndOuyKccxi8m6BfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su1KlBQmp044bZGLsEf2I0vk3JeyfjBTb90db4X8ys8=;
 b=WYxcPY9d0ZJWI9UQWrLUKUGYLGzJ8TuZ3C/8pvBF2GoSt6kP/V6zQe+c1Kam/q2fzEGqJt7epGSqnxBzaJ9oYSw66ucR5uOjZAXGCRc4HnxyhssuHZUNoqxcPQlQsaYWRAlypO82KRCI/y4YqkTWEmorAHnyAS+4nYoQKdYo/DrVOFyP7zlWI7noSfO9GYKO4murJfZCSbhYSoEmo6VACFMFc+ntPO18W4VYBqS+23IbBV6kOcDVMu2pwGUXVY6zat73DzIHcgNco83K87JdDsx97A7LYdLdrpkghJoPxm/38zY5Q8RqghKR02N/xgxEBiWye/j1AlM4sRk9w00rYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su1KlBQmp044bZGLsEf2I0vk3JeyfjBTb90db4X8ys8=;
 b=ermLnHgbqrT1ArOgGcyGdZRDXq/uO2dw7VBZ23fngZvzHkhL5kERKq7uWV/LcnmlTjgUZmZhmfMZ5v6epNn3+o9MEL1gUn098FIIBvby5xLMyYglUUZo4VMjkNUUTUWswrhM0DXkp0jnCx08gLSsm9nn+PcJAP64X6aVaJxWWrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB5355.jpnprd01.prod.outlook.com
 (2603:1096:404:803f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 18 Apr
 2024 00:17:45 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::131e:55c0:a4a0:713b]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::131e:55c0:a4a0:713b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 00:17:45 +0000
Message-ID: <87mspr8qxj.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] pmdomain: renesas: rcar-sysc: Cleanups and R-Car M3-W quirk handling
In-Reply-To: <cover.1713348705.git.geert+renesas@glider.be>
References: <cover.1713348705.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 00:17:44 +0000
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: c741e2db-247c-45fb-8a5c-08dc5f3cf86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ESwxQyX95WpJG9tx9h4aU1r7m31Y0uzblD2XmMzLOddr/MFVSc2K4KMkyPoMeqMjt8U00Ij5FMYbRjmCMTrx355XlvadqVz73h/x28lD+mKQl38IyyjcqBi4XdfZK92PY/uoiWu1H3QeG2Gh/1jtbg0frPR/G52YW1+QoZcz7v8EnaxqYwCtr+XNKPwj+TR3GwODy5PBlo1dZEhlEMqJe6q8i6NdmYoqaYSeaXHq7mL2SpIQ86yav8DqENZSRo8QrdecTKUVf1V3oHtTDzA5OkPd5INd00B936K8Lf85bLaPoA2G/vOQ/l46sb61tcDI1wNieoJhIxKltMTPGsjxMamIXGjXPffRJqh/l36FKez10/3thNx6iVcoaBFGQSerwcQPyIh2/xEczMavTxm87qmUesqAvy/i71F78OsNnAWzDq19frVQtvRmG706tgvLSwtGsBaMBj89MuzN7oLbsrW4WJM/BD8cBJontpubuGh8x0qlPsDLv3rQGBULRRn25xerbMOWAYBMAEJkbpcCaggHJ8zk0q0XqDBXyYdSSQwt+KRgl8jJw5S3lUVfdW3HTJ7H4j+CwPh4y4k4UbCPMoZzcQMB6djM03xgRuuORj/zubjCxW6gWlMmsk3iz7WWaYIh54HiKsmMsouzdknaBu5RnXCxPrEW2HEWktIQJZtWS3D5fiFZh0xwWk5HKpSTkI0pbaqfhSCejb41fbN7lcfT4bcpIIZcAoJJCxArCm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?KsrD6xId7CJB46PTJZphbXsWb3v+jKRG0a7v1Z/9slPGUyiTN1Q6m85hKQ?=
 =?iso-8859-1?Q?mU7e6/M47ZEuR6soDe3Z1CSG5QDvkmxi2Drk/r2KfjpgF71jPGx+hjKI9b?=
 =?iso-8859-1?Q?c006gZVKuci7kIK+RpAVihrSOICiYg9WFlxpot/EW8HRZrwZPsNGXcSkZN?=
 =?iso-8859-1?Q?/HaZ3YF3Ewh162+ZsRiiLo4U4PSAPTIUmNf0uBi9lHca3Qsvi7gUauJ0jz?=
 =?iso-8859-1?Q?Je4wI+MIk9KkHgi7slWx2Ci/KxUHzj3g0UIhPiWaJnfQvNYb+20MjDmLCC?=
 =?iso-8859-1?Q?4z1PrySByv8eKBfmJDPDeyRRO5z+n9ID11PZuk951l76GnAjyEmDzojTf5?=
 =?iso-8859-1?Q?/6e12Zky0nIhVAXsTAggn3f+hKFWDp2GpbfoMU/tulvY0OHnccIEGdrIHs?=
 =?iso-8859-1?Q?GjXMVG32cmaP3IfcLgxeYO/lA1v5bEA67uL+tU87m8ORc8z9gqtkF5VrM6?=
 =?iso-8859-1?Q?5SEw12uj2Tmr6urx+EHSPgS8xUtvF4Rsgm8sqnDwRzuDsjKEAnaJ0XYMAZ?=
 =?iso-8859-1?Q?YNi0irxu7tD4W12Qe6NZUhC+OkU83lbn/HR9AwaIBgOGYXbJGbrySKEcGI?=
 =?iso-8859-1?Q?3ekBOVaWlyHrs1jvzB3UhcbIZoE/hgupRwsCrDRWr810l9nfPE8KX75BAF?=
 =?iso-8859-1?Q?4dgbrbE0/QI3CUl6o5EfLTdJLwungRYHbF95Cgdi4u0byC5djO29GOGzhh?=
 =?iso-8859-1?Q?p7ZXoTzytnJiu+vtJLYhxnw5YCrL9V1Q/KS/Hi6uYuijcmjTszipjFG3sf?=
 =?iso-8859-1?Q?sq6qWjRbcqez6nvqWtf6kNNbi4C1qRBNbA6ydLumP3aTU5BfPCzH+ckDUI?=
 =?iso-8859-1?Q?+/kyzwgyiXJzqxPf3oiNkrFAkq04oUrNgo1Pp3E4BPGSY0SlTs4ZD/prxO?=
 =?iso-8859-1?Q?J+WFybUcFrMl9lc6KIBgSeNpkVa04zm55B3BEw5BkXX6UwY2DKxEoH7Qud?=
 =?iso-8859-1?Q?BduqXYTPgWCPivGIg+DpekMkm3lqpzV0CyvtFB/ZUUUf1MwdnRZKR85VQj?=
 =?iso-8859-1?Q?LD1SxnPnW2WwBHx/kwWOnzhfKVuX7VqRQFSAFYjiRjSflsClxuV/FGp1pv?=
 =?iso-8859-1?Q?HEvoISPmREwPpUyX9ciBxFwyP5TBbJBZuC+1iJFcygYz698A62d4CpoLDT?=
 =?iso-8859-1?Q?zn6nFlzgeLWvXiFTV+2XZJ17y1/ODVd4SlQ5wnuVv9qDk7inDEon4ZTyn5?=
 =?iso-8859-1?Q?hwIebKBO3BcET5wfU3myAB7q2Pu4jDJzJZRs12/m7qaLFLlU2FwLBKBDeQ?=
 =?iso-8859-1?Q?ojheNDIO950T1imcvV5uN7e7DIFkz4RP1e/nGKnjj7PijCmF/EllOcJYpr?=
 =?iso-8859-1?Q?0Nc8n8TQEOhfxURAO7CXWsq7ZaMI1+pajJUeuFprxdBpo+5NcRYlSx5fU5?=
 =?iso-8859-1?Q?CHreJZOCAfxzQpoYIagohreZrcoD/YylbU4vUGbAYAnMC7dXpG+1hmPsOI?=
 =?iso-8859-1?Q?trmYUOM4wgJB8Fn8Lyd1tJXrjiX93b+Xv/Iusz5elVwgBtDPFDE8DFrrud?=
 =?iso-8859-1?Q?uSN6MkhA2r5OuNBZ83uDq55frqHMSPNcaGIaBtoTvYf5vQ44PJ/3zP7DOS?=
 =?iso-8859-1?Q?r0UHSYIHhsrF8aebjBWuJhWDZbnkjlEK3Hcxky4kAkQstC0P+6W2B4ugbt?=
 =?iso-8859-1?Q?nUCBcaYjBuKVFXGVFTnkM1L1F6qkPQhS2e1I5HjTu+HHuo4TfN7Y1Fkcxb?=
 =?iso-8859-1?Q?4DqQNMk/eZGs4XUDmiU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c741e2db-247c-45fb-8a5c-08dc5f3cf86b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 00:17:45.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ErApO51/4IoIuua6QaswULwU4nmAytiGEyLvrgkYCf5UMSKU7VSV3inu2CGevPDLp5kabJitErSUGY2X/tLl77BtQddG0h9dQqsPHvWgCTdrhK+pNK7kVHp7QfS44dl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5355


Hi Geert

Thank you for the patch

> According to the hardware team, R-Car H3 ES1.0 and R-Car M3-W have a
> rare quirk where powering down the A3IR, A3VC, and A3VP power domains
> requires an extra delay of 1 =B5s.  So far upstream never handled that,
> but the BSP has a fix[1].  As support for R-Car H3 ES1.x was dropped in
> v6.4, only R-Car M3-W still needs to be handled.
>=20
> The BSP fix relies on hard-coded string comparisons of power domain
> names, and thus applies to all R-Car Gen3 SoCs (many introduced after
> the original fix was written) having domains with a matching name,
> whether they are affected or not.  Hence I took the opportunity to
> refactor the R-Car SYSC driver first, and came up with a less-intrusive
> fix.

For all patches

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Thank you for your help !!

Best regards
---
Renesas Electronics
Ph.D. Kuninori Morimoto

