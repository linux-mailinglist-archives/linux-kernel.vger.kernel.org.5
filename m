Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0B809C45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjLHGRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHGRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:17:09 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35710FC;
        Thu,  7 Dec 2023 22:17:15 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b6eb711498so60222739f.3;
        Thu, 07 Dec 2023 22:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016234; x=1702621034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rljey37reCyDrPkcI18g/IC3m4eCS+5k4TU+Pl3Hf0=;
        b=l1F4N9UGpY0fhs3T4NXrYCnXmS/nhNlY8peQ9uf3GN+zfCE24HKpnoR1yq30eCQ9ma
         TA3Xy2TmOsOGtfjahVd1kBsLiiIs+XUbe+WnheJTC1pMezDh/dO4h58LhBnVj5Ry6RPx
         DMdo2lYXDcaxde3npPa5bf5JRZJH8Wfy3a8NPJUB8JVdZSbkUXeSM0KAK9fqo4933dc0
         dGaGYtF0rFa2DSCyCAzahqeCUIMJX/aQtFgDs3qiuOeA7hAuzA/2xIwAzo/bpk5zkFjF
         6hSan9y2Y9alUUmOmJxBzWAY23nE7Anw8BeQ0in2y6iNz00vt8HmbdXLeZobSxMzAoda
         qPdQ==
X-Gm-Message-State: AOJu0YyF3VOyIssDQRo+NlCrnu9dYOWDCm2tbkARl6NqUB9FYqowyCWk
        lNapWoxStW3JDHfWHOOgaqltKpo0DvpBLLiB
X-Google-Smtp-Source: AGHT+IE0jZdYYI9gDsK4y0ZZ8A3iH59mtOw95l8DlTZs0o/W4Aqp3ghdtqrsv3wkfIDYx89/7KQq9Q==
X-Received: by 2002:a05:6e02:1a44:b0:35d:59a2:332b with SMTP id u4-20020a056e021a4400b0035d59a2332bmr5204188ilv.47.1702016234149;
        Thu, 07 Dec 2023 22:17:14 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bu13-20020a056e02350d00b0035d70b70d1csm214118ilb.2.2023.12.07.22.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:17:13 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next] bpf: Load vmlinux btf for any struct_ops map
Date:   Fri,  8 Dec 2023 00:17:03 -0600
Message-ID: <20231208061704.400463-1-void@manifault.com>
X-Mailer: git-send-email 2.42.1
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

In libbpf, when determining whether we need to load vmlinux btf, we're
currently (among other things) checking whether there is any struct_ops
program present in the object. This works for most realistic struct_ops
maps, as a struct_ops map is of course typically composed of one or more
struct_ops programs. However, that technically need not be the case. A
struct_ops interface could be defined which allows a map to be specified
which one or more non-prog fields, and which provides default behavior
if no struct_ops progs is actually provided otherwise. For sched_ext,
for example, you technically only need to specify the name of the
scheduler in the struct_ops map, with the core scheduler logic providing
default behavior if no prog is actually specified.

If we were to define and try to load such a struct_ops map, we would
crash in libbpf when initializing it as obj->btf_vmlinux will be NULL:

Reading symbols from minimal...
(gdb) r
Starting program: minimal_example
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x000055555558308c in btf__type_cnt (btf=0x0) at btf.c:612
612             return btf->start_id + btf->nr_types;
(gdb) bt
    type_name=0x5555555d99e3 "sched_ext_ops", kind=4) at btf.c:914
    kind=4) at btf.c:942
    type=0x7fffffffe558, type_id=0x7fffffffe548, ...
    data_member=0x7fffffffe568) at libbpf.c:948
    kern_btf=0x0) at libbpf.c:1017
    at libbpf.c:8059

So as to account for such bare-bones struct_ops maps, let's update
obj_needs_vmlinux_btf() to also iterate over an obj's maps and check
whether any of them are struct_ops maps.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/lib/bpf/libbpf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ea9b8158c20d..ac54ebc0629f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3054,9 +3054,15 @@ static bool prog_needs_vmlinux_btf(struct bpf_program *prog)
 	return false;
 }
 
+static bool map_needs_vmlinux_btf(struct bpf_map *map)
+{
+	return bpf_map__is_struct_ops(map);
+}
+
 static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 {
 	struct bpf_program *prog;
+	struct bpf_map *map;
 	int i;
 
 	/* CO-RE relocations need kernel BTF, only when btf_custom_path
@@ -3081,6 +3087,11 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 			return true;
 	}
 
+	bpf_object__for_each_map(map, obj) {
+		if (map_needs_vmlinux_btf(map))
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.42.1

