Return-Path: <linux-kernel+bounces-96480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E7875CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1881F21ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69262C1AF;
	Fri,  8 Mar 2024 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jP4H2k0E"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FB23741;
	Fri,  8 Mar 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868653; cv=fail; b=nIAS1jpCWhxHWNHDhz9a+p5bpjvMcm9MF2ds2DK4k7P4P812s/w0mRbb44aKFTI1mibS5FMXnWOlJ88UCOB+GJcNNugzXN3LXawY97sOWz3NoRpbiVY9Oo33RDLX7+Nu1i0UjVynqALLHEJznzsWtOKCR9hir4uRcv2pbvIMw80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868653; c=relaxed/simple;
	bh=JOhRAKj4fvw62eeCqYbycvjXxKdzYlXUQURf0gwWxOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FKES2rI4drFLyFXQw1MIY6tV1MWWZYhX2HysvskT16hm8upTsSNyb9f0XZ6AsRgWdC0R/e6oA5FYfHxN8lOa3ISqJBWPsPtj/5itasvAl5lJLFu5YHyk9wIFekS2gSZDveS6fWBHLBfYNhtDDO9FVPkExDxRS2X1KoqOQzbyGVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jP4H2k0E; arc=fail smtp.client-ip=40.107.104.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSvZZWlKa/xgVd6a8eByfHuIWeZrR/t5avWJnESe6b+qzH3yXgErzXEdI/dOTxMX1O6B7WYWg42s6S6RC3a5n7Cq2XQvW8/SRam/xFWp3nj38rDYmvzIIIzB4LPkOAkWfr6lnmFf0hhoHbpRGgt+v4Ou8AWeRiuwck1qWrsnMiK5HvLvDLrCZQuFzManj8fi3pkeLkg4TBL8oiVHI82GOlmZ9PtxbWpnRNPPlKYbZRhx2cA6SRTvhQSJvO4pzAAlJzkmMFb6ioG8lk0BqZ9Ja4OineCOJvMR0iR0T0WQ8U6sVmzcvyGkonUD4CN02bJvkPZ66QiTjm2cTLivFDuFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOhRAKj4fvw62eeCqYbycvjXxKdzYlXUQURf0gwWxOk=;
 b=NLfMLAbNNfIEnkcwCQ62oyEribJG5PpsRD4iic/M3ab7FzxyoO6urv7JQ3qDGzaW9ZlVnMXiMDIbigzlWL3Wnst5+UgduCiANYXJJyPZMMDs2uNi6NLlJ42byQOoScgd0uKVkWadfzo1/hwSHEmNEXyIXDA67hGexX8qI8m9dGc/QHfppjdP6+gTrQY74B9sM1yMaun9Ml4RchpOewaxoqExApMpdP2YCJwmFTQ8c3HTOlQWTDZY4XipR/QvT7tZOdTfwvwS8969V7luYhNLr5juDyjy2yUeZP3ujDiHCQyqELDLxuZOQsoJQE66wZtYezpRK3yt3gtkxzv3MQvRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOhRAKj4fvw62eeCqYbycvjXxKdzYlXUQURf0gwWxOk=;
 b=jP4H2k0ERjGzm8ibSXAfcE6tdX2B3PjSJ79EiAqrJjWxUUm/7m5MnSj911AXxZVvhnZSOUrYE/JXSxoLlPB7DTVOxXnjv2nQvYCLTlDpsHGOvrw9IbbQAkhnoKU5Xk7dOgGBFCApIQqsnl0LoatSbGBu92N7l8XyBO5oQfHohUw=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 03:30:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 03:30:48 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: John Garry <john.g.garry@oracle.com>, Frank Li <frank.li@nxp.com>,
	"will@kernel.org" <will@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "irogers@google.com"
	<irogers@google.com>
CC: "mike.leach@linaro.org" <mike.leach@linaro.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v6 7/7] perf vendor events arm64:: Add i.MX95
 DDR Performance Monitor metrics
Thread-Topic: [EXT] Re: [PATCH v6 7/7] perf vendor events arm64:: Add i.MX95
 DDR Performance Monitor metrics
Thread-Index: AQHacHX0/LKKJL0xVUmo1xu3gKBTp7EsPmsAgADyYtA=
Date: Fri, 8 Mar 2024 03:30:48 +0000
Message-ID:
 <DU2PR04MB8822853B582D2FD295E4D0DB8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-7-xu.yang_2@nxp.com>
 <85ffb1f4-75d9-4ac5-9be4-9f80b122679d@oracle.com>
In-Reply-To: <85ffb1f4-75d9-4ac5-9be4-9f80b122679d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DU2PR04MB8552:EE_
x-ms-office365-filtering-correlation-id: 84e933d5-ca2b-41d1-0f79-08dc3f2025de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qVADTMFTNrAS3Ha8fxW7IMPA1IhUMENPKMOcskfGDfs4VFuhfJ6ecJRhyklN3wCd22MNhmH6c2eWuzHBwoKgFrln8U+Kio2bW6HdxqQJQlYiv2J7yY0b7GSkqYAovYFo523pgEmr0HL0ijq8uNUKkFodxiTE3m0ucsHv4+1KgZDsa/DzyjjbMcY286TmAB0aSszvtoH+UuF5FfoTscRBvKoALveHmzPU1s2rKRXcI9bvKaLfsM1ty+OeS1DqBDjHCC7iEzNot5YIdH0LbTdWZ0NzPi/j/VvJYieLMVqWnB0OTkswIY4TTqAT6JCJAscDgyZaFyfntUvM7wmeoerWAa4psGQZcySorq4rFHW4I/jcqU8tRZKlA89qLooSgv1B4qEz8RaCgJi6HnS8uM7Ca2sbSdjLAgjPW0IEl0h12KP+mWSHqFdfqL3UWFC75cKeK73k5PB+MK6vnVZrHRJgplr5sIaxvSyFtT8POEpE2RzUoVh8RnE/NORIx72vnXbr3btk6k06KBBIYqHI+HMQaDSR0O1Hb4wqRKBZUiBMOe2u0TqzM9UvsilSYp/VSnsDP2BPAVhdy0B6cT1MQGZiOed2bvYFisllNmSJN6NB3sQYeQ2sTD9CdzNqAJX7g76Xff8iAgIuxWY1tWIpEeCVOTc2DSU4tTN+3cunSK8B625GDBNY7CCMIbE6uslE87UvLRhH8UhB42xexp/DdBfa3uFdncl5CLNRXx4NXb8yza8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BnUvjlOBgs0hMGYw3PIrXt6j7zPHnJ52tm/pgVlSwpo362cWEOuW6UPjBL9b?=
 =?us-ascii?Q?wLTwdZAxgnajJArkRr+HI0fp9N5r4EhhIvcHpFwauxvnYDDISqWOhMx7dWdJ?=
 =?us-ascii?Q?DDS05xJUswet6UgduhfN20BcYLMl3e3V4dtvrcuqkYEbGsXn4fy1hJR+B4xc?=
 =?us-ascii?Q?9h5JnRlD8tnbRFbe/GtD/iPUthRbl2YX0o44J+cGfOBZJ2eFbyNInhZt9LUv?=
 =?us-ascii?Q?QtSJ5ztFyLtRmIVKkvpuE0QkTXaXwBzOqoBH/fNbwPkRfk6IczjeBaGwghs6?=
 =?us-ascii?Q?XyTT/O+AecsooTzfa7y/qoGXQl3FWPbeKAWezDZBU52O4kgK/DzNkp0mPaPQ?=
 =?us-ascii?Q?rAw5lu9X0gSsYYDypE+j49bvs+X9bGE9mew4RkN2p5xuvhq/6BvIPGEJHWJI?=
 =?us-ascii?Q?1Y1xizi1fgESgIf3oFWAcAi/I4mG6lK2nrVBeb3jbbLYyF49RyZ42Sm4PgQm?=
 =?us-ascii?Q?26ge8iikgy6dDJPjLRVb0HZUqaB9E1fOfvt7vDXcpYgbP+QSfnkaWaHuyKl+?=
 =?us-ascii?Q?RaazIdwGyiUi60HQjs9/15Dvmy+ntyJCABkt6ujqXmK7R+JKObT8uXknww0Y?=
 =?us-ascii?Q?434WtRMeUQnYbyDm57iO74uUPAJJFmpbAOVbHdwqH6CZFpyyhEFU377fNeoX?=
 =?us-ascii?Q?leIxWyqAlDEIzU2ahVeCni9wBLkhgy6iX60HWV+Q/x1PFa46Ygm3wXZyrnaS?=
 =?us-ascii?Q?g/oRRHFHyIdlarhyhXuE2UCUhDXDR8yTMZ9RcWYmmrfytrP9xtJJWLT+chC4?=
 =?us-ascii?Q?g8julBcU4mOtd4mT1OHbZB0WJuSZKQjHETKv0/jQCNzVbpMy/gEMQslFnvf0?=
 =?us-ascii?Q?zBKijOVuRuXMt1V8+0/bn6X5japPQk3qQxw+4DtcZ+xc61cYEYFSH09/E2Ei?=
 =?us-ascii?Q?k3zTFqhTAEda8TVXnQGjahbSotJ/TSRFgoTU09XW3ahXLZ0e+D/0VVbrz3Cc?=
 =?us-ascii?Q?9TVKwAuuqqjfJJGaU68XzcssJtmrIf1RRg7BTiZj3ktSoMG/Buo6jJMJKdQl?=
 =?us-ascii?Q?/4Bz0LmbguRtP81QXBnDEp065Cos2A07byNkzVB1B+kg8OUcZBOHkwzIOkGW?=
 =?us-ascii?Q?eQkdLNJxDnfuC2ix+AJqc1XGSJPiz0KGxMss9EAxK378sEHZZ0Di421yOoLM?=
 =?us-ascii?Q?dvDUrUsdT6ptBq2dDrnja5aTGjYvSeczkEQYaOuJbY9PejRKSd6jE20O8uhv?=
 =?us-ascii?Q?9nno6GE+I9XdT9juw09w9iDXAHiTVUNWFh9Q02bESacEaPP6cWrAyjjffgtd?=
 =?us-ascii?Q?qePZwIGwhSCpDC0L/C1eNIzxZfJWHuwzCMnqXCTI4xU3uLuHsggSRVZiN7wn?=
 =?us-ascii?Q?yZuSJ/hyFk2gbZSvk/L7GZRpEN2Wiv79N/xoVK5uSggsa3UWQ9X+YyjXZpbS?=
 =?us-ascii?Q?JlS7rdU9txrLyMakevNg5+cqfqIHCPmrwcsbtftpqZQb7HQNdJaPQbQeAwZ+?=
 =?us-ascii?Q?Kn3l4ZxrkaGsui8aGtVby474O9KrQGBSQ4CIj0pbYzgjeJNBO5XR4GuEk6y9?=
 =?us-ascii?Q?RnxHZCQYniwdgg67+M+yzIq7tCoL0TX3VvIzgC0kqJJfgWjwqci79COitg6l?=
 =?us-ascii?Q?MjySz72Vt20k5i12yiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e933d5-ca2b-41d1-0f79-08dc3f2025de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 03:30:48.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxGZLP8+VlLTsEAB67vGvqIg1UvAWfp6DxCCzM944CsjjAbCKIVBpNvoHhZaj6ExCfoBh+3/yE47M8yK7K9hNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

Hi John,

>=20
> On 07/03/2024 09:57, Xu Yang wrote:
> > Add JSON metrics for i.MX95 DDR Performance Monitor.
> >
> > Reviewed-by: Ian Rogers<irogers@google.com>
> > Reviewed-by: Frank Li<Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang<xu.yang_2@nxp.com>
>=20
> FWIW, Please note that I gave a RB tag here:

Sorry, I forgot this. Will add this RB tag in next version.

Thanks,
Xu Yang


