Return-Path: <linux-kernel+bounces-34506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06E837DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BA31C2885C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC065FB84;
	Tue, 23 Jan 2024 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUanmnYs"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80E5EE88
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970163; cv=none; b=Hl4pqPjlJrHlX5sue/Du31stjrO/EXA41G+NsuLrd+vYV4A/JDgujy4gIteoJ1oNVR2NLSPHnoohz8IcxexS2DcqjjDtIjg1on8iADypEm2cEG6lUksDZViWbmkiRhUqljOEmfnIrWAnHipFOor0e0duAaany9mIehsGxeUZG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970163; c=relaxed/simple;
	bh=nGybLOIsuTz/Gb9B1iN3NLpbKPO1DsQM9K1PTfrNPdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqv4akYektQqpEF5mv5ivSdCvwq9FDwrmohCPnsZZYtgLMBaStFxORnuyyWqJVqZ6PML0UI5pM9HjS+kvUtxea9otYwecgsijWefyqhHICulnXTV1M3ChseQC4Thq+wpAV9PjHFY0Kzix2BdjxJKTG7LNi999IEwvTcWZkszgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XUanmnYs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6daa89a6452so2375709b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970161; x=1706574961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDa9oNn6F2ovUjbcqpVWupPtvSG3Yc95imKuqvbvgJs=;
        b=XUanmnYsPUxr2gTvzGVYaMzZL9E9AcU3GUA52Gz9cz66xR/dpNoDbA4kCJpY5GEAzb
         WU6dTn0ZwSxqqCNHu3v4br4nJPLpNwvukbM8xY3FM08wejMl/RHBgp1CmId2JPM0hivM
         5eA84oUg2lG083FsEyz7ga8BhzqiSjFEi1L1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970161; x=1706574961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDa9oNn6F2ovUjbcqpVWupPtvSG3Yc95imKuqvbvgJs=;
        b=HijBJnPPCK18I4Zbw2EnmRxmDu8/5lA0x9RZEcwEM4SGstaBIP5LaR3I4BRix78WCr
         p5IWwJqhm2Gs7IZfU6Bb2gS6SuIdvPe/0gq0Ue36F2aqSeXqqVyBXgH2dkaf6F6DnLTa
         9gluOMl/1XH407Vnor76pAovsB6AX9rkVwkCOqiT09dhCDlqffJOB7+kQQqS6sXklPdt
         54kikDbFuJASdITqYOgABQiD0BSKUQMuyeOtVNTnV5e03KJtZ3PXpOlncw5TNuIkMU7a
         6p5u8Ae6U+pkH7BmaKQZrVv3hXGVku+XRKSWGs5Zkr4j1vd5lHWeVJgFigPzUw5EFgP2
         6UWQ==
X-Gm-Message-State: AOJu0YxTyREnqX6Q3VEpTog7A3myLEa/7wU9yNVAO6T/kIJAODyjJBdI
	SoUhm+Hp6p3BrPlKoNPpp0dAfJRmWFOU0A/kugoQ/DakIawlmZuLQ8Md1+QaUg==
X-Google-Smtp-Source: AGHT+IGFisF1295Ij2x4vO/0+LvR+AVsOSL///qInuAxURZWY7CGHJ9Maj35pV/npREH2JNW8qXFIw==
X-Received: by 2002:a05:6a20:c420:b0:19b:1e87:5a6c with SMTP id en32-20020a056a20c42000b0019b1e875a6cmr2159488pzb.79.1705970161063;
        Mon, 22 Jan 2024 16:36:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d11400b001d717e64f0esm6400820plw.87.2024.01.22.16.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 68/82] PCI: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:43 -0800
Message-Id: <20240123002814.1396804-68-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=keescook@chromium.org;
 h=from:subject; bh=nGybLOIsuTz/Gb9B1iN3NLpbKPO1DsQM9K1PTfrNPdM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLXzUyFv8ROCBAkarbyBq08JOy1Jiw/R0yL
 UURfO04CTOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JuF8EACyGcPp93JqF5tp2S7pbgmh+m2YVe5oYzmcs4GyaCIJEg5zXT/fdkd6tu2LWmWPsIg40Fr
 SbKeYY5YJaOP/yC8bfFrSsUOCoCQFIOLM4SkZgOC3hAJtNPv+NG31XNwAmBQ3ogTFje0YjRk7qX
 OYSeEqoBDlAMmU4ce5qwEHM06VtNVtQCVNp5oulK1zW8BMSBgHMTXzBijtO/DtiBVki8i41z0wI
 5ErrZ+PQQvnc9zRdALPpt5gb/S8dIR7TKzb2KvbM6frT9lAgHflHE9pO5u1EhFtAejTqdWrGrN6
 pz7/2Fv4SETQBDdstfnc15QJJZCgPscQjsL9qw7dy5mLg+E40l1MBYJXivSBEyHPeiVE6vgl8xb
 9P5WqEdq1qfxNLckOqUq9TrZNeGxgxaio+1lM+9xtkKqRSW145a7mRn0Drc9DMHh0KKsUX5TNLk
 xCrBbdKnNhC+Jeqa6I6f6WQW9MgVjNkA17fQdWf/jxsjsf+JGxlVE1livqEEMJbpn66rbvl8iW4
 ypcRIykksrriHbd1C2Aq0g4i9QdSGL/ol0MeuQ2Q92JZUf05lKqbOyhUGChwz26XkLS4M9lRwh5
 usd0VpO9+Y4iU3JXhrCoN2j8ab6+8PU3rZesVh+i68xSHd06pfjnsC0JJQjMi9vWmUHq7sCOINd cznG4a3YV1rp9VQ==
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
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..ebf6d9064a59 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4251,7 +4251,7 @@ int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
 #ifdef PCI_IOBASE
 	struct logic_pio_hwaddr *range;
 
-	if (!size || addr + size < addr)
+	if (!size || add_would_overflow(addr, size))
 		return -EINVAL;
 
 	range = kzalloc(sizeof(*range), GFP_ATOMIC);
-- 
2.34.1


