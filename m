Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70C37DB3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjJ3HPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:15:39 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7553BD;
        Mon, 30 Oct 2023 00:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHNvrD71CUM6tAc2ny2BhB/4ZYw8XwZ4KdGmFmgnqwi1xzYU7NyTQgbqDEkNcT1FXRFnw68grizo/Mc10lsDg5Xt75DNEKR4Ce8UwU/DYOsoG+1IBF0nDsOwN+m3nhSiHjDZxycOsD9QDe/6RruVX9drgDZMiFrYNRazVgqwX6TFlEK/pQiTbDYDd9Xi3a0xPXbET5oMumYb/3DKL0mFI6zvsHeoN6lR0tXLrp7ORBqI4CT07ZwNbKeGpQnU0MRAKZPHK/Nkb3gCKi0FevE/LeNNa4pze+g9gCkMxvR0TEwXAqRfbpvoevMjhymjTi7MTEQwMLbdhBOjmHSJtHZTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX96sfRouqN2nRRKvOYxxMLVVfEwa7SIe0+kkU0vkI8=;
 b=XQJJCmSFHfMUqgBCgHMUHX4Cg8Hh6QuCufZ3n4qo9RVqX0+qzwnMwUkFeVH0h8Bdk0Or2lveoKmvDDFskq7QEV5Btyt1mQXdceGlskDig5erMuArXrhaLPm6m7wJpPINPI5Hje0SVpNgXBEkiopZgxae2OzvyHv1GH7Vo5lYSQClkQ54wSk0sxvtDL9P8OrZ3D5Sprv9Sce8QZz159OQ9OdapGWN1+x9qW5oTEmQehOBbAd+02t+y1M8E0F/fjAhbcfAq/kC2hQbr8dEaIkBAGMTSxL2gUIphY4IIUJGvhvRAbsYBmwEOSXdYxRQouZVp3IepLHHKD5zDYohm3fMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX96sfRouqN2nRRKvOYxxMLVVfEwa7SIe0+kkU0vkI8=;
 b=fu0ItL565Rr9s7XvXGXXiVsZu1zH4zR9mLfAcLPffrshC6idTUY2DenRoYvYzn+oQUFeTJMEx4c2I2hBfryh8xX1m0xxlS36o7gcy8N0N0DlAm/iqET7HqPhPWcsLQ/FKRXya3IpOHiJf2FOepoCJGK7ZRc2zHdX6escnKN4mRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DBBPR04MB7802.eurprd04.prod.outlook.com (2603:10a6:10:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 30 Oct
 2023 07:15:32 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::c4e8:4879:6e30:8886]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::c4e8:4879:6e30:8886%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 07:15:31 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     amitkumar.karwar@nxp.com, sherry.sun@nxp.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
Date:   Mon, 30 Oct 2023 12:45:58 +0530
Message-Id: <20231030071558.1631825-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|DBBPR04MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a8fc17-760b-4d65-e5a1-08dbd9180097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3r6Ld6Wig6KhBmNUEwiMAEKlmXAleaK+1Qe9BGhxfIXWjVB724q4fkrukKUX5G+hiqcYs/RdU9+GOol4WNKwpeMyo6XE7WmF0kfmBEyWTvP5VIw8UiRbFz3oQbzFKzgrPzD4BB7uncBxkp4jl0Qt+JBSA8m/a+moRh9vuQiffA7kPzqAD6KEqhMxj+35HQjdXI80mGt+JZo0dfRH+gVu7UwdmDCRuR2GRU3w9D1Uh44Df+kNCBLNDGp+Wv3sae889aQnYGP9wVlLQUy6AbsOoUTuZiQzIo7NXBRaUBGVRHc06hFOmJPwW/zn9gS5Yv9eo7Efukpg0jCI1tZjKpuD1qBYojEnY4NyCB2pQ1FsoB5BbMPML/SApZgVohv3JERrVT7LhhDLVEwLEAASHAt9m7i7jiqu0qEsqhrhEjS6Ly2cJhWMZ9fN+eTw5kPTlNy/WJX6FVLK6rC9NBYt2mYVVgoDxUF3HnJr+RkSpLCUfpnV2hAtvkKH2kZz+1IvjPiYt2Lw4+wlA0jLcZZJxFuP4YQvRFkPEwOZt0WG7TPi8BVcJggqg0pKDyk4Tecb8ATGf2cmtpdPXPzwy0JJZB9qrQyjHmt8pAH16gXxGAjm68WmCgZ4vzJ3c1wQuxG45NXc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(478600001)(86362001)(6512007)(66476007)(66556008)(6666004)(66946007)(5660300002)(6486002)(316002)(6506007)(41300700001)(52116002)(4326008)(8676002)(38100700002)(2906002)(8936002)(36756003)(26005)(2616005)(1076003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4FMf3gBbC6Y4kDT6gMExsqH2aMyL/SlOv4COEPssILM/0jFyoma2PhvbD96?=
 =?us-ascii?Q?JnLRMBsSgm1eBgfFRlkx5LCEgKUQf+REVDhiFxFzo2X+F4Eg0eVlulZzgs9Z?=
 =?us-ascii?Q?VGz4EKBI0O1mjSvSw2cwqblmRJDUDGyGxsAgXeiDTFev+5iTKebByb/mv4Ry?=
 =?us-ascii?Q?DBbSlwQKsst/Z0zcWrxYm/10YgFKrDhYUlXOLBAwBZ2jZeAcxQro+c44ldE8?=
 =?us-ascii?Q?viFcFKPxC5mGKbRTEovoFKnBMNYRK8CQdydV0TjBYH4cRkqgRV5/s9Fmyuk9?=
 =?us-ascii?Q?ka6+KSZks+h0by+w//NJqSC6uuuc1Kidjqu3o/qYAEoiVX+L0LjfcXaFSy/G?=
 =?us-ascii?Q?udfGuk8bM434eqc3cxrJoB7VFh/V4JmFZVxEM0Nwpw2Eps6DwIZqtCIzbBK6?=
 =?us-ascii?Q?4pNLE5aNFln+3T6aR21oYMJiaCR39u8v6cbBXmkk0McAYBsCmtAK0spYYEmJ?=
 =?us-ascii?Q?S2Grd63ML1ZSJMy4xmmgxrHSaCSGdNpfkD9eCKIV8BcWvSS0i4hpDxLo3OBY?=
 =?us-ascii?Q?Y6viRzjR5bluQKpRrtzbKgYUX1N8SLIFQu3fFRXWZMi3zFeJ2kxKCS+pK3Z0?=
 =?us-ascii?Q?kVWIE1/MrCCbpfRrSNZkWDexh+CoHx3Iv4zft6Dy4cpo7cvWAZN4Z0lmtdOJ?=
 =?us-ascii?Q?8/Uo52RLrRQhYAzvCOe+f2ziinPIHhqRakKLgnXFD5w32B4a5WyPTpa/EdQ0?=
 =?us-ascii?Q?BcgHXpTcvXwDxJ2rMgVJGgjBlD6NbdSwyyJfeRnVE+7sjN3iW9pgM4y7gZop?=
 =?us-ascii?Q?IVcX9XPWY2IMetLPVpMHOFQrrulpNrZJq2pM465sHc00EjE4R48UfYq1V98u?=
 =?us-ascii?Q?w1YpjPyMjpbn9zioa4ufGpWfqbU7qWV9M/QQt83g90S2oAKD5EforAqGzDQN?=
 =?us-ascii?Q?QRyWZxbcOtoQs+HuwvSKPSjAMmzDJbnGdPWbjw38Nik7De0aXcM1xTxjxfOP?=
 =?us-ascii?Q?iCH3aHD+LmXMT4XK2CXhktmmYXnj/JDWiqTMkMrid8hIDSH/5PGJ0B6Q70i7?=
 =?us-ascii?Q?b/thRgko8Mx8XIjBE5HczyOLlhvpIp8fSJex48wJUOXB2K1Fob9WjUcrv1id?=
 =?us-ascii?Q?scdXhWCL51BxQSwU2f0rI7xc/esOVGzGrP11blnRQjkgnrr9VGI46e2TgS9k?=
 =?us-ascii?Q?gFEPRwEmNeboVGoZ4S2mcPjXiRJR72pBY2UrvVJHgpoQvQok8Ei8W+hqJhXS?=
 =?us-ascii?Q?G/76u4JAvl3L52VZL6j0mraGErfedijX3hQjROn63KuvDOoWK22lBVnmLvB/?=
 =?us-ascii?Q?cbc2pOZYZ8lGXvZdlZheYpOJm+NY8l35OOtIabigB+BfifFZMCTcSbtMD/lt?=
 =?us-ascii?Q?CVm9E5fK1HlZqhgioCrC+8Tj+2aCVfZZnTElXBG1IC0ocf8m6/0fy5JEQLnn?=
 =?us-ascii?Q?AJMddcxzbiQ82+PLjFCWv0v7SlyMZXM08dMN0mdI3fwbPPPMVP3uLZmFO258?=
 =?us-ascii?Q?RNi++VHDjyau2eeB2WlpeyKgELYW7Ozp4viHy4recjaeNzJyPs65rnLNzCku?=
 =?us-ascii?Q?OSQIhJCGhzsF7dQZ8AbJNoLxxuX0PvcOHSD3aevT8GjmVISdjXcsdh33JrKV?=
 =?us-ascii?Q?e0G8blemGslP+mF6nUKAYPcKgg5hVbAtbEhvyRcIhGDXn4Pci5vzVo9LBvl+?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a8fc17-760b-4d65-e5a1-08dbd9180097
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:15:31.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvtOUgjVPHrp/d2YpbCyCO2sP/Ya5B5gw6JsUQ0+SjDkXBB73Vl+V67WUoGIokee+gAxWa5sK3Jjnv9iwNWZ1IVuzym7+szcFAHxN+9P7vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the tx timeout issue seen while running a stress test on
btnxpuart for couple of hours, such that the interval between two HCI
commands coincide with the power save timeout value of 2 seconds.

Test procedure using bash script:
<load btnxpuart.ko>
hciconfig hci0 up
//Enable Power Save feature
hcitool -i hci0 cmd 3f 23 02 00 00
while (true)
do
    hciconfig hci0 leadv
    sleep 2
    hciconfig hci0 noleadv
    sleep 2
done

Error log, after adding few more debug prints:
[ 2206.497227] Bluetooth: btnxpuart_queue_skb(): 01 0A 20 01 00
[ 2206.498239] Bluetooth: hci0: Set UART break: on, status=0
[ 2206.503283] Bluetooth: hci0: btnxpuart_tx_wakeup() tx_work scheduled
[ 2206.503299] Bluetooth: hci0: btnxpuart_tx_work() dequeue: 01 0A 20 01 00
Can't set advertise mode on hci0: Connection timed out (110)
[ 2208.514238] Bluetooth: hci0: command 0x200a tx timeout

When the power save mechanism turns on UART break, and btnxpuart_tx_work()
is scheduled simultaneously, psdata->ps_state is read as PS_STATE_AWAKE,
which prevents the psdata->work from being scheduled, which is responsible
to turn OFF UART break.

This issue is fixed by adding a ps_lock mutex around UART break on/off as
well as around ps_state read/write.
btnxpuart_tx_wakeup() will now read updated ps_state value. If ps_state is
PS_STATE_SLEEP, it will first schedule psdata->work, and then it will
reschedule itself once UART break has been turned off and ps_state is
PS_STATE_AWAKE.

Tested above script for 50,000 iterations and TX timeout error was not
observed anymore.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..a68d10771c99 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -126,6 +126,7 @@ struct ps_data {
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
+	struct mutex ps_lock;
 };
 
 struct wakeup_cmd_payload {
@@ -337,6 +338,7 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 	    !test_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state))
 		return;
 
+	mutex_lock(&psdata->ps_lock);
 	switch (psdata->cur_h2c_wakeupmode) {
 	case WAKEUP_METHOD_DTR:
 		if (ps_state == PS_STATE_AWAKE)
@@ -356,6 +358,8 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 	}
 	if (!status)
 		psdata->ps_state = ps_state;
+	mutex_unlock(&psdata->ps_lock);
+
 	if (ps_state == PS_STATE_AWAKE)
 		btnxpuart_tx_wakeup(nxpdev);
 }
@@ -391,17 +395,25 @@ static void ps_setup(struct hci_dev *hdev)
 
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
+	mutex_init(&psdata->ps_lock);
 	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
 }
 
-static void ps_wakeup(struct btnxpuart_dev *nxpdev)
+static bool ps_wakeup(struct btnxpuart_dev *nxpdev)
 {
 	struct ps_data *psdata = &nxpdev->psdata;
+	u8 ps_state;
+
+	mutex_lock(&psdata->ps_lock);
+	ps_state = psdata->ps_state;
+	mutex_unlock(&psdata->ps_lock);
 
-	if (psdata->ps_state != PS_STATE_AWAKE) {
+	if (ps_state != PS_STATE_AWAKE) {
 		psdata->ps_cmd = PS_CMD_EXIT_PS;
 		schedule_work(&psdata->work);
+		return true;
 	}
+	return false;
 }
 
 static int send_ps_cmd(struct hci_dev *hdev, void *data)
@@ -1171,7 +1183,6 @@ static struct sk_buff *nxp_dequeue(void *data)
 {
 	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)data;
 
-	ps_wakeup(nxpdev);
 	ps_start_timer(nxpdev);
 	return skb_dequeue(&nxpdev->txq);
 }
@@ -1186,6 +1197,11 @@ static void btnxpuart_tx_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int len;
 
+	if (ps_wakeup(nxpdev)) {
+		schedule_work(&nxpdev->tx_work);
+		return;
+	}
+
 	while ((skb = nxp_dequeue(nxpdev))) {
 		len = serdev_device_write_buf(serdev, skb->data, skb->len);
 		hdev->stat.byte_tx += len;
-- 
2.34.1

