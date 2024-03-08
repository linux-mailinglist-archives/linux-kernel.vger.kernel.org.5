Return-Path: <linux-kernel+bounces-96759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA4876112
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE633B22F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2037535CA;
	Fri,  8 Mar 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr9jUqfb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83409535BA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890845; cv=none; b=qv0aIWUzwkrBqVRBSbZ+Za7EyYWo+AnxLNin+5Wx8SJI1L29cJwrhdMNSt+c4lsq07iAG0Vl/uDZ4NNFGGHCopQZ3aHY9pH20bTqK2vOVMFC+V/9JxuAIn/n5Bpz8XdyeB8Mtwo7KaGmnu255LGVKMw9tkdaq8E4WToqfU41haY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890845; c=relaxed/simple;
	bh=+fEt8hcgY3yOz83r2AVEQybAL9hXUGeZf4MjldUvW+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTmXT3QVwXWJoRZIi66Dxdp4eCrBJhrKyA2R5mjje2BAhwY2CjAdR6p4S2tUUUX0WQrv1K8m3REFndE7VX9+H2x5jKwH/y1BcDahUYMz8alo+suRKIm8qEkbDRD3Wnhaj4s17GjPRFalUxuuTDErCVC2DLpWkrxF+h6EIloHd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr9jUqfb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd3bdb6e9eso13129045ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890842; x=1710495642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhsbBO/MKoPq3ThrOL/rSkQzCoO2b8EXw4tUZ9iUAk4=;
        b=lr9jUqfb8DtQ5Wv7/8pRfQE3nRhKOjsju98VEIDTsSF88LnVqr7L+XdK8gS8TSf7NW
         EX8g4BYmyADX7Pvz/vgIr8JfOa37melqAJvZSWx8fKL81oG+WFM+cPyIupFU1qXh++LK
         wO8EDAIKBKDPrPgxkqv709Bynm93G6tmajfgcItRpLkSETj676rDMVXsl9nUkmbnavrm
         inkCIJSGCrCa4pHPVVjSr1bqBYEXVWp6apDcFRrtaiyE6qbZbaCQyK3QXfcF9a/0UVlt
         QwjrjlvDtVLoUyax4dmzXYJo/0DxpuQukouQ+5cgrVmAChkhyKz8KCZtD35KeNY0j84B
         nyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890842; x=1710495642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhsbBO/MKoPq3ThrOL/rSkQzCoO2b8EXw4tUZ9iUAk4=;
        b=XFrSURM9kGAp7cN8W9Feudpw2u+Yl4P6Z6O6z42cmILgM31G+u8JaU8Ju5jPbp2TTa
         tYKbiSb4X96GLzf36pNYUIXHbbceJBokzcf/LTLgf8gmO1sThf1zkWmWWmlbWId5vLuq
         9raSD7uUz7XJoy3G/9eV+QTzHCi6ELVFH2bC7FS+W7uVD4OMmVQFN+3J0xZBXhbFGdeO
         O7Kd/1DV4/35aK2zXske0PNim0O/WpYhW759FnDHH619IVi9RqtpMFRQQynWmtUhnsHQ
         rDeScg5Ewq7sRHt7r/vXbhQglhtLC8ChOOkVE1N9tXHcmpVFvD9SPy5p44oLjX/hAU8e
         ut+w==
X-Gm-Message-State: AOJu0YwQk79u43q/fKCG2GtQmoXVHE6FI/H5m/UfwnhQp/8ngx3AxyDV
	AbvlhD6gHoIk5VZp2VKl2TqAJ0bMKJGdqI0OtLJoBMdMV7ZFyDAOW2rn9Eae
X-Google-Smtp-Source: AGHT+IGV2wCyCnyM1hzYm7D9aigr6c53zg3+E1uYF6nNumFDZ328Hlu0BFoBR410Gwte46cHR6YJ8Q==
X-Received: by 2002:a17:903:428b:b0:1db:f7f6:a73a with SMTP id ju11-20020a170903428b00b001dbf7f6a73amr9511468plb.25.1709890842371;
        Fri, 08 Mar 2024 01:40:42 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902b68d00b001dd6958833esm791446pls.242.2024.03.08.01.40.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:40:41 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/4] workqueue: Reorder the fields in struct workqueue_attrs
Date: Fri,  8 Mar 2024 17:42:51 +0800
Message-Id: <20240308094253.2104-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240308094253.2104-1-jiangshanlai@gmail.com>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

So that its size is reduced from 40 to 32 in 64bit kernel, and it can be
saved more when allocated with kmalloc() in alloc_workqueue_attrs().

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/workqueue.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..c885a5f6bb93 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -145,13 +145,15 @@ struct workqueue_attrs {
 	int nice;
 
 	/**
-	 * @cpumask: allowed CPUs
+	 * @affn_strict: affinity scope is strict
 	 *
-	 * Work items in this workqueue are affine to these CPUs and not allowed
-	 * to execute on other CPUs. A pool serving a workqueue must have the
-	 * same @cpumask.
+	 * If clear, workqueue will make a best-effort attempt at starting the
+	 * worker inside @__pod_cpumask but the scheduler is free to migrate it
+	 * outside.
+	 *
+	 * If set, workers are only allowed to run inside @__pod_cpumask.
 	 */
-	cpumask_var_t cpumask;
+	bool affn_strict;
 
 	/**
 	 * @__pod_cpumask: internal attribute used to create per-pod pools
@@ -166,15 +168,13 @@ struct workqueue_attrs {
 	cpumask_var_t __pod_cpumask;
 
 	/**
-	 * @affn_strict: affinity scope is strict
-	 *
-	 * If clear, workqueue will make a best-effort attempt at starting the
-	 * worker inside @__pod_cpumask but the scheduler is free to migrate it
-	 * outside.
+	 * @cpumask: allowed CPUs
 	 *
-	 * If set, workers are only allowed to run inside @__pod_cpumask.
+	 * Work items in this workqueue are affine to these CPUs and not allowed
+	 * to execute on other CPUs. A pool serving a workqueue must have the
+	 * same @cpumask.
 	 */
-	bool affn_strict;
+	cpumask_var_t cpumask;
 
 	/*
 	 * Below fields aren't properties of a worker_pool. They only modify how
-- 
2.19.1.6.gb485710b


