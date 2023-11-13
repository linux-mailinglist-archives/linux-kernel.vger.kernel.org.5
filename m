Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA87E958E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjKMDfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMDfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:35:17 -0500
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 19:35:12 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF7FC1727;
        Sun, 12 Nov 2023 19:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qzuze
        q5RZunEw9MzxOVC0ZJUq2k7xF8cGjQbiU3w6Ng=; b=XyVmSmrNOIocnF1EPnFY7
        d/6AXrh90j2d9cq0etvYpTjXrzQ8TIPMd5TKTYWzNFgIfZkvR2qiglQY2LlK56t3
        I+xdsbeZUcpLnaEWFVEUQfL+Tu4hmK/8uSTpEkpiuUnWoFkFYJCvBU/lwDWjITw1
        5DBV2HuqGFuRTyKvBE2by8=
Received: from hrt-workstation-l4hl6.hrt-tessos.compute.slcaz03.tess.io. (unknown [216.113.160.77])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDnDup8lVFloOCsCg--.49567S2;
        Mon, 13 Nov 2023 11:18:23 +0800 (CST)
From:   Wenli Xie <xwlpt@126.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenli Xie <wlxie7296@gmail.com>
Subject: [PATCH] bpf: Get the program type by resolve_prog_type() directly
Date:   Mon, 13 Nov 2023 03:18:12 +0000
Message-Id: <20231113031812.3639430-1-xwlpt@126.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnDup8lVFloOCsCg--.49567S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4DKFW8Zr18uw45Gw4kZwb_yoWkWwb_A3
        Wjgw4xGw4DGFyfKa1UCFWfWF1j9ryFqFn7urn0vryDCF15Jw4jyr18uFZIqFykZrn7JrWS
        yF9Yva4rtrWfXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb_Ma5UUUUU==
X-Originating-IP: [216.113.160.77]
X-CM-SenderInfo: h0zo13a6rslhhfrp/1tbiegMnBlpEG1mnGQAAs6
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenli Xie <wlxie7296@gmail.com>

The bpf program type can be get by resolve_prog_type() directly.

Signed-off-by: Wenli Xie <wlxie7296@gmail.com>
---
 kernel/bpf/btf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..b8ac96906bc5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6963,7 +6963,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 {
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_prog *prog = env->prog;
-	enum bpf_prog_type prog_type = prog->type;
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct btf *btf = prog->aux->btf;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
@@ -7001,8 +7001,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 		bpf_log(log, "Verifier bug in function %s()\n", tname);
 		return -EFAULT;
 	}
-	if (prog_type == BPF_PROG_TYPE_EXT)
-		prog_type = prog->aux->dst_prog->type;
 
 	t = btf_type_by_id(btf, t->type);
 	if (!t || !btf_type_is_func_proto(t)) {
-- 
2.34.1

