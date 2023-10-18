Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340797CE202
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjJRQAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjJRP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:59:58 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827A11C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfaWnrYpE1jAknfEuW+BVJomXqFkgPRpuH3J2xbdsIHFxoGE/rzSLPrXy8LmE1WF/Nkp0NhjX+iFgsSiqgxSwEl4zkXPU4QYlGJTLJxFk+VOrQ8lQd2Tmqef5sU1sBqhq7Ya5QtUeorgr/Gl9SwQZ56SAPiWLqVVVkS4EDSX4B3pestrYx0eYGOvvnFJUSSwGrGupapT3UDtPml3Lqb7k+oArsS21V7VlKehxW/4fUzb3h6Dr3VnqTfsLkZGTVBnfdVBpqOTv4Z5m9rbiKwp6oEZNjUQpcUzStogIwXAgmjsShUZsuG17K7iKOwM2BkfhB2ZQRhJ8XK41WqAvvk1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nayoLnZA6AxlXnKCCet/C/KGKXlH5vBlf4Xff954ehM=;
 b=Cs6A+f+UA2MHIjh7xAS+eKueKVu4GRgxDqtIwRuftQ3y1KkWx0e75QSdSrNqOPYLevH/9w3UGr67zj6EyEjmg3o3cVCma+M9dvtetbQPpjmsBnZCHoqg3nMJXVr54o3oksLi9a0OV6wlGxjfy2PQ3cWg4jnYYsaUnE2C2r/ox/NQUDztLO5ME6/ztL0tJDzFmbZTdqzQJvPQOFVEm9kGGzpKSb4hxfLUVYGdk7jCOxH5zmOncvYg4hTdrtuizB/OmOGga7Qz0jCIfpett0PK09CdcJr0TZdmNBKXDp+vlT+43Z1wjjDfPnIVW9Ir8ULvcXpv2Pk+U4M/jaUjsHx8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nayoLnZA6AxlXnKCCet/C/KGKXlH5vBlf4Xff954ehM=;
 b=fGsyOL39waLA/RWuJbGv8x+k6tiNcRqmdvI9gY3nxfUtRD9D4HcuT4XSWqyEvqatBdMsfryPMAzk1MuIhVU1g3PkJeRFZ0JyiGJR60pk/ht+qo6A5tM5y7JC/LdqRf6NylCrBvvO0goO0DnrqR7507nOa0lY8ayi/rdVx1HSk+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7694.eurprd04.prod.outlook.com (2603:10a6:102:e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:59:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:59:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 Resent 2/6] i3c: master: svc: fix wrong data return when IBI happen during start frame
Date:   Wed, 18 Oct 2023 11:59:22 -0400
Message-Id: <20231018155926.3305476-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018155926.3305476-1-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: b3668cf9-f417-4413-0618-08dbcff34133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zU8c6VPiSrcWJUHv36UOlWkRAmNu97Wq+uEKfWVjc7WOjokflQ5N6N8479ayadzuPw7/Az5xmWR4jd6LoYNGEQM8yEnoP7ZomDxKpCn3d/zxyx0CEpetz6+INS1pr8ykGDwhxIJ0GBJ7zMUdH+agXXoH2aQVMRumvWOlRZHPk/8dgnKkAcqXhsdqqg0w7SDJ680PHv4ZbiNIerxjKY14K95EWJzRTeQJK7FqY1B6wowv18PiKgSMvq/nGnKz6f7IwsL9wP0uMRvONYR80MBXYGVgO17MRDtFGiqZVj/R7zsWNJsBtqU2OoNbNwdrUGecBtyZwNtRCUcN1dQW2K4gHgl25+NwKwPiK36RWUyU8A+PhHT+hqjKWF39yhDN26xBBl3V2uxHqIyA2lmQBRV06Vawg6qXhBJdNsBnQvKoFA46Wlax2MwXV8M2OwJvr9WFyLEIu+NBpzv6UA9G19MrS0xyd1rXGvzEMrRf6tGaAHCOd1VECPULzWFC3nNicc3Guwjb++2dP8FgekNz/qhuzZE6lOtY4Aoxoh1BRDCQX18OqS4/Ka+lE1Wil3SRfdyAIEc3yiC215XFIWJJe+KJb0N+mTQ18zPTbss6T6s4mZNJZk5CPVXoCXKbNkYkz+/H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66556008)(66476007)(66946007)(6916009)(316002)(6486002)(478600001)(6666004)(2906002)(38350700005)(36756003)(86362001)(5660300002)(8676002)(8936002)(4326008)(41300700001)(26005)(1076003)(2616005)(83380400001)(38100700002)(6512007)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdYUDFlMmwxb21DK25wU3RQMklDMTl6S0tib29la1BmYVRkL25lK09TWjh3?=
 =?utf-8?B?cWxvaU1WZ2M4NUZKUVp4THJHdlZHQVBwR3RIWHNJQXBjU2xIdUdXL2xMWjdt?=
 =?utf-8?B?L1hLMDI1c1NuTVRzU2NTSkllbEdzb2ZyMzRRSnp4UjM0bnVtbTBDUUhkVlNG?=
 =?utf-8?B?VDQvQnFZaGVMQllTTERZcmxVNmY3UTJtYWV2VmdqTnlsdUNPS3VjRTA5cGo4?=
 =?utf-8?B?VXVLT29aMk9zbHFvVEMrcEhKN0NVUHFlSG9aRlhoYlY3WXFST3JvSlYyYS91?=
 =?utf-8?B?ZlVYcXQrQWt0eEkyRjg4Q1FFUkZkUElKaVVSV1dhcjlHT1E2YkFIeEI5dUlE?=
 =?utf-8?B?U0ttdktyWWwyWFJGQzRVY1NCS2ppMVZNZUkzSzhkU3RKKzJTUnp2UmxvSkVS?=
 =?utf-8?B?NGVtZ2YrcU95VkVDRUNKYm83c1F4c21uY0loK2hHTlcxYVBvTDh5NjNRSGZL?=
 =?utf-8?B?MzZ4UWZ3RUkwN1FzVlMyTnBianEyVFJUWFJEc2lSaENZdUFiYlpEdnZ4bGNp?=
 =?utf-8?B?VG85bEVsa04rTHFueExsNnhHV2dSYThCMzNKS3BBZ25PNGdEOXdqVUtNVktp?=
 =?utf-8?B?dFVCTnBTVlRpUlIxWEpVZk4vUTZCNHUyUjN3ZGNVZk9HSnAreGxWMm14VGgv?=
 =?utf-8?B?MS8wajV1Z2R1V3hKN0JzRDJORXptSkk3ZjYzN2ZRSC9jVG9lRXlqdWFnNDBD?=
 =?utf-8?B?anBDRkE3RWRTUUxKN3k2MDI1Z1JEZnlPN3IvUE9wbFZNbkE0N016dGFXN2pu?=
 =?utf-8?B?VHBLajdSVkJEcDNOa0IwNTNJdmlMWTVjWUFZcmsyUFBJVnRodlArWkxLSERj?=
 =?utf-8?B?cnpkTWR5MkZ3UW9WMlZpanBqQnFMamY4Qys0dkhaU01Bb1hKOHdUUGtLYTBK?=
 =?utf-8?B?TGhmT1Z6R1pYc3kzWllpQzhCSXRrdUI0NUpVVHNUNGdvYUJpZzM5eU9QY3o5?=
 =?utf-8?B?dFRIN0xMU1E5cUE3QjY0elVZbGVaYTE2bGt3aFozZUk4aDY0Nm15TXVvU0h4?=
 =?utf-8?B?Z212TFF6bUxYMW1JZGdWN1dwVWdpcDd5NXJob2lxWGlZZVZSWEpwTGxoeTI5?=
 =?utf-8?B?TEx4N1IvT2V0RHpVc0ViMXJCd1hXWjdMQWRwbTJpOGdHcy9tcndST3g4Z3hp?=
 =?utf-8?B?NHFJOVpTV2Y4ZTZDQWN6UlZmb2twSnFFS05KMVJyWVgya0ZxcDRDRXp1UlR2?=
 =?utf-8?B?S3Q1Z3NvdHFvUjdrWEM4d2NXUXJqRC9QRUNGaXFKeHUyYkRBQnVIMjU1WGpR?=
 =?utf-8?B?ckpMeWdkNXJkMmh4amdDb3Q3b0lpV2sxRHdGaE1zMlRNdEpwUHYvQlI3TDZi?=
 =?utf-8?B?QWljQkpxSGxQMGdjY0I2cUtrTEtXeUZQUmE1bStnRzJTZzdsNFJzTWlmamt5?=
 =?utf-8?B?VitZNGJlR3MyL3JLckgycmdKMmxHODdXb2JtNXRXb0pVOUFtdk5BYWZLMFNH?=
 =?utf-8?B?cEU1bVBPRCsyQnJKYmxmWUQ5bjg1dUhDT0NsM0RmeTJHMXV6U3QxejB5cWhv?=
 =?utf-8?B?ZTd2WE5lOG90R3hrZ2c1K3FXUzY5V3FwQ3ROVmtGZFhTbGNjakNtU0duWWpQ?=
 =?utf-8?B?bFZhOGcrcFdnZ0RXbExVdlpRbFZUL3ZwQm5Hd1l6UWtGRFV3QnhvZUpMUHJj?=
 =?utf-8?B?UE40bDViNHFYM3VCOFVBdGZZVXRrOCt4K2tncFNFM0RFRU94a25GVXVENnJh?=
 =?utf-8?B?NkFaZFFsWFJveGIzenNJcjRqeVNFbHJCMmM0WkhPSUtOb2tFOGxOR1JTUTNh?=
 =?utf-8?B?ZlZzd0ZkTVJIWlU3dzcrd2xLSEF0emZqK0FlNlg0bG9NVHVTRHRndGRMOXJk?=
 =?utf-8?B?aUlnSGFtRW9iOU5QN09GcE1pVmdpZlJNVkNLWERVUWswRWIvemxGK2ZwNDg5?=
 =?utf-8?B?ZTFVRFV6VHJuZi92czFLZTQxNEMyTEFRTFo3dTVEVFdBTHM2cWV2S1VSM0hp?=
 =?utf-8?B?U2ZLV1VPRWplVVVKM0VzUFpQRlZYTXA3M0NkSjJFcllBRFZNTDdUaDRoRjlE?=
 =?utf-8?B?QzJ3aWJpWDBTR08vQkUxc0IrOGVTZGFodWljQzZZOTdSN0RNaWNDSGdGd2Ja?=
 =?utf-8?B?aW9MeGF6azlUS1lyd3dTWkhKMTdISGZKTEtRLzRHODhXNGJ5YjFwaUdWbUtP?=
 =?utf-8?Q?QgzfW1/VOEPaNgb8FzLp548+1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3668cf9-f417-4413-0618-08dbcff34133
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:59:48.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRsBa7JWfzK+YweX5EuEKX7chQbGcC9JZ5hku/S09EdEHmxrHjmRdQRqP6HzUZzLUXaUrmhI+Hx+VEVuYgCBjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7694
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
scheduled, When svc_i3c_master_priv_xfers() initiates the I3C transfer and
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

