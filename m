Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49587849AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjHVSwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHVSwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73DCD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBEC6579A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D8EC433C7;
        Tue, 22 Aug 2023 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692730325;
        bh=kYWtsRw4Oth+9kYIvyxl4uncgY/197vM3wf6YcmPdq8=;
        h=Date:From:To:Cc:Subject:From;
        b=dlZlpMsDidSgXWyYc9l0IpYrPwTwRYNZg7MerBpk1YNM8VLRckatM4WeXB2hHc04s
         MqSdxCFtRaib2Ra+s/MoD245KXjFuw57rHa9Z0VtBOONof9qPvsiQMyIPK45SrMsNQ
         CZgVfWfRDsEqeXMidr1u47buSutBrzGalEpzqhhJ2xxtuypM1oss5KQtmCzoZimceo
         FGC61uQ8U+60t8Jp0votAal5WT8MNSSo/oYkhPDljxzF8RihZgJzMWyZRoJS0lQHiD
         9G20qPUz/HX5MuKfo2/G/48rM7AVyktj0j+E8h3igsC7Y1THCYqtEHmYCgrKgYNZIO
         /UGggXBphxkGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 335F040722; Tue, 22 Aug 2023 15:52:03 -0300 (-03)
Date:   Tue, 22 Aug 2023 15:52:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf lzma: Convert some pr_err() to pr_debug() as
 callers already use pr_debug()
Message-ID: <ZOUD0+GkuCVkYF7n@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed some error with:

  # perf list ex_ret_brn
  lzma: fopen failed on /usr/lib/modules/5.15.14-100.fc34.x86_64/kernel/net/bluetooth/bnep/bnep.ko.xz: 'No such file or directory'
  lzma: fopen failed on /usr/lib/modules/5.16.16-200.fc35.x86_64/kernel/drivers/gpu/drm/drm_kms_helper.ko.xz: 'No such file or directory'
  lzma: fopen failed on /usr/lib/modules/5.18.16-200.fc36.x86_64/kernel/arch/x86/crypto/crct10dif-pclmul.ko.xz: 'No such file or directory'
  lzma: fopen failed on /usr/lib/modules/5.16.16-200.fc35.x86_64/kernel/drivers/i2c/busses/i2c-piix4.ko.xz: 'No such file or directory'
  <BIG SNIP>

Then using 'perf probe' + 'perf trace' to debug 'perf list', it seems
its some inconsistency in the ~/.debug/ cache where broken build id
symlinks that ends up making it try to uncompress some kernel modules
using the lzma routines:

   395.309 perf/3594447 probe_perf:lzma_decompress_to_file(__probe_ip: 6118448, input_string: "/usr/lib/modules/5.18.17-200.fc36.x86_64/kernel/drivers/nvme/host/nvme.ko.xz")
                                       lzma_decompress_to_file (/var/home/acme/bin/perf)
                                       filename__decompress (/var/home/acme/bin/perf)
                                       filename__read_build_id (/var/home/acme/bin/perf)
                                       filename__sprintf_build_id (inlined)
                                       build_id_cache__valid_id (inlined)
                                       build_id_cache__list_all (/var/home/acme/bin/perf)
                                       print_sdt_events (/var/home/acme/bin/perf)
                                       cmd_list (/var/home/acme/bin/perf)
                                       run_builtin (/var/home/acme/bin/perf)
                                       handle_internal_command (inlined)
                                       run_argv (inlined)
                                       main (/var/home/acme/bin/perf)
                                       __libc_start_call_main (/usr/lib64/libc.so.6)
                                       __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
                                       _start (/var/home/acme/bin/perf)

But callers of filename__decompress() already check its return and use
pr_debug(), so be consistent and make functions it calls also use
pr_debug().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/lzma.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 51424cdc3b682c64..af9a97612f9df392 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -45,15 +45,13 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 
 	infile = fopen(input, "rb");
 	if (!infile) {
-		pr_err("lzma: fopen failed on %s: '%s'\n",
-		       input, strerror(errno));
+		pr_debug("lzma: fopen failed on %s: '%s'\n", input, strerror(errno));
 		return -1;
 	}
 
 	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
 	if (ret != LZMA_OK) {
-		pr_err("lzma: lzma_stream_decoder failed %s (%d)\n",
-			lzma_strerror(ret), ret);
+		pr_debug("lzma: lzma_stream_decoder failed %s (%d)\n", lzma_strerror(ret), ret);
 		goto err_fclose;
 	}
 
@@ -68,7 +66,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 			strm.avail_in = fread(buf_in, 1, sizeof(buf_in), infile);
 
 			if (ferror(infile)) {
-				pr_err("lzma: read error: %s\n", strerror(errno));
+				pr_debug("lzma: read error: %s\n", strerror(errno));
 				goto err_lzma_end;
 			}
 
@@ -82,7 +80,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 			ssize_t write_size = sizeof(buf_out) - strm.avail_out;
 
 			if (writen(output_fd, buf_out, write_size) != write_size) {
-				pr_err("lzma: write error: %s\n", strerror(errno));
+				pr_debug("lzma: write error: %s\n", strerror(errno));
 				goto err_lzma_end;
 			}
 
@@ -94,7 +92,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 			if (ret == LZMA_STREAM_END)
 				break;
 
-			pr_err("lzma: failed %s\n", lzma_strerror(ret));
+			pr_debug("lzma: failed %s\n", lzma_strerror(ret));
 			goto err_lzma_end;
 		}
 	}
-- 
2.37.1

