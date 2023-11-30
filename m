Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64817FFF9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377355AbjK3Xlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377305AbjK3Xle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3710FC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00ac0101d9so222950266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387698; x=1701992498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTN+h/QEMYf7Pops99ws82TYphIJnTeV37hKepwC4Tk=;
        b=jvDShIeY1Nd8NTlM5Eg9KF6YD5ThMjusALez0zU4GsL1V85mf8BTRgCKLvnZw6dR6u
         LZf2uJnP6/pX5kppjth03GmS3+2xRLvE5XCWFQNvg3F8leGLhysxlirX3RBLFjsDoIAm
         yiCoOi1vdbHHzL9X93eAczkVhUoIj/gEssP1VcryQFeEAnGhJZr2QVc7BY5b9H95zYFU
         kzl0G/WuyAO2w1Yl3rIV3UcGxWmmYX9QZyfoa6JN5hr2wN8vnweZnl4/BT3SGrD4ny4+
         AvOJz1q5QBWjWdIKEJIC/2XsK/vU7GnzXq6E1PKUhvPJsaOdn6kRNJiboQXv9bkRFhVU
         0SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387698; x=1701992498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTN+h/QEMYf7Pops99ws82TYphIJnTeV37hKepwC4Tk=;
        b=Pb7VStusSE+IvG5Wqcs9tIq+BlFa9pK2akhTmpeum1dy8PDdzD4kHxiLr2jXNqVlhH
         VRLBMiBToDMveI5SPxHJXe7riwFHqRkMQZcuyGT0ozRoyLWB2dSQiNL1BnjhXs7ibGpi
         Nl9hrquL6bcQfuRkaOBsBXg/3Gp4DEzEHpatUvngu+B954gqoPBqVxkfQtXIb3XCxtV8
         4pyJd0sbjql+z2jhbJGgb/RwQPFjk6FEKa++W7BUlzs3KQ2Vcd9dYTxTI2Y5XpJzKUjQ
         RcuaoEVLSV2pGWa/B1/9lOpwAS0dvtvsPvfthZFLD7/bg54eWWIe+amIb5wZV7CPLbB+
         y3RQ==
X-Gm-Message-State: AOJu0YyVinqClX5z2Un5SEETjaRG9JllORwvfBu+4Zul4NOgTJRdbTzy
        dJ3czBFlplIsSkfoDoZHQo4A
X-Google-Smtp-Source: AGHT+IFElJDryfSuMNqdgKPWut4MGwpnSAjjEYnzzc+i9phHDQLiFjprnGD0CsWityWbOgbsKwaGlQ==
X-Received: by 2002:a17:907:9057:b0:a16:9205:c5b0 with SMTP id az23-20020a170907905700b00a169205c5b0mr177421ejc.56.1701387698397;
        Thu, 30 Nov 2023 15:41:38 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:38 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v2 06/15] dyndbg: use __get_str_strip_nl in prdbg and devdbg
Date:   Fri,  1 Dec 2023 00:40:39 +0100
Message-ID: <20231130234048.157509-7-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Cromie <jim.cromie@gmail.com>

Recently added dyndbg events: prdbg, devdbg have code to strip the
trailing newline, if it's there.  Instead of removing the newline
in TP_fast_assign use __get_str_strip_nl macro in TP_printk. Advantage
of such an approach is that the removal is done on the read side (slow
path). The change removes also passing of debug message length to prdbg
and devdbg events.

This use is slightly premature/overkill, since some pr_debugs do not
have the expected trailing newline.  While those lacks are arguably
bugs, this doesn't fix them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/trace/events/dyndbg.h | 27 +++++++++------------------
 lib/dynamic_debug.c           |  7 +++----
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
index 647c30206a7d..ffd21480cd9d 100644
--- a/include/trace/events/dyndbg.h
+++ b/include/trace/events/dyndbg.h
@@ -15,46 +15,37 @@
 DECLARE_EVENT_CLASS(dyndbg_template,
 
 	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
-		 const char *msg, size_t len),
+		 const char *msg),
 
-	TP_ARGS(desc, dev, msg, len),
+	TP_ARGS(desc, dev, msg),
 
 	TP_STRUCT__entry(
-		__dynamic_array(char, s, len+1)
+		__string(s, msg)
 	    ),
 
 	TP_fast_assign(
-		/*
-		 * Each trace entry is printed in a new line.
-		 * If the msg finishes with '\n', cut it off
-		 * to avoid blank lines in the trace.
-		 */
-		if (len > 0 && (msg[len-1] == '\n'))
-			len -= 1;
-
-		memcpy(__get_str(s), msg, len);
-		__get_str(s)[len] = 0;
+		__assign_str(s, msg);
 	    ),
 
-	TP_printk("%s", __get_str(s))
+	TP_printk("%s", __get_str_strip_nl(s))
 );
 
 /* captures pr_debug() callsites */
 DEFINE_EVENT(dyndbg_template, prdbg,
 
 	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
-		 const char *msg, size_t len),
+		 const char *msg),
 
-	TP_ARGS(desc, dev, msg, len)
+	TP_ARGS(desc, dev, msg)
 );
 
 /* captures dev_dbg() callsites */
 DEFINE_EVENT(dyndbg_template, devdbg,
 
 	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
-		 const char *msg, size_t len),
+		 const char *msg),
 
-	TP_ARGS(desc, dev, msg, len)
+	TP_ARGS(desc, dev, msg)
 );
 
 #endif /* _TRACE_DYNDBG_H */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fcc7c5631b53..9682277f3909 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -886,7 +886,6 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
-	int len;
 
 	preempt_disable_notrace();
 
@@ -900,12 +899,12 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 
 	buf = this_cpu_ptr(ddebug_trace_bufs.bufs) + bufidx;
 
-	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
+	vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
 
 	if (!dev)
-		trace_prdbg(desc, NULL, buf->buf, len);
+		trace_prdbg(desc, NULL, buf->buf);
 	else
-		trace_devdbg(desc, dev, buf->buf, len);
+		trace_devdbg(desc, dev, buf->buf);
 
 out:
 	/* As above. */
-- 
2.43.0.rc2.451.g8631bc7472-goog

