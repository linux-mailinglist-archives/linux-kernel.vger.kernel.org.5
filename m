Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285857C636A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377012AbjJLDvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376835AbjJLDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E20A9;
        Wed, 11 Oct 2023 20:51:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c8a1541232so4988625ad.0;
        Wed, 11 Oct 2023 20:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082680; x=1697687480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4sMEvu1pH+3RJOeI6urGWSTCcNMJ6GLwYLy9hdY0TY=;
        b=LYW41OiIeoV2GIz0psGTEaV/x1YQo3THtFP5mHXT6T8PlVmVvUhicWxOaJfcbUp3Dm
         x9spLCmwo731OAKUH0zPXIVTVcIHCxqJwlk1DUPzD20AFPK0lxupmiF0J9vCvxdxAwOi
         fCVqehsNJxCZFm+EHgg/QZq+G8mcjTDAvNMNlBUFO1yEXjiepVr3dketwaGQFHG6RawI
         ZD3m3ZbVV2JiQzZG0cGB/r9Z6XzyeAVZIKMAblszHKj044x8dQkrd7PgXYEUwr3QpqaC
         WjoA7XH6gPSSGhSGt/T47G/0XZbeqaEwCqNzGzr/ieXjDT80ENmu0M4L0GOFMyqQXA90
         drVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082680; x=1697687480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4sMEvu1pH+3RJOeI6urGWSTCcNMJ6GLwYLy9hdY0TY=;
        b=V8w938/6rAp/MlEeiN6sgEs0DINJtW93HQcigUPCktsi9/hab6YGK/yteQp5kPvjrE
         wdjdidEWhl6JFerFpv/1WKX/yCzOO8ufbvrzQr0go4TW+n58+kjG8OXcSkdQCpX5bmDs
         hNsSAjaCla4QB5q45nfTfShk48EDzNM1ggQX6RNM/fy4roYAmuMZO2m+gdFT95cMMdNB
         xHpO92N4xn95WmvLWMUbZpwKFnGorIrzGEH7kaVUIiNJTlCGmwYIJC5jyGAB63iepZAj
         ZuVlWPYT6d6+fS1gtGqNbMhktjOy85et8nFhwesvZh6OzDEW4m0MhunA/j4A/3MHbztu
         /q0g==
X-Gm-Message-State: AOJu0Yxm55eYD6DD4+zlRHD85bbZEwF/s0rii5ZvHZXLgwP//Bz14HOX
        cbmlhLcQvgQRL6d81aIbqUO419ZApTI=
X-Google-Smtp-Source: AGHT+IG2ziFdYY4l2DxOHPyhPyJxsj/pXWB6ID7xRNKie6lBmqraGNqSl49oXXFcwJ9t92eDe3aIRg==
X-Received: by 2002:a17:903:228f:b0:1c7:1fbc:b9e7 with SMTP id b15-20020a170903228f00b001c71fbcb9e7mr27349370plh.43.1697082679910;
        Wed, 11 Oct 2023 20:51:19 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:19 -0700 (PDT)
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
Subject: [PATCH 04/48] perf dwarf-aux: Fix die_get_typename() for void *
Date:   Wed, 11 Oct 2023 20:50:27 -0700
Message-ID: <20231012035111.676789-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
2.42.0.655.g421f12c284-goog

