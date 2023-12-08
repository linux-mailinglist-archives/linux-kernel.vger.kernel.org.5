Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F58096FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444157AbjLHAP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjLHAPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:21 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B71713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:27 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b70db00e64so7050139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994527; x=1702599327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDBtxhHmRb9xUvMy+TwyAcV6s+hWcrLfWnhfzgBeMmA=;
        b=Rf6BmGxXmVlBpa/MZVcW3uzUzHhpOU6/SkHHBI9ThduSIB+etFo3ePYODmF1U8nGA/
         ma00S1zylH3VRvnM8PdSVyRZ1PCSBguNIlX9Q+4tPypAXwaJfyekWsgDpFVczDm8D4UU
         S/CeGJ1hK6U3hs1mt64IYbkXFYFw/OKDNzqWzaMjIjqu4ENSdPhi9ogT+1fxiZ2/kdBc
         tI0XYG9TDWuT0PhXDDVslvm2On7cXeTemjmkQPI3+VMF8UnSPEu4eCck2zRfy2htPLW4
         ufoPui3PbrvhBAldjdSM/6PByUm1kYSDjqMUtBh+ADr/kYVY1GwJwewJd6d92A9wLQaO
         jPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994527; x=1702599327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDBtxhHmRb9xUvMy+TwyAcV6s+hWcrLfWnhfzgBeMmA=;
        b=B3K6Rlw9dp0ngHwhdehi8/JA7mCHuzA32YKObdSn7QRy/Y4mqKSMcQ5WnaIRcSGQfi
         HEKjMbis+8aAw3RoABlRmGrd7H9UlU3sTLjC69O95OF/cvlwOBAe1OuZ+i9YDiw+o1QD
         DzrH7iisDhLqjeQPg1zAlerfbs8/SKI60a5d9H5b/Rdff46ZwsdDOtBQZwzlLUnBldrA
         kM7f8swKsC8o0I6tFOM04H7xhNK9vUc9fhumMYmQ51G3AdqyTuisriofa2EZvBTqsNl8
         EZnX02wWgkheosOsKkxuJNX5ils5wbvhTKlzf/ZmMhj8f80vCShAmBkzWhs0xSbENCPK
         NiKw==
X-Gm-Message-State: AOJu0YwViGapH30+liQ0KH+H0stW5Kt0p3dTOCdlKu9dDYP1dodf5CXK
        IBgZ2CZlk9F2LAppGrmYQtE=
X-Google-Smtp-Source: AGHT+IFidMk4jVxk2jDeIWi9s5BLmqpnH+o5AeqJxJad01cIk9n9fwCrAjfHQYEur8NdEOBCpRhZ8Q==
X-Received: by 2002:a5d:93d1:0:b0:7b3:d91a:4936 with SMTP id j17-20020a5d93d1000000b007b3d91a4936mr3961806ioo.9.1701994526962;
        Thu, 07 Dec 2023 16:15:26 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:26 -0800 (PST)
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
Subject: [re: PATCH v2 00/15 -  03/11] dyndbg: disambiguate quoting in a debug msg
Date:   Thu,  7 Dec 2023 17:15:06 -0700
Message-ID: <674f65e71c5c3e874b6b72b6f9d8cdd7a091b6d0.1701993656.git.jim.cromie@gmail.com>
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

When debugging a query parsing error, the debug message wraps the
query in escaped-double-quotes.  This is confusing when mixed with any
quoted args where quotes are stripped by the shell.

So this replaces the \"%s\" with <%s> in the format string, allowing a
user to see how the shell strips quotes:

lx]# echo  module "foo" format ,_ -f > /proc/dynamic_debug/control
[  716.037430] dyndbg: read 26 bytes from userspace
[  716.037966] dyndbg: query 0: <module foo format ,_ -f> on module: <*>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fc94f09b20db..bde96ad867c6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -955,7 +955,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		vpr_info("query %d: <%s> on module: <%s>\n", i, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
-- 
2.43.0

