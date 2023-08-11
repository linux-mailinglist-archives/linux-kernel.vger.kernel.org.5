Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200F77859E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjHKCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKCsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:48:39 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C312D60
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:48:38 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so13155306d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722118; x=1692326918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMBDXA84g45MvGZcRAUpRl/KzGFzLPhOq6x39ktx8/E=;
        b=B3TZ1bCn77xc47XbxuchQBs0+jUJsxUcpdzKuv8ut5MuC/NXGFEJjd8apA3jwF0jh2
         Pb06yfhQpGSqFGlYh/00IxT5CY6ZjlZFDYRzbaPjGd6WVSaP3bOjv6F8yNca4Hy5+GsG
         0kruP7P8TAPE1hoW9OKti7F+RyhW+jv+6kVEwqYfVyyakfNeTJyyr6MrdA7vbAkd2M19
         5cBx/85u4PusvDAViJ6jWOD2tzAGdj8yKLjQIms7rLO0kNrS9IiiHWOX1bQHJIN2NJpx
         GXiUUQLEX0Jdl1yr8GsvRVw/JJYKKlAhIuhnjVzx0PhmuQLrjItvRg9aTiTjUQngGhmj
         quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722118; x=1692326918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMBDXA84g45MvGZcRAUpRl/KzGFzLPhOq6x39ktx8/E=;
        b=ClCMWjgjiJBArz7JiDmhX0FFc/PrPCyKWdcis3vPD3y4ME1ODXg3Wn21UT8wgst/X8
         0VrOCbL1oolkUaNwSJ/CtVSwCj62OiNJ3diUOK7AL8kbbeL7QPrFI/PfoktrWuJLkkho
         wuMqf0+R1bqNJX+IHPaEN+izCjiPQ+ZVaLAmte5ARI6dUp7tGLm4WnQb7GtMQxpoCNM3
         MZSVhuzf4410SIxOj2vJiNUTmGHLGepvKrNnIJEzpkfv3L9M34UOkmQ691wa6S95MY3e
         tThl+xECN6V3ycNxOOK33ehOIQPotEcf2l69gGpF8kipWLdkT8MTgRjGlI9/dlFoicRK
         wiaw==
X-Gm-Message-State: AOJu0Yz5u8u2PXCEg8+qmeNRnejFh8SfEAuN9TMmozv1v3X3gV8G1sgG
        md38qLUJsNGPBsBcm+xJpv4=
X-Google-Smtp-Source: AGHT+IE5Ri76mAP8KOkXF8jvnd0e7Pv2C2cpprax49ILKQyJk7tNN9XbSYfq3TYMUsXdwu+0iZYh7A==
X-Received: by 2002:a05:6214:ac3:b0:637:b20d:899d with SMTP id g3-20020a0562140ac300b00637b20d899dmr5982723qvi.10.1691722117746;
        Thu, 10 Aug 2023 19:48:37 -0700 (PDT)
Received: from 5900x.home.arpa (d-216-36-4-19.md.cpe.atlanticbb.net. [216.36.4.19])
        by smtp.gmail.com with ESMTPSA id c17-20020a0ce151000000b00641899958efsm564874qvl.130.2023.08.10.19.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:48:37 -0700 (PDT)
From:   James Preston <james.walter.preston@gmail.com>
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, dirk@hohndel.org,
        James Preston <james.walter.preston@gmail.com>
Subject: [PATCH] x86/cpu/amd: Add Van Gogh to Zenbleed fix
Date:   Thu, 10 Aug 2023 22:47:48 -0400
Message-ID: <20230811024748.1331186-1-james.walter.preston@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Van Gogh (Steam Deck) is family 17h model 90h, and was missing from the
model range array for the fix.

As the SoC is Zen 2 based it is vulnerable and with no available
microcode updates it currently has no mitigations without the fix.

This patch does not provide any microcode revision to check against to
disable the kernel fix, since that is an unknown. Once such a revision is
available it would then have to be added in cpu_has_zenbleed_microcode().

Signed-off-by: James Preston <james.walter.preston@gmail.com>
---

Before patch:
	[nameless@steam-deck tmp]$ lscpu | grep -A2 'Model name'
	Model name:                      AMD Custom APU 0405
	CPU family:                      23
	Model:                           144
	[nameless@steam-deck tmp]$ ./zenbleed -m 4 -t 30
	*** EMBARGOED SECURITY ISSUE --  DO NOT DISTRIBUTE! ***
	ZenBleed Testcase -- taviso@google.com

	NOTE: Try -h to see configuration options

	Spawning 8 Threads...
	Thread 0x7f55e1fff6c0 running on CPU 0
	Thread 0x7f55e17fe6c0 running on CPU 1
	Thread 0x7f55e0ffd6c0 running on CPU 2
	Thread 0x7f55dbfff6c0 running on CPU 3
	Thread 0x7f55d3fff6c0 running on CPU 4
	Thread 0x7f55db7fe6c0 running on CPU 5
	Thread 0x7f55daffd6c0 running on CPU 6
	Thread 0x7f55da7fc6c0 running on CPU 7
	Thread 04: "%%%%%%%%%%%%%%%%"
	Thread 06: "5db7fe6c"
	Thread 06: "        "
	Thread 06: " CPU 1  "
	The consumer thread completed, sending cancellation requests...
	All threads completed.

Test immediately found strings from sibling threads.

After patch:
	[nameless@steam-deck tmp]$ ./zenbleed -m 4 -t 30
	*** EMBARGOED SECURITY ISSUE --  DO NOT DISTRIBUTE! ***
	ZenBleed Testcase -- taviso@google.com

	NOTE: Try -h to see configuration options

	Spawning 8 Threads...
	Thread 0x7f8ac1fff6c0 running on CPU 0
	Thread 0x7f8ac17fe6c0 running on CPU 1
	Thread 0x7f8ac0ffd6c0 running on CPU 2
	Thread 0x7f8abbfff6c0 running on CPU 3
	Thread 0x7f8abaffd6c0 running on CPU 5
	Thread 0x7f8aba7fc6c0 running on CPU 6
	Thread 0x7f8ab9ffb6c0 running on CPU 7
	Thread 0x7f8abb7fe6c0 running on CPU 4
	Alarm clock

The test found nothing in 30 seconds so the vulnerability is now closed.
The system is operating normally with no ill effects.

 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b55d8f82b621..506ce9257e35 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -73,6 +73,7 @@ static const int amd_erratum_1054[] =
 static const int amd_zenbleed[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x90, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
 static const int amd_div0[] =

base-commit: 25aa0bebba72b318e71fe205bfd1236550cc9534
-- 
2.41.0

