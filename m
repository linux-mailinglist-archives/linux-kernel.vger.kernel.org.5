Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB3809700
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444156AbjLHAPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444165AbjLHAP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:28 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41A1713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:30 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b70db00e64so7051439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994530; x=1702599330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIrfoZ1i426abC79FFZ4gkypbBAGHzLKNKqJo9Y1v4M=;
        b=F/DNRFmiPTN1m+8w/+UYEVREhhUTlo62xhr6yUwhqTRMg2kSPvNSb+VeepPK72U0kQ
         lGILQS0xfUHyU8LSMdrfJFfDH1qyZfN5ZWuMITM8qWxKxCa5m3Hs5gQLSFWEG+0Alzyu
         h4dYMmWKkz55PXoQ51jUleQ4tk4cNF/x0L1DtSBrfxWk5zR9YZXy6Qw/H7Sspr5SucZ8
         WJr0+BLoEmVAxXgB7RLz3aIyYi8c39ME8uEmJph8ybrJVmw0JZjxYI75LvwNSb7qEdam
         Omhjb3/igUgs/FDwBMPd4Y3OtJnOuxsQU/hZ3yCkxUEn5gkOCLdJBypXaOXDTaZMp3Hc
         LXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994530; x=1702599330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIrfoZ1i426abC79FFZ4gkypbBAGHzLKNKqJo9Y1v4M=;
        b=ctxGvPaXZzXiMDlqHRyqB2UeXp9blUjvb6n0UGM9C4CioPxhTkhLUxBEIWefn8uzxl
         l2vrqYTLWv1xprzoaMwgRcpOCL2sSNeoGhXB+91SFSM2tHjHHvapi+dbnpXSZ0qqguV1
         5rJzAzHmYHvs56oGcGyHUP8KpKa3P3heSVZEdjRuyi2Xpye88pA6PrgmL8Io1hDAPYhV
         NML3yNuzNVbBkwRoom41jxoLoiOR6qPUpXGPH0EtDMqZrc1Ovyr5CQolQmCUVHUOwSW6
         lMA+2DlWIylNuRNfyHJqsbnnTyaeWamUxal/4cxr7IwHTEUgahq1gL8v+ts+1YWqv81c
         x53w==
X-Gm-Message-State: AOJu0YwXJnXUXNbBpyS7FWlyvQol6Mazg737rwdlcKk32nYBJUycjNUc
        pLhkMRkExQkEkH9Bbpqa0R0=
X-Google-Smtp-Source: AGHT+IFBJDlvUosLfG725FvBGc4548iV6hbsLGeQ8z58R9AYRv1p/6HLHsNJAiRYrr50x1uhktla0w==
X-Received: by 2002:a05:6602:899:b0:7b6:f790:f7da with SMTP id f25-20020a056602089900b007b6f790f7damr1737509ioz.42.1701994530062;
        Thu, 07 Dec 2023 16:15:30 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:29 -0800 (PST)
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
Subject: [re: PATCH v2 00/15 -  06/11] dyndbg: treat comma as a token separator
Date:   Thu,  7 Dec 2023 17:15:09 -0700
Message-ID: <daa8332f3adc2406cc61bf781eb590a7873bbcaf.1701993656.git.jim.cromie@gmail.com>
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

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

  drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the myriad ways a boot-line can be assembled and then passed
in/down/around shell based tools, if the >control parser treats commas
like spacees, this would allow side-stepping all sorts of quoting
hassles thru those layers.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a5fc80edd24c..a380b8151dd8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -647,6 +647,10 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
 			break;	/* token starts comment, skip rest of line */
+		if (*buf == ',') {
+			buf++;
+			continue;
+		}
 
 		/* find `end' of word, whitespace separated or quoted */
 		if (*buf == '"' || *buf == '\'') {
@@ -658,7 +662,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
-- 
2.43.0

