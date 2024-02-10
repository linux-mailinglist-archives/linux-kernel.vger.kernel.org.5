Return-Path: <linux-kernel+bounces-60600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBB850769
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CE11F217EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774F61691;
	Sat, 10 Feb 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CPIYffui"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6C612EE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609061; cv=none; b=WlJjYXNwHQ5W2orhEPZ3FT22FWNrKBHGq5ggegtq9je7h4Xj6WpIvWfcaoCzHt2fOA0uT4LofAIC8WM7iQTNS2OaiziYnieeYVUyELYCMrStgh9PFGzPtBWxRpofmqDe3Atfe1O8vUIgNiVUPKTTfC1O1B6qZbUMfPiKMN+K6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609061; c=relaxed/simple;
	bh=xaGmcsjd+lkOWUksrw9hG2GtCYA1l7WNpGBbOaK1l7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIuQW5U7xOIRYjA6wM5h34zUGDTAQJ1x4u3UMMZU1oo0CzK2o7pzQ2YzB8h4yRj8p8nScQdhC+6aU0ZXkJSwlPwjM5M3LMY5l2r21mJ6EAQORtLx0af3bDAS3afOR5qud1DHQhOU2xEs7STKPwcaqySbfSuLXzKsN7MmxZqggdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CPIYffui; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso2840942e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609057; x=1708213857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcUhkZrXlF5pRwcMyaOQX2HOmfuyNRPW8LUolF8mADY=;
        b=CPIYffuiExah5o8/w1W4dH7kwyrLP8oCPHOTmz9hHRvAwYKIA12VgqBo5F7CBC5AHC
         1xKmAuRwCTsFPGDgIsWFyU3NzYfCMhA0ortwVZdcTkb8Hc02fIH3I6XU0DqEcJaE/l2i
         Vo/4NhwNW0g2/bwKTKKaafMLja2804uFWFGAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609057; x=1708213857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcUhkZrXlF5pRwcMyaOQX2HOmfuyNRPW8LUolF8mADY=;
        b=V48JXzB0tsjfIej67/ES25qaGLMzyHAXh0Uy6OmLWCFOtQTfNjsdpTw0z8dkTMwvd/
         faxsPgC55PRcBmIhbOfeYVxlFleLx9I5gB3MZ9BtHAeK21s7DsY/vIEkfJx3wsuWaFGd
         0m7t2fI9IlIBj2pydDfeHqrFiN085K2NSlqxckyhasdKLOQ5t7TH3GjVfPqtsv8r4uMr
         mVVQypyV8QIqjHR71ypeV5bauEPbCMcJ6DlDcGTX8VC2k+cWx5Z8coBj7EHXhnZCeMzK
         +jr66s/TydiM+rOkaqqbq+X4cscCO4hiripAxMxkT4fyBWvpm0f7m4gKMvfs53YxdwR5
         6/9A==
X-Gm-Message-State: AOJu0YzBTjNFSYRs/cRoeGXyK3Mbf2v+Hf1VgUjayoAift/8ZtVUIUV+
	VLesPtpCuKcQUIg+buduXk0YKLEwIZE3DmYkFkNI5pLAccVI2nI3tByDKuBRzCnupM24f3aRZQ=
	=
X-Google-Smtp-Source: AGHT+IEEgUtwreiAHXmoffnO7ggXYeIeG7rVYrB+JsapB5c9FhMRT5KMg9cDtA/txb+RAWnZtYy9OA==
X-Received: by 2002:ac2:5eda:0:b0:511:55fb:2405 with SMTP id d26-20020ac25eda000000b0051155fb2405mr1659223lfq.50.1707609057566;
        Sat, 10 Feb 2024 15:50:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMvMLuG7XWucjAH59S42BW92allZjpZHUiTZ04ZDytLeYM3qAkBnJsfwWB+mu9HTVVqkcciJ2PvdqAXL+Lw/CxLX016E2mfnFbGVXnY4elEdNKDkGpNxiUOYCSisgKf1x8g/1rvNOyPKkE7awdV/V2tNXIMG2+eX+vwEd0vj0I++44WalYTfoi/iz01iuR1a0rZc+lwoApvUQa1jeTb1+/LkdZtduzXmRkb0QP59tdOhrsYomvHmv8c1bwMsUTMrUWncRoVJiOLiQnvCIc/qA+VLmZ6SgoTbTSFzwVizQOyAQfL2y9lQp6EPli4UFC3Ij3o16Rw8+VofwvhZ+om7zvHg3Rg1sqrIHuXqKOzECasCWmLw56VaIkVsECEHXf2qNT4UfbAA2qgpA49xvATtvbzfeiMVoqfWFLEv3R7aiZBEs7BOWbzmOFFmklDvv7MGT8wmtLB+RZmmUpnMPYKMdjk82ZwKMCDAC0ZabHDlsdJcMq/Dv3jwUWxKyAWB2L0NbjC0Xhz7u09oheM4IgOzkEQCrUAACCyBEnNg9MmNx3rSju6D8riT7ffwLW2W1cxlSEwquJ5ugc8Ok5p9QiHTL9IdBfRru3ucbuEaCUhbERMoJCog==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:57 -0800 (PST)
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
Subject: [PATCH v4 17/39] dyndbg: add support for hex_dump output to trace
Date: Sun, 11 Feb 2024 00:49:47 +0100
Message-ID: <20240210235009.2405808-18-ukaszb@chromium.org>
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

Add support for writing hex_dump debug logs to trace.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Co-developed-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 16 ++++++++++------
 lib/dynamic_debug.c           | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dc10c7535f13..76eec3f05be9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -298,12 +298,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	_dynamic_func_call(fmt, __dynamic_ibdev_dbg,		\
 			   dev, fmt, ##__VA_ARGS__)
 
-#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
-			 groupsize, buf, len, ascii)			\
-	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
-				   print_hex_dump,			\
-				   KERN_DEBUG, prefix_str, prefix_type,	\
-				   rowsize, groupsize, buf, len, ascii)
+void _print_hex_dump(struct _ddebug *descriptor, const char *level,
+		     const char *prefix_str, int prefix_type, int rowsize,
+		     int groupsize, const void *buf, size_t len, bool ascii);
+
+#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,				\
+			 groupsize, buf, len, ascii)					\
+	_dynamic_func_call(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump",	\
+			   _print_hex_dump,						\
+			   KERN_DEBUG, prefix_str, prefix_type,				\
+			   rowsize, groupsize, buf, len, ascii)
 
 /* for test only, generally expect drm.debug style macro wrappers */
 #define __pr_debug_cls(cls, fmt, ...) do {			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d379e05837be..dbae1ed6ab5b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1377,6 +1377,42 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 	}
 }
 
+void _print_hex_dump(struct _ddebug *descriptor, const char *level,
+		     const char *prefix_str, int prefix_type, int rowsize,
+		     int groupsize, const void *buf, size_t len, bool ascii)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				   linebuf, sizeof(linebuf), ascii);
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			ddebug_printk(descriptor, KERN_DEBUG "%s%s%p: %s\n",
+				      level, prefix_str, ptr + i, linebuf);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			ddebug_printk(descriptor, KERN_DEBUG "%s%s%.8x: %s\n",
+				      level, prefix_str, i, linebuf);
+			break;
+		default:
+			ddebug_printk(descriptor, KERN_DEBUG "%s%s%s\n",
+				      level, prefix_str, linebuf);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(_print_hex_dump);
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.43.0.687.g38aa6559b0-goog


