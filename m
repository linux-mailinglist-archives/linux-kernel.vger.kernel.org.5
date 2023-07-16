Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48A75571C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGPU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjGPU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01AE9;
        Sun, 16 Jul 2023 13:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B97C60E71;
        Sun, 16 Jul 2023 20:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F848C433C7;
        Sun, 16 Jul 2023 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541035;
        bh=onCFm98c81/Vnl+zEOGckQqZnJ1rAGitlR8pEVSZX18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/V8VK1Da77zcRkoCUffbAM14sXbboRWNzU0ZuSlvIRc/xxdfGNeXsUTe9C5rJvQC
         szql7EjMVei1Z9XsITfSqNPTQ5DHroWVXFXj7sayWWXcPENjuSbLS8/BvnfOJdZqIR
         iSrEuXNzTpcGxle6o0wBaNJpbDCwCfzxsl376KdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Hsu <John.Hsu@mediatek.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6.1 576/591] mm/mmap: Fix extra maple tree write
Date:   Sun, 16 Jul 2023 21:51:55 +0200
Message-ID: <20230716194938.761629385@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

based on commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.

This was inadvertently fixed during the removal of __vma_adjust().

When __vma_adjust() is adjusting next with a negative value (pushing
vma->vm_end lower), there would be two writes to the maple tree.  The
first write is unnecessary and uses all allocated nodes in the maple
state.  The second write is necessary but will need to allocate nodes
since the first write has used the allocated nodes.  This may be a
problem as it may not be safe to allocate at this time, such as a low
memory situation.  Fix the issue by avoiding the first write and only
write the adjusted "next" VMA.

Reported-by: John Hsu <John.Hsu@mediatek.com>
Link: https://lore.kernel.org/lkml/9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com/
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -767,7 +767,8 @@ int __vma_adjust(struct vm_area_struct *
 	}
 	if (end != vma->vm_end) {
 		if (vma->vm_end > end) {
-			if (!insert || (insert->vm_start != end)) {
+			if ((vma->vm_end + adjust_next != end) &&
+			    (!insert || (insert->vm_start != end))) {
 				vma_mas_szero(&mas, end, vma->vm_end);
 				mas_reset(&mas);
 				VM_WARN_ON(insert &&


