Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47E7C7734
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442736AbjJLTr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442560AbjJLTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338CF0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fb78e297bso55716139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140049; x=1697744849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuwbt1McOcGdkIO7L8zjw1pQxOK6ynndpanb3dr/E5o=;
        b=MjsHGH0KcyHM9yh2BwpUgxQi3Vfa9WG/ty5Ea8lSq9yzqZNw5xDk/9ki9K87No8ZUG
         qG5MeKsDVy8jr2bZhF+76xcP9ksw7qg+qlgoChDneDxrJsUpE3XMwDwzBcHLEc1aVblp
         CvWFXpS8sowf7TYLE9jisRDmyNh1r4suBfBif4cro/xrrM24BxdcRFAIi5eXiKoffSDD
         fuY9xeV9X7nOFbkqCKiOsdds6PpP9pkQfnc2y3aREwa5w9RgR0085iRjkrG39bb0PbTs
         9GK2F2HVSy1eUP6TfGKPg7kG2BbSQgQ10gxqjj5HwogNZOxB8jg+Bv9viI60tkpMTxbT
         hq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140049; x=1697744849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iuwbt1McOcGdkIO7L8zjw1pQxOK6ynndpanb3dr/E5o=;
        b=cNtCen140xha191ucEXIkKhzIs6t02fb8JiBwWLcG/si3tpY9EW+k2aO4ooIrAGbD5
         ZfOoHFm3JW7GPK9x30mTqdKiwKLamtNBUzbqLLzdVwQaKbMiQ2NcURS/rrRIfH0xm1MS
         HrxsmXUVPu/e+xfye6QqtgJSmcTyx0e64V2RQ3T89DHfWK2trc1ngtrdgjyW402EjMqa
         CRmf6JfIVY3KWtmFuHHF/HEpcsGOOGJVRTGZ/dzFq52R1Q58B3gmAxQCDlpmhl97EUyj
         NYpQldUS7jfV+q/HkTE+c/rsXExzTxCsSv8Mi7pbQSFfkgcyFSjS88YuQE4sH78YgtZA
         Wlqg==
X-Gm-Message-State: AOJu0YzmLm0mmlnuet2asyoBbW1cmVbWBNBd7LbryFq9c3BgzF1xZVm7
        pRaw566PjZJKnDvvwIAo68tT//RlsOW8Vw==
X-Google-Smtp-Source: AGHT+IHCeodG2zR7qXJvGMWnDUytuto++Y0+52RDtBpPMwO267PxqNwztcmT278yMiBWKoD4h72RcA==
X-Received: by 2002:a6b:ea15:0:b0:790:a010:4c42 with SMTP id m21-20020a6bea15000000b00790a0104c42mr28325512ioc.13.1697140049529;
        Thu, 12 Oct 2023 12:47:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 08/10] dyndbg: drop _ddebug.site member
Date:   Thu, 12 Oct 2023 13:47:09 -0600
Message-ID: <20231012194711.3288031-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194711.3288031-1-jim.cromie@gmail.com>
References: <20231012194711.3288031-1-jim.cromie@gmail.com>
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

