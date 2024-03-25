Return-Path: <linux-kernel+bounces-117843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208588B14C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38A9BA5A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B143E468;
	Mon, 25 Mar 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxCTXOh8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850263399F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395779; cv=none; b=hM8Qq3Ig/xo+L1y4iYy7MYq4aN8LACUrVExQ40lHukuCg8YFB2waJhBFxbIfo0QQ6QzXsRhOLCPggg0VDNpuh97sDG5/nbRcTeejc3PzN42kOcGa4/zhwOHw+45lCJOweFwby7nuvXXXE7ZnjfcRJDOBZsFC8p8w7+XWkTNii6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395779; c=relaxed/simple;
	bh=clBK7WyFrTer33UcCZksOAeIE0Ht+WdYbjn6omkCaZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIRoGLEgjPfYPsnPLi5icXcuNGdFI/sm/LMILMWvKGHBBiFiB0Wb+NS05Ko5ZbjGBCEp5qvP1pMUW9h4NaCcVq3Xv17N0JmwWV9JI9AQmxKmPSGgIQOEcq9SZRKayUNtZ7U9IjKswiocXuj52ruJtJA+x+9w7JdsPj/j/V4Ogs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxCTXOh8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3228228a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711395777; x=1712000577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GNuMW47+QhhyncApcMkdyIFe1uqQGtbO15QL9ZbpIE=;
        b=cxCTXOh82apf606ipnrgCYiquC9a7mNgKBWRNUx637KKKI8w21qOZFGexP+ubSjdSJ
         8XQ+6Q9b91M2kT6h6PV2f5lM7qTfGWM8lP2ea1pwyFI0lg6H42/9DULDUdpf2nY87f6/
         mASO6J8o1dCxSI24fyEMnFxxJ5k9Wq6TvOS+BnKWsbzpj7JmPBwScybV2jhtU5f85xDZ
         Bxj91SyLP462aggxtjCMp2YM/llVUzY/izKzl58BkMZIhc+CJrTEHv+v7eZthZu1evMp
         fs2bkyB2eXkaf8bWiIgfYB8jN7aEBIYezCY7KFEmn09LLvu3IZXSb1j7U9ghlgvJLmpR
         3guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395777; x=1712000577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GNuMW47+QhhyncApcMkdyIFe1uqQGtbO15QL9ZbpIE=;
        b=Eo9EDf6adtNsuwBBttcZfI5bDuB9WvF0UeP7tgfcbZuw042Pe3MlqSP7dOPn2zidTp
         9cVNowKHO/TFMwY4LV+0o8bpC2PYGLsdi5LB2Le57L2jglPujgscD7OVBOXsBwXgitHz
         WjKA9gqDfTm48qFgkl/SQUzyhQu368T4hlHNrWa0DLIOP31LnzwXqLNfBNNAEUx3Dchk
         n2YjY4HMyEfi6slkBnoRgJej73UsjgC3cbyfhY2BA+sb90kfdDENfsHqSIMvglYN5T22
         yDExT83xrmBw7bZaFv73whqxz2Nm4shCwXakrFL37V7WIlFS1VNSR06kCId3gj8UL4kf
         iIEg==
X-Forwarded-Encrypted: i=1; AJvYcCXscZHjxmxjnaCELw0TAgrqnMbt2oTdcWRL5+HXkW2FHr0SMqQt4W1AuIAFNFarL/MJMLOt9vKGTpyiZjbux7Y5c+61x1/WkF06Xq99
X-Gm-Message-State: AOJu0YxgVEpBK1erBzoOD1CLuqcqYqK3OksysQ005iTrEhRYl++v7fDC
	VFlPB7xRsKZeO2zQ8iCjACVf4dzLvsdhF1YYCaAZt/ZYuYh8xw0Y
X-Google-Smtp-Source: AGHT+IGkI4tSgVn02uvMhd2KQNOdBj6qxyLhLLwWYxO6BM36ivtP6lrVG2lIDV8L+3zcaXhWHsaRvA==
X-Received: by 2002:a17:902:d542:b0:1dc:ce6e:bf06 with SMTP id z2-20020a170902d54200b001dcce6ebf06mr11844953plf.0.1711395776757;
        Mon, 25 Mar 2024 12:42:56 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902bb8c00b001e0449adfaesm5057733pls.191.2024.03.25.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:42:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 09:42:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: Introduce enable_and_queue_work() convenience
 function
Message-ID: <ZgHTvwIerkcRem2s@slm.duckdns.org>
References: <20240325180201.6027-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325180201.6027-1-apais@linux.microsoft.com>

Hello,

The function comment felt a bit too verbose. I applied the following
compacted version to wq/for-6.10 which hopefully still contains all the
necessary information. Please let me know if you disagree.

Thanks.

--- 8< ----
From 474a549ff4c989427a14fdab851e562c8a63fe24 Mon Sep 17 00:00:00 2001
From: Allen Pais <apais@linux.microsoft.com>
Date: Mon, 25 Mar 2024 18:02:01 +0000
Subject: [PATCH] workqueue: Introduce enable_and_queue_work() convenience
 function

The enable_and_queue_work() function is introduced to streamline
the process of enabling and queuing a work item on a specific
workqueue. This function combines the functionalities of
enable_work() and queue_work() in a single call, providing a
concise and convenient API for enabling and queuing work items.

The function accepts a target workqueue and a work item as parameters.
It first attempts to enable the work item using enable_work(). A successful
enable operation means that the work item was previously disabled
and is now marked as eligible for execution. If the enable operation
is successful, the work item is then queued on the specified workqueue
using queue_work(). The function returns true if the work item was
successfully enabled and queued, and false otherwise.

Note: This function may lead to unnecessary spurious wake-ups in cases
where the work item is expected to be dormant but enable/disable are called
frequently. Spurious wake-ups refer to the condition where worker threads
are woken up without actual work to be done. Callers should be aware of
this behavior and may need to employ additional synchronization mechanisms
to avoid these overheads if such wake-ups are not desired.

This addition aims to enhance code readability and maintainability by
providing a unified interface for the common use case of enabling and
queuing work items on a workqueue.

tj: Made the function comment more compact.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index bfcf8d38f4b1..2df1188c0f96 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -682,6 +682,32 @@ static inline bool schedule_work(struct work_struct *work)
 	return queue_work(system_wq, work);
 }
 
+/**
+ * enable_and_queue_work - Enable and queue a work item on a specific workqueue
+ * @wq: The target workqueue
+ * @work: The work item to be enabled and queued
+ *
+ * This function combines the operations of enable_work() and queue_work(),
+ * providing a convenient way to enable and queue a work item in a single call.
+ * It invokes enable_work() on @work and then queues it if the disable depth
+ * reached 0. Returns %true if the disable depth reached 0 and @work is queued,
+ * and %false otherwise.
+ *
+ * Note that @work is always queued when disable depth reaches zero. If the
+ * desired behavior is queueing only if certain events took place while @work is
+ * disabled, the user should implement the necessary state tracking and perform
+ * explicit conditional queueing after enable_work().
+ */
+static inline bool enable_and_queue_work(struct workqueue_struct *wq,
+					 struct work_struct *work)
+{
+	if (enable_work(work)) {
+		queue_work(wq, work);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Detect attempt to flush system-wide workqueues at compile time when possible.
  * Warn attempt to flush system-wide workqueues at runtime.
-- 
2.44.0


