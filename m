Return-Path: <linux-kernel+bounces-108151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0D8806B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1141C22282
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D44F200;
	Tue, 19 Mar 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ggEPHDnS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DC3C488
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883528; cv=none; b=jP+4PLsr7iyICWqTbX65WQqg17ANeagIS5KB4qq4CxwPQKOUbFRmnmIBC4b2ZMvChmNjss3KhLx2VYj0s0zMwJAUcdUNqP+ohYwp8zvFxw0m0GeD05Dh/6NpUUrCP3+UuB83l6Fls2oUmgZprHtum1tJxJWX2v8upBeS5lQSj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883528; c=relaxed/simple;
	bh=KkOVhzkgyAjCGaKaPgGzdIzZ47G+N0AsLX8VMEEZgzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mOPB2UMFtay3l0khfOA9HEAr6LI5U4Nr3ZR05Po3hxochQL9ftA0MOKICnpTHMy+sV/mGZ4raonQxz7v8WQhSygarVYUcdrR04I7aKxf1/YphD/0UD1LxrgBcJj4NFbLKSzLhv1LoU0+V8MvpQXqvB4xmAqhu8cvPKWTyCJ8CY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ggEPHDnS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710883525;
	bh=KkOVhzkgyAjCGaKaPgGzdIzZ47G+N0AsLX8VMEEZgzY=;
	h=From:Date:Subject:To:Cc:From;
	b=ggEPHDnSvHmLhfPXwBmW9Z3T7bw22e94cgd83syTrmM3VLhFyM3/RrWqP74xE54/E
	 /pLhe7dn8BQcqoUeUM7iqyqkfqlx6CAsC/nkej5clTijPYLgiIWsFENGZsWuK5ni3S
	 riFcLD3OvrHVRW9GmzH8n4IRDG1METvsYgiWhTZZAw2HzFcAdE7pb5RYsfY1D8Qcfs
	 bUBxlFfJnfvmUfCtMPu9THbP56l849MpACglAzwE/pf3kUVMJ8mT8sqS3wEAv6lN39
	 NmmMR/zvCRjozAF9btke8UHih4msLUSSibuqFMmjPj+0rdYa4L6nNBiiQid2YPtdRA
	 OafLCIyR0ufWw==
Received: from [192.168.1.91] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D0B437809D0;
	Tue, 19 Mar 2024 21:25:24 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 19 Mar 2024 17:24:26 -0400
Subject: [PATCH] scripts: Add utility to convert make's output into JSON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240319-make-to-json-script-v1-1-621cc4d502cb@collabora.com>
X-B4-Tracking: v=1; b=H4sIAIkC+mUC/x3MQQ5AMBBA0avIrE3S0mi4ilgUgyFa6YhIxN01l
 m/x/wNCkUmgyR6IdLFw8Ak6z2BYnJ8JeUyGQhVGlbrG3W2EZ8BVgkcZIh8n2spoVfaTNaOFVB6
 RJr7/a9u97wfA9/tLZQAAAA==
To: Masahiro Yamada <masahiroy@kernel.org>, Rob Herring <robh@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

The output from make isn't well suited for machines: reading it requires
hardcoding details of the formatting of commands from make.

Add a script that parses the output from make and outputs it in a well
structured format in JSON. This allows third party programs to parse the
make output without caring about formatting details, which stay in the
kernel tree.

For a given command line from make's output:
  DTC_CHK arch/arm64/boot/dts/actions/s700-cubieboard7.dtb

where DTC_CHK is the command, arch/.../s700-cubieboard7.dtb is the
target and any non-command lines that follow it are the command's
output, the generated JSON output is in the format:
[
    ...,
    {
        "command": "DTC_CHK",
        "target": "arch/arm64/boot/dts/actions/s700-cubieboard7.dtb",
        "output": "<any following non-command lines>"
    },
    ...
]

This assumes the output from a command immediately follows it. If
building with multiple jobs (`make -j`), the `--output-sync` argument
also needs to be supplied to make in order for the output fields to be
correctly set.

For an example of the usage of this script, consider `make dtbs_check`
generates a very long output in the following format:

  DTC_CHK arch/arm64/boot/dts/arm/foundation-v8-psci.dtb
  DTC_CHK arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dtb
/tmp/kci/linux/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dtb: thermal-zones: gpu0-thermal: 'trips' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
/tmp/kci/linux/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dtb: thermal-zones: gpu1-thermal: 'trips' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
  DTC_CHK arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dtb

With this output converted into JSON, it will be much simpler to
identify that only the middle DTB in this example produces warnings. By
extension, CIs will be able to more easily report which DTBs are
currently producing warnings and which are not, and identify
regressions.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Hi,
I'm not sure which subsystem this script would be a part of, which is
why I haven't added an entry in MAINTAINERS. Suggestions appreciated.
---
 scripts/make-to-json.py | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/scripts/make-to-json.py b/scripts/make-to-json.py
new file mode 100755
index 000000000000..7570134f6151
--- /dev/null
+++ b/scripts/make-to-json.py
@@ -0,0 +1,51 @@
+#!/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Collabora Ltd
+#
+# Transform the output from make into JSON. This makes it easier for machines to
+# parse.
+#
+# NOTE: This assumes the output from a command immediately follows it. If
+# building with multiple jobs (`make -j`), make sure to also pass
+# `--output-sync`.
+#
+# Command lines from make are in the format:
+#   DTC_CHK arch/arm64/boot/dts/actions/s700-cubieboard7.dtb
+#
+# where DTC_CHK is the command, arch/.../s700-cubieboard7.dtb is the target and
+# any non-command lines that follow it are the command's output.
+#
+# The JSON output is in the format:
+# [
+#     {
+#         "command": "DTC_CHK",
+#         "target": "arch/arm64/boot/dts/actions/s700-cubieboard7.dtb",
+#         "output": ""
+#     },
+#     ...
+# ]
+
+import json
+import re
+import sys
+
+make_cmd_re = re.compile(r"^  (?P<command>[A-Z0-9_.]{1,8}( \[M\])?) +(?P<target>.*)")
+
+make_output = []
+step = {}
+
+for line in sys.stdin:
+    match = make_cmd_re.match(line)
+    if match:
+        if step:
+            make_output.append(step)  # save previous step, if any
+        step = {}
+        step["command"] = match.group("command")
+        step["target"] = match.group("target")
+        step["output"] = ""
+    else:
+        step["output"] += line
+if step:
+    make_output.append(step)  # save last step, if any
+
+json.dump(make_output, sys.stdout)

---
base-commit: dad309222e4c3fc7f88b20ce725ce1e0eea07cc7
change-id: 20240319-make-to-json-script-764103bf74d7

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


