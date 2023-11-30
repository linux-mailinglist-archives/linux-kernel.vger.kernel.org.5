Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01C7FFFA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377345AbjK3XmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377303AbjK3XmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:42:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD81BE7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so215747866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387716; x=1701992516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzVtATo7qejOLEB4sJXRSm13xDxtkLHgydWT8VzDoHc=;
        b=ueInL2FUUEfz1oq4Yg9M5U7h/fVM/pA3nFnhAfjuZv5HfmgWkP75NJa1SlwTR0nbMZ
         lDBi3OoEJgzFPIhnZsQBr82hRf0IMKok9SJwL0qzRJYpPuIeOyAWZlhs4UH8dMcsoEsw
         6Ngs5fbl3XxPxiCj9jBsZGxyAKpNz9rQZDTDkkKsab/HvengCWVD6HNOLPLShVsYEMXX
         UG4tw8LjfxhXdl0CP6k1O5yEyslUjqx2Ds8HPquDJ8hUkysxoIU7qA7nSxH7sXyjr6Yo
         p3tX7QPL6XK66L1XCSuq4mKDDNC09F6xUQurjzH648SKKZUOp7R9hjLCDG/51bcAcPMo
         ztFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387716; x=1701992516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzVtATo7qejOLEB4sJXRSm13xDxtkLHgydWT8VzDoHc=;
        b=aFnkNvdjb0/Ke3mVXYAcmyoNNsR0yw/J/oQUkrvz8iYZbZq8sntK9/Hzt2cmwC3Hlc
         41HCvHorxvfae2iIgK48Qae7Phr7J4Xe5beX4h4Ng2lmG+fjvsIdhdK3TdIZd40w0I7s
         uG4bxcWkrz6YTJFR+2mt52vhwVaddm/GM99dTJdOuE1zNfYEnhWgwMLY7FkWR2pSQpr5
         hlkVSvkX8ynsdwcEWpNn1Jmvt5cT6USGMRFMIFKVIEe6EnABoCT8bsIkd0NL/IqJZlnr
         NWvn5FbNwyl1Cv4SM8p2ofgxfbo8BsfvqGOm/I2GOXzkRLxJzWg8iKVPeeAdJYUaL04X
         KIdw==
X-Gm-Message-State: AOJu0Yz0YMIFpX2ERJAVp0jUiwUFk4rsxhKFbu8gY5HRlJpF4GnY2n7b
        XTTk4DuSQps+Ow6JguKqs36Q
X-Google-Smtp-Source: AGHT+IF5ZpkMrM65f7DBXsUb6p5WzD9ekOc1bpk9Ey9ZaqoJx+OHB0eG3fr1rrLhe4JUc0uNAU63RQ==
X-Received: by 2002:a17:907:511:b0:a19:a19b:4268 with SMTP id wj17-20020a170907051100b00a19a19b4268mr121632ejb.211.1701387716688;
        Thu, 30 Nov 2023 15:41:56 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:56 -0800 (PST)
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
Subject: [PATCH v2 11/15] dyndbg: don't close trace instance when in use
Date:   Fri,  1 Dec 2023 00:40:44 +0100
Message-ID: <20231130234048.157509-12-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow trace instance to be closed when it
is still being used by at least one callsite.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h |  3 ++-
 lib/dynamic_debug.c           | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 56f152e75604..5555857d9ba5 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -186,7 +186,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.filename = __FILE__,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
-		.ctrl = { .flags = _DPRINTK_FLAGS_DEFAULT },	\
+		.ctrl = { .flags = _DPRINTK_FLAGS_DEFAULT,	\
+			  .trace_dst = TRACE_DST_MAX },		\
 		.class_id = cls,				\
 		_DPRINTK_KEY_INIT				\
 	};							\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 43e94023a4eb..73b6818e5fab 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -81,6 +81,7 @@ struct flag_settings {
 struct ddebug_trace_inst {
 	const char *name;
 	struct trace_array *arr;
+	int use_cnt;
 };
 
 /*
@@ -274,6 +275,7 @@ static int handle_tr_opend_cmd(const char *arg)
 		goto end;
 	}
 
+	inst->use_cnt = 0;
 	set_bit(idx, tr.bmap);
 	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
 end:
@@ -296,6 +298,14 @@ static int handle_tr_close_cmd(const char *arg)
 
 	inst = &tr.inst[idx];
 
+	WARN_ON(inst->use_cnt < 0);
+	if (inst->use_cnt) {
+		pr_err("trace instance is being used name=%s, use_cnt=%d\n",
+		       inst->name, inst->use_cnt);
+		ret = -EBUSY;
+		goto end;
+	}
+
 	trace_array_put(inst->arr);
 	/*
 	 * don't destroy trace instance but let user do it manually
@@ -316,6 +326,26 @@ static int handle_tr_close_cmd(const char *arg)
 	return ret;
 }
 
+static
+void update_tr_dst(const struct _ddebug *desc, const struct dd_ctrl *nctrl)
+{
+	int oflags = get_flags(desc), odst = get_trace_dst(desc);
+	int nflags = nctrl->flags, ndst = nctrl->trace_dst;
+
+	if (oflags & _DPRINTK_FLAGS_TRACE &&
+	    nflags & _DPRINTK_FLAGS_TRACE &&
+	    odst == ndst)
+		return;
+
+	if (oflags & _DPRINTK_FLAGS_TRACE &&
+	    odst != TRACE_DST_MAX)
+		tr.inst[odst].use_cnt--;
+
+	if (nflags & _DPRINTK_FLAGS_TRACE &&
+	    ndst != TRACE_DST_MAX)
+		tr.inst[ndst].use_cnt++;
+}
+
 static int ddebug_parse_cmd(char *words[], int nwords)
 {
 	int ret;
@@ -447,6 +477,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(get_flags(dp), &fbuf),
 				  ddebug_describe_flags(nctrl.flags, &nbuf));
+			update_tr_dst(dp, &nctrl);
 			set_ctrl(dp, &nctrl);
 		}
 	}
-- 
2.43.0.rc2.451.g8631bc7472-goog

