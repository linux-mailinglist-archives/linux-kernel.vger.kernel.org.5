Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E4806C81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377586AbjLFKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377673AbjLFKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9A10C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB1C433CB;
        Wed,  6 Dec 2023 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859571;
        bh=7Z66jDHh7z5xBFNmXPfkXoT2Dr9Z4ZSbHcvyhhC4qyI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MrcOsoWmHfmSiL4w5nG0+Ealab2TPz5Mw2VsXY/qIae+hnmWNmVDCYS9t3HhZBEc0
         krlqBnlqPk6t2n+IEG/JvyzWb0lmr/UcQlF7wPpnseyuMzqC0+OLfDApi+OakIpPnt
         dhT5xupOzpOcVXbdAQBwKZiKoJc/dZPSd9F8RK1dmjIxFV/prL4tjt5ty087PzrvBF
         kIwxl0MLKTJUuVVhVMFw1jqVa0MipGZim+PQt5Uv70CPJoJQOJDcDITHo8AFlsVUAQ
         gRMOqCbIroQfGsPzDyF8Q6TpuAbh3Pr5oGsM/Pvten5vrWXt3HGSOicbckxs2RHDdn
         VYd+jpcY/Sg0w==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:53 +0100
Subject: [PATCH v2 02/15] selftests/hid: vmtest.sh: allow finer control on
 the build steps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-2-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=3502;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=7Z66jDHh7z5xBFNmXPfkXoT2Dr9Z4ZSbHcvyhhC4qyI=;
 b=mm1Tq/31O7cS5QItcxF2bwB/nQV36NVLVjngjepgRvKVNcFgDqrFirSOUThonquaMjQqdXlBm
 nGXcNeqp+PzD3x9GUSuF+69wuUEHD/y1DlYemoH4kHABnp73uCz39Dl
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmtest.sh works great for a one shot test, but not so much for CI where
I want to build (with different configs) the bzImage in a separate
job than the one I am running it.

Add a "build_only" option to specify whether we need to boot the currently
built kernel in the vm.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- fixed typo
---
 tools/testing/selftests/hid/vmtest.sh | 42 ++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index 301b4e162336..db534e9099a8 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -32,7 +32,7 @@ DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS
 usage()
 {
 	cat <<EOF
-Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
+Usage: $0 [-j N] [-s] [-b] [-d <output_dir>] -- [<command>]
 
 <command> is the command you would normally run when you are in
 the source kernel direcory. e.g:
@@ -55,6 +55,7 @@ Options:
 
 	-u)		Update the boot2container script to a newer version.
 	-d)		Update the output directory (default: ${OUTPUT_DIR})
+	-b)		Run only the build steps for the kernel and the selftests
 	-j)		Number of jobs for compilation, similar to -j in make
 			(default: ${NUM_COMPILE_JOBS})
 	-s)		Instead of powering off the VM, start an interactive
@@ -191,8 +192,9 @@ main()
 	local command="${DEFAULT_COMMAND}"
 	local update_b2c="no"
 	local debug_shell="no"
+	local build_only="no"
 
-	while getopts ':hsud:j:' opt; do
+	while getopts ':hsud:j:b' opt; do
 		case ${opt} in
 		u)
 			update_b2c="yes"
@@ -207,6 +209,9 @@ main()
 			command="/bin/sh"
 			debug_shell="yes"
 			;;
+		b)
+			build_only="yes"
+			;;
 		h)
 			usage
 			exit 0
@@ -226,8 +231,7 @@ main()
 	shift $((OPTIND -1))
 
 	# trap 'catch "$?"' EXIT
-
-	if [[ "${debug_shell}" == "no" ]]; then
+	if [[ "${build_only}" == "no" && "${debug_shell}" == "no" ]]; then
 		if [[ $# -eq 0 ]]; then
 			echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
 		else
@@ -267,24 +271,26 @@ main()
 	update_kconfig "${kernel_checkout}" "${kconfig_file}"
 
 	recompile_kernel "${kernel_checkout}" "${make_command}"
+	update_selftests "${kernel_checkout}" "${make_command}"
 
-	if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
-		echo "vm2c script not found in ${b2c}"
-		update_b2c="yes"
-	fi
+	if [[ "${build_only}" == "no" ]]; then
+		if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
+			echo "vm2c script not found in ${b2c}"
+			update_b2c="yes"
+		fi
 
-	if [[ "${update_b2c}" == "yes" ]]; then
-		download $B2C_URL $b2c
-		chmod +x $b2c
-	fi
+		if [[ "${update_b2c}" == "yes" ]]; then
+			download $B2C_URL $b2c
+			chmod +x $b2c
+		fi
 
-	update_selftests "${kernel_checkout}" "${make_command}"
-	run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
-	if [[ "${debug_shell}" != "yes" ]]; then
-		echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
-	fi
+		run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
+		if [[ "${debug_shell}" != "yes" ]]; then
+			echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
+		fi
 
-	exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
+		exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
+	fi
 }
 
 main "$@"

-- 
2.41.0

