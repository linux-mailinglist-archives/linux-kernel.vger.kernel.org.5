Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E478DE46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbjH3TAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbjH3ORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:17:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DEEC3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBIYR5fefWFl0QhLhAS9JumF1YXYiOxl9T0q653BA4nqhr3EfvnFrLHqfR3G02Jg4fxCyzrqGhxpDyJ/D7WZTioFIVN9XhpcVsqxck9RoNyCa10I3nbrOah2iG9e2uc7YFT7dco3WDgjv9O49v+LrnrzKgar9EHxo/mGDj4wPNuCyJDsREFTwXmt0bQ9R228f4++5w1z208CYq92IO7LyqDWmjfEuqBuf/cpqvnEzk5mdsEZ8DUXJdGA0huDoeJaMNYdureEOyEYjCELC3tzIwd6Ufh2u8nNMu9X+Ey6zmUKeZnU7qunqEqkV1RvP8YQ6KH6dgU7j+NaK8uoBw2eUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mojyn39deYAsc5Hlyy1QnY104DFhnGSerOFCf3o0JbI=;
 b=iNsnr0vwS8RUMNhw6tcjsrhcWGiHgiArnyLdSgctab/+E/Nppcp1jRUd0YAKqJ7l0gENP0xJZ2eGgHLmZGRxQUAF1zNPto8XjI1JvvvgNiBvnCTX0N1Ri+KltOsmwIxSgftoNrQTbwo2QkHRP4svgQ6SBJb6BzdZ40wOmouPp52hONQefJmxqjiYqZxtxws67Le8T2ziM0s5OqlZkPDHoMelm13WclzZPubvpCO6sV67zV71tXQb3Jybx5e9tlMvBgLaGpe95ldXM9sE4EazRyJL3NWhHZT0UlpB4E5D0uXMcxOhiNx8ZbPquMByVVbBgLEb+mpDAozQi1fB4gJUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mojyn39deYAsc5Hlyy1QnY104DFhnGSerOFCf3o0JbI=;
 b=CX04i3hTLOmC5x8zCboF2lFcFHY6pwceTfY5OEGSo7jXaJ9RWhzpO0P4ei8La9hmThpwfyEki2K/VY4lRFdEL7UdbJIJ4n4t8bS05sunEn0d86ekpWLjGl43RUm+I5PfbNfEp/OB78KDWRqOV/UKyAIRYbdBmTgsKyQQf4nSgtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 30 Aug
 2023 14:17:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 14:17:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] i3c: master: fixes i3c bus driver probe failure if no i3c device attached
Date:   Wed, 30 Aug 2023 10:17:26 -0400
Message-Id: <20230830141727.3794152-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: be840c4e-427a-4b7c-0546-08dba963e130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pB38Fx3owMPNwx12TUIQSSp+ezy+C8Ahu8iRFBaUFDszyvA+TNmzm8ju92cKG+45nDsgmwQJ2W5wkwV99ZuRa2DeTsnoWB3QI+2MfcadGVYzY3ZgIIPtgNzQqYs6i8rK5XnCI9af9WxR4eOE5DDDB/UPiEQodGPAmkks6Y8G3PqkbqBR9Znh3uYa/p5TVFGWaeiPLN66kX/Fm2VCA5aMzMyghlG2P6LdvO5l+QKPI/1hEYcOS8HIZEAs83fPIAXWy5iZc6yM0f/2pVXe4clcy8lZEz08cywsD/jWx9TCJAf6yh0xH+hG6SUkSq+iS+t6EoEBKoX4zobvd2I3dLwOa/O2pEYYY/o3uc5bjjIS2jn2hhRMU8PIYiS8y0dlJ2esztxC2xf/RV3r/85hXrvDDTSfDYvVYBhUIoEDVMdy+mEAYR+WaZnrcl2gaw5JSEntOxRdqUaa1Gpi3uhxV7OKYXE6vi0jMf9hQ0vYbIEXuY9x6MyqPZhV8IKIFK1gdGfSmM+Ho41FcGyLcCtjoksBqcnUGV2O9PFPApDDbnPGB8KlmwXxMVdAELt8MkCfcZ2BcStJyyF8uYPLlSdx589H/EnCCUPd64Ge0UvKQtGvq8zC6Z2UGBR+g50Qa1r7B84Mhnt73O3HJm349pIahe21oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66476007)(6916009)(36756003)(316002)(2616005)(66556008)(8936002)(478600001)(4326008)(6512007)(41300700001)(1076003)(6666004)(8676002)(66946007)(38350700002)(52116002)(6506007)(6486002)(2906002)(83380400001)(38100700002)(5660300002)(26005)(86362001)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuEqGxyVzLqsVy55RYGtRbEeRuozruaEzls5X/59ofBP/YMjYr3UV9qi0Mb7?=
 =?us-ascii?Q?+M0ZeCGDJ8Afb2y3PUrkL2PsyOtVcj7h9BD390tJ0+KFViLt8XQyaFgEA3WV?=
 =?us-ascii?Q?LYKbmBYebbmhItcYxIjdwMbeAxcKO7DEqgdF11W+nYXQXdmBFbq4VQEF4vkg?=
 =?us-ascii?Q?eBQ1Ujgms9d/15e4giJ3xQI1B8nM1RobgK5eyHnZMtd3usHuwBjB6KXEBhX9?=
 =?us-ascii?Q?3XQ0coVo0FlUVGGMbBHWUyDQZ8g7OzIMPmTQbwj9nvGW11fnrAg+yl2Uf3q2?=
 =?us-ascii?Q?b9y2Bk9Ur1rdtI0pa1vf8RtzCF4COXZ/9UdQ9XZKa1PZUpEUd+XgZMx47vS5?=
 =?us-ascii?Q?x1uqsgWdRq6w4lnvMgUd/Nxh3WvNVqz9Kj5LcFQhZPJPK3zaXwVmBXac5xr6?=
 =?us-ascii?Q?biV2H2u6fHXd/MvFIkxJwzQRcwzjEY6/blSr2WosR8cQyHzg1MzvrD8CTjxt?=
 =?us-ascii?Q?vCRVhsdvWycSRVXvNwNA/TwVLwD7QNC+bjQBY3BcwxAFGWmWYqQtq7Z2YaYn?=
 =?us-ascii?Q?cqZighu7ulXjlXTGagyZJ4HE722lTEvGwlSFYUesf1DKO4uloCuY59AmyeUI?=
 =?us-ascii?Q?yeavSlvVzZFY0uuQLXoVES3VMFT1fLMIl7a8BCdXT4+04cr9leDT5lEoPYd5?=
 =?us-ascii?Q?0rf+tz+bINqv6xJzAc6N2zsxdBo6MMIPv0BbUUX31y/6OTcr34NDICexDfac?=
 =?us-ascii?Q?gwVtYTpIlFP9kG/+uYwyHhrVpoA5B5ay2wn4sM1wCs1f3RHiKsbQZYu92rRD?=
 =?us-ascii?Q?SR8Wd1RGuWt1LXGPEAWywcEB7Aa6zcvSUI3T1Q9HucIlTqsah4nADeoi4gzJ?=
 =?us-ascii?Q?tDgr/IC6oFdhorxnTfnTyn1s6IOXeC5RKMfm0pYBZMHy80VqovZG6OijOjIB?=
 =?us-ascii?Q?XRPXkLU2uo3SwNJ1+YAkJRBKuwObcxV1E13RJFPfjqHRDhEA+wFs/3l6NqEz?=
 =?us-ascii?Q?udxmalGI8n+w/phu7nT8VAL89jTebyr5uRYpx4G6pvTaeqpcGx81ojqzkJFg?=
 =?us-ascii?Q?MKWSZg67oRPsdI/4o/IYf1c6ivUNOrDaZzR4yy5+IqoKOOPqLa8rEikFBQkp?=
 =?us-ascii?Q?vt/HOhSGlg+aVuHYC9cxvuUlq6faZ0F20X6Bl+lc1A2qltG1F3tvFH8xV6S8?=
 =?us-ascii?Q?6ucJOM5JUcSZArGplCS1SrK3chqy8zmAcybQY+gL85LEZFTPR6/kAmxVBiRX?=
 =?us-ascii?Q?lMFiJdKXDbryrbWca3cgdWx+sv/+n9AlfkWrHWCiTynDtztocarq7IL7G6eC?=
 =?us-ascii?Q?+cMoqFLcjDkwFhVzx6+5grvNii2xrUW7MKfJg44jnMm1XkJq84ORdnrofCre?=
 =?us-ascii?Q?KOKP5PIWZ9eMiaW4IxUH+QSgmc9xMbGMM2lDNTfH5GFCCwTdWuA6vFsG+PmZ?=
 =?us-ascii?Q?qvxzl9ZfnKW9V9owiTaMJ1yR3jupEUUeegKYEWQ8B4ai7apgXrWJc02N13pj?=
 =?us-ascii?Q?0nFMYrJJcI7K/n9XHrsZj8LW5xA+fq+6iZzJrgHBJqqbtwgZOukxBgAxKTXM?=
 =?us-ascii?Q?UCC0EHEogIQPu2b8E0pWBxjf4wbBTCQxaXq61MqNcnbwAo0iL2ivmI3pj+Y2?=
 =?us-ascii?Q?LrzTkxqUIYrOxzLr30Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be840c4e-427a-4b7c-0546-08dba963e130
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:17:45.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cY0uCg5TnNRD4Gfv2acqb/K5XAFu00nMpRDH3y6Mgn6u9KR9sAVj14qAH4gogH8TezDWxwB106eQeA91n9pJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i3c_master_bus_init()
{	...
	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
	if (ret && ret != I3C_ERROR_M2)
			  ^^^ // it is enum i3c_error_code
	...
}

In dw-i3c-master.c implementation:
dw_i3c_ccc_set()
{	...
	ret = xfer->ret;
	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
		ccc->err = I3C_ERROR_M2;

	dw_i3c_master_free_xfer(xfer);

	return ret;
}

Return enum i3c_error_code when error happen in i3c_master_rstdaa_locked().

Cc: stable@vger.kernel.org
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2:
    - cc stable

 drivers/i3c/master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a78003..00a82f3ab9ac0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -783,6 +783,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.34.1

