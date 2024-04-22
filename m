Return-Path: <linux-kernel+bounces-152812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F18AC49D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934EE2817C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D033848781;
	Mon, 22 Apr 2024 06:59:27 +0000 (UTC)
Received: from hust.edu.cn (unknown [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B861391;
	Mon, 22 Apr 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769167; cv=none; b=aYIMXeWIxK/ng521eBnYGo271b7cu4uSTBKipmG/46B5DkUTwQXddcYPNbEDC+7HaovR9YMEYbZQXzL1TsCjlnwzIpeV6/FHfw+zF7qg/UJ7vqY7ytRQCIX8wYqfSBaqrdHXqqrYjluRgJqO2WGlEH13Zg5ou6KJ9XNVEQQz5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769167; c=relaxed/simple;
	bh=2ogYp+srszOcE6Ovo5GFA3DdV2gZfv5XNhxq6YQGH/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iI9BFdB/lcqkBUX41q703ERgYZrr1DOCIMwEoJgC+WpefQ8Nxtp5SAORbxgghJXMUPzLzfTcdqdYXMZ/zOjSwJ5CgeDQgwQswNrseUBdGZOUCemGEFkyRaJnbg21HfU05bn1Du3a3NNyjYJpecs2DjdLbZxhZDwPR2r2ys2t1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAAnLoKoCiZmBRBGBQ--.60769S2;
	Mon, 22 Apr 2024 14:58:48 +0800 (CST)
Received: from Chengziqiu-Lab-Desktop.. (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCHcC6QCiZm3LchAQ--.51477S2;
	Mon, 22 Apr 2024 14:58:46 +0800 (CST)
From: Cheng Ziqiu <chengziqiu@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hust-os-kernel-patches@googlegroups.com,
	Cheng Ziqiu <chengziqiu@hust.edu.cn>
Subject: [PATCH] scripts: add `check-trans-update.py`
Date: Mon, 22 Apr 2024 14:58:22 +0800
Message-Id: <20240422065822.1441611-1-chengziqiu@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAAnLoKoCiZmBRBGBQ--.60769S2
Authentication-Results: app1; spf=neutral smtp.mail=chengziqiu@hust.ed
	u.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWrtr17Jw18Kry8Jw15twb_yoW7Cr4Upa
	45Cay2yr4rAFZrJrs3Ja15uFWayrnxJF4jqryIgr9rArW7K34F9FWIkrySvrZ7WF1rX3sI
	g3WFyF1jkF17uaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IUnYYLPUUUUU==
X-CM-SenderInfo: bpsqjjaxrxkmo6kx23oohg3hdfq/

The `check-trans-update.py` scripts check whether a translated version
of a documentation is up-to-date with the english version.

The scripts use `git log` commit to find the latest english commit from
the translation commit (order by author date) and the latest english
commits from HEAD. If differences occurs, report the file and commits
need to be updated.

Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
---
 scripts/check-trans-update.py | 176 ++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100755 scripts/check-trans-update.py

diff --git a/scripts/check-trans-update.py b/scripts/check-trans-update.py
new file mode 100755
index 000000000000..0f913c5c4555
--- /dev/null
+++ b/scripts/check-trans-update.py
@@ -0,0 +1,176 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+from argparse import ArgumentParser, BooleanOptionalAction
+from datetime import datetime
+
+flag_p_c = False
+flag_p_uf = False
+flag_debug = False
+
+
+def dprint(*args, **kwargs):
+    if flag_debug:
+        print("[DEBUG] ", end="")
+        print(*args, **kwargs)
+
+
+def get_origin_path(file_path):
+    paths = file_path.split("/")
+    tidx = paths.index("translations")
+    opaths = paths[:tidx]
+    opaths += paths[tidx + 2 :]
+    return "/".join(opaths)
+
+
+def get_latest_commit_from(file_path, commit):
+    command = "git log --pretty=format:%H%n%aD%n%cD%n%n%B {} -1 -- {}".format(
+        commit, file_path
+    )
+    dprint(command)
+    pipe = os.popen(command)
+    result = pipe.read()
+    result = result.split("\n")
+    if len(result) <= 1:
+        return None
+
+    dprint("Result: {}".format(result[0]))
+
+    return {
+        "hash": result[0],
+        "author_date": datetime.strptime(result[1], "%a, %d %b %Y %H:%M:%S %z"),
+        "commit_date": datetime.strptime(result[2], "%a, %d %b %Y %H:%M:%S %z"),
+        "message": result[4:],
+    }
+
+
+def get_origin_from_trans(origin_path, t_from_head):
+    o_from_t = get_latest_commit_from(origin_path, t_from_head["hash"])
+    while o_from_t is not None and o_from_t["author_date"] > t_from_head["author_date"]:
+        o_from_t = get_latest_commit_from(origin_path, o_from_t["hash"] + "^")
+    if o_from_t is not None:
+        dprint("tracked origin commit id: {}".format(o_from_t["hash"]))
+    return o_from_t
+
+
+def get_commits_count_between(opath, commit1, commit2):
+    command = "git log --pretty=format:%H {}...{} -- {}".format(commit1, commit2, opath)
+    dprint(command)
+    pipe = os.popen(command)
+    result = pipe.read().split("\n")
+    # filter out empty lines
+    result = list(filter(lambda x: x != "", result))
+    return result
+
+
+def check_per_file(file_path):
+    opath = get_origin_path(file_path)
+
+    if not os.path.isfile(opath):
+        dprint("Error: Cannot find the origin path for {}".format(file_path))
+        return
+
+    o_from_head = get_latest_commit_from(opath, "HEAD")
+    t_from_head = get_latest_commit_from(file_path, "HEAD")
+
+    if o_from_head is None or t_from_head is None:
+        print("Error: Cannot find the latest commit for {}".format(file_path))
+        return
+
+    o_from_t = get_origin_from_trans(opath, t_from_head)
+
+    if o_from_t is None:
+        print("Error: Cannot find the latest origin commit for {}".format(file_path))
+        return
+
+    if o_from_head["hash"] == o_from_t["hash"]:
+        if flag_p_uf:
+            print("No update needed for {}".format(file_path))
+        return
+    else:
+        print("{}".format(file_path), end="\t")
+        commits = get_commits_count_between(
+            opath, o_from_t["hash"], o_from_head["hash"]
+        )
+        print("({} commits)".format(len(commits)))
+        if flag_p_c:
+            print("\t", end="")
+            print("\n\t".join(commits))
+
+
+def main():
+    script_path = os.path.dirname(os.path.abspath(__file__))
+    linux_path = os.path.join(script_path, "..")
+
+    parser = ArgumentParser(description="Check the translation update")
+    parser.add_argument(
+        "-l",
+        "--locale",
+        help="Locale to check when file is not specified",
+    )
+    parser.add_argument(
+        "--print-commits",
+        action=BooleanOptionalAction,
+        default=True,
+        help="Print commits between origin and translation",
+    )
+
+    parser.add_argument(
+        "--print-updated-files",
+        action=BooleanOptionalAction,
+        default=False,
+        help="Print files no need to be updated",
+    )
+
+    parser.add_argument(
+        "--debug",
+        action=BooleanOptionalAction,
+        help="Print debug information",
+        default=False,
+    )
+
+    parser.add_argument(
+        "files", nargs="*", help="File to check, if not specified, check all"
+    )
+    args = parser.parse_args()
+
+    global flag_p_c, flag_p_uf, flag_debug
+    flag_p_c = args.print_commits
+    flag_p_uf = args.print_updated_files
+    flag_debug = args.debug
+
+    # get files related to linux path
+    files = args.files
+    if len(files) == 0:
+        if args.locale is not None:
+            files = (
+                os.popen(
+                    "find {}/Documentation/translations/{} -type f".format(
+                        linux_path, args.locale
+                    )
+                )
+                .read()
+                .split("\n")
+            )
+        else:
+            files = (
+                os.popen(
+                    "find {}/Documentation/translations -type f".format(linux_path)
+                )
+                .read()
+                .split("\n")
+            )
+
+    files = list(filter(lambda x: x != "", files))
+    files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
+
+    # cd to linux root directory
+    os.chdir(linux_path)
+
+    for file in files:
+        check_per_file(file)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1


