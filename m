Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B87CAE06
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjJPPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjJPPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:47:00 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E675D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHcAIEyeVxYH9ZG/l2Vet2h6x7UeTlmTQWI2hdeSlzCjhuHnlGNFiIrIfMjlSPtjWFWdpwT9L08SLGWn0AHBYdr2ePboZfckPIHwyoj7xmLv+ag0p5uxfrFKXhDfRYXlL3r/aFL9GLaH4TlrhGT4Ym23wMVZ3gAcJkFAIpbj2h4Cyve/vgLKPp6jMwF5wU7ao53tFMFEuvLK+sjZ9o12jwLSaS86kgwp3suMbj8jMaFYYepZDR9yeCbIjjkvSaTxQf2S+VYf3OwWi43M6YTLtZ5Oo3/V4d1sttA6F+1nHg2PjvIdSGg9+vzuIZ4AfZ1TASsBzxHF9oGB5Jjj+AbQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6wYLxGqIqDAdgK8VtmcvwBleY7Zkme71O6KK0sSUG8=;
 b=DeuvMWkjWa6gYQq7wPu77jzPiDPUah6LiE2wog1N+tiptqa8vzXr28qBaLSfsWuzeXsP3bmLKX3edDIT3rPxMJpVMBH9fjde/DQwh57z5nHAj5i1qhTFQIkV6dB31OetAUSf4nWXfG/d7XEoY3aep1amLMhaAYhjPCilj2MQcwSbDNiQuZ58RPWVDlGAR17zMrGUEstxns599mrcEYzj2KFB6tC6hCBc/q9X7gnqFza/Yl99QQdUijeTEYy6+Ry4DTOnvv1nJyHJVqQpbth+oC1up36frxIkCiUHkDFh/34flcHmLDm6Q5OgckzO8ZdYD0URUuVpKEIbAqH29Xsu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6wYLxGqIqDAdgK8VtmcvwBleY7Zkme71O6KK0sSUG8=;
 b=quZ3tJ87J2E1Xeb9FiNoUY0SJV73FIiNO1C4CZOo/VqR5Rj0GYxSqX3DJ0XSAM2hOU7xCwJTFEAdZ8yXYGVOQW9aOT7OI0xUvnEYhuW+BNPgg+Ps+r8q/bt3rlB58HJIHRf9zkgAfCURbsN8EFJanEbi2Fj+ELQ2GR3rdIj+MeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 15:46:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:46:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 2/5] i3c: add actual in i3c_priv_xfer
Date:   Mon, 16 Oct 2023 11:46:29 -0400
Message-Id: <20231016154632.2851957-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016154632.2851957-1-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 034fbd37-0c12-40bf-625f-08dbce5f1dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgTpxcQQEV/sVhOP2G79UuNaFe24g3ryy5V8MTpQJ/2z7qbevjA5IDqYkbbC0iM1iv+bq/0j6LsFKjqClwFAn/+NuFtdJ5yfAc/9/93p9SVkwKx0fCbGfEd4NuDh6GR0Cn++ffmbndfpPjk0ycQ5kBUvUwV+Q+me0fWiuGugNlV1cZchbpPgsjyhRIviTAn1lpmJ7IMITpVL+9LuWZawVorBOGLVavjGuwcCKC1ExpniRTjaF978joyvrMx1Z+lx7N+XtIJjVXNoyuN1M2BmvtcNBTNcDbPjxBB6mOfEjGcN8Zcd0BNUdHvjCudDBOJbCz4SnsIuAn/9rRMBxFGHE9txT71ymPNrZIpxGoD8cgObSk4SwiolgwT0po4blOgTBLY9PZ1x5BKTDbBm7UTqKTU4ESQF8FCQ0g5kZZBehjJRTNknrikh0glBMm9Lejtb5CN0CBZPgmVTEDQf20FDfqjNZruz8TGpVSTxmUgjLnAon8iahlJH3JrMRa1evo/T8UyZnatgDs8FYl2kYhw9e7OsUGw5XejJuQdAgSWpt6SZziV6MqiDILqn8k5JwMTaUClkUWfEDqb8QfEwhDU0ZVVfs4rhWG6nAJ7k295LQvbWGk0Z+/IU1bxMG6lVt0hf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(6512007)(6506007)(52116002)(5660300002)(8936002)(8676002)(38350700005)(478600001)(6486002)(1076003)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(41300700001)(86362001)(4744005)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NzaGRLRDJBS0JPMDdYZVFVT0Q3QnRxZzVBRHpuZm82Y3d2SmNtRDl4akVH?=
 =?utf-8?B?Tlo4SzhJdjYrUExReWtNWU9TS2NFalZvNnlNbEhBYzdwcmFCQkhYSWVoZUQy?=
 =?utf-8?B?VG01Y1k0dVZYTzhsMFZXTlZNaGRIcDRVbWtyYktVOTRIN3FTRCtCWWdLdnFD?=
 =?utf-8?B?aHJ4bThtUVZZMEpnOFNaRFhPN2ZZMWRsaStZNzhBcnlKOG94eXlHbWp1R0tU?=
 =?utf-8?B?WFJ6Q3BzV05Gb0daN2xRLzlOZHZ5QTZFOXlOL21WY1U2R3R6aVY1RG9iNi8r?=
 =?utf-8?B?dDF4QVh4U3FHVXRZK2tDYTlDM0hFczhNTGZKdGJ5UVU1S0xwMW1XdGRWOVhM?=
 =?utf-8?B?UE85RWdLeFRjWjVObjdGUzBGdjd3SmNmSnRIMWxZamp3RjhwNVJpZ0JVd3pD?=
 =?utf-8?B?YXU5OWxhMHhDdXpzRFBuS0dxV1JucG53TjV5akVFUGp0RUxneGw4SGt3ajFJ?=
 =?utf-8?B?S0diV0hXTkwzcURvVk1oTk9XeWZZZGZXckxjOEJhVU1VeXBiblZ2QWFKbmVT?=
 =?utf-8?B?T1ZyQ3l1YnBROGRIeCs5SkEzREJnN2hkRGJKck5GR3FPU2ZzUmVMTnNNRmVw?=
 =?utf-8?B?UzdWTjN1bjBycFNYWkhodlVQeXVqS2hieFhPRWw2QmVadVlsTTA2ZzFsWlpp?=
 =?utf-8?B?YUhZZk1HZnVBY0VTVVVRNEpVa1Y0cVhTR0JCOVBWZjRWVCs1L1E4SDhJYWEx?=
 =?utf-8?B?dnpnQlpRUG91am5TLzI5bUxGaEU0T1gvWEtOYU9JVHdrQmluVUdqKzZqUGdP?=
 =?utf-8?B?ZDI5WkNqc2I1ejVnYUVkQzE2dFE5VXppQlJlcEExTm5sb1BvUDJ3SThuMDYx?=
 =?utf-8?B?cVZKYUtxZm1WdkhBbGNRNldDOEVab1d1RDRDYmIyMzd1cnpwMzdnZlYwakxZ?=
 =?utf-8?B?amt5Z09NclFySVFuWHNqVGVGWW9Oc2ZYcVNkQ2ZkVXdIMUkwWmhJYVYxYUEw?=
 =?utf-8?B?bUEwTmliRy9KbkEwcGlVNXJ5ZzRCdnBjWjhqWmVDSWw3dTRUb3ZPN2pqTmpn?=
 =?utf-8?B?cEVyYTV3Tllyd0pPQlQrd29GOU12aHpXaHcrek02S0lWZmpSZ1ZiM0hPTG5Z?=
 =?utf-8?B?aTRDOU5lNGhNRWFMNEp2Q2htb1ZHU2pUcVdlTnhaK2RQL1NYbGtRdUpjRWFl?=
 =?utf-8?B?STdTZ3B0RmpZeWI0RXViM0J0OTJDNkNNVlR6dXFZeThBaVEwZ1lDc0ptZ0NE?=
 =?utf-8?B?aTZUakJYSHJlRFZ4cStJWnlRZkhhZHRpU2ZjTHlycUlDQ3duWFBnTGp6TEls?=
 =?utf-8?B?V0NKeGhvcktTM1pISTk3OGZjeHJ1OEFTbTZhcXIrdEdjdWVLZFRLekszWXls?=
 =?utf-8?B?RG82S2VwMjZHbi9CVjB2TFVzeW9oRWhpbjdpZ3BpV2l1Y0JKMXNQN2owZ1Ni?=
 =?utf-8?B?YjYxd2dWVU9vOFEzZEE3RWJEVlZwd21PNGFoR0xyalM3YXdTem1ESjFFdFBJ?=
 =?utf-8?B?TlBZcVIvZmxYQ3EzTWp3bFJROVAvczZRUVdXSEFrTU1sckJPcTF4Wks4SkJR?=
 =?utf-8?B?bVlTYWxYMDJhem40VjBCeXIyeFVwdkVqeXU5T0ZQa0lmQXdVQi9BdjIxaEdY?=
 =?utf-8?B?bjREVmNSQzdUajhFaW80Unc1bFRCdFhjdTZMejZXY2IwQno3a2ZwODZONnBR?=
 =?utf-8?B?T2VJemE2ZUd6VjF5RGlRcXpTaUpJNlBCQnFOSzFGZ1Q2TGF4aTVmSU5RQ0JC?=
 =?utf-8?B?WDVYR1NPRjJzbGZNckI4VVFnTmlWejBBOEsrZ1FFQkhnKzV6bWdVOFpxZVkx?=
 =?utf-8?B?SmVCK1VrMWwwL1I0YnRKTHlKTHZBenVLbzlYcnU5Wlp5cUhCS3d4RUtnc1VW?=
 =?utf-8?B?bU1kL1I4OFErVTIvcGxqYkZkUnZEOHJNcHp3WUlkWitiUmcvNVFTK2pPbld1?=
 =?utf-8?B?dHhVMVVWMkQ1ZnlOK0NWaXNvbWhuUDJoNFhRUDlRWG9Mc3NxeHFCQ1BHT080?=
 =?utf-8?B?dDg5N3A4ZElEMVk1ZFdyS1hvTjc3WkRRek1GeVhyTTZoSzlqdmh1VUlZNGZk?=
 =?utf-8?B?aEpzak90dWFxUHRadTF4eUdhekVrQzhKMFF3Ym54ZGZQNG4weEx2MFUrRGE4?=
 =?utf-8?B?NjY2c1dBQ3pvekNRMUxJb1N6MnU5M0g4QTdLS2pxcHBjaEE0emxEVDRtNDJ1?=
 =?utf-8?Q?mz0M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034fbd37-0c12-40bf-625f-08dbce5f1dd4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:46:52.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHK+GOFjTtmnVvDxP7agUGS5rSS5ak5mlYcnxQsr506ZReVVfQv74W8H+zKDWByTmzSOpPLFThk67OXSgNvdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
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
index 90fa83464f00..f2fa7ee5d96d 100644
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

