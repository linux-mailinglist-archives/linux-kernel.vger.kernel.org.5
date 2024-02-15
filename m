Return-Path: <linux-kernel+bounces-66994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97971856490
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAD31C219ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C66130AEE;
	Thu, 15 Feb 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IY4OVNa0"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CB12BF3D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004205; cv=none; b=GdJdXZWueyrRLyLS79JJCJ+i3UebWyvQKVybR70MNEHAXfck9bHBOSdHcRMZzX5ooEjSwz34Xc3tuptKRDwFNwIJgwcqKF0RDLip4LWIqFc+B/NdaAFRCkGDEtbEmAvr2POdfRhvDC9fsd/eMBKj92SSDVwI96wl/XUKu3kIO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004205; c=relaxed/simple;
	bh=+qesoz2V42RgfnQKUGiS5UYjIIFWsK48uyeINtqXE/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BWDoUwr9QXaCGJxIsGFy8vs3NcaWSR+7xAOosbcf3u6uB5X5JefwLTQGrguHxDiMReihs4mHjQAQx6s9tt7l8nQ9CmNsDy1b3O8b06jxrkCNn6ZUazAUq+2/ueLlL0zpSrwNAuL+cjvMGHPySZOvHvW30X/SMtNUBAxqCLC8CIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IY4OVNa0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-561f78f1ba1so940146a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708004201; x=1708609001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSAPglM2wZ+xLjfRrMYJKrvwCFVOGwCTlmuHoEDAY3I=;
        b=IY4OVNa0hihlnbwP70YHsBdcI2BzPlAKrsg/qokuZRhUvP9s82dAMSHruJ2z6p/3GA
         KV3PD7KImFwQsfHaNMpgdBNZVtVYG7LshSc799Owvsn8V8yzoZBi267aAjG2rsCaE3US
         mVSlhjM/cDhdG+l139cr4O4sWiS2F67SXD25oL7MHhBW61d7olpTMDmJVVFhHpUovZfO
         VeeJ9WoIWTRDZ1ngyOqwX/Ia+q7xUZBE0FCWMr77kQx+dsq92Xu5xHVyZvDtJqH+DqVM
         959w0q5tBVNY8XOjZjrXtVbbeatTnRNewH6skM1WkZzCJ1sJjNrqXkp/FIXCnAi1MeyS
         fQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004201; x=1708609001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSAPglM2wZ+xLjfRrMYJKrvwCFVOGwCTlmuHoEDAY3I=;
        b=u3UcQWvshaQNzL+J9VBjyJapqwKnTSbvjxsZ3o8/pv+p9ttJAUF+PbSl3G9gOlIM58
         MSCK4xXG+5Gb3ujhLD4ihwE1yh6o+FFbll9TuJzveb0hQArPIf0relvfcsfx/pkAI8dK
         +EdU/wdI+KDgl5OvmHohZG2HuXtlGxVrYYXEkay6ZqszNhAzMdDWyomcmAuzLPmGUWQs
         aRDuXdxZetnKPdOpmxJMJG6ScjMPgD8ppmM/0F8QCZj2dur1jQLft+oyQ3bgHM5JCtVX
         z077GuwoL3NcQnPZ6T/8ymwrlRqYgk1ersxJCpE5ofOd9y6ZoChDEnIMYBRcmhBCj3Yp
         suyg==
X-Forwarded-Encrypted: i=1; AJvYcCWyG0Q0awL0Bz+C7Sh0bUaoVdfYkcK4/9lRHvlp1O8dnHGethKD31VCyhIIbTR+4sw0INEQS900utFiLx0uzoFMCrnziWFQEsXWVB7t
X-Gm-Message-State: AOJu0YwzMZPk5zrolNaNJnU3woFqV3fXEgzmAthzhS1tJ1BcjeL4RX8y
	H9XMXCoam6QUdY1gEcjz/GwQF7yywfIVsCxGa9zCRBBRRA1lPbaL0hrkHPmj3KQ=
X-Google-Smtp-Source: AGHT+IFWwIf8yc8YxM5C/1EMQUcZSLV33IwQsH6D1RK7xkbn7UQ2/OWS+wm0Vwr/2+XrMlsQVNBxUw==
X-Received: by 2002:a17:907:76e5:b0:a3d:8035:fdd1 with SMTP id kg5-20020a17090776e500b00a3d8035fdd1mr1467797ejc.76.1708004200904;
        Thu, 15 Feb 2024 05:36:40 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906131800b00a3d22f53210sm542350ejb.188.2024.02.15.05.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:36:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] arch/x86/entry_fred: don't set up KVM IRQs if KVM is disabled
Date: Thu, 15 Feb 2024 14:36:31 +0100
Message-Id: <20240215133631.136538-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KVM is disabled, the POSTED_INTR_* macros do not exist, and the
build fails.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/x86/entry/entry_fred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index ac120cbdaaf2..660b7f7f9a79 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -114,9 +114,11 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
 
 	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
 
+#if IS_ENABLED(CONFIG_KVM)
 	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
 	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
 	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+#endif
 };
 
 static bool fred_setup_done __initdata;
-- 
2.39.2


