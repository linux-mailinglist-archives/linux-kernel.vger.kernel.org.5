Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95D97DDA41
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377116AbjKAA1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377024AbjKAA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:27:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDA186;
        Tue, 31 Oct 2023 17:26:46 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-359381980f7so3536385ab.2;
        Tue, 31 Oct 2023 17:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798405; x=1699403205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEqBwr5bmlsUliJRNMs53J4oxL88HwMAGezbxgrXL5M=;
        b=hqSMN7WPTyq3WRIjqyv+yVNSFuG2TOLbbdjpHSeNcQdWjUC1wexT1CdXVck7Cv48ih
         llidVDMtZ32E4/qZmfY4Y8wWMPBAcc7q9nP+OMltzRSQsncJdxux3fUgXjyo9K5FYSHB
         ZLA+72t7SbBXKgpjqVBIZfegPnkrhpSVh2nwUB4KRyy9SGqQysUwJ+uhrnzMto/1YX0Z
         EOFbXzbt1t9q91ik003LpX5HXzH9fbTh2ZTAL9on8WS76mJjncs8hdUVrH1lhKpeagbj
         r7YW1KZVnbpfIRDO38KbPxl4iNQx3M2M6OWjj09EcseRd4yx+2W8OfuHz+IJ2DLeMmNR
         t4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798405; x=1699403205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEqBwr5bmlsUliJRNMs53J4oxL88HwMAGezbxgrXL5M=;
        b=h5P4+LmfC4Fuv5hvJ8y790xUSUeqZzXbjJiNSIry6SBY2tbL/98NAuioTVu1j9PruA
         A9X/c8htPYlwO403+8URGr2pdICvIJYKlNsTZHwTG99E0II0AsKNYZGIjzToPbcrVukC
         EcgRY9MGd543yxoT5nMhufN/en1WY5HT3bV7PkPZLmkYw1rVa04FFEtS9O0ZLkLtnZms
         g8Pl6iXI2Jy7cYYBkevoOm9tgNu7ALkt0AAKTj/AxGKKi5tYDkmqYhadAdHJ8TAHesgE
         4Z1vudqu7UIAAXTBHC+UlwTdOsm+ZH9PRzdKQoQeR8kXhXS148ObVoKCG+1E5VkvZl3O
         Rb8g==
X-Gm-Message-State: AOJu0YwHtGKDnvVcbiYR1tI3yud9Myanxrst75A48uRQZin4uNHXYwJP
        VO8RZ7vHxu/2+U7s9yDU9Jihf12LoHyZcw==
X-Google-Smtp-Source: AGHT+IGkWEhH/sTMgZAoCvqDsHJ9MiwzmTfgqH8FCsVszlSzvBBjofFDFFpQzS5/UrGCR45izJ6Y7g==
X-Received: by 2002:a05:6e02:1ba1:b0:357:a08b:566d with SMTP id n1-20020a056e021ba100b00357a08b566dmr19451120ili.29.1698798405690;
        Tue, 31 Oct 2023 17:26:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v7d 20/23] dyndbg: refactor *dynamic_emit_prefix
Date:   Tue, 31 Oct 2023 18:26:06 -0600
Message-ID: <20231101002609.3533731-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101002609.3533731-1-jim.cromie@gmail.com>
References: <20231101002609.3533731-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the split of duties between outer & inner fns.

The outer fn was previously just an inline unlikely forward to inner,
which did all the work.

Now, outer handles +t and +l flags itself, and calls inner only when
_DPRINTK_FLAGS_INCL_LOOKUP is needed.

No functional change.

But it does make the results of the inner-fn more cache-friendly
(fewer entries, reused more often):

1- no spurious [TID] or <intr> noise
2- no LINE-number to bloat the cache (avg 9 pr_debugs/fn)
3- only LOOKUP stuff

Currently LOOKUPs are descriptor-field refs but could be replaced by
accessor functions.  This would allow the __dyndbg_sites section to be
de-duplicated and reclaimed; currently module, filename fields are
~90% repeated.  As the accessors get more expensive, the value of
caching part of the prefix goes up.

Also change inner-fn to return count of extra chars written to the
buffer, and drop "inline" from outer, let the compiler decide.  Maybe
also change name accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
fixup whitespace
---
 lib/dynamic_debug.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f878a6f09fc8..213110ec1e9c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -774,11 +774,28 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static int __dynamic_emit_prefix(const struct _ddebug *desc, char *buf, int pos)
+{
+	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+		pos += snprintf(buf + pos, remaining(pos), "%s:",
+				desc->modname);
+	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+		pos += snprintf(buf + pos, remaining(pos), "%s:",
+				desc->function);
+	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
+		pos += snprintf(buf + pos, remaining(pos), "%s:",
+				trim_prefix(desc->filename));
+	return pos;
+}
+
+static char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
 
+	if (likely(!(desc->flags & _DPRINTK_FLAGS_INCL_ANY)))
+		return buf;
+
 	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
@@ -787,15 +804,10 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				trim_prefix(desc->filename));
+
+	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_LOOKUP))
+		pos += __dynamic_emit_prefix(desc, buf, pos);
+
 	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
@@ -807,13 +819,6 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	return buf;
 }
 
-static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
-{
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
-		return __dynamic_emit_prefix(desc, buf);
-	return buf;
-}
-
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.41.0

