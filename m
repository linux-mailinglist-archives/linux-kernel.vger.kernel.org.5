Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8D7DA156
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbjJ0Tbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjJ0Tbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:31:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0781BC;
        Fri, 27 Oct 2023 12:31:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RJ4Rli003642;
        Fri, 27 Oct 2023 19:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bV5AdOX1b6yj4uR97m5Igmj5fgcPy3yKPKwqN8wNUHA=;
 b=DK3S6ez61lBeAytVbhzJsYRGJZXwM7oMS5Ad5tOuYPmNe9dAhK04sQrrtOsVjsRRRMAv
 cRqm3q9ks+Z/pt4nuPCGCWW9wQk+oYYZmZMcEJvwP97Zy4gK3bb6N9AqwY6JugpCJGXR
 zE56YFK7iZMwJBiZX4gI8iy4kN5XXrT+NPm+rvfyTf1X8LE6cT57Spp56RFGzSYRVGSS
 CQ7Ny5upcfSQM4FsYjYGxLZDjMFOxabg5HlIthVrZxclNlVOOPpF1ZcdYQGuF1C3MkW5
 L0TGMsYtoWJrVD3vJSqdcBbzx2HS+VmZBX9of73zkNEJ/h6VlJ1Iz58C+lzEwQHf6gp2 cA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxfgawwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 19:31:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RJUgWF019845
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 19:30:42 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 12:30:39 -0700
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 3/3] check-module-params: Introduce check-module-params.sh
Date:   Fri, 27 Oct 2023 12:30:16 -0700
Message-ID: <20231027193016.27516-4-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231027193016.27516-1-quic_johmoo@quicinc.com>
References: <20231027193016.27516-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5ZOiOtwdrCJekduPWOFAJ74XuEjt5e8j
X-Proofpoint-ORIG-GUID: 5ZOiOtwdrCJekduPWOFAJ74XuEjt5e8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_18,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One part of maintaining backwards compatibility with older
userspace programs is avoiding changes to module parameters.

To that end, add a script (check-module-params.sh) which
performs a simple check of module parameter changes across
git references.

For example, if this module parameter:

module_param(max_nullfunc_tries, int, 0644);

...restricted its mode parameter:

module_param(max_nullfunc_tries, int, 0600);

The script would flag the change:

Module parameter "max_nullfunc_tries" in net/mac80211/mlme.c changed!
  Original args: int,0644
       New args: int,0600

Signed-off-by: John Moon <quic_johmoo@quicinc.com>
---
 scripts/check-module-params.sh | 295 +++++++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)
 create mode 100755 scripts/check-module-params.sh

diff --git a/scripts/check-module-params.sh b/scripts/check-module-params.sh
new file mode 100755
index 000000000000..4d2b2cd483e8
--- /dev/null
+++ b/scripts/check-module-params.sh
@@ -0,0 +1,295 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Script to check commits for UAPI backwards compatibility
+
+set -o errexit
+set -o pipefail
+
+print_usage() {
+	name=$(basename "$0")
+	cat << EOF
+$name - check for module parameters stability across git commits.
+
+By default, the script will check to make sure the latest commit (or current
+dirty changes) did not introduce changes when compared to HEAD^1. You can
+check against additional commit ranges with the -b and -p options.
+
+Usage: $name [-b BASE_REF] [-p PAST_REF] [-j N] [-l ERROR_LOG] [-q] [-v]
+
+Options:
+    -b BASE_REF    Base git reference to use for comparison. If unspecified or empty,
+                   will use any dirty changes in tree to UAPI files. If there are no
+                   dirty changes, HEAD will be used.
+    -p PAST_REF    Compare BASE_REF to PAST_REF (e.g. -p v6.1). If unspecified or empty,
+                   will use BASE_REF^1. Must be an ancestor of BASE_REF. Only headers
+                   that exist on PAST_REF will be checked for compatibility.
+    -j JOBS        Number of checks to run in parallel (default: number of CPU cores).
+    -l ERROR_LOG   Write error log to file (default: no error log is generated).
+    -q             Quiet operation (suppress stdout, still print stderr).
+    -v             Verbose operation (print more information about each header being checked).
+
+Exit codes:
+    $SUCCESS) Success
+    $FAILURE) Module param differences detected
+EOF
+}
+
+readonly SUCCESS=0
+readonly FAILURE=1
+
+# Print to stderr
+eprintf() {
+	# shellcheck disable=SC2059
+	printf "$@" >&2
+}
+
+# Check if git tree is dirty
+tree_is_dirty() {
+	! git diff --quiet
+}
+
+file_module_params_unmodified() {
+	local file="$1"
+	local base_ref="$2"
+	local past_ref="$3"
+	local base_params_file="${TMP_DIR}/${file}.base"
+	local past_params_file="${TMP_DIR}/${file}.past"
+	local error_log="${TMP_DIR}/${file}.error"
+
+	local -r awk_cmd='/^ *module_param.*\(/,/.*\);/'
+
+	mkdir -p "$(dirname "$error_log")"
+	git show "${past_ref}:${file}" 2> /dev/null \
+		| awk "$awk_cmd" > "$past_params_file" || true
+
+	# Ignore files that don't exist at the past ref or don't have module params
+	if [ ! -s "$past_params_file" ]; then
+		return 255 # Special return code for "no-op"
+	fi
+
+	if [ -z "$base_ref" ]; then
+		awk "$awk_cmd" "${KERNEL_SRC}/${file}" \
+			> "$base_params_file" 2> /dev/null || true
+	else
+		git show "${base_ref}:${file}" 2> /dev/null \
+			| awk "$awk_cmd" > "$base_params_file" || true
+	fi
+
+	# Process the param data to come up with an associative array of param names to param data
+	# For example:
+	#   module_param_call(foo, set_result, get_result, NULL, 0600);
+	#
+	# is processed into:
+	#   pre_change_params[foo]="set_result,get_result,NULL,0600"
+	local -A pre_change_params
+	local param_name
+	local param_params
+	while read -r mod_param_args; do
+		param_name="$(echo "$mod_param_args" | cut -d ',' -f 1)"
+		param_params="$(echo "$mod_param_args" | cut -d ',' -f 2-)"
+
+		pre_change_params[$param_name]=$param_params
+	done < <(tr -d '\t\n ' < "$past_params_file" | tr ';' '\n' | grep -o '(.*)' | tr -d '()')
+
+	local -A post_change_params
+	while read -r mod_param_args; do
+		param_name="$(echo "$mod_param_args" | cut -d ',' -f 1)"
+		param_params="$(echo "$mod_param_args" | cut -d ',' -f 2-)"
+
+		post_change_params[$param_name]=$param_params
+	done < <(tr -d '\t\n ' < "$base_params_file" | tr ';' '\n' | grep -o '(.*)' | tr -d '()')
+
+	# Flag any module param changes that:
+	#  - Remove/rename a parameter
+	#  - Change the arguments of the parameter
+	local incompat_param_changes=0
+	local pre
+	local post
+	for param_name in "${!pre_change_params[@]}"; do
+		pre="${pre_change_params[$param_name]}"
+		if [ ! "${post_change_params[$param_name]+set}" ]; then
+			{
+				printf "Module parameter \"%s\" in %s removed!\n" "$param_name" "$file"
+				printf "  Original args: %s\n" "$pre"
+			} > "$error_log"
+			incompat_param_changes=$((incompat_param_changes + 1))
+			continue
+		fi
+
+		post="${post_change_params[$param_name]}"
+		if [ "$pre" != "$post" ]; then
+			{
+				printf "Module parameter \"%s\" in %s changed!\n" "$param_name" "$file"
+				printf "  Original args: %s\n" "$pre"
+				printf "       New args: %s\n" "$post"
+			} > "$error_log"
+			incompat_param_changes=$((incompat_param_changes + 1))
+			continue
+		fi
+	done
+
+	if [ "$incompat_param_changes" -gt 0 ]; then
+		return 1
+	fi
+}
+
+run() {
+	local base_ref="$1"
+	local past_ref="$2"
+	local abi_error_log="$3"
+
+	diff_args=("$past_ref")
+	if [ -n "$base_ref" ]; then
+		diff_args+=("$base_ref")
+	fi
+
+	local -a threads=()
+	local passed=0
+	local failed=0
+	printf "Checking files between %s and %s for module parameter compatibility...\n" \
+		"$past_ref" "$base_ref"
+	while read -r modified_file; do
+		if [ "${#threads[@]}" -ge "$MAX_THREADS" ]; then
+			wait "${threads[0]}" && ret="$?" || ret="$?"
+			if [ "$ret" -eq 0 ]; then
+				passed=$((passed + 1))
+			elif [ "$ret" -eq 1 ]; then
+				failed=$((failed + 1))
+			fi
+			threads=("${threads[@]:1}")
+		fi
+
+		file_module_params_unmodified "$modified_file" "$base_ref" "$past_ref" &
+		threads+=("$!")
+	done < <(git diff --diff-filter=MCD --name-only "${diff_args[@]}" -- '*.c' '*.h')
+
+	for t in "${threads[@]}"; do
+		wait "$t" && ret="$?" || ret="$?"
+		if [ "$ret" -eq 0 ]; then
+			passed=$((passed + 1))
+		elif [ "$ret" -eq 1 ]; then
+			failed=$((failed + 1))
+		fi
+	done
+
+	total=$((passed + failed))
+	if [ "$total" -eq 0 ]; then
+		printf "No files with module parameters modified between %s and %s\n" \
+			"$past_ref" "${base_ref:-dirty tree}"
+		exit 0
+	fi
+
+	if [ -n "$abi_error_log" ]; then
+		printf 'Generated by "%s %s" from git ref %s\n\n' \
+			"$0" "$*" "$(git rev-parse HEAD)" > "$abi_error_log"
+	fi
+
+	while read -r error_file; do
+		{
+			cat "$error_file"
+			printf "\n\n"
+		} | tee -a "${abi_error_log:-/dev/null}" >&2
+	done < <(find "$TMP_DIR" -type f -name '*.error')
+
+	if [ "$failed" -gt 0 ]; then
+		eprintf "error - %d/%d files with modules parameters appear _not_ to be backwards compatible\n" \
+			"$failed" "$total"
+		if [ -n "$abi_error_log" ]; then
+			eprintf "Failure summary saved to %s\n" "$abi_error_log"
+		fi
+	else
+		printf "All %d files with module_parameters checked appear to be backwards compatible\n" \
+			"$total" "$ARCH"
+	fi
+
+	exit "$failed"
+}
+
+# Make sure the git refs we have make sense
+check_refs() {
+	if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
+		eprintf "error - this script requires the kernel tree to be initialized with Git\n"
+		return 1
+	fi
+
+	if ! git rev-parse --verify "$past_ref" > /dev/null 2>&1; then
+		printf 'error - invalid git reference "%s"\n' "$past_ref"
+		return 1
+	fi
+
+	if [ -n "$base_ref" ]; then
+		if ! git merge-base --is-ancestor "$past_ref" "$base_ref" > /dev/null 2>&1; then
+			printf 'error - "%s" is not an ancestor of base ref "%s"\n' "$past_ref" "$base_ref"
+			return 1
+		fi
+		if [ "$(git rev-parse "$base_ref")" = "$(git rev-parse "$past_ref")" ]; then
+			printf 'error - "%s" and "%s" are the same reference\n' "$past_ref" "$base_ref"
+			return 1
+		fi
+	fi
+}
+
+main() {
+	MAX_THREADS=$(nproc)
+	quiet="false"
+	local base_ref=""
+	while getopts "hb:p:j:l:q" opt; do
+		case $opt in
+		h)
+			print_usage
+			exit "$SUCCESS"
+			;;
+		b)
+			base_ref="$OPTARG"
+			;;
+		p)
+			past_ref="$OPTARG"
+			;;
+		j)
+			MAX_THREADS="$OPTARG"
+			;;
+		l)
+			abi_error_log="$OPTARG"
+			;;
+		q)
+			quiet="true"
+			;;
+		*)
+			exit "$FAIL_PREREQ"
+		esac
+	done
+
+	if [ "$quiet" = "true" ]; then
+		exec > /dev/null 2>&1
+	fi
+
+	if [ -z "$KERNEL_SRC" ]; then
+		KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
+	fi
+
+	cd "$KERNEL_SRC"
+
+	if [ -z "$base_ref" ] && ! tree_is_dirty; then
+		base_ref=HEAD
+	fi
+
+	if [ -z "$past_ref" ]; then
+		if [ -n "$base_ref" ]; then
+			past_ref="${base_ref}^1"
+		else
+			past_ref=HEAD
+		fi
+	fi
+
+	if ! check_refs; then
+		exit "$FAIL_PREREQ"
+	fi
+
+	TMP_DIR=$(mktemp -d)
+	readonly TMP_DIR
+	trap 'rm -rf "$TMP_DIR"' EXIT
+
+	run "$base_ref" "$past_ref" "$abi_error_log"
+}
+
+main "$@"
--
2.17.1

