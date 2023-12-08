Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF78096FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444173AbjLHAPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjLHAPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:22 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E538171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b70db00e64so7050539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994528; x=1702599328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Jj4zDaid3kObonfF2nPMR3v/yop3sD2p9jGaVG2Tw=;
        b=jwCEX7KBobCTzEK/+b2DcAstaFCNhbIaUTxK4nLiJvq+8D+/B62dwXkVOCxeMMvDUa
         Rw/tuogmw6SV4ArFYooHGI68ZKeDUGTWnYcZn5wWeUpgDznECg5E2VPgTaa5CTT0WxKv
         KAmXlULc5MXtrt4LcukC9nLVogvMH4baDYKWlLWAY2MkoTB5omYWZl2RYzaK5E+X+Cxq
         ODpEZZoV+3K729nz/xJeQvaz6E6ZbsQJxCj6wOCovS1f9SacBjia6aKApnPBUGuFDF8C
         b0vltXYgAXmd+Gi/130MtVKrfF3znR7VBkU+s98rEchf91l7oxWXdsSOcrqo694UqlU7
         0yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994528; x=1702599328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9Jj4zDaid3kObonfF2nPMR3v/yop3sD2p9jGaVG2Tw=;
        b=mJ9kbUYusN63DMUo5g1sXig8l24/F8GXcDqpVL7b6/BDUCTnCfzNSlWstN7Gzj4K1z
         uPeehiPV4xeSLoLeoDQhSmjubE2dkgdwV9DaPoflrVudLh/lKrr6u/YEs2qV2dEahN8o
         3lGvtW/wGfdmNi2OpScIQ4AVvQISPuyXkr6MzxtveQTjowU0VQwcCNMCSj8E3nANlDgB
         V6LcZeBd08WFNPIkT9DNcA1ZXeQt2KgpxFt5TGTzfBVI+eUb3OXaaWOUaeaaAXzgFZwa
         kTJSRq4sS/j3NdA8mHpIyo/mhZsNUTKHeJctiFXzHPCzxP9cOHSu8+4UEBjtaqAhHhnP
         cnIg==
X-Gm-Message-State: AOJu0Ywn3oGOoaMKniYWibkcBUgjbxO0PJRCeXXgvOAUTxFXSmI7wK12
        Th8qwGTCqAbR3mVOUQLnSqQ=
X-Google-Smtp-Source: AGHT+IE/3sRF3SUcpIUV3+nScL3OxkWMltezEv7Op/4l1FjjDoalbRepe6d825qdblca5KIdRAC95w==
X-Received: by 2002:a6b:7d07:0:b0:79f:ca2f:9198 with SMTP id c7-20020a6b7d07000000b0079fca2f9198mr4134890ioq.2.1701994528020;
        Thu, 07 Dec 2023 16:15:28 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:27 -0800 (PST)
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
Subject: [re: PATCH v2 00/15 -  04/11] dyndbg: fix old BUG_ON in >control parser
Date:   Thu,  7 Dec 2023 17:15:07 -0700
Message-ID: <3f7fa537d49fbd96ffae84f62029bd9e56e99d5a.1701993656.git.jim.cromie@gmail.com>
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

Fix a BUG_ON from 2009.  I have hit it while fuzzing >control on some
other patches, and panic from user input is bad.  Replace the BUG_ON
with pr_error and return -EINVAL.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index bde96ad867c6..2ac1bd7f105f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -660,7 +660,11 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		} else {
 			for (end = buf; *end && !isspace(*end); end++)
 				;
-			BUG_ON(end == buf);
+			if (end == buf) {
+				pr_err("parse err after word:%d=%s\n", nwords,
+				       nwords ? words[nwords - 1] : "<none>");
+				return -EINVAL;
+			}
 		}
 
 		/* `buf' is start of word, `end' is one past its end */
-- 
2.43.0

