Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42575E943
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjGXBtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjGXBsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EDB6A71;
        Sun, 23 Jul 2023 18:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5A760F5A;
        Mon, 24 Jul 2023 01:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF1EC433C8;
        Mon, 24 Jul 2023 01:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162522;
        bh=/SA4D8gh2JTmeV4nGu+CvkOMYUG15B8No+LlTBF6Sbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuS2OcbVK6jIRMAvXs6aZT9jThraxL5DBqzxOPco6q+6rxOWnjgEYoqvrcaUNbWFe
         TPqxYnDqWJqyBSJXdRtbuCkWb+iIYs74KcsQtRIuk4sFR0TN74A1OXfEwiSQAfbvye
         j3QxqMcTwOBLrLUFfJW7xGsZZ4ahPrN5WsjEp+J9vQHICK6jILrl1ZM8/Ck/ObzJAH
         ijcElE4XKYGQ7TMe2gviyKO4HPyJbIBvQYGxnyiIO6ZiRhynaIAy0+g4ClZbk2QzkO
         Jvvr4LdShQ9Nv1yBEPlpdNfd/rmn7rMktAr3wxHtyo3tXurKgei8AdUvf3EMJI7nNg
         zLSW8sHC8YUug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Armin Wolf <W_Armin@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-pcmcia@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 6/9] pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()
Date:   Sun, 23 Jul 2023 21:34:42 -0400
Message-Id: <20230724013445.2334326-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013445.2334326-1-sashal@kernel.org>
References: <20230724013445.2334326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.288
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit c85fd9422fe0f5d667305efb27f56d09eab120b0 ]

When nonstatic_release_resource_db() frees all resources associated
with an PCMCIA socket, it forgets to free socket_data too, causing
a memory leak observable with kmemleak:

unreferenced object 0xc28d1000 (size 64):
  comm "systemd-udevd", pid 297, jiffies 4294898478 (age 194.484s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 f0 85 0e c3 00 00 00 00  ................
    00 00 00 00 0c 10 8d c2 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffda4245>] __kmem_cache_alloc_node+0x2d7/0x4a0
    [<7e51f0c8>] kmalloc_trace+0x31/0xa4
    [<d52b4ca0>] nonstatic_init+0x24/0x1a4 [pcmcia_rsrc]
    [<a2f13e08>] pcmcia_register_socket+0x200/0x35c [pcmcia_core]
    [<a728be1b>] yenta_probe+0x4d8/0xa70 [yenta_socket]
    [<c48fac39>] pci_device_probe+0x99/0x194
    [<84b7c690>] really_probe+0x181/0x45c
    [<8060fe6e>] __driver_probe_device+0x75/0x1f4
    [<b9b76f43>] driver_probe_device+0x28/0xac
    [<648b766f>] __driver_attach+0xeb/0x1e4
    [<6e9659eb>] bus_for_each_dev+0x61/0xb4
    [<25a669f3>] driver_attach+0x1e/0x28
    [<d8671d6b>] bus_add_driver+0x102/0x20c
    [<df0d323c>] driver_register+0x5b/0x120
    [<942cd8a4>] __pci_register_driver+0x44/0x4c
    [<e536027e>] __UNIQUE_ID___addressable_cleanup_module188+0x1c/0xfffff000 [iTCO_vendor_support]

Fix this by freeing socket_data too.

Tested on a Acer Travelmate 4002WLMi by manually binding/unbinding
the yenta_cardbus driver (yenta_socket).

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Message-ID: <20230512184529.5094-1-W_Armin@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pcmcia/rsrc_nonstatic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 123420cac6b54..b75b12c2c702d 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1056,6 +1056,8 @@ static void nonstatic_release_resource_db(struct pcmcia_socket *s)
 		q = p->next;
 		kfree(p);
 	}
+
+	kfree(data);
 }
 
 
-- 
2.39.2

