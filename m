Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8072E7EE82F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjKPUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjKPUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B361AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700165756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIfhkJ5q+MuBUNqDP7+llj85JgVyRPSym9vvMGwkwM8=;
        b=EMx+bDzk8Nr6qdAyyHWiJIBCZsczcUAeVyoyfOnK7j09Dx0o3tGzSJJCquD6Cz1ihDUGAf
        JT0HHJwk4/AfoDhrwMAauPtQmzUsz8f5AgNWITHtHtSrFhFjXKJrugQ9C/1JawY77aYj1l
        AAVX7Yom9diVSfpqjEI3NswuF9l+ZL4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-tfgHdjaBOQGR7f3JsXbUXQ-1; Thu, 16 Nov 2023 15:15:54 -0500
X-MC-Unique: tfgHdjaBOQGR7f3JsXbUXQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77a02ceef95so18076385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165754; x=1700770554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIfhkJ5q+MuBUNqDP7+llj85JgVyRPSym9vvMGwkwM8=;
        b=njd9H8AZLVpERM9UglB7S0bIz6/cg74E57X9V/jQUdQnJ6k5UM/BtceOhsJG4NiADj
         FXuKG04svL3kjY+hmneJ2uqCfxrfFpAECoTfhD4nubOi0CdtGyGn6dQnbXJH7B+TFlxB
         93tXymbKZyZWGY082sJWfLR6XOjDjg5LVxN6SyG2LqLi7pO4CKVEZ94hp6EoTaCkxkhh
         PHj7aPnBVZEwt0r7WOp3Y0pt60lmOwXi+RWcgd3vNSMFzDSzv2Io2vOEibt8IqXh9E+X
         oetBNT+htpe/A1dDBTzh53/rgT82MmxGPkBsYmi79aqshNDARSFCbDDi3P7bdZ0Btbcp
         9ZJg==
X-Gm-Message-State: AOJu0Yy7Eci+Q4VuIpONnnc9mZT4ykYTUSaGJ/6Pndh5jeLszd49mUQS
        lobd2RIzJ9P9dIv1kkXm50wKRUSvaP8WKK9jB/z5Ura81DeljrN2M+BZxpY/jlO8zuxK8kqg4n7
        vlapXNR78kzUonyByvZnlpdB4
X-Received: by 2002:a05:620a:460f:b0:777:7178:ebf0 with SMTP id br15-20020a05620a460f00b007777178ebf0mr10983525qkb.5.1700165754345;
        Thu, 16 Nov 2023 12:15:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn7WTMLEwrbmDqREYqOP32v0nHbLxAxhRbfg6zZ9i1WFQBXOXwxoGfistYIkGysffqZC/jBw==
X-Received: by 2002:a05:620a:460f:b0:777:7178:ebf0 with SMTP id br15-20020a05620a460f00b007777178ebf0mr10983511qkb.5.1700165754044;
        Thu, 16 Nov 2023 12:15:54 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a271300b007659935ce64sm65524qkp.71.2023.11.16.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:15:53 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 3/3] mm/selftests: Fix pagemap_ioctl memory map test
Date:   Thu, 16 Nov 2023 15:15:47 -0500
Message-ID: <20231116201547.536857-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116201547.536857-1-peterx@redhat.com>
References: <20231116201547.536857-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__FILE__ is not guaranteed to exist in current dir.  Replace that with
argv[0] for memory map test.

Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index befab43719ba..d59517ed3d48 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -36,6 +36,7 @@ int pagemap_fd;
 int uffd;
 int page_size;
 int hpage_size;
+const char *progname;
 
 #define LEN(region)	((region.end - region.start)/page_size)
 
@@ -1149,11 +1150,11 @@ int sanity_tests(void)
 	munmap(mem, mem_size);
 
 	/* 9. Memory mapped file */
-	fd = open(__FILE__, O_RDONLY);
+	fd = open(progname, O_RDONLY);
 	if (fd < 0)
 		ksft_exit_fail_msg("%s Memory mapped file\n", __func__);
 
-	ret = stat(__FILE__, &sbuf);
+	ret = stat(progname, &sbuf);
 	if (ret < 0)
 		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
 
@@ -1472,12 +1473,14 @@ static void transact_test(int page_size)
 			      extra_thread_faults);
 }
 
-int main(void)
+int main(int argc, char *argv[])
 {
 	int mem_size, shmid, buf_size, fd, i, ret;
 	char *mem, *map, *fmem;
 	struct stat sbuf;
 
+	progname = argv[0];
+
 	ksft_print_header();
 
 	if (init_uffd())
-- 
2.41.0

