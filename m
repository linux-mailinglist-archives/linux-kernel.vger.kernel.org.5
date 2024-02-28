Return-Path: <linux-kernel+bounces-84444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122086A6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B85280EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908B1E51E;
	Wed, 28 Feb 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="URgjHVN3"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1211DFDE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088368; cv=none; b=a9x6JfdhLDI5MyCV/cbprO0E9MGGfYBZA9nOA10J5gcCsyQC2vqG1uF23HvRsrQqRFsUkNCRMI9czYE3RfB3KdtgkZqJVJj9ISUfQzGDgwHbWI1cjWvNTixyTSDS5PVd9wsVKNNUnwAyUht80niPYCFrby/D7VdYzDY4aCSSFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088368; c=relaxed/simple;
	bh=j0esSTih3HDQGZF6sZoHNfFbxuBCsmG4nJeOOvz7sfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJAMbAW4yjHsq7eTWlmt9xH27N8sxwXpltFrKUHWxi0O5MtWVFV9hpnCMKIqQcZ0gZRRFx66m7ftx4G3PmiHcZnOztV0qKvWEuwEbPqOp53OJ7LoGktaElQyNcmkhCrQnmOM0Pih/BrYx+URfBrSBK39jUNrJN8ptJ/gzOK9mHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=URgjHVN3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so2891573a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709088365; x=1709693165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZcP2NcGO5ZtZ0U6eIwOdju/e57ADMXOAHt2kWBKkaE=;
        b=URgjHVN3OXlILq/zS73P865F6O1rIRFp1ebNQhamgJv/j2T0qfjP+curvoZT9UYfy/
         9+MGyYuH8SmyoLmUZoiX/z9Fi6cb9zux1wZNf/UnYXoUtWkSYXE97Wv7ov3G5ft/leui
         MPEay1sA+pV7c27MeVDIVySSRZEZOsCy9yXh1kQnV32vJvHr2NCbTOMAYqA8C9LHG7LJ
         RzJ8t+lqXkmwuQ1Dl0utPy4J4deZLFOHaK/w1wIVLTZi8bkfrVW9UsKhPLgH+Ywy81t1
         +yq3JG/SCCARUjnWqxvFKayIL47S7Sa9xt6fGUd5QaHl4xWT4oweo5O/I96vl3zJbRLW
         rNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088365; x=1709693165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZcP2NcGO5ZtZ0U6eIwOdju/e57ADMXOAHt2kWBKkaE=;
        b=beFEqVzLnX5LIfMpyaeAMknhjqgxwAQq8K47VOQ3xhlSmaHK8VbO+YH3RHEMTLj+c/
         XB1LxhcFo9xBtnel8czcfXXrjjOyvMBP+MKT9z/dtWjsiBHbhhGBqRNy1Tcig6DZHFEB
         nMw4zpN7pwr6dFCfuZvz8AEWC0QQ8WzakbXbODqr1KLC9R9u0o5Zw5NziIp8NgB5kNfA
         taMaTlkMcFICvCpwiajtxE1xVmJQzd5t50XCQX7Ej1zDjvBLS+VhzVPX8Pp6yr2zFYUI
         1v8rOm9K2NTXiBgw0EIpgm5Cb/PQliWnxDyu5HIleXjqTfHuyRT/ovX3KntCUf8xdyMA
         9pSw==
X-Forwarded-Encrypted: i=1; AJvYcCXnMRUX0ToSKTglKqy6UGVuzQgb6EPc95FSIo9+djd2laYognW1yZBWgAkziHpNZUMnbVeo1j0gr1s7btzpBwo9dKyesFAx6UqZZpce
X-Gm-Message-State: AOJu0Ywal87i0eUzyrEe/RPbKpUMfJcgqH07oWrBs1bM7u4QKqVNwENV
	lLmqWY1L1nfhOJgsJsmlsL+T+8JLJaLJ9DSaSJl4SlM8Wd2LmrzgHoXLBF85KL4=
X-Google-Smtp-Source: AGHT+IE5aRguP/6spiUNpXSKcim90cEHvc+QzPlJD9JJPgHm8oKDp4OsDvgpiR9QYwrYBE0MCnDu4w==
X-Received: by 2002:a17:90b:8d8:b0:299:3e54:83fe with SMTP id ds24-20020a17090b08d800b002993e5483femr9708762pjb.36.1709088365439;
        Tue, 27 Feb 2024 18:46:05 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([240e:6b1:c0:120::1:d])
        by smtp.gmail.com with ESMTPSA id 9-20020a631249000000b005dcbb699abfsm6489072pgs.34.2024.02.27.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 18:46:05 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v2 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Wed, 28 Feb 2024 10:45:33 +0800
Message-Id: <20240228024535.79980-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240228024535.79980-1-qirui.001@bytedance.com>
References: <20240228024535.79980-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Chartre <alexandre.chartre@oracle.com>

commit 87cf61fe848ca8ddf091548671e168f52e8a718e upstream.

Fix is_fentry_call() so that it works if a call has no destination
set (call_dest). This needs to be done in order to support intra-
function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-2-alexandre.chartre@oracle.com
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dfd67243faac..71a24fd46dbd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1367,7 +1367,7 @@ static int decode_sections(struct objtool_file *file)
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
+	if (insn->type == INSN_CALL && insn->call_dest &&
 	    insn->call_dest->type == STT_NOTYPE &&
 	    !strcmp(insn->call_dest->name, "__fentry__"))
 		return true;
-- 
2.39.2 (Apple Git-143)


