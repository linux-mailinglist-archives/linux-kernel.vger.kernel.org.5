Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BF79E84A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjIMMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbjIMMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:49:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F719B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:49:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77a62a84855so249493139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694609358; x=1695214158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vy7JcxjX2sI8J+tYRSHZ5xGLUxgOH8JQq+vqCf2qAy4=;
        b=B5vkjBE7s2YR6tOPvaE3ybgBDPwNvwLdUSEAViLJLq+eSpclJNAu7NWB5dHVHm5xE6
         DRMKT9MkFciRNlkafqNOdANn1/cmC2gn7rLXk4zKmFje4fW70FDlbUusxnT4ZTTxL1MK
         t/qSzFBLhURwtZZj/HAif8yRkx9RVz/HWgB56KTfaAVN9sI1F9pDO7U7K0+Au+E4WuWK
         6weWy8kgvzNfMiYB4CZgCh+Za2Y4GZxk+ThQBEhMLpn04JVPByoMfN6LNoelcGnJS/vx
         PpZBNZtrFiMGGt3lJ6CIqtCdOj7TJKTigZAq8uS/cNPYp8UBvv0l3lhUkqoMpUj7QHYC
         HHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694609358; x=1695214158;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vy7JcxjX2sI8J+tYRSHZ5xGLUxgOH8JQq+vqCf2qAy4=;
        b=fhuwaO1dOVKUUU1kLRlyToQ+TCGu6ibagskfHu/tng7DxaZquTXwrOgjZnMWVBcDnX
         BHfpOXQE8TIp3/qR725MrxMFqb6D8TSo6gOb8kAxaw+aPsEB/FH3RTq9lgR4Dj9cwQPb
         NuSl4h5DaO/DEfyiMfpL3lX1sL0ZQzcJ9X9ok/4I9bgci07zW6wKZYXFWMZ86hD3iYur
         nJn6wEsGpoZgcm+qiUaX6jqyc6dw//qV1mHGZ7gKSI/FLGbIFPO/JOBfd0xt9U1c7j1T
         +gY6iwK+aYMY8ZwEpr0925Lo2uNAx8Y2aqe7rqNwjoXoWO1rid1aHQBRUwoqyp7Hgrs1
         lkvQ==
X-Gm-Message-State: AOJu0YxeHabqi2T918nQbdUf0KqjRWlis0YjiSLJXretD3bXlP/PtWGv
        3Uxm7y2l9mHtuVSTvrLBGRuqtq1XZ5dJgTM9IX7Cyg==
X-Google-Smtp-Source: AGHT+IHejtFz+fyDC+oWroZbIidC71O4LjojvEegaaQWtYalzVCdqXMkq27FUcCV6IhcmsYH9IUxJCB3abCP90+Y7vk=
X-Received: by 2002:a6b:7a4a:0:b0:780:d76c:b640 with SMTP id
 k10-20020a6b7a4a000000b00780d76cb640mr2811549iop.9.1694609358299; Wed, 13 Sep
 2023 05:49:18 -0700 (PDT)
MIME-Version: 1.0
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Wed, 13 Sep 2023 21:49:07 +0900
Message-ID: <CABCjUKBXPLNaBjELHqz=Oke_JsxXLQauTWrsNmTp3KToW3-9MQ@mail.gmail.com>
Subject: NOHZ interaction between IPI-less kick_ilb() and nohz_csd_func().
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Youssef Esmat <youssefesmat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed that on x86 machines that have MWAIT, with NOHZ, when the
kernel decides to kick the idle load balance on another CPU in
kick_ilb(), there's an optimization that makes it avoid using an IPI
and instead exploit the fact that the remote CPU is MWAITing on the
thread_info flags, by just setting TIF_NEED_RESCHED, in
call_function_single_prep_ipi().
However, on the remote CPU, in nohz_csd_func(), we end up not raising
the sched softirq due to NEED_RESCHED being set, so the ILB doesn't
end up getting done.

Is this intended?

Thanks,
-- Suleiman
