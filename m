Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239C78BA03
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjH1VMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjH1VMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3FC3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693257086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DqxapwNpcXU5UQrJcGPZCzbnwE7dcwZ4jrY3BSYkS+c=;
        b=TlKbNUITTQE9m0DS6fqJj3wlQrSMFlB52BUDmn4qYhz37DHpBz4u6VjFpu6z45WiLl+gKo
        PUqlMTfxycCfJ+vh+//e/aYVj6M85lx8XXNWN9v0TizGRVtnOdl/Uua6/ot0Voa/nHGtzS
        Y0zsVOdJC9Ldy5EgD70aPgc2kOZJK9A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-hORU5RVlP_-9_WnX8y9ujQ-1; Mon, 28 Aug 2023 17:11:25 -0400
X-MC-Unique: hORU5RVlP_-9_WnX8y9ujQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40ff67467c9so40758241cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257085; x=1693861885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqxapwNpcXU5UQrJcGPZCzbnwE7dcwZ4jrY3BSYkS+c=;
        b=iTgPa0yPNzg6rylJLpK7FCYIBjzdP2673pbr/tbv+9iDndSJtoqAgPAb1z9kVmXmqC
         N7iVBwIaAeNNEyILACZmryGttKl2/yaVXBy2qZPkg4RLf3sNc6CRJhHn7PRrTYhCQhDl
         YQafYshLNkqVlMw4D7pkVb+PzyipzbrGjj+h6Zr9E5w7Smm2Wajo8+6XuBe/RuGCNvRg
         20U6MYOOHfzlMYXHJAa80KHYSezTiaVnG9raQIy6+KUFwsfB4dhIfrhXBeJDgYxPwn5U
         RG/205pctj1OlKwXjRf7mOCtRl/dzzhzoDySnQeKmN9sZn/dgo3CLq+dSLaKYeT7ROCh
         p39A==
X-Gm-Message-State: AOJu0Yy9gCczvSSpr2eW3jfMQ2oRCiUenB4kMLMKfe0PhGfehnlLCUuT
        UmNoNlmuZDeURJ1vlIlU73BmYE0KYU7VRBE3YscTYuPqZBIylXSY+WWMHmE7/METIHQ2/jwKOZr
        BsOGoATXsOBbgmG2mq1IdTjDjOAEC4TAB
X-Received: by 2002:a05:622a:153:b0:40d:2d0c:5685 with SMTP id v19-20020a05622a015300b0040d2d0c5685mr34948131qtw.55.1693257085074;
        Mon, 28 Aug 2023 14:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnu4KOW0+2uXvz9joKEIl2jERq2FqfY95dr1tvn41dKl3063IiNY5EHisHBegqlXQdyQCmZA==
X-Received: by 2002:a05:622a:153:b0:40d:2d0c:5685 with SMTP id v19-20020a05622a015300b0040d2d0c5685mr34948117qtw.55.1693257084760;
        Mon, 28 Aug 2023 14:11:24 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id ge15-20020a05622a5c8f00b0041020e8e261sm2598756qtb.1.2023.08.28.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:11:24 -0700 (PDT)
From:   Eric Chanudet <echanude@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH] arm64/arch_timer: register arch counter early
Date:   Mon, 28 Aug 2023 17:02:43 -0400
Message-ID: <20230828210548.1010192-3-echanude@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at how long it takes to get from primary_entry to
time_init(), when sched_clock is initialized and timestamps are
available to printks. Patching in cntvct_el0 reads in a recent
linux-next (next-20230821) with the default arm64 configuration, I found
the following:
 * Qualcomm RideSX4 (sa8775p-ride, 36GB): ~700ms
 * Ampere Altra MtSnow (96GB): ~1210ms

Narrowing it down a bit, most of this time is spent in:
  start_kernel()
    setup_arch()
      paging_init()
        map_mem()
          // Mainly in for_each_mem_range(i, &start, &end)

From time_init(), each platform reports starting the init process after:
 * Qualcomm RideSX4 (sa8775p-ride, 36GB): ~1100ms
 * Ampere Altra MtSnow (96GB): ~600ms
So the timestamps are not accounting a relatively significant slice of
time spent initializing the kernel.

I found a recent similar thread[1], but I would rather account for time
spent solely in the kernel while using the arch counter.

IIUC arm64 can rely on having its arch counter, is it possible, and
sane, to attempt to register to sched_clock earlier in setup_arch()? It
would look similar to what is done for SPARC64[2]?

The following patch tries to experiment with this, but let the counter
re-register as sched_clock (through time_init->timer_probe) and does not
handle the erratas and other relevant situations:
 - erratas and work-arounds in arm_arch_timer,
 - cntvct vs cntpct (that shouldn't make a difference at this stage?),
 - device-tree overrides for the frequency (?).

Alternatively, would it make more sense to capture a counter read early
on, for example close to primary_entry after jumping in the kernel, and
use it as epoch for sched_clock_register()? Since this is only happening
early it should not have time to overflow?

[1] https://lore.kernel.org/linux-arm-kernel/CAKZGPAOYPp3ANWfBWxcsT3TJdPt8jH-f2ZJzpin=UZ=-b_-QFg@mail.gmail.com/
[2] https://lore.kernel.org/all/1497300108-158125-7-git-send-email-pasha.tatashin@oracle.com/

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/kernel/setup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..cbc51c42c9fd 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -32,6 +32,7 @@
 #include <linux/sched/task.h>
 #include <linux/scs.h>
 #include <linux/mm.h>
+#include <linux/sched_clock.h>
 
 #include <asm/acpi.h>
 #include <asm/fixmap.h>
@@ -53,6 +54,9 @@
 #include <asm/efi.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/mmu_context.h>
+#include <asm/arch_timer.h>
+
+#include <clocksource/arm_arch_timer.h>
 
 static int num_standard_resources;
 static struct resource *standard_resources;
@@ -290,8 +294,23 @@ u64 cpu_logical_map(unsigned int cpu)
 	return __cpu_logical_map[cpu];
 }
 
+static void __init early_sched_clock(void)
+{
+	u64 min_cycles;
+	u64 min_rollover_secs = 40ULL * 365 * 24 * 3600;
+	u32 rate;
+	int width;
+
+	rate = arch_timer_get_cntfrq();
+	min_cycles = min_rollover_secs * rate;
+	width = clamp_val(ilog2(min_cycles - 1) + 1, 56, 64);
+	sched_clock_register(__arch_counter_get_cntvct, width, rate);
+}
+
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
+	early_sched_clock();
+
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	*cmdline_p = boot_command_line;
-- 
2.41.0

