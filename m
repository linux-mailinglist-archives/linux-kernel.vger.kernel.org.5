Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF57CAE04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJPPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjJPPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:46:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28838D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpE1/Gu8qSVjVtxiWq/3u9ip8SoHTJ6gJstQVrzci3Ps6yxiJZeHKBO0dV/bxfARQ+ShngskK/JmOnYOuPz96OVfyDVxSmsFEVuJ12Nm1rxQO0udkkuOz9IkZVgwRs9CtM1jg83x82X0xSYF+OMv7b8ZzSY+yMHmpAuM9XPLunz+wGDqmvtv3t97tpXj3v2I+UR2TDyoLUxv/lCTRDUyAFpYlkIs7d2qBDFdPqYqJiY5crn9NlmvRD3V7UQpWzYTzKfXMt/ZGbzpEeI8WQpG49eGaAn91xGL8aMRffbN7wnIXQtU+5EFrtFMzm6yjT5lXP0R7T1zXICYfarToP2KCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC4uwQKDKlFvTEP4XC+cCKeORb/n/Onc64lf+Xn5MAk=;
 b=UnxgJfb+KQiQwCF1IT/1SYF7MECKTm+lXkG5KTtXfZVdjNfqIbFiDoH/JEtXbQZ3FynWRbUEbWIlPbFYG7fJq0jwCbhUcQ9qCQj7V9HN8YN08iTMzSgbVkHoKN4RMdBqLlz8d0B8eLH74iBmrlZEcukVFRo10AkSaapKDZeMiunXUONrzY/3zUPXafKHopvjuubW1DlvOWQIp7GMpisfssYgoyMFMyw19Ne0RN20n24ocnYIaUkkODmIFUYI4OADR2lHooY9P1yAofQwwyLEnsNJdcA7qPbCiNJV8IqXlqviMnSJCbO0PyDgvD9X0bYov4sYgYL0kBYVBz3bmcV/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC4uwQKDKlFvTEP4XC+cCKeORb/n/Onc64lf+Xn5MAk=;
 b=jLEt/FVV6uDpNhuei3qaSI+goXO57oKtnw5yjgYGs+WWmnCbO63M3FL09Flcmpzb9DQEV3BqWurCIlxUjYU7EWl8HykwOAoyGXv4tHsdp++JHMg4H04xpyGfo2V+Cy54Plvi+n+N+CjRjgJus3Eiu0MtQnmXyDpUYhi5yDTqiC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:46:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:46:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 1/5] i3c: master: svc: enable hotjoin default
Date:   Mon, 16 Oct 2023 11:46:28 -0400
Message-Id: <20231016154632.2851957-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016154632.2851957-1-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a04a720-617e-4436-5e00-08dbce5f1c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pd94ebbfR+3dkAnX/5ZhnSTZT2kKLNly0Tok7v51wc1ooZ7SP9b42aS/NUmTKrGL9Rxw+m0dw6wFvwttErdYQQr4vyUqEPRRBv5wbVMqYW92rk4NZhxTmEnlab1Un2jreyD/fQJBB6OhNEXxEfpPTB5zvAmL/aNy0MEd2kymWmlLZjLhlhXPKkbxtXsZ2OjoB2yt5fdBr64kK289MK++oCxcW8fwhaV+dMZ5G3aoJEG516DSW6Wbf+XRLzoG8winA0vZ9SDaRe0V3LzdHUyVGJPxckJWafeCaQDUwtvfIawNvVZAHc3dMsT1wQI4UEI+V5zc+dQrKSdTap+o33sk5B0017kMeLDyKlrJW+H5w0TLkxYe7n3XD18Lh0AH2gJYW5BJLRG9tOtJTm3CN6l2zAxPHnKOE5Lffkg5x2sfcUuekeIVolLx0IMx6YdWoqzb6Gi2Pcgx0vonXsCv4MAC0atYVFCTfBSkzBBbItQBpBg00GpFQTp5rUVzG8s6fMEbajeTWoGgUdq5LDFC9vg6Es2LYcaYvS58g7uY2D7DlSlGHtjGRFP3VGVwkimJUkcyA7Ee+jeq4LVofAqfURTV77X29tnOsxPBTgnI+sfnJP+bte1+nvfH4gtEvjynsi/t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(2616005)(8676002)(8936002)(5660300002)(38100700002)(83380400001)(41300700001)(478600001)(86362001)(6486002)(38350700005)(2906002)(316002)(6666004)(6506007)(6512007)(52116002)(66946007)(36756003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1o3Sdf3+Hw+X3X1UE0VA8rBd9H3XLan3HNpLqpHZQ6Jctm6EdQkEuClyfdiv?=
 =?us-ascii?Q?cInfDxc9c1vUy4G03zv1OhkapS6uzhgSM25N8Aqkl+LsXHIh8OGEhLX1o7q8?=
 =?us-ascii?Q?jk6/FWyByt1rllpA2Gn0noERmQ5sSD99VOSACiAyUJNq+VFEsPVOvXfnIhYW?=
 =?us-ascii?Q?EMMEp13NkcTOH5gfkKDCpfO18OI7BK43Gle0REVoACXG9q37ujs85vwv800d?=
 =?us-ascii?Q?5GXkInq376u/G7j2Bk+/Q4BCw1ldwQReZ6nghGTeI3qjMUJ5+ELF9qHrhp63?=
 =?us-ascii?Q?yQpGdlWHEl1kfwajpjOf1pAdLSzWZK4XJY7HuTWy1r05Q1doKtb6nOJruPeE?=
 =?us-ascii?Q?5njks+fZBfjz5DT5cogHEqHLc4cpXDW1szO+wE1RdJftZz4BkBBS+E+GILUF?=
 =?us-ascii?Q?IkJfIznIQnBgxAIu/EmPjUBg6eIgG41U4mwKl4WCJRh/SGWdkgi4EbEcOBBy?=
 =?us-ascii?Q?MSFX1qga4Wu8iBemcxlYrLyvTfvvm795UD51yciOXk911XFks3R+dUnRoka7?=
 =?us-ascii?Q?0nURBT/YdH02v1Ib+e+8nO57EAHeCWcAwlYsWX2d8wJ/3appTBBOy0S2dkLO?=
 =?us-ascii?Q?lp+zILcKJzc/36pJ2UlH29XNBhhPnhBXGSoQIAfNOUSCxasxflwo039QF9rL?=
 =?us-ascii?Q?M3BU4yzeowKkdfBE6SniyJuJ3L1QcIZoL01A4M+pd5i7oeWj6HzPuOtUjc6H?=
 =?us-ascii?Q?MJY9mMvWhwDa0gTnw5vv/tZmhq+DCDqGEkEhZIaPg7tbc+9AND1Dbm6vh+Ng?=
 =?us-ascii?Q?Kr6LIaoKeF91oJKmztqD41rNQAGWW6lFswZXPm/quP9dRKK1+0FXJo48bx0l?=
 =?us-ascii?Q?lAedNbjj/T2GjFxVS9bCNw9WrV3XPJWsX9EpH3nuS7cxLApw141DXMGZjwse?=
 =?us-ascii?Q?AbNbNfGRMPVk7G0ygUmwrT3bg5LvqCM4+g0qk7PUIDtOktQGjbg4Ul83Ej6k?=
 =?us-ascii?Q?jz4gxg9wgF75Xw6iDhuPU7Rxny6TnKSElkcoPXmi/4emuT5P/Oihj+aLugUo?=
 =?us-ascii?Q?80/CcE+GQ1080VF632/SBhpnkd46iUMWIf0Vlk9cQGq48xUuGOHLRYBXQnli?=
 =?us-ascii?Q?r7jFSDIt0moKPlzOgb4oGSDjjdFfD1ADec9gS+CGyi3moAdKBkqvcnikafBr?=
 =?us-ascii?Q?kRssh+BNN+XUwcEOwQXxoBxRGKFCg8f1jHbq/ppVbSly95meT5/op2wkq/5C?=
 =?us-ascii?Q?owvRu5Ymaq2BZSZQBUpFo8t+BDfKYG/+FPTzsOtZDr0Qp+XzyeNEsl4hsvXR?=
 =?us-ascii?Q?miLThM4ITydX2nk5S871wzNCQlo07n/UqnNjn/u3VsqdWYMYIrxHEBPzTSzz?=
 =?us-ascii?Q?oijoLZ1Xb8xMklatNpd7v/vK3YUC99cTVT7vK+ABGo0UQBpRPoOtkYbrJn3j?=
 =?us-ascii?Q?2CcVx9xnw4P6b9BmBzu+SSue0+ngsxrohkHzyC726kKFDV9ehrUprOjDiB4K?=
 =?us-ascii?Q?2e8InA6w2+4gUPR7HAQYTdl7HxOAZKwwvOyE+P6mM/6a0/cnyFC47zcbScGN?=
 =?us-ascii?Q?+gq6dXULJ45ZakViRMb+a8NGsoynOqca+AxD+BwdMxMVQcUdji8PAM0WAglx?=
 =?us-ascii?Q?v6RvK1u4+v9Rkb833ck=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a04a720-617e-4436-5e00-08dbce5f1c8b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:46:50.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cOgdy+IuVBBO5JR4VEUYqsZFkWqRH3ZVBwlVs9oIBmViBzCdsBfknlAYltG9nCIGLAo+bFEh3VbJE54LL51og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hotjoin require clock running and enable SLVSTART irq.
Add module parameter 'hotjoin' to disable hotjoin and enable runtime_pm to
save power.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 18bc277edc8a..f0d99b029e5f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -128,6 +128,9 @@
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
 
+static bool hotjoin = true;
+module_param(hotjoin, bool, S_IRUGO | S_IWUSR);
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -1623,8 +1626,12 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	if (ret)
 		goto rpm_disable;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	if (hotjoin) {
+		svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
+	} else {
+		pm_runtime_mark_last_busy(&pdev->dev);
+		pm_runtime_put_autosuspend(&pdev->dev);
+	}
 
 	return 0;
 
-- 
2.34.1

