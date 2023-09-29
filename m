Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62087B349E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjI2OOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjI2OOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:14:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A510D7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:14:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3232e96deaaso1627712f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695996839; x=1696601639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0oAyXAB8Kt0enGgPoo66x41kbTf1AFVvqj5ECchyAUM=;
        b=aSMTqIrFhTn3HiOITEseOFuCDAONUERX6t6TWwOkq756TUc+lGPv+3nICCbvU2nw+f
         OFPGdCOLa2uzlCH7t4Lqf3leqQrUDQfuJsJFBJs5sHGoFULKiJZq3VXxESagRtaShtIO
         bJapw0oJ/a/z1bk3HWQG7YsbJgQjZ/gM/t3iSkXcCCam4TS2OskTN0Oz9mpGvSGnDo0P
         nXyEq7gqsRDBFNRpSWw9oWkbxKnzOigzbETaMNWKnhG/GgWcpBT9SNZnmO/XvbWhv1N4
         xYchjpm8F3QzbqlXYMYnbHPTLNbbCWqpixoT8AYhRUX4HLcBi7CmCnWw+OXybjh1e3pm
         lKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996839; x=1696601639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oAyXAB8Kt0enGgPoo66x41kbTf1AFVvqj5ECchyAUM=;
        b=pcXIeCI8bF/fsKjVxPAS9xCm/uVlAzu8Mtk9HmtfsIZG3aUobCtdgGvXUayQhbmEjq
         3ju+3ezegwsGp62RynPRA/C/12SPPzL1gr0cQbbptvoDfeNsOFSqbVACBcauNIirP+hS
         GIHnVNzrYp1yYZ85X4QXYYR9qDaOjNqMFejgZ+BZGAnTLQoHQl9uCDjQIHblMs1fCLFf
         bDRrA7jJoWFsqR5o1qeg7B2wMAHwmNfPwkh88agY6wkaXW8u0AOxpymYoSoI0igLTn/U
         sd3Q3s+oC1t7SnujkKYRtgXuQqMZabZix06r1DQQsokjPo0WAledwDud/hh9lmHp7+ve
         7moA==
X-Gm-Message-State: AOJu0Yx1xQA62GBRnnLwrCbukowCIam/X5wpiqA7h7WAM3VGadSFCs7k
        fhcEZBeu19aLRXNEluHRPb/DYQ==
X-Google-Smtp-Source: AGHT+IGFOOh5+LAteol7g3S4FPXeKfzumkk2yywvg0O2Q6EhLZtL2XAFS+ExVx+JnhpGQoOvXLTm3A==
X-Received: by 2002:a5d:5151:0:b0:31a:e54e:c790 with SMTP id u17-20020a5d5151000000b0031ae54ec790mr3671242wrt.6.1695996838175;
        Fri, 29 Sep 2023 07:13:58 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:4e67:5f1a:c933:c857])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b0031c8a43712asm21606043wru.69.2023.09.29.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:57 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH] tracing: relax trace_event_eval_update() execution with schedule()
Date:   Fri, 29 Sep 2023 16:13:48 +0200
Message-Id: <20230929141348.248761-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel is compiled without preemption, the eval_map_work_func()
(which calls trace_event_eval_update()) will not be preempted up to its
complete execution. This can actually cause a problem since if another
CPU call stop_machine(), the call will have to wait for the
eval_map_work_func() function to finish executing in the workqueue
before being able to be scheduled. This problem was observe on a SMP
system at boot time, when the CPU calling the initcalls executed
clocksource_done_booting() which in the end calls stop_machine(). We
observed a 1 second delay because one CPU was executing
eval_map_work_func() and was not preempted by the stop_machine() task.

Adding a call to schedule() in trace_event_eval_update() allows to let
other tasks to be executed and thus continue working asynchronously like
before without blocking any pending task at boot time.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 91951d038ba4..dbdf57a081c0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_fields(call, map[i]);
 			}
 		}
+		schedule();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1

