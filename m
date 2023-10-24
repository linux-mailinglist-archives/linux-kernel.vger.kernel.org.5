Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CB77D4B08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjJXIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjJXIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:53:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFA1734;
        Tue, 24 Oct 2023 01:52:47 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pe8R6tL57OmCbabwVfsjoHgMDSqyr8YzIfgc2ok6lis=;
        b=jpA+oeNtcblDgDLtEEnWh84yO8nGthWce3K0Vzc4iylQ+ARW2EswUd5JmNOHHIeEapuIge
        HYckkMqc48ggJkuo4kXoQGw/6aHDphSsrlYbSXEA8UlpG84YNFTfpdjm2L5HvDU+34j6O+
        xbdYmRGU1mzJCnLGCg8zzymH2AwJuO+N27vat+XxwyZHpsJNsikRf7oOkR6V/m6Oag40S4
        57dLgzlocJNNnTAIvXEK0PGj+Tt+/a4I3dNcyP6Tvz5IRYUBbkxrTBdB7wTnIf41TTnKM7
        l9TJ2X+wdDh8NpiL9T/i+RFSCFEOrVUpU8ks1s9yX7DLgItcCCwnxL7QlctK0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pe8R6tL57OmCbabwVfsjoHgMDSqyr8YzIfgc2ok6lis=;
        b=h6W66AFtUD4w6UlENqo1KAS9J2joEYxMLIRW+tBsEZyWU0ekLrxR4tqWAcYnjhJSjWK6om
        jj6vmdpA3UtQe9BQ==
From:   "tip-bot2 for Aaron Plattner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Propagate early errors
Cc:     Aaron Plattner <aplattner@nvidia.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccb6a28832d24b2ebfafd26da9abb95f874c83045=2E16963?=
 =?utf-8?q?55111=2Egit=2Eaplattner=40nvidia=2Ecom=3E?=
References: =?utf-8?q?=3Ccb6a28832d24b2ebfafd26da9abb95f874c83045=2E169635?=
 =?utf-8?q?5111=2Egit=2Eaplattner=40nvidia=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169813756572.3135.10008415743628852325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e959c279d391c10b35ce300fb4b0fe3b98e86bd2
Gitweb:        https://git.kernel.org/tip/e959c279d391c10b35ce300fb4b0fe3b98e86bd2
Author:        Aaron Plattner <aplattner@nvidia.com>
AuthorDate:    Wed, 04 Oct 2023 17:08:18 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 05 Oct 2023 17:01:11 -07:00

objtool: Propagate early errors

If objtool runs into a problem that causes it to exit early, the overall
tool still returns a status code of 0, which causes the build to
continue as if nothing went wrong.

Note this only affects early errors, as later errors are still ignored
by check().

Fixes: b51277eb9775 ("objtool: Ditch subcommands")
Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Link: https://lore.kernel.org/r/cb6a28832d24b2ebfafd26da9abb95f874c83045.1696355111.git.aplattner@nvidia.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/objtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index c54f723..f40febd 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -146,7 +146,5 @@ int main(int argc, const char **argv)
 	exec_cmd_init("objtool", UNUSED, UNUSED, UNUSED);
 	pager_init(UNUSED);
 
-	objtool_run(argc, argv);
-
-	return 0;
+	return objtool_run(argc, argv);
 }
