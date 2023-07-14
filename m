Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E575317B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjGNFsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjGNFsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:48:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B02123
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:48:06 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2L9b25qLzBR9sM
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:48:03 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689313683; x=1691905684; bh=P47K7jXvA45fclYf4dasK1LeFOG
        dQ+OUWctDP0gqIXI=; b=ngLfrW1XHzF57rEcAQKtVSsTL7Z9VTH3VdHeFkV7MYB
        bIvy/iItRKWAsjZrVCVpUaEGHomMYrIjuFqsF0NW6iNlLFI36QhJ4chxQcfTJhc8
        /o1mdDO772QRUmoZHm8uJ7IyN/f04/qd88YUjh/1fe5RiYkBPSRGJR27YbxOhUQu
        lTZ7NixeTc5ZhBvvaSqDexY/tc6KJChtqabJRkM5X2bEzoq3VMRBAd00w0XbAWOJ
        yDVoIPG9p/BLqmV7bFM82qRQOH0Q+P5Jh9rIJP8MeEmhXbAqiyFfXGyDdCmOqNP6
        5pJ8CcsFRb27aRJOISqU0ifovjOK/f1F/f1j2X+OO8Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZMAsBCvnuW2O for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 13:48:03 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2L9b04MHzBR5C9;
        Fri, 14 Jul 2023 13:48:02 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 13:48:02 +0800
From:   chenqingyun001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kprobes:Use #include <linux/cacheflush.h> instead of
 <asm/cacheflush.h>
In-Reply-To: <tencent_A428F07DC9F08B94E0D44D8FDF25667A7C09@qq.com>
References: <tencent_A428F07DC9F08B94E0D44D8FDF25667A7C09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8ab7efa1c7dcde54a8bea39f66ef4712@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/cacheflush.h> is a generic header file,
while <asm/cacheflush.h> is an x86 architecture-specific
header file.

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kernel/probes/kprobes.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c 
b/arch/arm64/kernel/probes/kprobes.c
index 70b91a8c6bb3..9da6b07801fa 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -22,7 +22,7 @@
  #include <linux/uaccess.h>
  #include <linux/vmalloc.h>

-#include <asm/cacheflush.h>
+#include <linux/cacheflush.h>
  #include <asm/daifflags.h>
  #include <asm/debug-monitors.h>
  #include <asm/insn.h>
