Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DF75787C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjGRJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGRJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:51:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DB8F1;
        Tue, 18 Jul 2023 02:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS8pJnPr08Ejm8C0JNYpdY4xbDhuOQNFFXY/nikLpwxKdEOYz69oPVb2RW4QifrcndEzK6Gk4AoT9BZMFIG85Yy7C6GG1Oo80BhUxHpodGrwpJNZGFECMviEftp3TGLRI5rHurihokrqSwvWvGFqdLZHMq2qgAhg2morxWlEyR3HpAT2gmm20/S8SbeMs2mqfxoUIIrcd65+BrubCcIoorL/MLiTg1nL+RxEKcWwPv8GNPiE5guY15v/aqzGgG4QHZmQ24jvbblk9NNOeX/0ny7YflW+qoIRkeFXH4NSZkOEYQAyNSCFlX3ytxZsyUJSHXVXn57NCeIW4yIorCxJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WikWkd9d9vvysIloiy7srXDggPWB1NrwjogQ2EBZejU=;
 b=BLJgKGzi2Ly6GZeXTVbS8+BabvhuenenPl2Ay93XmtXUgSNak5EGAp20y7sCqWfybKTSO2rus1sgKRptGmuldyiGzyb6Doe6gI22QX02Ieca9aFtjWyFBXw4A3wy8q/+mNQ+ocH2yAJqAS8K5c62Fwbn06CmTjbrVS8M/ypStzHKp9rZrY5TpnhXRswy2gti1Axv7gEraGnfWgJeizelmqgyPciqaZoWjoYomKPvQn5sgOR1bUY5T14nY/WXsnw3qO38CJtsb17aA8gtKaXCq951dbclZD+SMA++i924gYUHj/L+17mIoF5JgU4BFD4PRIVpGQR8aJXstEYjzS6AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WikWkd9d9vvysIloiy7srXDggPWB1NrwjogQ2EBZejU=;
 b=EObprGIqqmyGEtEIiwI1yEzypu7zVvEwCadTBqNgHU6PCO/i7Tgf5LqidVQ0+ZUXagHUM60zumfHm1yooYTIsf7BovcflqP+yLEC9GgQA3uYyedKV05CbpL74hm+d+cdlDVsT6iRIVRz/bL4rFYiUR9id57nOGHs2c1W+jDvuHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:50:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:50:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] media: amphion: fix UNUSED_VALUE issue reported by coverity
Date:   Tue, 18 Jul 2023 17:50:12 +0800
Message-Id: <fa299a44b24e787518cc36129c1b272d8cfeb990.1689673395.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689673395.git.ming.qian@nxp.com>
References: <cover.1689673395.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB8PR04MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: b63aea81-dc68-479d-0a18-08db87747d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzJFIYEg7X4tIczFJOtmTJO8cyi7Lar8cXx5XryiRRYl/MntVa66yw9dBSQ6D8KRfBHoc97um1UD7ZgfCi/xYtWiF/qw57pRdDmAcNeCkBhTvNgliFbkjP7C/ut5rz3FAAo6eNagR5RhrjHCCMSjOtKmwgUOXtju5Mg/aA85JPMBFrFZg0nKSkbWGL2uAKqHiO02rH8wfd1JucIDUUjSNFWkCMf0hDo/fVPYtB9mpM1JU2oqeGOTx6yY3inw9nhh1Nl06iiyWODXc2Kn9jnV8I4RfVngfKMWcL398sFpvsh7lqucVKLv42jxP3uezueyBzm978gVwTLgYSzJtpusq+FK9T4VB6gxu5NkRMvzx6yZpZopCoofMITihzUS13N4D0ffDrro+I53ePIS8/tG8FteFyksxoAotEKAWd6gf8hpNqvJ2VxHpuVoHGseLDbkLLycrzre2Gz5dZDixGBoFWKoF6zurVFTdNuC6TFZu6D7f5uhpy4j9K1OQTtl4J5+2tJRQEgEBchdxJwDc9k4WfXlWXl4euSr7/0J3sXvzmhdD0I5Ai8LSPd/Nzd/BsggO50+FMN65hK8r5uGqNtDCJz/tKgTEn2qGzfr+7EMEGVhE41/aajJLmDAxXdlFsWG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(7416002)(86362001)(2906002)(4744005)(36756003)(44832011)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(38350700002)(38100700002)(52116002)(6486002)(6666004)(4326008)(66946007)(66476007)(66556008)(316002)(5660300002)(478600001)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q7qA6zTkBBljR96zdPLUiqfqTE5PPU8eMmwJQ4MlSMxVwKxxCzWv9/LCvD+U?=
 =?us-ascii?Q?6QysZpH3wQrPaJJBikRSOV/wQ/ZrsMR2OyojQUMrMCKEXgioBasRWVgH/tSA?=
 =?us-ascii?Q?vUNEKXiJO+Y3IjGzS8VHekSaAeU0sPS929hOjZCd8cLA1QbKUQg3E6Znrn31?=
 =?us-ascii?Q?DtBuqetc5EDJdcK2/kS52dfXPndoPWQXlo9ZXhDHwTS63LG/ClwOvRDA6649?=
 =?us-ascii?Q?jGnYwVj3O2hHGFZwlCTvp9RZcGHhrHgzhusI2TY9IM82/VoKXDSlNkXrvEBB?=
 =?us-ascii?Q?yCOYew+6kFgGuQOG7O5vmnfeGjCon/Ve5/YqYALQEPzXEcFkzELWcaN0zw8C?=
 =?us-ascii?Q?D0s2UP0UOoEksKZE4nmErNYcHKptiaNsL2pYoGbB5TxhGg+n1ncPCuY68wip?=
 =?us-ascii?Q?s+8zXMS6xUzeRKZuRDWv36oF/TEXDGjJzrwFrB/6uHtCkjZsEzAFRLhj3bEB?=
 =?us-ascii?Q?GN59iN62SrKMM/162p3V7AEgmGF11McEgtbgia2YcmrAdwAQFvo+oe8NYMRe?=
 =?us-ascii?Q?z2KQmZ7/BfKYYROvaRmSsjM4AOy1o1Zb98mRIuZp92qFYOLnLu3m8XdATLga?=
 =?us-ascii?Q?+3bhC6BPp6NiVAta2DS3jY5BOx1l6NahACDRlLcGRPQjMy5Gi6rJdJCXSjlK?=
 =?us-ascii?Q?CzoJ9z/4JEta3a6jmic9sTKBo+nJNB1kXBDQ1vcCeMwHBVDgUAQD/hlagBIn?=
 =?us-ascii?Q?QOx7L0nprVmswehvYbIA9XXWGPjrKZtdObDi7glWp25JAj8K1R1JdIbIDDGP?=
 =?us-ascii?Q?1wUP5yItFmHZeAcjX0cACma+OQtdnTu4mMhDe37ge6pNn/UuRoWryQZllhBV?=
 =?us-ascii?Q?fiP+gRR1Vu/ES6GL30qPv3Y8LqLmqXhPJ/Rv5rFSy+/IlL+C7Qz9K34LaziS?=
 =?us-ascii?Q?cZjJlAJ9l7LhiTPsBnNARsPDCm9uop3Xdhlc0bCfh7ZFuDWWKFrv57KB7dig?=
 =?us-ascii?Q?RWnONYlIYAOLSMkV2RNfApxQrr6B5MfCNGJaH8Qk3uKJiJyx9SLSZjmwbnez?=
 =?us-ascii?Q?kSaB4/YG+zdf1n1dMjdAQjpEdUXcpEjyevcT7XiT8rpXja4DjDRNXfk3ZexX?=
 =?us-ascii?Q?hTdY1APzrzANy8vDkn/tjhkF5hdMC/NJAs0/su3XMVad+i8j6mVnaETvFuNH?=
 =?us-ascii?Q?hAdD9FxZxS0itC5b1nx8fThuGRMzfZhDUK/gwLTnjn99jR9lvY7pbf2BqqyP?=
 =?us-ascii?Q?lTBpcQwPG0mqJEIGusmcBMbAf1iSIZz4PspzICzU0KZMBK/kqn9KD1khqpnE?=
 =?us-ascii?Q?DQrFz0PYKr05dHHo44qSzv/bstHk3Qb/xP/mrqttOddbJdEGROsGW83b0PxW?=
 =?us-ascii?Q?nH0F022s+UlcT8qpS/H1HojllSHnGkX+dzyzM/Ejx2ECGG8Je2PUSxiPSXFO?=
 =?us-ascii?Q?TaJ3Uog0RSAlgy3yuvDVJgqLcLOOtuBPWUzfUNcMTBdh73A8rmKxyKednHKm?=
 =?us-ascii?Q?tRtOcXi/1szJpFzmNFhz70dIvHu97Tk8glm6r1vo5+Ln/0pdYHvjBiS5tcOM?=
 =?us-ascii?Q?GRsdCO2wsuze6jfeJ2Hb750OZr5ezYV6uqoJRUScAgC6IvKFdD6Q0BguCOtY?=
 =?us-ascii?Q?VmqUCyfu+ix444RZoj6vVSVmBxSBQZrZw7HNUJRu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63aea81-dc68-479d-0a18-08db87747d67
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:50:59.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2REs+6ITlCsC9rn4X6gmnbpAE+PPZfFZ/lvHh1KTVqavu6Pga6C7Hlr1PpHYfOWScE05jTTzdKQqGtLAdaGFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assign value '-EINVAL' to ret, but the stored value is overwritten
before it can be used

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index 7e137f276c3b..235b71398d40 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -315,7 +315,7 @@ static int vpu_session_send_cmd(struct vpu_inst *inst, u32 id, void *data)
 {
 	unsigned long key;
 	int sync = false;
-	int ret = -EINVAL;
+	int ret;
 
 	if (inst->id < 0)
 		return -EINVAL;
-- 
2.38.1

