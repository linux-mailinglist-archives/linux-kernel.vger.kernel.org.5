Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4B377EEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347484AbjHQBUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347500AbjHQBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:20:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3054726AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:20:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686be3cbea0so304306b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692235224; x=1692840024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvyxeUS9fq0mQZuA1GzyXjv4L0y4/K/wnguyQj7Xykk=;
        b=ZqhzWxk7QJkOCT6R4F8pbFod5NEa31t3jfoj9cyNhZbDZlSWjNzEZNkZP91pJtdKZz
         DJ8iGvN+jqVUjpYFYGkugedlVfuVXGy20ThwkUrrGFC0alkvId7W7ueXvwrgFt5aUfIg
         zS8xWHv2v4/NdB2IlV1tuEiArplP9y41mKTZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235224; x=1692840024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvyxeUS9fq0mQZuA1GzyXjv4L0y4/K/wnguyQj7Xykk=;
        b=e1U40qZDvJzUJQrdBoWsEWmOh3GHSYgGNOaMZWPoTvM4mCv/FpHeRCgL22uZnT4a+Q
         LoJbK+VWhW32YXJqNCiib+JgiwkNzgz+YkBqFG6jdyk4ynay0oFkM4jJT6yrqkPQHs5P
         ney66TbNyvh8UPfdZIy4pF7oeY5URw/tHH30HR0lALvcxdpBF/HvGVa+cew1B6A5uavJ
         zsyCFOaENR6Rp35rDeHd/uK1oQrUFSzPk2daFflBtIH3XiNiDbbrQTlyXD0C7MH2baJ/
         FOrD5m3ReLLQSuwW/J0+3AUllgAqlge6fBIfPtpnYGbgoHcrML4KKymjnZ2wo3OXfDzX
         lk+w==
X-Gm-Message-State: AOJu0YyVFQWIXCgR9JmptyFvrJ7kZAjk/cYjw4m+xTFiQSIZYAQiKb2o
        Gc7WY5CpNz1pL0md9qhyUW7c1COdl5a1h8l6XHg=
X-Google-Smtp-Source: AGHT+IH2q4lepA7YmeqrxG50qPCrrMNlYPYTXjfU9Hysz7Q9VTKdqFH6EII6oO0fteuDCQNZi3P8/Q==
X-Received: by 2002:a05:6a20:1448:b0:134:3a9b:4cd7 with SMTP id a8-20020a056a20144800b001343a9b4cd7mr1546893pzi.23.1692235224554;
        Wed, 16 Aug 2023 18:20:24 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:1601:f73d:719a:8de1])
        by smtp.gmail.com with ESMTPSA id n7-20020a62e507000000b00686b649cdd0sm11593737pff.86.2023.08.16.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:20:24 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH] kconfig: introduce listunknownconfig
Date:   Thu, 17 Aug 2023 10:19:58 +0900
Message-ID: <20230817012007.131868-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The listunknownconfig option reads old .config and lists
all unrecognized symbols. This is especially useful for
continuous kernel uprevs when some symbols can be either
removed or renamed between kernel releases (which can go
unnoticed otherwise).

A recent real-life example of such a symbol rename
that quietly disabled some drivers after kernel uprev
is MFD_RK808 rename.

Example:
Suppose old .config has the following two options which
were removed from the recent kernel:

$ cat .config
CONFIG_DISABLE_BUGS=y

Running `make listunknownconfig` produces the following
list of unrecognized symbols:

.config:6:warning: unknown symbol: DISABLE_BUGS
.config:7:warning: unknown unset symbol: ENABLE_WINAPI

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/kbuild/kconfig.rst |  8 +++++
 scripts/kconfig/Makefile         |  4 ++-
 scripts/kconfig/conf.c           |  8 +++++
 scripts/kconfig/confdata.c       | 55 ++++++++++++++++++++++++++++++++
 scripts/kconfig/lkc_proto.h      |  1 +
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
index 6530ecd99da3..445c438dc741 100644
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -29,6 +29,14 @@ To see a list of new config symbols, use::
 
 and the config program will list any new symbols, one per line.
 
+To see a list of config symbols that are not recognized anymore (e.g.
+removed or renamed), use::
+
+	cp user/some/old.config .config
+	make listunknownconfig
+
+and the config program will list any unrecognized symbols, one per line.
+
 Alternatively, you can use the brute force method::
 
 	make oldconfig
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index af1c96198f49..942316ddebd9 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -69,7 +69,8 @@ localyesconfig localmodconfig: $(obj)/conf
 #  deprecated for external use
 simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
 	alldefconfig randconfig listnewconfig olddefconfig syncconfig \
-	helpnewconfig yes2modconfig mod2yesconfig mod2noconfig
+	helpnewconfig yes2modconfig mod2yesconfig mod2noconfig \
+	listunknownconfig
 
 PHONY += $(simple-targets)
 
@@ -141,6 +142,7 @@ help:
 	@echo  '                    default value without prompting'
 	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
 	@echo  '  testconfig	  - Run Kconfig unit tests (requires python3 and pytest)'
+	@echo  '  listunknownconfig	- List unrecognized options'
 
 # ===========================================================================
 # object files used by all kconfig flavours
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 33d19e419908..e26aa491be00 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -36,6 +36,7 @@ enum input_mode {
 	yes2modconfig,
 	mod2yesconfig,
 	mod2noconfig,
+	listunknownconfig,
 };
 static enum input_mode input_mode = oldaskconfig;
 static int input_mode_opt;
@@ -683,6 +684,7 @@ static const struct option long_opts[] = {
 	{"yes2modconfig", no_argument,       &input_mode_opt, yes2modconfig},
 	{"mod2yesconfig", no_argument,       &input_mode_opt, mod2yesconfig},
 	{"mod2noconfig",  no_argument,       &input_mode_opt, mod2noconfig},
+	{"listunknownconfig", no_argument,   &input_mode_opt, listunknownconfig},
 	{NULL, 0, NULL, 0}
 };
 
@@ -712,6 +714,7 @@ static void conf_usage(const char *progname)
 	printf("  --yes2modconfig         Change answers from yes to mod if possible\n");
 	printf("  --mod2yesconfig         Change answers from mod to yes if possible\n");
 	printf("  --mod2noconfig          Change answers from mod to no if possible\n");
+	printf("  --listunknownconfig     List config options that do not exist anymore\n");
 	printf("  (If none of the above is given, --oldaskconfig is the default)\n");
 }
 
@@ -823,6 +826,11 @@ int main(int ac, char **av)
 			exit(1);
 		}
 		break;
+	case listunknownconfig:
+		if (conf_read_list_unknown())
+			exit(1);
+		exit(0);
+		break;
 	default:
 		break;
 	}
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 992575f1e976..d387a4f08cef 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -341,6 +341,61 @@ static ssize_t compat_getline(char **lineptr, size_t *n, FILE *stream)
 	return -1;
 }
 
+int conf_read_list_unknown(void)
+{
+	FILE *in = NULL;
+	size_t line_asize = 0;
+	char *line = NULL;
+	char *p, *p2;
+	struct symbol *sym;
+
+	conf_filename = conf_get_configname();
+	in = zconf_fopen(conf_filename);
+	if (!in)
+		return -1;
+
+	while (compat_getline(&line, &line_asize, in) != -1) {
+		conf_lineno++;
+		sym = NULL;
+		if (line[0] == '#') {
+			if (memcmp(line + 2, CONFIG_, strlen(CONFIG_)))
+				continue;
+			p = strchr(line + 2 + strlen(CONFIG_), ' ');
+			if (!p)
+				continue;
+			*p++ = 0;
+			sym = sym_find(line + 2 + strlen(CONFIG_));
+			if (!sym) {
+				conf_warning("unknown unset symbol: %s",
+					     line + 2 + strlen(CONFIG_));
+				continue;
+			}
+		} else if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
+			p = strchr(line + strlen(CONFIG_), '=');
+			if (!p)
+				continue;
+			*p++ = 0;
+			p2 = strchr(p, '\n');
+			if (p2) {
+				*p2-- = 0;
+				if (*p2 == '\r')
+					*p2 = 0;
+			}
+
+			sym = sym_find(line + strlen(CONFIG_));
+			if (!sym) {
+				conf_warning("unknown symbol: %s",
+					     line + strlen(CONFIG_));
+				continue;
+			}
+		}
+	}
+
+	free(line);
+	fclose(in);
+	return conf_warnings;
+}
+
 int conf_read_simple(const char *name, int def)
 {
 	FILE *in = NULL;
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index edd1e617b25c..bb60b1669750 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -5,6 +5,7 @@
 void conf_parse(const char *name);
 int conf_read(const char *name);
 int conf_read_simple(const char *name, int);
+int conf_read_list_unknown(void);
 int conf_write_defconfig(const char *name);
 int conf_write(const char *name);
 int conf_write_autoconf(int overwrite);
-- 
2.41.0.694.ge786442a9b-goog

