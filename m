Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34B17CE201
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbjJRQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjJRQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:00:00 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427511F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MduOfhjH/LdwUtG06Ew2098PgJ41MQQqrwjzuPOmaMZ+kdfrCdAo5mkdBECZ7KY7cyTnL8sussEv294xYC35MXlJoQlmof8tnn0N7a2FbhdzVVbKnfA/Z2YG5SYMkl74zAxlG4GdqQoyiVRpJx3zJHDHODWAPn7f7n0+5Zs+laiflvXFmesFp/kgGa9YW3SCez6ro1U/CqBo4M87ELzR4If62Ig7Vyx7NJ+e+gxjMw945t6VaFUkkAiwpJrMuoz9UcqIpDT2p7YEo8uxx00+amz7uIuYhLAIR9sUmfHWAna2cfmN+OM2gUMJQO3+5sleqa0/YaKeKsIPXPyiARmS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghMi/AjqmeuflsZPjowu1AoqUyQlM4/JO+IAd05K8m8=;
 b=IqOEH9CJS+j9dxZgR2yEbWh+JmUh/sLcmKqYDT1JcInjEj1q1OpVah+1MS5UlNqst2JKpLe+NaAJSGEGY4YxkjEBEsjhlP6QYLMvLmmJTmn66WBKKrSH/65++LyaFneKf36pBNftWNLolvw0UKmclVJENRLruGPU18sJN/yDNlI5NRXSPx0w7c4Lb/SuLqTX0gQ7Iz4gJFRGv0EVxKDR5VmVQ+Ja5fkz/68AJi6H3nAbhneS3uOA5oNpspcBNo3T+IVuACxGXis6xHp9HoIg9JiudVmsyYI/aHWHzDtaIdC4g9GQqJqCINTFl03FhtQ2Yf06tGuGmin00kBSvSy68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghMi/AjqmeuflsZPjowu1AoqUyQlM4/JO+IAd05K8m8=;
 b=lGEcrEycImBcT70mVsCuAnZY21OYSVIRJDOB7ZuJ0h3aiJ7OhrKCnbpR3uK8N8/IE/IrAC5nhfzjtUvCGegecrC/uaZi2t8mXE4rbYwT6Bz+QyhfDGYHquIcicAB8lYZ1nv+8oM5pEZGXLrmUAOEB01edQxL7bJOV8fnlTQf1DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6966.eurprd04.prod.outlook.com (2603:10a6:20b:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:59:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:59:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 Resent 4/6] i3c: master: svc: fix check wrong status register in irq handler
Date:   Wed, 18 Oct 2023 11:59:24 -0400
Message-Id: <20231018155926.3305476-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018155926.3305476-1-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e072b63-f091-45d3-ba7f-08dbcff34432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4fWw9ZM8N/m5xDM33uJ4HdiK1ld3pQPedGUKi85zJ7BYmqeKNBHHm3k3uncepvDYDO1wxa+PDeIvF9WgX/GG9grnqHKs7d5lgUeSwFXaVKI+o+epSOt+8MtfzQw2za0T/6WyO9dYtxIe7D+zCEGdCcUa9lMEwSYowBoM9Ciz4EiGDFIMYo8XETPKBkr+DvX0cvmriEDGtwIXBo94yPEdhauW3RKMeFd6yoBY/ZieUYvOR+qg9JebAVKQ0k0phl3LDlbqp+VG6ZiGur0MgUWze6c37H5iCpb2+rl5dgX40HUe/Vh3/Kp2lHf0n7iZP4XlVnOtTxk4CVkKWxFP/n8xcDMlK+X8DrQnPwqAjOtJJLlrs+gacZOytas2CB4im5CoR1V6+IQHdj1Lm2ZhDRs5iHlpe/LUTcEpQMJWeL2/TGKE4Q3qXeSPudiA5wiXFF81XOpw5gwQ3/aAK9Xsnl7b+brW1Jw5EdIN1cNoNMbbruwrinynuWX3q55flh7p8/UfXKSz2q+FyrXf+6PMOjEntJ8nLg4jXrfa0Eh6xXygVRbdCO0qbBal7zguc6xNFxeaTIN7FFNgTP1MLcwBKTjuHL+w1RNVcUOBy4NQavVp2DFrgZhkJ7N7WU6KakYi1E7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(478600001)(6486002)(6666004)(38100700002)(8936002)(5660300002)(8676002)(66556008)(4326008)(66946007)(316002)(36756003)(66476007)(6916009)(86362001)(41300700001)(6512007)(52116002)(1076003)(6506007)(2616005)(26005)(38350700005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h90RWPYZsEHs1ff8kqjfxPnbhINnOxCeSY332nStR/VX5ag39/snqoQidqGQ?=
 =?us-ascii?Q?fFQIoJu66AxPZnlc7kTOL4jNfcd9iWiWUe9vVQusFbKJBCBmvc7r5f6Y3cVF?=
 =?us-ascii?Q?PXO/R86DAQVpsxnNS+Ti+c1g1hCyBFmWYZN9LLzXUd+hVDMTpb4wg0y9D6c7?=
 =?us-ascii?Q?0EJRvx/4B7QEg0IbOcRlk11lmJTsAfZp1K9dgaNMGmgBOWEnpa/fi3O3Xm/7?=
 =?us-ascii?Q?BExA+wPTq0XQdalEi+bM7ysipCgvUkgWulMzxr9Ll1U7vlPi0/sEtRfdzD8p?=
 =?us-ascii?Q?wrnEDP8htgArNkTYOmZ4tbFhrcw0AOHsdeqxEtnUQ3QbCiaKQETj/iAJZ1Yi?=
 =?us-ascii?Q?rBhU6b/ZWzHicsUEEzEDFKOEmagUWI9RBySckoOO2hcp3XVpXHhSVqi3Mn2F?=
 =?us-ascii?Q?O/evGqHe/uZR93VcBwr2YSqyoNTiNnxJdZGRT80hjPzBPlI7h/0meuu6W4rz?=
 =?us-ascii?Q?V1s3jJTCXElchxIf9/Tr66sgT8SGLRb9rGlAHsWnEX9MpJhkEgU/gGtHWG5O?=
 =?us-ascii?Q?4afXS5hs1TeDZtetaeA567np2rJlY7QPy81BRJoaM1/WYvh9HA/Pka7TAg3+?=
 =?us-ascii?Q?UuxTDg1zB2vptUpDRxH4ekITX9GljvylEwL+N369NH+PcvRjgZ4Mn3seSuCW?=
 =?us-ascii?Q?fzrUjmJlmHsT0KgX/D4Hk7stkgB3r6gMZhfO49vY35dM0kw1naIYex5COj4M?=
 =?us-ascii?Q?VO25zG0kBvq5gBmoD4v8iqd0DXyNcDSbUmXfaVv1HVzh26OvOpUdBcGVeZcS?=
 =?us-ascii?Q?xAbC4gpYBd9O61YMk8P0RC9kI4+QylTPFDJ9KOKr5BjIRwc5xZS5R3Irhew6?=
 =?us-ascii?Q?ExIlfzbcGH5XuYj8VCAr7kjvhxunNkCCVLwVq7ipO+DqirkUYgkmY/MGTtPE?=
 =?us-ascii?Q?9ghsHNQS60htu7dj04nATx60QKff7MO4pYtp08NBRNYO1gc9Jh/RFZeleB4S?=
 =?us-ascii?Q?jaH885NgX5/Lf9xURk1PcZJJS7FWCYsSAGyjVJpQ5C/n6CcXjYYVgc5JCJzd?=
 =?us-ascii?Q?JAHgh8CiCzRgvI/6knK7VshuFSYivJv3kmzMQbcTDfq9frkCRw2Io3SNffbL?=
 =?us-ascii?Q?eAsHIbOn/fVmpHgTs/DkH3QhmR5mHaSc9bbATvzadIAVl+fo8cctUGD93ERC?=
 =?us-ascii?Q?Kg+CK2N0F30Irgrj3L6JqfWnH4zPW8MwsZLtzPYAn4URhJOT+cLDBhycaJGi?=
 =?us-ascii?Q?uL8mliC63o5es/MD4V7y5YvH4X3vt935nDoRz5HNDJr0kcKJjkfeD//bo0V+?=
 =?us-ascii?Q?77KIyggQ7uzseEEvVGsC9wiqoHfRZH1NjC6mRkoZqX3SqU77iM9/SxMus0zv?=
 =?us-ascii?Q?i3B2+dbYMGBga+1PQuDU5R7gHaGqLRD10N5ixb71+vUhvA1SqGmUqokCOhlB?=
 =?us-ascii?Q?8LZwQLpAeVOaTS5nT9wtD6NSnNTtdsDCLJ9Hes/ck2z3Kge3GtPY4M7RjFuc?=
 =?us-ascii?Q?ZVQEBTVIXDFynsqv8HO5VviDzgx0gHEVQeGtOPuDEJ4LphG3PtISW43/7Nxe?=
 =?us-ascii?Q?0qgItvDh27N786+2F7LXUdTnAq3E2wAOxP7Y0lRq5AAG4IMPnxsLJjQTYvzt?=
 =?us-ascii?Q?6W00SFhUlRFw8O5xC34HpCGQ8degTr4nKXLGPbbm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e072b63-f091-45d3-ba7f-08dbcff34432
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:59:53.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duZdMaKarVguVUIRRqL/0gLXw2QgJ+bKMv4PdDEGBcDAaZZbZctCzUTZ9QG7jSWK/DUfqaV3aileL7rRYj++VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svc_i3c_master_irq_handler() wrong check register SVC_I3C_MINTMASKED. It
should be SVC_I3C_MSTATUS.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Add Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index dd06b7c9333f1..b113460f059c3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -476,7 +476,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 {
 	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
-	u32 active = readl(master->regs + SVC_I3C_MINTMASKED);
+	u32 active = readl(master->regs + SVC_I3C_MSTATUS);
 
 	if (!SVC_I3C_MSTATUS_SLVSTART(active))
 		return IRQ_NONE;
-- 
2.34.1

