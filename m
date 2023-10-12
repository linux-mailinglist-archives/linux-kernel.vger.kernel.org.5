Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A747C7748
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442971AbjJLTte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442495AbjJLTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC279D66
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so54899639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140124; x=1697744924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuwbt1McOcGdkIO7L8zjw1pQxOK6ynndpanb3dr/E5o=;
        b=hBdC0aeRhkFt6qFdVdZrUldD0geIWMvkPWvEdY+8+wKvzk/N42lapeJXf0eKEp2Y4/
         cEr5kEJhNxnxnuMImO4IVWgkxnoAzcRK/dZA79XqKNTamzOvYakgr46vzBGcgDHP6eMl
         AqculhA/pZY4di+v+riFCqDf6Drxqn1JjLcXLtLsKDFQEm+fG+yc5louOman+nM9OVC/
         qE9btNapd5dPb0wrtCPvpaYMuDRs6kdZ8b35YqoeirtjrYexClOwmTVSEUq8jFmcMoEX
         427F6gZOCzY4nemT9BQk1cjMAXfmGjER8oFTeBpljQqV4SLMWN6Tk9hFoz7cXI/tAwYJ
         KCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140124; x=1697744924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iuwbt1McOcGdkIO7L8zjw1pQxOK6ynndpanb3dr/E5o=;
        b=QYpzLOKTRB7I/Urex7sXYAv1l/6HzVtEfRTUUV1ElpGTe1v+IGzIQvMeP47X+u8joP
         i/8aJ9aiucEON6S/CIv3s0wcPwl6F5U+S56/gdx/JdEDqaQ4OXgXg9O/t2EBNeNr76p3
         qlaD4jEjm40PAyPF3Xsh5Ls2nhcDfnoV0qnIImB1cM13tfLl6fRqY9uO74fNnrpJ9Rz+
         B/XoNYGf4339a96gWvtJUch2r1PirQPMKFFAvQtX0yjdOh/Jp78BBy7iACSq/6YBVwV8
         ulWH0y7txD0iaRXLSWUFLW8N4nNnqehnvOPyQTaHrlYwZWqqp4F/fBC/7VDMZbpyU1Ri
         YK9Q==
X-Gm-Message-State: AOJu0YxQcBvd4xNNRhmOYgMDPdhYEXFpc32ml0zLHkf8VA5q/sMAdAlc
        iWFHD66aWe4H+aij7t8nv82nFjEKh495lw==
X-Google-Smtp-Source: AGHT+IHlxTW+J6rW7Zd2Pq9sVXFhxqom9NxXG/NPLrr0aum2XInHvnhwAk/EyR/uZTaVq9k5JHvdXg==
X-Received: by 2002:a6b:d81a:0:b0:792:82f8:749d with SMTP id y26-20020a6bd81a000000b0079282f8749dmr30579249iob.10.1697140124637;
        Thu, 12 Oct 2023 12:48:44 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 08/10] dyndbg: drop _ddebug.site member
Date:   Thu, 12 Oct 2023 13:48:32 -0600
Message-ID: <20231012194834.3288085-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194834.3288085-1-jim.cromie@gmail.com>
References: <20231012194834.3288085-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop site ptr, and rely upon the maple-tree intervals loaded by
ddebug_condense_sites().

In DEFINE_DYNAMIC_DEBUG_METADATA_CLS(), which creates a pair of
_ddebug & _ddebug_site structs, add '__used' to the latter, because it
is no longer linked from the former, and then also to the former, so
they both have the same number of entries.  Replace the BUG_ON with a
pr_warn that shows the size of the mismatch.

TODO: sort out where the extra records are coming from.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 5206a2cfdb37..406b30d8eb98 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -27,7 +27,6 @@ struct _ddebug_site {
 };
 
 struct _ddebug {
-	struct _ddebug_site *site;
 	const char *format;
 	unsigned int lineno:18;
 #define CLS_BITS 6
@@ -228,13 +227,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	._filename = __FILE__
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
-	static struct _ddebug_site  __aligned(8)		\
+	static struct _ddebug_site  __used __aligned(8) 	\
 	__section("__dyndbg_sites") name ##_site = {		\
 		DYNAMIC_DEBUG_SITE_INIT(),			\
 	};							\
-	static struct _ddebug  __aligned(8)			\
+	static struct _ddebug  __used __aligned(8)		\
 	__section("__dyndbg") name = {				\
-		.site = &(name ##_site),			\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
-- 
2.41.0

