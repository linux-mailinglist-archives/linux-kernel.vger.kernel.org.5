Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9F7CE9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjJRVLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjJRVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:11:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6C19A2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGgbfbSncd8p2bDrHLNik5lueWy8SbNxHYWAqL+uoru4wyoCmWS+u4TfX5YVwDQ7hf4NCHe1Vks751atTVmsiHU5MpIcsYDniQZ4cnGNAgjKr6kTLO2GVna1gSYvnHOFBHAVr4xU6hZ+RzsCjOvyyy5o1kJ2YcYkVl+PmhFQuwS33da/V/q1GrbvBAdjnLgsMwg4rYNDRBFsPt7Wts2mdmiwhniQYwsc/H4WPC4C+Ue8wLf5zyOoy/Sx32lECo4ZtYsH7FrN05SfrwD2iFMd2z2E1woxyPiq8gc8FYrir0loPlp7CNT+KOzoW4/Qav83FLcvwCTnhcL7N2hPPs+QFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++WWKqxHPtPOuShZ9C+n6tM8dcE6BdIrF96tSwG9XqE=;
 b=jY/hTIw/hGqG5Pb/8e5ruRaKvaHE47YflqAHgqfXfvBCgrFiPH7TZ/VA9Gtc4bjzLGT4ZMyHm/A6cBj5v46/qgwZRSpzE309lW7E5GPOD1o9MwZZfE7aXmodxUhra71152lL+kCAnu3bmzGAjN19XS0oAXZRvQ1N/t+YnrClmTJp7iBEL159rpM0fKzayKpdFwvUOREWdH8AMIYM9+ycbM+vNzqu63ib7svqo2lgElDJOLysrllx3aRyAXWK8aFB7CquFzkDPPIGETp1EX++I4+33k+P+lfL+kEAMwpPGa3lZk/1M5X8kTD4CGnOfhoCGgBoSxhbeN7rdLqTB4sLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++WWKqxHPtPOuShZ9C+n6tM8dcE6BdIrF96tSwG9XqE=;
 b=M8Hv1gNKjOSb/AdUxOrgoV3OfRHashw3lq3tM0oBR8AGcsrknSpJH4RIfGWqa4BBFkJDXllS1V7/IHUlDXwWVN6vlU+4bi0iSDjyJmY8/0y5v02WCEymqxwp9qoBD7y577qQGHznXbPIN9WK6klxzyh7tpQls3h/26vWoN2S56E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:59:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:59:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] i3c: add actual_len in i3c_priv_xfer
Date:   Wed, 18 Oct 2023 16:59:26 -0400
Message-Id: <20231018205929.3435110-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018205929.3435110-1-Frank.Li@nxp.com>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e53ad2d-fdd7-4bbd-780d-08dbd01d2cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8QNzJRvOtNz5fh7/7kTG7y8nBigabHT4b3YaTA6IFQ2DzRMdPMby72LLsfyv+TuXRuc5EKDwnXZbQFNPTw0kC8cbBnSR0OQ+UvaHdKRb5kEBABBNoP9y59aOatA5o0zBobUGUbCXXzrQoFHCjOY/bJufTrCSqCEi9TdtIZIeQ+b0QJTrKHHQyyz51d7/g3uX5xg01qGpGsBGzxvCefJ8zt75n+Xux6auch7gJ5jfj9gfPXplQi2f8bNS89IiXIpeeyLKL+G7kUPzSvMZh6trawOIgoIF0+nO0UBqwMgFvuJ7RuxrJk2H+f19Y2u64tgD2bMgjFBT9qbiUjKSw/vsZsJPTk4z94prNhVIU7gYAA84eMcqxS9ydSOMZrGIioGjKQNQ/H+NABZfuLa8Y6HxIjNleLZ8oioNEMUfs38Jhf1Hmz1T4oSGUxH+xUHYR71eKLT4wwBVoiqTim1E3WND89KUcBhXD0CyO1+dqWzxoJG5n49Ofa+CMNKHk6yMhoNdldyUnegfEmF3KkLfQrNFm3y+oKk5i/k6qZpYmOwl3HRxYj1xy9q2j8xJXme/B4SokvyoLt4CNSNyy4CX0fJMyRnU3G3B27DKFdhk1Yni11nkq7XpGNxyia6HjvqVHBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(6486002)(1076003)(26005)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tUYlk0Q2xmcmgwVyt0U3IyVDA5ZjhyU25vYSs3ZmtFelJ1OFczc0hJRVVw?=
 =?utf-8?B?SzJ3U0FDUUlVL1ozOGNlVitQZU5OSG55ZWZURjk5YnJFRUE3Q3lEOW5mcHNw?=
 =?utf-8?B?Mm1Fb0JxVXZ4L3V4VTZMSTZkeGZUUm4vRi9JUHltYnZvRnduMUExbkg5bng1?=
 =?utf-8?B?SDM5NkpQK1N2NUVNdzFYRkhrall0WmlzNEFuNjBlQi9ZZnNodkZTYTVFOFRu?=
 =?utf-8?B?OUErQ2tFRGpybVZGR0F2WTVtckVrWlRUdmN3NHZJazRkNDd6Yi9YSDhHOWQ0?=
 =?utf-8?B?NStlbDZTVnVxYTRIVDNNUlF1cEpRbkxvcVRFS2ZXcDdTbXZkUGpmY1JERFdq?=
 =?utf-8?B?eUNsYlZlVkoxZUhIVXhwYTZYU0ZrN2lQRFYvUmZwQ21UUFlUc2RCSWpnakdS?=
 =?utf-8?B?aTBBZHFIaTE4dnB6eDlsd2JqRUJoeDIvZDVBYWszZU51Uy9Sb2Q4NVNsQXln?=
 =?utf-8?B?NHpIZHVIbUdEcmNTVDRXTDVpVGZQd3VnQk1KczJJNFl0VUhuWTFZay8wcXlR?=
 =?utf-8?B?NXk3cWRpMWJoQU1QQlk4bWpRNVBSMzdwSlJuQVA1WUpZNTVEbVRxditQbzNs?=
 =?utf-8?B?M2I1dmgvYmo1QURudUlCVnVYZVlRNDQxZFByaVQyMXBQZ1h5NVcyMUZDUFBF?=
 =?utf-8?B?MVNGSFRLQkV1RkpjbUQ3eldqdjN0eHRQMXY1eW9JMmUxY2hWTUFNZGw2dEpY?=
 =?utf-8?B?K2Z5eW1xZHZMNys1ckdpSVk0OE9JbTI1MmlVeEZodTBvaEVnb3RFbTh2R28z?=
 =?utf-8?B?dGsrd0tQb2pyRGxtNmNSZGx3MmhhcFRSN0NlOGtaWjhRYUtmaWl1OVFQeHhq?=
 =?utf-8?B?S2Y5dnh2Q2JCWENvZHZDZExhaU9sS0FEM3NKRnNGRTE3dUM2d1RhT0orcDFV?=
 =?utf-8?B?ZW9OWnU4a1gyNzFENVhYL0ZHdy92aFVXdExFdC95aG5mSDQwQVFKWHk1dit6?=
 =?utf-8?B?OUVtUkNoMk1jMDIyL29yVktwdzVlc1pqMENPcjlQTVpnWE94akwycVlJL2Rq?=
 =?utf-8?B?OTg1cFl3QUdjWkdrS3hkTHFjQVdNWXlOQWREdldCUjZYVWNnL3NHRDRtZHFs?=
 =?utf-8?B?MWkrdzZxaHZPeTk0NFhRQS8xSkhWV0g3VkVHUXpkKzZmcWYxelgrOVdhMEFU?=
 =?utf-8?B?UzYxeW5LdzVDaWpwN0hGTkNKM0ZMYTBvNmk1TDhNK1ZSRmtxTmV5L041Sm44?=
 =?utf-8?B?RU5PcyswMmhheGpGb1lOSHB2NDArNmRURHIyeGRWbFBEa1FsQzNWQkJVdHVs?=
 =?utf-8?B?L3FRdFg0ZmNVOVo0Vzc0Nmx0NUZsL0tNUzRpWEZuVFBPSGljQnF0OGQrb3dP?=
 =?utf-8?B?T3BOanFnR2RINGhZZFJCdXNnVzJON1dmWVdhaFNyQXpZUHZqRGxVQ0cvL1Nz?=
 =?utf-8?B?Mjg3bk5VME5qeUIzTW0waGJzR0ZQdFhkWEZ1aHJYRWs0bGdrT3VoeEJhN1VS?=
 =?utf-8?B?SlZyUTlPYURqYS9uK1ora1BTeUJGdUJVSDkwVEZza3lWRjZpbGRLemxTazdF?=
 =?utf-8?B?eGRvcEtibGhBcUl4ZzJOdkJyV09PTkg2Z24vaEF6ZXhJR3kvbmM2NFVhU2s5?=
 =?utf-8?B?YkJTVDBjeFNGN3V4aDk1QjZMMFhaVURqUXh2OFVwUTNQRFBtUkE0WDIyOUdo?=
 =?utf-8?B?TVk3UGZ6bnlXeDdlaFp0a2RKWE12bGtOb3AvbENWV3dsdlNjSnRZS0I0QVFY?=
 =?utf-8?B?SXU2dVBlV1FJQmU5SC8wZ2JoNE9idFJKWXJIek9Hb0JtdGVaa1pHUWk5YlM3?=
 =?utf-8?B?Q3lKY3YwUGlJUk53aGZIKzhuekxIYnordU1IMWpHTGZrcitKSUN5OEV0T3Ar?=
 =?utf-8?B?OHEwMzRwNFBOTmYzS1VjRjB2amFSRXIrUVNaUlZ2NS9UajFhWUFuQWVIL21K?=
 =?utf-8?B?eHJ3NlYxcllOTEhnOW9menJWdnJNM1N5aTBKNlhIYW1EN1ZTc3hZdHhETTJm?=
 =?utf-8?B?SXQrU0RMTnNPTlFkZVlXYXNXVXJuYTZzWElJNE45aCthNW5lK0lBblBVdWM1?=
 =?utf-8?B?Y0YwYTFYNDVsTWJla3VtSi9HaFl2b1pvZzJkbEwxWHczWWJ0Z2VsOVVxRkZT?=
 =?utf-8?B?YmNWRFE0MURHQjUvdlkzUGhjVFhuM003clJYVjdDUENjVlp0dG5KM3ZTT0RX?=
 =?utf-8?Q?ezBI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e53ad2d-fdd7-4bbd-780d-08dbd01d2cd2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:59:52.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7t3pknfqVKU8dle9k9zzGg9Gs5dAAs22cI6t5PYcWucNBmZ03wSXWhWCCPLkV5b/80bopHkg/aipAXdi6uwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
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

