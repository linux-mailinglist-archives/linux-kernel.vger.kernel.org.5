Return-Path: <linux-kernel+bounces-136745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111BB89D7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA75628542B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918686AC8;
	Tue,  9 Apr 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="A0hiCMyN"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79828594B;
	Tue,  9 Apr 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662115; cv=fail; b=uTR8ukDmPlPqEGd98be+jM3bh6XkRMYA+q80itLCsLmvECl+1G204tbIInEQ3l/jlNnJXvLOMZ6Fi0QTxz+mw8juICWKysx+GkaWfjPEgu7Q7YWN8YTsTSaHuZZV+LJhYhc1wIS2zERjEheAip0hKijt7KJ9SuAEO0+jsVa6hWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662115; c=relaxed/simple;
	bh=yXpZl4ly39Pl3RIdpY7PymAWGqwILuqkqTLH2SzJy1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kk8bJqflzDLu2mt43MqT4HRuiQ00e5yvzkqugzx7Xqe90+c1zInuLT0tzdRxD1xasf7IQQbg/lMS9h85yVzo63JZyqFHCkrZQZzkynbROjswmLW54eXy2rDQsVTOjDJb3d3ICrNq10TchvNeiQfVWFdvmzWo/A2aUvRa0pWdQ70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=A0hiCMyN; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLc+Khyr7JQAwtrnm/IJ/ngHP+rwm5cfcfOcgNlaIJ7Nj9o46C1BdreYbhbA09AZPctDoTUA/LXKr1mDyo9CcQwFIV2sS5i2Edd7OKab57BfqULyGq3UpPvmOod/rRF6ovhz9jj7cZdLnFe7Gi/OfjCVdAEMFyBCjKr1O3XbCLhEN3krZ4jxdHANFYg3H6Y2FvEwyoQ4tFLinElwbLpYCDMPa9N4mdA9/Vo3oj3Ch+SuWQNWo8B+dnzRPj5jqerkbVN3GhLmH+Pw7s/KPv1i2aZCodS7oYfb9abyW1+9ViPqHZBjWjzNr8y30eVpkkAN6kYpvelzY6FyTGrvGmoflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRsOuexl/4ugi6f4C0zbXuU59b/WKBFh4W4iRr7Vk94=;
 b=K9ZGrrTK6JfdyeLmFT5aVZZ+uT4F4/Vvy4zQSda0PrUiyjyOkFdDiwgPWbLsvRt/wtdPYgzChONTPwYS/W+exG3BqU83Q1WGKtlNk4xQVrURRjIxFDlkBaO59cry1HyCwub2O6d42B4dHLAoA9KVW4kjjTgPNSMcwDfrjtEkwsGaESQ5JZEn63KgabK4q0NHcsF47O2BbJxbXSX0OUUg9E4G0kn+UlyA/DfbOH4wKbDba+wGMhoJvqgZ2OIi+fY61Dkt0mNu/WoGMP4JBduVTGpwVX9QV9bl7v4z5LsvWYtVN0p7kb4uGYJ4N6YXRftuI0VGuWwExar0kFdkhuezmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRsOuexl/4ugi6f4C0zbXuU59b/WKBFh4W4iRr7Vk94=;
 b=A0hiCMyNfsq9EdmB7nbHX2PSq5SnhPLV1nPVVl/sAoBqVTC3XOkSyHQTJSYlNla73YcVQp//IHu0xdPr202VL/LMd9wcLF3QojsNu/8TQOPQyL1IVnQy8/9PtBfTAKKTo8wWIGkYnQnpyLAdQBH0dQHKFRu5hh9SeFRaVSiYLbY=
Received: from AS4P191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::18)
 by DB9PR02MB7161.eurprd02.prod.outlook.com (2603:10a6:10:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 11:28:29 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::66) by AS4P191CA0036.outlook.office365.com
 (2603:10a6:20b:657::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Tue, 9 Apr 2024 11:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 11:28:29 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 Apr
 2024 13:28:28 +0200
From: Rickard Andersson <rickaran@axis.com>
To: <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<sfrench@samba.org>, <pc@manguebit.com>, <ronniesahlberg@gmail.com>,
	<sprasad@microsoft.com>, <tom@talpey.com>
CC: <linux-kernel@vger.kernel.org>, <rickaran@axis.com>,
	<rickard314.andersson@gmail.com>, <kernel@axis.com>
Subject: [PATCH v2 1/1] smb: client: Fix hang in smb2_reconnect
Date: Tue, 9 Apr 2024 13:27:58 +0200
Message-ID: <20240409112758.467112-2-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240409112758.467112-1-rickaran@axis.com>
References: <20240409112758.467112-1-rickaran@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|DB9PR02MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b119189-2ebb-41f0-cd14-08dc58882e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RBi7hoXLlw6IvBjlPqNb6Q3ogW8t2cOr6G3Ktr4cbPWE4tmilltuuGXkMX72zVsF1UWy6NGvAaxurDEisFn2wXONRY4qCz1FLLTtKQ1rUV+34bZI33xT0TMwwm3evbfzRzYBdK/Imdafj70FhH08w2UwzzLwvuCNrSapgHTp2dYucKasLvSmMPgVTin5vFiDlifZrjfNswJ7sIIV+RZtdlbs6i2nWa21+T7YuqpnT89rz+lhQ0ewY0TXe0YHI8r0yZgyhj9tzjsmVd4i1tT6FpP3ykEpTE1eJz9/rSSPUNm0R+hkVE5+OxdRHncyOdRAmntmK0HXpAFkg5aCBwZi78ub5X8YYuoK/kHvKQFgurzkSrBdf1kdcjvmoikhviNU322qvadt5jlMc35mVTMyWrWkbgoygqMRhQFvpx+qsR6/jdYn9LAZOm3FmXSPSF+q1R0V/4PT1K6yjmBBBZX3yC1E195hGpy/pJCLR70GHljrrqIQgZV47mGvL6WTuXroUzBOf/YerfWyc5fD838cbkok85SlYutgNQkmCaYfWYIhq6/Yqz0k2m5TrFlnIz/x87M2xt/oywZno3YZjjqMbB4svU7rooadb5DESLniQcXwkVwM922b9GSjgVHqljUT3ehEHyLBmHdDvBboA5nQYAksu3yb3PcCIBCIAiB5PgE8ygtyirVQB6LHIwf14ezX7BjeW7cmGk/ZvkHrSCdCVzxktBAnbC8Z8sy6pB28yFuXTt3rXyGSgiIuYl7+IPfp
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:28:29.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b119189-2ebb-41f0-cd14-08dc58882e69
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7161

From: Rickard x Andersson <rickaran@axis.com>

Test case:
mount -t cifs //192.168.0.1/test y -o
  port=19999,ro,vers=2.1,sec=none,echo_interval=1
kill smbd with SIGSTOP
umount /tmp/y

Gives the following error:
 INFO: task umount:466 blocked for more than 122 seconds.
       Not tainted 6.8.2-axis9-devel #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
 message.
 task:umount state:D stack:0 pid:466 tgid:466 ppid:464 flags:0x00000004
  __schedule from schedule+0x34/0x108
  schedule from schedule_preempt_disabled+0x24/0x34
  schedule_preempt_disabled from __mutex_lock.constprop.0+0x330/0x8b0
  __mutex_lock.constprop.0 from smb2_reconnect+0x278/0x8fc [cifs]
  smb2_reconnect [cifs] from SMB2_open_init+0x54/0x9f4 [cifs]
  SMB2_open_init [cifs] from smb2_query_info_compound+0x1a0/0x500[cifs]
  smb2_query_info_compound [cifs] from smb2_queryfs+0x64/0x134 [cifs]
  smb2_queryfs [cifs] from cifs_statfs+0xc8/0x318 [cifs]
  cifs_statfs [cifs] from statfs_by_dentry+0x60/0x84
  statfs_by_dentry from fd_statfs+0x30/0x74
  fd_statfs from sys_fstatfs64+0x40/0x6c
  sys_fstatfs64 from ret_fast_syscall+0x0/0x54

The umount task is blocked waiting on the session mutex. The reason it
never gets the session mutex is because 'kworker/0:3' is holding the
mutex and is waiting for response (see line 1209 in
fs/smb/client/smb2pdu.c.

Stack trace of 'kworker/0:3' just before calling wait_for_response:
 CPU: 0 PID: 220 Comm: kworker/0:3 Not tainted 6.8.2-axis9-devel #1
 Hardware name: Freescale i.MX6 SoloX (Device Tree)
 Workqueue: cifsiod smb2_reconnect_server [cifs]
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x24/0x2c
  dump_stack_lvl from compound_send_recv+0x7bc/0xac8 [cifs]
  compound_send_recv [cifs] from cifs_send_recv+0x34/0x3c [cifs]
  cifs_send_recv [cifs] from SMB2_negotiate+0x410/0x13dc [cifs]
  SMB2_negotiate [cifs] from smb2_negotiate+0x4c/0x58 [cifs]
  smb2_negotiate [cifs] from cifs_negotiate_protocol+0x9c/0x100 [cifs]
  cifs_negotiate_protocol [cifs] from smb2_reconnect+0x418/0x8fc [cifs]
  smb2_reconnect [cifs] from smb2_reconnect_server+0x1dc/0x514 [cifs]
  smb2_reconnect_server [cifs] from process_one_work+0x188/0x3ec
  process_one_work from worker_thread+0x1fc/0x430
  worker_thread from kthread+0x110/0x130
  kthread from ret_from_fork+0x14/0x28

Change-Id: I53439ffb007c9c51d77ce40fb655a34e5ca291ec
Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 fs/smb/client/transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 994d70193432..96b8f8757ddc 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -32,6 +32,8 @@
 /* Max number of iovectors we can use off the stack when sending requests. */
 #define CIFS_MAX_IOV_SIZE 8
 
+#define RESPONSE_TIMEOUT_SECS 50
+
 void
 cifs_wake_up_task(struct mid_q_entry *mid)
 {
@@ -735,13 +737,14 @@ static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 static int
 wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 {
-	int error;
+	int ret;
+
+	ret = wait_event_killable_timeout(server->response_q,
+					  midQ->mid_state != MID_REQUEST_SUBMITTED &&
+					  midQ->mid_state != MID_RESPONSE_RECEIVED,
+					  RESPONSE_TIMEOUT_SECS*HZ);
 
-	error = wait_event_state(server->response_q,
-				 midQ->mid_state != MID_REQUEST_SUBMITTED &&
-				 midQ->mid_state != MID_RESPONSE_RECEIVED,
-				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
-	if (error < 0)
+	if ((ret < 0) || (ret == 0))
 		return -ERESTARTSYS;
 
 	return 0;
-- 
2.30.2


