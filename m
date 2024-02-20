Return-Path: <linux-kernel+bounces-72358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0D85B268
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B4F1F226DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DE458200;
	Tue, 20 Feb 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mJ5GA+eF"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7556B9F;
	Tue, 20 Feb 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407935; cv=none; b=p31RYLJZvFyEiLlfd8sZyKcsR+DBTEkO+PKVqZish/qXPNdrNoPcoGh+yPjzYrvFiPtigMcfvNT0KOmQ1jF0opQNijOlF9Re/YdJeiX5INPjLumz0nh3W8OoxWpyY0ojCOjjc4tF9CJRaqs3Tz9SVEDG9ddN08wAKlDQF1X6xD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407935; c=relaxed/simple;
	bh=eobAWH/CQ74AbdBposfF5jZqxo/Sl7vEIa1ZDCK8rNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyMVNfDXPHbNePhMPu1GFbCboZD1r9a5ib0Vpb3IwQ01pCNI3vTV/XadlB6HAPZ7K8Y6oqixLE2XDFKDJbRHLZEJTRRfde03vVrqMS60FJXz5VJKQOUk3ByJFxXSrGgSxNN1e9kY4EIbLYBhzzENdMsang3W0AMGfHTSRqDmpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mJ5GA+eF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708407924; x=1709012724; i=w_armin@gmx.de;
	bh=eobAWH/CQ74AbdBposfF5jZqxo/Sl7vEIa1ZDCK8rNs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=mJ5GA+eF/fBfSmgGh86TH5ksk1Z8QTD3RXe+4w7OBQDUAxtTlHuk6/cYhkNQgXYW
	 6QDhUOAT3uz735VMktpWMiPpGQyQZeIaAvu8ummMh0FpW81xxsQ+TKeagq/TFcX3Z
	 pIBcDKq/78AFxwqtkTSECjUpzqq2ILa817bM+5AAVh4GXTBwnp3N1ckoPTjn5zi3b
	 QAdgff7W/+3ytQqQXl8mJFzN2cR1PaBAXu4pJRqsQMeBe1kDqqyAj+jbC2qUOCQXf
	 sirIrnuH+J3JOkps5xU+kMmr3Da21sVCEWxaMrcU+lnRVQ1C2XlvH+MqulPBMz6UB
	 +GLWVX5YrHYkSbApSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgNh7-1r0k8K3i07-00hufC; Tue, 20 Feb 2024 06:45:24 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com,
	mika.westerberg@linux.intel.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: intel_scu_ipcutil: Make scu static
Date: Tue, 20 Feb 2024 06:45:13 +0100
Message-Id: <20240220054513.2832-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220054513.2832-1-W_Armin@gmx.de>
References: <20240220054513.2832-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FwrNV4oltVweFu4+1d1wzAEeqcmQk3qU4JgmxxNMCO1FmdRCMJH
 r09Jvi1qYGSmYgjMZLI+LFflr7cdKwr6vWJj+eH/KL3XRxGsS/0F4X2Yy0Gxp3frwKdoUNz
 KHpwI8yCydJrLP0workv4liQEphTqGvTBi9T3suF9G+PJu+B31zsWTgNUPFI8N/6soKU0jE
 cqMQXrQssdM4iY3OMpl0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bPiltYbMaEg=;lauq3K32ajcbpBIZwGnp6fPdrV7
 wtjwCCLm9ahVxJu++i8v7yF2PiJ/pmLfI43WM8JGkXVHvw5Z8GyT0MEZHU4Vxb7a3g0IKq53o
 JSi+sR68UqYqqTuFNnWLSYsBDcoUSBnO50GLz1SvFZEi4OjpyJ/bMwkkktZR38XObI3se18V9
 7PFu6GDkH1yphdput7n/gNVOtg7Xf/4UtVFVul3dlRUt+R1OvGrnCAlWjHCB/nKTzhsBl78lW
 D7v53XLf/2iXzBAxzi7aJst2BPCC4xd7/l//ruocgU+S8lPAf9euELTsjYMOdLjtde8WU8ZBd
 BUT56sQKa0gzBNeQPT9QZPohJQ5DZODdHlqJa0AyuNTTzPXJFvkgU+VQGxjOwrozUWWco/nt6
 WUlV3FN2HNkmNzGjedxOAf5SiLdwTrUgDuPrmCKhYSLn8g3hp3b6CsWMLogwTajR44DB4AmDP
 Zb0dACgA4XbKp3ON0qsw7ytFtNuZbXSo1hNc7CUGwENHjwBDKuBCshxDMg/S9+jCjjhc9jMwJ
 vLmWmdwTRVgGIttfQ7x2WCtPJCo9o5JUSQSB8hMJXZSpE4K8LRPIHdxmY+9zJsm6jDvDMtIf9
 YvOEnL6VQc6v6HlxR9EY0DOIUk7uKSPbUD46hVBmgqrL3Wgh0TzX6OHU9GXebyxuDiXldr/qV
 gVF6YOAPToqkWEtkJU6BJ0RDdIi6PjDUoaUuwQuSifX4wi5QMEvcSVk6/O1IojP3HvR4op6XM
 i5lB32vx/mq3EWU1r9p373mKUywRZqxOPLCt+zwuSOfYWxoH5nYkuyyWSD9VcvaNBGqB1SHPM
 hlB+mDhLWtfF1hP42/fsEQ1y5Csbr9N5ggdMH/onN+ccU=

The variable is only used internally and has no external users,
so it should me made static.

Compile-tested only.

Fixes: 663cc18861a0 ("platform/x86: intel_scu_ipcutil: Convert to use new =
SCU IPC API")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/intel_scu_ipcutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x=
86/intel_scu_ipcutil.c
index b7c10c15a3d6..7d87cbd4b9c6 100644
=2D-- a/drivers/platform/x86/intel_scu_ipcutil.c
+++ b/drivers/platform/x86/intel_scu_ipcutil.c
@@ -22,7 +22,7 @@

 static int major;

-struct intel_scu_ipc_dev *scu;
+static struct intel_scu_ipc_dev *scu;
 static DEFINE_MUTEX(scu_lock);

 /* IOCTL commands */
=2D-
2.39.2


