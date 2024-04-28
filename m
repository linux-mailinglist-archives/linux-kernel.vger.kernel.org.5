Return-Path: <linux-kernel+bounces-161253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78A8B499D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB90281EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8D3C38;
	Sun, 28 Apr 2024 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pPdmMD01"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19011003.outbound.protection.outlook.com [52.103.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466E19F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714279508; cv=fail; b=XHNTNXq8KHkyni0irYQG/2UNytqRu/KD41xspa2SZ4K8izH8LkioVgzlzGVsPz/935IERDqbphkhINCvmPlnP4B93rfY09UH+Bs2UsOwVofdxwLTXsW1CZah20Gxzb6xdUhGO/cNeKKLKHlHa546oh79vxtJf3DDBOPnjn9lIKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714279508; c=relaxed/simple;
	bh=cBdNWWQPo4+AjeWksCaZzxycSNDHAdGVeVpcVOLVr7k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=big//IvxtlOKHIiU6Y0wUU3iwXw2cpT5pnwkPON4olxlSD/VSWfLb84PsCyxTdfbnWltTbWJq1EVOTJE8jM2R+BI7znfO4NfPA17uvBW0hQWsV2z9yceBBZt+QbJgjWG1BoxWG0kq4sx99B+NUGqlf7KF7OMESpa7tliSaV0xVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pPdmMD01; arc=fail smtp.client-ip=52.103.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuL0QbWrfwKLfJcVS8pVQ5orIiojgsMZScnRXG2DkWthqmOBxSufLvI+fmZwCmFIb3gj/ZH3mkrQA2QnfJlkzc+/F9r+BAK7/APiCNWc9PqMJnnmd+SuMGeaeszMAV/khn1InJ6SsIyF8IggNaw5SnjaTHYyHUnXazFAiyf0yaorToHBOjQLGdU6QoS+aQk7Qh75SIHPGALcn2SDEPNlbx6P1Ag+IY9P85+6UQpb1nxSFPiliapxjoPl2Vbq9dy6B/00oU1j27CC/d3HkQ/HG1zACtCJZVYXdsB3vVWXXzoHQJkKW0hqvuB5tF0/XjwI3h0EKc8DC4ov3VfzIpNHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FRUhzaLIO+NPD86/Q7agHIkNEjG7ywy+myCCzisDxI=;
 b=ZvMi1bMOyyh7V2TUOXgsDeeAXj48PDLQ7jqk5ZKFMAJk8IwYu/t2FhW9nTHdGL/zBIz2hP/Oy4ut3pZPjicTZQUWDot40sMZSe0ijCqBmUTzOEnTAmi/h2DftB1GtXdNE2H6ki5gL0C7lwbPtAKStOcXLPnh5NTVMfDt3wsIhHm2GMUCPUnqhIxw4LdcyV/4WQjDtlZlVvsfONfvamOf3mnIzsmcuqCVUUpyZkmDxoY8DontSpwk9LTpxVTh0u2PRL2f+Cstkx1ohdX64frsj+x7w3ZwlXI060lWpMY63RbAyHvTVBLOW9Sbh3WyFPXHDMDFMuO+7GBRlNmMmkxyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FRUhzaLIO+NPD86/Q7agHIkNEjG7ywy+myCCzisDxI=;
 b=pPdmMD011eoCcssJp1ekB9hMxJ2iXXz5XZh6slx6nfv907bNQEze7eTNxmxRhZ0Dn/jcB3u1ST6HUnOPSe8ne3NnnGZuUCYgRyhuKNSDQU0IzlzgUlh3R4i+mGp1olLtCKiofkRv9JZJ085tt+k2A0GYNh6OIatqS5/bfNlpETQKw5w8/3WGC53xoySjB+/l8CGywfPiBvY2/04Bw5O2a1/cWGYqnpK2VyXAdqI6YiC5S7UCTRfr8fRmEGI0oJswvIG9KT8QOold2LFdCl5GLvmpKz7EXg0Paq70A9WL4W9drziZBVPIjcid5hL2glz+17WNdPWfI1zKedcThl8HpA==
Received: from TYAP286MB0026.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::13)
 by OSZP286MB1799.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 04:45:02 +0000
Received: from TYAP286MB0026.JPNP286.PROD.OUTLOOK.COM
 ([fe80::435b:a73c:1b5e:2169]) by TYAP286MB0026.JPNP286.PROD.OUTLOOK.COM
 ([fe80::435b:a73c:1b5e:2169%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 04:45:02 +0000
From: Zesen Liu <ftyg@live.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Zesen Liu <ftyg@live.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sched: update the location of entry_64.S in the code comment
Date: Sun, 28 Apr 2024 12:44:39 +0800
Message-ID:
 <TYAP286MB0026B32BB0A525F6635F6F21AF142@TYAP286MB0026.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8RPdo1up3hdZTAJg/FFKK8BpcFSBIW3z]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To TYAP286MB0026.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::13)
X-Microsoft-Original-Message-ID: <20240428044440.30718-1-ftyg@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0026:EE_|OSZP286MB1799:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0c9bd2-0a61-4f93-6b44-08dc673df7a1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	Mdu4EDcFBORl5jYIcmSG+SfA8P16Uhm+BsuCqWoCmYC7rrIU+ordF0iJkzwcmkUdq9wHfc8FV8zfnQ4j++dNRSpoxYhmbdnRR2ri1FaTWNZKHUZIR5gomtBcxO8VqxBh977To6ir591HbmJImO6st0kGIIyn+B85v/t/Ya2+vripOwmokCzAVjYuQPB6vdg4CjaXOnQG4DlMQlUzBySvf7qLaOvfbEAE83azjsG21W37iZ3lS3GBK5lJuQ0kkFTFCtG7jDHYxtvuhqTiFiQL1aRKhrr1iaUAJ87lUyZVUNA53x31HJ4xkRzYPFFDTbtVJEbcw01jIoi86r7hGAu7sPWVUnuVh36qGWXgzWodB+gRhFKyjGqqV9+L80wDVzZ3yQg3PfXnJK5ER1hzGu5q7IGnX2LYqjLvFmAeA2f1YyJXCJfX48hztlVCjWJ7h2hOU0lVMmInCGioqrK+RMnjcoW+KunjjgOV9OMwTrto4YautL86wGoSuWJHnP6vrlFV0aooU+u+Waubiu+MZCjOn7+0QmFKwDQTdfA9vUHUuT/oHChzsZYvnXtxbGDjVUsvF+NQpiYzcZv9GnnFL1KZO70a25AOIgNxUnNT2yBYMh8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3lSNJ2lHRL3POSjNtT/d00dokIifbDDlflu5lCJL0wniw1nOt527AFVPbi3q?=
 =?us-ascii?Q?2BoGQTl3Jmniey9qfcPeU5XVN6Kbtmb9cp1oyD9WldQETuBN3MuRr7f9m1JR?=
 =?us-ascii?Q?uflFT2MLMq6o6eYgnJ8gR5r65rKIrjjLIJltPn4u3c1gMduu3og0iKxYYo0K?=
 =?us-ascii?Q?4n9YV+8+ZOGbKBBYByl0ObDHmF7QZEXqJGl7fcG5d/fHB2o3Kz3YIbnpw7G7?=
 =?us-ascii?Q?GI0ajRGl6wojpYerhT3L1UjyFy3wj9ftLTcUUovRGJqZtsW/KilTKMu+d0Ki?=
 =?us-ascii?Q?jfC7MHbdcX5AjAJfXDJqKn4Evs6LKkla2+LFiJJsCd7rZ9z877bM/GNSdJtI?=
 =?us-ascii?Q?2RjQ8dWwJMSjUay3b4MSnV7SeNMDHgMS1I/+eT9pj9JTXshPAVLPRojW7eMr?=
 =?us-ascii?Q?ZNfgiS2hq8f7/0dMEvIszNpVrJ14UNu+SFmRz5nxlINSgVIBjESrZS1/YfTv?=
 =?us-ascii?Q?j8VKgw9NPzJsr/MGq2luoZBv+BuLHg3smC3Zfm6lM/pt1nWD3uF9DWWd5URC?=
 =?us-ascii?Q?quj9KTyewh9tQPtCxcKH4ITtCG4W3PmeFohQArme3shMY9W+p4Oea2fDpEto?=
 =?us-ascii?Q?cJDrc9b+yEgzQnGdro1JiqmWMzJfMVx7/9gqLqlM+6dbD9QhFIdK93Z1V5Ox?=
 =?us-ascii?Q?Z08wRLeH4F8WBOytLq/XR06G21ZhIsqKkyebLwKjBjAF5OzFmYdfaapchJrA?=
 =?us-ascii?Q?/0B2rqow6pu5uu9oPxDP6PeD405IfRZ7BKCymyfP2sm3ZURcG/3AITgZVh7e?=
 =?us-ascii?Q?l+4Ua1gsXuki1jXkB5KIGs/TcuzVtjvxmO8/x7TP6bXeLokgQl3pdfcL6FyH?=
 =?us-ascii?Q?OroMk4gi0x40XCjm995Aq606FC2T2cn/buGFHeBnHfzkIGV1pFjMLi2lxec/?=
 =?us-ascii?Q?Ki72AfAHdMBYgVSC4/tw+IQOnJuhMn57X7IXmzmMofXnGFfQnlc9oHAWmqiU?=
 =?us-ascii?Q?b5deRWqNzIDOWQ8stI70g/8bxlOlmSOw4MWHQ/99KkHPyF8NBd8IW7nmm1nw?=
 =?us-ascii?Q?p1t54brHA6c2WUM0hwNmKMnWMB5NsD6tPwUvbOSHXP4uM4Lun17Mp8FtpstU?=
 =?us-ascii?Q?QZBsGAXctmTH5rbJDnbnmP4u+OSMMeST5nII9Ff7s/KLWfgWvlJ0umsmiwE6?=
 =?us-ascii?Q?f5IPdUII/GtK2oWstJA24WXpM7N84EWWUaDM77lKFDYwuzu7KzQLCeN8mVOT?=
 =?us-ascii?Q?W9n7Nu2bIDT33ZSC9fk5i95AcqNjcw+7tLPOmA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0c9bd2-0a61-4f93-6b44-08dc673df7a1
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 04:45:02.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1799

Signed-off-by: Zesen Liu <ftyg@live.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..8a0d7102ce94 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6582,7 +6582,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  *
  *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
- *      paths. For example, see arch/x86/entry_64.S.
+ *      paths. For example, see arch/x86/entry/entry_64.S.
  *
  *      To drive preemption between tasks, the scheduler sets the flag in timer
  *      interrupt handler scheduler_tick().
-- 
2.44.0


