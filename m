Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32176BBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjHARub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHARuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8A2100
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690912179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYUWXb5VBW1ndzfLEcQ3Dy13isLM6VUOP91Qx2qKRhg=;
        b=KTpjpZR+i/NGJdjx3AOW/D2UJSdcbka5+uG6x6z6w84iasxDUp3cWVakMRLwXVSSJ70Ulp
        3IoBmOUbTWCTt1EdZSoKACqHCSjP/lphF8giGQdcgqsgwR3DTUNZ5Sho3oLPt6x5wRaHnr
        0Z+5YRYjEfEKUFSePJWxUgIIlkq1qII=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-TRJqXeB3Ojio9d8b3IMMPw-1; Tue, 01 Aug 2023 13:49:38 -0400
X-MC-Unique: TRJqXeB3Ojio9d8b3IMMPw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-58440eb872aso76041867b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690912177; x=1691516977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYUWXb5VBW1ndzfLEcQ3Dy13isLM6VUOP91Qx2qKRhg=;
        b=I29oMLUS/ywi8Xc1b1khO8WCRYVNkkJr1KscmzhMvfQY6vGzFPnbll4TB7V+WlBUS8
         UC5iphhcy1iP3UPTd15J99y125cpwRXJP60FrrmvKPh2ua1/+Z0FMvFV40nz5FiVudKO
         CWJe4YaYxXDDfkx3t1vZgYz9H1659vpTfbNCMsYM3NE/f4Vx8g+o/yMjkreltUQp9HBn
         8KFdRhcCiPWt1Bo3qdxLN6siw002e8fENO+rh3ldhkpI6BKdkUIe16HW16g6xbYxcH1w
         pav51g75czXsXjQMeXhJxmBJf1zsDYymxmiPBwgGag5dim4yC+qr5HjDxtJwP9bICpoZ
         u/ZA==
X-Gm-Message-State: ABy/qLYBQPJhSTyD9iHETHyYoOu3Urd1mWrCVsqe4XlEinO6ksLXlTjV
        T3Y5S8chgk7EQizkLE3L7YB2LmwPdg4U6SvKOZQKMkJSgF9oA84nwQUazBpa+k92vQzn1WV3XzL
        AAhA0Vbi5QUdO1MFXWqy7xrBzpY0zsoOp
X-Received: by 2002:a81:83cf:0:b0:570:6fbd:2daf with SMTP id t198-20020a8183cf000000b005706fbd2dafmr16026115ywf.37.1690912177470;
        Tue, 01 Aug 2023 10:49:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEx/rTzRu8VRjCf/p3Bv17M0mRYJt5gkfqTtA7hsbvwsSFovUUUg5LKF0PGAKJJ27eO3PqixA==
X-Received: by 2002:a81:83cf:0:b0:570:6fbd:2daf with SMTP id t198-20020a8183cf000000b005706fbd2dafmr16026104ywf.37.1690912177215;
        Tue, 01 Aug 2023 10:49:37 -0700 (PDT)
Received: from brian-x1.. ([2600:381:222b:e67:295d:9324:c84:3382])
        by smtp.gmail.com with ESMTPSA id k187-20020a0dc8c4000000b005773afca47bsm3881728ywd.27.2023.08.01.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:49:36 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 1/2] scripts: add mod-to-kconfig.sh
Date:   Tue,  1 Aug 2023 13:49:21 -0400
Message-ID: <20230801174922.333700-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801174922.333700-1-bmasney@redhat.com>
References: <20230801174922.333700-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a useful script that can be used to convert a kernel module path
to the relevant Kconfig symbol name. Examples showing how to use this
is in the help at the top of the script.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 scripts/kconfig/mod-to-kconfig.sh | 93 +++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 scripts/kconfig/mod-to-kconfig.sh

diff --git a/scripts/kconfig/mod-to-kconfig.sh b/scripts/kconfig/mod-to-kconfig.sh
new file mode 100755
index 000000000000..1b69b638ebf5
--- /dev/null
+++ b/scripts/kconfig/mod-to-kconfig.sh
@@ -0,0 +1,93 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+# Written by Brian Masney <bmasney@redhat.com>
+#
+# This script takes as input one or more kernel module names, and outputs
+# the relevant Kconfig symbol name. This script was originally intended to help
+# identify which Kconfig options are enabled inside an initramfs.
+#
+#   x1:~/src/linux$ find /usr/lib/modules/`uname -r` -name *.ko.xz | \
+#                       ./scripts/kconfig/mod-to-kconfig.sh
+#   CONFIG_CRYPTO_USER
+#   CONFIG_CRYPTO_ESSIV
+#   CONFIG_CRYPTO_CHACHA20
+#   CONFIG_CRYPTO_TWOFISH
+#   ...
+#
+# You can also use this to walk the modules.builtin file:
+#
+#     x1:~/src/linux$ ./scripts/kconfig/mod-to-kconfig.sh < \
+#            /usr/lib/modules/`uname -r`/modules.builtin
+#
+# Pipe the output of this script into scripts/kconfig/lookup.sh if you want to
+# view the full Kconfig entries.
+#
+# Note that there is a fair bit of variability in the Makefiles across the
+# kernel and this script won't match everything. It's only been written to
+# cover the 95% use case.
+
+process_module()
+{
+	# We may have a full path, like /usr/lib/modules/`uname -r`/kernel/...`,
+	# or a relative path, like kernel/... that's found in modules.builtin.
+	local DIR
+	DIR=$(dirname "$1")
+	if [[ "${DIR}" =~ ^/ ]] ; then
+		DIR=${DIR##*/kernel/}
+	else
+		DIR=${DIR##kernel/}
+	fi
+
+	# Handle compressed module names
+	local MOD_NAME
+	MOD_NAME=$(basename "$1")
+	MOD_NAME="${MOD_NAME/.xz/}" # CONFIG_FW_LOADER_COMPRESS_XZ
+	MOD_NAME="${MOD_NAME/.zst/}" # CONFIG_FW_LOADER_COMPRESS_ZSTD
+	MOD_NAME="${MOD_NAME/.ko/}"
+	MOD_NAME="${MOD_NAME/.c/}"
+
+	local MAKEFILE
+	MAKEFILE="${DIR}/Makefile"
+	if [ ! -f "${MAKEFILE}" ] ; then
+		echo "Skipping $1 since ${MAKEFILE} is not found" >&2
+		return 1
+	fi
+
+	# There's probably a more elegant way you could do this with sed or awk,
+	# however personally I find this approach more readable in this
+	# particular case.
+	local CONFIG
+	CONFIG=$(grep --before-context=200 -w -E "${MOD_NAME}(\.o|/)" \
+		 "${DIR}/Makefile" | grep CONFIG_ | tail -n 1 | \
+		 awk -F\( '{print $2}' | awk -F\) '{print $1}')
+	if [ "${CONFIG}" = "" ] ; then
+		echo "Skipping $1 since CONFIG cannot be determined" >&2
+		return 1
+	fi
+	echo "${CONFIG}"
+}
+
+# Run this script from the toplevel kernel source directory.
+SCRIPT_PATH=$(readlink -f "$0")
+cd "$(dirname "${SCRIPT_PATH}")/../.." || exit 1
+
+RET=0
+if [[ $# == 0 ]] ; then
+	# Read module paths from stdin
+	while read -r MODULE_PATH ; do
+		if ! process_module "${MODULE_PATH}" ; then
+			RET=1
+		fi
+	done
+else
+	# Read module paths from the command line arguments
+	for NUM in $(seq 1 "$#") ; do
+		if ! process_module "${!NUM}" ; then
+			RET=1
+		fi
+	done
+fi
+
+exit "${RET}"
-- 
2.41.0

