Return-Path: <linux-kernel+bounces-133691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F9289A769
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C133128394E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08F2E65B;
	Fri,  5 Apr 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNMzQU05"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C78493
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357481; cv=none; b=BQ4+DcUwNDqcUnNulLVHqbBkUYKqFVuN6qqyxkoMiYYz+T0EwhdT/UhCTLq6TeTAjWdBDs2XplnQqvuuegI1l+SZO3ZFjF2J/Aziz0MxAdHwqq4U3ay3YYpOA4LIrwXgcWTGdtKiNfkJuFGZEZWAooGfckxsQ5hwtNbRXfNDgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357481; c=relaxed/simple;
	bh=G/E5VsTIa0Nt0yF9PXKPbaORHiEXit3F2ErrRJ3sUm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mes8f3atog1SKQFAHyhJ6/BuN2fAHhwVAqlp8xtKJqN9J+l2kMNB5tMEMAV3qtXrdWXP2IU3P34ovg9eP5+4zMbZ6fjDsdFW/C/DINeMHDwXYoN7M83VH6Uz0+SWzst9PuiW0mcQyVb3rCiieGHYbkhKgXXmsM/un9Mkj0BomCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNMzQU05; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615372710c4so43263287b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712357479; x=1712962279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i4fXLqJdMsNXvGpMsai8ez+BeipIQ1EJUVBYaTSDMgI=;
        b=dNMzQU051TmM21R/54kwsgjcUBj11neMvqDqau5DxcPQkx9lUTr3IiDJRQKnbcSyPp
         W+MkCj4N1HPyXVjFCMvlkWQy9yjevuTH7LF8yk2qeTlKwF5H+GU6WlPYAJDej4AN4Mdt
         vR+UJnaDlEGmhMyx4lIz7Q0K0rSXprTadZcP7PISxPkxL/Mw9i/E2oWmxZsOce8vnTwF
         pokfAc7zAGG37XDf3viNE9XOBdC+neVTLQ8mRVzvqZIM83I6uz1BZ5QM1RkeZTOvJae5
         wPIBMHZwZoCoDEeDuMPJNY6+0TIozmLbOOSCF0xFgbC6hi6lzr5uuZpyzuKsTjNCj36/
         a/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712357479; x=1712962279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4fXLqJdMsNXvGpMsai8ez+BeipIQ1EJUVBYaTSDMgI=;
        b=qRwnfQ5u5QPulY8SZ74hiW6TPIdkUG5VOgHacHh0CAqtjvMlqnJC26TRrR5MF863Oq
         pIRsjmv1I4n/1qdhqqhSdOy9L3W9wpEhgsadsS+1SqZjVL0NQ9iHxj7DHDMjZZ/m0It6
         /KNZwdaWkXLv/lI3SNzzlc0rpTfmmHMNhkRyAVrkGW5OPAMVkhQrW8MI3T2Gku/6Pc5+
         ONiegJjkrWelXBxkFZn7XeB2JyOTg3O266TJMKf07XxPY90RtajIV43UQY6nUBfmEb/Y
         PQvNFnyFKAoTwWgU9lS6Y0htVTmpggZNKhzAlRwvOKeFVtzV2K7uHLeMhN423c7V6D9+
         ABoA==
X-Forwarded-Encrypted: i=1; AJvYcCXJlSlH+TXuERZTWEPECkrkUvtajbbsi1UbuuVNL8ovbUk6z4jTFCSYnrugC4rxfWL4vaxYL/C7GGuKSWnI8sh4FOEDgK6AgROMRq29
X-Gm-Message-State: AOJu0YxNzRNgZHoaQBM+STmFmvIPDKbGPSPmcs0QKaqpX/T2TnYaWlex
	GWL9t4IEaAAW9Tmd56op2okH6v6uEcveZzjW4GHWr4vWQIVF52ztWHlGO4Hm2GR1nw0fFc3ow1u
	+7w==
X-Google-Smtp-Source: AGHT+IHclmmdSjYGZUdmjZK2cvbaB2MKvJYWWk5WHbm8g0fV5bD2CI2Z3CB5bz7MnU21ewBLqfHrjEIbNog=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4a6e:f175:e95d:9b88])
 (user=surenb job=sendgmr) by 2002:a05:690c:6003:b0:615:2ae1:6cd3 with SMTP id
 hf3-20020a05690c600300b006152ae16cd3mr576317ywb.3.1712357479562; Fri, 05 Apr
 2024 15:51:19 -0700 (PDT)
Date: Fri,  5 Apr 2024 15:51:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405225115.431056-1-surenb@google.com>
Subject: [PATCH 1/1] fixup! fix missing vmalloc.h includes
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

fix arc build

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404050828.5pKgmCLu-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arc/include/asm/mmu-arcv2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
index ed9036d4ede3..d85dc0721907 100644
--- a/arch/arc/include/asm/mmu-arcv2.h
+++ b/arch/arc/include/asm/mmu-arcv2.h
@@ -9,6 +9,8 @@
 #ifndef _ASM_ARC_MMU_ARCV2_H
 #define _ASM_ARC_MMU_ARCV2_H
 
+#include <soc/arc/aux.h>
+
 /*
  * TLB Management regs
  */
-- 
2.44.0.478.gd926399ef9-goog


