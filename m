Return-Path: <linux-kernel+bounces-54165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2984ABBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D72281765
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8874C6B;
	Tue,  6 Feb 2024 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRN59ApT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E704A11
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183824; cv=none; b=pB4NOiZn5OVlY88BP+AXJzYDFZc580S1SUVn/0BaU92wO1bl4agLU1YaOaCpt03yLVJj7Bm1lc0K1neD4AHguuPunY6r5s5BZNx+tMuRjmmWjeKj0Zj06zYO4eUO6XWxYwoO+OD4KWXmlyfUFScsEyZ4zOIQ/OrMCFedecRbB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183824; c=relaxed/simple;
	bh=mEUrVZLLkIvLQcQ0A9uCjOXEXqckE3NAFl3/ZipwLQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eikVj1jUtYenDqCUE7vxHhQAndis9CbVUEeU4lT2apGPmRoA4G+jycV8rfJNt0aAXmyux7N7njGFczX0daNCJFv7zkn+lBbEddnGEdl7R9C1dkggTEWhoYhmLmwA1ykHHvQuQmK/X0oJrC5MKX/yxJzPtZsB0IDS7DRupGEQOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRN59ApT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7354ba334so44502415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707183823; x=1707788623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDonYuwOqhudA4UO68AGfMmX1G75eqQFxO+eIAJElag=;
        b=HRN59ApTz+21QsW8S6O5LlnR8sZedDuptIjLmI6IVqTKptnM8q8NsIu0xDeb+QvlBc
         i9d4hUS6fZ1lf2Rf1BkfAwKlQX5nPhofJIGYnB9lh2hfLqtBcJWDFw1OcFVEMP3faq2O
         gitxQ9lXMMr4iT2hheessWiEdIplFMIVHOAmoEnaB2PwhBzDMxa1PkOM85YmqFgkVppp
         IPK/kQQN0BVRYHAyuPgwLvDgVWADFNx3lOngB7HAtQ0bPliA7Ril/UAz+dlBpaz+mzEQ
         Ec0mBQCLlPJPMXtX8ZkW/wEV6kv6h7HZcCYJvMzHamcWixNUON5wShy5Z+ZUpgQrQWVw
         WVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183823; x=1707788623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDonYuwOqhudA4UO68AGfMmX1G75eqQFxO+eIAJElag=;
        b=YUkOkRTg6Z9QThQKYYuhXknGEJI9xvM6gffksHvOdaSASMCFmzmpaf70E9HrmTSJki
         bg149qIPSlCJx8oQITBIkNgBbTSKshihCDEx5Y/DXrRHF4pgZZ6+bJ7HfXdbJRG/NLq9
         vvT99jnFG7UWXKLQn3e+0P+qFdJYQT+Klp44urBdw5X6Y8SH5f7GPc6kQNkiW+KSrZO/
         kQ33zJf0lJ2LGHpQdjDIZH8kEsRtct2KefAQGMfAZq4qvrMwZHNbnxBLVk2ZVQ1+CZl/
         dxWbGAVk62G6Y+Z8ZJF5Pk5k2UcZGMvleq6JVvQ5sgwIm+MFuUt4/z0WVFgpGqdQnBwi
         5QAQ==
X-Gm-Message-State: AOJu0YwKMdSVz2gzyxZWhUTS8nVQ+OWBeqjVHKhCpbMHJP3/IlV8Qbvd
	RSOJHE2ZHH5IFw17jvg7xtpXVMTW/s/uS9vRiwV2gid6g7wJLyEw
X-Google-Smtp-Source: AGHT+IGUltm4mRKXSQ5UrQ/PE3NtoFt9Fn1sTLlLGQoiBYZQwlb9D9qXjvWVoSHlLz5oiDVO1FvILg==
X-Received: by 2002:a17:902:d2c2:b0:1d9:d300:a69d with SMTP id n2-20020a170902d2c200b001d9d300a69dmr308120plc.11.1707183822561;
        Mon, 05 Feb 2024 17:43:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUdUDnG17xIBaVyPZZhj8IrgOlXo+Fsf1IJWb56JSZyAlkVJ95hvNMNM5in9JxvCUZ1+LKPunbe2eYEtmCBVSxmAk6nV44zaMwoce1a5oDrjXdppMTwM0Cyc7Nb8+6sNsJgPx6dtnt3CBAKBogbctU=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001d71729ec9csm541543pld.188.2024.02.05.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 17:43:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 15:43:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] Revert "workqueue: Override implicit ordered attribute in
 workqueue_apply_unbound_cpumask()"
Message-ID: <ZcGOzSeoLGSJvqMQ@slm.duckdns.org>
References: <ZcF65MlIYdKqukzK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcF65MlIYdKqukzK@slm.duckdns.org>

This reverts commit ca10d851b9ad0338c19e8e3089e24d565ebfffd7.

The commit allowed workqueue_apply_unbound_cpumask() to clear __WQ_ORDERED
on now removed implicitly ordered workqueues. This was incorrect in that
system-wide config change shouldn't break ordering properties of all
workqueues. The reason why apply_workqueue_attrs() path was allowed to do so
was because it was targeting the specific workqueue - either the workqueue
had WQ_SYSFS set or the workqueue user specifically tried to change
max_active, both of which indicate that the workqueue doesn't need to be
ordered.

The implicitly ordered workqueue promotion was removed by the previous
commit 3bc1e711c26b ("workqueue: Don't implicitly make UNBOUND workqueues w/
@max_active==1 ordered"). However, it didn't update this path and broke
build. Let's revert the commit which was incorrect in the first place which
also fixes build.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 3bc1e711c26b ("workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1 ordered")
Cc: stable@vger.kernel.org # v6.6+
---
Applied to wq/for-6.9.

Thanks.

 kernel/workqueue.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ecc775843bfa..cf514ba0dfc3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6489,13 +6489,9 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
-
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (!list_empty(&wq->pwqs)) {
-			if (wq->flags & __WQ_ORDERED_EXPLICIT)
-				continue;
-			wq->flags &= ~__WQ_ORDERED;
-		}
+		if (wq->flags & __WQ_ORDERED)
+			continue;
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (IS_ERR(ctx)) {
-- 
2.43.0


