Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4DA8096F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjLHAPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:20 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AAE171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:25 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b37405f64aso49731439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994525; x=1702599325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJm+8y0/qDoimPsT2MU0Y1LRoOh1PxcpEIrcd3ya5V0=;
        b=Ctfq1Rl5X+Kfuw3yv+Ivdd+QvpovYJ+qQ7IpdTDu7xK49lvNxUgWJMwBdxptv5eUBc
         U9xXvFUXvI7wZo0uEsOOKsn/LsHshdEH4aLV/jLVxkTfG9i7auQnawwbofGJedizGhiu
         rXSVdlN6SQEMCImjkxiymu56/wloErlEyvSdwiSf9QF8NPvLkhuOF/MzLE7/AYdQy7qm
         DsmoulYw7GXbUiq44CN5b/iQ46EwQpu2aOdjwVtYf0E2ejsCqfQcu0YclbkbeH+t5Gau
         +abah8Uku8EnTGBFpJhaCdS1FXAynXtrl4A3z29/Wiaw+qb5HmEz23GhEeJR0BQxWcAC
         2C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994525; x=1702599325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJm+8y0/qDoimPsT2MU0Y1LRoOh1PxcpEIrcd3ya5V0=;
        b=tHNdyq5f7AgcutU3WmBXRnRblD4T/c6qVYJCIw80ljsNUrzlmIoBEw9lZBflPoNI92
         8QM2BlKpJvSydG7tEtmqv0vHspLATC9okmH/Kjt+FUfbN4PGFDwM4AgJ3SFFM89N+6DA
         BNtfn5pgbvZ2poHSD3ohrQudm112QF2FcZ+R+Sn0FeVpqhT4RPEoDSo88FvgCUwNEWEg
         E5jEGUFu42mUCj7fkCZzc5VExoXlB0gIAZutauFTp5xzNk1IqdIEV64W2dcDjae3aros
         /fwuivAgaiVT6S6QYCIB6PMTq7L+KcsAdB497GI+skFUyd9lElQyGbMXff68Pp1/nxPl
         Ys/w==
X-Gm-Message-State: AOJu0YxUbkjMdhg87ZBaOqvLPS654nXAnA9XLEoZBNZXigl2YzQSIKYe
        dcGj03+2ToH/sBU5+PIWd7dUN8brsF4kOQ==
X-Google-Smtp-Source: AGHT+IFXJyOCFmbJ8M9MrsCRGtIr0tsrctkU3hsZegUxyES0yMI3LJnMNovTm1fP4+y+ofa/uAKTOg==
X-Received: by 2002:a6b:ef02:0:b0:7b6:f0b8:56dd with SMTP id k2-20020a6bef02000000b007b6f0b856ddmr2307315ioh.25.1701994524879;
        Thu, 07 Dec 2023 16:15:24 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:23 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     lb@semihalf.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
        daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
        jbaron@akamai.com, jim.cromie@gmail.com, john.ogness@linutronix.de,
        keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com,
        rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Subject: [re: PATCH v2 00/15 -  01/11] dyndbg: export _print_hex_dump
Date:   Thu,  7 Dec 2023 17:15:04 -0700
Message-ID: <b9d003173239d3b2f3b42697372da8b727527135.1701993656.git.jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com> <cover.1701993656.git.jim.cromie@gmail.com>
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

This fixes a modpost error on amdgpu.ko
squash in w/o comment.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 71db40df31b2..07c377924160 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1388,6 +1388,7 @@ void _print_hex_dump(struct _ddebug *descriptor, const char *level,
 		}
 	}
 }
+EXPORT_SYMBOL(_print_hex_dump);
 
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
-- 
2.43.0

