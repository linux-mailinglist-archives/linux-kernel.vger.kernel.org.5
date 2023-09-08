Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21A5798AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjIHQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbjIHQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:33:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24319B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:33:41 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id eeQKqI5GZmTYjeeQKqPfiw; Fri, 08 Sep 2023 18:33:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694190820;
        bh=sdUE6TT14eCOvBoLJKIUC2N7D/QN1SaUjLEtihNQU5w=;
        h=From:To:Cc:Subject:Date;
        b=HGltK7lFNNSlaViWY5Tw+9MdSB0TIuI2S4w5MayZ5ex+ylWxQQqhQVVxZm5ugaxgy
         pMfJ3CzQ6IgikgF75wQaqaTr5/maVjAVP+hh/QDI25vYO33kpOAw6DrH1Uj3uM7766
         de+6KA1xEduuUmHwxLbB231sJJFBVXFgOSJXYW64mMpj623DgpsQGeRBVGa/ToWE4P
         LctZ4qg0h5GAOZeCo0b30nemcfEZVN1axXIgE2uhGctFhbfttk4r5D2ka3L85a4YOr
         DN4gsmr5tiiIkl1J2/s4U5GQTL0p90mM2PXzc+jmQlecxD/7iI1ZQZk8fgX9InOpX4
         /NRBoMrt5AGug==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 08 Sep 2023 18:33:40 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bpf@vger.kernel.org
Subject: [PATCH] bpf: Fix a erroneous check after snprintf()
Date:   Fri,  8 Sep 2023 18:33:35 +0200
Message-Id: <393bdebc87b22563c08ace094defa7160eb7a6c0.1694190795.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() does not return negative error code on error, it returns the
number of characters which *would* be generated for the given input.

Fix the error handling check.

Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1095bbe29859..8090d7fb11ef 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8501,7 +8501,7 @@ bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
 	tname = btf_name_by_offset(btf, walk_type->name_off);
 
 	ret = snprintf(safe_tname, sizeof(safe_tname), "%s%s", tname, suffix);
-	if (ret < 0)
+	if (ret >= sizeof(safe_tname))
 		return false;
 
 	safe_id = btf_find_by_name_kind(btf, safe_tname, BTF_INFO_KIND(walk_type->info));
-- 
2.34.1

