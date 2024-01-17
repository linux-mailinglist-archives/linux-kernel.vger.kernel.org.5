Return-Path: <linux-kernel+bounces-29669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E143831182
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F2D286525
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7655686;
	Thu, 18 Jan 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="kdWvejox"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4B28F5;
	Thu, 18 Jan 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546112; cv=fail; b=Oe7ItzGk7WDfOG49WE0JguNgq6OQwsx5bif9HwQY7mWneGnqLXh45RjH7Dvhrjwcj8Lz/xqoEBqB4Ddn7o4NFE3WWaTL6HCFUfTsX8KNp95SBXCaVZntsXUaCwdytk+e0Z1N0SWA8qLsA34raoxxhV4t1eJ8GkxTc+8xNvxzX9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546112; c=relaxed/simple;
	bh=BCh2q5Tk2/R59h3MSewVzFJoLeEuMsWynLM8dyMpfA8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=EKj2mB110VB8dILqkB2r7ms2r70I3hKoFOMo3lil5OMJ2+dzk7C7S/kdOIAsLR7BX9yO49o6NHAn0992a/cL39eAWoauxh4m/pp80FbOc+AtdAaGMkm/Yk8l+7VHWICWZA7abpfqoKvYjHnYVDV2mGlmCJryb8U2gNIsj3xvuUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=Sony.onmicrosoft.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=kdWvejox; arc=fail smtp.client-ip=40.107.93.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/lckcM5eadIzyqKNZwq6AYt9zG8Hq8IflFYppSk5B93VxIXwNYNUHKt4yU/eHlVYSuEM2r5PB9ZO6VKnRwATEi1vT/e6/6+i7s+LRH3IvlQnRd5bvoAKtCrABU4GeKBnBnzVEMTuR33XTFmfY4eDGD5HAXfeDZsH7xTzeq6pEVBLH/lXHaB+hu946OfUtmzqUvjBO6+q6Tfb0g+aGjE0L4T93Rg9UZsT7ygTxNgdPJ5pKlwRN0N54mjqmXlPxTFnAzZcafgQ2xXTE4DcIZRgc2bEOSjVn0Du+Q8WUHOfOYzNkfDVGuJ0oMVFd0VcwMk+muKF33RcNTI/0dnpbU3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLRaZ2XnB9Rpbe5Pr/xd1PmmB0yRDEZ04eKbHFb+Ibo=;
 b=knTpqcmb1DrjG4aG5y/V3Ue+KSGw1PVm0eU3I4t9KmYpsn94pp3RzQKBZv6fw5eTVOkaJfvrsaJbv16XReV37jWXZyijX3TB1aZLsx5oUCDoKWyq+pvnJHCPzZ+tr6C62/gh6p8jK3uh0euRzb0ffG6DKb28Lr1luqIHN913FcBBAjoAf/BuRhjU5iTP81OnGY7q4AgbcjYXLc7CLLn/jjGbYCS7ONnjWM15IslyeQUGuIdATyoqUQp4ed/tYZAhAv0K3K4yjU3wqTQ+sJp590+UTDecLywrTfk38N0RX+mv6iZdP4ZfTXCV2sffH578fTBjetkvEjkrbR/6K38Fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLRaZ2XnB9Rpbe5Pr/xd1PmmB0yRDEZ04eKbHFb+Ibo=;
 b=kdWvejoxQ/UYiW2n90upSRw2q2FGz7rQV6iMrBdWxr1pZVhujopr6rayCw+AQmoGLMZit7bxucCBdsmXDFJQFmLKaLqLiFADskOyHHaUt7nidhlpUUmdpyNAXD84xmTcsV/apT1LFFnz/XPZfP1v0RNSi3FBn511Y/+lWXrm5FI=
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by PH0PR13MB5066.namprd13.prod.outlook.com (2603:10b6:510:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 02:48:27 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::a9) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 02:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 02:48:26 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HALSob021557;
	Wed, 17 Jan 2024 18:21:28 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HAF2U2007739;
	Wed, 17 Jan 2024 18:15:02 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 1C97120C0303; Wed, 17 Jan 2024 15:43:22 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com, sreenath.vijayan@sony.com
Subject: [PATCH v3 2/2] tty/sysrq: Dump printk ring buffer messages via sysrq
Date: Wed, 17 Jan 2024 15:42:20 +0530
Message-ID: <57daf43c5270f7532b269b9f0e90d126ca012354.1705331453.git.sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705331453.git.sreenath.vijayan@sony.com>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH0PR13MB5066:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab429bc1-451b-4513-6043-08dc17cff244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QS5lCxVMTv2Qw4TKq04lkB3Y35Bv2pflW4RRJG8INVxoXG+AYySkVOqP1mhXKMJpkGyKFJ2MLW27flCzotobFfVjiTZg8h4yM7ADsbPA5Ql2Fu3Gw7/Yf3b6X1cH0mym5XRd5/JYd3mV8VNehPsc4NIwcBiE18UucIH5XnepWJKHKY8mkzN9Q1fuvcg9ptzDJ3+HM7SPRgmIk1oQnNdbUibNkj8oL5J85ymIrTyJlJj5DleQcBs5YUNtp44GLwOUFt5x7JJiS4+DOwOzoxs/jovYrrqEEiJ+nbWk/05NZh8z8Yi3hG72jCyWjaw+lcDtO8SLpfQqcIVZfuozeovIZJiIK4kVNEFUYCHy4XC9dLzpOlTZa1dKIlFyP+kSF+Ba180xL4POF2umLumYeDl7lyks8sV2TSjS6BVPEnUNcjtnSvqkKLv+l6mr9zlcnB6f/1++Jr1FnxQpZ7UXDBRvGbSwTSwnShLR4XTPZp5LzWtbdWqOZnw2CnsSIESReNenlMxz+Jkkvgx9xvexdQfwFp7EYeuXeXrZzns8HyJmWJ6B5yUL2lTBEMytIkX/6WGk2eml4KC1xdQAHcZA/5jRZXJZfmzhy7DrRaxvbQ/DX6vDEt3bVTZVBp7EjzreRD4HpaNykH+jpT6tAXXMaTgDY8B2lLHtroFxCSE+yLjbuQG4tYsM68a8OECQf8poaw5EHGxSy+rTqqo5KO/9agvmu45DmGzGNZ6KqndphHV74AXGGGY5CDjYhJm5g3vlxSY0
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(40470700004)(46966006)(498600001)(70206006)(316002)(450100002)(4326008)(8676002)(8936002)(70586007)(42186006)(35950700001)(44832011)(82960400001)(356005)(41300700001)(47076005)(83170400001)(81166007)(36756003)(82740400003)(15650500001)(5660300002)(2616005)(40460700003)(26005)(40480700001)(107886003)(336012)(426003)(2906002)(6266002)(83380400001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 02:48:26.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab429bc1-451b-4513-6043-08dc17cff244
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5066

When terminal is unresponsive, one cannot use dmesg to view printk
ring buffer messages. Also, syslog services may be disabled,
to check the messages after a reboot, especially on embedded systems.
In this scenario, dump the printk ring buffer messages via sysrq
by pressing sysrq+D.

Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 Documentation/admin-guide/sysrq.rst |  2 ++
 drivers/tty/sysrq.c                 | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 51906e47327b..246a7b61a0eb 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -152,6 +152,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``D``	    Dump the printk ring buffer
 =========== ===================================================================
 
 Okay, so what can I use them for?
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6b4a28bcf2f5..1976412706a4 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -450,6 +450,24 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void dmesg_dump_callback(struct work_struct *work)
+{
+	dump_printk_buffer();
+}
+
+static DECLARE_WORK(sysrq_dmesg_work, dmesg_dump_callback);
+
+static void sysrq_handle_dmesg_dump(u8 key)
+{
+	queue_work(system_unbound_wq, &sysrq_dmesg_work);
+}
+static struct sysrq_key_op sysrq_dmesg_dump_op = {
+	.handler        = sysrq_handle_dmesg_dump,
+	.help_msg       = "dump-dmesg(D)",
+	.action_msg     = "Dump dmesg",
+	.enable_mask    = SYSRQ_ENABLE_DUMP,
+};
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
@@ -505,7 +523,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* A */
 	NULL,				/* B */
 	NULL,				/* C */
-	NULL,				/* D */
+	&sysrq_dmesg_dump_op,		/* D */
 	NULL,				/* E */
 	NULL,				/* F */
 	NULL,				/* G */
-- 
2.43.0


