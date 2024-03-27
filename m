Return-Path: <linux-kernel+bounces-120215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B8788D48A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BD71C2410B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE3120DF7;
	Wed, 27 Mar 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fTjp7iE9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E217BA6;
	Wed, 27 Mar 2024 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506561; cv=fail; b=rti32+5iKZKGTumbgRhD7xmq6+WqS8fLf5R2qqv99KhKrxuHFADrm4J3OsbGOKxDDZBu3V+rZwb5ld43PGajxqtkpcNp/Sa7k0+9P0wIywv162ACoWo283L73fniYyOlM2RMOtnqzJMWcR6ErNXJ1pR3bcJIas90LXT+i8UXGLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506561; c=relaxed/simple;
	bh=d5eCP8ZItzhIeDzQQM6S/dKCd3K2JQGytXRFEVsTYmM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RcRTuNVncpAiZUiCWlp9ciZWMDZPvLQVVZIvBxnAy242PwGMzM0bLNP/hqzJ6iSR2gLWhDAWSupFehzVILL2IFazf6gLHw4cAQc2rkJBgTOmnqlIMNRAKGCEqSUlLojmH7qJR/TXtjwtp3aA+PXfnjIfkVuBi99P7iZAGz15Onc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fTjp7iE9; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIIAotVjYImFjrwRQv2Mpb39zMhHp5EZlVH6a3cLwL6Ws8fFzP4CB8YAce/77cCNd7ebN9hMLDmvvVRDay2PUTVgtUu812+3ie6P+8tIYdwAjhY46vBJUi6BkNy6Rs1wdEUTdNwaBVHVjio5o7HNw0WsJl20ELBP2xF2pW4mbDw4PWikacoNKyuZxSk738ie23wOCT/DEgofbfkyIfGQY1rqCnp85+d8Jqd51go8XLhA8P8KkQWD/rQmwOGNA613DLE0A121Uykr72vVfeOKDbaN6Gvw9k173nanzXYJ8ZI7jOD0hfE3yZJ1hMe69bGjR+nKl8HsV5ue7yDanJIZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qaf+zladn37bMtw43Qj0rOz1L1uTahX8BhvlUF1DZIE=;
 b=hvNE0fWxLghoWacgMMiPwUfSyYmcIEiCAGm1H2tCD/Vvqu4yGyamGbBqAx22+DMr8ePu6nPSlW0fwAX+2oxMeelJeE5n5csqhQZCJQLulOoqIAb9a/c/iH19bS0jPpcymOqsaq2UJz4tBNdAo5YesLcu/BRrPGaIuQ46nBoa5Bd+zP4uxcthBluLIQlSSx3iCTmnDb36snGsXdcuy6XRX7wyMi7nIBt4GoT29qM6PWXWLOUAA+d8y77Ja6TFZ+Ra4iYvvP6oYOhyydmyQygQ2lXIhvdIZpp7456J/slF2VwlR19O5kcpWoh+QiBzmKYUK0BGObeZ7CADH2evI4D0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qaf+zladn37bMtw43Qj0rOz1L1uTahX8BhvlUF1DZIE=;
 b=fTjp7iE9XQ2gNOb7OFSK4Fe3hyauLCeQZhFwm80W7B3rZTdbvJUP/vMu+OpnYYHPB43u5TLhDX+iiZUYWJSOTuzeAKbO1Efd6y4gg082RTHEysvdJr5bOhakX0HUNpxqGvColG6sHXZCimGtqXa8EkmaO6iR6/ZHMX6U7Tay6MitaQB/vOO1tyxMPCuXSmwsaSu7jrKEh3qx5vlOlEt3V3KN/exdkutC3HV/oh7I2Cpff7c80ek/VbYpCO+s6jLObOmbwX82SPwWqoSsuv4UoqrMfjihgKL6FmWWle0NoxA0NMWHvDHNaPeHO6EejOQiQm+QBdyoIDoLWhjcX/sfGA==
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5176.apcprd06.prod.outlook.com (2603:1096:101:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 02:29:12 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::575d:49f:44bb:b50d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::575d:49f:44bb:b50d%6]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 02:29:12 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] dmabuf: fix dmabuf file poll uaf issue
Date: Wed, 27 Mar 2024 10:29:03 +0800
Message-ID: <20240327022903.776-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5176:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dIU0N4othX3dc6e9RQlVhM9w+pXR+F/2POdw9JiXqnt7eoCbjsbQ8gEl+WloZuFn/d8H3vmdGmjBi47rIZUohwiMARUpwNxVLB7OB6No9KzSNQbW/GlHkngeIPoMiUuBKRmk/X/C5uVCYQfwKzclRQaEdYlUpOoGgdlqHrL24kpqoCMXccndGJCrQWalrC4W7pB1E3dyub2Cwby2EKW9g04utrWSHdjoNyIXFkX6Q5MoJPfNv5cjRxaCYtaL5/v9jNTIHNkKxb6mhOESMesnvcWg8F2hGiktdKoOamz9nb1yHAggXrQloSMpG9ZGik2mtdOWwRWaUWpolkwpoRLJ1easvcnD3UQEWVtUCdRiHWJbCxLPWgNFXsohYzJ/5705xt3wiGarkdNGK/FBefHp1C2R5Qff2/4c5aU6It5p+AGH4umTV/DiZV66XljAeBFhLBkuc8x3B+4lMlcMzcA2QuWXR/qye01S3zVvbRAimXwtVnI79/WQ9Wram6iFPAvVah5OCWQi0X7HS4HDCcuXOG6OnnnEBbVgUczVN3Fpx1DCA5uEPH1uRuj18AM59NO35Q0o/yQM0oC6QB7lDK2QenAdzXG/u8cu61bCg4pgEplhElKdrkQBUoxkTcrpP8go7JQwMGFP6iQ9RA/Aj+hwkNtLnmp4WnKjf1JjyJsYK7VxJPilaIltz3XvScMbZTuxNmtsk76TucMIh3prdSDn8V/h+CHqiNCq4w7Fee8VJsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XkbhkUqakJfIbYcYloP9Z1dwaQJZz4YfZ7vVWnYAqfdxkUiCRQKtKz0Xm/xT?=
 =?us-ascii?Q?WIvh0t9qO4duCgKEugqCy7vdtmz723WigV0aBD3N7SwrSfa0P5+ALANMvsP7?=
 =?us-ascii?Q?SJf5LzT6G8SJQ+seobnY6TCC3amOgS3x0Iksm0X1KNQEaTgj3DhGOkITcAz7?=
 =?us-ascii?Q?fGeo3fD/15czz4Sxx8hpvl7c7oWQEvEEKziAQW2/hEr361Lwys4sLxlfuJww?=
 =?us-ascii?Q?mbpBddbrcdWj/XaWqF8+WSQByOmj5D1jyral4wljgb6rkF28Wpu/xH4YFGxD?=
 =?us-ascii?Q?qUgy5CKnr6yrjZ8sLud6YlMpy2GmTw3hfY5K9y1LcZX0mW6/ELlqny2oLrH+?=
 =?us-ascii?Q?Zag1ICiGHrr/xBxMJuhs0NrFkm5+If05f8R2p98uNwycT9w5jF6BtGuLLiP3?=
 =?us-ascii?Q?P/tPlyrHlojY8+3Sk3jBdBgRq/1oUj7Z6MRnUwsXQk0za5zLr2S7XZlMUM8b?=
 =?us-ascii?Q?5WopB4RLEn37hfTOHCHohATvwhsD9gkWBdy1LMBZ8r/wqhxbEAg7RbTpd8pM?=
 =?us-ascii?Q?lxYPxoqhth3K4X3Joar8EamfY0l5AoSGVhwEE6AIt3jgG7pq7SnX6eRM9+89?=
 =?us-ascii?Q?gQvW85lsCiVb2ye5QCtNYekk4uxE4ZM2GZ8+PGhMbkCNtaWdG1pnNpvzw7Ah?=
 =?us-ascii?Q?y9PWfau+hFfC1dVzi6P2R2L4rj2QRmdoWwAjRcgOjN5U3YuhKXkJ5uCBcfXk?=
 =?us-ascii?Q?1BAJyQuycCteL1+rm9BAnm7Ud8wTE0HZYdwekc1YK6gJSuP/BgFHAubHqgYs?=
 =?us-ascii?Q?GKdzM61vg1M0564kyS0JNj6Sp88Q1tUZ3RZ4C/6GLlTGaJI8HcEkVwvfKDLN?=
 =?us-ascii?Q?5X+K9tYKBA8/5C3HkvWvkZuQsk6/BLofH5NvahRyafVNarAce5ogB+dimGOx?=
 =?us-ascii?Q?l8CpQc81fn/28O3+ZeibceCQ9A3Z8k4rCf3ToLGm/U1EVzkwZ7JMNofWm3y0?=
 =?us-ascii?Q?KKq6sjBuyIerEIq74azgzk4MesbcDipfyZEek0eLGYywGxIBKCO8qGdtWWnM?=
 =?us-ascii?Q?3dgLaQRWZ6cM+QCeU7PY6TEj+OM8yzVzm42mdVnjF9ncFFuN1Kr8uLB40qL7?=
 =?us-ascii?Q?k/TN437XmroejNsFsp3MlD6tdpANpr2QzZ6bSe8suwR3BXyKnuEkLUMWTOLY?=
 =?us-ascii?Q?CKrhomSXrdSg+yX/WWbCMTNspCV5GH42rn0jwLeRUG+Zaa0i3FsUZCtHDlpt?=
 =?us-ascii?Q?XsKhJyC+xLp8J58iDM35+CVhJAHJ/RuGqa1cUjPsw6h3VCkqaterBEWFngDu?=
 =?us-ascii?Q?wJYdFxEnwGOmvKuQdWkw091KexsI4EhUuGyrpE3ZTSvSsFEL6M7kIdo+c3RC?=
 =?us-ascii?Q?muX/DfB9dndt8g5TWf0pnEU7rvJN4PAFEUFy6nMK3RPBmrQ1IyYjh9CnGsq7?=
 =?us-ascii?Q?UtI3O9zbm9T2lLhOxPXId+SrQ6QKKYcyCo8SjJ80j/A9h5JMHz1POZYXbGIt?=
 =?us-ascii?Q?3/WxvfvCNqEIb6ncBOLIA0HqU8OP901wYs9gUmfw5UdU/fjdbxCDfBY0BSgb?=
 =?us-ascii?Q?PZcqaPNfTP6BKdItLG4Sf2yv8JK7de1jpn65fhHGsWUDWMkgwG9GONIjvixA?=
 =?us-ascii?Q?qmOwzIqyQaRhO/Bxvf2Xlf6hT3ZU/m6XXS+aDcZz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ee4ad5-ceec-4a4e-526c-08dc4e05b040
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 02:29:11.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqWMMCO9whZl2fUqDSoG8hjwTCfJzA9A8KX+tkJ0R0yZbI9FhNtTb6yAIUlfoWvY378gz1LdesizAk3QE0uh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5176

The issue is a UAF issue of dmabuf file fd. Throght debugging, we found
that the dmabuf file fd is added to the epoll event listener list, and
when it is released, it is not removed from the epoll list, which leads
to the UAF(Use-After-Free) issue. 

The UAF issue can be solved by checking dmabuf file->f_count value and
skipping the poll operation for the closed dmabuf file in the
dma_buf_poll(). We have tested this solved patch multiple times and
have not reproduced the uaf issue.

crash dump:
list_del corruption, ffffff8a6f143a90->next is LIST_POISON1
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:55!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
pc : __list_del_entry_valid+0x98/0xd4
lr : __list_del_entry_valid+0x98/0xd4
sp : ffffffc01d413d00
x29: ffffffc01d413d00 x28: 00000000000000c0 x27: 0000000000000020
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000080007
x23: ffffff8b22e5dcc0 x22: ffffff88a6be12d0 x21: ffffff8b22e572b0
x20: ffffff80254ed0a0 x19: ffffff8a6f143a00 x18: ffffffda5efed3c0
x17: 6165642820314e4f x16: 53494f505f545349 x15: 4c20736920747865
x14: 6e3e2d3039613334 x13: 2930303130303030 x12: 0000000000000018
x11: ffffff8b6c188000 x10: 00000000ffffffff x9 : 6c8413a194897b00
x8 : 6c8413a194897b00 x7 : 74707572726f6320 x6 : 6c65645f7473696c
x5 : ffffff8b6c3b2a3e x4 : ffffff8b6c3b2a40 x3 : ffff103000001005
x2 : 0000000000000001 x1 : 00000000000000c0 x0 : 000000000000004e
Call trace:
 __list_del_entry_valid+0x98/0xd4
 dma_buf_file_release+0x48/0x90
 __fput+0xf4/0x280
 ____fput+0x10/0x20
 task_work_run+0xcc/0xf4
 do_notify_resume+0x2a0/0x33c
 el0_svc+0x5c/0xa4
 el0t_64_sync_handler+0x68/0xb4
 el0t_64_sync+0x1a0/0x1a4
Code: d0006fe0 912c5000 f2fbd5a2 94231a01 (d4210000) 
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception
SMP: stopping secondary CPUs

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 drivers/dma-buf/dma-buf.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 drivers/dma-buf/dma-buf.c

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8fe5aa67b167..e469dd9288cc
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -240,6 +240,10 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	struct dma_resv *resv;
 	__poll_t events;
 
+	/* Check if the file exists */
+	if (!file_count(file))
+		return EPOLLERR;
+
 	dmabuf = file->private_data;
 	if (!dmabuf || !dmabuf->resv)
 		return EPOLLERR;
@@ -266,8 +270,15 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		spin_unlock_irq(&dmabuf->poll.lock);
 
 		if (events & EPOLLOUT) {
-			/* Paired with fput in dma_buf_poll_cb */
-			get_file(dmabuf->file);
+			/*
+			 * Paired with fput in dma_buf_poll_cb,
+			 * Skip poll for the closed file.
+			 */
+			if (!get_file_rcu(&dmabuf->file)) {
+				events &= ~EPOLLOUT;
+				dcb->active = 0;
+				goto clear_out_event;
+			}
 
 			if (!dma_buf_poll_add_cb(resv, true, dcb))
 				/* No callback queued, wake up any other waiters */
@@ -277,6 +288,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		}
 	}
 
+clear_out_event:
 	if (events & EPOLLIN) {
 		struct dma_buf_poll_cb_t *dcb = &dmabuf->cb_in;
 
@@ -289,8 +301,15 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		spin_unlock_irq(&dmabuf->poll.lock);
 
 		if (events & EPOLLIN) {
-			/* Paired with fput in dma_buf_poll_cb */
-			get_file(dmabuf->file);
+			/*
+			 * Paired with fput in dma_buf_poll_cb,
+			 * Skip poll for the closed file.
+			 */
+			if (!get_file_rcu(&dmabuf->file)) {
+				events &= ~EPOLLIN;
+				dcb->active = 0;
+				goto clear_in_event;
+			}
 
 			if (!dma_buf_poll_add_cb(resv, false, dcb))
 				/* No callback queued, wake up any other waiters */
@@ -300,6 +319,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		}
 	}
 
+clear_in_event:
 	dma_resv_unlock(resv);
 	return events;
 }
-- 
2.39.0


