Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B377FFEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377197AbjK3Wok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377205AbjK3Wof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:35 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE010E5;
        Thu, 30 Nov 2023 14:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b31855fq2DvhCsl7NpVg12bHH30hpTixRmJBUT4mO7dmdCJTHM8iW6D3K8Kr+PnJRct2qYg9e5A/y36dFpa1ro768zfYD0PgPoBPL5It2TLgc77IrCVuUEHi8+c9Nke/ug/Zak1eggcLvIkxQlVkqzGDHccvgDvGMH92fHPo0QfpIVsZ5js4aLUFWX/KwDWaE0PLe6juiX4iI1NVuoUaAz28vxK4mUgK9sNHMstgrBskIINdIea8YSD4nlNzNzJAlyGXXsEDOq2oZAirev1xUJGrw25NCtV78FfUMdKQ/m7uJNUGY4hoUlLo1bduxtllCiMEZl71MLbXF8GorIr+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytSmslj5oOfXj/kvlZ0mw3AYP7VbssW1sje4uneG+bA=;
 b=T4ft1KON8E+FmzSaq36MA5X64Ewq96fOrmSTR6+M1JTORTTR23j20GCCaV7AhR61BrTu5YMlzCW5kWTp91ELSIhZC//0wl6JDl4ix4CZLtwtFucK9qwfHIl90d/j1v4M9BiCuCcFQl/1XapuTlboX8fcM1vALsI5xjlBOTRSQ9dqDXpl+2DUB3kuWBzCEkVqJ62kiy2L5VuuIoY3KB6viBQgM6tnp/y2cNEa2jqbRvvcdXBwmc61g9XnfkxgdA8FVuzKewAFWQ1zTyTv9Ftj5+WhOgTTexjj2hKBfjsYTmCl9Ph0+A9gAizCUQHF7I0A5FtOY5VXXYM1ex0XDafQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytSmslj5oOfXj/kvlZ0mw3AYP7VbssW1sje4uneG+bA=;
 b=a5rZPENe55RfhynvToaK9m3o/vTHvm4SU2zUyvcXjY4aOy4iqKGMdm1Ww6VlKeXlZen8kKO/33+7OwvjNsz+7grmMHY37EoTQHoRsspTUtMxe1Zcya07o9UjXASAkcIqNkR+yN49dK7AbRAKhF+gNV5pTBqlF4cAHh830FxRBzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 3/7] i3c: add actual_len in i3c_priv_xfer
Date:   Thu, 30 Nov 2023 17:44:04 -0500
Message-Id: <20231130224408.3591288-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130224408.3591288-1-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: a6686b44-0440-4b23-d94d-08dbf1f5eeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiv9MqFZ9gLTCRgG9b74Ttz5boNTt2Nd043CFehMppwf3xNAqPiUl1dG65gwQ+N614AH8kzBk8ZCaCdvohu1tix/0rsJgH4ojVUtXcSbCRkfR5AyaIIrSRJJhz5l+tzIu05enlELfut5dh6yP59/JKyf6MgXMtQmn57TGefpTjbfy16/9zQktXJlPAVZ8ITWVwQN1OryH6aaLyruD9eTaEBEt4nJNHf+M0Pnqk82f0N3yFb54LY1BTV+Z0BD4Q0xRd0Q2Gel36hUBFyP3SaFGaDeVrzw9b1C/ZT7X+WeIPAdF7WBGRZ15DomIgmtzaTljsf/kNwEdhNB0W7KFhJpi/BHLM88MS+46lFR7tRxwwQZeWcC+iAh7Km7BypnHXvO0qVg45IXG3a8tcKAc7B1gMgLRuaGOyX3MHuZnFTGGBjZByGvrxVsXs/f9w+uSP21krzabn0qGOiQQPW+Q/xbgezjqbtEz9tlArw8UcgwkGlUuYmWs60mwhtaRy3/GGqBKX2uClOZqd99+3Yh/FpEwrsLXFllwkDWi5cWWqU0ZfZR0fwumun9jLaZI3KsVq0mL5Q97T4n/m5bsyHxhgToGAUGra4WekZoCmMx1QE7dtpgS9TxrX+G4R2jVhqXTpFUsY1eWunirYTFeRmdY2BAwWaaTSZg9TyhQUx1bXgzET8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNFMkJQTFpGNUpnSzhPUzJmMWJpZWhqMllZMW0xaTNyS2xoVWxoS3hoOXpG?=
 =?utf-8?B?R2YxeHFFZW9SVEtDRkR0WkRlWXU1TURYcXBzaWVLQ2V1Vk50MFM2bkRaS1Zh?=
 =?utf-8?B?UklyOTgyeWlrcndscGw1cmRkZEl1aHlrN3ZROTdIUkV1d3lrSk9jMkZQNGVr?=
 =?utf-8?B?NEMzcWRiU3hVUHllL3FxelpnQlRXaWgzSGhnSk04TUNhRXhmOHUyRnAzSXFw?=
 =?utf-8?B?SGRuRVlSTEd4MHhOSytHYTE2V01GR1ovVFVjSnMyT25FbGplYXNNWWFlMFRF?=
 =?utf-8?B?cklEQTRydkhYQzBZOU9kS1NVTU9qNWJ6aEVMZ0gwUStlNFhnOVFuNXl4RklM?=
 =?utf-8?B?UUswQy9ocHROUWtEOGtXSDRKSmp4eWxXZkZWbVh4cnNZUUk2bWhwMy9vWHN4?=
 =?utf-8?B?Y1JPdVp6UE5WVVlqWEx2TWQ1enhxdkhiS3RwbjdFZ1htSHF6SjdOVUY0ZnZs?=
 =?utf-8?B?eG9XZkc1TGNNamZzcndHd09CdWNYQkhJNzdGbVNnZEVZQlpkY2FxVnJLL3Ja?=
 =?utf-8?B?UVdwZUw3ZGpQbzVtM2czTmJPcWVHRUFta0xaR0VKOHRNeDBrMnFoQWlTZjZl?=
 =?utf-8?B?SW5qUjNRbGlGNmFBeHEvVlQvZlpEZ3N1cTJON2wveFM4ZXJ3eDZkd2wraWpQ?=
 =?utf-8?B?ZmdKZjFZY096dUtxQU8zUnNucG1LOS9tWWZWcmxyUm9va0FVenlwOGRFM0x4?=
 =?utf-8?B?MGJjQ2NFM1dCUGN0S1k2aldEWjRPVm1JUUtTYU9ybkxsdHN6YlM1K1g4MEdG?=
 =?utf-8?B?a1QzUnUwV3M5a1hKUkFHWG9JMW4zSFdqUWpWUHlHOGd2V0h2aFZyM2dHb2Yv?=
 =?utf-8?B?a0NvRjdseTN3d0VEVktUR0FvczdyZnQxczZFSXFiMXpwUXNsTUplWUd6aUpk?=
 =?utf-8?B?U1lMdlZiYlNTRHU5dGhVNnl1dXEwL0FHY281aWdkS3dhVmVwTStlK2FkSll2?=
 =?utf-8?B?U3cyM1BCSVJ2dkpOcjhWeDZCZ3dZM0J6K0t0c2ZsckY3dllIb1NBZk9UdzYz?=
 =?utf-8?B?bEFzL1BXSXBKRU44Y09jblgzOFlPWTRmb254UnlNQTdSVWlwRG5jSGNaMW5t?=
 =?utf-8?B?cWs1T3hlUVBKcjBJWDBzT2lhZWphRm5STlM2ZFZCYU9TbWIvdTVRdmowODZi?=
 =?utf-8?B?MVNYOEYzaUFCaXpyTzN5OW55ZjZMNXJIUUpPWlRBSzg2VERMbnZKUUFjUHd5?=
 =?utf-8?B?QVNxWFRueHBqQU9sWnlJZlhjKzJYYnBNbitzWVZPRlhJc2lHS0dhcWc1S1JO?=
 =?utf-8?B?cWdJRUthZ3R0VzliOUc2R2lOSzdjemcwMTdpL0pQdGJYVjlFcktxVS82dUJ0?=
 =?utf-8?B?dWw5Ti9MSzJxMGxaZjZZb1EyajJDc2ptSGR4VW0xMXN5U2ZDeDZyWVZZMzRt?=
 =?utf-8?B?akFEU1ZXc0daaVQza1MzaXF4djhSYWxxUlZ0VlpIR0krenRYcEQyRkJSVW9o?=
 =?utf-8?B?YXhDWUsweTdZajEzMng4UkRMdXllcEdHNEpFU0Nhc214U2Y0Vm02dVpTUkRu?=
 =?utf-8?B?UytXdEJpdGlQTklCMFRqZmVJaU51bGJSUkZpNEV3bXlBQTJRUWNIekJNeHho?=
 =?utf-8?B?L0VTdVhiZitaN0trL3haMmpkSkJTNzJMVVU5ekxNbjNNV3NWU0JzcW9YUTJp?=
 =?utf-8?B?Y0hDNlRyWEJDdFlHUi9tQk0xQXhJZ2dqQnZBWEVWMm9sTWFiVlFwUDhLSXhv?=
 =?utf-8?B?UmxjanV3Kzk5K3YrZlZENkRKTkVzeXJpS2N0c0d4TnhTYitkL1JaODdFVGpG?=
 =?utf-8?B?UUh5SythZ2xzanMvUmVqdm1PeFpncHlXNitoeXVNMUVWVWw3eVpEOVJkZmQ5?=
 =?utf-8?B?Mjk5SVM1VnNqTGM1ZDdidnRHV1FnL0doRXMvMHMrdVVqL2RjTFhmcjBHSFBr?=
 =?utf-8?B?eVRVWk8wd1RWVUt0VEhCOEI5Nm5TVWNFZHNiQVRzNzZFUE5IdTlSS3lyVkZO?=
 =?utf-8?B?TTZnWS80SExwV2RTN3V3SnVEZCtpOVFBNklzMkFGcHVwM0s1aDlOZlNab2lJ?=
 =?utf-8?B?cTYwM293bllnRThneXV2SVkvUEpBVjR2SnpXZlh5NkdETytYZ2czTithOFBY?=
 =?utf-8?B?SzZtRXdiUlZ3K3ZuWVZzQXorNllKSE55ZzVacFNLVXhtdDNhK3pSTVVKQk9u?=
 =?utf-8?Q?jbcecTDIHotFZ8Rqk0plJ40DW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6686b44-0440-4b23-d94d-08dbf1f5eeb1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:37.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02zHrarsbY50WRY9tGSu6K1IcsU/y9tsdreY89HtyGwwLAlzO5UFOpJGOwg5pXTGuskEcSi7Wrnv0tQR4nc8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v4 to v5
    - Add Miquel review tag

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

