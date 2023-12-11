Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18980C07A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjLKEzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:55:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B680FED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:55:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d1e1edb10bso37801605ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702270552; x=1702875352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kl4wg1J09lcPpRVdW57uX8PEQktJgyhY3gmEO1BemVo=;
        b=WMINwjEMdz0YJ33dmHAasIetA4dQ6Sfv4GedYvAQuYZ4bHmIpXPd9RfYAQ4E038vfX
         dYvpYHo4ffq3EXnE3efJoyPuwmPTWIMVoxtfbBfQTegnTEwmQJFaOlHjpVE+iol9CLIm
         x9nbhvd4k9sRhSE+XWflcNdVS4etWxzyUb3EWM66AS3CXOnrOgtR5womrJHDqUsonu+m
         qnOYzIyV/Meqp+mIWA0exXyR7Rs+cpGcoa79ENUGK8q8JoK+OCIisi1y/EJzcIVwP+Vh
         N7q2Y/68VMWov5QPE64Xt061N+u7xU7n4CjhmHpFSrVtjd3wvnM3wGYnziLKr4j9ZfRi
         /qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270552; x=1702875352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kl4wg1J09lcPpRVdW57uX8PEQktJgyhY3gmEO1BemVo=;
        b=drwLmHFGN3qcp8TYebS4LrWDY7hephRaJYDru8RvF3xmU0gtsUeogTd5ECFAlvXqny
         C0kIDNkF9jReHVE14iZ6aN/ehfEzw3JzvPN+bDyFzPo97TjYgOHXlUoXHCmJ30RaG9vG
         g5eNuOXfoyJ2aNu8cZRjWNt6F2rzdxogM6rS1wLrYVIJcCV4Qr4U82V196rvkBkvT9np
         t9ATWdLvaYflRMNv0asrn9I9efWIole0mwEo6z7i9qTQnoJoCIP1RiM4MYyNsj8pcHvZ
         DZaFbGRGNGMcu/eJKfEMm3puXNLFOOOYC3jwKaf1UzNgho86sVqf32/167b1kJSsugkQ
         k4Ww==
X-Gm-Message-State: AOJu0Yzj+Xv3nweptOhjkPurUe6fCmhWrh8YUyxUjUXHk+O8uGkmprOI
        26FYTzUrbJENCm6OFgpWzHQ+dw==
X-Google-Smtp-Source: AGHT+IHuWkmPjE12XCHEO61i5/dytoy32ww7FGStSF9nnNLWWezXsnMaj6wFfeKpkqjVRMXmfnyeqg==
X-Received: by 2002:a17:903:2303:b0:1d0:6ffd:e2c5 with SMTP id d3-20020a170903230300b001d06ffde2c5mr5310259plh.95.1702270552180;
        Sun, 10 Dec 2023 20:55:52 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001d2ffeac9d3sm3300623pls.186.2023.12.10.20.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:55:51 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marco Elver <elver@google.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Robert O'Callahan <robert@ocallahan.org>, bpf@vger.kernel.org
Subject: [PATCH v3 0/4] Combine perf and bpf for fast eval of hw breakpoint conditions
Date:   Sun, 10 Dec 2023 20:55:39 -0800
Message-Id: <20231211045543.31741-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

rr, a userspace record and replay debugger[0], replays asynchronous events
such as signals and context switches by essentially[1] setting a breakpoint
at the address where the asynchronous event was delivered during recording
with a condition that the program state matches the state when the event
was delivered.

Currently, rr uses software breakpoints that trap (via ptrace) to the
supervisor, and evaluates the condition from the supervisor. If the
asynchronous event is delivered in a tight loop (thus requiring the
breakpoint condition to be repeatedly evaluated) the overhead can be
immense. A patch to rr that uses hardware breakpoints via perf events with
an attached BPF program to reject breakpoint hits where the condition is
not satisfied reduces rr's replay overhead by 94% on a pathological (but a
real customer-provided, not contrived) rr trace.

The only obstacle to this approach is that while the kernel allows a BPF
program to suppress sample output when a perf event overflows it does not
suppress signalling the perf event fd or sending the perf event's SIGTRAP.
This patch set redesigns __perf_overflow_handler() and
bpf_overflow_handler() so that the former invokes the latter directly when
appropriate rather than through the generic overflow handler machinery,
passes the return code of the BPF program back to __perf_overflow_handler()
to allow it to decide whether to execute the regular overflow handler,
reorders bpf_overflow_handler() and the side effects of perf event
overflow, changes __perf_overflow_handler() to suppress those side effects
if the BPF program returns zero, and adds a selftest.

The previous version of this patchset can be found at
https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehuey.com/

Changes since v2:

Patches 1 and 2 were added from a suggestion by Namhyung Kim to refactor
this code to implement this feature in a cleaner way. Patch 2 is separated
for the benefit of the ARM arch maintainers.

Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleaner
implementation thanks to the earlier refactoring.

Patch 4 is v2's patch 3, and addresses review comments about C++ style
comments, getting a TRAP_PERF definition into the test, and unnecessary
NULL checks.

[0] https://rr-project.org/
[1] Various optimizations exist to skip as much as execution as possible
before setting a breakpoint, and to determine a set of program state that
is practical to check and verify.


