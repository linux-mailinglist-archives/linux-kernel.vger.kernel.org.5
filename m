Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FC7EE974
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbjKPWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjKPWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:43:43 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE76131
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:43:40 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3594560fa09so5192775ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700174619; x=1700779419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7CJRAJ5zmc/CyN0iNuUX7460eksgbeoQL+z27nuIOo=;
        b=fxdtQAdBxC0gIesxs4iCPiOmubUa3eVLCiyQDJjjdvhoBpI/kvw+43UTTqAXuu/g3D
         MywefD3GS71k3ovxLHsK8NmB5QuZ04YuJWOGLOCbSMGwfr/F7FesMyMfjAREfLSqVDKL
         ipxra8lphS5dkjRLo5hWbzXwBN01jJM2MoLX0GB6rsEobOaF//W0XjT/2744QVy0ODbB
         4ReCuGHirAyp5/uTozkolORgV7bT7L9W2newIWgv36vRynimfKk0LPaXXWf9whRIOdKa
         auM1KT/fUh1LFUHVfrgPdDafEhKEN8x4B/HVt/xpfsWHFDC435RJqwUnDeIgPGlMXDHC
         cOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700174619; x=1700779419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7CJRAJ5zmc/CyN0iNuUX7460eksgbeoQL+z27nuIOo=;
        b=hOicE6XxhrY+zRHTDKoqxPBRhxOCDzdIqGj3R07m51++Sq+a5EViQRRNG3XJiMCd/N
         2PpHVithS3tNRVuhjk4hB3rahDiJ9Rx3ngHn0G291h3rKAXcX5mFPTmMGAFlrcFESlN5
         Fahms3/Cd8PAN8RiuQS9btB+AY5AiXcWf2g2gXLCQTBDgzdFLgTndgU8zk3OMhWUA8g4
         KJkP9AjPbQYysgwDpr8OkN66uQYN4L2RrmoNnhwUcbG7qIjBQid+waNRDuIM8pGR6urD
         aAyr7Kv4cPyvsMLOHlfKE7xX9TNGXg7Nv/cbQXHJTEABOaSyp5gAO8u1u264oKkYFfyc
         ViNg==
X-Gm-Message-State: AOJu0YwvyM3YjF7nSLyPsGKY02sDh2sWHvQjhUTT6jY1Q1K9thqnMa30
        oavpp2OBXUckHkQJ3AuonTBru+bOaxA=
X-Google-Smtp-Source: AGHT+IHci1YpxIi+rCEfCL+/1XjqAwuqMsRHaRmkTsjGKITpVT0SVNE/kMXq8v3zD/yVS5ld7dMsVQ==
X-Received: by 2002:a05:6e02:19c8:b0:358:1b:f8fa with SMTP id r8-20020a056e0219c800b00358001bf8famr23868182ill.32.1700174619453;
        Thu, 16 Nov 2023 14:43:39 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id g12-20020a92520c000000b0035913c8423esm84399ilb.73.2023.11.16.14.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 14:43:38 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] kmemleak: drop (age <increasing>) from leak record
Date:   Thu, 16 Nov 2023 15:43:17 -0700
Message-ID: <20231116224318.124209-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116224318.124209-1-jim.cromie@gmail.com>
References: <20231116224318.124209-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying age is pretty, but counter-productive; it changes with
current-time, so it surrenders idempotency of the output, which breaks
simple hash-based cataloging of the records by the user.

The trouble: sequential reads, wo new leaks, get new results:

  :#> sum /sys/kernel/debug/kmemleak
  53439    74 /sys/kernel/debug/kmemleak
  :#> sum /sys/kernel/debug/kmemleak
  59066    74 /sys/kernel/debug/kmemleak

and age is why (nothing else changes):

  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67
  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67

Since jiffies is already printed in the "comm" line, age adds nothing.

Notably, syzkaller reads kmemleak only for "unreferenced object", and
won't care about this reform of age-ism.  A few moribund github repos
mention it, but don't compile.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 mm/kmemleak.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eacca03bedd..10c9b611c395 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -355,14 +355,12 @@ static void print_unreferenced(struct seq_file *seq,
 	int i;
 	unsigned long *entries;
 	unsigned int nr_entries;
-	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
 	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 			  object->pointer, object->size);
-	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-			   object->comm, object->pid, object->jiffies,
-			   msecs_age / 1000, msecs_age % 1000);
+	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
+			   object->comm, object->pid, object->jiffies);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-- 
2.41.0

