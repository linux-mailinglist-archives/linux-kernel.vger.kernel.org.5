Return-Path: <linux-kernel+bounces-118135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA888B461
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88B11C3F0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC57F48F;
	Mon, 25 Mar 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmg79TTJ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015627640A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406508; cv=none; b=bc4WAU7UqOZVRxZhs4QL8GmaB8Gan4ocnkn7h83YX0dkZmo6o8Mfo2dEHAZnzwv9qqxvKrBEMQABxtjhaAGoHJ5cx9wYLf4jxB+GkVaz/4bzQcroWbcOBPlP1P0ebkZjHPfQq3gUev//jJmdIzOtDxoUnk5GeBGO+os9tsyddws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406508; c=relaxed/simple;
	bh=bi/Pa9rLIzlNbabzqsTfFqi4NUT70ZarCDP0zU8PLhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMqzJLmnH293XGaTZ68Xto1R/ZGRLxvwGumBTpu4NnB41to9BNJdmykNOj4hhOEPIaBHpIRr/YRK9lNzuaa6r30Kq7irjDLF107WEdzWHp+fGUe9GtKufwiqg0cbqGg4W1yCKtB7ED1hNUU/BuKZGfjlZeX0S2c1a3zyj2CZfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmg79TTJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0ae065d24so15718765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406505; x=1712011305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dbRRrnKX05Y5juIbion79E9tHH3iiJC0OmBLltVqrLE=;
        b=bmg79TTJMzWQrxJD+JurLN8vi6WgcHNmCXC63qDlPIu4BHn4OKFRlKJFsis51K4oX9
         KcNm7tWUxr8FM3s16tFjqPHFmWiVyvyZrVGTeaabASAWeAU0tFAoMha5P/uQCC1GRgf1
         s74ECX7mSGt52HZfeexeTWFwgsPCziKe91/W4otvKeCZp8vB61psAxGDWwJpEeXoWcs2
         yoDjMsAqymc+amyWLhJUiD7cTE8Ac+awRZVY86S3PDHx3qXCjVxu8nT6qpttnpiUL0L8
         qiQBUFIxRmBzCZqijvfFygMK/UeQkuypJ3nxXIa4z0VQF+kwkAWFggPgN6KiDMLxn47j
         XCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406505; x=1712011305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbRRrnKX05Y5juIbion79E9tHH3iiJC0OmBLltVqrLE=;
        b=nBauHBLRp+Oo3GVnyJo+cLDCZxRjkuP7qhTmg68LY5RA63lqGY/+iNcgFZKjB5I1XE
         ByinOug7caMeRWRuiHD3EtQLOm2keheq4cXMgb34B7RaKqyCviF+xsw5Y7yeXd5lPX/t
         Mv6YCsSp9sYhsxsGkj82bLAsdz7iXfuwIa9/9/BiRjjgLrg71j6Mf6fKXNxSzlOScfpX
         gABIejXRN0qQZ0N9BQsvs8P1ddCpOvbY6LRNEVCKlakDOVSSlRmvFITVpPlSRKOASJK3
         GyWdMFj4JM0sN/qvYdIv6jbh//7+Exq3Q865olCbV5jcaUzNJBdQxtmqTOF5vzcbFRMr
         aA/g==
X-Gm-Message-State: AOJu0YzIDkdw16xlZ1sxagBY3i6iqUDK6hAvAsacBrdFL694oQQWm0C1
	8q6l4xDIBls2ZQXZ7q1KTYXrJz1pEmPXT5xaGln2NMac+loaDW3x
X-Google-Smtp-Source: AGHT+IHIZF1DnUcWmwaFZN9tekowDzjvAbZvAZ9qPPMn8K6rB+J3i4PqU5su0fKXKTirTqrOwf2zNQ==
X-Received: by 2002:a17:902:b196:b0:1e0:2335:8f77 with SMTP id s22-20020a170902b19600b001e023358f77mr6971362plr.54.1711406505216;
        Mon, 25 Mar 2024 15:41:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b001e014627baasm3273321plf.79.2024.03.25.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:41:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] nios2: Call handle_mm_fault() with interrupts enabled
Date: Mon, 25 Mar 2024 15:41:40 -0700
Message-Id: <20240325224140.1911036-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following log message is reported at each boot if
CONFIG_DEBUG_ATOMIC_SLEEP is enabled.

BUG: sleeping function called from invalid context at mm/rmap.c:194
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 23, name: modprobe
preempt_count: 0, expected: 0
CPU: 0 PID: 23 Comm: modprobe Not tainted 6.9.0-rc1-00033-g5afc2860dc51 #1

Fix by enabling local interrupts while calling handle_mm_fault().

Note: I don't really know what I am doing here.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I don't really know what I am doing here, so this is just a wild shot.
It _does_ fix the backtrace, and I have not seen any problems, but that is
just with basic qemu testing.

 arch/nios2/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index e3fa9c15181d..b468d5ca78a1 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -121,7 +121,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
+	local_irq_enable();
 	fault = handle_mm_fault(vma, address, flags, regs);
+	local_irq_disable();
 
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
-- 
2.39.2


