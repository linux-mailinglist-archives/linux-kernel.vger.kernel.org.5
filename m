Return-Path: <linux-kernel+bounces-157572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52F8B1310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825CDB23077
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44221EB3F;
	Wed, 24 Apr 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r6Uasnqa"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED731B7FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985259; cv=fail; b=YyZo0p6a+3gZ1VkSypL+uLtRii1JuFHPj4cd3eOx5EGy80XS4F24DQEvMOqn9Y0PTOSpoxHxcA99qoAw2tFiFiaciIIH7w7k4nue9YgaocIe0VCm5XDIZtEyqEtIhiB1OmwkQERk725Q+YIVV3oCtc6Jqn2ECQEp+4VgYwO8t1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985259; c=relaxed/simple;
	bh=9+922P6aORJ9EGcGoeB+Yz8+lfltn9gN+bo1lWPzPsU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gxLidgREA19w2Xr+RJzX4rEnbs0A1BnmgiQvCkP680CFxhS6Q/wypRZJPiE4Q0rHy1BrmKU3+8S6DpIHQ6aaGWivBGznTphWH1Ha11O0ou8duAh5VpsurufYa6WPBYgV1irynsDZ7L8j7EMQ9u03tNWSc/oKrRYR1f0XN3lNApE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r6Uasnqa; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZcjHFW5Wi+BURFylKCzZ/clDcYoXTLJKXC0x78a6dQeTvK9SNBjwCVS8ssfAfIh4PzIfoSuxw4UD4BP3zuwkOpxmYB93u2gvgCI2vBkiNv6xAPkcsuR9jpY8HoUURMKohittOSO/dJQL03/IrCmZ+Zy85JZdMOaMEWVRG3D9AGy5n1zhOW5HbsXgvvQd+AJswLa18vtZYNk7HEtV6TBfdwzlCgwUntBIIE7KM7nAMTZBk/5gP5g080aWV8G5ZUW/yAtN/swi2YJ4tkgRC5OPKee6vEcMlqwx773UVuDmzv9nlPcwAr22SkrZTFBbWlUB8vag6rov/RdU1kQ87jDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2UfnR2JpnWpluYB46qe3wZ9n+QawI/2Ohezc57zk+0=;
 b=Y31Qm2dMRSoPCi33NZyOZymQxN0G3PyDd/yZek0Un0HQFx6HuAi4bOLQjKob9NPFz9vbTUA+dEFbrtsH9LOVonWPX7RFtsy6LkKFbSf/8N+lupxvJv6LXOdOFmwSO4gtg7z4usKhfFS/214bADXjDxAFAhfr7VvVcsABLteiSSX+EAEsKWmeTXvkY4YQ0peDAuO2FOsZ40QDkW+XyXR18/ljlIkxIEmOOug6yg3OwQ1IMx3uzdSBkwMjplkZ9vkzhLhdiQXzS04N/uzTUPfx7lnXirAEhpPkvC1OMR4Br8j8G6RdRG/L0W2IMHzoKfN5IylSlk1VozfJrWWpOnVjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2UfnR2JpnWpluYB46qe3wZ9n+QawI/2Ohezc57zk+0=;
 b=r6Uasnqa7RQ8s3lWh0Cz0J11tpfdNyN7Dz4RumquibMbMn/ljWgNDkOvaYqK4HKYDEUkZnuCimYHY6F8ZTg1iXBntEPuAFERXeP7PCXubumRyX6xv8rThj583fIQf3gEPCfScopYA4lgLXOB3FnHTOB/4c3vbD/cTcTXzFNS+fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 19:00:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 19:00:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] i3c: master: svc: change ENXIO to EAGAIN when IBI occurs during start frame
Date: Wed, 24 Apr 2024 15:00:29 -0400
Message-Id: <20240424190030.857632-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1ef884-1b0a-45e0-4cdf-08dc6490da75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J7IOojdnNV+Kl/EZQwN+Mo6flOfX4YdRtQ7c33lwGFQs/PfxE9aCivSZTtZD?=
 =?us-ascii?Q?+MLCKAgk698yDum061xh9q9e/6p4k1rxky9PK9s2E2AHY29oQZJRrR9Toz/W?=
 =?us-ascii?Q?dAENW6NHTF7MW1k/z/lgSrUyujpqmYHWWaPEI7NOBa4qLiwFY+09J6Oj89h3?=
 =?us-ascii?Q?axVoEKNreR7SG4Oy+ckRf2o6dQSt+0i7C8MOQXElwnExrp7BuuQ85SvOe3a/?=
 =?us-ascii?Q?w/hH0CDtZeJ6HtH8WJudUfgjw0cp0yPmBufBYtaF9rpglDw0B+0JfpCsRXoT?=
 =?us-ascii?Q?fV6AJ3Tk2vD6wz4ilO7dSqEzpDtj7hs4uJ6BfDP3QMZbjyYFHgBrtryFp/oS?=
 =?us-ascii?Q?aVEVBd/7iOwb3yH49qzMDWe0c6OK/aXAfRuy1uoAgKVNvKfOH3WiAVqAJL3y?=
 =?us-ascii?Q?gSYHiAitunSmxoVqvvOrIo3LfxQVBTU7xIPMTQNrgvfi/iVvUyzF4dJc2Qx2?=
 =?us-ascii?Q?aB8lI6dwT8USd2r2IqI2B3586P1mkKx/5uyF8zLtGXbc3evplEfDzU3Gb5a7?=
 =?us-ascii?Q?b9MTaFabKO5QIV+PJoPzMu4s5lzhOK96tpNaciZxaRWhgGre0vkGNVbOSMsk?=
 =?us-ascii?Q?/l8n+ZQ+gTtbu2c9hzvDe5fzp/+x+O7rCVUfVlL+qAXVd4snwDrS2bUgrSUf?=
 =?us-ascii?Q?Lf07Jv4X2yPD1mJLaslWGuhwwsLDH8VeP9FtJSUth7/Suys513iFlTsQbltR?=
 =?us-ascii?Q?VDKnp4kd6IBpBr7wtdaTPb8ZuhVO17gDI0Mc2HKYcP48gUK7L8Vdsx50Qpfl?=
 =?us-ascii?Q?w7SuKh6g5FY/2gnC93la1XZ9H4TMR11n22fXQyHqyxB6yyboJeKCjxotSLpM?=
 =?us-ascii?Q?NPjqBi5RLAa+2Z6jLxRBvX9BvGReqSyIM7nX9+UV1cGXKzuqffly0v298GiG?=
 =?us-ascii?Q?xgDx6GCv3vDkdBWMn7aFomT1/wauGjB44XmIlgZ/mR4vo5lrwdeXOEIA8FCV?=
 =?us-ascii?Q?EgiydDZEcFiPRhJIMXwfblqfd+2f+zeDd6vBAJbPN6pH2GhpNXJ/1CkiM7vS?=
 =?us-ascii?Q?Q5rk7CadhOKhgwKsTYxBZtC24LNj/aiEkdzqCf9qJ0t5LOr9k5fHgCo5KG1H?=
 =?us-ascii?Q?a1iwQJ44g3fgsTDWcUgNYXQbmQ9Xp8p6aawitLliEobRiYD7XyYGOGxWegx5?=
 =?us-ascii?Q?UbqWkEjNbWg/dwyrtjoeb4KfGcl5+H215VdEyNqZCHtxBLYBCsQh9aLmOXgO?=
 =?us-ascii?Q?KykMp6w2enrAhSo98vU2Ad49lGVx4NuepH72rcIxmmUVH5yEAkP2FYHIO8Ax?=
 =?us-ascii?Q?DLjY6Wxd4N4w4rKM00tmBLnKpIxu0xEKku6a5k3/tdZtgj4Xel0oLi6NoRDh?=
 =?us-ascii?Q?3pxVHt02dJuitavk8WZOm0qrTWy1Tmljk5BQ/90HZRZLCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/CX55deS69WDcQgQZdGSZwH24cRQWry29QelLy05gRZAPjuN/NTMAYYUNXb?=
 =?us-ascii?Q?1dJP1KylTHSLlDnF15Q+FSjKEDJvusxPnzshey2inbOHo8Stqurlr4m8Lly0?=
 =?us-ascii?Q?bj7vU6/AEI5oXh+nZkgGxYYjwtIAOsJAx8n6BH0N3ZMRX/YAnjL+K306/jIf?=
 =?us-ascii?Q?dqQsa3LiSBDZ65ZGAMdWQ7fM97CLmAHYLsgo0xpSfHuth9hQ3tk1rBYwd626?=
 =?us-ascii?Q?Z72Db7y8RKMr2pWB6Slukqi258gkCkbE49hyDnqeKRsV7KIJxO3g+PLL8o4M?=
 =?us-ascii?Q?ysNRWhGBVdhRt1rgfAiolXBc+TLo+LRucBbuFenlSGSHQdlil3LxSPOMk904?=
 =?us-ascii?Q?0G5AEDRRg8VYVrg5wCsL4u/ppnyQJXUZwNMdjj5E9BcoGBw9S2bJXQdw324e?=
 =?us-ascii?Q?QJMMNy8NLMO76/xNZarsbMHnlkozDLF7j3T0OUKXeXzrAwGHAeDzolJmKd+A?=
 =?us-ascii?Q?vtOI39R0bm5pFA0I8YcEsqOS40HTuhDERoLMG+4IzkuWCPanBkVGxcgyjgbh?=
 =?us-ascii?Q?/YhjgqyhvSafML26eG/X4fqp5M25S/OtapSgu4b1DO5lxQ8nt1SZH5hflTzw?=
 =?us-ascii?Q?qOyH95JpjKXX2mIRePKgLT5x3prTXnLySgaBlFNvvCdgIcDTz7O4Z2NTynfc?=
 =?us-ascii?Q?MBVtp7atZjj+VBF+kAEVURiOXK+dRdSFfy5FQLQgRRTG1jTuZG5YZ9AdMB+x?=
 =?us-ascii?Q?arhMZJFYWAizGKOjMk8vb7LkeT447clfmRn5zp/zGsxdCL4d7KLEU+zAbiM6?=
 =?us-ascii?Q?WoMNkk/QSrgCy+zY0s2dCBlWbww0Q0SAHFE6TQ7LNWqyB+BYhNFvVQteRto2?=
 =?us-ascii?Q?zaEVEm4RUpxdePqrfRZkLmhGUXnRV5QX3PlhE2zChLOBXuu8yNRXWLC3QTa/?=
 =?us-ascii?Q?mIDu+NVYqedcxxlYrAXD21TATssSkvGzedNFoGuJZBtcvz3+WUXlr2PMdEoA?=
 =?us-ascii?Q?GMCFnl+YA5eM+CFtZanNgl6vjcxKgEZWCvEnmkmBLjeohJH2ydNvevbhGS1M?=
 =?us-ascii?Q?SLROpCcNLdt6Ia83bN9QrBPko+3siUgcMTY2vcSW9rzl5B1ayVIzn+Am/KJK?=
 =?us-ascii?Q?vE47B3j6yPwwmwDaDUzrgXJfOtcRJY9s/aBh77/9FU84cuVpVSVELj6Rgekc?=
 =?us-ascii?Q?2FICZYiKYaM7AsiGOV37+OlPWTOJ/6MUVkyBWOLNa/cDjFWxAiULCxR2pDc5?=
 =?us-ascii?Q?JYT9FSW7HnrDooX3/cx+A7WuvuzimMuvUwVTak4O0Qqh7oM53wZZItMtF+xq?=
 =?us-ascii?Q?gAUDYSBheX+I0Q7ewNYx49JoWGTGI7ljl5qpDNPTgbNRxnSkc8wgISdbQ7qH?=
 =?us-ascii?Q?CHd+MzH/coLuI1HrYVfcPxOlqiHb4i8bZCtV9GInXmMbc54fyZdH5NWJVi3F?=
 =?us-ascii?Q?oDJSGqWhyCevjTSt2px2v+4Y0gfUAuZocpgKVYu+UyKgorew4F85LD6mcPjk?=
 =?us-ascii?Q?zgvLlm9RatiX7t6GNJm0cFdWvIJUOkd1lDbO2b2thcsr2uktTAWtafBMaYLA?=
 =?us-ascii?Q?fZhCUBfIW96uJZvK7xmcoxeMPSfi4Lq+Z9O39rPZ9fSGfGsc1QGIxX4A7gjM?=
 =?us-ascii?Q?JVAStR3mR5kn3HbjUOnPquhiArJJl6ySMY8XxO2e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1ef884-1b0a-45e0-4cdf-08dc6490da75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:00:48.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3L2tkAm3k5wlCTNG3fYQMaVuoGz9Eq47Lyp20/Ssnj7401pUAweEglg9lM5UpK0D/QU1JBu4TktPaQ5Y3Ngdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617

svc_i3c_master_xfer() returns error ENXIO if an In-Band Interrupt (IBI)
occurs when the host starts the frame.

Change error code to EAGAIN to inform the client driver that this
situation has occurred and to try again sometime later.

Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI happen during start frame")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5ee4db68988e2..a2298ab460a37 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1080,7 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 * and yield the above events handler.
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -ENXIO;
+		ret = -EAGAIN;
 		*actual_len = 0;
 		goto emit_stop;
 	}
-- 
2.34.1


