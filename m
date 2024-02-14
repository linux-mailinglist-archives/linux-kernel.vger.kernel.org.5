Return-Path: <linux-kernel+bounces-64784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204318542CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA77828895B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A511183;
	Wed, 14 Feb 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g37vhshL"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2022.outbound.protection.outlook.com [40.92.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5C29A2;
	Wed, 14 Feb 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892351; cv=fail; b=MA69GP9PmEwpqxSoT35K4NGnFxEahQyYgx1hz6uRd97qZbql+lmABvfoWYoqQVDx2Trf8OZjPMu0vk0DoyITcLna+e/tjgYfZTmp0+H7F9hhk25d5Dk1D805IsTizdncoQbc3sUEvbGUNgKCQ4BmeIdW86lF1pksPJtG7cAYinM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892351; c=relaxed/simple;
	bh=MZXCi8HkuDSXLbNfZjGcrm/1J+XoJSj8/n3KCxDKVOg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aVKjk/GFS5kI9Auxnfo45umKHatPPMR7Txc1cqMaaLGpHSjfteN0KHDhwmPEhRT4u/81uA2HqCk87y+m1KXU5PqtBS39uPV9nvf54KLATG9O7YyE9HR92Rjj7Wwvc2oskVprMUP3oTSaQozg0h1Cz49AGKmADKteMmYe1Om6QeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g37vhshL; arc=fail smtp.client-ip=40.92.46.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNr/u6XLH3RPdTBcNO/2cIMzaNIQOrQ7y1vgIH65psxI0G92X5t0/vNU9eTxBhJ4pHYapem8E0RAUTpCRZURTE5nI1HrIReWVG7pdKl0JDUmdyIUeMSSjmSUnc/Y3RYNHwmzgQT+xAmZd0neluwHTsNK/0/HYEArVrThlQ3C5QBkLag1OCHco+jVG04IMgomZUcl4sLKioiCLwJ5ozou1pvhWaybgMqqsLeQ94BRgZaVnvOKKQ6KR03bY8o8h8jEcL/PS/BydbZHFSXl0S3XpwfOlzNUsATEG7IHronnCxiwbU/uI+FxS9QOKTudfq49IdoYSkREsqiyBBeWO0KQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nNVde7Rlv1C2AbEyQWe1VgOjhB7kc5jISoOHGVvmN8=;
 b=QnsRgrilH67E0iSDRZgw6CGGVzFwYUSlD4UO3jCzH0fxP1LMBM/DWG0ROKrpg8jKfEIyHtZdiJ37a64ehQM8hAIdne2/nLKWYDtSR8UDZ8kQJ9TunqFdrXgx/Y2QL0I+HTLFbHkBdUBQDISteFUkdcUe7IzKGWiBUDDDewGxzx93Hl1YVimqTYNvPv3dJj09H1FB2iI7gQdZ6CyhB3yuwqHitNmqra1MLAqtRXirXj+8J9fJgMmGOW9BbEOT9c1O0soYDr+Qd2Q8wbmnrYoHVbYp2EVkOKvmysmHdiELAGi398JBMGChfgxAsqaiTsLNjXxLhEA96/hyDImWNOiW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nNVde7Rlv1C2AbEyQWe1VgOjhB7kc5jISoOHGVvmN8=;
 b=g37vhshLIG4quB2b+id7Fig1Zf6+nt5opvODiVrD7Og3SqCwl/w/7aIx6rtnEVNxU08/8COVsVqpXbQmzrCgWC9ag8IHeS36fsCKnkvkvoFlJ2reJ+BeRmuFJj64vnJisPwE98IrJop9q7TdRGi/Rewg2nGxs4r/zE48nhYajOqCyUBfsE9Qfs13MaUbbGgBESn3g5pRLV7IF/7AMDZiF3Fhha+Av5kJsQlfb37+8giNxRbTZNKK5WCsape03QbOWFvKmt5u+MMtytzvD+wkGDJU/IN+0UMyRaW+TDfdA7dcnmY+PR/PdfHU379tnIkAiPp2dlxK4rYGrf36+elzfQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by DM4PR20MB5063.namprd20.prod.outlook.com (2603:10b6:8:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 06:32:27 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 06:32:27 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/2] riscv: sophgo: cv18xx: add top misc system controller
Date: Wed, 14 Feb 2024 14:32:28 +0800
Message-ID:
 <PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AZZxIpocySHQ/0+OkZE3JvJLF0tEF/KelIANr+ibskPbUAAnahLVTf6GS2vde8zO]
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240214063231.435079-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|DM4PR20MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 0baedb0e-ffe8-4fde-339e-08dc2d26b65e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vHEXCP/uVLZsW2If+PqXDrI5XM6Zt3OeL7gS6ZrY3umcCn7XqbAPqppWzGElKj95Q647MfgVG9zhmKx2pG+7TVTAbI44eiGabBkXDr2Faao16E9AYZM0v62Ecr8NkVziO4/1Vhh9AmBc3fp/1FYNoptLhOwBJKLigH2piVVRHrw+KH3iHEigHvP3Rt5IihqpyPweY2bUuvtdzy1XpinwYdjxnV8T6RpEomQMM+XUIO+rHw9x7MoHhjrDil3P0DjQ6H9eEZy9rTjF0dTbDgRraM3XTRnEzI44oRNclORsQQWsWVb/5Ju7zROH4rQl6Z6HrfBhMjm1U3scLXdqP2xc8ESRoGpIaV7N9iz2YgMWY1LQewdQkLvvAGvcjpM7kSAdMO7dM/VH26/5Q0ykq7A9zCw2aIM1s8jTLwU8BU0K/nvrbwJuwv3vR2Y4DZgHw8Kp7n/D1JfAKu356mX6VpzSJZ8Zs046JO+ADI1x07X+kYE4ir629oj2W4u3DhEaLeibcmAg6zSUVQs9RIEWkSbWoFqIM9grUKVKAoLr3Hf0xlMVe96jpYBMBzxvuonbpOS2TfOzz4dMLFv9DogY1Lxic1phwrFEOhm8YFgRiSvM0FkOqAK6F2lMMvagUiwB++2j
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5yOCGShiWcWf02z1iWJg/byxexJVUAt+VWw8w8azWS7a0d3Xsh3i0g5rcE2?=
 =?us-ascii?Q?z6aynzDfziaupzuzMAwKjJzUDKoTra25rBrkdvdA++7bLGvCOuu6W/vDK5S1?=
 =?us-ascii?Q?jRi8nTssZ8hOt9afsYPxJk4XLlYIYoh0fuObPn9VlRfM3RwBzNYVz52tu/TU?=
 =?us-ascii?Q?vUEjy3BVAbhFfHmWlbtkZPlnOx9tNdSmC9nC4dYytlZbayXe/qvjHSbJh5Zk?=
 =?us-ascii?Q?/dmJ4U3lxjgv7rmwfYl7nZpPcG0nM77rH+goGE10TWz5GcdWjZLgt2sH47Ce?=
 =?us-ascii?Q?7pk9Bz+CvMYmNiU2uYiOTQhX8u0S3MGKzjdZTWI+WO8UV137/vdAgHdOa8U9?=
 =?us-ascii?Q?9TvdWsblDnr3p7q2PLMdQNVfo1l0J68FtFHxC7kHb0lt3jr+bti+x7evdaNV?=
 =?us-ascii?Q?1sAsgLWhcQM6OsGYDKw7dLmlQmwyPLhXoaN6eZZGjSR5GjQL4N/VebXXd0j2?=
 =?us-ascii?Q?5Ke1RJyWh4JmdAbAV/SBOv818o2r/MXiLqIgew5D1d2rPmEPajvbTbrIEyuy?=
 =?us-ascii?Q?jOO0xkFIpbFUILKb+IlfVJXLoYN1pQ9Q1rB6yZLraJzJtw/9TKu2yciaeQaS?=
 =?us-ascii?Q?gST2HLdtHUboed2MR9WmZ5mt5xErU+PAvr+G+3FWYeiJ0PznRDLE+YldK40J?=
 =?us-ascii?Q?139Ngpc9amCDRqBHCd9iVB3AhscrCj4Cr5gs1n4ryxn8qb8w0wHaQbGF0/nP?=
 =?us-ascii?Q?c2cHzWrufVYxKBrpMc1YqHZjrRm0I4c3ABAZccZwOMQS3nBK9c1zsj1OmisH?=
 =?us-ascii?Q?qCKr+EOtMsy2+feM1qGwLvcReb8QJhwO+bQxoP3u4lXF9/mSVwoMauTdw1YP?=
 =?us-ascii?Q?z4j2s44XtayR0id2g7k7hKjXPIC3MAY5aFaPXiW+4iLVJH5+kFBHQi/P6JkN?=
 =?us-ascii?Q?Wu67zyRENkvZgdjxuSyBddwo6VU146ZWCja73MLPkaQUmbNEIzGVyrwzqWbI?=
 =?us-ascii?Q?1SskV6sc97jByEICbkkEl+4Hq15jO7pCxzMguyWp8ujqel7OnItjoGKtnEIK?=
 =?us-ascii?Q?4DsvswHhLiHOmfoSfiRwvPcqkQcjqN4hYMKO0UViQZeO1oSphJgkB9/seZ2B?=
 =?us-ascii?Q?dFGSZfh7BCRY9a5bpNotdUwq6GSJnvYU6GKC4gsK+1dwgg1JAq5sg9L/0Fnb?=
 =?us-ascii?Q?8rsu8oL9rumWR/8Z+YsBpzi75C4aUDIDC2FwS7WrrCeFhrkU8vyCxYkLTZcg?=
 =?us-ascii?Q?fsJM91Qp5Zne+YZdgNZkDyXKIoaIsouTpfgF9NlNrOKAdSiOW+K2xErKUIAr?=
 =?us-ascii?Q?KUp9vjxcTkgsrCxDDMKWDkhQaRMQFtfHUnTlAMnpqf9YmPW0o24DYyneTnW+?=
 =?us-ascii?Q?038=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baedb0e-ffe8-4fde-339e-08dc2d26b65e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:32:27.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5063

Add top misc system controller to CV18XX/SG200X series.

At least for now, this topctrl dt node has no related driver, because
it only contains register for other devices, or the subdevice for some
other purposes. The patch is submitted for providing potential common
dependency for watchdog, sdhci, usb phy and maybe etc.

Changed from v2:
1. remove the unnecessary "oneOf" in then binding.

Changed from v1:
1. fix linting issue.
2. remove #address-cells and #size-cells in the dtb.

Inochi Amaoto (2):
  dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X
    series SoC
  riscv: dts: sophgo: cv18xx: add top misc system controller

 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 40 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |  6 +++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

--
2.43.1


