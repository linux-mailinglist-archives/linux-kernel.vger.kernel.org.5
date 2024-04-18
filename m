Return-Path: <linux-kernel+bounces-149602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E918A9353
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589321F217CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE492D03B;
	Thu, 18 Apr 2024 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="svpEvHW8"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2040.outbound.protection.outlook.com [40.92.99.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85421373;
	Thu, 18 Apr 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422627; cv=fail; b=QLAtsxGbfrdlKug093C/1H83kepdnnFcyDa+Yqgm920ASm5JqZuoLSJFvJ0fiPCJzwojUC1frVzu99KzUmF8Wx9bFh9U8U5rbRoIGSHGQvtqLA1EwIIQtC3ziEDz8polwM+91QywgUnEA/Iy4Pol2aHc1ckbjNuetxcOtjkEqWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422627; c=relaxed/simple;
	bh=AFYosN6+GsczlP5oIvbgbP/8Wzdf6jGdSYaj5IJZhGo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X5txMIX7e18Ql6KM6Ty4GxvYxjQwiPh/hV4IxgA3gySYp5i/A4kCi0oTwzqDBlRHamNGeFBHz6aDs6wkEu/RkcDZEX19xshSdxyYZkEv3LUyRWqzsIJgvTMMtIftb9nn7Rom8gSXLDHVCYqprAES2gGtTRF2XZ4kj3zhVqZNpFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=svpEvHW8; arc=fail smtp.client-ip=40.92.99.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3wDMs9gicnuuHmJI4MVKOI8tbLbfUb87atU2w18xVH1exTqM+S5qRQbhn3w583juciW6lEbgap7xbP8M8vhe1DtYWM1nOZXC/GG+6tFUimf9DnBI1D4glCekcJV+cB19CdfyPzegV1PG8vCi/EkAwrxeGRNKDhgE7F86VnS8nd961Bfw/JaNgz8GPIg3OUJMD5TveN8edrYlH/F8fr4bHBITWPcKBc/QPMdXq405XiBvtneG8QESUt8gRWT7XvAgyhCdptHFTDMyfG9qZNKxIDdeONNrhjjWgWWsnuUTcMVSbJAxXm0nOs81JYigbCEfreJNT82Ch2Vz+7S2aNguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjoWZOiZp2AsHP2HZwEPaNYesD6tRkSp80Q0IXFaWh8=;
 b=Hm5QBCgBm2DCl5VJbyJCjeWlXYDCFojM1gw35TgVSewbtRTULBYwP3sVTkKwzwlejcVgHjTks0AEJsydzauk/pvqatJDBK44MhGYhA18MuvMg9vjkbXPonlySOKHLFwSFnbQlXbJMxN+I95tTWbVQh2Ijudi8alKYgqESUXm07jlOuxBKbKZ04QXlmoRsCIYEU0JitzERCGHBxK0a/FftzofFJBCOjRONIAWsUdyv00TXhZrX+iYdjaROB8L/RDbvHVtjwEKnsiAVpt5tpmxbivY4CDG5C2uG3YUXFnwTNrzRJx/ytVnrC3BLK012wlBnffqdmJ7sfXuPLnf88CFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjoWZOiZp2AsHP2HZwEPaNYesD6tRkSp80Q0IXFaWh8=;
 b=svpEvHW8/dgDnibzGXkgiK2w2DWjnyNoUT4HTLXIBdghUJq1ZrpLxcfmpcz/lMxJu01uKdXS86JhHvDmQLmX0+Ox8xohLDu7NHta6Ip7TZpg9IBaY79uWfB/OONKN1Nw56p63/k2aELA+93cIUjjxmSbMFf90bOTxXQz7WEpEsMi/fgDG5CkEqfth12toh4ztlzyoENFx1MnpkNFxOQ9Vyvt2ExEy5lRwrlsLJ6kKfqovXvgcBG1ZqPwTYB3mOJzuoxUVPoc4xkfDynpJdqAWXAxB89wRKjqBDZ7+il2RAyzipqgvpFZS4YcwsWsVJ1RQwRJBBvnE/eZPePegzRM9Q==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYCP286MB3599.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 06:43:42 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 06:43:42 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: [PATCH v2 0/2] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 14:43:28 +0800
Message-ID:
 <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VnCgDr9U8MiDEUKAQK4UK4WI3q5N2mgiSxBxAO84ez5TDey63NZ9Gg==]
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418064328.12758-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYCP286MB3599:EE_
X-MS-Office365-Filtering-Correlation-Id: d23cc1fe-bbd4-4ff1-9605-08dc5f72e320
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qdmLgSScYYnCvXd92IfdoMe49/i/UO4SRZ3GXM5uBNTm+kfDsTjR2eXdIQREA0THxy2Gf5xBFA73GkDUT2OVtUUS4y6HNy8Cy+hAIL4WImG+3FUSQgb9ohpO3STEx5T+Q4qj/AetjX97JYmhMSDA68LhWv4oyFqlVOe6KOK/P2ogXw7/HBzjzK13vsGmSvQaJ+Ybtsy6QS5OGoxypA6qB+GamGOladi1+ci/wom9oRI0CwXU6jkZoHnUHhSk2u/K84oTN9rDCD2RxKhsxrRk9FaYQzwtrrO+kLPOePVFGGHoaVsKdu4RZ3AGqFcZ03jGVpB96dZvwg8BIxRfwsXMf1D2SKrDbosdX/UlKYRSiirvkzjyGYVuFE5k0CWjn7icJAo3p4asVq4h1YXlvEagMp9sf2aFXrZIfr+gmawY1/lzrkLemb4lOXPJF+PXEs2Ccw29Z101p+MzY/c3dNRQ17sb+9MRY69IPimQdRVhFwPdOq+olBl8jLzgqazG50eehGoR0DCzB1rVGfo5dcWIZYxgFPQ7B/y5qj/hQbscELlXzlwsLk02kJ3M6bmnac/ydCMsmIvcGDaiOoY2CZlDiqH77NBZMBxRKsQSjL5A8esB9WGrnV00gKP3I5kxSCZD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLu8PwHJmwxjJFmyxwVy9WJh8Sh+Jmis0eKaNATYr8UGltj9xkiqG5FlJcL6?=
 =?us-ascii?Q?FyGbWUlPoY6ePqyVX565rYeyfEhDwOmVTHtiy18Wt9kJJjNFsDoT4yvRiY3p?=
 =?us-ascii?Q?bEYNSMxMTUuBlHZQ0sk1bOSUnXKGoU5FC8uxC6VhhQWd0dJh97bHrPhfYh4f?=
 =?us-ascii?Q?1hBHWbESkwco/NLhqOMDYfkQyvx+QAyNKTcUJLVok6SrNEfENB5rlWBt6a/6?=
 =?us-ascii?Q?GF1rWd9Sco/kgkalGR3S4c3bl6lPWOmewHxVfObrc7crvqP75xIoTLeWaRHk?=
 =?us-ascii?Q?QGS3rl9XxOwY5siw9Lr0+a+z1wQg4oaT/pDBj3DAwbNfPmZjmPn5xhurzSn6?=
 =?us-ascii?Q?m0Db2RUJDSim2NlEkwzvR0oe0QRsoX69uCG0/5/R0x6RZ4pV/nsuWSfVhJIZ?=
 =?us-ascii?Q?RmGlM643qxTfvrxbV3RKEtwXBs5Rca9RuacJq2GxyB+GPVfILLTSm8KiZZxH?=
 =?us-ascii?Q?JkQTLbweuE9TujGOANtQ9inf8IW2g7RL4O7nOJRkO3S4z4h5oL7a52aUjJMB?=
 =?us-ascii?Q?9oCSiudLluLgUvgXLDa/tmpsNsjNX0rHldqjUgQG5uoevNPoX6iEoiJzOsRv?=
 =?us-ascii?Q?NYowNqRrWaJVwK8jOLCFFI+pWNYf/RLS2XEvSsWD3EqvgggjjdLLMQnQ09Dw?=
 =?us-ascii?Q?Xmfm5tnNUPMPY4I3bxSrevnzQTq+upGjR7A9Vb+No+ztm3kDUTqEr8n4K+gF?=
 =?us-ascii?Q?VnlFh1uozZSAQn1qanXWleUTCsDdv7cHyT4viwD37MdLkPJR3BU/c8/0IY3U?=
 =?us-ascii?Q?MDi1dNA15KVeypcg6TKqsMIpYn2A9YIoebQLBXHatk6/wXkwPe+hr7YWqy56?=
 =?us-ascii?Q?1ejtgWjCK/TXnelWsF25iCFzDEBfs0j3PvEaFOkkrV9n2wLsXAvPfRJSN53v?=
 =?us-ascii?Q?W1v1TmqgEHEvG+m0H81MoYiVLUzZbR+T22i2vZJ41X/9h43Z7+q+FxWm+kGE?=
 =?us-ascii?Q?djgZdOi1y5PPm+ZkehxWe4+Hc2M0Ip9ZXXtV3tUypTZ+1fIHmWwgwSWaUr/S?=
 =?us-ascii?Q?KvZE5+1EDOwWeWrHLl8+oGPMCe20xXTA4Dib9wxA7CVoVmlrMHj/BnZwl6Ly?=
 =?us-ascii?Q?xkf+NRebCBUy3+dQKanI981XQzvbNx8OfHZrFNVA8N6znidMIwP9/HvtH7Ma?=
 =?us-ascii?Q?WHB62cqJbEZv9ef07fZw2kDFSKNdDyllshC8Tim6DELthtwyHeBE/hrbLDrg?=
 =?us-ascii?Q?0S3c13LkWai2EZ7uGi7tXkR667sUy7OQkVDPy1eOxkpgG92jTHX9iCxdmuq9?=
 =?us-ascii?Q?jMgEE7Arwhx9JHtBayTX/3tnCoAKdRyXQSo1WxCRwg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23cc1fe-bbd4-4ff1-9605-08dc5f72e320
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:43:42.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3599

This fixes the sound not working from internal speakers on
Lenovo Legion Y9000X 2022 IAH7 models.

ArcticLampyrid (2):
  ALSA: cs35l41: obey the trigger type from DSDT
  ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7

 sound/pci/hda/cs35l41_hda.c          | 9 +++++++++
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 3 files changed, 12 insertions(+)

-- 
2.44.0


