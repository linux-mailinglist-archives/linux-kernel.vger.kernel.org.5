Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A537530CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjGNE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNE5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:57:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AA2D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:57:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2K3W2d1nzBR9sc
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:57:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689310662; x=1691902663; bh=CsJiRvlfiU+SLN3sgAfoRbBp9D/
        h+nRJSRaz5ccoFlM=; b=tSghKWhRKhmDxmG7JeqJBo4v13llPgRRmyHwPHBQmA/
        M/93yk8QzyXmqYsb5eCOAqAk1dH1nFQPXOQ/sKPIhBhS4sSrhlvOfltSCbh3BC0a
        XSpKL5OEsxu4jheJdSJWmhNUh29fzuv+UBlBwEa0SgG3+6a+WPugnY8hVLfeZRjd
        +EtSBn/SAyNWRdcC0bat166qniLVzs4TlsL83wBKunYqZgrRhuT65fP+Q10X0tTP
        fAqWePEPu8KgQ6hB4pLFu3WnY/VCw3xiVLN357TtLpSLtTgpAqtF3Sab9mTVuZeh
        1gtRT+KrY9nBffYn5gv/ciZb//yidCMLPi/3az1z+8A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hJ-GFkleozje for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 12:57:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2K3V3fxjzBHXhN;
        Fri, 14 Jul 2023 12:57:42 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 12:57:42 +0800
From:   chenqingyun001@208suo.com
To:     maz@kernel.org, oliver.upton@linux.dev, catalin.marinas@arm.com,
        will@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Subject: [PATCH] KVM: arm64:Use #include <linux/kprobes.h> instead of
 <asm/kprobes.h>
In-Reply-To: <tencent_2099141F01FC6C32AAA20B385053A477C507@qq.com>
References: <tencent_2099141F01FC6C32AAA20B385053A477C507@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <3d56cf129c2cf1cf53f19ebe3c23a803@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since <asm/kprobes.h> is a kernel-proprietary header file, it
should not be included by user-space programs.
And <linux/kprobes.h> is a public header file,
which provides some functions for registering
and unregistering probes

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kvm/hyp/vhe/sysreg-sr.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c 
b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index b35a178e7e0d..072471df8b1b 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -9,7 +9,7 @@
  #include <linux/compiler.h>
  #include <linux/kvm_host.h>

-#include <asm/kprobes.h>
+#include <linux/kprobes.h>
  #include <asm/kvm_asm.h>
  #include <asm/kvm_emulate.h>
  #include <asm/kvm_hyp.h>
