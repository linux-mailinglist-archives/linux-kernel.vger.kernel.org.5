Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4B7E035E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376612AbjKCNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjKCNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99083
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a62d4788so2615770e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017015; x=1699621815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCmq6ecNHq9wQ5I/v/wW8k80iE2cJiNMS0glwgLSSUA=;
        b=P5DXfnGm+1DVs0NFVjMhd+p12QhM6GUalIJ1voaVop6yGefr9ejiFlbQDpKvE3fxtr
         clIBovkRoyszm9wmvw/8RYfkCZky94GEGN7hdeCBXqBzLPrjMtJxZ28g14UDbbr1riu9
         Ab9GCZFw29ih46mwtgNHicjdLHoISTRSs8tiCERnnRHMoCFWbPQZPl2MKZQwFPn+FsYg
         6xAigz8tMb7zJtHF04AidTOzDCguR8G11YaJNRbepWoO22/HZKYHsEJBznxS5nIwVM8i
         /1XsoGXrKoAhzVoQU3PPlyGcSBvMQotlhTcu44cH2/YAmON1qBfgTm15u/eKuCOY/B09
         CMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017015; x=1699621815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCmq6ecNHq9wQ5I/v/wW8k80iE2cJiNMS0glwgLSSUA=;
        b=n1tq+DqXseR/pajyuaAgjD6sxUnecaxasRW7eY7Tk8CtawEPKpD9hGrIejMljfbh2n
         3xl6xcmLEhR1DqGLyvezEHu42uRgkMj7C5ygMoKA1IdT1ePfQ/KUQe0+Qx+SQyr+LZb/
         nxpV/4Gg3VCEh8a9umdBAmnK+a/OU9NF64HtZkhISjDT0EymJ/zO7OGOZ2f88wHswvFN
         VZKPAvfBlkkSQebUF366k6qhWdu+713vB5roo06EoYRE7FNUcP+VA5wpzgZmuVkg88Np
         bNXRwfUszef/ugB0zN9Uyq2RzwCXejDUYFXQD02PhPdUOPgaWhGSWCpd7PZYR6UcuWcb
         5Fbg==
X-Gm-Message-State: AOJu0YzDHvbozoCcYKbfS1HhykOGpJU7u7KXxqGq4fMBHmyRBRbBXVKx
        3eVzRfB1JuevSTC7m0uiN3mqBcc4cp91+Zzfp2hO
X-Google-Smtp-Source: AGHT+IEF9Xju8k36xJdC20HDqFLX9sPEzp8yH1++rJF9awv17rwDpUIpcTPwkYsLvpVtI4Yt7AZ2Tg==
X-Received: by 2002:ac2:4f8e:0:b0:503:1d46:6f29 with SMTP id z14-20020ac24f8e000000b005031d466f29mr14497523lfs.37.1699017015502;
        Fri, 03 Nov 2023 06:10:15 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:15 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v1 00/12] dyndbg: add support for writing debug logs to trace
Date:   Fri,  3 Nov 2023 14:09:59 +0100
Message-Id: <20231103131011.1316396-1-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for writing debug logs to trace events and trace instances.
The rationale behing this feature is to be able to redirect debug logs
(per each callsite indivdually) to trace to aid in debugging. The debug
logs output to trace can be enabled with T flag. Additionally trace
destination can be provided to the T flag after ":". The trace destination
field is used to determine where debug logs will be written. Setting trace
destination value to 0 (default) enables output to prdbg and devdbg trace
events. Setting trace destination value to a value in range of [1..255]
enables output to trace instance identified by trace destination value.
For example when trace destination value is 2 then debug logs will
be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.

Usage examples:

localhost ~ # echo "module thunderbolt =pT:7" > 
				<debugfs>/dynamic_debug/control

This will enable output of debug logs to trace instance 
<debugfs>/tracing/instances/dyndbg_inst_7 and debug logs will
be written to the syslog also because p flag is set.

localhost ~ # echo "module thunderbolt =pT:7,l" > 
                                <debugfs>/dynamic_debug/control

When trace destination is followed by another flag then trace
destination has to be followed by ",".

localhost ~ # echo "module thunderbolt =pTl" > 
                                <debugfs>/dynamic_debug/control

When trace destination is not provided explicitly then its value
defaults to 0. In this case debug logs will be written to the prdbg
and devdbg trace events.

localhost ~ # echo "module thunderbolt =T:25" > 
                                <debugfs>/dynamic_debug/control

This will enable output of debug logs to trace instance
<debugfs>/tracing/instances/dyndbg_inst_25 with debug logs output
to syslog disabled.

Given trace instance will not be initialized until debug logs are
requested to be written to it and afer init it will persist until
reboot.

Please note that output of debug logs to syslog (p flag) and trace
(T flag) can be independently enabled/disabled for each callsite.



Jim I took the liberty and based my work on your patches you pointed me
to https://github.com/jimc/linux/tree/dd-kitchen-sink. I picked up
the commits relevant to trace from the dd-kitchen-sink branch.
The only changes I introduced in your commits were related to checkpatch
complains. There are two errors still left:

1)
ERROR: need consistent spacing around '*' (ctx:WxV)
140: FILE: lib/dynamic_debug.c:1070:
+				  va_list *args)

Which seems to be a false positive to me.

2)
ERROR: Macros with complex values should be enclosed in parentheses
62: FILE: include/trace/stages/stage3_trace_output.h:12:
+#define TP_printk_no_nl(fmt, args...) fmt, args

I have not figured out how to fix it.

Changes:
V1) Major rework after receiving feedback in 
https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/

Jim Cromie (7):
  dyndbg: add _DPRINTK_FLAGS_ENABLED
  dyndbg: add _DPRINTK_FLAGS_TRACE
  dyndbg: add write-events-to-tracefs code
  dyndbg: add 2 trace-events: pr_debug, dev_dbg
  tracefs: add TP_printk_no_nl - RFC
  trace: use TP_printk_no_nl in dyndbg:prdbg,devdbg
  dyndbg: repack struct _ddebug

Łukasz Bartosik (5):
  dyndbg: move flags field to a new structure
  dyndbg: add trace destination field to _ddebug
  dyndbg: add processing of T(race) flag argument
  dyndbg: write debug logs to trace instance
  dyndbg: add trace support for hexdump

 .../admin-guide/dynamic-debug-howto.rst       |   5 +-
 MAINTAINERS                                   |   1 +
 include/linux/dynamic_debug.h                 |  57 ++-
 include/trace/events/dyndbg.h                 |  54 +++
 include/trace/stages/stage3_trace_output.h    |   3 +
 include/trace/stages/stage7_class_define.h    |   3 +
 lib/Kconfig.debug                             |   1 +
 lib/dynamic_debug.c                           | 414 +++++++++++++++---
 8 files changed, 465 insertions(+), 73 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

-- 
2.42.0.869.gea05f2083d-goog

