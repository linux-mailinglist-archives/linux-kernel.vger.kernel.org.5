Return-Path: <linux-kernel+bounces-60588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF485075D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3DD1F21A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC1605A2;
	Sat, 10 Feb 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4WEghAA"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5134604BA
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609041; cv=none; b=LSKijHIvSL9sRHxA3yRfCHVeVgKOOnXrDnROU2QSzMFo1qzDFJjLWFi8qz1UFI6hE7iCLqBmFZFauczpUjoxdJBLyiVyTknHOSCdSftTM71pGLpSZKik5rM2yT4w2Zjdel2ESLiqc7k/bc+MthUmKJha5nZ0DRTnOcH8KOpdEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609041; c=relaxed/simple;
	bh=CEm2u5oLoANuCFcHRqanlvBhrRP8jePFysyGpg9GOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAN72GXPh8p4wXJO/tCId7gaUUSkdDXY5m1+yEETYsZ0+vhIwbji5xmDIEEqwXG1GsyhAJq7mC5mvoDdU70JN63Ac+SoG/+M+Cb2e0ECH42jr5enc6xhFCpHNiko3OQ7ancyYGVBuY4L89WUajxj4/OTcgLBGdYF4Ax1DAD2cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y4WEghAA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so27700721fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609038; x=1708213838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJESVK7kHt1+7K3a2iTQplxRuP50hVTmiKkfD52o08Q=;
        b=Y4WEghAAak9V/nq8V6yn3g7oTyKN08K8z0dIfkXqNLLvBcvGFXfcT/sj/sNZPEfXLM
         XB++GTxyxfozCOZDd/c015p6Vd2RnGxpP8iIleU7PRsZVDuMOxjtjYNP0TVL61GFwc9F
         2szYnYg353BjDU/jlik+iFQCO/Qmh+t0IGbp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609038; x=1708213838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJESVK7kHt1+7K3a2iTQplxRuP50hVTmiKkfD52o08Q=;
        b=sYO8YYmm5iP7xjJb62eDdgNXsrwGAzlTxWQSIAmkQLfqy7140iP30jg2Db4Uz3N7F2
         38pEc80t24wlI272AF7J91T5lzQZHEjQ9o/mqsRIaTz4+0wvnzlDy6S/csCpTOmx9IaR
         4Q8aBrcWAnTQnd6vUXNys747qsuhgX8vpZOyMkp8idgo9PDO26dX+LD7V7L+3A8ub4nv
         ptwtp9sye0FHly7Yak9U1H/ZIY8NfuaPIYjtm4AN7FVYRgRV87y0pwzwXv9PFrlDsD7t
         rCJ5kSVI9naHmLi3nTbqHZLjTDOykTrwoBoIUE2v6nfT7Eq4JHRdGni76PeWNQRf2t0C
         SaGA==
X-Gm-Message-State: AOJu0YzayMRy9glTYTFXLHQ91pOZqdLfElp/U3vQ6mtVnQs4nonyamnj
	9GRPsi5ZC3HpBxbJkv3VX7ewNCtXqle2PLf38XHkZ3SSEofdd5j1Tojb+w0f
X-Google-Smtp-Source: AGHT+IHVR2xbmhJIxxY6EebfRkEZJFRJQ1zAxth2B3VxmSkD8iDu7C8RlPSLS3itHWUFm8nicKC4zw==
X-Received: by 2002:a19:5209:0:b0:511:79ce:f325 with SMTP id m9-20020a195209000000b0051179cef325mr1576643lfb.31.1707609037846;
        Sat, 10 Feb 2024 15:50:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnU0vsLxtkUbNcbT7Arujl/3sW/7tv/nm0MPyXW+L7RPEIemfAuiboHfYHpEovp6knESiGxQUDU7oHl8LWX9pfg+l7apXoAhYfShXHF8Css4OirBKnTd45MkuwevTRvvYnhagwTL352TxZSsevQINxiKhl/RiYLxg3EKRfZ7hPhvPBmccMe4UaF9Bbfdqk08mZAooteiCTjxLnBAF+WEq1XObEZnP3IUxdxOpfIifIz3Pem0rup4v8FtNPxQEOqeaoLIYfR3ikAJP9osWhkzcvtqyWEq/MqwA3rcbP8VA7McIrEzPdC7jfnVK72jCYbgETxgAoC+h3RMDNj9lq8HyDduu0RwMvf58pqmBKHrWgoIvg7FbWEaXvfvB3OdwnJxVo4LlT7m1+p0PFFE7kKrfV0of7lofCYt5a84Otgo7Rq+vVFgNxVz1KBCDWWzzlO32YYmS9GFZgkA5G0MNsEd9AqLTXnuZgbpUal3ZcchxxOvqlkWk5Xg9akEHpNOvm+wHu05y95HpNsuX3NfHR9k4K+BtTlkrmneNQiJH5oKfR39i0WDGK6ufjp3rVZW+G1raw5f79vk/39tiYr7gSaiWsmkvlKlMwJ+QmHuP9nV5e/2fA5w==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:37 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 05/39] tracefs: add __get_str_strip_nl
Date: Sun, 11 Feb 2024 00:49:35 +0100
Message-ID: <20240210235009.2405808-6-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

This variant of __get_str() removes the trailing newline. It is for
use by printk/debug-ish events which already have a trailing newline.
It is here to support [1] which taught dyndbg to send pr_debug() msgs
to tracefs, via -T flag. It "reused" the include/trace/events/printk.h
console event, which does the following:

       TP_fast_assign(
               /*
                * Each trace entry is printed in a new line.
                * If the msg finishes with '\n', cut it off
                * to avoid blank lines in the trace.
                */
               if (len > 0 && (msg[len-1] == '\n'))
                       len -= 1;

               memcpy(__get_str(s), msg, len);
               __get_str(s)[len] = 0;
	),

We can avoid trimming the last \n during write into the tracebuf, by
instead stripping it when reading the tracebuf.  So do that.

[1] https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com

Cc: <rostedt@goodmis.org>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: <daniel@ffwll.ch>
Cc: <pmladek@suse.com>
Cc: <sergey.senozhatsky@gmail.com>
Cc: <john.ogness@linutronix.de>
Cc: Simon Ser <contact@emersion.fr>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 include/trace/stages/stage3_trace_output.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..283533a17e62 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -19,6 +19,19 @@
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_str_strip_nl
+#define __get_str_strip_nl(field)                                       \
+	({                                                              \
+		char *s = trace_seq_buffer_ptr(p);                      \
+		size_t len;                                             \
+		trace_seq_printf(p, "%s", __get_str(field));            \
+		trace_seq_putc(p, '\0');                                \
+		len = strlen(s);                                        \
+		if (len && s[len-1] == '\n')                            \
+			s[len-1] = '\0';                                \
+		s;                                                      \
+	})
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)					\
 		((void *)__entry + 					\
-- 
2.43.0.687.g38aa6559b0-goog


