Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02379E956
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjIMNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjIMNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182919B6;
        Wed, 13 Sep 2023 06:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0hGAAz1Wap63LG2Al7tanIO4omaj8OcBwnJ8F4q9FbIwSlMqO/4A4WI20lGQqjveca/ErbM0Zbq8eoe0Y/0Z0uprILM9zmQFn/XEsbBi8JxIT78lqZGN8MazaB+Weu/ET27neF3fL2fCf5NKg3F0Ds32NdPoww3BDTE7ILc55Co0FLO5MxLSHDVeyr+bxb0mBtDGB356bWXmyeI80OPG6PqsmadPhp+35DZXLIto1Q+X4xhBZeOXh0e6QgDo6vi2jHgdcbK0nl1GChFF5DCr6pxgvG0LsPP83EwmCxDi6qarblNDyPLFn8YUYinfM2zM1uciwU7PhkJpmEeZSHgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptttOu7BCBrIVx7RRWA2CjQLpXJ8B1jM5pv/OCdaJPo=;
 b=knucm7L2r4SGAQ0iOdjU+E1cCjdNaPqXLetlNm1lxPT0dk7EaDjkfdCwY81GtA+ikgUSw3Y3vur+7mykv3ZWDH5HnANCZFadNPR0dZZ15OJtdGwnR2IEPsj/usuWSUjVdgZtPf0Q7rWBjD820fjUHYvwgJ0h1dbCL0tZtcKcfLtAQo5ncTxp1L8S8J0J8pfNHfZFRhc9wMlZEaJ5vkRv4KqJnLpwSF7Yg29HvaX7brOXYCgF99wHEUXO3gZyjJjnBWs+VBDlFDgQuOvT56fp6dgBSxeZ+occQQmuSc7JpZLi55qSS/tLbZmAQfRBR8bQg2beB1n76vofeboTouZVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptttOu7BCBrIVx7RRWA2CjQLpXJ8B1jM5pv/OCdaJPo=;
 b=DeydIpbQ8XNmQR/J8CO726P129thouY6zsgJ4E8YZghU37wIgKnSq76LSz+vzg5xQ5kpFVUL4fBUpJHEDZg2wwxZG05YPMaXSkmPFZO5n8Mf3iG85uChxF/1ZmG8sCt1Ejw4iJniPkbpDXmg1lJ2OwvTIlXoVjGNvV/gJx8MfXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:23 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:22 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 2/7] net: macsec: documentation for macsec_context and macsec_ops
Date:   Wed, 13 Sep 2023 16:32:00 +0300
Message-Id: <20230913133205.3749628-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: c91aebc9-f363-41b6-fc47-08dbb45ddc7b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0KzVlZS9yNWQE8yFDJomfFBSngUmb6ctppTcCD9TBf/h/uYHeH0F7JvbXn121MtpaQo5fL0qZeiFk7s0fmgqVzbnSnghi2xga4iruOMSuvAo373IlBPVyz2OYTHVKZClAsTk37GNiWZFe0RzAuaqrR8TR0nduhRsszDONFXXdrKXo3SN9mqGIayI0NDMe0xS1hr3gPxyJ11UQRgzSdmv1HpWGp4CyAf8fs/UU3f2SGARpY2jXnWXS0YSh8R1Noa9adCQmiQ2P+hJTuoW6UtBgd84FN7BqGgn3MBXhB0OboWb5dnDQ+Ik7kJ6i8HWk4cltQCNmBpgNWVw3j/3JyIQLCMUk3zUzSl40RNxIZ9aopXAPgm/fDqr/rIrqlLwb8uAx5D8qjuPE+hWSpxRyK7SGs/gl+97R69w5xVko/o3pFJFqODJAs5jRWEsH8IWFQokK90+kOuicRAV/vCAOqizqivfgnWZ7YyjBWixtv2X/r2/GxhwAdso8v30AG/NGIsTOxjr9JEuLjNC2q5H9kKneY0IwnKfGbrUFI5tzsGkJ9ILoAQMTMUbD8F5pgEvSgaWjAR+uNHETU90E4dHNDFxe4+soBxe3Au5VS/wwjZr1NrM+eaXXEwqBFxOJuw77g/GBBPfMedNjhkIttwOpPn2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(2906002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r44IKIeBfKhEi6M+v2+Et2PtXfbsw9UvWRkH0pLeFrx0aaIkbNoOas3H5mkV?=
 =?us-ascii?Q?mn7nTc7jSaTW1+DbcxRSJLfoadoJCG7W9cD65yjwQm84rOh6YtZJeZqQNnmx?=
 =?us-ascii?Q?vEJhSHa+5JAASf3CwFRcUSYb6y8+nSviZr12p3fT/2wFtW77XS7AgLGxTI+7?=
 =?us-ascii?Q?QDS1E5f7JmSyVxxI4FpyUdVaRWNCnPJFmr6WxgWrbMSYa4eN3/m27Ipx/EBj?=
 =?us-ascii?Q?+sjCJvND1CbdW0ExFVAXNJdi5ibFigyiAEnnvj9AN9f0M76En0zh3Qzoyaw0?=
 =?us-ascii?Q?2DsmRdK4BTcKG9mBVvqM/G84eKWIO4yNhBVxRzE4mcuAeH1B1ehCUCh54vf1?=
 =?us-ascii?Q?lfX4ftbMz7/IiqkMkkXNMuGnYzvk6yxizzPKZJxnIeQAqk+bKy7lyVO1HZjQ?=
 =?us-ascii?Q?lgYbDww1l+32zFpCCQhedrK9xdkpmrMqWDfTxsd1g+BM6y3UFbAlfsxI+c/5?=
 =?us-ascii?Q?D++i7hrhHdNiwx3abMb8n5NW4k8wEDIDdYUv5qy2ok+MvHnynezfiG0VPbX3?=
 =?us-ascii?Q?6nmtJumqbLRV7EdFojVSZQDa0GIeiLdUc8OG9sQdlDYJTnBNiAxKmaYo1cR1?=
 =?us-ascii?Q?HjAwADr/7RJV0Rspr4kC6Zxq/+vnNlAzh96BWKLnijUIBWtttvGFyFsr6/IF?=
 =?us-ascii?Q?xZNYhENTfVWXGWWfIP8NVidtqJM2bWVXZlbG/Fhf7wy2v/umda4+yC4iBirn?=
 =?us-ascii?Q?pJN8hVVcODrfloBnp99PpMDxrIkeLEukeKY3jCc84/dTlnWEm6HlZovAbRsy?=
 =?us-ascii?Q?GHxJsUmrm4clDpQVUaPii4o2imYFTnrRkjl6dYixT9JdII7/93xoUSXBgbwP?=
 =?us-ascii?Q?BReaBGXszBAJjPhyzZtRpSkuRTEZ7oUjsHeoAkFYmy8gkMnUBzJGoINvx+JR?=
 =?us-ascii?Q?dk7rBzsVUl4RBuLw1wcRU5ZnbT/JkCShJquqfBlxMgxEthqlccEgp7sqoYV0?=
 =?us-ascii?Q?4g+VKpGeSQU2iB2tc2tu/yxUG2xjOLgdvEsDSV4/4NDC9vbznxCFqlmQh4e3?=
 =?us-ascii?Q?oEDQFm6+jkKBtwmjqhNa3TeBPi8tAFvfrNokbHjmouzm2750qB3ycCEvyxkR?=
 =?us-ascii?Q?SVgnnKi2yx6RQYc2+S5jvaPAT11yx6BOhRb8rghIQLsTah+nM5ojBK3wP87Z?=
 =?us-ascii?Q?DTZER5a+INUAacoYPR4XsasukREMHdkKKKVNJemNL/aMbI2YbHL8PW9evtYO?=
 =?us-ascii?Q?m9vQr0O1btCiBRSzh8YobeEKubaeMhbWlhUZSxNdry1wKeRAi4ZXQ8kc7nhY?=
 =?us-ascii?Q?GtV1lefJpBx87mQ8tyjPkbe62BENdP3qEDNKR8R5NMSGZ11wv4ciVuN5OQE5?=
 =?us-ascii?Q?Evs/pGAS4bAtoEQ7pRzHOSIoM4yLWwJODG1CovriqVHGII495p6MGk9rvZSt?=
 =?us-ascii?Q?rVBbEMublfoIAkdTo6emx3iEnSO+kt4eBwZWN+S21lsLtA9ox9N7ngcNhJIQ?=
 =?us-ascii?Q?vYtd2wv+c9i7sNBR1jyg00OaJW8CBeeJCo3wAJU4DqLIdkp/Er7E+Qwi3B+n?=
 =?us-ascii?Q?5ZfBvdodcrY2j73Jbi5CwGevQTHyMOP4HjTZOCB52oV9gVIhhlMp/Na8hlFN?=
 =?us-ascii?Q?lxhe8Lphx3NRPfYT7xnubzN0iqGvziw7tz95d9EmkK96SBHEV/DqP59xCjuc?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91aebc9-f363-41b6-fc47-08dbb45ddc7b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:22.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QRRU1W4zOixaIwQPDV440WKfQrbnu9P0kA5RM0v3GD04kqfzVR00yucbm/YSQzycNl7Dx5xd2XyZlVybCk8dSRA7xpM+LWoGPALzp1Ug0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for fields of struct macsec_context and struct
macsec_ops.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4:
- none

Changes in v3:
- improved description for the netdev and phydev fields
- fixed typo in mdo_get_rx_sc_stats description

Changes in v2:
- patch added in v2

 include/net/macsec.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75216efe4818..ecae5eeb021a 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -247,6 +247,22 @@ struct macsec_secy {
 
 /**
  * struct macsec_context - MACsec context for hardware offloading
+ * @netdev: a valid pointer to a struct net_device if @offload ==
+ *	MACSEC_OFFLOAD_MAC
+ * @phydev: a valid pointer to a struct phy_device if @offload ==
+ *	MACSEC_OFFLOAD_PHY
+ * @offload: MACsec offload status
+ * @secy: pointer to a MACsec SecY
+ * @rx_sc: pointer to a RX SC
+ * @assoc_num: association number of the target SA
+ * @key: key of the target SA
+ * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
+ * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
+ * @tx_sc_stats: pointer to TX SC stats structure
+ * @tx_sa_stats: pointer to TX SA stats structure
+ * @rx_sc_stats: pointer to RX SC stats structure
+ * @rx_sa_stats: pointer to RX SA stats structure
+ * @dev_stats: pointer to dev stats structure
  */
 struct macsec_context {
 	union {
@@ -276,6 +292,28 @@ struct macsec_context {
 
 /**
  * struct macsec_ops - MACsec offloading operations
+ * @mdo_dev_open: called when the MACsec interface transitions to the up state
+ * @mdo_dev_stop: called when the MACsec interface transitions to the down
+ *	state
+ * @mdo_add_secy: called when a new SecY is added
+ * @mdo_upd_secy: called when the SecY flags are changed or the MAC address of
+ *	the MACsec interface is changed
+ * @mdo_del_secy: called when the hw offload is disabled or the MACsec
+ *	interface is removed
+ * @mdo_add_rxsc: called when a new RX SC is added
+ * @mdo_upd_rxsc: called when a certain RX SC is updated
+ * @mdo_del_rxsc: called when a certain RX SC is removed
+ * @mdo_add_rxsa: called when a new RX SA is added
+ * @mdo_upd_rxsa: called when a certain RX SA is updated
+ * @mdo_del_rxsa: called when a certain RX SA is removed
+ * @mdo_add_txsa: called when a new TX SA is added
+ * @mdo_upd_txsa: called when a certain TX SA is updated
+ * @mdo_del_txsa: called when a certain TX SA is removed
+ * @mdo_get_dev_stats: called when dev stats are read
+ * @mdo_get_tx_sc_stats: called when TX SC stats are read
+ * @mdo_get_tx_sa_stats: called when TX SA stats are read
+ * @mdo_get_rx_sc_stats: called when RX SC stats are read
+ * @mdo_get_rx_sa_stats: called when RX SA stats are read
  */
 struct macsec_ops {
 	/* Device wide */
-- 
2.34.1

