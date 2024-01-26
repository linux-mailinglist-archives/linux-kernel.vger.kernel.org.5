Return-Path: <linux-kernel+bounces-39550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D24883D2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE1928B599
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F49473;
	Fri, 26 Jan 2024 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YVgMcy8O"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6B8BE3;
	Fri, 26 Jan 2024 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706237134; cv=fail; b=A/ZPTl+lIyWzQJBx440TM2rjQ0rZg90GOMVnRD5GBxe4YRRI2eZXreFq386t6bvzCbDhuLPjIVMOkth354djoVbyugfIvsNt7AkGFBl+MTNeu8qz+olq5NiYhanX1RDlQCzfwAlbOYD5/J/OHt0Ve4lAmGgcLc6jWFI7aJATgIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706237134; c=relaxed/simple;
	bh=ShGWeNyytCPhjh2mv68J5MKLOFcOpuVgoPKH/wppBno=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z32wWkgGEl8eUVKx5SxOj4slptz4Vbi3OKiK0FpBnUkENiso2IGvh0B+v5KN+6mJ3MKwirDRyLjK2Rm3OTLXucjyQ5Axg4xPFPcmj4THC26A8YQDyBZDstpK23XQbsymHT2l+FF3Z3xmV93EUnPpHyLe5Iv8K4hhxEsa85PFCPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YVgMcy8O; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQp68Lx3MGWOYQvaLf+Bzp+UcO3zv1cVWkPy7H7rswVJDQTVnnsAHfHWOk6lPwTkOUC5TyKq78LBrQguBwZ8DIu/Ds+uEup7q44ofNZrECfMwV4FnRkWmJGwGZufez0R7zJUn4L069zEE/rULiFORuBIuI8rxoFp3LtgWZOHGuF6Zto9q1S67zSHudH+bQ4/KQLP37gEQL9lnjH5VUt09B+oWRfUgFl+147ja4P6koKDEp7Lzxjerw2DV/cG+W9nSOffzL6gEE8SudwDrQwz2bWqvxsFIRJzX5WTyUMRgmXbaGHoJjal9KaUks098LjUviD6jKhPfNqA46AtiCMmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW49dLpV8USGjUemLcLvL7oPezuBeSxUtAH5BdqpUi8=;
 b=CjDS66rVnNEFd58KW9xwsHfd+JbikLvunKKphUSEVZgKaRqt4ow3G29ywLrqbd4N4PKSxPrdWMbaxnO+8yLGqM52fLThNahwsZXoeR5tYbZJh62KGNScb1+nZReFXh1ajhx5kxGzXpqMwyLmtdNAH9+inKo02bM+lSMvZYdzXMtYTMtKbgdiClXj+u5znI+k5nZ6M4O4uEYnJ/9JIxjmEY0ICZ+aaeW2U3MkcZ1ahR8CPJEU2aYuu36jtsC3hPi0RNJhl2yhzmA7I/rpox3KMxe+XZhGSlM8K2SYbF3U2AoI6cBTGEjWO/wwA+RNQjC8gGsr1nRTiP2EPpzFWf9hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW49dLpV8USGjUemLcLvL7oPezuBeSxUtAH5BdqpUi8=;
 b=YVgMcy8OBAumtOdYBnKcg6zM4IweJjGvZSzF+kZJ2GR37zzmnkeb3rhaq6koBLLdUbZdUT9gkYM7Ebs1ynCgn4wxGMV1wvG76eaMXOLSJr4l6OmBSzCwwBAgvA/P8Ld8gelX7GAVN6h4XjIfn1kn5bdoE7EbYEoFBbCvSNG9va4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 by DB8PR04MB6811.eurprd04.prod.outlook.com (2603:10a6:10:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 02:45:29 +0000
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::708:ff6d:21e:71ae]) by AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::708:ff6d:21e:71ae%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 02:45:29 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-imx@nxp.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: fix wrong place to call pinctrl state change
Date: Fri, 26 Jan 2024 10:44:32 +0800
Message-Id: <20240126024433.2928223-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8382:EE_|DB8PR04MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 983c40ec-ee2b-4543-b735-08dc1e18db82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8100ojHXOPtbdq0RTrXKcVFWOEBTJah9WL9aA5PdrUa57rqcp3fohktRcrvLdnyR0jM1EA5bN6X43mPwvcinz9cjZEq9Hr1CZbpHFoIFupWj/CII3i8VyXEBCMp4bRmjKv6pKzBzyxfjFNjB7hh5HkgV2EFtsQdCOH89FU8oB5YzeVUOu/qkVVyb6fQchzWYHBCTCmtxdJOalBPT2VP1xaUbEBsk0SfCpUuHHbGx/XUi/JSFMAnCcW6hEQLpecQd7ngTS9FrhCTkR7AHcUPhloUczZ39eJOqYmQ+MS8+d9jSfYWAZqIQt18tB7Wm9+6sYFc3WzzkSJJuBM3IPe5sWRmZBItmP7MnMMSjo8jAzUKJ3xOyr6bQn+AaNaTE4FEJY888KHPHPrk/rS3jqSOA8IzbFcKce8/0U8k9lb3WMw0qlXHbEBsWyrApPyiOCHqBTcbgqiZcfoaQB9taM4lPLwxvdrxaFM1LthN6ryg5zjPUfN6l5Hm1gzjrc1huxlmtfX0eT7vMT3BoG1SyOUA7qyweJgUs5rN+2Jnfc/RHCACdzWA7LSIPFTqIsPA1WujLeJVCw7wAAeL91tixBVf11fRjUG8Df0PWSwqdcxUFUQ2bedADhHuXNQj8eE4NeSZfnssSukzXSwfpNSXMJRvcHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(921011)(38350700005)(6486002)(6666004)(8676002)(6506007)(6512007)(52116002)(66946007)(316002)(66556008)(66476007)(478600001)(1076003)(83380400001)(7416002)(5660300002)(2616005)(4326008)(26005)(8936002)(38100700002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dnv/bn60p4gGBd/IBOcjGMJmwXcNOavNy7pipZrormorfyvOG//ISr5X2WKL?=
 =?us-ascii?Q?0iaJ2PgCUmi+S27FS9XKzJNKym4BtRbO6jyS/M+4UQsqwy0i+giKRgsBlVo2?=
 =?us-ascii?Q?cm9KI1AnF0wJdjdhZUbR7pME6KP5ZuesRXvdM7W7/3oGMfp7n3j3tJP5COMP?=
 =?us-ascii?Q?mMwhBIlNkdifQ9KgYwi5bhxpn7IWpOxXb2BnqOsMP3Jzlb3IPS0Bhda5vdOd?=
 =?us-ascii?Q?gJSm/2aQLF17gfFS+6IH/cbIOHorw9Vop2/+DUH/SGO8a/lBZQ7QCZ+so/P5?=
 =?us-ascii?Q?VNZijjGsFBPjEqevbiM6VINsvBd45XDe9c6NRUduVg1VVrBigJQ0BZyKijWk?=
 =?us-ascii?Q?KfoZY2NiuRMtutw4Hv6IrpBqJadE19UlSSDySe4azQ4oInDhOX2XWlACRn7+?=
 =?us-ascii?Q?frms6+dhEHAzOV64HeXZjtpuguUfVktCtdFF9OQL3UaDnAqvX+95wSTBiEf8?=
 =?us-ascii?Q?oOHJ3iLhtnILaoF0E69XnINHP03IBRgjmXZGJQcyClq2bEJT4jPAvMcVzcMf?=
 =?us-ascii?Q?sdN/IHHN13XgiFXA8H7Cg5PJDl+97tKIhH7WZBzUOpli5U0VJq2u52Bojnmf?=
 =?us-ascii?Q?D2teb218IS36RGZtc89kk5LVeIk8mVjdebERY+HQlP9t7XPdsMKNdz1S9MJa?=
 =?us-ascii?Q?se/oayBGIxRJZeFnK6tePnzk+1YLrU26pBMz5KMY5kwWkD4k8b7M9SJVPURu?=
 =?us-ascii?Q?z/3Ve10dEyFMXloBNR8EEnR6Gmof0zNSWYmjfUxXDRK+i4ZCht5CxfsgBGTm?=
 =?us-ascii?Q?SHmbXLhrhnHmcfbzTepH0SNJan2QKdIwwfNhchmNBh7SMYmBikreL/qz8+Ew?=
 =?us-ascii?Q?B5hqUbiybFqhyHRxP1nBWmbbBX0BjKhtCmT9UNy0chkptJsJ2G7FS8OU2okP?=
 =?us-ascii?Q?8MbgcRKefVRKAqhTksHIAyK0hR1y2R/mO7piitcE9HbQPswPDgLpG0mbF1tp?=
 =?us-ascii?Q?w0dHL5alBd+hDPt5yvFu6/rOBaZtkDfSmDWPiCzozPlq4nOL03nPUde7QO7N?=
 =?us-ascii?Q?xktpHBLwYVsMPku6ET04+7OoyyN1j5xyQJ99QeIup1UD8goX1n4SRbc/46fU?=
 =?us-ascii?Q?a6RtQXTzNyxXcjRdqDTCl9cH4D9JMhPGvezajEStN6b8yvvzo0KIk9xWYOhJ?=
 =?us-ascii?Q?ByvGuu2cQIkeMYYBtpkEWYxXkH6iOeG4YiSL5I5RlyawNxwm78X/bYurNmvH?=
 =?us-ascii?Q?Kye2tNgaxs0riN2OK7L7UcpoJMj/HUKCJIBijJJ/1YC1kx1fFxxeZAedLy6W?=
 =?us-ascii?Q?3kSLnf8oW5UY1yJYuRTYniOq2zv0PlxyTL8bFYEVK5dbzPhMpaRhnKIdbymI?=
 =?us-ascii?Q?dFG6CyKEKGfRId2MEIfh/V3J6IDgFVJXCqs7DxzfxTQ1RtPCEiBbH/dSd61+?=
 =?us-ascii?Q?GwQUTfqpIrf8W9E1dwdrs804Ha1hq7SX7X6MfpmS1wZGMmrLaEsr9f1WP0cZ?=
 =?us-ascii?Q?1/av/zKgeC4k1S+eaSWcfF1RKZzL0nzE7LYyQnvhGqtHQwtWFToR8vrSxWiT?=
 =?us-ascii?Q?8kTcG66dT2NvEzy92VryYRKhIk77vfPFkHdWNvZBL002JI/wMl01l6CvnJHH?=
 =?us-ascii?Q?YXaEzJesR8phmH+9oYCksagdTpWwzowc9Rc7tJfP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983c40ec-ee2b-4543-b735-08dc1e18db82
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 02:45:29.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siuAk6gSI/uXguJoRbbyBeM146N2c6ZCJTuu2TpvqM5x8i5OKQeSyZ7eVMxjV5A9JqibMIQmu0vLkHSKRKJWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811

The previous patch put the phylink_suspend after the pm_runtime_force_suspend
to fix an issue. But in phylink_suspend, it will call mdio read/write. If the
iomux of the pins of MDIO bus have been changed to others, the MDIO bus will
not functional.
So put pinctrl_pm_select_sleep_state to the right place to fix this issue.

Fixes: 90702dcd19c0 ("net: stmmac: fix MAC not working when system resume back with WoL active")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b334eb16da23..9104ebf49c5d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7851,7 +7851,6 @@ int stmmac_suspend(struct device *dev)
 		priv->irq_wake = 1;
 	} else {
 		stmmac_mac_set(priv, priv->ioaddr, false);
-		pinctrl_pm_select_sleep_state(priv->device);
 	}
 
 	mutex_unlock(&priv->lock);
@@ -7863,6 +7862,7 @@ int stmmac_suspend(struct device *dev)
 		if (device_may_wakeup(priv->device))
 			phylink_speed_down(priv->phylink, false);
 		phylink_suspend(priv->phylink, false);
+		pinctrl_pm_select_sleep_state(priv->device);
 	}
 	rtnl_unlock();
 
-- 
2.34.1


