Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6C8096FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444224AbjLHAPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444156AbjLHAP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A71725
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b3ec83a8d4so65778839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994532; x=1702599332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzemyBWiktEMRpqERnIwUz6Pik0FVBTgB713Rxzb6zY=;
        b=eYB2/Nv2F6Rz8yVggy3H5m3aBU+QdvcME2mv0cZEKardO8zz54KspNspZFHjVX1B7b
         xMMrbX3zTyw2pbsV66XNCUQF3z+OKm+O5ipsBsXBXCiQoGNbPAomG8bdKpK0xfnpKedl
         zZB7JqO8po9m8lythDVGulp3sujuQM26KjcNZwG02NV3UqFWzR13NwnHB41N2at+zCVY
         m/v6FJdWXYZv5q7ZxHhRzh2F3W3ATWJjFdg7kgwZAbPEMu50kjLXMPVtGuJ9jcpgGNsp
         SH5r1c+NVBUrad1G1Tcp8ACmwUROeuWhyX6vxdLNoe7RNmkIwfMSbVM/4v84Tkm5yV/i
         ZaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994532; x=1702599332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzemyBWiktEMRpqERnIwUz6Pik0FVBTgB713Rxzb6zY=;
        b=vtmayaK9Snl3Z6ZlD6mgW6TT7aVfPXwTH4x6RttxC4TMjPZh9rwH1QzKxnqeHV9uyq
         MrYaRn3dQdIOlCnDZyb28oaSHInNQ/gJ/BnVjKdMeQFkdZqn6hAS5EjZ0790pBzq4ZuV
         My77epjp20wcyR3OMuKnbYAyG6L2bGRYFjuiybY91mUCgVC/tr1dzWd76gQSHzWELfSf
         MjwxNWn9K4fxdzN82CAd3RJHcwsyy4fay4FD0USK4em6+U7awRXlwCJY8hfmcLsM0sCE
         2S2qxVuUcZtm9roFFeb4OZUDYLStJPMosZ2o4sS1DPQbm7b36+aytwkEckOMiHKSBQra
         ZXRA==
X-Gm-Message-State: AOJu0Yw2goeiS6dRBCvAOLcp10x95A2bB47N7e+0Bfq7PY7uhXQh85B3
        +HoTaAm1oZqLOb1yS0a1Bsc=
X-Google-Smtp-Source: AGHT+IFBKJtLRg83F5qs++fJW1JgATvZAheFKIQSYnR3OLgXNDhIpfpGSM4fcLqF5q6OyqKUIRaicA==
X-Received: by 2002:a6b:fe05:0:b0:7b7:22d:6ee3 with SMTP id x5-20020a6bfe05000000b007b7022d6ee3mr44376ioh.18.1701994532447;
        Thu, 07 Dec 2023 16:15:32 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:32 -0800 (PST)
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
Subject: [re: PATCH v2 00/15 -  08/11] dyndbg: split multi-query strings with %
Date:   Thu,  7 Dec 2023 17:15:11 -0700
Message-ID: <5351f56289add68eee2aa5288f82a313c2b9f664.1701993656.git.jim.cromie@gmail.com>
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

Multi-query strings have long allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +pmf
     class DRM_UT_KMS  +pmf
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

But that leaves unfinished business; that semi-colon needs escaping,
and thats not robust to further string interpolation.  In particular,
it fails when passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-cmd
separators, which is more shell-friendly, and avoids quoting and
escaping hassles.

  modprobe drm dyndbg=class,DRM_UT_CORE,+p%class,DRM_UT_KMS,+p

NOTE: it does alter/break this (ill conceived) search:

[root@v6 lx]# ddcmd format %s +p
[   38.170998] dyndbg: read 13 bytes from userspace
[   38.171542] dyndbg: query 0: <format > on module: <*>
[   38.172011] dyndbg: bad flag-op f, at start of format
[   38.172487] dyndbg: flags parse failed
[   38.172839] dyndbg: query 1: <s +p> on module: <*>
[   38.173285] dyndbg: expecting pairs of match-spec <value>
[   38.173791] dyndbg: query parse failed
[   38.174141] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

In trade for that minor format selection limitation, we get to do:

  vng -v --user root -p 4 \
      -a dynamic_debug.verbose=3 \
      -a drm.debug=0x15 \
      -a i915.dyndbg=class,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfml
  modprobe drm
  modprobe i915

NOTES/TLDR:

In this example, using both drm.debug & drm.dyndbg is mostly for
testing.  Using drm.debug is preferred, because the drivers all
explicitly depend on that input/control-point, so settings there are
propagated to drivers.

But more to the point, drm.dyndbg explicitly limits the query to drm.
In fact, you could pass a module wildcard in the above, and achieve
the same thing:

  vng -v --user root -p 4 \
      -a dynamic_debug.verbose=3 \
      -a \*.dyndbg=class,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfm%class,DRM_UT_ATOMIC,+pf

':' would be a more natural multi-cmd separator, but is reserved
for +T:<trace_buf> to designate separate tracebuf instances.

If '%' is distasteful, the backup plan is ",_,", since that would
never appear in a useful <format "$foo"> cmd.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c974f6e19ca1..0ca3ba9e2032 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -963,7 +963,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
-- 
2.43.0

