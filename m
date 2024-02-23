Return-Path: <linux-kernel+bounces-78002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E68860DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5122873A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41925C61F;
	Fri, 23 Feb 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX4RZiim"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62C1AAA9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680234; cv=none; b=p7r1b+bTN05UihQnoz4QktWLYNFLinKWdz7OhPB4V0rpCekPREsolOkQh7on9gUQRsPOU//t+UTd4W4J06rCfFeQ7nQvzEyWJvwQ8GuNH2xVUdOx8nWOfxRovP1CISySLqcPeb1esBG1HW9DiSwdQDfuSN+Msp1LRfCbAsqfREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680234; c=relaxed/simple;
	bh=ckRSkSYNxlYZlzbSiUcnhkJwKP6BpBL3C/6X5jI2i14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0UMOq4VQG3K/CSsqyikiY8GqHxpsU3WKD3hLpgEkI7T7dm15HC3QqyzL7plyZ2Ye5hyyYduuW1LQ+Myfm+26yZZfVx6NtZ1FcMmtzYaIrJFRscIaYqqBGL3UekuOus0bt/U1ciQELUwWuCcd3dlAGKsTtoYj3c9eELt9IefPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kX4RZiim; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59d489e8d68so292971eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708680230; x=1709285030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HB/FNAFmQYYhsfmNSuI61Gc8yU/ABQLJ8+mq/+w5WNE=;
        b=kX4RZiimfH11IPgvY0tTrD5Z9Qxxj8f9bXLVO5P7a3UTcyEmsvmnao6OOTirj4IRHk
         Cv9cAaDdRS+458DCYmb6w8gPjSHJafDYGOOZ4NI4ZkKeQl9lZ2D5gd6ryvRMhiuG6YP4
         Xq1HwWBRmOP10cvMtLcsFYvjZZDp8l2DA1TLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680230; x=1709285030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB/FNAFmQYYhsfmNSuI61Gc8yU/ABQLJ8+mq/+w5WNE=;
        b=EVgYXGwFL94qY1ZXyHhLwbc4lHC1TzoolvvIHegOHzl/RXlyvJrDCC0+EevqPv54Zl
         ZA8rqzCjsBvg5t/C5nHIb8JQVn0SsdT2LQiuZaJGkr+tDjOsysGo+fgNZT3SIfPkwP8e
         mI3HZa577t4cSfUPsy37WM3nN2AeNScQSeltbZaJBCNnj0vCY9faV4VvpYLEtrKA9nf2
         5zZsZPcnVLWy+ahyQk+XMl1/xeKUrJQRqJJD7n2+spB1KbhsmLSDXfFyE+sv2dd/Nxd9
         ZX7qgEJ45B9FF8485ArSPcYFvoHRzCgUdlWlDyiKnvHvQQFbYjCIUb9cJTWBixySPEjC
         tpOg==
X-Forwarded-Encrypted: i=1; AJvYcCV8varI8dXtquHshwhw1uk9fmCh8lZp0dnhiUUovhqUPn/KIjHnvRCQl3sxsqjTEp7H5YhZW2qV2cN6B7aE8DVvuX9gDw+QsrS6rEWw
X-Gm-Message-State: AOJu0YzPFJZ9+iEwYE929KC2zJDk179o3lgUWtOEyBAKXl4wm/VzG1ih
	xnlo13R7DzZWgQYsu1pMVbI0g0aa8IowLatlIJaMweaiohu6VlxWJppWZnT1Mw==
X-Google-Smtp-Source: AGHT+IGxmT9JLyw7jzJXAiJjYX06IB01yPHil8fnUx8qSrKhBlGjZrRaHZVMNca8KrtmHHQgE+zc9g==
X-Received: by 2002:a05:6358:d06:b0:17b:58a6:5172 with SMTP id v6-20020a0563580d0600b0017b58a65172mr1826086rwj.21.1708680230122;
        Fri, 23 Feb 2024 01:23:50 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e0c9:81eb:a87f:e8e7])
        by smtp.gmail.com with ESMTPSA id a21-20020a056a0011d500b006e0d1e6036bsm12367253pfu.129.2024.02.23.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:23:49 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH RFC] kbuild: create a list of all built DTB files
Date: Fri, 23 Feb 2024 17:23:34 +0800
Message-ID: <20240223092338.2433632-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useful to have a list of all composite *.dtb files, along with
their individual components, generated from the current build.

With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-components,
which lists the composite dtb files created in the current build. It
maintains the order of the dtb-y additions in Makefiles although the
order is not important for DTBs.

This compliments the list of all *.dtb and *.dtbo files in dtbs-list,
which only includes the files directly added to dtb-y.

For example, consider this case:

    foo-dtbs := foo_base.dtb foo_overlay.dtbo
    dtb-y := bar.dtb foo.dtb

In this example, the new list will include foo.dtb with foo_base.dtb and
foo_overlay.dtbo on the same line, but not bar.dtb.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Hi,

I hacked up this new thing to list out the individual components of each
composite dtb. I think this information would be useful for FIT image
generation or other toolchains to consume. For example, instead of
including each dtb, a toolchain could realize that some are put together
using others, and if the bootloader supports it, put together commands
to reassemble the end result from the original parts.

This is based on and complements Masahiro-san's recent dtbs-list work.

 .gitignore             |  1 +
 scripts/Makefile.build | 16 ++++++++++++++++
 scripts/Makefile.lib   |  8 ++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index c59dc60ba62e..bb5b3bbca4ef 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@
 *.xz
 *.zst
 Module.symvers
+dtbs-components
 dtbs-list
 modules.order
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 4971f54c855e..ba85c2385c9e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -72,6 +72,7 @@ endif
 subdir-builtin := $(sort $(filter %/built-in.a, $(real-obj-y)))
 subdir-modorder := $(sort $(filter %/modules.order, $(obj-m)))
 subdir-dtbslist := $(sort $(filter %/dtbs-list, $(dtb-y)))
+subdir-dtbscomp := $(sort $(filter %/dtbs-components, $(multi-dtb-y)))
 
 targets-for-builtin := $(extra-y)
 
@@ -390,6 +391,7 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
 $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 $(subdir-dtbslist): $(obj)/%/dtbs-list: $(obj)/% ;
+$(subdir-dtbscomp): $(obj)/%/dtbs-components: $(obj)/% ;
 
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
@@ -422,6 +424,20 @@ $(obj)/modules.order: $(obj-m) FORCE
 $(obj)/dtbs-list: $(dtb-y) FORCE
 	$(call if_changed,gen_order)
 
+#
+# Rule to create dtbs-components
+#
+# This is a list of composite dtb(s), along with each dtb's components,
+# from the current Makefile and its sub-directories.
+
+cmd_gen_dtb_components = { $(foreach m, $(real-prereqs), \
+		$(if $(filter %/$(notdir $@), $m), cat $m, \
+			echo $m: $(addprefix $(obj)/,$($(notdir $(m:%.dtb=%-dtbs))))); \
+	) :; } > $@
+
+$(obj)/dtbs-components: $(multi-dtb-y) FORCE
+	$(call if_changed,gen_dtb_components)
+
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
 #
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index dbcac396329e..7c2127a84ac2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -61,7 +61,6 @@ real-search = $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $(call
 multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y)
 multi-obj-m := $(call multi-search, $(obj-m), .o, -objs -y -m)
 multi-obj-ym := $(multi-obj-y) $(multi-obj-m)
-
 # Replace multi-part objects by their individual parts,
 # including built-in.a from subdirectories
 real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
@@ -91,6 +90,11 @@ real-dtb-y := $(call real-search, $(dtb-y), .dtb, -dtbs)
 # Base DTB that overlay is applied onto
 base-dtb-y := $(filter %.dtb, $(call real-search, $(multi-dtb-y), .dtb, -dtbs))
 
+ifdef need-dtbslist
+multi-dtb-y	+= $(addsuffix /dtbs-components, $(subdir-ym))
+always-y	+= dtbs-components
+endif
+
 always-y			+= $(dtb-y)
 
 # Add subdir path
@@ -406,7 +410,7 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 quiet_cmd_fdtoverlay = DTOVL   $@
       cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
 
-$(multi-dtb-y): FORCE
+$(filter-out %/dtbs-components, multi-dtb-y): FORCE
 	$(call if_changed,fdtoverlay)
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
-- 
2.44.0.rc0.258.g7320e95886-goog


