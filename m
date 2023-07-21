Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A52775C25A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGUJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGUJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:03:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEE2D7D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:03:54 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6kBF4fR5zBRSTx
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:03:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689930229; x=1692522230; bh=cSCFQw9hjDMj+m8XhrzSaZr3Xb5
        zOIMnO6//5pRzzUI=; b=SL4/VJC/YYJ5jJy/p/43OSr3VVt5H44t7KQd323F+5C
        LJwFbfBGpj2hLfeaeeKrrHLFPHUZ7shmrrN98x02ZUyS06ePbdtrr4l9kuyThyzb
        mppTInvQe/OPpyAlbHrSkATN0BMZx/S8+mNRcVI670J21nAqpgKsS1ajBexq58TV
        0gYaHFXSoCWdPvl6soWFbvB3mUbtP+TNkFu8HZSAHspOSCQP+NcGC/2dPpjCA/qL
        0vAy/9R6GeQTG3Wyr9gXWQZzVz7cPb64xrLNOtgf6VOi/mxy5NZ4iN9mh5ibfKHh
        uZmTnXJBDeerD1FmpQFDmPvfGmScTk56IchGX6/nzCg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a03nskruB0IP for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 17:03:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6kBF1qXNzBJnMj;
        Fri, 21 Jul 2023 17:03:49 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 09:03:49 +0000
From:   sunran001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ioapic: do not use assignment in if condition
In-Reply-To: <20230721090248.6331-1-xujianghui@cdjrlc.com>
References: <20230721090248.6331-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f42427601560dee3e611a6145b6c3b8b@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/apic/io_apic.c | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c 
b/arch/x86/kernel/apic/io_apic.c
index 4241dc243aa8..be32b085d37e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1058,8 +1058,11 @@ static int mp_map_pin_to_irq(u32 gsi, int idx, 
int ioapic, int pin,
  		if (legacy)
  			irq = alloc_isa_irq_from_domain(domain, irq,
  							ioapic, pin, &tmp);
-		else if ((irq = irq_find_mapping(domain, pin)) == 0)
-			irq = alloc_irq_from_domain(domain, ioapic, gsi, &tmp);
+		else {
+			irq = irq_find_mapping(domain, pin);
+			if (irq == 0)
+				irq = alloc_irq_from_domain(domain, ioapic, gsi, &tmp);
+		}
  		else if (!mp_check_pin_attr(irq, &tmp))
  			irq = -EBUSY;
  		if (irq >= 0) {
