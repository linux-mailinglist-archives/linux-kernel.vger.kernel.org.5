Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FD7D3C17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjJWQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJWQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28110C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3t/wGFSe5J7o3cvXafWvvWkh7d6iBVwWFgggd8nFWq1PPU6ixv7hNV/AQXLDncgjGWy/usd33LUd6xtyBW3bzkgL9vmPkdCNj6+bBGBFI8hmp8XTYXDIZDeH1BVPUenCFozKzrAd7RSkj+fHTvdZmpFNDpDDXvYLJqqjpiNKs+AozzIc0vXORSvl4j2Ka4L2J7gN4m1b7wQ1gdUwDEskU0NVEneeTfQ16ydgajBccB5hbEjbuHfQr8JmcoWJ0bCTplUpEpaLra1e3yZA7oJVivoVhJUrAV024zLcL+dpq9M0jr14dHK8kXLZpb8MlJrkUoBFxOGJYla/X7HDJuYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJcAQxBYawmHt4F5h8Rz2JZ46sg6P7hOUVI6G6WO4qs=;
 b=CMHkEw+IiBtGz2jc3iBm2G6/UmHF/0YSoY6KizC6+1iZLG9LgT7ga/cBYqPiGl8QB+h/Ak62h/E2HiyIv2AicM2xcwOscNXzxVtcAuWhF/Co4zWoK2ovn8UZo+VCyGGbQwfwEsm6BwZ9iMF485Ot+jKO45roGZOvlo23oOBgSvKwxAOgBpyEdNnPJgEjcg/DW6XYXGcAvRFV/XQq/feCQ6hE3Rxjv6c2TYSzyg4csE18RdnnkoJ+CdMXNL4sbonumAkQoSvI/ZuhKVSE/SpXKIpkyvuPGW82hn/IqpU1dUZYdm5p25cvfP5HNfPtye6fqFJwx4zGjUFRLDSVHVBcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJcAQxBYawmHt4F5h8Rz2JZ46sg6P7hOUVI6G6WO4qs=;
 b=YfrBIctZZvCqD5SStvTd/2NQf7LjhG9osMMGjVSGMEGVVlr23Acc93JDvsl4IByr33q9hwBP+OjUsGY+rm5NfWpwaPkCuGMWqH1FJ2n+oQ9AstciU74gkND43AqSFyiAXQyR+yCfUNozw2lxCjs9NpuBATta2m61pXo9TL3r+CE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] i3c: master: svc: fix wrong data return when IBI happen during start frame
Date:   Mon, 23 Oct 2023 12:16:54 -0400
Message-Id: <20231023161658.3890811-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161658.3890811-1-Frank.Li@nxp.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: d48a6b18-aad1-4ba2-8d2c-08dbd3e38632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGJt/1i3AbMH/FS7ITSmYt0LuXfN1kl5jLs0pyRLtgbm4I9f3KHNfBEjCmN1amFEVdMQ8NM06UH/ZNflZ/8FW8K/ClowR64lYlfo7TzCVt5c7Cz6WJ5Zr+FopNkV27S1YiXjaWTME0RnhkZTbqT9jr1SHrSLAww5kNE0wY9YJsFZSu5ZIW9PfhpYL+OiPzCidxWH/VXI57fGAqwtAx5oL0yMsj+qlbzCld8mTmsowUK4ywtlMG14iZZhefG90BJIchEWzYPQKttkirDmviKW+WGr6dTs/q1uG1eTMPAF3wKA+OhlKzHq0A+44RLfzQWFy9jMEVl6KftVD6WLsu+BNs6rNAoBWXMw9VRreaml2i38BWITJE5c7LnKaRH4frHVahXbDa/L64MtLUbhTzrimutLggPDYYP/zXqDEltQuzvXotHluTmPzvAMC3j3WfwYhbDG506dWYYrSra4fbkqlyQp88IdG2ESMf4QEjWNr8PDlKvf2JLwcEZFusIZ8BSSFYU2PdjCRmJ+qF8n0U6BKPX/5vZm7IwB7/wIjSDzhpWvIDQXyblIY+AH/Vm6NtegahEkEdu0a7WuhM0AvKRhFsRgVecR8OqwtD/gwiqfwopTvAHL1Iod0KBb52AmUlio
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJJSGZjQUVLUGdLWHlhcU9Zakp4TXRhSlNlbTk3NlRGNk1jNXRSVjN4Vjhj?=
 =?utf-8?B?eDgvS29rNmRzUXYya09Rak54ZXROeGxxb2prMExLbUNHMEFyVnJXWFRucFdk?=
 =?utf-8?B?RktpZUtaQ0dJYnFOT1AxdUlWNGVPTUh1UlhUZGk3aVd3WjZnWkd6Z3JXaDBX?=
 =?utf-8?B?SlVDQVZPR3lLTUphWUowdVY4bXRkZXVkTkNidEVYOXlCczdWRkxycUNQVU90?=
 =?utf-8?B?bGxEdHdjbFZYeHBHYmt3WEQrWXJaeE1BRmROMWE1bjZzRkF0RkJVUXpWUVZD?=
 =?utf-8?B?V2JEKzY1Z0trY0ZkYTAyZkNGRGRpVkVvbWlDd0didC9TWUlSVDJCMHoxUzVE?=
 =?utf-8?B?YzJqV3FYZVVoL1J2R0ZZcGxJaUNrbTBqVDhhYU1oQXRJcDZvdWVQTytRcEt0?=
 =?utf-8?B?ZkQxV25KTk9aVmlqVTNwTFlvUEpXUEw3eDhIL3djaXhoZVloOG5VWVBFZlJU?=
 =?utf-8?B?WUsyem1GWFFBblhYWXNPdXBzY245SlFZeEpGSFN0aUJ4RERYZ3h2VlJtZ2FO?=
 =?utf-8?B?aGJzL0xPeDlnODRDMEcvSkZiUDRSb0JBZFFQSEZRRW1WelUxTmRvdFRvcTJW?=
 =?utf-8?B?cjNhaExtOGdWUjFzUW1JNFk3M0hZdnU4UlN3dUhQRXBJVmpuTi9EcEJKZHpl?=
 =?utf-8?B?Y2lWRkhCeS90YVdDL1NXbloyaXQyZWRWamFqVlprbzVvcEE2c203SFpobXJB?=
 =?utf-8?B?WUsrVFFwTU1KVzlsODN1VysrNmlvWG43dW4zMHZWT3h3RG1aRFBpamFYeEVI?=
 =?utf-8?B?aWZHOHVITThoanJOVHhLditnTS95UTllMTZvOWNBTFhEU3pyMXE4QmJBUmxK?=
 =?utf-8?B?ZUFrZFdGMnltWFM0d25zdkVMakZRaHpDcVBwYThMUlBpVXp3cldsZGg5UDJY?=
 =?utf-8?B?eGVFZmdkU2gyZWE2cGhYdUxmU2I5dElWVGJkb1JaZHgrbVJTdFVRNEdod1lt?=
 =?utf-8?B?SzcybUZkY052K0VITFYzUk5uMy9wRk9BVUdWZkhWejFhVTBRQU5tU0NGQUc0?=
 =?utf-8?B?YnNvK256NTFrSGI2ckNha1B3U2lrM2lvRWJYNFFDV1VvM0FqbWFrNStobTZV?=
 =?utf-8?B?ZzZLVU1EQ3YyUmFSUWdjTWRhd2FnVmxmL3VMYkx3NUJRTS9jUnFSdjY0ZlRM?=
 =?utf-8?B?UDVhUE5KYzNpUXkyN1h6d0dLbTQrRlQweENXTStqU082SkdXM0Nqa2NNK08r?=
 =?utf-8?B?T2hadXJ1dmszZDVSc2VDY3AvMlBGRHE5RmN4V2ZCQjJObVMrakdLb1VpWmg4?=
 =?utf-8?B?T1FyQ3poRXo3TDRoWGhiYTdCakQ3Qytpc0dwL3NXMnI2OS90eUk0THc5R1Nu?=
 =?utf-8?B?emJoK2ZkZERzNlh0Z0E3V2VBakt3UCtWREdYRGlMd1ZucTk4aytKcDN2VkRu?=
 =?utf-8?B?ZERadlEwL1dvemtrRVIrUzJFUElQbkxlMUVlem83SXVXVkdKZ0lOdS9raTNW?=
 =?utf-8?B?a2Rmakd0S2FXMjdnYnpVZ0dVamJBa1VPZndSUEZaUU9DOWFRTENqTnZ1QjJX?=
 =?utf-8?B?NUU3SUVqS0NIWDlReWw3aFJoYk05aGkrdlBsOCtaSDViS21JME9TQXJPVWxK?=
 =?utf-8?B?WHE3RDFISkU3ay9KMTZnYXVHYlg5Tms4U2dVZXpLYTdmaEppN2tNS2ZOODAr?=
 =?utf-8?B?ek5Fa3BmUTJHUXlKR051MldiRmpGdy9QQjdtNVFOZVhxS3RTZXRKL0tBRDRS?=
 =?utf-8?B?WDg5K21Cb3hSbjZackJYcndMY0pqZUJwUStTeWVrYUJ1OGxzQmRmdmY1bEhS?=
 =?utf-8?B?RFozZGNCck1QMFl2SU5ZeFVaSUxlaC9MSC80eW1lendEcnJoZ2M0SXpMMHFR?=
 =?utf-8?B?YzEvcjl6VHZTT05NN3hPSmR3NEdLOE10VVVpWko4UWxkeVprRFBJYWRRSC83?=
 =?utf-8?B?T0ZVTldhcER4RTJVcTJrUHV5TjhZZUdnS3RtMjlncXluYktjalFIdEJ2a2NW?=
 =?utf-8?B?b2RVK1pZS0llQ1RNd3UxZnZQeTVvUVltV1FPZi83OWdzcUE3aWEvZEltOCty?=
 =?utf-8?B?RFZWYUZvMFVBS2xJV0JHK2ovSHNuNFVLdzROSXFyclBlNlJzQXowaEtvRFBu?=
 =?utf-8?B?RG9SaU9Jb01UVmVHSm11aHJFdWFWY2FvWmYrUkRCTUJrK01Mc1VpYXpkOHYr?=
 =?utf-8?Q?+YCdSaeRYv7SLHB7psO9R7Z5P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48a6b18-aad1-4ba2-8d2c-08dbd3e38632
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:16.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM+OSme/CEM72+aqI7lUpTxo+9mEMSHpDKBsP/oAyHAuVF41ruJPbMCMYdWcQHyW2wgs/tLljFntP38UvOHlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

If an In-Band Interrupt (IBI) occurs and IBI work thread is not immediately
scheduled, when svc_i3c_master_priv_xfers() initiates the I3C transfer and
attempts to send address 0x7e, the target interprets it as an
IBI handler and returns the target address 0x0a.

However, svc_i3c_master_priv_xfers() does not handle this case and proceeds
with other transfers, resulting in incorrect data being returned.

Add IBIWON check in svc_i3c_master_xfer(). In case this situation occurs,
return a failure to the driver.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - When -> when
    
    Change from v1 to v2
    - update commit message
    - fix typo yeild and falure
    
    Change from v1 to v2
    - update commit message
    - fix typo yeild and falure

 drivers/i3c/master/svc-i3c-master.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 8cd708c965085..abebef666b2bb 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1010,6 +1010,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	u32 reg;
 	int ret;
 
+	/* clean SVC_I3C_MINT_IBIWON w1c bits */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 	       xfer_type |
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
@@ -1028,6 +1031,23 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
+	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
+	 * and yield the above events handler.
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

