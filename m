Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBB793108
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbjIEVjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjIEVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:39:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3FC133
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFnjv4rH/R/nAYzObyQpnij0UjAhLbviyhlErAh5BVaL4Dd1+DKS6SQGfViiOmPjtiv5En2IAqePu/WTAFE2bGnglcVPDDORAxK5aQYhaPW1ULUTI4UTe/PkvsycpOg/iGJiaLeZyhkEPAm9+g0Iwq22Xwsg7sBRX52cTz0Z2tmUee3jnxspyeIAaCEa6SYcCnyR3GmC7kEvNxK2AyrJnqnk/njkaLn71L37yGDX3ymnbMuDRqmKM4vTlpTaYNvXj0J8x8O2ABlnz2msBzX/By/WPA+AmKEfzNHs2BwHS9yeoV2Sb/kwLV3fPOBhymAvYQQUvEWfzVNceqfjkph6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjL4OHwC/rHtCDoRpljh9fgGCzjlUSYpZKXCcvdcfOA=;
 b=MpeobatYKM0tsI7c9FhcQlbfQ0zStmCaDYnLvOT6RQxQdpobpcsF7sDYv40/kaFZkGwTYrAW6gFpl8CKrv/VBTEQy7UcWV06PKmKQcigjnh5kxs9+Aby3t+QLsaR3D7ySYFG0ptFCDNpni1mB1mmrKZDJAUDI6EzvuWNaFVI4yVrKX2DMgBux1+uwL78rBmU5vrS06QH7lAwV5nArtK5ZpZgmK/d6egqKhGYxhq04lzorl+PhrswR1/aeW5VlhopDlHLRW1CQxvhX0xPCcnZjzO1/L+kUJj48g0k8ILVCHhdFUPyMukl7H8DHB2GRAqsOP88sik0dgfx6zbKMgwjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjL4OHwC/rHtCDoRpljh9fgGCzjlUSYpZKXCcvdcfOA=;
 b=Dnz3e+CrQov2AJowNWT26JlTi2ECBhxdlnHhzbD1KWUPgQ5HuYLxJ+zybdI1dVrW+ae6HqHli2+lEoPK0dFWQRHFZNZMjy5gCVpBy0XGwF7kw/zuRDQaTvUXGhL0RE72lYtNlD5Fu5/IJzg1m1XhwKZzyxi69l7gsHewcdpqAOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/9] i3c: add actual in i3c_priv_xfer
Date:   Tue,  5 Sep 2023 17:38:34 -0400
Message-Id: <20230905213842.3035779-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905213842.3035779-1-Frank.Li@nxp.com>
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee94220-a981-48b6-5114-08dbae5885db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KBbxbE8CGm5YJ4Z6TgLh6Y5WZtxb2/qdL5p+kWerzMP9m0rIpbX1up7LVMGiMuAsLuXkAMFQ2jWR/nk7J/Ti9lbCcx4Bi0/0E5P47eBXLToiKw1YStrB/Kg0Xi3x/XjElQw0xYFNPpdCMlZ1DiXWhFXV008r+ibVPNktenq6ldaHJZlGyrDHyzv5VyrZVUA3Q0nJXqFAjgoFNegkfL2cPqxLuTlwH2q9tH0Mgn3i3t6IptrdwySMMFUt44yHS9AQcj4Ne/Z09upKAZRCy7UBiyfrJ8k/YNN9RPIUvGAg4HU56oBs6OJC2JW711PnZFyBAIcYKofnVLmlwtnRVgRjprPvv2+bDRqPs0dqx91hUT9xWEzq6rPxrNtxZBBDKJzVX5V2hEFMFGzcAN2ujeHYLbqH05X97lp+4/gtGkfaX1uHZGlZeVrvI8AeAfTLSeoCtkbQk/s9xi+dnyB45ILZiiL6PRqGSjZrrxgixgC8RU0VH6zrBahmyupqC9Y+4PGKzFLg0eMUslMT6PaYZVV0VxqRwEE3pnZoJWmnak9/JdiUatmFXA3RkepKZ4dSo918ql8JQwPlQUGRGbas17AruXOv7c3CUsohKh10ium/qy6wQlm3uag3/1TrWor6NdO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(4744005)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTVSMTR6Ny8zNDJ5Y0pvTVZ5bWRPT3hnc3hXbU5pUGoxNVRJZFpyTGs3cWYr?=
 =?utf-8?B?ODhPTG1yRlNzTm1NUEIxeDU1a2hOU2VJeUxTdmVsQWxod1IwR3QwVVNIT2lI?=
 =?utf-8?B?SDB5ZXlwVG9QSnNuYkI2ZXNjeXVnckkwSmgvTXBoUlFydXV0bjY1bWdMd201?=
 =?utf-8?B?TGozYVM1ajhjVlhoK1RNSHZFcVBBelVBUDdyVnA4MC93YjBVTHcyd2VMM1ZQ?=
 =?utf-8?B?T1k2WEUxQkhMaWUyQU02NS9RL0JSUjNmeVBmMGhGOWI2Zm5FMGpjQTF4T1Ay?=
 =?utf-8?B?cjEzOGV2MFhEdnB5NVRVSHhCcXJKb2tkOTFKUDVCTTlGODlSa2MxQWxyQTFo?=
 =?utf-8?B?anhmamlNUmJSTldzemMrMkd5dG5YQ25tZlVmNVZPck54M3l5cGFQOGlKOXRy?=
 =?utf-8?B?aFQzdksrK1k1a2tyRE40d05hUk05TS9SRzVVdU1oZlI2bzF3U3ZrcTRvTmZ6?=
 =?utf-8?B?UmtsbXlDRXU1RmZVcWlvR0hNOWwwUjdaWlQvTERCYnp1TE9RMElqVzJVNDcv?=
 =?utf-8?B?aTZwS1h3Zys1N1AxeTU2N0lUUWgvSldyL0JGNjE4djFKdnlIT1k4dUViQ29m?=
 =?utf-8?B?bjVRZEkyVUVVNmtoTkhBYnlhdU9rQWoyaW05cS9KR2Z4eURGVGZMamdtUjVi?=
 =?utf-8?B?NjhLb2xab2hUMEdXMERzdGFEWXpwcDdzeTZDbmVHb3JwOE5tbE5zUGp0MEhY?=
 =?utf-8?B?Z0h1dmJKZ0RTenc3T2RnT0hsbjh3NFZZcW9KT01USEJac0F2a2tOREpPMjhp?=
 =?utf-8?B?TjdHeCtwVG90N0UxbEVoZFRwaXY5VGVjR1RONjFIZ0VWdk5uWHNSeGZtZGtX?=
 =?utf-8?B?aEtPUTRqa09xWndZTlpVWWlGTDVXQUNndVdBRTV4Z1RNb3Bxd2hSd3F3eVZR?=
 =?utf-8?B?S1oyb0VaWnVkUmVvdVliMmgrbjJ0M2ZNWmIwcDlMeUZMaEJOSitVZXExeGFj?=
 =?utf-8?B?WTZoL2F1dzdMdUdSM3piMEhIbUZYNkVrODBmSi9qRXJFUEVCY0F5NHFPRmtP?=
 =?utf-8?B?OEU3Sjc2NHRuM0dQSzJDT1VrNi94KzBIZVdQTk9IUS9xR09kSy9tTjF6Qm4w?=
 =?utf-8?B?dmxYd2NSMFViS2lkTyt1aTZtd2lmQ1hiVzcxVHJCV1QrQmIwUW95STlEeGxQ?=
 =?utf-8?B?YTFiY0g0aDN0MUZMQThjUHlUb0xHVVZhM2ZOVzFwd0ZidnRlZjlxeXAzUVJS?=
 =?utf-8?B?dDJvS2Fqb2p1c3p5dE9rd3IwRnJrQ0l5MjB2WTJDQnBXZlArWDhwTm54dnRj?=
 =?utf-8?B?ZllwZCtlTE5BcEk0eDB3bHVZdWN3SWpYTUllTHB1bDVhTCtzcWNuWWd6RTNx?=
 =?utf-8?B?WmJkekhhaFdDWkRzZjBpV1A5aENJNnR1dFJKQndCVWxrNzNTcmZMUkVZekoy?=
 =?utf-8?B?Q2JicjJ0V0dkTU9NSU9YS3p3SnczSVJ0WStWSHZtUkNYZCtNS3gvTzJIVHQr?=
 =?utf-8?B?UnpxQ0IrakF5YUQwMFd5Ty9pa0gwUitiWmFmdWs3SFd0Z1JYT3B0aTNrSXMw?=
 =?utf-8?B?aWc2R3lVcXZoVTFMRzhKNjZqSGF5N0kwNDNuNmdpVzQzVFNIeE0zNjdKUHRt?=
 =?utf-8?B?SkoxUWdKaGJoTHVsSzQ5aUh1WW1LYzlkSUNUNjErWFpPSFRTcW5YQ2kybG1L?=
 =?utf-8?B?M3RDbmcybE1KNmZKVmNuWlBwNmxCOG14dXB4SS8zQVVqcXZLdFJLdTJlTllR?=
 =?utf-8?B?NDNJa0hUSGdWUHVjVU43bmxVeDgwZTVnU0VBYWhWSWtWOTd6UFl3aUlPZGhB?=
 =?utf-8?B?UC9RWEthcDl1U3JWUjNsM1VZWks2UVU2d2VsemRjUldoc2NuUGpaQnpXQzF6?=
 =?utf-8?B?Z1ZpakJtbzBrenE2Y2NHZitPTE12M2N5T3BLTXROcjdzR1JVc0dYUC93UU55?=
 =?utf-8?B?azRXdXY4MXBqZklMWkxrUFdJMXpMeUJGNkFEN3RCeXNBaHB4aVVWQ054OHNm?=
 =?utf-8?B?OHl5MjRRZTZ3YjhoUU5FWHZjWCtXT2d6YUlRWS9PUmNEcDVXekc5Wlc1T2Jq?=
 =?utf-8?B?UmZmdjM3SHEzUERaMzlvUzNsMndPOE1HZFFCNGZVWlIxR0s5c1FCRjRBYTJm?=
 =?utf-8?B?SjVzWWR0WmhlbU1PaGUvKzU1NWF4b1pTQUNPVFJuUVZIeVVlcFdMRWxSR1Jn?=
 =?utf-8?Q?yhqo3ttovXG/NsrsxsLAPikGA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee94220-a981-48b6-5114-08dbae5885db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:03.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vn5NFJ3gXc4rvsmqLRevuRUGCEmfus8JB9ph/3kN1junEHj7dN6gmArrHo7PkussjFGspV74y7XCJRWOIC4nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MIPI I3C Specification:

"Ninth Bit of SDR Target Returned (Read) Data as End-of-Data: In I2C, the
ninth Data bit from Target to Controller is an ACK by the Controller. By
contrast, in I3C this bit allows the Target to end a Read, and allows the
Controller to Abort a Read. In SDR terms, the ninth bit of Read data is
referred to as the T-Bit (for ‘Transition’)"

I3C allow devices early terminate data transfer. So need "actual" field to
indicate how much get by i3c_priv_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/i3c/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 90fa83464f003..f2fa7ee5d96d9 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -66,6 +66,7 @@ struct i3c_priv_xfer {
 		void *in;
 		const void *out;
 	} data;
+	u16 actual;
 	enum i3c_error_code err;
 };
 
-- 
2.34.1

