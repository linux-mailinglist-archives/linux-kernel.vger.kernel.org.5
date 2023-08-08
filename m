Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB2773B08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHHPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHHPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:36:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D02113
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:30:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76c845dc5beso312577785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691465426; x=1692070226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq8u+P5B599QNMU/hMo97WZZje4v2kxUMmhAQURJTHU=;
        b=lrC69s/9+ztDiIY1TLG6g1c6x7Nx2jLCtsJtQTTX7FNKTGGAl7mvxs2oCQVyBQocCA
         N3AxMNtBHlyn0Un41DO29tDJibRHSUk6rjR7G19/9mJpTYsI06Kw7zjjzyOoAD6Z4GCm
         +KTlhbUw+6Lt2Jsp9fUOuxugb5wHQjsVj8JkduXP9wiY0qO3AfGcuoP8VawFResSaCti
         0enkDVNEKcgkx4uY3A55Z4zMTngcYayl2eHWhyGajNcftM/fNLUJOqrkqs3ef8yr/Uvz
         IdAibuiXBwxVYeUXxYN1q+keEWqE0X7yZ3LQTSEzhMD7jR1U3a6XDh7uTvJAfqUd3XqK
         587w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465426; x=1692070226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq8u+P5B599QNMU/hMo97WZZje4v2kxUMmhAQURJTHU=;
        b=E4FWwoy0DVgvRgYPc8/312skrRyXfzyJyuIcTDOZU+3woo/lFUQ7zG8Ozfi8zMorNC
         AAmnnPes5SBpfJFWMcUSV1Q3qlEepAKYWL6JyxBmM3oapHqVGmJSdFU04DFU4LJ7el12
         poDTo7wOU9VjTIbH3xhz5pdvxNwL/B1dp+cWCwItw0dlZRJjkKKrlf4RAo48g4lw0mSq
         OjNHj+B/J1IpqEE45nMr4IEWoPm+oiaReiuGvGSUaf5wWjod86KTn/h0tH6CKgkijzpu
         1mn6WhARYlFiPbsJ0FF+aicTZtNoeYro4S8hb+VyX3Dr37Di2ywnVTkKMOoYAbaeYlYT
         +OYQ==
X-Gm-Message-State: AOJu0YyzebIAXH7WW8ErozFTmuPRlwElLOs82kh0G8DZJfBM2i99pfkR
        9Mk909V8tJrmHgMqZj8NHEFxaXafVeypXQ==
X-Google-Smtp-Source: AGHT+IHQMqiYicHT+fmzZnAJg4yOkeV3vYlkkuP2ZRNmw/k13b7oxxofxm0xMcjjDbLn7f/9UnJtfQ==
X-Received: by 2002:a05:620a:258a:b0:765:3ca0:3708 with SMTP id x10-20020a05620a258a00b007653ca03708mr8876142qko.75.1691465425812;
        Mon, 07 Aug 2023 20:30:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id em12-20020a0566384dac00b0042bb5a8e074sm2854031jab.8.2023.08.07.20.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:30:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Jim Cromie <jim.cromie@gmail.com>,
        apw@canonical.com, joe@perches.com
Subject: [PATCH 1/2] checkpatch: special case extern struct in .c
Date:   Mon,  7 Aug 2023 21:30:18 -0600
Message-ID: <20230808033019.21911-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808033019.21911-1-jim.cromie@gmail.com>
References: <20230808033019.21911-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"externs should be avoided in .c files" needs an exception for linker
symbols, like those that mark the start, stop of many kernel sections.

Since checkpatch already checks REALNAME to avoid looking at fragments
changing vmlinux.lds.h, add a new else-if block to look at them
instead.  As a simple heuristic, treat all words (in the patch-line)
as possible symbols, to screen later warnings.

For my test case, the possible-symbols included BOUNDED_BY (a macro),
which is extra, but not troublesome - these are just to screen
WARNINGS that might be issued on later fragments (changing .c files)

Where the WARN is issued, precede it with an else-if block to catch
one common extern-in-c use case: "extern struct foo bar[]".  Here we
can at least issue a softer warning, after checking for a match with a
maybe-linker-symbol parsed earlier from the patch.

Though heuristic, it worked for my test-case, allowing both start__,
stop__ $symbol's (wo the prefixes specifically named).  I've coded it
narrowly, it can be expanded later to cover any other expressions.

It does require that the externs in .c's have the additions to
vmlinux.lds.h in the same patch.  And requires vmlinux.lds.h before .c
fragments.

Cc: apw@canonical.com
Cc: joe@perches.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..6aabcc1f66c1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -74,6 +74,8 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
+my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
+
 sub help {
 	my ($exitcode) = @_;
 
@@ -6051,6 +6053,9 @@ sub process {
 
 # check for line continuations outside of #defines, preprocessor #, and asm
 
+		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
+		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
+		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
 		} else {
 			if ($prevline !~ /^..*\\$/ &&
 			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
@@ -7119,6 +7124,21 @@ sub process {
 				     "arguments for function declarations should follow identifier\n" . $herecurr);
 			}
 
+		} elsif ($realfile =~ /\.c$/ && defined $stat &&
+		    $stat =~ /^\+extern struct\s+(\w+)\s+(\w+)\[\];/)
+		{
+			my ($st_type, $st_name) = ($1, $2);
+
+			for my $s (keys %maybe_linker_symbol) {
+			    #print "Linker symbol? $st_name : $s\n";
+			    goto LIKELY_LINKER_SYMBOL
+				if $st_name =~ /$s/;
+			}
+			WARN("AVOID_EXTERNS",
+			     "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
+			     . "is this a linker symbol ?\n" . $herecurr);
+		  LIKELY_LINKER_SYMBOL:
+
 		} elsif ($realfile =~ /\.c$/ && defined $stat &&
 		    $stat =~ /^.\s*extern\s+/)
 		{
-- 
2.41.0

