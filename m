Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE896798EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbjIHTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjIHTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:07:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7333B8E;
        Fri,  8 Sep 2023 12:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0F3C433C9;
        Fri,  8 Sep 2023 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197199;
        bh=Bw7BD57gTfmTQejdO40EktYA1m5WMUEbeAZug9wk/Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrNy+duFj/R93sFt3Lb9gWxHmBvo3GFkbIB2dZPxEi1VoUQO9fMJ1nZxl3VxaodhX
         FwcZocT5wp+ivGlkbFd5w0qzzD/UHiRCyKi+Jzl7vIyMN2b3t06yXTdmG7T1zJoseG
         f7B2Nw9AVPlfQPevH10xpFKe4kfg7j7T42m/u5Fa7pFGLVkVez8s2Jbf+yKM0oUWF+
         hESu0o4OM4fMNIjOzbIghQCxTzNmXxY+l+pl3KkYqn7DqTsUqZplGKFzjhnR6kxLuu
         wvYtXp/2vdAPiPjt9Dgu0ZCQObVrV6IZLfNyFSa4ELCCvXqqbsBD+dURpgyMN38kMI
         JoyoPAq58jtOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Luo <haoluo@google.com>, Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/15] libbpf: Free btf_vmlinux when closing bpf_object
Date:   Fri,  8 Sep 2023 14:19:17 -0400
Message-Id: <20230908181920.3460520-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181920.3460520-1-sashal@kernel.org>
References: <20230908181920.3460520-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Luo <haoluo@google.com>

[ Upstream commit 29d67fdebc42af6466d1909c60fdd1ef4f3e5240 ]

I hit a memory leak when testing bpf_program__set_attach_target().
Basically, set_attach_target() may allocate btf_vmlinux, for example,
when setting attach target for bpf_iter programs. But btf_vmlinux
is freed only in bpf_object_load(), which means if we only open
bpf object but not load it, setting attach target may leak
btf_vmlinux.

So let's free btf_vmlinux in bpf_object__close() anyway.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230822193840.1509809-1-haoluo@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f87a15bbf53b3..9b8a0fe0eb1c3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7559,6 +7559,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object__unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
-- 
2.40.1

