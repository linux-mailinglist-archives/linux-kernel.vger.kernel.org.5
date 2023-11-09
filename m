Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEA7E756A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbjKJAAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjKJAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4544BE;
        Thu,  9 Nov 2023 16:00:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso1299554a91.1;
        Thu, 09 Nov 2023 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574422; x=1700179222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFMOX8SX01fXKILUSbNGFFOegaedr50GlhEgN7HfJ3c=;
        b=CbLFzvPC358cS0wOpDSrPGATDH0xnqTgZD0dqsUDQcOfBytmiDL3raJOWTRUicod6X
         wHXzk4NuiM6GcCK0clPzu1SlkG9oBJC2uU2VyA2Av0SCs20VUpwRn0PsdxgfOmJcwhMX
         Hy4sGGo1FRdoS2hcbnfLAYNh7kOiVuV0dE1+2rWb/AirRrud7TtxZFJl/W9czdrSo+qU
         zfW/B1WQ2cNe7ykTb3SKrAx8GYadAMvQX4rbU9Ua+LBlTGsVj+RkVwdmAXhnW/2I4tbP
         H6GxQ+oFJOGr/i8FTkIhnhCgSGnbbBKNCnzPRtgQ8vSLwO3tEYHh0j+61Q620hlGxmut
         G11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574422; x=1700179222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFMOX8SX01fXKILUSbNGFFOegaedr50GlhEgN7HfJ3c=;
        b=f7iO/DpGZppY8pXBqHJ84jmT2CH1Eco5OznaId5G8jIogTIyN5kAFmmEXqtceDp8+z
         UmLV8/pYOZ4/QGwjdGM7tGI4MQMIMGYmBKorWDf5iomyGypxEkhG1NslQgs4lskPpnwq
         YiTb8LCUAkohWx8CHaKGyIS6WFDXQbZ+B93GeFA/XjufAiTIpzNQobFzWn9v1FW1Crkr
         eOye93utTxw5GIGbjZpoR/+3ZewG9h+tW9VIF2Vp37dJi5Dqao28phStJE18g42R+pWE
         9xOMyJ34saxxlW6LQHLCe4B17RF566MjrPO599NAvFQNKQnh9adFn1Y0Iu96qWVgeH22
         xc6A==
X-Gm-Message-State: AOJu0YxVEsgW+mMGEhdmYkSoU86vnSsMK5KAEaGa26k6BlRhafUOUGPA
        K2u4vAdmlI5RbKUO5CIYRqA=
X-Google-Smtp-Source: AGHT+IGSNjWc3MbyvDO+qDwwjc7N06wOn2WivEP4MkJBt3rpiL3aUf/iaPdEzzYU/Ta+kPiT01PkDQ==
X-Received: by 2002:a17:90a:e7c7:b0:281:3fb:6df1 with SMTP id kb7-20020a17090ae7c700b0028103fb6df1mr3301226pjb.46.1699574422245;
        Thu, 09 Nov 2023 16:00:22 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:21 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 04/52] perf dwarf-aux: Fix die_get_typename() for void *
Date:   Thu,  9 Nov 2023 15:59:23 -0800
Message-ID: <20231110000012.3538610-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_get_typename() is to return a C-like type name from DWARF debug
entry and it follows data type if the target entry is a pointer type.
But I found void pointers don't have the type attribte to follow and
then the function returns an error for that case.  This results in a
broken type string for void pointer types.

For example, the following type entries are pointer types.

 <1><48c>: Abbrev Number: 4 (DW_TAG_pointer_type)
    <48d>   DW_AT_byte_size   : 8
    <48d>   DW_AT_type        : <0x481>
 <1><491>: Abbrev Number: 211 (DW_TAG_pointer_type)
    <493>   DW_AT_byte_size   : 8
 <1><494>: Abbrev Number: 4 (DW_TAG_pointer_type)
    <495>   DW_AT_byte_size   : 8
    <495>   DW_AT_type        : <0x49e>

The first one at offset 48c and the third one at offset 494 have type
information.  Then they are pointer types for the referenced types.
But the second one at offset 491 doesn't have the type attribute.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 2941d88f2199..4849c3bbfd95 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1090,7 +1090,14 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
 	ret = die_get_typename(&type, buf);
-	return ret ? ret : strbuf_addstr(buf, tmp);
+	if (ret < 0) {
+		/* void pointer has no type attribute */
+		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
+			return strbuf_addf(buf, "void*");
+
+		return ret;
+	}
+	return strbuf_addstr(buf, tmp);
 }
 
 /**
-- 
2.42.0.869.gea05f2083d-goog

