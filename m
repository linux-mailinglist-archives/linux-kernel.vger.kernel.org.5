Return-Path: <linux-kernel+bounces-121432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778EF88E7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E351F34E79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91347148307;
	Wed, 27 Mar 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VwnaqOt8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87B147C80
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549569; cv=none; b=MW6TrN9rt30xOpzKmcvKq+SG/iIl0tkxZBgIL83PYHPYKgEoLYMrS51FLhjoaEO5SsXZEhSF9815fTRcrzDovkFu9NRfTA4LO7ldi0+R22rnAFN5uDDVnpPMBbK3jOlB+bSoXri4E7VzD1k5fdoCL+rkTu+aEjIXmuwSrUrCGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549569; c=relaxed/simple;
	bh=F584rvY9Ael/CReGADwrBnGTlfcFElRXi+daopA8MFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChxINEtM7gUa8NGa8wWQLT0uaP9uzMjKLxBI5Kv1tGsRL8+w4wGpzbl7ecf1f61SrWzt0BucZFI2p4WFJLAZbcYGIyYJqlIUDZlauGNyY0GrKsgHVkFl+n39PiQrKl+qpkWsUf4IDNtrJ2ijbrCOJb4LBKnzf9WsRAqL6QwHvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VwnaqOt8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4149744de85so1785765e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711549565; x=1712154365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73OCrYqPUt68WHM39Ot0cX5xtXg6EOrolRVcpBahWYE=;
        b=VwnaqOt8CHodoxAn5Z3v6SHUw0B1e0qaXh4xRhu2dWCFD+Xh/hzwZmLUooIEQbAEA7
         QevdUtR8Chag0mLr5spQWgt50hbvSSAVixg9WuG62RB8T42fb8i3cJabyzE+k5Zj3QH6
         eXCMgXJvl+e+izffjHNLyVj0hAA4YVsZAVtHR/7TGGCmmn/usBEw6Bg5H5m66WqkTCpI
         lvbq7CYUbqIRtXRdFMsJlh34pG6kDUmVlr3Dr9McaZnPRHGEDt2izWYSLrqubU0e6x9T
         M3/wEL2Og8eru9QtZdPLqKpBMtqpyFdJipbEjGWH9o1WXOLRWLhPFhg8KwnazkT4P0LO
         ZCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549565; x=1712154365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73OCrYqPUt68WHM39Ot0cX5xtXg6EOrolRVcpBahWYE=;
        b=ZIyNSoax1uJMF1ahCFcjpcRq96wDpVPRafYcuEUydQzpxpUtEmcGFG2glV+Etpdb+8
         f6+uf2q2mNaoZYBls+P7ERqo5BEuJzk38OlzADAdPUDPh74LvJSDn4GINXYSpNXFbtqu
         xQSGZkgPturaq26/FatSHkK1JFOGRwj0yIi2Ou4Z4g8SQ2Gq9aF9Gpi59Z3zrzN6GmkD
         xNcjfOUzqxmW82divQS7weUeVFCeoQ8hvCmgtFEKL1JHv6ugcAY+J9NkHrj0KD/OZblY
         BeerG/2UHKPjMNc1hlXf8jOJ3EWxBTtxYGGH1t5quteC5U5/FFavB439+C3sSctayxSy
         CN0Q==
X-Gm-Message-State: AOJu0YyUqX8ZrdIEkwIBuAY8THoG0GJF19+hicUcwZ7R+/5p5r4YEaKy
	ipgylNM28xxcX0GBGKNqZkOsq523rXXYA2Dg8nP927yr4GD79AiZ4wf65WrtDzI=
X-Google-Smtp-Source: AGHT+IFikmKCrEwbGhQWaJgcSA86RpedL07E6S4CyB+EWdx+XRR9TNGvX7Sb7pDA6ciMSYIHD8Nm5A==
X-Received: by 2002:a05:600c:4f44:b0:414:902c:f8ba with SMTP id m4-20020a05600c4f4400b00414902cf8bamr159238wmq.1.1711549564473;
        Wed, 27 Mar 2024 07:26:04 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm2300840wms.20.2024.03.27.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:26:04 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [RFC 2/2] scripts: Add fzfconfig helper script
Date: Wed, 27 Mar 2024 15:25:44 +0100
Message-ID: <20240327142544.1728286-3-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327142544.1728286-1-msp@baylibre.com>
References: <20240327142544.1728286-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a script to present all config options in fzf. This allows to fuzzy
search in all config options and their help texts. It also displays the
configuration state in the list. A preview window shows the actual
Kconfig snippet for the config option.

Using 'Enter' in the displayed list will open 'make menuconfig' and
automatically execute a search for the selected symbol. After that the
user can use the menuconfig to change the option or do other things.
After exiting menuconfig the fzf list is refreshed and you can continue
navigating the list from the point where you entered menuconfig.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 scripts/fzfconfig        | 112 +++++++++++++++++++++++++++++++++++++++
 scripts/kconfig/Makefile |   4 ++
 2 files changed, 116 insertions(+)
 create mode 100755 scripts/fzfconfig

diff --git a/scripts/fzfconfig b/scripts/fzfconfig
new file mode 100755
index 000000000000..48f9590c1031
--- /dev/null
+++ b/scripts/fzfconfig
@@ -0,0 +1,112 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Author: Markus Schneider-Pargmann <msp@baylibre.com>
+#
+# List all config options inside of fzf and offer an easy option to jump to the
+# option in menuconfig
+
+config_script="scripts/config --file $KCONFIG_CONFIG"
+
+history_file="$HOME/.cache/kconfig_fzf.hist"
+
+kconfig_fzf_clenup_on_exit() {
+  rm -f "$menucfgpipe"
+}
+
+kconfig_fzf_oneline_config_items() {
+  make helpallconfig | \
+    grep -vE '^(Type  :|  Depends on:|  Visible if:|Selects:|Selected by|CONFIG_)' | \
+    sed 's/^  Prompt: \(.*\)$/1111111111\11111111111/g' | \
+    tr '\n' ' ' | \
+    sed 's/----- -----/\n/g' | \
+    sed 's/\(^ *\|-----\)//g' | \
+    sed 's/  */ /g' | \
+    sed 's/^\(.*\)1111111111\(.*\)1111111111\(.*\)/\t\2:\1\3/g' | \
+    sed 's/^\([^\t].*\)$/\t:\1/g' | \
+    sed 's/^\(.*\)Symbol: \([^ ]*\) \[\([^]]\{1,40\}\)[^]]*\].*Defined at \([^:]*\):\([0-9]*\) .*$/\4:\5\t:\2\3:\1/g' | \
+    grep -E '^.*:[0-9]*	:.*=.*:'
+}
+
+kconfig_fzf_make_menuconfig() {
+  menucfgpipe="$(mktemp --dry-run)"
+  trap kconfig_fzf_clenup_on_exit EXIT
+  mkfifo "$menucfgpipe"
+
+  make menuconfig < "$menucfgpipe" &
+  menuconfigpid=$!
+
+  echo "/^${1}\$" > "$menucfgpipe"
+
+  cat > "$menucfgpipe" < /dev/stdin &
+  redirectpid=$!
+
+  wait $menuconfigpid
+  kill $redirectpid
+}
+
+kconfig_fzf_get_catcmd() {
+  for cmd in bat batcat
+  do
+    if which $cmd > /dev/null
+    then
+      echo $cmd \
+        --paging=never \
+        --force-colorization \
+        --highlight-line {2}
+      return
+    fi
+  done
+  echo 'echo -e "+----------\n| "File: {1}:{2}"\n+----------"; cat --number'
+  exit 0
+}
+
+kconfig_fzf_command() {
+  menuconfig_action="execute(bash -c \"source $0;"' kconfig_fzf_make_menuconfig \$(echo {3} | cut -d '=' -f 1)")'
+  reload_action="reload(bash -c 'source $0; kconfig_fzf_oneline_config_items')"
+  catcmd="$(kconfig_fzf_get_catcmd)"
+
+  kconfig_fzf_oneline_config_items | column --table --separator '	' | \
+    env SHELL=/bin/bash \
+    fzf \
+      --history="$history_file" \
+      --tiebreak=begin \
+      --delimiter=: \
+      --nth=.. \
+      --with-nth=3,4 \
+      --preview "$catcmd"' \
+        "${srctree:-.}/"{1}' \
+      --preview-window 'right,90,+{2}-5,~3' \
+      --bind "ctrl-r:${reload_action}" \
+      --bind "ctrl-g:execute(echo \"'{}'\"; read)" \
+      --bind "enter:${menuconfig_action}+${reload_action}" \
+      --header 'enter: Open in menuconfig, ctrl-r: Reload, esc: Exit'
+    if [ "$?" -eq 130 ]
+    then
+      return 0
+    fi
+    return "$ret"
+}
+
+if [ "$#" -gt "0" ]
+then
+  echo "USAGE: $0"
+  echo ""
+  echo "Show all kconfig symbols in fzf and open selected item on enter in make menuconfig."
+  echo ""
+  echo "You can fuzzy search in these data fields: <KCONFIG_FILE>:<LINENO>:<CONFIG_SYMBOL>=<VALUE>:<PROMPT>:<HELP>."
+  echo "Not all fields are visible but the search is still done."
+  echo "A preview of the Kconfig file is shown on the right side."
+  echo ""
+  echo "Key bindings:"
+  echo "  Enter : Open symbol in make menuconfig"
+  echo "  CTRL-r: Reload config symbols"
+  echo "  Escape: Exit"
+  exit 0
+fi
+
+(return 0 2>/dev/null) && kconfig_fzf_sourced=1
+if [ "$kconfig_fzf_sourced" != "1" ]
+then
+  kconfig_fzf_command
+fi
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 87df82c03afb..1f47b9ae9786 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -124,6 +124,10 @@ testconfig: $(obj)/conf
 	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=no)
 clean-files += tests/.cache
 
+PHONY += fzfconfig
+fzfconfig:
+	$(srctree)/scripts/fzfconfig
+
 # Help text used by make help
 help:
 	@echo  'Configuration targets:'
-- 
2.43.0


