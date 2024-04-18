Return-Path: <linux-kernel+bounces-150388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377248A9E50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CFD282E71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0F16C69B;
	Thu, 18 Apr 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DnHFHmYs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2090.outbound.protection.outlook.com [40.92.18.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB5161935;
	Thu, 18 Apr 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453952; cv=fail; b=qLlRmZ+Kem/QRXN0WgblmDpW6QMQWJu+NUtAMPGavsLz7Ts3YIAZ2qajpSlfH1Vw+1IfFHeMkp/e1jfgx8dBF52q6dkocvSXKUJ+Jp/9byxmARkBOj9nBIJo5a2ZpiWIeyxYqciYBHDVhXXywVG0ziI0K1ldCMkX+PsTziCTBWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453952; c=relaxed/simple;
	bh=k1NuydLhAUmibwDMxM6bSHmVgSD8ZulZDnS5kKChrbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pJ6V77pWqM7xpELQqn0Mn86TXjp6XCcBBRfnOH9kAjcfaImUo6HVeksORm75kLhryO5X5PzBzSmePWgQieQIyGLIGgoR1njA5Aqwq4sBASMU3pt84G/wPuWbleA+F0dnEsPUkKBaFDc4IXUX+thcgdpVgfdYIAbm+zKgaFF1M6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DnHFHmYs; arc=fail smtp.client-ip=40.92.18.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQlwY28pSxH+38t0/u8r/VWqkCTmtli1zmJvrovVVdK5H5QmkEWDdxiMV6xrVhTzHdiuhUd5FH9qljydnej4iSReiDEyWl35UY7jU12ZyzyAe48AD6/yLR+exZ6Z4byikg7HeTt0NVvF+BiwEfvFrQtSHJwlmAu5BUMgobQWQ12JuAmGpdUlg8l2ZvJ8HuGMyzl7Kff2U2Y2nGOgYNJO9hDYPBUj4xkWVdeg/RW96+X28uHKESfCIEy05TyIfY+e4k0Y50Jh6RNtHAYM3D8EWnvhShlnHOukL49wxjLxN4nYdTmwDUNNGtbBKGiMaUkNPMMiGRWWno4GMjSZG9obew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkdL7xjz4aO/iybJ8lM/saFQhcff1yi/wIEEydrW44g=;
 b=HNrhUNXrfeLzVccXed6xVg3q8PPYGwah5Q6sTxDhaCzRtd+noPKd74rgjbdm5hmmaf6Co86wO5F/uwg7nFxMn74wsfHkFMkqoUJKLmv9a+0kfTChWLR3GQA1zH1V/7Iv5PPoFpadx0OX0viVDWyl/aQW6rtLRj6WaJD/1i5jszaMvPllqLALbmpL5sNJarH+WmBqiRcJ8nTri0sv3fekek2F2NsgAROTj3xymh9I1TKSboK4qsxTK1BX6DWa36CqkpGp8b3FhvcPob/+v5807nR5cq4ysGFlmfSUtSorkGaKzYAjeFxrGMF4ScjDNg420IfvjQZATUCIKwqyUxxdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkdL7xjz4aO/iybJ8lM/saFQhcff1yi/wIEEydrW44g=;
 b=DnHFHmYsXH/2iqIGvEHQBqw8B+Ku8/vbjk8iFtEM2s2r+LgkqL3TuhOsi7iqp9/KyQNouCPSal9r3hKutcnmjsoFSu6PdnZib7cyPKgZdDmoEmpzIDgN/jJL7YILWw19uXJkDxkOW9aTfdKpkdm4HLE5pYzwz8J3lZQfsIOzvcfVVvAmjlz2Qy1kFNes6nPwIbeTLCA/beqbGNQOM8ekbD+TakTFKnMu1KawFs3St95kNSkFrRf6gJmk8se7mR821Q3TfoFbARx0UH2+YZWQw8ys58eAbbDAiTcOzvyKYwPp9hfQXBsKYDBNbQbPOD1sQPilkVhcgLTjkVF4cFsZkw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYYPR02MB9927.namprd02.prod.outlook.com (2603:10b6:930:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 15:25:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 15:25:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "petr@tesarici.cz" <petr@tesarici.cz>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Topic: [PATCH 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Index: AQHakZfceiYYTi0lC0K56jdO8yuO3rFuFjoAgAAPoyA=
Date: Thu, 18 Apr 2024 15:25:47 +0000
Message-ID:
 <SN6PR02MB415745AA09BE9E468001EFBED40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240418135213.426671-1-mhklinux@outlook.com>
 <ZiEuGIoa-FCE0p4X@casper.infradead.org>
In-Reply-To: <ZiEuGIoa-FCE0p4X@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [cy1y2jeAaiWiOMVLoqpRcDSLQBMqTkn2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYYPR02MB9927:EE_
x-ms-office365-filtering-correlation-id: 20262499-b887-4229-d8e6-08dc5fbbd2be
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ax6Eb/JSVNu6zWHB32KzAcs7/8sijf767Agd0UnTeasepHWg7VjLEOwZ3Qie27BbdCwzL45YUJHNBur5GTOwUsJq0vHRdIQdd56ExJgO4uqgwUWfYzf+IcORiOvGjyolTMf5cEH3dYRaktdaeU2tf/jKg65AJiHLxGzVnlcJCAreZMOjHgiEROTcA0ces/UDOpc0k5+k021TXGoWcbMJcj2wMBnf9/juAJ3IGMVqcNsHui5ciN8iWItVbWz/4rh17NtWxLwh+RpUCDJluV00AqwjuxuGr/h6VHE5AcOI/bWBW4xTjSwrAPx43m+OsqW1MkFC8k7hovO6iqMyPZ8P1SSO9yWQBYQk7W3KT1SZpdVtdB3AlvBM4hJKSm7h0g+PG68NwrXT7mSBWRpNAJzV7lwlVzOPzufTG7lpWK++gOUmzAc8mSWpYlY8iCOFLpEqQMiUAeMm7KI4nJXVglbX7E3jP4i6BRumDck45VpgbGMsd8IpQAz+O9aMrWI/B4Q4XbeFOYHa2Z8Mz1xPjh7VSJCNJA1Fb0tMxYl8DhfLNP8riqq6lDSGgRzPA66ObHrk
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+cuhHkOkQS/whAb1sFtEJZzhks9OAW+a0rBNDYQxP6RRBMeRdNB5J+Kn1nKj?=
 =?us-ascii?Q?dQz82SqkEFGfKJAWj72WzWQ5Wqglvm2pHxQ80l2GukK6Tzp9Gg3rQIu6Qw0b?=
 =?us-ascii?Q?F4lpKnDaLgeACCpQtUvqn0DQsfSznz3wcILwnplLW6D/j72osxSBX1Ek3wDw?=
 =?us-ascii?Q?XeYWS+IIh0nQyA67LPRctbjHtV/KItQ7+2qGJxRA8DSpixx5yq0dPR46FTa0?=
 =?us-ascii?Q?DFcotffYtC7ubNF/OYwDCwX2TJYLoJQ3Vkr2ieuz8K9THm8yq6keMpPjTwBJ?=
 =?us-ascii?Q?kwqy//4n/pPZalOdGAMNogsELitGdPwlRKn5w4dDlxHGnhWpXQX+pNGE31og?=
 =?us-ascii?Q?+0tc9c/q2b6eQzvhTWOrswlSbfa0mrkvV4sWBjI/zn39Nd5mY0nUnpKkpL85?=
 =?us-ascii?Q?cAqgYnARFp92bj5A62HKbp56DIkHzKBHJ5qZ37hdaLUnuOstxKBhERuNSwtG?=
 =?us-ascii?Q?fwKuVpyqt54q51OIbhq/fqtc0D+gQq97CkdCH9gtUACg4g0YwUp2lQiDzLJo?=
 =?us-ascii?Q?PY+l07JgAwG0gikb0zd8MOzKEFTCIA+V338Kk/3RT7WvFe10P/rk5UOyRpxh?=
 =?us-ascii?Q?254NbJm4Uk3ZS/hMh6s37iquq26kV7+YLzXCcEYSvT2bdj7tfeaPe+ITy9UD?=
 =?us-ascii?Q?vUhZc9PyzwlybWeuMAmGBu648VHl9mItBwlGFBHpFJNmgy4E9UdtAD4aa0ej?=
 =?us-ascii?Q?ykDvU7dJzmWDy45y1tdUY/h9BZ5f6hkm7GR29P0ON257w0tVEqW5vrz3gH4h?=
 =?us-ascii?Q?K/qsA0Jz7VVZeWH6duhd4bJ5wzuB3SywQIe5041PF+Awj3jbxOMoQN7zfVBR?=
 =?us-ascii?Q?i+79U0+7se71fRt6kpyKFOdz5cO7aqgjRtHgO18CUGBz90/IEdDhW3hAMIHR?=
 =?us-ascii?Q?u8R4PFtXt2qune0wAT3AOMmOy3ZmIGZMDO2A3zTSi+8UpCM95KCNi092caCp?=
 =?us-ascii?Q?lZlCoTDzvPygv2JgAsp+ZBegIDj5CcWK+tb5/0nSO/cQ1rYE6HP/OUq4h/gP?=
 =?us-ascii?Q?cCRPZkvGe8/7y5NNc4JQhMZ6Xd7MZX7Wb7CB7giL70wkwsH3zTg1wjoa06z8?=
 =?us-ascii?Q?8x34KwxMq/be+pG4jsbVrT4H2bJdkImo6txeR+KzUPlkX5BlKx2Z6FgU3RVg?=
 =?us-ascii?Q?EhaDe/RKPHCLe0SuoRcVXao2I08oywaBlysl+HnwsclWKiolq40zwvBoo9wC?=
 =?us-ascii?Q?R2Qg5vR36C07kd6Ll2WyqHSxOIFKiBEWP1ZVDw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 20262499-b887-4229-d8e6-08dc5fbbd2be
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 15:25:47.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9927

From: Matthew Wilcox <willy@infradead.org> Sent: Thursday, April 18, 2024 7=
:29 AM

>=20
> On Thu, Apr 18, 2024 at 06:52:13AM -0700, mhkelley58@gmail.com wrote:
> > There's currently no documentation for the swiotlb. Add documentation
> > describing usage scenarios, the key APIs, and implementation details.
> > Group the new documentation with other DMA-related documentation.
>=20
> This is really well written.  Thank you.  One minor nit below.
>=20
> > +Usage Scenarios
> > +---------------
> > +The swiotlb was originally created to handle DMA for devices
> > +with addressing limitations. As physical memory sizes grew
> > +beyond 4 Gbytes, some devices could only provide 32-bit DMA
> > +addresses. By allocating bounce buffer memory below the 4 Gbyte
>=20
> I'd prefer GiB to Gbytes; we might also prefer GB, Gigabyte or Gibibyte,
> but Gbytes seems wrong.

Good point.  I'll update sizes throughout to use the correct terminology.

Michael

>=20
> You've written a lot here, and I'm not an expert on swiommu, but nothing
> else leapt out at me.

