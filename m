Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA776FFED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHDMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHDMFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:05:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1118B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:05:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso3504437e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691150740; x=1691755540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw4/LiNw1X5Y/MHQwsTYyBXo81S5Syv8pKLuqoL0MVc=;
        b=WPxCazYrqqlHx5915mCMiXz4mP1qKpaSwY0IzkNEQCvN5As/YyH1+qjO7yGegRQlMm
         cPTBKghJcqApf4PEJm18G8TAA8gTRPnXwZ0dxaS/uSq2Nlr0WNncEVlkWKpFL/4RYMdv
         L83ahtj8wD41zaOQmsWqIstgpgyiOlVqQCgvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691150740; x=1691755540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jw4/LiNw1X5Y/MHQwsTYyBXo81S5Syv8pKLuqoL0MVc=;
        b=YvsDSOzdgDdL53hVtnLf2L3lDwKFggrh/wGD0UNq2Afsoq8fcc8GWYSGLEpxg48F3I
         WhiM9k4ulSi8ygZzxDlLTUFydg2bw2JXb7gNEU1ExiAFT1+sC/PFog4dI8iVIDcJ0pma
         wln5iK1xFszeTtlPE3JOLwwM38vW2u2gjpibMBEfo+pBO3rBae8naoJMge03CLEsR1y8
         b7b4sxN2oXaf3nVxsRh9lRt41YJTb/d5GL2g3teoEG4exS7oNH53lf+xMb3xkK+uxpy/
         sCj9/ZY4a5K63pKiBeH3eBaOklSzm5OiwU4M9Vy3olA8tsPG7ePH5SAQP4WfYivd5iTg
         EN8Q==
X-Gm-Message-State: AOJu0YzTdONRw6fDF6eNpdAKd1gmbeR2yfwgEN2xTqF3A9A71smqzsIo
        LQxgPZZ8iInShvHdnpX7P/NSOGZnfMMKQUV5OWA=
X-Google-Smtp-Source: AGHT+IFk7+18EVKOfD0eBgM1s+A8NsrXOVV265v0Qim5DSNkwWvnugj55uMQhbxPuA3jrFFY6GEwCA==
X-Received: by 2002:a05:6512:74e:b0:4fb:ca59:42d7 with SMTP id c14-20020a056512074e00b004fbca5942d7mr1135328lfs.33.1691150739456;
        Fri, 04 Aug 2023 05:05:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d19-20020aa7d693000000b0051ded17b30bsm1172597edr.40.2023.08.04.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:05:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/setlocalversion: also consider annotated tags of the form vx.y.z-${file_localversion}
Date:   Fri,  4 Aug 2023 14:05:36 +0200
Message-Id: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v2: explicitly initialize desc to empty [Masahiro]

 scripts/setlocalversion | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 3d3babac8298..e2f49e237565 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -57,21 +57,37 @@ scm_version()
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
+	desc=
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
@@ -81,8 +97,8 @@ scm_version()
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

