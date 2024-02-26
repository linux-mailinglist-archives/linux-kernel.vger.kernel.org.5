Return-Path: <linux-kernel+bounces-81077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F23866FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BE81F26DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A975FEEE;
	Mon, 26 Feb 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CGosVka7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E155FDC8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940490; cv=none; b=bLOO2PtJtFkN3qe2swsR6yZLyHoMGzVHsApTPSHnuLFr8/UxAmTSnd0jdqYe8WSFZ6E4XDh69Nx+ia5bmUHoxUGwAAvYKibQRqWgDpr41/CdJea4zVojpsSD9J2OCOyblXlQhKWoKQaJYBVALMPxDQX6Ug9DQb9uZmzBrqtq5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940490; c=relaxed/simple;
	bh=GVSij7Ng2ZnL6ItLte5S5qesoG2Gu5vTbGRvnRyWD94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhJWY8msBhlOezAdjuFStxL8D9qfdR+l/d9NfPNBXZO6iN2P8dhlJts76x9K8Iv/R6WmgMyr+oKOE6tWW3h0GLdoo8R8Dl3ZaC81Lm/p9bpa9HjH8yKzh707W5lgpK8Eeq8z5iU6XVRieQ2DL815pXVW+I3nhE8rZ9m5juKpY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CGosVka7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so2911769b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940489; x=1709545289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYE4VOh0Esz26qF5nAL3o0bNyOzXw7ZQ+0pcNpsCkTI=;
        b=CGosVka7qjKnY0yXUtD2+62cpEv1B8Qhi+1DxsL2sdF7UyOq45eSF3NGmH12bPKjmI
         41tjaSsU4mkqSagFIk63eyKyMxNYCe0CHq644jSJgVNddKoqyRXooeJ0/TvJCY3fFIMh
         aaoeZXQaGO9mDUUbGBpppzK5kvPPymtCZbG8smCpwCcOaFtQt+/+MxGl0Tf0WYKjtafo
         AMVtWfJULiR5JfTWhbrjXYN29/aCRfZycpfXmXDyO209XS+5jAIHwiB0YDnBmEhKAjIb
         ZbAgugfeZHio/fm/SED3g7gXzspnXhwfnRRp7YUB8gM+9gt9wYfbVvj6OBcxFNjr3nuL
         FyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940489; x=1709545289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYE4VOh0Esz26qF5nAL3o0bNyOzXw7ZQ+0pcNpsCkTI=;
        b=bFMk6tmVLIubQzhd0VlBSp/rjpWQbYicXA0Z8guYa8DR86IY94sm3XAWKXp4JWebFt
         IJngzkElCd9nbQUhiZ3que0M1I0SPwXuR5qFHaUwxmRwHxqj416o4r59QDet3YR8fTAw
         0AQA+GdKeFN7NOdqzyy6BklYoO6MDyPgbGt8vfiykfJRFK5+RnYvjoP2vkdjd32MMUaq
         anKZTMaYl7b/H6g/sQ6jagfqb1srcrkVltRBGlJ8Yzs+iHGhi3xA6uL8IFGdKrtv1ZCF
         1D/rMyWdZk61DBvcTcSHw6MlGxDRQ/1wCx49SsX+GjYRJOqsea34PvqdtzALsb/rKs/g
         oBzA==
X-Forwarded-Encrypted: i=1; AJvYcCVMFkyMeXkq8RrTtfq9McgYD626p6P+24JEjZjUAnB7JopdwBD7vHRwuk894WpflNdle0LAN08mchMCo/VJ6Y3Zyxecfaj9dfEzBgE/
X-Gm-Message-State: AOJu0Yz+56FzbDGc1/c0apBRylBHd99MzZ+sb7Bs3JtzHS9PdqYulqh5
	GCn5CyADC6IBRBrlK+Eirpog/FsWMT3mZn0WesMV8ffITciyLrWn3pSkNG7ijUs=
X-Google-Smtp-Source: AGHT+IGvZV8jHTxyMl8ODdufQaI3tZxW0Qibr0287grfFaY6EgP+oyydN3lDJlq23rMorsZ0fuDe2g==
X-Received: by 2002:aa7:8edd:0:b0:6e4:1a29:7332 with SMTP id b29-20020aa78edd000000b006e41a297332mr6304473pfr.8.1708940488829;
        Mon, 26 Feb 2024 01:41:28 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id ls22-20020a056a00741600b006e533caee00sm949194pfb.155.2024.02.26.01.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:41:28 -0800 (PST)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
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
	qirui.001@bytedance.com
Subject: [PATCH 3/3] x86/speculation: Support intra-function call validation
Date: Mon, 26 Feb 2024 17:41:01 +0800
Message-Id: <20240226094101.95544-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240226094101.95544-1-qirui.001@bytedance.com>
References: <20240226094101.95544-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER
 to work with objtool") does not support intra-function call
 stack validation, which causes kernel live patching to fail.
This commit adds support for this, and after testing, the kernel
 live patching feature is restored to normal.

Fixes: 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool")

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/x86/include/asm/nospec-branch.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c8819358a332..a88135c358c0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -13,6 +13,8 @@
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
 
+#include <linux/frame.h>
+#include <asm/unwind_hints.h>
 /*
  * This should be used immediately before a retpoline alternative. It tells
  * objtool where the retpolines are so that it can make sense of the control
@@ -51,14 +53,18 @@
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
+	ANNOTATE_INTRA_FUNCTION_CALL;           \
 	call	772f;				\
 773:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;		\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
 772:						\
+	ANNOTATE_INTRA_FUNCTION_CALL;           \
 	call	774f;				\
 775:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;                      \
 	pause;					\
 	lfence;					\
 	jmp	775b;				\
@@ -152,6 +158,7 @@
 .endm
 
 .macro ISSUE_UNBALANCED_RET_GUARD
+	ANNOTATE_INTRA_FUNCTION_CALL;
 	call .Lunbalanced_ret_guard_\@
 	int3
 .Lunbalanced_ret_guard_\@:
-- 
2.39.2 (Apple Git-143)


