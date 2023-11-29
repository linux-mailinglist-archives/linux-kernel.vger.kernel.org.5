Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920D7FE2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjK2WMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjK2WMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:12:49 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B05D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDsQ2KcAuz0d8mg2XG882N4R69w2/0MdK1pXwB0+3F5g/OdIYJD4WqNZSiIo9RUACqgsSOM0q6O5/Mg1mt+fxI8n8Jhc+xqzLF2G3ObsyW5jOVwncvRaZcYb7uqz05PSx9nQgu9xR7T9gqsGBCH8FfO61ZgNSIiSlUuKRKMmqWCx+Rqd1xFsWNvzgiDLwceDwXXDEly6e7GDBLe12ssRc8KRg0dI4y14znO7ou3PRwjVOZT2Hw3p2iStn9vyj5sdLhC+zSDYRFGqI3eB2HGaRt/1YeityntyD3N1OildUV8wz9WbNnldkMNZdrIyuSzww6yvdcprW3UwAlSkv75Kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++WWKqxHPtPOuShZ9C+n6tM8dcE6BdIrF96tSwG9XqE=;
 b=nf7a5rgOv+UPOHZTadyLE+anwpzul7VX5pgl7FvBAksfwGOIgg4C2ONXcEvrm63sJGgeqzd3/fgwk+P7IISgPo2mPMBXqAjY8Qi8lDD1up2b0N1JPQtP35CQvg3RwiaM0tjsnE6lXhPLrAqZ2gkUr9ZgzX7g/4pgNtgiCW6TXuq8e9E3fMwwbMPYvCNNAuzhkv8v0o5silQz8DkQmEc+3yF3clzGe3G4Z3LwRMFoFOEX/ztYs4aRQ+13jB8HEs7DkLPpqTso3S7D/REFu8tGWT6Ux/g9pw1EHRUJwYpl9POJV9n7UV/Rty2IF9HgPYx8KdlusiZ7VW4U/88UcpRshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++WWKqxHPtPOuShZ9C+n6tM8dcE6BdIrF96tSwG9XqE=;
 b=OmtZJzw0E+IRJfBDs/uBI9vKMDzYcCMcwdOdyw9UA25l1FxYNAD1tcoiKngu8SVepfALNU6DIa3ALik8yHfhQE1zbK9iaR9Ejy5ez0zrRUL+ns8G+FfMRiHqe0AgpMYi416bFi/buVI52B51hwyfve70zWf4iSqfhgBCmgrUWv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 3/6] i3c: add actual_len in i3c_priv_xfer
Date:   Wed, 29 Nov 2023 17:12:22 -0500
Message-Id: <20231129221225.387952-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129221225.387952-1-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0a95dc-92c5-4ba6-89fc-08dbf128545a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LU9ldm+8pEXiKI5yIpulC0Za5ZMpklP4GoQ0jnVdV4KmKgBco9ckwHKqCI843WF7e3Ptvn/aH5PvsfGQbQCrPmv0yz4hoT/5SUZgy7nvqH8bombV3map6TQ4JGR70w+QSAcdeY4gmq1RAqxcymJtMMSz4hFCnpH1TUGsJ9PdKYA/2O3K01qUOYyRg5UT8B22SJe6f/QpnHkOIQWZ3Gcect0/BLGn+vS4t+ZLIWbeUWwXDzxxqQLbXwyMCLPk77kqd972R4mMhd7Oe+E3a5cLhYfboHDSVnw8qJ5xEt+rZiBX9Aj2aQ1Owi8PhUrKXBX3kYBd25RpaJdOhjBOT/k+TOMbViWYKul40fh8jDiDUz/Jn0DsfEj59hMt/yKPuqyr4Fg9H9dmybq7yZpuMhilmeGr2s0gAJwIZN2IcWk5gj6jawg0lFG/P1mue6+RsyWzuIiLEpz3A0IubCx7zeckRsOH+Mb9gk3qeI6KJOT2t91nH8TzFYJZBUPnNLAZsXVMstf8UgqCwP/LxiqQp1jav1eDdUW83uMED38f5eVso/go17TuacEaG0MSGaFEIS8NcOfxGHZSyk2Zs/u3M0vbt+uDQL8jrh/UzzFcYSsI3Nwy0GQ/rWBZJO95CPQyXOHzWoQyApQini0gPpQuAMxyow2fzn/oiuHvTvOMky39eyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1NRTJSeVFmcmhrUi9heUJUcUpGeWZGQkU5b3M4aEdSMlZuVDZIcXNGcFFY?=
 =?utf-8?B?T1ZlRFMzM3Z4cm1zeGZSYzhDVkhaR1o5Mm5HcGk5UmI3RXZxZVJ3WnJoSzhr?=
 =?utf-8?B?Wm5rRW5YR3pjNGFQREFhbm14TW5TMTUxU2ovdVc0UmpYYzJWM1FXL2F3Mjgv?=
 =?utf-8?B?ZHRseUN2dVhZbjEvVTF6SnJXeE5YYW1MM0pZalFaMmJNcEo0U1FNOVhaVEhZ?=
 =?utf-8?B?ampqOWpsR2xxRkYwbFF3ZTdRRG5kTXF5K09pN0VVY3YvK2FFdGNFSTE4d2li?=
 =?utf-8?B?YmdHZnRiZ0NvOEFqeGl2aFNCVWRGK0lDY05FeTFxM0VUS0MydlVKcVJKT1Jw?=
 =?utf-8?B?RjVieGNzd3VhbThsMUJDNE5jS1ExM0NkRmFpUG93YUhEeXVuZERGRGhXQ3c5?=
 =?utf-8?B?YU55ckthUElJRnNINmdhUmQrV0ZtRi9QUHpmc3ltcDdoemJCVHQwSU9qRmo0?=
 =?utf-8?B?SE9MbUpuRThaVkh4andHNkROS2laMWZQdU5JZDV6RVgwSHdLUkpzMGtwSHhk?=
 =?utf-8?B?SThDTEE3U0FBeW8rRjBDTVVDNG1qMG91cVNGQ21VZXNxd013UGp6dXQ4SEIz?=
 =?utf-8?B?UjM0aSt1bk94ZWdoTzhkVmxPTHFwU1hwTVZnV1RxL0NjR1B2K1I0U2p1ajVE?=
 =?utf-8?B?QmlUMGNUK3luZFpLbW0vWFdmVkhiM2o4aG5vTGxHMUxyaDJiWFpmQXY4N1dF?=
 =?utf-8?B?UWwzTmt6OTRJcHdrQzZpQUZSMnA1NldVVERORmU4blBFR2xjeTV2MmIyRUNw?=
 =?utf-8?B?L0pYUWZ2Nk0rdzZ4b0ZDNkVpRG9MVDd4ZHdIUjhvVm0zSStwVjhWR3BpQSs5?=
 =?utf-8?B?RHBxWWwxQU9mMUlnUWtjd1pDU1lhYTJFS0dJK0tFNDd6eGxRYmZ4bEo4a0Ro?=
 =?utf-8?B?Z3Zlc3h6My9mWnhtelh1R2d4MStWVE0zMm5VSTdjdENsNFBqellVb1FKeExR?=
 =?utf-8?B?cCtlanZreS84RFlveFZ3a2NiMWNDOHlyelJVa2VoN3RmeDZMUkNmTmpiOFpF?=
 =?utf-8?B?QWNqWE1wU2gxWGFUR3puaTZUWTlJdll0K0psd2tvTTRhQ241UE44Rk5xTHMz?=
 =?utf-8?B?bDFtd0hGcmgrZjBkaGFmeGVTSmdtMXNORi9rcUp6N1M5R3BSb2llWXhFRWdx?=
 =?utf-8?B?Y3lQOTFQcXpvMzl4aE9PR1BabytNTnorOW9nVGFJUG1XcXZrakV3S0t2Qmlr?=
 =?utf-8?B?cVBxdXIrU3JXUEdHN2pRc3ZWSlF4aWhodm5yMUx4OXdlaWNvd0ZsSUR3dDU1?=
 =?utf-8?B?Qmh6aVVmUnl4cUhwQkQrNlUwcXd1Nm1XNkcxSElCMGR0Z05QUloxNlQzTGt6?=
 =?utf-8?B?S0ZFbmdvYThKSFA5NDVIQkxhbXd1UFVUcGg2Zk1hZUtvNld5QVFhN1dQMDJh?=
 =?utf-8?B?SHFzbVZ5NUhxdVBNTDNadGEvaHRFelVFdXBhU2phOXdsUGtwM1NUanVUYzRl?=
 =?utf-8?B?Rlg0ZHN3NFlLUlJwNmEwOHIvTlRuZVZMTW8wckFSbTVRS3RCLzYwTUVlMTB1?=
 =?utf-8?B?WWRQQzBVVCtHUGJXS1VjZFZNWW1YTmhTLzdVNUE1cU1lVWQ0NGxTbmwvblA4?=
 =?utf-8?B?cmxnWGZXazZJU1crMUZQT1RuWlRxdXh1UTE2b053RWhBdlVLZjdLcGdTQ2Fl?=
 =?utf-8?B?QjNOVEM1dHU3MUo3azVWcTZkT0xtL0dBV0M4TGhjdEQrWFM5TVN2RGE4ZTZC?=
 =?utf-8?B?T0FnZnE0b1pCR00wWnhCZVkzTTk0Z2RROGJ6aHU5ZGk2M1hnSDlSQUxiZ3lQ?=
 =?utf-8?B?V3hrUW9odDlWV0pBZ3RyTXpZbjI3ZThJUWp0SnFtcDdXbUx6SDM3bVVsUldE?=
 =?utf-8?B?MFBsNGZlYmRNdHVxOHI1eWFCN25Kc1p4N2dUNVFHOUtnQ0RRMzVBNWRDR1NY?=
 =?utf-8?B?RzdYUEM2bUJTcDBPcGZWL1BVQVI4MHNwM2VhRDFiWkZKeTdxaWRYTlB1T0U4?=
 =?utf-8?B?OTZtbmROOUVvU2JsTFBkLzRIcUlEMVNDYzRyQUhPcXljNGdoT2xBMUhhczZ0?=
 =?utf-8?B?VjRsOUpDRGg5cHlDMWRyNzZ3RDh2bWIycytiTCtYZzJBMm43VEJ6TzRRTjJ0?=
 =?utf-8?B?dkFuMTBYdE0xVE52WFhDRDBIZGw5SFh3YXl2YnVUZGRjRFlwYUd6R29CRktE?=
 =?utf-8?Q?cyZ3QNSwZclYMYdO5xRSq97gC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0a95dc-92c5-4ba6-89fc-08dbf128545a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:52.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqW7yc0q+PBmiRvVU9wojR9eEHastHvAeMhzhrSM4YuvLvhV5ROZUhkpXIA1IZ6M2QCPNYoMhWY5IAi68aHvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

I3C allow devices early terminate data transfer. So need "actual_len" field
to indicate how much get by i3c_priv_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/i3c/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 90fa83464f003..ef6217da8253b 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -54,6 +54,7 @@ enum i3c_hdr_mode {
  * struct i3c_priv_xfer - I3C SDR private transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
  * @len: transfer length in bytes of the transfer
+ * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
  * @data.in: input buffer. Must point to a DMA-able buffer
  * @data.out: output buffer. Must point to a DMA-able buffer
@@ -62,6 +63,7 @@ enum i3c_hdr_mode {
 struct i3c_priv_xfer {
 	u8 rnw;
 	u16 len;
+	u16 actual_len;
 	union {
 		void *in;
 		const void *out;
-- 
2.34.1

