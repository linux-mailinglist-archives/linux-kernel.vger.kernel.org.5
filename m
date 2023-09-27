Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB67AF9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjI0FR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjI0FQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:16:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B45FF0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bed2c786eso8076660b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695786145; x=1696390945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmhcOt0Phh+K4fShkXGPXzhG2+0EGgvMOT3Anhb5JtI=;
        b=ZYsp9X2L/K4sq6nHJ/InBMtpPeI6AC7q+P6owshAAH8QJH6wLbLAYABxQO17n6vIwP
         FjMdtDMz2/Gjw9Jtf6KVV/kwTK/UXRDxjd8c4mLhhOPLs53oDqJGPV/oEuNWV+BSxbph
         ZABsEBD/b4uQDrO7SOdPnc9aHU6r4MoyJjsYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786145; x=1696390945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmhcOt0Phh+K4fShkXGPXzhG2+0EGgvMOT3Anhb5JtI=;
        b=QV5/Ma12CSvHYQQgpl3DGAd3SrrI7OHw2VWwsdePucUWO3o76mJ/l8iGcSJMN9Moc7
         FO1plznuUhanyLy3rkG7/b8vtlIvHW3gURqhzfzHA97VEZgMRpH+NLqNv286wonawTFn
         INfTOnSZzqPfZmCfguzDP464qBNgMH09raAvHJh+UXJ0zlx4JAW2HPEtZUQScike1WkX
         T3ZpcQfd51NoG3oVZXNQIV6Cyz+HrOW/52h8u0ZuetUkiqIeZ3lI3ypEbxv0JrKy6xAe
         kfDI3OCAV1kX2OeYCxj93BYJQR472f3kp/nVEAa8lb2N4d7Q4xVnfzSl8U6MoJmRvwzY
         /IBQ==
X-Gm-Message-State: AOJu0YwI+Oicm+ikT80e7k9+oxleO+80a5op8dm4oihQsKN5+KLcBJcE
        rGflX39uzTMfb9rrJmj4deLHXQ==
X-Google-Smtp-Source: AGHT+IEnkEHkAMyfzsQkaO55Avyrk0ulpfRxCywQvRCp4n7UkR+naKdiK+KW8D+X2wQeWkwJJchcfQ==
X-Received: by 2002:a05:6a00:cc2:b0:690:ca4e:661b with SMTP id b2-20020a056a000cc200b00690ca4e661bmr1032600pfv.13.1695786144968;
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i13-20020aa78b4d000000b00688965c5227sm3826941pfd.120.2023.09.26.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 3/4] binfmt_elf: Provide prot bits as context for padzero() errors
Date:   Tue, 26 Sep 2023 20:42:20 -0700
Message-Id: <20230927034223.986157-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033634.make.602-kees@kernel.org>
References: <20230927033634.make.602-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3658; i=keescook@chromium.org;
 h=from:subject; bh=wBfTuibkI1ZafUlyw4M9Ln83egyXuZyKwCYBlE+Ln0Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlE6SdGv8DDqtwm5Ol0LgrgyjZaP+4ZO6Wq6Zvc
 ewLHcLJGtKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZROknQAKCRCJcvTf3G3A
 JgOCD/9Yn5Qu3vikEH/yBMhn9z8VzLRLFdyRg9vmKyaQg1Y1oUqxhPpmdoBiT9lo4FEZcAz3Pbo
 slZs7xhhxScfjwwayUC/3eCa2sGC4pDlomjzWuLKZx+rhUKBTXLGk57l/T030w/BTGRk8OApPaS
 19sBIkkgXFNfHvlcgw1zzeX4/JPF7yvsr936vFS/ypc4nuzEzdrRoMKxuTMgP+eVrsgNAri296j
 DeMk8JiLE+PzpbV1vRrhK/nP6G5m/OdH6OVZP3UIOq0+M1GnvJS0F1LVRL9T1aolQyan5mAn1/3
 Tt2f5wsLeGNsy09fY4++KWw22oYo6YHGAYfwbp93cdnjtqCniroSVvEYPNiPdsd6OXtZm8O2ERQ
 IhyT1RCKLWjAXpK6Ow8yZYZwS2FmI0TRhU8BgygE3Qh5XkzdsjY0oi+QUkh3s0ktiqKyZxXrW40
 k6zgbv7iGb6zTzbkqeecY4Tju47/elEUbwqNCxRnPcmd3SfCF0jwKWVwGGxUcBRaWdao36it2H0
 09ADuzAuiBrMa1Z24c5C99+xO7kPruaySYYC7DV703FB3q5+qWFThooJ4gzw8qx5HyOZhtzvQhz
 zyn1WsqYfrF04pj19ZYwP3oimZ2OctqtY4fYgdF0pZadU5BzKZlwRvxwrEMy713xxETHnY6nu8b rYdT6wNKfO8hgTw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors with padzero() should be caught unless we're expecting a
pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
is present.

Additionally add some more documentation to padzero(), elf_map(), and
elf_load().

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 0214d5a949fc..b939cfe3215c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,19 +110,21 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-/* We need to explicitly zero any fractional pages
-   after the data section (i.e. bss).  This would
-   contain the junk from the file that should not
-   be in memory
+/*
+ * We need to explicitly zero any trailing portion of the page that follows
+ * p_filesz when it ends before the page ends (e.g. bss), otherwise this
+ * memory will contain the junk from the file that should not be present.
  */
-static int padzero(unsigned long elf_bss)
+static int padzero(unsigned long address, int prot)
 {
 	unsigned long nbyte;
 
-	nbyte = ELF_PAGEOFFSET(elf_bss);
+	nbyte = ELF_PAGEOFFSET(address);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		if (clear_user((void __user *) elf_bss, nbyte))
+		/* Only report errors when the segment is writable. */
+		if (clear_user((void __user *)address, nbyte) &&
+		    prot & PROT_WRITE)
 			return -EFAULT;
 	}
 	return 0;
@@ -348,6 +350,11 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	return 0;
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". (Note that p_filesz is rounded up to the
+ * next page, so any extra bytes from the file must be wiped.)
+ */
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -387,6 +394,11 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". Memory from "p_filesz" through "p_memsz"
+ * rounded up to the next page is zeroed.
+ */
 static unsigned long elf_load(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -405,7 +417,8 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
 				eppnt->p_memsz;
 
 			/* Zero the end of the last mapped page */
-			padzero(zero_start);
+			if (padzero(zero_start, prot))
+				return -EFAULT;
 		}
 	} else {
 		map_addr = zero_start = ELF_PAGESTART(addr);
@@ -712,7 +725,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	 * the file up to the page boundary, and zero it from elf_bss
 	 * up to the end of the page.
 	 */
-	if (padzero(elf_bss)) {
+	if (padzero(elf_bss, bss_prot)) {
 		error = -EFAULT;
 		goto out;
 	}
@@ -1407,7 +1420,7 @@ static int load_elf_library(struct file *file)
 		goto out_free_ph;
 
 	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
-	if (padzero(elf_bss)) {
+	if (padzero(elf_bss, PROT_WRITE)) {
 		error = -EFAULT;
 		goto out_free_ph;
 	}
-- 
2.34.1

