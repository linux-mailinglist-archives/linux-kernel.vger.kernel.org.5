Return-Path: <linux-kernel+bounces-34567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF88380C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C1B24F45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A0132C10;
	Tue, 23 Jan 2024 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIdjwNrN"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85170131E31
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971826; cv=none; b=gpoR+QtR93WpoL2MccliQDhk3Hp7r5l7LP+zBuyCDjt1mNzn7fvih8SUA+W7vAqYzT2hkcWs9Witt2kUTlT7E2FazphZiyQyT9f5uFsBQ5pPElYM0bZi/v0ZsdRloqYCKG3C0mmRFHJsLSDz91bnt58Nzh418lxuDi7kxfOgWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971826; c=relaxed/simple;
	bh=0h5G2tRq27FIpo4Q7qModudkA+HmHi/wgWR1Q2jDdRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLfyF3r1S9GiFG99RM2PH15eNBa5+2et0SFVKs316EwOByrC3WsTyX0NKputPQcsIBqhHLu2HcNh+Pa1g7GReq9fkYIvizVe7GpPbQhpdfMGCrcfbmWBYjUhmh/OCAAo2u0VvMtMRqzbCQdEPu4xMygy378RpEpA0myxHgeQOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KIdjwNrN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dbebe4938bso819178b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971824; x=1706576624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHzaAgF/BvT1ydL5OjrG2T32BsfjtHiswnni+cftQZw=;
        b=KIdjwNrNfztB+9sApXU8+AmNq+1j3EAk0XGIsme3K/4b7xQMf/NvAZhahQnHguW2ds
         BrgujlKCAjUi72g25ttj2EftG+At1FNxAq9H5pCNQeZWvRgSwNJmgNadDLhmCeYmKRCw
         Ai2hltH3QbJWENzjPeMwPJdan61Q6jpHmGgGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971824; x=1706576624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHzaAgF/BvT1ydL5OjrG2T32BsfjtHiswnni+cftQZw=;
        b=QROn1GCP7u3vvkGeprYfrO0wgTi8CyX21vc0oOMp2zHvBziUddId4F9IuyBOwIX9Kt
         TGRL0Swk38k4JtqJuHkZJUqbL/+TzDAQzy7x5wr4gkWWW48g8qKkZeBnU1SNNfaG6Fo9
         748UyY+BCdcaWLM/7Z6g3p29JPL6n7oxgYDP/hD274Sar/dS5BWx6EDcrK6S4YbuJLhf
         gUuQusCufBseaoDWQkbrjt2nCNOtd4mns7CwAs8qC8BHQD48eP8zgn/TcBVgsJY3KBLA
         LBFq+iCXpq8yEVZUnp8Ur/wcGZnXi+iWMR7rVk2OfyaBu2+gYSm6PnCHbZGJ88cudoi6
         PFvQ==
X-Gm-Message-State: AOJu0YwnL1YCagigkHiBy+uKIdBxpvrEfAfYO+Kdk9KHper2kJWrfrMG
	76YTiAV3dzmERSrRYNYCrMNkAfqa0JWPUpdEIaY4RuKS9wtNvmT32gdWQQtVMVy05+P672G10Ch
	HSQ==
X-Google-Smtp-Source: AGHT+IHvroj2CO8ZLYbE446i2XqYNffjGeUmqPm7hHeasKcoNWT1iFohUjGr20Vo2qOU4QDlncK//Q==
X-Received: by 2002:a05:6a20:1587:b0:19c:5643:faee with SMTP id h7-20020a056a20158700b0019c5643faeemr678799pzj.19.1705971824060;
        Mon, 22 Jan 2024 17:03:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001d740d195e0sm3193684plb.93.2024.01.22.17.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 71/82] s390/mm: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:46 -0800
Message-Id: <20240123002814.1396804-71-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=keescook@chromium.org;
 h=from:subject; bh=0h5G2tRq27FIpo4Q7qModudkA+HmHi/wgWR1Q2jDdRM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLpMT9noDscy8y7zO/F2OVlDacpSoottbqW
 UQWgBJTZW6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JnnYEACr61LHBTRgtHLdcMb2Y/zEYEf9fNAgAUuvvxO5kW/+qOG1DgGldVNv/XDAOoTlvFck4ak
 FIYHx3fNLtAD8BeeK5FOheewr9wuzYSB2sgKs8XYqaq4sSAAXBqcUVwzQIYDgLycXM91gBv6XWk
 TeOK+U3cPpE1u8dG2uO+vai6gmjkM7zS0Lj3DSFl+yAomYD2D3zqqmmJ1Qib47sgyy5CQPLbYwq
 8hQXgWNrKwuC55t2HcHW7NaosV0nPz8gyjVVzEIOMqB66z9DJ3S2/XGk+rN+hzjOpGhO3LNgIoE
 0JLif7W0eA5mpxrskfe/zXJl7nPYZw2fwH3JgQ/rsfxRvTv9FrGq6Q4WJGpTyXoopYaPLotcPNQ
 frGK+B1yd5iZMGtbAaN5bq8DiNvFU3q3H3QJIQ4StPWYLeUFyLZxZpOsvYOKUO/G+LYtFyMisV3
 1EhF6Eg+Mb9MOAF0D/l0yE6tyCJqLC6jgcWaK1APTpgKOfeLbel2oOBr/QNOy6USDpmVnd10rui
 j6e1h1sC5OpJF7ML0bu+pIvfu57zLAyPFc1RW3fZbOpExWdOhgnkfMjvf1sqq67wTBn+Bw1urz3
 T/U0rOzWsOjUlMKwey8HgpQb1NBONSo8NXBrAEgZK0bKLp2E1JOdlZi6mD9rOPfnew+b8F/eOtO vrl+6rhRn/aFP4w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/mm/vmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 186a020857cf..98a7f08141f0 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -538,7 +538,7 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
 
 	if (start < range.start ||
 	    start + size > range.end + 1 ||
-	    start + size < start)
+	    add_would_overflow(start, size))
 		return -ERANGE;
 
 	mutex_lock(&vmem_mutex);
-- 
2.34.1


