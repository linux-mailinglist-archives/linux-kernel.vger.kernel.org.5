Return-Path: <linux-kernel+bounces-133695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1389A777
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777551C2131C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571B39856;
	Fri,  5 Apr 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPBzD9Gl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC7381C4;
	Fri,  5 Apr 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357777; cv=none; b=hZX4ODp71yRcIjj2ZcT15Oj6d/ShqFiNu/4xDP4BLremMZ+CkS8KLfq0Uay7lnGE5nDcgy60FpwQXEOdTyh0C1t47hzbqFwRw+ocGzlJLiiHiDuWvde5KJni9t7RymTTj+1k8v6K3db9JBYYTk9QqQJ2ab+lKpfCZwjt6lIOGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357777; c=relaxed/simple;
	bh=NDgit/zD/XsJmhpf2nWroZgulljOwKs7JeTqVXmjuok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McSXFBKCrQ/yuB7z4S2r6jxsOq1MKFVl7l5Wsyjq0VvNEJb6fahhV9rSzqWWBwhZroSJdaBfKpwulRXnaRR4l/QoggEox/ocpHqfmZwIHru1UpSwXHirxI33SNorAbsRm3bkUmKphvCXAjJbSSpwoUcYHgSsxfG/lR+z5a8aWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPBzD9Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BC3C433F1;
	Fri,  5 Apr 2024 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712357777;
	bh=NDgit/zD/XsJmhpf2nWroZgulljOwKs7JeTqVXmjuok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rPBzD9GlHEBvrwRwAJDdNaqgQ2+KSdSNETW0L4RPTvH7EbhEd9IA1U5Ak6jd3E/K6
	 Q9ezCJBaJCnmlf3jV8KI1+VJMJ0Q9JNmh8YjJg4Iugnb/0okphaXPUDiYEP1bf6UI3
	 LHy1bTEypUi2g2KDbdWQlTgTEw5mLO7v4gVwojyIxUlrILm5zrCGlPxrCdCzopmSfr
	 watGoex8RFE+EQeNmSksg0RE9+FB1i+1ptTG6MhO16hTF5OD6y0r2lE4a9IXzh3frw
	 A7kMq81ON5nFWQW53bU4aeJaKers89SlCO3O4o5BvapMFP499qRWb2Y4dQpD8CUH8O
	 3eboWiuj59shw==
From: Rob Herring <robh@kernel.org>
Date: Fri, 05 Apr 2024 17:56:02 -0500
Subject: [PATCH v2 2/3] dt-bindings: kbuild: Split targets out to separate
 rules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-dt-kbuild-rework-v2-2-3a035caee357@kernel.org>
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
In-Reply-To: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

Masahiro pointed out the use of if_changed_rule is incorrect and command
line changes are not correctly accounted for.

To fix this, split up the DT binding validation target,
dt_binding_check, into multiple rules for each step: yamllint, schema
validtion with meta-schema, and building the processed schema.

One change in behavior is the yamllint or schema validation will be
re-run again when there are warnings present.

Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/all/20220817152027.16928-1-masahiroy@kernel.org/
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Separated rework of build rules to fix if_changed_rule usage from
   addition of top-level build rules.
---
 Documentation/devicetree/bindings/Makefile | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 95f1436ebcd0..3779405269ab 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -37,11 +37,13 @@ CHK_DT_EXAMPLES := $(patsubst $(srctree)/%.yaml,%.example.dtb, $(shell $(find_cm
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs -n200 -P$$(nproc) \
-		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
+		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) \
+		     && touch $@ || true
 
-quiet_cmd_chk_bindings = CHKDT   $@
+quiet_cmd_chk_bindings = CHKDT   $(src)
       cmd_chk_bindings = ($(find_cmd) | \
-                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
+			  xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) \
+			  && touch $@ || true
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
@@ -49,12 +51,6 @@ quiet_cmd_mk_schema = SCHEMA  $@
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
-define rule_chkdt
-	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-	$(call cmd,chk_bindings)
-	$(call cmd,mk_schema)
-endef
-
 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
 
 override DTC_FLAGS := \
@@ -64,8 +60,15 @@ override DTC_FLAGS := \
 	-Wno-unique_unit_address \
 	-Wunique_unit_address_if_enabled
 
-$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
-	$(call if_changed_rule,chkdt)
+$(obj)/processed-schema.json: $(DT_DOCS) check_dtschema_version FORCE
+	$(call if_changed,mk_schema)
+
+always-$(CHECK_DT_BINDING) += .dt-binding.checked .yamllint.checked
+$(obj)/.yamllint.checked: $(DT_DOCS) $(src)/.yamllint FORCE
+	$(if $(DT_SCHEMA_LINT),$(call if_changed,yamllint),)
+
+$(obj)/.dt-binding.checked: $(DT_DOCS) FORCE
+	$(call if_changed,chk_bindings)
 
 always-y += processed-schema.json
 always-$(CHECK_DT_BINDING) += $(patsubst $(obj)/%,%, $(CHK_DT_EXAMPLES))

-- 
2.43.0


