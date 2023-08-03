Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DF76E6B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHCLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHCLU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:20:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30230127
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:20:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so1064225a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691061645; x=1691666445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGm9RaCktksphBM6qBTo2dajqQuhAqPOJNdE3FD2hgc=;
        b=YeQDmDoPcsL/ShP7B0Qb4le9h+np5ZDWzGzMGeFnGxZbfqeQ6YqJyjW18ihxEeS+d0
         znMUkpUVAvm0bMZS4tQH7EOsqP/XRzpziC+OEyLSCrN8dSdCfqzB7RrppSG4AoLwiV/Q
         uDY5WG0ZHYKshcY8RnpzuCMPs/SzFd9lWzVv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061645; x=1691666445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGm9RaCktksphBM6qBTo2dajqQuhAqPOJNdE3FD2hgc=;
        b=eqF280SBLTJgDa79r/qENpiogqGvB4D/39zlqW+QJCKua8Tw4JnG+fwUbk8hRCT9BZ
         T8R8FjfsJHfH4YlQ7T05PDvVB/UyspEebdgYzzO8f7XpDyMnwPW5SA8xDv6h4G0SDpfI
         n8aqCWdD8cCW2iS/9TUI73fc9ptBiTS9W/2IrqHR5kjabWhEFiwbNxMy+86fGVvZECPD
         ovUaUE7cwbGWurNPTnojSCN7sBVnayDara0h0S42yTHiWaskuZn4pli6OpEOLL9mpymj
         3acumSxrMxaxWN+9FzA9DmhNUBrk0vxU4sQouE60Yg7iGaPXO9DaUu6Jg853MsLw7Jy0
         usuQ==
X-Gm-Message-State: ABy/qLYRJ8YGkyhO5rn3sKnnTKJEhLbi3mh27g6RNV2orhR5E34qUZwE
        4ymXZ54nrF1Mp/9ZQL1LSV6mjA==
X-Google-Smtp-Source: APBJJlGgjSzevYGmhrLQyvHjBurRfrYIQ449O32ykxDOME8FzzWGSetnShITQEHjKUCiaBrEGeufrQ==
X-Received: by 2002:a05:6402:883:b0:522:40dd:74f3 with SMTP id e3-20020a056402088300b0052240dd74f3mr7639650edy.39.1691061645504;
        Thu, 03 Aug 2023 04:20:45 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id bf19-20020a0564021a5300b0051ded17b30bsm10006387edb.40.2023.08.03.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:20:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/setlocalversion: also consider annotated tags of the form vx.y.z-${file_localversion}
Date:   Thu,  3 Aug 2023 13:20:42 +0200
Message-Id: <20230803112042.2277172-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ab7e1f95e96 ("setlocalversion: use only the correct release
tag for git-describe") was absolutely correct to limit which annotated
tags would be used to compute the -01234-gabcdef suffix. Otherwise, if
some random annotated tag exists closer to HEAD than the vX.Y.Z one,
the commit count would be too low.

However, since the version string always includes the
${file_localversion} part, now the problem is that the count can be
too high. For example, building an 6.4.6-rt8 kernel with a few patches
on top, I currently get

$ make -s kernelrelease
6.4.6-rt8-00128-gd78b7f406397

But those 128 commits include the 100 commits that are in
v6.4.6..v6.4.6-rt8, so this is somewhat misleading.

Amend the logic so that, in addition to the linux-next consideration,
the script also looks for a tag corresponding to the 6.4.6-rt8 part of
what will become the `uname -r` string. With this patch (so 29 patches
on top of v6.4.6-rt8), one instead gets

$ make -s kernelrelease
6.4.6-rt8-00029-gd533209291a2

While there, note that the line

  git describe --exact-match --match=$tag $tag 2>/dev/null

obviously asks if $tag is an annotated tag, but it does not actually
tell if the commit pointed to has any relation to HEAD. So remove both
uses of --exact-match, and instead just ask if the description
generated is identical to the tag we provided. Since we then already
have the result of

  git describe --match=$tag

we also end up reducing the number of times we invoke "git describe".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/setlocalversion | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 3d3babac8298..bbb6c7d545f4 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -57,21 +57,36 @@ scm_version()
 		return
 	fi
 
-	# If a localversion*' file and the corresponding annotated tag exist,
-	# use it. This is the case in linux-next.
+	# mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
+	# stable kernel:    6.1.7      ->  v6.1.7
+	version_tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
+
+	# If a localversion* file exists, and the corresponding
+	# annotated tag exists and is an ancestor of HEAD, use
+	# it. This is the case in linux-next.
 	tag=${file_localversion#-}
-	tag=$(git describe --exact-match --match=$tag $tag 2>/dev/null)
+	if [ -n "${tag}" ]; then
+		desc=$(git describe --match=$tag 2>/dev/null)
+	fi
+
+	# Otherwise, if a localversion* file exists, and the tag
+	# obtained by appending it to the tag derived from
+	# KERNELVERSION exists and is an ancestor of HEAD, use
+	# it. This is e.g. the case in linux-rt.
+	if [ -z "${desc}" ] && [ -n "${file_localversion}" ]; then
+		tag="${version_tag}${file_localversion}"
+		desc=$(git describe --match=$tag 2>/dev/null)
+	fi
 
 	# Otherwise, default to the annotated tag derived from KERNELVERSION.
-	#   mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
-	#   stable kernel:    6.1.7      ->  v6.1.7
-	if [ -z "${tag}" ]; then
-		tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
+	if [ -z "${desc}" ]; then
+		tag="${version_tag}"
+		desc=$(git describe --match=$tag 2>/dev/null)
 	fi
 
 	# If we are at the tagged commit, we ignore it because the version is
 	# well-defined.
-	if [ -z "$(git describe --exact-match --match=$tag 2>/dev/null)" ]; then
+	if [ "${tag}" != "${desc}" ]; then
 
 		# If only the short version is requested, don't bother
 		# running further git commands
@@ -81,8 +96,8 @@ scm_version()
 		fi
 		# If we are past the tagged commit, we pretty print it.
 		# (like 6.1.0-14595-g292a089d78d3)
-		if atag="$(git describe --match=$tag 2>/dev/null)"; then
-			echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
+		if [ -n "${desc}" ]; then
+			echo "${desc}" | awk -F- '{printf("-%05d", $(NF-1))}'
 		fi
 
 		# Add -g and exactly 12 hex chars.
-- 
2.37.2

