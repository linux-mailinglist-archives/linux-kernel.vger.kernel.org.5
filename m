Return-Path: <linux-kernel+bounces-161659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993148B4F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8440FB218F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F37EB;
	Mon, 29 Apr 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T5vawU6P"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2023.outbound.protection.outlook.com [40.92.22.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCE7F;
	Mon, 29 Apr 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714352852; cv=fail; b=jEmlMjOD2bGY+4XT8lLCMeFpLruJqoAkZonVrCmk4btmFv7UTni4QxIysjTjRxCIYi0WhJeyDHAFVP14npI7yGzcQUZzCKaEB1kx/wsNZIXT9o8g+9M+7ZOyCZw5RC6MtiPLqf2vE3LmDjwtD5p9V7O1ms2M9q6jgE3EEzstV68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714352852; c=relaxed/simple;
	bh=y5E+DaArzWhMR1P4hkJVqRCinmoeEFArPLGN32J2D/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jJobMr5mwNsMbZDpWPwHUW6gem809U14zXWgBE70DbxiTHHmGmDRYXRrACcO/O9sP6fmygVS6Kt2LbH6EzYIGI8i6Iw2BDOR+kdYeYBHzxWmvTFN7YjrJydCGNqDGxNjik95gmECTRN1tAhut7IOIK8YG3xRhscg6l05DNYYXBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T5vawU6P; arc=fail smtp.client-ip=40.92.22.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMD6RBRKGmEGjHC1mptw0IC7QzrSJVRuPUSFSOA9fGCQygWmA2rQdH/62fNvYfOoV1ttLVC0vdliasyt8Su9FEPMK0LHyu7TihAYJBFD1ugM6QqLbmMHZj7WEJxlh1SR9rqK4toKYbhkMnuyEz6M6kPoqVY4HvcoBu5gbf8bae3oEMDq+IqwIyRPebQUzpF/9D5SfuZhjmsWC1AUg+ZnjYr0n5LWYlvD77BhjF7gr29hCYztMDTVwuwOaBX3PVIbjIn/1BBy/6NYo0JWtA/SyFcK7+Q3uPw1qAKappFGsjc25k+GncnAmL1aR8Z+UeJZrHjXscj7rUy4hQFhS+xYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taLvmoMeFn1Npj6IXehzMgj8+bFyx+ZBgrdvXSgnxjQ=;
 b=PA/Qw02qq0zTGIyoI28H2cums5oNgrv3l0M6jCMC833fPHMo8K4DExGn1P9dJVyVOeoVeZQxybA70Auz0xV6LSGM+NS5z4tAb/hKwMjOYb373JTohiJwLLUtOeA3uPR4SR0TZ2lyqkIW8FMruIb9Gg21EKShrhhu9ngA4DhokSUWwQsIPC4u8su0x5CZmKyj2AfTAXLy6K1EygA64BS4LEHVEu8/Y8YoAk9LA8NeNrT5jADLWU4pj0J5nACNoXBCAL4TSuEM7ahawmZ1LBs5BBovmVRYoPYRq2Q5tm6gLW0KLD+RLNBq2t4AJvwwuBD/IZ+odNow/CH8c1Rpq9fZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taLvmoMeFn1Npj6IXehzMgj8+bFyx+ZBgrdvXSgnxjQ=;
 b=T5vawU6PKajjkslNc6iUHIklxEMf+PVjER65QGdDr2wO8gYZL6/dPkR0aaV+nx6Cjkl+A80KVj/04aL5Ha3vy2GeSjqwtPg7c85ik1Xgo1u41PGWk5qB3f0SabiF3VJacEnq0Yh90gGD3gzEInV2JehuclkBCdX4GMlK+Xzfryr814t5N2DspL+7e5yqKkOguOy3mixyTA4+n7nux9YX/rf15BZFpDC4H7QMKiqbQeesPsGTHNxD1IdlntOYInoKXDIOiDHr7DJ4eLa2nDcpAMmBXL7n+MKGR2qSzJVvHpNO15EnA3NocbsVkSWgbf7jlCTPihm8073LKqN5GaV5Cg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7298.namprd20.prod.outlook.com (2603:10b6:408:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 01:07:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 01:07:28 +0000
Date: Mon, 29 Apr 2024 09:07:57 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: sophgo: add USB phy support for CV18XX
 series
Message-ID:
 <IA1PR20MB4953337B33CFC1FAF00766B7BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [UaEcXcZmrIIv/wX4zsoWNszLrB2/JalVVmFai2lN/9E=]
X-ClientProxiedBy: TYBP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::34) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <665uqyqlxtqvun2xp6g3cpv67ol7yhub4juqq3mhf24grw3ezu@w34o7njqnx3a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: be650667-ccca-402c-8177-08dc67e8bcc8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	3AjTkf5FXnjuT7+DHgU+RH9x4TE37sRJjOZ+KEl1nksGLn8EkNzqKFT/NnYpJoALUl22N1HBSFQsUvgEfJV/8wdhQ0SbQNn4UUZ23YGOg2v1M1GsIeYYP0NlZvcDbP0g/pyMC/i9oJE991tMoL8ttER7GT3UKOaqCuCnJZQMQ+OgqgxpjiBPThLxKMiJTZtgITZGGvGMSe3hLvB0Ggqtc2bEmQYZB+3TsePjypxoOH5hEFgFXHtIw67fJiShJfF5mWLsAFpSBn1XCbP8w3LJ8hYMsgQdw1F+Lq0IHv7cyOVL3JMTQLtQyqt7mCnkiUnYsxuSo/LIum42CK2hQO6/EhBsTi/mDBK0w8MOvRguVWrdQDOo9UJ0BzAUfWCkStBbC5kBxF9Lb03TFEI4gp7PrGDKXDbke/ysUrg48kSTVTly2KOwkbO/ErnhmD6IWm4gY28y1DsLLcpMF04L5AaRbyQBqNJY/G2QjlwZ9gYmqNQr78fMj7HNd8bve7qxkzMbj7hZiGC3yjbttdG6OmgmD+EpkTN26OMqXRZ/z10W9NDeQ92TJFhyMKpN922uV4oJiiFOt3GNEMWvjIzGqH0G+mD+NAHmySkPzcDDiz8z1NT2Gg1hZYSVRkkhakB+KRShVjEqSw3yBTroyjyGu7+vR/vKxMLqxUEmHkfEFKlOUqUZPHAcVUJQpwlWO+0qPn7I
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/0cdFp0obFN0rDzfv3NDTvaqJ0ApVuXH7+Funic9nM81L7ze9zCfLXL6XVv?=
 =?us-ascii?Q?kQHOkzWFwFxl79gD/fDA/wG+4NJ9wIoMEZNLopALInYcEXrRjNFfUdaLfhdH?=
 =?us-ascii?Q?F1iI8TtpjE9XfDQ5sAiEYgg6f380P8aKZWdJUp6sd3mc8W4GaqT3BsikmyRt?=
 =?us-ascii?Q?aIS498OX88fHIEo2z+9YtRD/u94Fwd+VaD82Y3ElPWKRkT/Bq+0o7hHemXwc?=
 =?us-ascii?Q?h9+kMaQn8JTDEbMdvTSxMJmnTckfMEVsydp/q0Vr/eROIHD9ZnVvN9iSoq0I?=
 =?us-ascii?Q?btUii1xm2pQxChUOsSo/NH/ZAY9hJRS1qxZ6W1wpPpDrsMjm1ouASgEZTfnJ?=
 =?us-ascii?Q?7x2L5ZyqWuo17+CY22b+//qhnvmbn1Krd8XP8QRD/KQPBQ5U8qxjO/mj2ScU?=
 =?us-ascii?Q?o3uzVDuNNyP9raHza+ioBtL42a7nh6CTqA3Sz/KuT6TI5R8qiD/kFovaYzde?=
 =?us-ascii?Q?ZSJ9O79va8KM5rKHym2Mzz6YaNv0gKvLyZwSltwwBwCwNoe2uj+Hu3rO3eiJ?=
 =?us-ascii?Q?1GEv22L/DN38AEEzIhoJmlwRfuWanaG4cjN7MowPc8/y6YwYWyWnjga/fDET?=
 =?us-ascii?Q?0wtMzI5Wk1Y563QQjkCLuSSd1GH72KXxuqmEMzdByDdZpkDK5lYVwFXWEfuR?=
 =?us-ascii?Q?ciVxVajMKC7nzQ7RyDDd+qeWN+Vf/62sxrAPGlf/luzO8DynVTn+xxyRNBCu?=
 =?us-ascii?Q?T0D/yr8eJZiMF+9Z5l7t/kbX5xdGr2IMcLx9ClxGLlbi2LQrMb2odYOq8HH/?=
 =?us-ascii?Q?rhwlmWb61IkDXv4cy5W3oYhGom4LmwkeZ3l/9licT+nkFLpzDQAtz3Micz72?=
 =?us-ascii?Q?G2nhmZk4rbAvSYvmqD+H/98yyfwdhm8pAU8bJXtdvNkRTsIPJb5nA9BWj7NB?=
 =?us-ascii?Q?oPeSroZKXI5lq0wl7U5MT8iIo+FFN2YJZczozs6+tEgeNy+qjEtB3j5g/z6Q?=
 =?us-ascii?Q?L/h99Rj1l/YPjoWfK74plv8Ftv2uC+V4vNBjpwIyIy+nFPU5dZ7IcJnMg70i?=
 =?us-ascii?Q?lXhJwJNQOvmFLpFaP0qCgMe1pLcUQvJV6B/Fz+6cibD54wCba+hpOKDjss3L?=
 =?us-ascii?Q?n0+vcnHZGsJ53d0cUCbgDI21Dh4s4OfiRvN7LrBk3kLuCIMkWNwDrmDbQtKT?=
 =?us-ascii?Q?vs6LSBqOBRADur7Rd8op1zo+TwhBJ2x3ORU0qGd9mD/wYqI7PoLiZApRuT9I?=
 =?us-ascii?Q?GPAQaqIYJjQQA/dyKmas687VvG5jK7kA7QqrJ8HiOYYcyo2YoAp+IjDd77h8?=
 =?us-ascii?Q?aOQiKNnNa0bqC1G/p+g8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be650667-ccca-402c-8177-08dc67e8bcc8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 01:07:27.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7298

On Mon, Apr 29, 2024 at 08:30:23AM GMT, Inochi Amaoto wrote:
> Add USB PHY support for CV18XX/SG200X series
> 
> Changed from v1:
> 1. remove dr_mode property and use default mode instead.
> 2. improve the description of `vbus_det-gpios` and `sophgo,switch-gpios`
> 
> Inochi Amaoto (2):
>   dt-bindings: phy: Add Sophgo CV1800 USB phy
>   phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
> 
>  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   |  68 ++++
>  drivers/phy/Kconfig                           |   1 +
>  drivers/phy/Makefile                          |   1 +
>  drivers/phy/sophgo/Kconfig                    |  19 +
>  drivers/phy/sophgo/Makefile                   |   2 +
>  drivers/phy/sophgo/phy-cv1800-usb.c           | 378 ++++++++++++++++++
>  6 files changed, 469 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
>  create mode 100644 drivers/phy/sophgo/Kconfig
>  create mode 100644 drivers/phy/sophgo/Makefile
>  create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c
> 
> --
> 2.44.0
> 
On Fri, Apr 12, 2024 at 03:21:26PM +0800, Inochi Amaoto wrote:
> Add USB PHY support for CV18XX/SG200X series
>
> Inochi Amaoto (2):
>   dt-bindings: phy: Add Sophgo CV1800 USB phy
>   phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
>

Sorry for forgetting to mention the depends patch again:
https://lore.kernel.org/all/IA1PR20MB4953BAA0F8E06CB202C5C2FBBB062@IA1PR20MB4953.namprd20.prod.outlook.com/

