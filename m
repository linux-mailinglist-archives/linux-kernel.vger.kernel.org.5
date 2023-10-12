Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946927C636E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376899AbjJLDwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376992AbjJLDvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D372BD8;
        Wed, 11 Oct 2023 20:51:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859a7d6556so417237a12.0;
        Wed, 11 Oct 2023 20:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082685; x=1697687485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT8z3RMvM5F26FD3Kbo/1bwOpEfsadnhZEpHV6IP5pg=;
        b=EaYaIaiay2u/pclrS1KXWN1dujxHAjVbZRaapLT2tzZsFgsiR4WuS2nnseUMcmY53f
         XEsCK7hDtsGNQNfZL9NSTpA0Jl8GP0jqQSa5AIRaOhztOmhQt16dlOitvwaZ6HYbiVQ0
         Q4belOW36ISdcgFImYgrwysaNImBRpfiLVC+IKlGG3u41CUtKhWDTa9k3jvy1BsaOvvn
         DzQJbk+Xq/LLwrPWTh9D+au8fHMrfdpC/aMN6ujYfA6EKaZN/OQ5lKC9xHtwASY30U6y
         sdQPlaPlu7wzShGLd3HQRd9ZuGW3dXgF6KzKtWF2lZOVOcvHRr7EkbZDAgH2n9lhjZdr
         8I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082685; x=1697687485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aT8z3RMvM5F26FD3Kbo/1bwOpEfsadnhZEpHV6IP5pg=;
        b=mRTwPZ0Gy9gzWkSlNSSs3xy/uqvfX/EYjc37R2I2WENSfjk+9ghBO90X5iXxcxd0DU
         aBLLjSFADxpcyI9iUK6DSStbA3yOtVIXo60Ki6whLNJqYhaYdO2Tg2/9DpGEGy5jzFCT
         wzQO+Q9Q3+ngQP/S6Poyi0V+GpL9Hb/O+C0M58y+ctHFaETo9foo7QHHaVV8/OIrKLtZ
         RmOFqRbEjt+MXHRVTQduLJuntcuXLTGATzE1CgIJ9Xks0l+lk8t6M8Olwl5d+ZXtHFPn
         2isIJ3P9DPDtDK+5vs9jmtmkY134ZcW7Boag8QEqgbPvOlO9/Nkw5Wjl33dke3IpJP4o
         jlZw==
X-Gm-Message-State: AOJu0YxSyFe55VqcZgQvcdjOMGcyERCh6S50gmRPB2i3np63l5wyBIIt
        a7a0H+anJBhw6RTDIFcjKTs6iEx7Rs8=
X-Google-Smtp-Source: AGHT+IG134Ei6UM+lAX7WchV1fDDjuJo11PdahSufKGcv4xgIfpiBosiowsTg7DvvCUjXRSTsk1WWw==
X-Received: by 2002:a05:6a20:72a2:b0:133:bbe0:312f with SMTP id o34-20020a056a2072a200b00133bbe0312fmr28190854pzk.50.1697082685172;
        Wed, 11 Oct 2023 20:51:25 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 08/48] perf dwarf-aux: Factor out __die_get_typename()
Date:   Wed, 11 Oct 2023 20:50:31 -0700
Message-ID: <20231012035111.676789-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __die_get_typename() is to get the name of the given DIE in C-style
type name.  The difference from the die_get_typename() is that it does
not retrieve the DW_AT_type and use the given DIE directly.  This will
be used when users know the type DIE already.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++-----------
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 652e6e7368a2..5bb05c84d249 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1051,32 +1051,28 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 }
 
 /**
- * die_get_typename - Get the name of given variable DIE
- * @vr_die: a variable DIE
+ * __die_get_typename - Get the name of given type DIE
+ * @type: a type DIE
  * @buf: a strbuf for result type name
  *
- * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
+ * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
  * and Return -ENOENT if failed to find type name.
  * Note that the result will stores typedef name if possible, and stores
  * "*(function_type)" if the type is a function pointer.
  */
-int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
+int __die_get_typename(Dwarf_Die *type, struct strbuf *buf)
 {
-	Dwarf_Die type;
 	int tag, ret;
 	const char *tmp = "";
 
-	if (__die_get_real_type(vr_die, &type) == NULL)
-		return -ENOENT;
-
-	tag = dwarf_tag(&type);
+	tag = dwarf_tag(type);
 	if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
 		tmp = "*";
 	else if (tag == DW_TAG_subroutine_type) {
 		/* Function pointer */
 		return strbuf_add(buf, "(function_type)", 15);
 	} else {
-		const char *name = dwarf_diename(&type);
+		const char *name = dwarf_diename(type);
 
 		if (tag == DW_TAG_union_type)
 			tmp = "union ";
@@ -1089,7 +1085,7 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 		/* Write a base name */
 		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
-	ret = die_get_typename(&type, buf);
+	ret = die_get_typename(type, buf);
 	if (ret < 0) {
 		/* void pointer has no type attribute */
 		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
@@ -1100,6 +1096,26 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 	return strbuf_addstr(buf, tmp);
 }
 
+/**
+ * die_get_typename - Get the name of given variable DIE
+ * @vr_die: a variable DIE
+ * @buf: a strbuf for result type name
+ *
+ * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
+ * and Return -ENOENT if failed to find type name.
+ * Note that the result will stores typedef name if possible, and stores
+ * "*(function_type)" if the type is a function pointer.
+ */
+int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
+{
+	Dwarf_Die type;
+
+	if (__die_get_real_type(vr_die, &type) == NULL)
+		return -ENOENT;
+
+	return __die_get_typename(&type, buf);
+}
+
 /**
  * die_get_varname - Get the name and type of given variable DIE
  * @vr_die: a variable DIE
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index b6f430730bd1..574405c57d3b 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -116,6 +116,9 @@ Dwarf_Die *die_find_variable_at(Dwarf_Die *sp_die, const char *name,
 Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 			   Dwarf_Die *die_mem);
 
+/* Get the name of given type DIE */
+int __die_get_typename(Dwarf_Die *type, struct strbuf *buf);
+
 /* Get the name of given variable DIE */
 int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf);
 
-- 
2.42.0.655.g421f12c284-goog

