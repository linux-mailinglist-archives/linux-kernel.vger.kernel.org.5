Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06390765B21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjG0SEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG0SEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:04:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213A2D5F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:04:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so1580171a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690481042; x=1691085842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc7jh51lvqkyURmJ/OY+7GJErTQWfjzV6VRfqYhkZ5E=;
        b=rppHm5w00TKozkRuGz0uvydG0ypOWf1pFA2j74AjzokGKVYNnXfWUCLqk/DQ+b1HYT
         bd0eKpv9UQ3uml+NNWuzyqibNVtkjFifJW8CGm2zZ8YXp6Y8m1OLOVJbby3tUAyEZ/py
         mbj8D8zlR4b9mNHMTQwpZh7MH3dRI6rcn5CorGyOkyOl8p/aJk+5uhXoj2h9F14pczhO
         oERMrSgOnqvgyXAyFfxsDC1dA+GaYd03wuKPMWXy5rcWH8Ie3Y31N4gPhM0PvjsK7eXJ
         1g+TgHkHeKJnCRDPWhNnCNxVo8qQ3IqMjx8/9ffQVRHP8gSUnfgOH6MB+2Pkr9qLe9PT
         3LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481042; x=1691085842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kc7jh51lvqkyURmJ/OY+7GJErTQWfjzV6VRfqYhkZ5E=;
        b=Ni5+hX8SUrq/yTF8kXE+nSVAm1shSrMe9+81MyToMAwH+fhShaFpr9yXcK03o6nE40
         LhPZEo/WteheXMwBA0QGAZKZzsV1CcVOe0fYyOBymEbyt9d7yGCBPvraKNFLZkK2P15q
         E6GCBRViMGGCB6lILMuSANnyuajPmmRjn4fBpWngvfBTkp2k82dGWPlcb3c6nhFr/cV+
         5b93P3r4m7z06iEhcIrpm6akgrX9VmwCP2EjLdY3QJ49QM/TSUVyKXMr/1Q9l2pQq1Vb
         wNPQLNg8+PuJWoCdUgeuWStdLANXmlrudJmhRPFjxLgwrNXEU7w+DCG9rWvqVzcaXM5E
         Bcng==
X-Gm-Message-State: ABy/qLYok5VsINfOzoLhvq5kkAJY5RDrS40braNB6RlJIw8RRSVv5ZgD
        TQ/YOmHLGdKx9yY7msqWrJI=
X-Google-Smtp-Source: APBJJlFdNctAXyUHKgDdp3jhdMUPbOH5qbCKi+OoR1cZ/tsEh5z7k9ZfpG/aam4c1VBmxau4/JWZZg==
X-Received: by 2002:a05:6402:341:b0:522:5873:d4aa with SMTP id r1-20020a056402034100b005225873d4aamr2648866edw.23.1690481042042;
        Thu, 27 Jul 2023 11:04:02 -0700 (PDT)
Received: from f.. (cst-prg-78-36.cust.vodafone.cz. [46.135.78.36])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906481700b009927d4d7a6bsm1039148ejq.53.2023.07.27.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:04:01 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] seqlock: annotate spinning as unlikely() in __read_seqcount_begin
Date:   Thu, 27 Jul 2023 20:03:55 +0200
Message-Id: <20230727180355.813995-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotation already used to be there, but got lost in 52ac39e5db5148f7
("seqlock: seqcount_t: Implement all read APIs as statement expressions").
Does not look like it was intentional.

Without it gcc 12 decides to compile the following in path_init:
        nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
        nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);

into 2 cases of conditional jumps forward if the value is even, aka
branch prediction miss by default in the common case on x86-64.

With the patch jumps are only for odd values.

before:
[snip]
    mov    0x104fe96(%rip),%eax        # 0xffffffff82409680 <mount_lock>
    test   $0x1,%al
    je     0xffffffff813b97fa <path_init+122>
    pause
    mov    0x104fe8a(%rip),%eax        # 0xffffffff82409680 <mount_lock>
    test   $0x1,%al
    jne    0xffffffff813b97ee <path_init+110>
    mov    %eax,0x48(%rbx)
    mov    0x104fdfd(%rip),%eax        # 0xffffffff82409600 <rename_lock>
    test   $0x1,%al
    je     0xffffffff813b9813 <path_init+147>
    pause
    mov    0x104fdf1(%rip),%eax        # 0xffffffff82409600 <rename_lock>
    test   $0x1,%al
    jne    0xffffffff813b9807 <path_init+135>
[/snip]

after:
[snip]
   mov    0x104fec6(%rip),%eax        # 0xffffffff82409680 <mount_lock>
   test   $0x1,%al
   jne    0xffffffff813b99af <path_init+607>
   mov    %eax,0x48(%rbx)
   mov    0x104fe35(%rip),%eax        # 0xffffffff82409600 <rename_lock>
   test   $0x1,%al
   jne    0xffffffff813b999d <path_init+589>
[/snip]

Interestingly .text gets slightly smaller (as reported by size(1)):
before:	20702563
after:	20702429

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 987a59d977c5..225eb1db35b8 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -326,7 +326,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex
 ({									\
 	unsigned __seq;							\
 									\
-	while ((__seq = seqprop_sequence(s)) & 1)			\
+	while (unlikely((__seq = seqprop_sequence(s)) & 1))		\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-- 
2.39.2

