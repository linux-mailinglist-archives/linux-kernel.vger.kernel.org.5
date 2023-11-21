Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588F7F2C07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKULtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjKULtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:49:20 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5FE114;
        Tue, 21 Nov 2023 03:49:14 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54366784377so7541364a12.3;
        Tue, 21 Nov 2023 03:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567353; x=1701172153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoNlAoP8Se/Bi79SOE77aDYGWRLRtUcUIIaZs7kWmj0=;
        b=hrDrL2LHDjLYHpyD9JBX7cuf86zn/tFg44GasBiCFzGrfqNizdQqORiXy5vb2Y7vxz
         ZuzHM7G9qNYg8VygOhue6rfccnPHK68h60Dy55mzn2FFid+DM5pRBIGDiQeZqOxMTgaU
         jv4oLF7WA1paYBmzN7HuaXImO+0DZqR/fstWLCutyNPuVcwpQDlvP4BI3P4+E53mkt7z
         qeXSaEXTJrvjtYm3DrzXdTfdpvHTWtZwhSLJBamaaxy/Nlya8i1hjkq+QnObsC5rN4QY
         tzlQRGJubEa1Q7YFVBLHSJ1MbFpof9LNcOxiq2BVrhYkJcAdBm56eXqfgLm4ehUTC/cb
         APQw==
X-Gm-Message-State: AOJu0YxzGWTPtYTJnDI8ov9OYk2+QbFBDZgjjAcCDVNV/qUAMW0HeWqM
        tM1rSaLpa1f89GwnUo6xDgQ=
X-Google-Smtp-Source: AGHT+IEnQND2iaYtwcR98j3P7GBwMjnYQib/btoSrKWHxBNKPG61M0VK14+st7F4A7+EXhpdgnzZow==
X-Received: by 2002:aa7:c412:0:b0:543:6828:f129 with SMTP id j18-20020aa7c412000000b005436828f129mr1682413edq.23.1700567352565;
        Tue, 21 Nov 2023 03:49:12 -0800 (PST)
Received: from localhost (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id l13-20020aa7cacd000000b005486f7f654dsm3682924edt.7.2023.11.21.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:49:12 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     corbet@lwn.net, kuba@kernel.org
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        edumazet@google.com
Subject: [PATCH v3] Documentation: Document each netlink family
Date:   Tue, 21 Nov 2023 03:48:31 -0800
Message-Id: <20231121114831.3033560-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple script that parses the Netlink YAML spec files
(Documentation/netlink/specs/), and generates RST files to be rendered
in the Network -> Netlink Specification documentation page.

Create a python script that is invoked during 'make htmldocs', reads the
YAML specs input file and generate the correspondent RST file.

Create a new Documentation/networking/netlink_spec index page, and
reference each Netlink RST file that was processed above in this main
index.rst file.

In case of any exception during the parsing, dump the error and skip
the file.

Do not regenerate the RST files if the input files (YAML) were not
changed in-between invocations.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>

----
Changelog:

V3:
	* Do not regenerate the RST files if the input files were not
	  changed. In order to do it, a few things changed:
	  - Rely on Makefile more to find what changed, and trigger
	    individual file processing
	  - The script parses file by file now (instead of batches)
	  - Create a new option to generate the index file

V2:
	* Moved the logic from a sphinx extension to a external script
	* Adjust some formatting as suggested by Donald Hunter and Jakub
	* Auto generating all the rsts instead of having stubs
	* Handling error gracefully
---
 Documentation/Makefile                        |  16 +-
 Documentation/networking/index.rst            |   1 +
 .../networking/netlink_spec/.gitignore        |   1 +
 .../networking/netlink_spec/readme.txt        |   4 +
 tools/net/ynl/ynl-gen-rst.py                  | 388 ++++++++++++++++++
 5 files changed, 409 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/netlink_spec/.gitignore
 create mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 tools/net/ynl/ynl-gen-rst.py

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2f35793acd2a..5c156fbb6cdf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -97,7 +97,21 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
 	fi
 
-htmldocs:
+YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
+YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
+YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
+YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
+
+YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
+YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
+
+$(YNL_INDEX): $(YNL_RST_FILES)
+	@$(YNL_TOOL) -o $@ -x
+
+$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
+	@$(YNL_TOOL) -i $< -o $@
+
+htmldocs: $(YNL_INDEX)
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 683eb42309cc..cb435c141794 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -55,6 +55,7 @@ Contents:
    filter
    generic-hdlc
    generic_netlink
+   netlink_spec/index
    gen_stats
    gtp
    ila
diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
new file mode 100644
index 000000000000..30d85567b592
--- /dev/null
+++ b/Documentation/networking/netlink_spec/.gitignore
@@ -0,0 +1 @@
+*.rst
diff --git a/Documentation/networking/netlink_spec/readme.txt b/Documentation/networking/netlink_spec/readme.txt
new file mode 100644
index 000000000000..6763f99d216c
--- /dev/null
+++ b/Documentation/networking/netlink_spec/readme.txt
@@ -0,0 +1,4 @@
+SPDX-License-Identifier: GPL-2.0
+
+This file is populated during the build of the documentation (htmldocs) by the
+tools/net/ynl/ynl-gen-rst.py script.
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
new file mode 100755
index 000000000000..b6292109e236
--- /dev/null
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -0,0 +1,388 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+
+"""
+    Script to auto generate the documentation for Netlink specifications.
+
+    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    This script performs extensive parsing to the Linux kernel's netlink YAML
+    spec files, in an effort to avoid needing to heavily mark up the original
+    YAML file.
+
+    This code is split in three big parts:
+        1) RST formatters: Use to convert a string to a RST output
+        2) Parser helpers: Functions to parse the YAML data structure
+        3) Main function and small helpers
+"""
+
+from typing import Any, Dict, List
+import os.path
+import sys
+import argparse
+import logging
+import yaml
+
+
+SPACE_PER_LEVEL = 4
+
+
+# RST Formatters
+# ==============
+def headroom(level: int) -> str:
+    """Return space to format"""
+    return " " * (level * SPACE_PER_LEVEL)
+
+
+def bold(text: str) -> str:
+    """Format bold text"""
+    return f"**{text}**"
+
+
+def inline(text: str) -> str:
+    """Format inline text"""
+    return f"``{text}``"
+
+
+def sanitize(text: str) -> str:
+    """Remove newlines and multiple spaces"""
+    # This is useful for some fields that are spread across multiple lines
+    return str(text).replace("\n", "").strip()
+
+
+def rst_fields(key: str, value: str, level: int = 0) -> str:
+    """Return a RST formatted field"""
+    return headroom(level) + f":{key}: {value}"
+
+
+def rst_definition(key: str, value: Any, level: int = 0) -> str:
+    """Format a single rst definition"""
+    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
+
+
+def rst_paragraph(paragraph: str, level: int = 0) -> str:
+    """Return a formatted paragraph"""
+    return headroom(level) + paragraph
+
+
+def rst_bullet(item: str, level: int = 0) -> str:
+    """Return a formatted a bullet"""
+    return headroom(level) + f" - {item}"
+
+
+def rst_subsection(title: str) -> str:
+    """Add a sub-section to the document"""
+    return f"{title}\n" + "-" * len(title)
+
+
+def rst_subsubsection(title: str) -> str:
+    """Add a sub-sub-section to the document"""
+    return f"{title}\n" + "~" * len(title)
+
+
+def rst_section(title: str) -> str:
+    """Add a section to the document"""
+    return f"\n{title}\n" + "=" * len(title)
+
+
+def rst_subtitle(title: str) -> str:
+    """Add a subtitle to the document"""
+    return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
+
+
+def rst_title(title: str) -> str:
+    """Add a title to the document"""
+    return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
+
+
+def rst_list_inline(list_: List[str], level: int = 0) -> str:
+    """Format a list using inlines"""
+    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
+
+
+def rst_header() -> str:
+    """The headers for all the auto generated RST files"""
+    lines = []
+
+    lines.append(rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
+    lines.append(rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
+
+    return "\n".join(lines)
+
+
+def rst_toctree(maxdepth: int = 2) -> str:
+    """Generate a toctree RST primitive"""
+    lines = []
+
+    lines.append(".. toctree::")
+    lines.append(f"   :maxdepth: {maxdepth}\n\n")
+
+    return "\n".join(lines)
+
+
+# Parsers
+# =======
+
+
+def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
+    """Parse 'multicast' group list and return a formatted string"""
+    lines = []
+    for group in mcast_group:
+        lines.append(rst_bullet(group["name"]))
+
+    return "\n".join(lines)
+
+
+def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'do' section and return a formatted string"""
+    lines = []
+    for key in do_dict.keys():
+        lines.append(rst_paragraph(bold(key), level + 1))
+        lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+
+    return "\n".join(lines)
+
+
+def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'attributes' section"""
+    if "attributes" not in attrs:
+        return ""
+    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
+
+    return "\n".join(lines)
+
+
+def parse_operations(operations: List[Dict[str, Any]]) -> str:
+    """Parse operations block"""
+    preprocessed = ["name", "doc", "title", "do", "dump"]
+    lines = []
+
+    for operation in operations:
+        lines.append(rst_section(operation["name"]))
+        lines.append(rst_paragraph(sanitize(operation["doc"])) + "\n")
+
+        for key in operation.keys():
+            if key in preprocessed:
+                # Skip the special fields
+                continue
+            lines.append(rst_fields(key, operation[key], 0))
+
+        if "do" in operation:
+            lines.append(rst_paragraph(":do:", 0))
+            lines.append(parse_do(operation["do"], 0))
+        if "dump" in operation:
+            lines.append(rst_paragraph(":dump:", 0))
+            lines.append(parse_do(operation["dump"], 0))
+
+        # New line after fields
+        lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
+    """Parse a list of entries"""
+    lines = []
+    for entry in entries:
+        if isinstance(entry, dict):
+            # entries could be a list or a dictionary
+            lines.append(
+                rst_fields(entry.get("name", ""), sanitize(entry.get("doc", "")), level)
+            )
+        elif isinstance(entry, list):
+            lines.append(rst_list_inline(entry, level))
+        else:
+            lines.append(rst_bullet(inline(sanitize(entry)), level))
+
+    lines.append("\n")
+    return "\n".join(lines)
+
+
+def parse_definitions(defs: Dict[str, Any]) -> str:
+    """Parse definitions section"""
+    preprocessed = ["name", "entries", "members"]
+    ignored = ["render-max"]  # This is not printed
+    lines = []
+
+    for definition in defs:
+        lines.append(rst_section(definition["name"]))
+        for k in definition.keys():
+            if k in preprocessed + ignored:
+                continue
+            lines.append(rst_fields(k, sanitize(definition[k]), 0))
+
+        # Field list needs to finish with a new line
+        lines.append("\n")
+        if "entries" in definition:
+            lines.append(rst_paragraph(":entries:", 0))
+            lines.append(parse_entries(definition["entries"], 1))
+        if "members" in definition:
+            lines.append(rst_paragraph(":members:", 0))
+            lines.append(parse_entries(definition["members"], 1))
+
+    return "\n".join(lines)
+
+
+def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
+    """Parse attribute from attribute-set"""
+    preprocessed = ["name", "type"]
+    ignored = ["checks"]
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_section(entry["name"]))
+        for attr in entry["attributes"]:
+            type_ = attr.get("type")
+            attr_line = bold(attr["name"])
+            if type_:
+                # Add the attribute type in the same line
+                attr_line += f" ({inline(type_)})"
+
+            lines.append(rst_subsubsection(attr_line))
+
+            for k in attr.keys():
+                if k in preprocessed + ignored:
+                    continue
+                lines.append(rst_fields(k, sanitize(attr[k]), 2))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_yaml(obj: Dict[str, Any]) -> str:
+    """Format the whole YAML into a RST string"""
+    lines = []
+
+    # Main header
+
+    lines.append(rst_header())
+
+    title = f"Family ``{obj['name']}`` netlink specification"
+    lines.append(rst_title(title))
+    lines.append(rst_paragraph(".. contents::\n"))
+
+    if "doc" in obj:
+        lines.append(rst_subtitle("Summary"))
+        lines.append(rst_paragraph(obj["doc"], 0))
+
+    # Operations
+    if "operations" in obj:
+        lines.append(rst_subtitle("Operations"))
+        lines.append(parse_operations(obj["operations"]["list"]))
+
+    # Multicast groups
+    if "mcast-groups" in obj:
+        lines.append(rst_subtitle("Multicast groups"))
+        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
+
+    # Definitions
+    if "definitions" in obj:
+        lines.append(rst_subtitle("Definitions"))
+        lines.append(parse_definitions(obj["definitions"]))
+
+    # Attributes set
+    if "attribute-sets" in obj:
+        lines.append(rst_subtitle("Attribute sets"))
+        lines.append(parse_attr_sets(obj["attribute-sets"]))
+
+    return "\n".join(lines)
+
+
+# Main functions
+# ==============
+
+
+def parse_arguments() -> argparse.Namespace:
+    """Parse arguments from user"""
+    parser = argparse.ArgumentParser(description="Netlink RST generator")
+
+    parser.add_argument("-v", "--verbose", action="store_true")
+    parser.add_argument("-o", "--output", help="Output file name")
+
+    # Index and input are mutually exclusive
+    group = parser.add_mutually_exclusive_group()
+    group.add_argument(
+        "-x", "--index", action="store_true", help="Generate the index page"
+    )
+    group.add_argument("-i", "--input", help="YAML file name")
+
+    args = parser.parse_args()
+
+    if args.verbose:
+        logging.basicConfig(level=logging.DEBUG)
+
+    if args.input and not os.path.isfile(args.input):
+        logging.warning("%s is not a valid file.", args.input)
+        sys.exit(-1)
+
+    if not args.output:
+        logging.error("No output file specified.")
+        sys.exit(-1)
+
+    if os.path.isfile(args.output):
+        logging.debug("%s already exists. Overwriting it.", args.output)
+
+    return args
+
+
+def parse_yaml_file(filename: str) -> str:
+    """Transform the YAML specified by filename into a rst-formmated string"""
+    with open(filename, "r", encoding="utf-8") as spec_file:
+        yaml_data = yaml.safe_load(spec_file)
+        content = parse_yaml(yaml_data)
+
+    return content
+
+
+def write_to_rstfile(content: str, filename: str) -> None:
+    """Write the generated content into an RST file"""
+    logging.debug("Saving RST file to %s", filename)
+
+    with open(filename, "w", encoding="utf-8") as rst_file:
+        rst_file.write(content)
+
+
+def generate_main_index_rst(output: str) -> None:
+    """Generate the `networking_spec/index` content and write to the file"""
+    lines = []
+
+    lines.append(rst_header())
+    lines.append(rst_title("Netlink Specification"))
+    lines.append(rst_toctree(1))
+
+    index_dir = os.path.dirname(output)
+    logging.debug("Looking for .rst files in %s", index_dir)
+    for filename in os.listdir(index_dir):
+        if not filename.endswith(".rst") or filename == "index.rst":
+            continue
+        lines.append(f"   {filename.replace('.rst', '')}\n")
+
+    logging.debug("Writing an index file at %s", output)
+    write_to_rstfile("".join(lines), output)
+
+
+def main() -> None:
+    """Main function that reads the YAML files and generates the RST files"""
+
+    args = parse_arguments()
+
+    if args.input:
+        logging.debug("Parsing %s", args.input)
+        try:
+            content = parse_yaml_file(os.path.join(args.input))
+        except Exception as exception:
+            logging.warning("Failed to parse %s.", args.input)
+            logging.warning(exception)
+            sys.exit(-1)
+
+        write_to_rstfile(content, args.output)
+
+    if args.index:
+        # Generate the index RST file
+        generate_main_index_rst(args.output)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1

