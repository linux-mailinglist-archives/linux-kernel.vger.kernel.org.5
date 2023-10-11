Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F57C5995
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjJKQxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJKQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:53:38 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00998;
        Wed, 11 Oct 2023 09:53:37 -0700 (PDT)
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qqcSg-0004XY-37;
        Wed, 11 Oct 2023 12:53:30 -0400
Date:   Wed, 11 Oct 2023 12:53:30 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org,
        Matthew House <mattlloydhouse@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v4] execve.2: execve also returns E2BIG if a string is too
 long
Message-ID: <20231011125330.13dfe148@imladris.surriel.com>
In-Reply-To: <20231011124301.4d93ea72@imladris.surriel.com>
References: <20231011124301.4d93ea72@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh, once again I did a git commit --amend without the latest file change being
included. The change below should be good. Working with both git and hg gets me sometimes :/
---8<---

The execve syscall returns -E2BIG in 3 cases:
- The total length of the command line arguments and environment is too large.
- An argument or environment string is longer than MAX_ARG_STRLEN.
- The full path to the executable exceeds MAX_ARG_STRLEN.

Spell out all 3 cases in the -E2BIG section.

Discovered by moving a too large commandline parameter to an environment
variable, and finding that things still did not work. Examined the code
in fs/exec.c to get the details.

This simple shell script starts failing at 2^17 on a system with 4kB
page size:
./exec2big.sh: line 10: /bin/true: Argument list too long
fork failed at loop 17

STRING="a"

for loop in `seq 20`; do
	STRING="$STRING$STRING"
	export STRING
	if /bin/true ; then
		: # still under the limit
	else
		echo "fork failed at loop $loop"
	fi
done

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Matthew House <mattlloydhouse@gmail.com>
---
 man2/execve.2 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/man2/execve.2 b/man2/execve.2
index 0d9582492ad1..b689101771e5 100644
--- a/man2/execve.2
+++ b/man2/execve.2
@@ -449,7 +449,12 @@ The total number of bytes in the environment
 .RI ( envp )
 and argument list
 .RI ( argv )
-is too large.
+is too large,
+an argument or environment string is too long,
+or the full
+.I pathname
+of the executable is too long.
+The terminating NUL is counted as part of the string length.
 .TP
 .B EACCES
 Search permission is denied on a component of the path prefix of
-- 
2.41.0


