Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F707CAD93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjJPPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJPPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:32:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBFB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVkXKgA1+LpgBKJxpjyFd/bVugKjzVctsj3qK7B2kqE4GbY3rHdSw36nQYzu2+0wwbW6pMcnpcQF/Hgwc8Un++7SDSlUeak2hy7jcFmbZi3GofDeWdiebOWXkUJT2/UqFIG4Np+YIURQB3qjwvimmEG8G/Ny2BeFndW3/rVc4Dxt4iq9jh/vQycd2GLuv0nJ0z1hmKECymLEahE8Pw96R7Sc5MkVfjCaFjn9tp2tpvn+qYmGwh8GZNiq8aIvWt6tCa1GdeDEumS0O6PE13hAqEPP9//4E5tPf/+3eoCmoTmSqi07h9DggO9e/37epF30/n8Y9+vQhGcZDXnkk+uiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvIe54O5QCnNX7y3AwVwXO/OJ5Uma3/csUrgUguDejw=;
 b=IUS65wvn5eLDwJZ3br1/UW3zgvgVXBI39tw9TNPtFs8K4adLicWHfC6JKVWaL05opnW3DzbduKiAvq8Mobh62uuAH7Lw4fvmj5M8svEtz9gEVZAFmoSImClng2ePpe7rnhwe2awpGR3QY5pTdMgVYrJRTZf6EIUuYGIQQ2AkPvxZCINlgpAu5lers+jNSH4xFCTJou820pa4Q5lxvI9kmlu5up4uMgoJU4e6YIWlU3pMcqUjQEGHO4LmmiM/EhuDZd7KPkclZn/SgBTPx9SRz/8AAqUf55zswI3hEEy1OPwXqYUuZxMBYAvcwPLJfZNZi7K4roHXIO4nzpL0Ykv3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvIe54O5QCnNX7y3AwVwXO/OJ5Uma3/csUrgUguDejw=;
 b=AKApbANDLCdTH72KxQAaf5/ykh5DjBg8ZE7TyhA0Bc3H/h4ey0T9ytt0F6XAgs3S0MxxNU4MMzcrSymTtYWwyHOavV5AdWU5kjwz6okdB6XaytQCKUf1QNlFyhDC5NYTU70FPEcXkdWNtgBsdlM/cY8A4vTB9Fk6zNgUyCjymV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:32:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:32:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 2/6] i3c: master: svc: fix wrong data return when IBI happen during start frame
Date:   Mon, 16 Oct 2023 11:32:28 -0400
Message-Id: <20231016153232.2851095-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016153232.2851095-1-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bba315f-0fe9-4cbd-5aa3-08dbce5d280b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfD4F+UQUfCfQWT1KV3mgpduE+31+aM+gYyYgpwFlKHkL8HVnQM5XSoQuFmO8grJdRmXUFsagROQrIFyxuM5axm0Q4wDWSavbp9T47D+kNR37FzpLk15zcNt/119gM3qeCYExJb0K+GF/K5tdFp29J5FiXWjzUNuVM/UD5pEJXsVdZLW+iyL5RZeStx4uffpcjPljohq8tp1pg6xLWM3ytd0jNuxpWpSmkHf6rjU9T/3ri2Yyx658YCZL+MIbuHPB0CWIwO8zihdnDzugE8JgZ7ZJctZPCdrKI4Au3UcYa2gXPXjqB870l91KQkhE8HIN3cWZN3Uy/c4wZK+yQHnXoTGeEHIp8Pu1xuWojyE1y/MdtSKEffn8KGpYB+LuRmEmLVisWMDY4MDsWR1EsnuzZERCPsO7CiXsEXXxQdOWRVa/MNrhkLlsuGtLjnaDNIY0/qJxVAxoRffRw34l7Uhnx4f3HwNUvkLS/JH9c0A9kfpjsBATy1/rRJebp2IoU5zadqn51WuTXCdQg/NVPUopnipD475qbbrig8XsB1sJ19RFVEin9HVPCRa3QFxCKYlbZ4DWOEi+RD5GF1ksE73DeDtm0CEQ+TYobSQGxAKy39iww53Lg3qFKF/dKeSt8+r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(38350700005)(36756003)(38100700002)(83380400001)(6666004)(6512007)(26005)(6506007)(316002)(66946007)(66556008)(66476007)(478600001)(1076003)(2616005)(52116002)(2906002)(41300700001)(86362001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlrK1lobmJScVpmSE9UR3Nuajl3VlM5NGVac3haYUQzbVBLV2dxNlhjTlFJ?=
 =?utf-8?B?Tm92U2dIV2JrUkNEdmVaUEJQS1YxeVhLTXVRTkQ0UnpXeXM1KzNsSGFzL212?=
 =?utf-8?B?cXRUQkpyMnEwcGlIaGNlYVNJa2YrYlNTTjQ1eHhzVWFxc0JDdVdYUjQ4eFZw?=
 =?utf-8?B?TjlFQzVBOSt1OW9Nc2cvbUVnWlB4aER0enhRQ1o0T09jV2ljZTJkUm80eWlP?=
 =?utf-8?B?TnpCQlVPRUxPdEsvQjl0ZWFsTmI0bGpqNDVHcVRzTThYWW9QZkF6LzVPTmpj?=
 =?utf-8?B?dWRCdkpPMzNhSkhGVld5VmRTM056N0tscWUzSHBJVnFMZFdRWlhUWXRQc1dl?=
 =?utf-8?B?SFhzcG5rTmM5K0JSWWU1VTZDYmx5M1Nac0I5bVQwT0Q4RGRkTUZFQWxPQVZu?=
 =?utf-8?B?L3d3Z1RXeUJFWXArZ1FxWFJiMWhVQTZYdG1ndzZYeUtwelJldVRrV1Q0bTlR?=
 =?utf-8?B?cktlSlVyVVN0QVZSV1QxazRINUwramhLWUgwRk9va1dSb0J4Zm9HQVdLRjZL?=
 =?utf-8?B?dVNiR1l6WDhHcEpXSjNQRnRiZ0FSZGk5SHFIckN2ZzV0TENvWWd3d0ZyZGRm?=
 =?utf-8?B?Tlg0TWFuSjFkMG9ISEtUSDBDRlcyb0FJYUE5a01nUkJJcDV1amwzV1JsdXlD?=
 =?utf-8?B?aUJvbFhIQnJNaDlDSXpJTE5RL3Z3ZXhRK3pQdDd0ZXFwZnEwcElDS3NFOUlt?=
 =?utf-8?B?czBtQXl1SDI1MnNlUFJTSXRoOENSbEliYnNSaldWQ1JHOTJHaG1yT0diUTV1?=
 =?utf-8?B?cFdmckVBU1VFTU1RYU9pUVVqZEd2cWI0a1JRYzliK21xQ1pSZk0yVDlNTkhX?=
 =?utf-8?B?REQvSnlqMUx4eWdsZnJ3U0J2Yi9CR3VRbmdBbUVoOEZ3RDFtcTRYSlZOOEVY?=
 =?utf-8?B?VEdDMld3bmpvRmttZjVqYk1MN0FYOGtnc3ZvbU5iMTN0NURqUUh0TGt6OG1j?=
 =?utf-8?B?clJocnFIQzVQbHNsMzRhUVVwZ1JLemdEbkJ4Sm51VlZ4cVFJRWd2VDE1MjZn?=
 =?utf-8?B?a1c3dzlEMm96M0tLNlhQVTBwa0RSZFBlMCtEM3h4UDhxYmNtamN1b2xaUVZS?=
 =?utf-8?B?WlV2eDMwWU9GL0JkWTJWSGd2b1ZLUWJhUUU5Z2QvNXRWUHVIVWJ1SFB6R0Z0?=
 =?utf-8?B?NTJ4b0Y5d2c2SlVWWG52UHFYdWxDYU1DQjU4UnZudGdLWkdyR1B3ekZaVXE0?=
 =?utf-8?B?UmhJamlBMTNUMzRGY1NvdWxjTUhiM3M5QVB2SWN0d0ZtbHZoZFBVcVhJU0Np?=
 =?utf-8?B?SkJNTEYyVjNEOGk5Y1VMbkdpbmY2dnJ4RmU4STRCY3dNelVlWjRiYUhwOVZ0?=
 =?utf-8?B?VThJdmhCVlNGWGlMZllJV25DN1BRNWhMM3p1STBCNVNwSitabjR2MmRzd2JC?=
 =?utf-8?B?amVMTkQ0WnoxWEJRTndBRk8wRVNyNm4vOERsUHZIUC9HS0V6TTFHQUtZQ1I1?=
 =?utf-8?B?ZnY3dXJFNEd2ZjNtZVV2SVZRUlhMbFRqclc3UktRQ0UwSlZRMk1FZEJjditQ?=
 =?utf-8?B?T1h2OXBaaU96QTVKeThCSVQ3dllHa2FPRDRmRGF3ZUJuYUtoaXVoTWRIaGFL?=
 =?utf-8?B?UEhra05QdXgycDNkNkFGTkZRa211cWlDYXE1ZWQ4OElpZjlLTlAzbFBKUC9a?=
 =?utf-8?B?UlloOWZ0cElEK0RPV1haeVNlN1djT3RRU083ZEVCQ25JS3NNSEVNbUdqdXpp?=
 =?utf-8?B?aVpid0dRRW1JYnhqZ0NwaEhzeUZ3VmF3YjhNZG5WL2pyelZlY0x2eUk0WG9O?=
 =?utf-8?B?eVRIQk9pZXJvWmJ4VjQzNFA1UDFyaG1IQjJLNVd2aGI4VWVuNUVrTUZyUDBW?=
 =?utf-8?B?MVpWM3NOM3M1aGhxRDBFY1Exb21lcWlqMDkzc3FDYTIxbGtBb1JVRmp1Unc4?=
 =?utf-8?B?b3E0Y3ZmQ2ZTdSs3Zkc4bFVGZHdpY2VSWnVEL3VSZ1pJazdSeTBkSTZncHpn?=
 =?utf-8?B?cGMzMXpCQS9SZlREZG5tRlMzV1k0NnRqNVBEeVdOMTBqMTFnNnlpb3RLY3U1?=
 =?utf-8?B?VUg2bnF5TXBGMnExLzZvdXRpSHNSaXYrS3hKYzEwdzJOZWJEalNYbzNMOURs?=
 =?utf-8?B?SFYrY1BJSStNOTMvdjdOVTlvbzhVcVJDSXBzNHFJMmR3T3pjZDZ3THB6dXdz?=
 =?utf-8?Q?0oA0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bba315f-0fe9-4cbd-5aa3-08dbce5d280b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:32:50.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULMIngN0t84bbebWLfXv0QzBaEJuC2xkOy/Txofu01yrltD6TSf0nnYFIieoQ4adtEcl4ZDDYKYqrBOTa3IrOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

     ┌─────┐     ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┌─────
SCL: ┘     └─────┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┘
     ───┐                       ┌─────┐     ┌─────┐     ┌───────────┐
SDA:    └───────────────────────┘     └─────┘     └─────┘           └─────
     xxx╱    ╲╱                                        ╲╱    ╲╱    ╲╱    ╲
   : xxx╲IBI ╱╲               Addr(0x0a)               ╱╲ RW ╱╲NACK╱╲ S  ╱

In-Band Interrupt (IBI) occurred and IBI work thread may not to be
scheduled. When svc_i3c_master_priv_xfers() initiates the I3C transfer
frame and attempts to send address 0x7e, the target interprets it as an
IBI handler and returns the target address 0x0a.

However, svc_i3c_master_priv_xfers() does not handle this case and proceeds
with other transfers, resulting in incorrect data being returned.

IBIWON check has been added in svc_i3c_master_xfer(). In case this
situation occurs, a failure is now returned to the driver.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index ebdb3ea1af9d..0f57a5f75e39 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1009,6 +1009,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	u32 reg;
 	int ret;
 
+	/* clean SVC_I3C_MINT_IBIWON w1c bits */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 	       xfer_type |
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
@@ -1027,6 +1030,23 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		goto emit_stop;
 	}
 
+	/*
+	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
+	 * with I3C Target Address.
+	 *
+	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
+	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
+	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
+	 * a Hot-Join Request has been made.
+	 *
+	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return falure
+	 * and yeild the above events handler.
+	 */
+	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-- 
2.34.1

