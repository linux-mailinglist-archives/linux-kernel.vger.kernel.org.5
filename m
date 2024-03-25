Return-Path: <linux-kernel+bounces-116732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095188A2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259612E0A78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6141161307;
	Mon, 25 Mar 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="NjrSfMiO"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD516D30C;
	Mon, 25 Mar 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357359; cv=fail; b=usgRhOD44LdbGx171LCDSyuRi1tshiLzGGno3Roucr5vBnB+OUTk6viKdKXExGh4hxbzzl+k0rulSOvj6vVF/FJbnyjqXZkhgl3pFdY95b+EYL47gQxdObOcDa9rY6EmOoflZ/Ypywa+ZgAOGrsz9vi7FI1sEgNVvcQAp7y/RyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357359; c=relaxed/simple;
	bh=V4DZHkcARNC7fc2daZ1OECCct358ildSRykedHXTgNU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H/a119DGqS2FQmLSrS1oNui1lQ/kOwSJVyDSHyErSPMTA3Sy35tSVp8h7lPTmHZGLExz1gZVEFUfUFPqo4VSk1hIqArRSvY+qC//O8m/AhmKU7F6vjDrQukYQiU6o2HhVS7d0Fnct/tQ6bea5oAc5Z5V1mFD5W+JLpt3rWpKQco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=NjrSfMiO; arc=fail smtp.client-ip=40.107.7.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5mBucAUegHfq9T+ZkMKkKrJYrLC6QD8TXPvZWxhVvyf89QGrM8lHV20TPR7rBUxBGHz0cq2YD3r4rPu1W8mncC/kaM+xulGXgNkJl/FA7aNXFu7d15U4VSOJejdL95e82ei1iNqWi99bG1l79ksVrqe9f1DvMtaPlV9DhgkNLYun1zxvg6aU+gYNb+s0E/upPX8fzLEYNt8ZixqSz48AlTGjfLUS5Vf2FXrjZEGGQlc2VFputG9o1qxqDiB7lgZh7BWb3JfqMBQH+LddTf5iNxDgb0pW8kcE444g7RQ1vVZ7cmhw/IIW/7CcB9HcOAFfBLKe/pXwdafS8+TNhGAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6IxgU3KTNIxgzSKuZaYIlNmkj61o383/aiDnWetpD8=;
 b=GI47scM5dH/vbrxpWi4s0uKXCVvg6kuj6/10P+lTrk855BXSgBcB2bxZhGOVJh7r8bGyiIjhB1uMFFeftZACTCt9d4AbdC6F/XBmn91xU1RZiL9QwyPFvW3J3WaBjStwoP08qbM1T0ghornS6yaDcLdMTOGi75R1v5wzEUf7Xn0qU6djDWhYWR506n+VhDiMnkQRsTKjLNHl/R+OPm716DSC85V3glmsH77DKVBIif/Di0emHL+AkyQzwyqLEQdrIOSwht69peKojR+OwIbZSkpulRnXBYhi7mXmOurodQmywCypKcb05XZfnE10MgzWaVBijfUwh/LBGf6ruF51gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6IxgU3KTNIxgzSKuZaYIlNmkj61o383/aiDnWetpD8=;
 b=NjrSfMiOZYn2kfki+WJac6UXy3QdCjgRAGEqX7cS7+Pf1I1wt3Enr5feBIOfZH6wuQOy7TVFLdJXngq2HOU4o7ukaI6XBU8azpdtHDklzH8FK0Qei7TKdekO+ggI4urXX/S38nrAxzNCnzL5sIb9Pq6nMtRbN88z9LRO23mTfsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB7848.eurprd08.prod.outlook.com (2603:10a6:150:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:02:28 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:02:28 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 25 Mar 2024 10:02:22 +0100
Subject: [PATCH 2/2] usb: typec: tipd: fix event checking for tps6598x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-tps6598x_fix_event_handling-v1-2-633fe0c87cc8@wolfvision.net>
References: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
In-Reply-To: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711357347; l=3228;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=V4DZHkcARNC7fc2daZ1OECCct358ildSRykedHXTgNU=;
 b=oqMTptz5e9quNz9ztaaualZjG17J2v/Y0ZDoKeiCRD0Geok9ws2nLi4ErNi0SerQsO2VvjFYY
 2PscYN1aMt9Bcl3+S+l+0+ccY0AGS19vAVtpgLxcKpKgk+vxj83yZG1
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VE1PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:803:104::35) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfb46e1-09a7-4bb1-4242-08dc4caa4bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DP7DwmjGbymgOrulASjMnQJm02T3Ta+CG366QDt1WAKaaCrKZxw2F9lbZIhzho/QJ00+Dbrk2WP6UjvNVFAlmA3zx8Z5wngtFUQVSay8Y5rOGZQPgEA5YebqbC9uKdZ1DL1w/QIE+IpyNBYEzernDWw7TA9hNXpwI7PTrJbuRg3LmCcMX2p8HM0o00WHZ46XlNtQT+LgiVvh/EMDjsgAuW7XKO9/PoPL+8MaxKJ2lZw2NRNAqCTPMgZEcaKtWs2dRYp1n0NUbiRZJmJIgE2XF63bDg60VI0RgCxioX16vLhzxB7LJfCRgPlI+t4L3IhYrkI3yPt9Cd7Bq0KqDg7eheKwW+KZ6JWehSvIvCkdyC+rjqm7vtN+mkTRU/7bVllOKGnt0pMtjESfeAxxsw+mRb9JJMgJETsa2721iLmZWRtPyZsjTVO5UrBAtewzUshbH2mGg5efznM/oEub8BCOtzBTHO0ffIbHJem6k+1lfruvUf24twJJsNs4q+KnnOUGyMuOCh+FHTL0G4YTZAPyvDEiK6T1uzLkZbwpPb6R09Vy54NAReyam2vu4mdzY87MF/rSuWD3PQkF+BzJA3krFYNcj2ScJTVtCVYcSQ9WL2F69kiuz8OJ/LnAllzo+pQm6NDS2ufkedExtfd7FW2rpKQiGrBulDxNJ8uQT+Ac/JqrhQPykJpEbLVHhm7KqsJMB21FBSFL0dhyv3uwVfEvuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU5RbEFpN2svY2JIM1crYVlFRGE5TTN4VDc4NEQxZWN5QmZhSURBaFExcXlj?=
 =?utf-8?B?KzluWUlGb1V0c1c3SUtNYkhuRWJSdVFucnpGSWRKakM5OWRnaDlKWVZzb0Ry?=
 =?utf-8?B?NE02Z2FBOVo3VGpRY25xWjNreUEwemoycWFZc1UvWSszb1FoQjZLUDNVd3Qx?=
 =?utf-8?B?SXZZZFJoTnVjQ2xqeG50WUMzellvOXdVYzVLQjZWdFZyZFZvRXBZMkZpK3hq?=
 =?utf-8?B?bE43NXk1Q2M0am9neTJIY0NqbDhVTVBzTjFhK0ZYT3VHTkkvV1p1SXY2RHho?=
 =?utf-8?B?VUhtbHZzTVllQWV5UW1PMWthd3hvZG5LSU4rR3lqdTJ1MktHUkxuYXFtVkl6?=
 =?utf-8?B?U1ltMkNzYjJNUEJFTlp5YnJjQ2UzdVo3NHQrcTNaWDQ4MWU1cHdVMGIzQlBS?=
 =?utf-8?B?M01vQlE5VkUvNEZXT25UMElLcFJlTngvbXFKYURSd1Q5T053M3RKbG9BcDBN?=
 =?utf-8?B?U2h2NHcyeUNZTjBCR1NJQ3k0eWRybENQSEhYVHR0V21yeE9ISFE0Mm1PNzJu?=
 =?utf-8?B?bVBkWU1udTBwRGVOZFVEWGpsU2NmUytJa251dFNmVkc4aHFJZGczSGRUeFpX?=
 =?utf-8?B?MjVqZGI0S3FxU1E0cVhrSk5jTVVIekFZcVFJQXhjUHlPYWZLNXo1cUI5MTBw?=
 =?utf-8?B?M3BBMURTR1ZnUkE1K0RlNVJvbEQ5VkFBeWlIZjFSVE1xSzVzUHlLRzEyQjRS?=
 =?utf-8?B?NVhZQnM5QXV4SmpURkt5b0dxVTFlOGNOMTdiUVR6RVByRlJpZ3g2WTVpUGlF?=
 =?utf-8?B?NVdXSFJYWit0Ujdtc1g2VHRzQTlRN1pkcWlqQVpjUTBVWksyc3JLN3lNVmxB?=
 =?utf-8?B?VUNiRWtLOElCSXMybVE3emxXTmZIWVRGbXFWMnRSSCs3RG45bW5JaVZWWXF4?=
 =?utf-8?B?a045MjMwZUFaaDMvNmJoRHBRdGdUZ2JQS2J0QUlvV2tPaDBRa2lYQVl5NmJR?=
 =?utf-8?B?RjZNbkZtQmRUMkNlY0tOSUhnTnpqYXhabWZNMTliTUp5NGR0Um9MdExnZVlS?=
 =?utf-8?B?cU9GRW1PeUc0U2NkNHo2d0VtVlgxSGVqRE9zazdCTE9EN1FHS0VDMGpVRHQ1?=
 =?utf-8?B?TnIwODBxYVgvazdaRENRQ1VLL0s3eDliOHNadmprbWNsYmprTko3RDFOUWo3?=
 =?utf-8?B?cVVGZC9weEloeUVsUUxFbTBaWG1xYzBEUHFKd1FZeTdZWlhYMjFHWUt2SGFT?=
 =?utf-8?B?c0R3aU5ZajVqNGlwS1BER1RHZ3ljbUErdVd4dEdMK2JRSVpzWk05d2RKQlNl?=
 =?utf-8?B?d2FTNUwrUkEwRGpjQWdoTHE4UjBuUWRMN3Y0emEyOXNjTmU2TTlKTTRVcWZv?=
 =?utf-8?B?UG8zSjljYVIwOXpTQ1BIU3VqL1FzaDZmY2Q4R1k5aEhhRUFSUFJLeEt6eGdu?=
 =?utf-8?B?TlovOUphTnh4U2RoVEVNRVQrMk9xVWRObXEwRlpkSnlQenBmU05zKzEyb2tH?=
 =?utf-8?B?VzNrOS9XQmliTTBpdkdpSHNUcW5WanZvZDExTUpvNW94ZUZjWm4rYUZIbERS?=
 =?utf-8?B?aXh5S0p0Y2RIN0JIQU1OVFBDcVEySE5HaUEzdUZIeHdpMkVpaFRROFNvN3Bn?=
 =?utf-8?B?UWpqWkFVRUJKK1c2bnhKejlGU3c2N0tqLzRiMFMwR2RxODVlZXhCdlovV1NQ?=
 =?utf-8?B?TjYzWkN3bEVISTNQUEUrYTJjakt3TU9ickttQXRpZ1NaMUtaM09seVB3eXcv?=
 =?utf-8?B?V1B3cnV5SVhCdm5qZ0VLK29qRzRPUmNhNERCZ3I1MDlKUC9iUE1XYlFueGZo?=
 =?utf-8?B?Yy9zZlBidHBvekI5Nk1kK3RUOGdLbFBpdllBckRuYkd0bG5GaHdCQ0lwRXMw?=
 =?utf-8?B?TWhxdHE0N0tIYjEzbHVtT0hNU0lONHBFS3VTUlIzMStSTXBLTlNKME50cWJo?=
 =?utf-8?B?YllNeDZ2eWVUa3dnSzQweGVvb01RUHVaNjdzdm9zQjJKWUczOE5PdXlLMko0?=
 =?utf-8?B?U3NPbHU1MGt4NFFqZk9sM0RxSVRPVlQ0WXVhb3NDbWx2czZ5MVVQN1JYZ05n?=
 =?utf-8?B?eG1VdjdST3JabWJIamNlTkxxdzlSN2lJck53aGRVczF6aVVrdkZ2N1VHK2Y4?=
 =?utf-8?B?cVErdlc2cHphazJpMDgzenljR2NCM0ltME03TVNQeWc2ZDBBdDhqbmlGYVF3?=
 =?utf-8?B?Y2hvd1BDTENxY1hiNHo4ajBrN2o5SjlZb29EbEdGMkl5K3FXVWxoVU5sQTZ0?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb46e1-09a7-4bb1-4242-08dc4caa4bcf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:02:28.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKHt89uBX7Kdo0xBrA0SpFRoUbNDJNNtiKHqWDjH9GIqIhggaFVgfwhL//BkMvSbOYV/ysof27ib3F6tUgZTDbwTHu40UiTM7XqJSNdtZ84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7848

The current interrupt service routine of the tps6598x only reads the
first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
that any event above that range will be ignored, leaving interrupts
unattended. Moreover, those events will not be cleared, and the device
will keep the interrupt enabled.

This issue has been observed while attempting to load patches, and the
'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.

Read the complete INT_EVENT registers to handle all interrupts generated
by the device in a similar fashion to what is already done for the
tps25750.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7c2f01344860..308748d6cae6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -637,48 +637,53 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event1[2] = { };
+	u64 event2[2] = { };
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
 	if (ret) {
-		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, 11);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
+		goto err_unlock;
+	}
+	trace_tps6598x_irq(event1[0], event2[0]);
 
-	if (!(event1 | event2))
+	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, 11);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, 11);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event1[0] | event1[1] | event2[0] | event2[1])
 		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 

-- 
2.40.1


