Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEF776D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjHJBGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJBGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB741994
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691629537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JkB4Upyz+pODWA+n3M6W8QaRx94LWEelftlH4td1its=;
        b=hrgShFmi7qM27vG1GZa8VfA/AB5h+ELCu38ShsfSDhKYFEsb5BvRYfM/XtWsG59oJTEKS+
        yC6WWFVs6Hh9tDIE+SLqIWzBaiYn0Br/X3lA4Rmy39zYP4YUGdrPktKfAKFA79p6mPlWkA
        BG6nbYvWoT4OXzjRnD7B3VvH3E7Ge0E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-CC_9kY1TNLqylLS1GmsFcA-1; Wed, 09 Aug 2023 21:05:35 -0400
X-MC-Unique: CC_9kY1TNLqylLS1GmsFcA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-267f61da571so500100a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 18:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691629534; x=1692234334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkB4Upyz+pODWA+n3M6W8QaRx94LWEelftlH4td1its=;
        b=PmYVVDdMnT/PgbWIzMLtW3dbNS72ovugwPDWFzY63EIH7P9iYHVVmVOkJ5X+F6j1LZ
         HLrHnfGxNvnc1FGwiG2XOebg2/Ojiq1tmBKMpsE1AI2Cf/bHYcnQbefpuCiiyLWxf7Km
         1s/ibtw+uaC9HVgyfDEOStI2q1zrluCqkCBVjWn89ANPFyUv54R8jLn/HNt/2ufmLv9Q
         TxDXnY3GAtxg9El3uS9t497B2LuJQ/DUQf6A9+zEhUz0bPLWWeE11J0N22Jv8bbRvSHR
         di+rkHAkCx2Zi8Nu2xAn2cWSGwUIS1YvQAs9iM7oJoUAjWXiZmxRK+kmwD8a2rGZJnr7
         BQlQ==
X-Gm-Message-State: AOJu0Yz2cszWh7xa2d6JxcOwvYSnBNNjBTQB0GNyWdRyiGhHTo1RMcPS
        0fawGeds7aSz9fr7h91oi1G7avAz8ZpVh65UUztJtZzZ2d+5k4b7Hh1jmHNgTTZLCJatJZrlGhB
        Zeb1x0mM15IAwpQNj4UG0BK9zKwjXrZW7MK5FRfbUYdBG20RDfbk2Mj8SsQlfGKQnlcOUyyQMMf
        ppSpuAwj26UJg=
X-Received: by 2002:a17:90a:e60f:b0:268:14d7:bc34 with SMTP id j15-20020a17090ae60f00b0026814d7bc34mr816253pjy.20.1691629534593;
        Wed, 09 Aug 2023 18:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY1anU2xQoxwSHQv10Oia90ffZnFNfLoZIUz1KlWbFH/MUcU8hO1zVboPzOexpsDBlg5FojA==
X-Received: by 2002:a17:90a:e60f:b0:268:14d7:bc34 with SMTP id j15-20020a17090ae60f00b0026814d7bc34mr816230pjy.20.1691629534186;
        Wed, 09 Aug 2023 18:05:34 -0700 (PDT)
Received: from fedora19.redhat.com ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a034800b00262e485156esm2214827pjf.57.2023.08.09.18.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 18:05:33 -0700 (PDT)
From:   Ian Wienand <iwienand@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ian Wienand <iwienand@redhat.com>
Subject: [PATCH] selftests/zram : add non-zero data
Date:   Thu, 10 Aug 2023 11:03:14 +1000
Message-ID: <20230810010313.493384-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In diagnosing some issues with the partner test in LTP I noticed that
because this fills the device with zeros, it doesn't really activate
the compressed allocator path as it is designed to do.  This is a
"lite" version of the LTP patch that simply perturbs the zero writes to
avoid having all pages hit the same-page detection, and adds a sync so
that we're looking at a more quiescent system to get the final stats.

While we're here, this rewords and expands some of the mm_stat flag
docs to be a bit more explicit about what's going on.

Link: https://lore.kernel.org/ltp/20230808035641.364676-2-iwienand@redhat.com/T/#u
Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 22 ++++++++++++++-------
 tools/testing/selftests/zram/zram01.sh      | 18 +++++++++++++++--
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index e4551579cb12..a39a01870f40 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -253,17 +253,25 @@ line of text and contains the following stats separated by whitespace:
  orig_data_size   uncompressed size of data stored in this disk.
                   Unit: bytes
  compr_data_size  compressed size of data stored in this disk
- mem_used_total   the amount of memory allocated for this disk. This
-                  includes allocator fragmentation and metadata overhead,
-                  allocated for this disk. So, allocator space efficiency
-                  can be calculated using compr_data_size and this statistic.
-                  Unit: bytes
+ mem_used_total   the amount of memory currently used by the compressed
+                  memory allocator to hold compressed data. This
+                  includes allocator fragmentation and metadata
+                  overhead.  The device space efficiency can be
+                  calculated as a ratio of the compr_data_size /
+                  mem_used_total.  Note this value may be zero;
+                  particularly if all pages are filled with identical
+                  data (see same_pages).
  mem_limit        the maximum amount of memory ZRAM can use to store
                   the compressed data
  mem_used_max     the maximum amount of memory zram has consumed to
                   store the data
- same_pages       the number of same element filled pages written to this disk.
-                  No memory is allocated for such pages.
+ same_pages       pages identified as being filled exclusivley with an
+                  identicial unsigned-long value are recorded
+                  specially by zram and thus are not stored via the
+                  compression allocator.  This avoids fragmentation
+                  and metadata overheads for common cases such as
+                  zeroed or poision data.  same_pages is the current
+                  number of pages kept in this de-duplicated form.
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
  huge_pages_since the number of incompressible pages since zram set up
diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index 8f4affe34f3e..122625d744c2 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -33,16 +33,30 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
+	local page_size=$(getconf PAGE_SIZE)
 	for i in $(seq $dev_start $dev_end); do
 		echo "fill zram$i..."
 		local b=0
 		while [ true ]; do
-			dd conv=notrunc if=/dev/zero of=zram${i}/file \
+			# If we fill with all zeros, every page hits
+			# the same-page detection and never makes it
+			# to compressed backing.  Filling the first 1K
+			# of the page with (likely lowly compressible)
+			# random data ensures we hit the compression
+			# paths, but the highly compressible rest of
+			# the page also ensures we get a sufficiently
+			# high ratio to assert on below.
+			local input_file='/dev/zero'
+			if [ $(( (b * 1024) % page_size )) -eq 0 ]; then
+			    input_file='/dev/urandom'
+			fi
+			dd conv=notrunc if=${input_file} of=zram${i}/file \
 				oflag=append count=1 bs=1024 status=none \
 				> /dev/null 2>&1 || break
 			b=$(($b + 1))
 		done
-		echo "zram$i can be filled with '$b' KB"
+		echo "zram$i was filled with '$b' KB"
+		sync
 
 		local mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
 		local v=$((100 * 1024 * $b / $mem_used_total))
-- 
2.41.0

