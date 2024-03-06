Return-Path: <linux-kernel+bounces-93222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCA872C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A4289A74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9269D529;
	Wed,  6 Mar 2024 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bzOKc/Fc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4379DE;
	Wed,  6 Mar 2024 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690473; cv=fail; b=fqq8QJMkNTF9SSG4epP2lSCjhB6yPCQIElTgVQAGegFW/i90WxLYxlcHvKHB+QGdRiWMj2afRHLJTz6B3ROUBPY7ng3qW6QnzVEZtXMadIN/9Hqpm3jydsqlzV3p31SDDsj1KiYm+8Ehkq0us73JiF89qrvxm3pOZQe+hXDEnuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690473; c=relaxed/simple;
	bh=CDFILk5RIMZDN0YoCN3jP05vZ4PKs6PcsHYxW3j4muo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ARtWQiq290XLoLrNU54Ototrq3DRz4Wbyv9FlfweqZPQbXGFu1ozAk+9ime3ZGWmis13u0Obslqsx/rolsla1yZpMM2ab7EmRvuVp6MSvR43DRMKtRUCiDm2kpR7JnoPVohsj+X6Cf3zFdVZSQxXlRC1uxwXn8ZHK2WKMMsTWI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bzOKc/Fc; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkJ/DfYohvfWgcROv6yamWCVKrEAOzaoj9TsgJwZSsC7LTiTKsxTZvpW91H7Mtn7WNhoAHl5NjLS9+IiTqmtitJO442ppU1EyTX8VIqLtf/TuXfLwcgy8YApSW2ioP/XHLX6zQfZsCjqvj+i7FcrZmj3lpBtlCbub3CwuYjl3dOiOXGJJ+MXMMTFGPW7peigfnPJRtKoTudVJMVMTYG3ra4a7bei4XIIoM02JlzkiNtB6z2UJxnVvs3W1PraEyjRENiCAdOcUWCNIhPPz9CeDII4JWpaIH8tk54uHEqpd3tVL7jZlMDSDF1aQwslGZ99IwUqZyjXlmfuU+Q/XTMwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/fHvVtzEaxbNBccNy+qvTwNYfDIjTPGrvXkp1JGP30=;
 b=T5rYhdO05VIrqHcdlSPit/0MvEbFCQe+/UxLWYoqYq2XqVBNALONRiyXhAE2jNylRM4/Qu0+h9LFa4IZHn+FVtONrgpS24k/diJzjMnGdKO0wtMRgeHn5VjKWfcgk2dK9aGZuFfAfJWX/PXk7t8TJg52xd/BYD2Im4t8nyj0W5zxzlCbwUDoysTMJYVluSFm0oVv7FfYMl/2obvd0DdZp44Qp/paRTcNeO9TpfjFEXXuF3dzUhoXB96eLCdaK7mCyv0HM2O70wcTgPouC2YRbi6fwL9pGBrSvqYrd1zQ2rgVkGA28c7NIVu8ya78LwO3eStIyyqvz7G3k9L4r/27qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/fHvVtzEaxbNBccNy+qvTwNYfDIjTPGrvXkp1JGP30=;
 b=bzOKc/Fc5SCQCx5KYMWx4hVhF2MPNOpHf6CdKHe5CINJAea4q1XC3fuBFtjze3d4QCtUa0l8GjTzWzXBJk17+wdFzE7ly3CFkQS4gTukxHMEVKEKq/e3TlIrNI1cotkojQyx8gWTLWfV56qA5J+5A3saWGwk/rlNluPix7TOsE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7595.eurprd04.prod.outlook.com (2603:10a6:10:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 02:01:08 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 02:01:08 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Date: Wed,  6 Mar 2024 10:00:51 +0800
Message-Id: <20240306020053.18054-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DBBPR04MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bc920d-2850-49de-64c5-08dc3d8149cd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 RqOlZM1zmx1yLyNpYc89RZ9s3NA/J/qmCiupcnVDX7PvlfiewWYGksDpMENCBcopGD8p1gl3hJsI1MGiaApUExUcubRyLumqEFqGoRARBVTtEdeiUcdMpmzrbxr5sG54IT7A5TZgYlvN4hu0OY+Q2RjSijDSui+tXL/d82xJEuY2nSXvje+TEM+OAGCOzRCQHoV4pMPEEjiGUp6xKVd0Ojh27Xh1sE7VsEgD7MZfzd2iHm20AUOX0ObOlv4sAUpA/kY30vNV/tMp+7SJHXrK+i+fo/R9HKxqp8vbyDYgK6c0Z64itIpU0G+BROmZ4cQ9Le2abQx2rQ5ENVSf7PGCi5G2FyAodGum4083V+bE7rLvqseC4wiTpimQr/HImqJsh4Gtvz2RNWf268RmElu+3ZfdjrSrQxRUcy8e5mZFKSI0oYT2anWHestiaKSHY6aHW/2fhtslEK/zvKvpSEzylVttc4EBbLph52HNhPLJhGAKBSrfg/A67vNrQNNKAViAVBxFLr3aLv38gvxGExr0tHvyenF5KUlc/EJzRYlyBoww4KlRuEEj68hAmObO6yE0Cezs+7XdJQzYGcxyIaLlvQRBa6/eoxL6VnaNvNeG3rD5Mgwip1eD1+NI/VF/Urflni2MR2CteAEW8R3WeLiuG0oQnqejAJbu8i7Ef3ZFD7rXuY4i7i4tqTk8IAlZRfXafKNAP8MxGR5UEzU+2suO5g==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Pacv7oYNmtFGxFA9Uasw0sGY44x3tYUnMeLzNb7Oo1mDNfDxzdhTv/nqcEIy?=
 =?us-ascii?Q?TbuM2CwJvITwql1LjmRVqn4Nk3j/qBC9QxB2W6S9FRd3YmoRCScjySK0SlTD?=
 =?us-ascii?Q?SErBpqzcmnce2Uq6aAIjyB6VAK+vSKHU2dfajoW5U7igacul98CPZq0SgYwO?=
 =?us-ascii?Q?4XiK+fTh82PtOPjFxkcjndcbTpUTdR0gSGyYgo7/BqucTpntK4t2OZ6amMKN?=
 =?us-ascii?Q?uiiVIFy/YjFH7ctsHRkAHMLkpfieCU8El7jqcn/9s06bpDbZwKVaq0pfMCo9?=
 =?us-ascii?Q?AjZpU/L0rfKbzc/ZdyXIuIZsTNjc/Gj3nTH8zISKJiCwiAFP+DGnd71XcEce?=
 =?us-ascii?Q?shIb2dunixUugzsJ6Qj4EhQ8qNU+13AJBpasp73vD9DB+Y35kttNnYrbrqAh?=
 =?us-ascii?Q?oWGCNaYWnVFCF3YpQAIOVFh6VT2aSrSzWmLYl+lec05jdAjp6CjoMh5yOBA3?=
 =?us-ascii?Q?JPlhrGCuwXbCbNoi0bNQc/9eip+eljM4lUNd7KNiNSLl5EVT1aIa2r4LLKzf?=
 =?us-ascii?Q?353/Fh/mlPmPQTH51wq4CyQWnINRUY/Zbp80RWhvl6IpzKPYouas6XBwTGP7?=
 =?us-ascii?Q?+77m6IWVJl18gzhAORgi59X2Wh9COoyoHNBXhPBZ9TWYUNXX+ue8gsy625+B?=
 =?us-ascii?Q?AOg4ZZ1u2RMKSGgjUYRvD/1CWJUsGsLWVRK0heP0yBWUIGI9F00QTgjCIqYu?=
 =?us-ascii?Q?quXibQHIwoVOeHMOYgiBbgpINRGFjgwepKFvBw0rDsO5fdGMGqW2bZIJ4aTB?=
 =?us-ascii?Q?SP1Fq61Ge9mSbKn9lNMZayQCWGb8bXT/9A4cEHeq2D8pJYrzwi8iYQ3iiWtx?=
 =?us-ascii?Q?ylDuExoAPzb2vT4yk2mQzCQnGta16izK9a+Pc0dkcaXob8XrndcpxHPXhBbX?=
 =?us-ascii?Q?JmNbMDCXw9e5gcTv3aFc2x0WA2uHGs4+Za/qn4uk1NNn9FDykOiARp/n6LC8?=
 =?us-ascii?Q?p+G+RE7Ba6jPa0y2mtjpT9ftB/s4sVqRmg66D4R8bWIzacisEMYTaLjZKxpk?=
 =?us-ascii?Q?UiRmaXGYWUO3nJBzdC66rt5dH8aEHHq5yA7q+cst0DzgF2mxcZlYRmiWRpmH?=
 =?us-ascii?Q?lZqiUFxeNOwi7b/NYrYATKblKyaPtxQ0CmQg8KSVX0WXba69x12kfJblQxUp?=
 =?us-ascii?Q?V67MKtugrm3T/Vtx+HtXpnDWZu6B/AWHt8JcU4upMpZQXhRQNIqcW4jeIO/o?=
 =?us-ascii?Q?P9+i77w/sB/7YAxnWNU/qTux0bQqSsbl7GHc2/Z4vPUp7Iblav3JRdwa9oYe?=
 =?us-ascii?Q?qRXw2n0wVUyIl8wO7YKm9tkrcPtkUkE+Xzr9GQKbcOVkTtKFAdaun8Kn/6NR?=
 =?us-ascii?Q?qtdvasK84o13whOwGR02P7Dlnqrete8pNf4q/iTqj67DWOYeJ/gezX3Zde2D?=
 =?us-ascii?Q?jw2Zn3ksvTCK3R2it8y6XbALWxp5hGyL66rMXnPnCtbToNsRgFlqHIIjNdSO?=
 =?us-ascii?Q?M3FiiTUwYJAQmD8lFSjcRfgqNOpDCY3L76JjUf/9EURV6dsBN7I7V1Ohc7zY?=
 =?us-ascii?Q?ERG/L7MjwbPsgGvMVzuGEjqmiAYM6C4hjGP/XMp1uILBxRzq5SL1HjRIwOya?=
 =?us-ascii?Q?2VnPFs5sYvF8xwMJgPgKD+Q/eLyK/C3kt41kSFcE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bc920d-2850-49de-64c5-08dc3d8149cd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 02:01:07.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alQs6v63egtWN5BacBz6wGkprVF5z9372PKowMXiy8qAtMpeKIPOJuPkd40eZ8ayvgritt00BVKlnhjFNLavHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7595

With host mlme:
Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD
Without host mlme:
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # 88W8997-SD

This series add host based MLME support to the mwifiex driver, this
enables WPA3 support in both client and AP mode.
To enable WPA3, a firmware with corresponding V2 Key API support is
required.
The feature is currently only enabled on NXP IW416 (SD8978), and it
was internally validated by NXP QA team. Other NXP Wi-Fi chips
supported in current mwifiex are not affected by this change.

v9:
   - Remove redundent code.
   - Remove unnecessary goto target.  

v8:
   - Separate 6/12 from patch v7.
     As it's a bug fix not part of host MLME feature.
   - Rearrnage MLME feature into 2 patches:
     a. Add host based MLME support for STA mode.
     b. Add host based MLME support for AP mode.

v7:
   - Fix regression: Downlink throughput degraded by 70% in AP mode.
   - Fix issue: On STAUT, kernel Oops occurs when there is no association
     response from AP.
   - Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
     STA can't connect to AP anymore.
   - Fix regression: STA can't connect to AP when host_mlme is disabled
     (impact all chips).
   - Address reviewer comments.

v6:
   - Correct mailing sequence.

v5:
   - Add host base MLME support to enable WPA3 functionalities for both
     STA and AP mode.
   - This feature (WPA3) required a firmware with corresponding Key API V2
     support.
   - QA validation and regression have been covered for IW416.
   - This feature (WPA3) is currently enabled and verified only for IW416.
   - Changelogs since patch V4:
     a. Add WPA3 support for AP mode.
     b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
        when group rekey occurs.
     c. Bug fix: STAUT doesn't send WMM IE in association request when
        associate to a WMM-AP.

v4:
   - Refine code segment per review comment.
   - Add API to check firmware encryption key command version when
     host_mlme is enabled.

v3:
   - Cleanup commit message.

v2:
   - Fix checkpatch error (pwe[1] -> pwe[0]).
   - Move module parameter 'host_mlme' to mwifiex_sdio_device structure.
     Default only enable for IW416.
   - Disable advertising NL80211_FEATURE_SAE if host_mlme is not enabled.

David Lin (2):
  wifi: mwifiex: add host mlme for client mode
  wifi: mwifiex: add host mlme for AP mode

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 394 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
 drivers/net/wireless/marvell/mwifiex/decl.h   |  22 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
 drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
 drivers/net/wireless/marvell/mwifiex/main.h   |  16 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
 18 files changed, 972 insertions(+), 17 deletions(-)


base-commit: b621df176d4d6eacd8b057f7324229655f10e77a
-- 
2.34.1


