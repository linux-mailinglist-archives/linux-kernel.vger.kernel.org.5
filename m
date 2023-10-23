Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763C7D3D99
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjJWR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJWR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C984EA2;
        Mon, 23 Oct 2023 10:28:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3A2C433C7;
        Mon, 23 Oct 2023 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082093;
        bh=HcLcWLJGRHlp2Xy+fV5Mci2qklXKQc19WPVrm8dOxFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAtKha4EZ7gSTTqFMSgy8ortj9/5xX2oOp4l3Uq7N3ipaH1a3ASihi+CbwKXuedQ5
         IolqSynqa2QJKbX6wbUeGw2sypeOg37j3vCrenjNagMLZWyJFO2BvxrGfSbuLdrFi6
         pyMPsoM2hGImZvRQW/Zrmt2H3cL494HSb8z3bSFs3OxULE5KvJYZqcnYZD2F2VlmE2
         jttNR+TxMijUbhekwZ/26PT7bXLs0rHgZga5hhLpG1vXEt22pnxIAveab5FgUAja7W
         EX4xzgzaYScfs16S04Kh1XHC8zhQXTAAztDrZKMWUhEtiGB70D0Rxs8FCJ1eswKQBu
         RiTNpgzEdA/hQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 098924035D; Mon, 23 Oct 2023 14:28:09 -0300 (-03)
Date:   Mon, 23 Oct 2023 14:28:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 22/48] perf annotate: Add --type-stat option for debugging
Message-ID: <ZTatKUD6nS7OlvuC@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
 <20231012035111.676789-23-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012035111.676789-23-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 11, 2023 at 08:50:45PM -0700, Namhyung Kim escreveu:
> The --type-stat option is to be used with --data-type and to print
> detailed failure reasons for the data type annotation.
> 
>   $ perf annotate --data-type --type-stat
>   Annotate data type stats:
>   total 294, ok 116 (39.5%), bad 178 (60.5%)
>   -----------------------------------------------------------
>           30 : no_sym
>           40 : no_insn_ops
>           33 : no_mem_ops
>           63 : no_var
>            4 : no_typeinfo
>            8 : bad_offset

Had to enclose it as well, as:

⬢[acme@toolbox perf-tools-next]$ grep annotate-data tools/perf/util/Build
perf-$(CONFIG_DWARF) += annotate-data.o
⬢[acme@toolbox perf-tools-next]$

/usr/bin/ld: /tmp/build/perf-tools-next/perf-in.o: in function `cmd_annotate':
(.text+0x27b7): undefined reference to `ann_data_stat'
/usr/bin/ld: (.text+0x27bd): undefined reference to `ann_data_stat'
/usr/bin/ld: (.text+0x27c4): undefined reference to `ann_data_stat'
/usr/bin/ld: (.text+0x27cb): undefined reference to `ann_data_stat'
/usr/bin/ld: (.text+0x27d2): undefined reference to `ann_data_stat'
/usr/bin/ld: /tmp/build/perf-tools-next/perf-in.o:(.text+0x27d9): more undefined references to `ann_data_stat' follow
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:675: /tmp/build/perf-tools-next/perf] Error 1

When building with NO_DWARF=1 or in systems lacking the used DWARF
libraries. I noticed with some of the build containers, will updated
those to have the required libraries so that this feature gets compile
tested there.


diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 645acaba63f1957a..5b534245ddb23294 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -353,6 +353,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	printf(";\n");
 }
 
+#ifdef HAVE_DWARF_SUPPORT
 static void print_annotate_data_stat(struct annotated_data_stat *s)
 {
 #define PRINT_STAT(fld) if (s->fld) printf("%10d : %s\n", s->fld, #fld)
@@ -389,6 +390,7 @@ static void print_annotate_data_stat(struct annotated_data_stat *s)
 
 #undef PRINT_STAT
 }
+#endif // HAVE_DWARF_SUPPORT
 
 static void hists__find_annotations(struct hists *hists,
 				    struct evsel *evsel,
@@ -396,10 +398,10 @@ static void hists__find_annotations(struct hists *hists,
 {
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
 	int key = K_RIGHT;
-
+#ifdef HAVE_DWARF_SUPPORT
 	if (ann->type_stat)
 		print_annotate_data_stat(&ann_data_stat);
-
+#endif
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
@@ -698,8 +700,10 @@ int cmd_annotate(int argc, const char **argv)
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "data-type", &annotate.data_type,
 		    "Show data type annotate for the memory accesses"),
+#ifdef HAVE_DWARF_SUPPORT
 	OPT_BOOLEAN(0, "type-stat", &annotate.type_stat,
 		    "Show stats for the data type annotation"),
+#endif
 	OPT_END()
 	};
 	int ret;
