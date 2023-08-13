Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCFB77AB3A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHMUgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:36:03 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C91E5B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:36:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-790ca0ed6d3so117882439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691958963; x=1692563763;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iOirdFXAoR4Dw5/bPjx/MkVB+PbXDe73OjSK0jH83c=;
        b=Q7j+GZAQELuXA+fkPVYYc2MCLGuNFdpba8u9NPav5G6xgAZwmnfe/hu/EroDvFfNRx
         u1PM5Y23qwjzYO838EHiidTRsVhEsutMjyAwh6bp4vQwl2edIo+EK0X+lodcx6/IFAca
         7rapvLC94KaC4ykdFUwGylYJ4+5nE4c5nZQlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691958963; x=1692563763;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iOirdFXAoR4Dw5/bPjx/MkVB+PbXDe73OjSK0jH83c=;
        b=dqqpxkLsdKY+B3rO/ep9ChfDq+xYkODbDsHpbCga2hYfkAm5jdyx+jUTaCd55LU8ig
         kv3+WHi+idXu9ZeWUJ8dO64fnbgomMzKsa0gaI0WTD3gpRjQ3KxhVVuBLQX+wLKoEWcD
         nYFoiACUQYWgC/ZSu8Uceui2Y+elk1LZwJ+QvFUs2sT12xUPofiivj8+LKjjEQcb7o+v
         Jlk2i63jrBoY5D06S2NsWIFPYyydp7rxg0qkAqPANP+WZs2LujmEuRpddDDHRxTYcQRO
         uXqw42LiCcsz7Q8SPSFv+Fh11nbu6A1Flm/N1aXJIw/6e0Zesy41iftcaVstj5OiiCgv
         LbsQ==
X-Gm-Message-State: AOJu0YwYOXhL+Yfzyd3se98MHwhCshCGXIMQtXli26vNJm8Vd1pM2zfB
        sOR1/GbLhJBzMrV8jRIpPz1a0Q3LDhRsp5dtVJo=
X-Google-Smtp-Source: AGHT+IFbDXxmLldQoWKZd5uSmnRGDGphEDAM5QfwwW4+ElNvXFWN1Z5dMNo0UGjx7wHHJYzCe9hSeQ==
X-Received: by 2002:a05:6e02:2162:b0:345:d2fe:da92 with SMTP id s2-20020a056e02216200b00345d2feda92mr11738497ilv.10.1691958963068;
        Sun, 13 Aug 2023 13:36:03 -0700 (PDT)
Received: from localhost (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id x14-20020a02ac8e000000b0042b27413760sm2522937jan.142.2023.08.13.13.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 13:36:02 -0700 (PDT)
Date:   Sun, 13 Aug 2023 20:36:02 +0000
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel <agnel.joel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] rcutorture: Copy out ftrace into its own console file
Message-ID: <20230813203602.GA696907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes (Google) <joel@joelfernandes.org>

Often times during debugging, it is difficult to jump to the ftrace dump
in the console log and treat it independent of the result of the log file.
Copy the contents of the buffers into its own file to make it easier to refer
to the ftrace dump. The original ftrace dump is still available in the
console log if it is desired to refer to it there.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1-v2: Change log updates, "From:" updates.

 .../selftests/rcutorture/bin/functions.sh     | 24 +++++++++++++++++++
 .../selftests/rcutorture/bin/parse-console.sh |  7 ++++++
 2 files changed, 31 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..2ec4ab87a7f0
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,27 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output looks in the logs looks like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+        awk '
+        /Dumping ftrace buffer:/ {
+        capture = 1
+        next
+    }
+    /---------------------------------/ {
+        if(capture == 1) {
+            capture = 2
+            next
+        } else if(capture == 2) {
+            capture = 0
+        }
+    }
+    capture == 2
+    ' "$1";
+}
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9ab0f6bc172c..e3d2f69ec0fb 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -182,3 +182,10 @@ if ! test -s $file.diags
 then
 	rm -f $file.diags
 fi
+
+# Call extract_ftrace_from_console function, if the output is empty,
+# don't create $file.ftrace. Otherwise output the results to $file.ftrace
+extract_ftrace_from_console $file > $file.ftrace
+if [ ! -s $file.ftrace ]; then
+	rm -f $file.ftrace
+fi
-- 
2.41.0.640.ga95def55d0-goog

