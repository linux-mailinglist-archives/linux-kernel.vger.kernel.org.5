Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4481576705D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjG1PUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjG1PUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:20:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371F3580;
        Fri, 28 Jul 2023 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690557577; x=1691162377; i=georgmueller@gmx.net;
 bh=b3jqgX/FTTLcKkdYTNRXpA+IdOm+qzwJHmsQNLmI1uU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Au1ml8XDHLXynrUV8DlBalRIcMriKlIfa/JY3oyDsDRFUxYctTyvfFHyTLbqPWP86nQQMRJ
 sfG0BqIZUF/jauJ0nTh+EGXtvpokFemJSvMxczmd4WN0ChWlD95XFPyOs5U5inK1j8oeew52R
 I9KfFimeUTO9opBX04yXYfP4Xam97NCwylY2Uzm/LI+Jmz1uh7RI8RmYA9ifgZTVTAkQk08KT
 oJpff1BuuxwddxcxkqdVmeXJlE3p2FuorJRHToTjSN6qKLNnqeUxwmlgKtu2asdTfcJXZOptL
 hd0Ms6xR0vrIpF0U58drb8PbwoqnJmBLrfRHqjsCwOPX53bhptEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.95.128]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MNKhm-1qDlUR1VOM-00OmRl; Fri, 28 Jul 2023 17:19:37 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf probe: skip test_uprobe_from_different_cu if there is no gcc
Date:   Fri, 28 Jul 2023 17:18:12 +0200
Message-ID: <20230728151812.454806-2-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9aWZpPGLTw7RvMYEc6PyMQraGPcqSqMmqLsqlB27y8SL4tymPT
 4U0T4Z0aLLKEDVa5w8FH396x9LvRJwJNSpciBAKf+smlTwcjvoppabzCjWFwduTB1ene+cD
 7aYLRhREyOqFjQtlt1F1oXKFIhqRTK1MhVjnP2xBN8UhraMAR0xL8y1ktYZ5MPjs/P3yTIU
 ho0krwrrCfC71WAFAOyiw==
UI-OutboundReport: notjunk:1;M01:P0:6l98EEo7XGA=;nrweatGZcCzoena6WSFTgnmI6zm
 F9e3quy9tezodLsvqxrCn68geGjN+MWnDI+XiK3NSSVumYveNNgEykIEsiqbgilNeFeviOy5P
 NdbSB+GZRGHN3Iyu0ZxQg/9U5SZxLr6wmH8Z8ZRoDqmwzb2R1j5n003tJCerNbhgumgEzVSI4
 eQHj5heFbOc3Civb0Nk1KYsCMdVbYk0yJofhPtxZzzFDO424mQt+LssqPard6Vqnvz4Y4iwoc
 vU5z8MoAFAJ53nM6ozjbvfEJNu7qPVwAoDSrH3pwsx+Aj5i6wfuxR4rEZQ7zsM7zbtFG9M2dB
 Wa8Y/YTZGxPdsTnSFj93I1SBM2/aVLwMWWy/ZqO0bCLsBKI1qsy0Mclb0CsoxewMIQ20zN35G
 yoaLIRT11vGAaiVKRp3FLC/7ytcno/xpxZFOhBVI3u0uhaUgBtl7o8qZvNK+HomaOm+oHHhzV
 Lnr2c4k51VmWOY/+/BRxUqVSKfrCGj+tRLHfipUt/WE5lNgxdGGiLCI4H0SizIZgv9jNjc7Ew
 ZllJ8NHuiAplGyh0plH+3VCDzlmr8fVAEUkjdIn4hgtl4cNU+p0lnqN5DgWbaLJ/YntuJ6/q8
 gmZMK2ke8hMmfeO7hPWHgQbdRJ0JmEVB7nsRRBGqv3h9MocJHvoi1pz0sjCmEsDtD8+FVjNQJ
 7yuo9NEmuBJBBfYW/LrZP4F9RRZNdyj1ch37n1J+0oquHdAhzQoR85wKyproFd1akHsUO266m
 dy3wTk8eWKY/kTS+62+yvQxKPFpakdQ9ec9POz1GwIKkpGa7POUot9Uni5QFHGKrYgKhVLg0x
 t5ZEt0cwxyGL/NF//7E7JBn7dZfYKnZwcTV7oaZet+LnlxCNAMlcINrjbXaWYam90zCxVFAkL
 8NFCaN05zAJVP4qHJL3FFox6BQcwcDNwhSzo/yYBbLnXJeq1cE1tBAWL4zsNH+Lxq5sydponE
 0c8WIw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without gcc, the test will fail.

On cleanup, ignore probe removal errors. Otherwise, in case of an error
adding the probe, the temporary directory is not removed.

Fixes: 56cbeacf1435 ("perf probe: Add test for regression introduced by sw=
itch to die_get_decl_file()")
Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/CAP-5=3DfUP6UuLgRty3t2=3DfQsQi3k4hDMz415vW=
dp1x88QMvZ8ug@mail.gmail.com/
=2D--
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/too=
ls/perf/tests/shell/test_uprobe_from_different_cu.sh
index 00d2e0e2e0c2..319f36ebb9a4 100755
=2D-- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,12 @@

 set -e

+# skip if there's no gcc
+if ! [ -x "$(command -v gcc)" ]; then
+        echo "failed: no gcc compiler"
+        exit 2
+fi
+
 temp_dir=3D$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)

 cleanup()
@@ -11,7 +17,7 @@ cleanup()
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =3D~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo
+		perf probe -x ${temp_dir}/testfile -d foo || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
=2D-
2.41.0

