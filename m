Return-Path: <linux-kernel+bounces-153318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A821A8ACC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64627285C12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B611B146D57;
	Mon, 22 Apr 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH9ul2tG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189F1465A7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787267; cv=none; b=GZdqoez8jcSc/f7tZlGw3qcY/3C/JN4ARDSu92txkXt3rtlAldG7r0u1eEknlahVgiAHlKzFCYtsabSI0Zcisdsy2K7wQizcpeJJBwUgS8WdHgGv5m5VdIxsMntLIyIswuE3Dr0NN8PW+KGtMkEPJI8ei19VjuScrf9udVBrKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787267; c=relaxed/simple;
	bh=4UFUDrnZaiEppiwH3I4zA+17+x8DNbh2KbHYULiw1JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=allMO5OgnBFZDX0ieVHZlgkDkm5z9PtUWHWwvdrHBQ6DSIyRo83L7mpk3DAJjpmEZz5oSGLtERMqHPAPGO0/CKCeSjEXyRgHaa74XohKr4I90nN3EkR2MHcE4tIQ10RC6Mu85EXzXdeofovUUmPXwwdmlcEHeLW4/F9/12rqgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH9ul2tG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55bdf477e5so62686066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713787260; x=1714392060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6fd5i+0JvXAyxfGeQJKy8pR12A2rl+HE+2Dsk7AGwM=;
        b=WH9ul2tGdH7zLU11MIZOOO5frDLuOFh2b4iXnSaF8gqWLV8Bg1aNttZNNMxvxnqLKx
         +6XbQr2ABxOjjNzsz9vImDXdwynQiFyqqWuWMJFqD1wJ0KSRIgIWop7eXsr/gaCCKkcj
         3ssL5DK1QbOlA73s2yPpvyMncHXsuDx0VtjA/HxOXPvQlXhxNvDysbhg3jeus4PxE1Pt
         rc3IgAb/RzdI6s27SuDi40ZzxmluMoeoy7l57auw/MC4DNqmFFxH585tdoWa4Wb4hGwk
         NvQT+gnwTBjTWoAO+QAar7NVdvlx5PRYyPZzmmt5ovpXTomyS7pRtG3Eah+Ore6y14N4
         Lwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787260; x=1714392060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6fd5i+0JvXAyxfGeQJKy8pR12A2rl+HE+2Dsk7AGwM=;
        b=dXb4v9M2V5HrY37lbQI+Jry0GJFU/gjVL/5kLQCVJIH8kX3iVGrGl7z8zuyz9lvZE/
         KP2/o1h9/qzZ4RQnhRhkgccUw/xBMqK5c1eT1omy2ShoY1pTry+6VMvgv8lGVnH1qa+c
         WQXudZUFlJ7gx17MGzHZ/QRJAXTb1LnyCIE0Z+7ck8QJovTwXJcy53JRSktwwxPlEqmZ
         n+c/3PJ+O6xsqeAuZPdPm2ffyCUfRFaRNs8iViuPtdnc9v1WY8KmSh8ywS1H2oS62/Fp
         bRGjdaAMWYXwB8KX3iBKqqkytjglMIoAqIeyWbOd0w+hHNV8MU+0KPghA0DeH3/vC7lh
         bzBg==
X-Forwarded-Encrypted: i=1; AJvYcCUt1vScxoWLk/24xEi0GOlzFtBRt/BpPF7BLUiRILQXgklCX3v0BTcxgvK8gOTei2MrY8lklDWhNHibBuwK1vKalHzDcjb+3ZeRmUUC
X-Gm-Message-State: AOJu0YzAQg1+QDM8CedAYjtsoqAPPpHbEUOy5facQWJpej271gHuwfqd
	Z96ehFq7voEqmc3y9H0YHY5YkufsBZ/ksy8FAHjsufFACxHPSPMm
X-Google-Smtp-Source: AGHT+IH0eLbh0z4T48v+/R6epjAWIqIwEIZBTeL/rAT/X+8MogZu6F69KsSLjqUYUd8Gw0Uf+GHtTA==
X-Received: by 2002:a17:906:16cb:b0:a52:6159:5064 with SMTP id t11-20020a17090616cb00b00a5261595064mr9528762ejd.52.1713787259961;
        Mon, 22 Apr 2024 05:00:59 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906110600b00a5827d2f6f4sm172070eja.115.2024.04.22.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:00:59 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] locking/qspinlock/x86: Micro-optimize virt_spin_lock()
Date: Mon, 22 Apr 2024 14:00:38 +0200
Message-ID: <20240422120054.199092-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize virt_spin_lock() to use simpler and faster:

  atomic_try_cmpxchg(*ptr, &val, new)

instead of:

  atomic_cmpxchg(*ptr, val, new) == val.

The x86 CMPXCHG instruction returns success in the ZF flag, so
this change saves a compare after the CMPXCHG.

Also optimize retry loop a bit. atomic_try_cmpxchg() fails iff
&lock->val != 0, so there is no need to load and compare the
lock value again - cpu_relax() can be unconditinally called in
this case. This allows us to generate optimized:

  1f:	ba 01 00 00 00       	mov    $0x1,%edx
  24:	8b 03                	mov    (%rbx),%eax
  26:	85 c0                	test   %eax,%eax
  28:	75 63                	jne    8d <...>
  2a:	f0 0f b1 13          	lock cmpxchg %edx,(%rbx)
  2e:	75 5d                	jne    8d <...>
..
  8d:	f3 90                	pause
  8f:	eb 93                	jmp    24 <...>

instead of:

  1f:	ba 01 00 00 00       	mov    $0x1,%edx
  24:	8b 03                	mov    (%rbx),%eax
  26:	85 c0                	test   %eax,%eax
  28:	75 13                	jne    3d <...>
  2a:	f0 0f b1 13          	lock cmpxchg %edx,(%rbx)
  2e:	85 c0                	test   %eax,%eax
  30:	75 f2                	jne    24 <...>
..
  3d:	f3 90                	pause
  3f:	eb e3                	jmp    24 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/qspinlock.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index cde8357bb226..a053c1293975 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -85,6 +85,8 @@ DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
 #define virt_spin_lock virt_spin_lock
 static inline bool virt_spin_lock(struct qspinlock *lock)
 {
+	int val;
+
 	if (!static_branch_likely(&virt_spin_lock_key))
 		return false;
 
@@ -94,10 +96,13 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 	 * horrible lock 'holder' preemption issues.
 	 */
 
-	do {
-		while (atomic_read(&lock->val) != 0)
-			cpu_relax();
-	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+ __retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+		cpu_relax();
+		goto __retry;
+	}
 
 	return true;
 }
-- 
2.44.0


