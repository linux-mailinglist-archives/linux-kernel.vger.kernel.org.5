Return-Path: <linux-kernel+bounces-146312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9E8A6368
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C4D283E09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386B5A4D5;
	Tue, 16 Apr 2024 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iAKoCgV8"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725455A0E1;
	Tue, 16 Apr 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247252; cv=none; b=V8dkYPbn0ukk74/eeUZAqWXsqkqoufbHpojzHSepwzGfQ1/klB1yi0QKgkgPI2kAefaiiRiFOZl5jjI5Xxdbk56EZ6Q1oU9uRNkR2Qu9r9XJaB8ZlefLV4TjYq+2AidN3BA/dgUm721RGQXq9MEyH8IkOHAsfsVYvoTOiUcQkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247252; c=relaxed/simple;
	bh=dih606yrErrkqNVvWnFiNkO/wdqRKq2ObolV1o0W1uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCRdm8UzN0FYGyYbKavDGoxgYswTBdW9rc3eDTkEJmtlnBBpIadjde0lvzy6AV6+oQApglE5CE6f74Vcn4eMl4TQBpfQGvoygCiPG4rH21jih2hWDKTKhp+EfLN4fo9Nu040Ri2vTWDYXX4VFCXtDPdSjztV/rGMgP2aExbbOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iAKoCgV8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 613F81C0007;
	Tue, 16 Apr 2024 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG9kzMrVpynd80/NtdllZ7WpEs5hwN+0Lqp+VsGRRiY=;
	b=iAKoCgV8jLGRyLWeoEyjrmHewBGuqOfBEulha1860KVwu97GIGh2JPsaNGfDj4LYBrbzID
	CHof/IrcIQ0Urts3wEBVObe5qU/jL3qQRS2DEeHPCMYotGDW6aKmoSkfDg4uZanwqgh9Dm
	SqSNegNl6W0lJittieThwyJblQpzI+o68J3ASkrE+3CBAiSfef03VNlqdaIDcMsoIuyTcW
	7tj4s92/7cw0SAGMEUDenk2Ww+MhPE2vp36cb/nLNtLszYa05e8QBjmYQOc0V5uTxtHYVZ
	RCBI+pCtZ7cvfxFZykXn4XFn4AQpPhkcRFiTpqOmutvllYC6OySNE3t/4MVKJg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 08:00:26 +0200
Subject: [PATCH 3/3] tools/sound/dapm-graph: new tool to visualize DAPM
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-vizdapm-ng-v1-3-5d33c0b57bc5@bootlin.com>
References: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
In-Reply-To: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, 
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Mihai Serban <mihai.serban@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Add a tool to generate a picture of the current DAPM state for a sound
card.

dapm-graph is inspired by vizdapm which used to be published on a Wolfson
Micro git repository now disappeared, and has a few forks around:

  https://github.com/mihais/asoc-tools
  https://github.com/alexandrebelloni/asoc-tools

dapm-graph is a full reimplementation with several improvements while still
being a self-contained shell script:

Improvements to rendered output:
 - shows the entire card, not one component hierarchy only
 - each component is rendered in a separate box
 - shows widget on/off status based on widget information alone (the
   original vizdapm propagates the "on" green colour to the first input
   widget)
 - use bold line and gray background and not only green/red line to show
   on/off status (for the color blind)

Improvements for embedded system developers:
 - remote mode: get state of remote device (possibly with minimal rootfs)
   via SSH, but parsing locally for faster operation
 - compatible with BusyBox shell, not only bash

Usability improvements:
 - flexible command line (uses getopts for parsing)
 - detailed help text
 - flag to enable detailed debug logging
 - graphviz output format detected from file extension, not hard coded
 - a self-contained shell script

Usage is designed to be simple:

  dapm-grpah -c CARD                  - get state from debugfs for CARD
  dapm-grpah -c CARD -r REMOTE_TARGET - same, but remotely via SSH
  dapm-grpah -d STATE_DIR             - from a local copy of the debugfs
                                        tree for a card

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 MAINTAINERS            |   6 +
 tools/sound/dapm-graph | 303 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 309 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997ebd1ae474..8c1be129419e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20773,6 +20773,12 @@ F:	include/trace/events/sof*.h
 F:	include/uapi/sound/asoc.h
 F:	sound/soc/
 
+SOUND - SOC LAYER / dapm-graph
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+F:	tools/sound/dapm-graph
+
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
 M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 M:	Liam Girdwood <lgirdwood@gmail.com>
diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
new file mode 100755
index 000000000000..57d78f6df041
--- /dev/null
+++ b/tools/sound/dapm-graph
@@ -0,0 +1,303 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate a graph of the current DAPM state for an audio card
+#
+# Copyright 2024 Bootlin
+# Author: Luca Ceresoli <luca.ceresol@bootlin.com>
+
+set -eu
+
+STYLE_NODE_ON="shape=box,style=bold,color=green4"
+STYLE_NODE_OFF="shape=box,style=filled,color=gray30,fillcolor=gray95"
+
+# Print usage and exit
+#
+# $1 = exit return value
+# $2 = error string (required if $1 != 0)
+usage()
+{
+    if [  "${1}" -ne 0 ]; then
+	echo "${2}" >&2
+    fi
+
+    echo "
+Generate a graph of the current DAPM state for an audio card.
+
+The DAPM state can be obtained via debugfs for a card on the local host or
+a remote target, or from a local copy of the debugfs tree for the card.
+
+Usage:
+    $(basename $0) [options] -c CARD                  - Local sound card
+    $(basename $0) [options] -c CARD -r REMOTE_TARGET - Card on remote system
+    $(basename $0) [options] -d STATE_DIR             - Local directory
+
+Options:
+    -c CARD             Sound card to get DAPM state of
+    -r REMOTE_TARGET    Get DAPM state from REMOTE_TARGET via SSH and SCP
+                        instead of using a local sound card
+    -d STATE_DIR        Get DAPM state from a local copy of a debugfs tree
+    -o OUT_FILE         Output file (default: dapm.dot)
+    -D                  Show verbose debugging info
+    -h                  Print this help and exit
+
+The output format is implied by the extension of OUT_FILE:
+
+ * Use the .dot extension to generate a text graph representation in
+   graphviz dot syntax.
+ * Any other extension is assumed to be a format supported by graphviz for
+   rendering, e.g. 'png', 'svg', and will produce both the .dot file and a
+   picture from it. This requires the 'dot' program from the graphviz
+   package.
+"
+
+    exit ${1}
+}
+
+# Connect to a remote target via SSH, collect all DAPM files from debufs
+# into a tarball and get the tarball via SCP into $3/dapm.tar
+#
+# $1 = target as used by ssh and scp, e.g. "root@192.168.1.1"
+# $2 = sound card name
+# $3 = temp dir path (present on the host, created on the target)
+# $4 = local directory to extract the tarball into
+#
+# Requires an ssh+scp server, find and tar+gz on the target
+#
+# Note: the tarball is needed because plain 'scp -r' from debugfs would
+# copy only empty files
+grab_remote_files()
+{
+    echo "Collecting DAPM state from ${1}"
+    dbg_echo "Collected DAPM state in ${3}"
+
+    ssh "${1}" "
+set -eu &&
+cd \"/sys/kernel/debug/asoc/${2}\" &&
+find * -type d -exec mkdir -p ${3}/dapm-tree/{} \; &&
+find * -type f -exec cp \"{}\" \"${3}/dapm-tree/{}\" \; &&
+cd ${3}/dapm-tree &&
+tar cf ${3}/dapm.tar ."
+    scp -q "${1}:${3}/dapm.tar" "${3}"
+
+    mkdir -p "${4}"
+    tar xf "${tmp_dir}/dapm.tar" -C "${4}"
+}
+
+# Parse a widget file and generate graph description in graphviz dot format
+#
+# Skips any file named "bias_level".
+#
+# $1 = temporary work dir
+# $2 = component name
+# $3 = widget filename
+process_dapm_widget()
+{
+    local tmp_dir="${1}"
+    local c_name="${2}"
+    local w_file="${3}"
+    local dot_file="${tmp_dir}/main.dot"
+    local links_file="${tmp_dir}/links.dot"
+
+    local w_name="$(basename "${w_file}")"
+    local w_tag="${c_name}_${w_name}"
+
+    if [ "${w_name}" = "bias_level" ]; then
+	return 0
+    fi
+
+    dbg_echo "   + Widget: ${w_name}"
+
+    cat "${w_file}" | (
+ 	read line
+
+ 	if echo "${line}" | grep -q ': On '
+	then local node_style="${STYLE_NODE_ON}"
+	else local node_style="${STYLE_NODE_OFF}"
+ 	fi
+
+	local w_type=""
+	while read line; do
+	    # Collect widget type if present
+	    if echo "${line}" | grep -q '^widget-type '; then
+		local w_type_raw="$(echo "$line" | cut -d ' ' -f 2)"
+		dbg_echo "     - Widget type: ${w_type_raw}"
+
+		# Note: escaping '\n' is tricky to get working with both
+		# bash and busybox ash, so use a '%' here and replace it
+		# later
+		local w_type="%n[${w_type_raw}]"
+	    fi
+
+	    # Collect any links. We could use "in" links or "out" links,
+	    # let's use "in" links
+	    if echo "${line}" | grep -q '^in '; then
+		local w_src=$(echo "$line" |
+				  awk -F\" '{print $6 "_" $4}' |
+				  sed  's/^(null)_/ROOT_/')
+		dbg_echo "     - Input route from: ${w_src}"
+		echo "  \"${w_src}\" -> \"$w_tag\"" >> "${links_file}"
+	    fi
+	done
+
+	echo "    \"${w_tag}\" [label=\"${w_name}${w_type}\",${node_style}]" |
+	    tr '%' '\\' >> "${dot_file}"
+   )
+}
+
+# Parse the DAPM tree for a sound card component and generate graph
+# description in graphviz dot format
+#
+# $1 = temporary work dir
+# $2 = component directory
+# $3 = forced component name (extracted for path if empty)
+process_dapm_component()
+{
+    local tmp_dir="${1}"
+    local c_dir="${2}"
+    local c_name="${3}"
+    local dot_file="${tmp_dir}/main.dot"
+    local links_file="${tmp_dir}/links.dot"
+
+    if [ -z "${c_name}" ]; then
+	# Extract directory name into component name:
+	#   "./cs42l51.0-004a/dapm" -> "cs42l51.0-004a"
+	c_name="$(basename $(dirname "${c_dir}"))"
+    fi
+
+    dbg_echo " * Component: ${c_name}"
+
+    echo ""                           >> "${dot_file}"
+    echo "  subgraph \"${c_name}\" {" >> "${dot_file}"
+    echo "    cluster = true"         >> "${dot_file}"
+    echo "    label = \"${c_name}\""  >> "${dot_file}"
+    echo "    color=dodgerblue"       >> "${dot_file}"
+
+    # Create empty file to ensure it will exist in all cases
+    >"${links_file}"
+
+    # Iterate over widgets in the component dir
+    for w_file in ${c_dir}/*; do
+	process_dapm_widget "${tmp_dir}" "${c_name}" "${w_file}"
+    done
+
+    echo "  }" >> "${dot_file}"
+
+    cat "${links_file}" >> "${dot_file}"
+}
+
+# Parse the DAPM tree for a sound card and generate graph description in
+# graphviz dot format
+#
+# $1 = temporary work dir
+# $2 = directory tree with DAPM state (either in debugfs or a mirror)
+process_dapm_tree()
+{
+    local tmp_dir="${1}"
+    local dapm_dir="${2}"
+    local dot_file="${tmp_dir}/main.dot"
+
+    echo "digraph G {" > "${dot_file}"
+    echo "  fontname=\"sans-serif\"" >> "${dot_file}"
+    echo "  node [fontname=\"sans-serif\"]" >> "${dot_file}"
+
+
+    # Process root directory (no component)
+    process_dapm_component "${tmp_dir}" "${dapm_dir}/dapm" "ROOT"
+
+    # Iterate over components
+    for c_dir in "${dapm_dir}"/*/dapm
+    do
+	process_dapm_component "${tmp_dir}" "${c_dir}" ""
+    done
+
+    echo "}" >> "${dot_file}"
+}
+
+main()
+{
+    # Parse command line
+    local out_file="dapm.dot"
+    local card_name=""
+    local remote_target=""
+    local dapm_tree=""
+    local dbg_on=""
+    while getopts "c:r:d:o:Dh" arg; do
+	case $arg in
+	    c)  card_name="${OPTARG}"      ;;
+	    r)  remote_target="${OPTARG}"  ;;
+	    d)  dapm_tree="${OPTARG}"      ;;
+	    o)  out_file="${OPTARG}"       ;;
+	    D)  dbg_on="1"                 ;;
+	    h)  usage 0                    ;;
+	    *)  usage 1                    ;;
+	esac
+    done
+    shift $(($OPTIND - 1))
+
+    if [ -n "${dapm_tree}" ]; then
+	if [ -n "${card_name}${remote_target}" ]; then
+	    usage 1 "Cannot use -c and -r with -d"
+	fi
+	echo "Using local tree: ${dapm_tree}"
+    elif [ -n "${remote_target}" ]; then
+	if [ -z "${card_name}" ]; then
+	    usage 1 "-r requires -c"
+	fi
+	echo "Using card ${card_name} from remote target ${remote_target}"
+    elif [ -n "${card_name}" ]; then
+	echo "Using local card: ${card_name}"
+    else
+	usage 1 "Please choose mode using -c, -r or -d"
+    fi
+
+    # Define logging function
+    if [ "${dbg_on}" ]; then
+	dbg_echo() {
+	    echo "$*" >&2
+	}
+    else
+	dbg_echo() {
+	    :
+	}
+    fi
+
+    # Filename must have a dot in order the infer the format from the
+    # extension
+    if ! echo "${out_file}" | grep -qE '\.'; then
+	echo "Missing extension in output filename ${out_file}" >&2
+	usage
+	exit 1
+    fi
+
+    local out_fmt="${out_file##*.}"
+    local dot_file="${out_file%.*}.dot"
+
+    dbg_echo "dot file:      $dot_file"
+    dbg_echo "Output file:   $out_file"
+    dbg_echo "Output format: $out_fmt"
+
+    tmp_dir="$(mktemp -d /tmp/$(basename $0).XXXXXX)"
+    trap "{ rm -fr ${tmp_dir}; }" INT TERM EXIT
+
+    if [ -z "${dapm_tree}" ]
+    then
+	dapm_tree="/sys/kernel/debug/asoc/${card_name}"
+    fi
+    if [ -n "${remote_target}" ]; then
+	dapm_tree="${tmp_dir}/dapm-tree"
+	grab_remote_files "${remote_target}" "${card_name}" "${tmp_dir}" "${dapm_tree}"
+    fi
+    # In all cases now ${dapm_tree} contains the DAPM state
+
+    process_dapm_tree "${tmp_dir}" "${dapm_tree}"
+    cp "${tmp_dir}/main.dot" "${dot_file}"
+
+    if [ "${out_file}" != "${dot_file}" ]; then
+	dot -T"${out_fmt}" "${dot_file}" -o "${out_file}"
+    fi
+
+    echo "Generated file ${out_file}"
+}
+
+main "${@}"

-- 
2.34.1


