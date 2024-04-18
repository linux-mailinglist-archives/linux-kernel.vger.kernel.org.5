Return-Path: <linux-kernel+bounces-149549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B048A92C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0F4281DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D32657D4;
	Thu, 18 Apr 2024 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ppvDykAB"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34854EDF;
	Thu, 18 Apr 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420406; cv=fail; b=ZdbAgoUoVQw55jxW6Qx/M3kleekLEvYSww64tu5JT0VTfUVPidlBKWYU9J2RpN2barPZklvsbDCTTEsergrA9pS4hC8SuD6brSyrijAKNchdT0NmGYb0MMACYIlzNDj1hFIAc53Ddf3w5nvif/9YRZKH5w/Mzkc6wSGxAMQtWV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420406; c=relaxed/simple;
	bh=Hp9OApt02ZX9LSBC0GSY0ltVHf9ID8jQjAEu1x10Ubw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PnnnFY2rOzT4/jnhflani/Itgp3r/vhfP6OYTOgHjmuWvxsdtVYzQlRRJ9lP4zR4zkDHev99VI/hqdMBB0HkhSzPQ7bmIENHqSReAywGd0Iw1Cm8ZwEdP7Kh91zjIHALGvsJ2ZVgJCnY1kOwfM8Obef1WYfKzwJ19OOGQzU/nLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ppvDykAB; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2q5VOCOzMu64bJbcVpDPs4I/iZqi0l6rm8OH+SGYX2ulhf88a4IU3zaMQ4y9gO3Cw271988CjYbJ0ZV4r9a4VAtSAvrvkuLHyIocrz2XJ6/MPw7HAQ2aaL6YhS4LErxKSoYZDxeqLsHljdeBjiklf/yOTaYmbHgV487hTI5Bl/GdxfNmqfJfQBweq9MAwETI4fijwTkJLAJgL1RK+S81QWnmTyr/CPk0LCNotjK0Q05XbyaGS5r9M086JEUU/39egmYB37PYQb31hy4Au/A41Tp27cPXOO2I2wUuTT/rOhsVj3ps0Mc7BBwY0bseeu/Esk/uk9f+dgGylVuofN8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLy9Kf/ZKDHrooV/ug2MnrvK1USICbP9uPBYnH5IQNw=;
 b=aCFi/DhoQNs/AqE2+pAVB1B8wLq/wZlHpxYy43Y/YZlyAO3lGtFLgt0IbQykDlW+Gqk+y0o5O/6pDIhrIdyl4h3sx7mIX6rlMUc+qAbpUme3fYg4vzr74lrzsXCmZdefItwaZhNoKYSpjSIqQZKdO+gc+/9WmC+8E6tilFIAzRCiptOJ+pf0k9E6B84BFY57lpupKG//FPhTVYcNb7RD4UxFg+jtN4Mt2VfvsEjQB/V6T3Wjt/nmmliE9DEgFNhckgUDjspiIqnDwAMYhqlOJy4cE38G+OfyedafQDS+kMaDCT8y7JJ5Uu22BjvUcnsaAZy4WpY4gRT31zLMXgcKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLy9Kf/ZKDHrooV/ug2MnrvK1USICbP9uPBYnH5IQNw=;
 b=ppvDykABOwGu4QPoRxeAlplv6BMm6ErzzSTdz3HEoa8rliydmF5VOaoMFdyCqZMLU6btyP0OD/H8lkiK5tn261gYDfJkhMWk82xrnbUtAITbyvNNlL8zUlCAtyiiXmd4lhWP3Qr9Y6iyyMmgD8DjXxpwG70+C0EJE1mbgiie6NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7828.eurprd04.prod.outlook.com (2603:10a6:20b:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 06:06:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 06:06:41 +0000
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
Subject: [PATCH v10 0/2] wifi: mwifiex: add code to support host mlme
Date: Thu, 18 Apr 2024 14:06:24 +0800
Message-Id: <20240418060626.431202-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AM8PR04MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5f2083-03fc-4798-c988-08dc5f6db71f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 30mrIfVXRIn+Vt9kdXjHUrLeSlpPlfN0QstXy2gQEgerk/cjeHjoYCSEvIgPBhtU52eF/ioGSGz+FhB1i1+S/Rkho1VcWh8qGFzLavqGpnoZGAGGCD3i/QsdHx0akintz3psdU/haAq93cbSDuZjRKNv/qwMjIXS154bgK/PwSWHXaE1uNw6KYp+JrBaFnjy0Sv0GRBJlJPG4P3EmzOxp5v0nS+UBDc+i2THRiMEIrTb4lQ8nC0QcSPMfcNFdMvmPAsl+igsUN0spk9MHiDEwbVBoh7Qzdv01lZHsdBZdiu9b6R6xA1El9iJPnaelRw2TgzeyfSF7G4nyXX8D2yNh2b0F0mvzWzsyjQc5oR0ETee4cLW32yCFV4EcRMIAmtj2AOYUv0yZpdZDpgORt1KshqlJMmV5+Dubp0H1j5gAYUK08yiJ3rFoBXJKQgoB0m5lLESWRjwMlqvLpjKSmI9cuhEg1XYwbBrk7IaOrtBzP7Zc9pKaTQYd3VrNnrKKRUHBupB6NdRSQeaJwFTruIplE+dUunRjSMeUvc8ECitUog0LbNVW022GPPSKoOSbAgFZ62IE7MpRx0bZo7MGOn54XvVx75kDS6qRQgclUvJgSYbScQ3cS0GYN3gWXPP03K3ZC46IcmRk79SPSz2h8s8S3251tailj9pN67Ft4Ic207PjotBCdWfiTIddP0tFDqKOFkFc4zll1JJZGojsHC0LISdi/qP6Miknz05aik3+rs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?nTjvN/H4Xn/nWZLT1oW35vr049+fOwTW4/fUpGp41NfDSzuDKpvRVTqG2+Vz?=
 =?us-ascii?Q?gutfeiwIgdq/wgiZN46Jzs8TSs/lEuSFxFXO2EWmvKUjihx64GTjTypQXvfb?=
 =?us-ascii?Q?BDf6m/bxlppuCSGbLBRY7JHPjUNxh0K6tYAxWUG9cTBmuh3cCXStiLL2S6Hw?=
 =?us-ascii?Q?2wllbKcFOe931sMxEikBMtUhYUG1E2ywaVPIIJgdbuS48WXc42qWu6YulSGJ?=
 =?us-ascii?Q?zqo2aF+6yEuxpLZWEslc1AY1CCpAfvWPdJRaE9Racq7Yd4+TeqgLsIajdZAE?=
 =?us-ascii?Q?N7RIOdfNsAFcXMF8p7YECxMuQIdCuen7jMPks4ExYC4la+X/GIuXCkIIJ0e9?=
 =?us-ascii?Q?fxXamIrhdF4mbzXUJvQLHxdtv26IKgYe95k1CVRfly8fdQlStHy/jZaJvRMs?=
 =?us-ascii?Q?GL7CoGlMsBYb78a+vNg+683SvbEVoK6zal+0O5MGXFpo6r6oCdT0XcJGB4+l?=
 =?us-ascii?Q?2dykvDitXgbDzn/4OnnPzq+sFofjRZruYmg2LK+TkX2dMDn2A3qPDhsPOvCS?=
 =?us-ascii?Q?pQbrBJoDyP56XBdjn3bZA+3H/ba/1jhmp8QV4+v1aVkrEN2Pbzzy7L+QwmwL?=
 =?us-ascii?Q?kGjAaFGf2x5Sj5OS94z5VOy8B0RtBmH8zS7PQ99xC2urGHo6tYPmbR9bA+jG?=
 =?us-ascii?Q?CqqqKlbzqyp1wdBQWhFsbqNgbY8pUl9nF+ppwTEyP4JjQoRmlIMj1J+LWb5s?=
 =?us-ascii?Q?XFd+SQMwxSszIcKN/i7GMHz7dzbiSohEAaw/mmoXDRuzSGeyMPud3VaCQsgE?=
 =?us-ascii?Q?6KTxA6YwaxkqfAnyGbRmFzKa4eRFBbUQ/jCj1tbQqmBD9f9Y9BRqcQA+s0oe?=
 =?us-ascii?Q?v9tadJmLPThQ/kE9QiADPljUHuQ8IjYuGY8cRiMfxcLUdbEG3MzBKBk+3CTo?=
 =?us-ascii?Q?UqgL31eVlYOnQ+pxpDs0RVI5yz0frY+jQbdRysJvai3RPzPROAfRAIy/Y8E6?=
 =?us-ascii?Q?viod9AhPvrUOGXF681jYvCwcD6EmC3HOzr2n3grm16HEmYHplLh40rOYH1iy?=
 =?us-ascii?Q?lUFLIFme6M7DU5XbMIPQ8frI3GvYEZtXy4kqe8HvyI4cfcwhJ0jsULcXnhN9?=
 =?us-ascii?Q?QELwe4b+oEgVbVSoJhetdxrqDOANErcKqDEPRxofjNX75O2ntrBdMOvGmTOP?=
 =?us-ascii?Q?HUT6PRBh13CJKrMsr5wXQ+YdV76dx+SD6iK7tcugmQubky5NRmj6j7lirMbB?=
 =?us-ascii?Q?FCeJwEXb2jFK1Eo1loxAJxFjxcvGr5+E0jQsNxKea3H/5k6+hPCyww4cBo8d?=
 =?us-ascii?Q?I38ZbpTmjXMoQID53cK2xrqbWvnlNbpG+btT6u9xlF8CkWdPt7opt8WQ1WC6?=
 =?us-ascii?Q?q5qgCMjZl4JvRabgzpZ7ThFffUOpMYOupUyetMgSt39P19fIJIg78fUHwr5b?=
 =?us-ascii?Q?bmiQjarHvf0r+H+w+e77tNxCTLYojV97NMdLwPvMJ0lDOv8FRQFs7Wwv/yxb?=
 =?us-ascii?Q?n3U5zguAsTn4euzgRGnBcpuj8KUwLOSeKVA1HKe5Vp3epufLbtHtGWxNK83m?=
 =?us-ascii?Q?bjNqW2WuMbAUDtWbYFhF5gSlHtjJ3WD7N40daw+g9aW7xactbj/gaxUrkNNh?=
 =?us-ascii?Q?0o9zQbGlB8r27Ip3RDIEFAXwOw6MQCh3WHfOrcFB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5f2083-03fc-4798-c988-08dc5f6db71f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:06:41.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxT/RZDgjFLPgzIQ7QlRAU/kNg4XgZOhXBT76zLRC5VVG0blIabXdMQTMPte0/FCpMsU/QWXQcvkvVc9Gn7OSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7828

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

v10:
   - Use eth_broadcast_addr() to set the broadcast address.
   - Add comment for constant used for the length of FW special 4 address
     management header.
   - Check host_mlme_enabled to decide if creating host_mlme_workqueue
     or not.
   - Use cpu_to_le16 instead of casting via (__force __le16).
   - Change the abbreviation "disasso" to "disassoc" of the printout message.

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

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 393 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
 drivers/net/wireless/marvell/mwifiex/decl.h   |  23 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
 drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  62 +++
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
 18 files changed, 980 insertions(+), 17 deletions(-)


base-commit: e6a9208730a9b693e938e497cd43c494e4b95d7b
-- 
2.34.1


