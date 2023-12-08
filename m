Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23C48096FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjLHAPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444130AbjLHAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47301713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:29 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b6eb711498so53096639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994529; x=1702599329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mATCtMnSIobn/epfr5Berq9mhTsVI3cfwyVyNaWc5ds=;
        b=D6ItTSIDrBRmTjvVFY5MBzsE69SVWEVtLwOH3lN4BpfsOJQah4aU/PH3HM27JgvE8M
         iFkEKN2EElYLTBVwGK7UELbzzG8bRKybgVCMppbRWBWLIf5UsEHw8b8rC+eiTsz3OUyV
         8AgRVowJUSlOBnTMyBxL7xh6NytXA265WmxxOewTJgEpIPJH2KI7TqLj6PmouNvP5G/g
         8d5caIxSxRZF5V1qQKKQtk1WYWaOBiJ38IbEnUA7tHufUBJYM5RVffS6f2gDDq72/y7b
         JWMo4H3vre6Y8y6SXInBbna86xDSfR5sDzdaji+RpKsKVP/eHR8HaDL/5hlDOIYvTRze
         lEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994529; x=1702599329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mATCtMnSIobn/epfr5Berq9mhTsVI3cfwyVyNaWc5ds=;
        b=Flh+OW+dI3hWPFC6hhcB4cvCS3nDXq2Co0PmRHaVXNfax0/snON/6yzJFoFaHqp6sW
         1+cojVdsUEb38Swv+wzTKYDctfpQBJX67LEhq+GWko1dXG6CBFJSDNoNqH1qd6Mm+Fm3
         aAIdRPPqCELrYMa0BhkWTH4xjicWN8gff4r6fJjgkBNk8C6Ml4c+3aGME8rHOgSjJOsp
         E2F3rhwHrZFYQP8i+FyIaTv/zO93Uc9UJYJHSP5548MvtCTUFQ6ceiEXKaRqhX3rd3sz
         Mts/RSDkSy5Y3IyUGkfkA4r63mw8A2H6ShukhMyPfoqxrQnUo9jqDr/fkh5H936JzOfQ
         DMhw==
X-Gm-Message-State: AOJu0Yxvu75ThFrY8oajk7CFu97aQx2WDjxRFtBU5z8rnalAGECeOo1s
        uXD62BcMPSLNVGiP42E6q2w=
X-Google-Smtp-Source: AGHT+IGBWqSZVDZk+xppMydkDmuUdw1CWFhhG5UQEoozOzoVI9+LDr1Z6gcI1AACVev5Vv0Ps84rRw==
X-Received: by 2002:a05:6602:400b:b0:7b4:28f8:1e03 with SMTP id bk11-20020a056602400b00b007b428f81e03mr3994734iob.34.1701994529057;
        Thu, 07 Dec 2023 16:15:29 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:28 -0800 (PST)
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
Subject: [re: PATCH v2 00/15 -  05/11] dyndbg: change +T:name_terminator to dot
Date:   Thu,  7 Dec 2023 17:15:08 -0700
Message-ID: <7cb5c8b6c6efba7e437595266638be39f23361fc.1701993656.git.jim.cromie@gmail.com>
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

This replaces ',' with '.' as the char that ends the +T:name.

This allows a later patch to treat ',' as a space, which mostly
eliminates the need to quote query/rules.  And this in turn avoids
quoting hassles:

  modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

It is particularly good for passing boot-args into test-scripts.

  vng -p 4 -v \
  -a test_dynamic_debug.dyndbg=class,D2_CORE,+p

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2ac1bd7f105f..a5fc80edd24c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,7 +172,7 @@ char *read_T_args(const char *str, struct flag_settings *modifiers)
 	}
 
 	str += 2;
-	end = strchr(str, ',');
+	end = strchr(str, '.');
 	if (end && *(end + 1) == '\0')
 		return NULL;
 
@@ -264,7 +264,7 @@ static char *ddebug_describe_ctrl(struct dd_ctrl *ctrl, struct ctrlbuf *cb)
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
 		if (ctrl->flags & opt_array[i].flag) {
 			if (show_args)
-				*p++ = ',';
+				*p++ = '.';
 			*p++ = opt_array[i].opt_char;
 			show_args = opt_array[i].show_args;
 			if (show_args)
-- 
2.43.0

