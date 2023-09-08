Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E99798DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbjIHSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344727AbjIHSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:23:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27044682;
        Fri,  8 Sep 2023 11:20:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9A5C433CB;
        Fri,  8 Sep 2023 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197242;
        bh=5gYfhHtbATN1eBZVLKgHgCJ6/y3b9OYHJfOcIM3jMVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohSUDPXS5dIWfC5d5DxljfFeXqa1OsFfDszXY6fZQYHJ9iy9cQy4xrofha5IOw9TV
         QdLcIkeF28rvG2TToqudpMZvXw93KjkMcOCqSc6VReywk13z1HhCQY7x3HewwhL3sv
         VNc2PMBgLFCJD8VkvFd5DmDcNMcsPRt9Er1a7tIAd/2sTvwCbac4asAFlJxKcgaDq+
         Hkg97hgOiOeN0KJMwP6On1PGcbPz8aHpFtIqXlzxMqFKSN5y/uWZ0IpYt/Ylb+ekS3
         OSsOlaP4Y2kw0WLydQhS1QGZ0QvYnz4YoBFD1tahofu8AkTp8rzHJ17Qv2qjkYYAKT
         rlQs+yUIsbRCA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Luo <haoluo@google.com>, Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/14] libbpf: Free btf_vmlinux when closing bpf_object
Date:   Fri,  8 Sep 2023 14:20:00 -0400
Message-Id: <20230908182003.3460721-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
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
index 015ed8253f739..44646c5286fbe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7962,6 +7962,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object__unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
-- 
2.40.1

