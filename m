Return-Path: <linux-kernel+bounces-116466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212D889F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D701F38022
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941DE56B7C;
	Mon, 25 Mar 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5TZ02pZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F06136E1F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338709; cv=none; b=CeSyhc/BI0/sZclBJ8O8BI6XxcfIhmOPxRlYEgE5vSMEGG4tnk+ds93uXDH/AS82Sjjguv/i8q1N+AuNBfsJzj1tFMn2Q1ak2FiVqHba6QsZLsa7REwz3tIL8wgclIp48lwjNqRVLvIYcIeMYPxJVG2kV8E3THGTCk68LTJ/Pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338709; c=relaxed/simple;
	bh=9H1bFwVATYVu3oBpZ6NXxCZmHIP0732OtVnBw7mBqQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o1tuEMuenlZS/CWGUtSx0f3t2JCRuiHccDmOuSi2bKBHwxQO/H59MU7UhMIYIN2zc0oTYpAl7U7If01n9o7FCIQf6Q9GbVlQb0CfnS6hIkwM7agGsWdLUfs0mAXSxb+oF6cb1hZKVbbvdMZO5gkZZUUUiTADNE9MK/ylAm02qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5TZ02pZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d717269fso4864313e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711338706; x=1711943506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S181V4s58CW/eDQDzX/YaeoQbmnp0MLg4S2VCDvsY38=;
        b=c5TZ02pZkJ/yppQKtBwWQAcbVRSsJE0z0pEAENouMyo+qks7puiBQlKVIj5Lztqlpj
         PD2oE7BbGQg5KsAgwzHrmjsbahAdxOF3fIrJw8GTU74U9Gi+B+YfVMgWj6b1Hp96xozh
         S/sYtSKy3SFQN/eS75FaxqDYiU1VpNSZf4kDrDWKNQpbkLMDkcqkuncfh59ylree3zOv
         GEmqQmHtptDuoTR0XnMdrrBmazCrH2JvD+vDn3fQtXewrGWNG/UQZ++da6+ubq56nfcT
         utHYqJr2AvPdyN8Acbl3XdgQxrE/8V1zxZ9sznQ2ykfuyQA1v+7YVj9ofMWRgNVjWmMY
         xs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711338706; x=1711943506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S181V4s58CW/eDQDzX/YaeoQbmnp0MLg4S2VCDvsY38=;
        b=T7JngU87tOFJPfA3CLHj6zlPbBGrW1fzWHXUJbHDz/iqxtWBzfAHpIe9L3V60c2tRz
         O/CzAA/La/RIsjxpG1u7X0ICgR/jzku3dXPb5c0KHvkxtlM1VLdvMaRCu7RUZQdQIzKN
         EdA0t9uTZhgALSdkmnWY+YeMAqVcW9ZUp8uLCxOyuWfRPi5tHnpIOX3En2uXK5G8GyDf
         quIR6wKDWNAv4TtrpOlIJyIDp19xOBzJu39K/ubcBL1mDdoSvtkc2R6X1cGGMa8Mz9QJ
         +5T8THzlX+ZdJ8sbW8RTbmz5VygfMBAbe4tiAxaFJKnrsMbYYl8XYT67x6WeWHgr7jZN
         qmkA==
X-Gm-Message-State: AOJu0YxPqRd+DbKER2mW1KbhrJWTycemIQ2EMMHf9eXhBeLKpKSh/u8D
	6O7AK4vGPpfIJXtTxO9UhlUyA5PHuaIAtltp+46BjiEV8nAVQsWO
X-Google-Smtp-Source: AGHT+IESS7QcDu+Ad7VMvz5g/QSXCJTjw22ug66Sy794r0vn9i2cWSBzzu5jPESFGODc7vNWERvJMw==
X-Received: by 2002:a05:6512:138c:b0:515:ab7d:6c2f with SMTP id fc12-20020a056512138c00b00515ab7d6c2fmr1590135lfb.17.1711338705343;
        Sun, 24 Mar 2024 20:51:45 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-164-229.dynamic-ip.hinet.net. [220.143.164.229])
        by smtp.gmail.com with ESMTPSA id dj16-20020a05640231b000b00568d7b0a21csm2513941edb.61.2024.03.24.20.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:51:45 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] genirq/proc: Try to jump over the unallocated irq hole whenever possible
Date: Mon, 25 Mar 2024 11:51:02 +0800
Message-Id: <20240325035102.15245-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

Current approach blindly iterates the irq number until the number is
greater than 'nr_irqs', and checks if each irq is allocated.

Here is an example:
  * 2-socket server with 488 cores (HT-enabled).
  * The last allocated irq is 508. [1]
  * nr_irqs = 8360. The following is from dmesg.
     NR_IRQS: 524544, nr_irqs: 8360, preallocated irqs: 16

  7852 iterations (8360 - 509 + 1) are not necessary. And, there
  are some irq unallocated holes from irq 0-508. [1]

The solution is to try jumping over the unallocated irq hole when an
unallocated irq is detected.

Test Result
-----------
* The following ftrace log makes sure that this patch jumps over the
  unallocated irq hole (less seq_read_iter() works).

  ** ftrace w/ patch:
            |  seq_read_iter() {
	+---2230 lines: 0.791 us    |    mutex_lock();------------
            |  seq_read_iter() {
0.621 us    |    mutex_lock();
0.391 us    |    int_seq_start();
0.411 us    |    int_seq_stop();
0.391 us    |    mutex_unlock();
3.916 us    |  }


  ** ftrace wo/ patch:
             |  seq_read_iter() {
+--17955 lines: 0.722 us    |    mutex_lock();------------
             |  seq_read_iter() {
 0.621 us    |    mutex_lock();
 0.400 us    |    int_seq_start();
 0.380 us    |    int_seq_stop();
 0.381 us    |    mutex_unlock();
 3.946 us    |  }

* The following result is the average execution time of five-time
  measurements about seq_read_iter().

   no patch (us)     patched (us)     saved
   -------------     ------------    -------
          158552           148094       6.6%

[1] https://gist.github.com/AdrianHuang/6c60b8053b2b3ecf6da56dec7a0eae70

Tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 kernel/irq/proc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..756bdc1fd07b 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -485,7 +485,14 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	rcu_read_lock();
 	desc = irq_to_desc(i);
-	if (!desc || irq_settings_is_hidden(desc))
+	if (!desc) {
+		/* Try to jump over the unallocated irq hole. */
+		*(int *) v = irq_get_next_irq(i + 1) - 1;
+
+		goto outsparse;
+	}
+
+	if (irq_settings_is_hidden(desc))
 		goto outsparse;
 
 	if (desc->kstat_irqs) {
-- 
2.25.1


