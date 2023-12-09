Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3A80B56C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjLIROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:14:06 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0A137;
        Sat,  9 Dec 2023 09:14:12 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c2308faedso33585175e9.1;
        Sat, 09 Dec 2023 09:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142051; x=1702746851;
        h=mime-version:message-id:date:user-agent:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFZwViJ6f92+SPClRElHJp1Vv2gXoHKsUhjNztqGxkM=;
        b=WyV34mXammQ6zC1ftc8wXNvhx56Q8pRm8jVFASYo66X+1rO9DeHYXEQn3QVhsCtdbw
         4arybAk+IjkJbXe38563ul+K02qCpXF39Y0pmnWzHtOzkcDYpMwrpjYWar/K8cAxJFx3
         BdpPxL/7yMU1/6IUfam5xXIrjJy6bHA75/ikyWnPw1Sv4zMCtCP3HwRal8i0Nb5SeCZ8
         o8TWkPW/i8az6wLPgUvjhF2vyfuT2mmIvHW6BdnXq449Hrfek7NAjGGx9XP8D67aBdfF
         lasOH+lKLPZ5ZSVDcxaWQKcVnmHjmBTvlh2RASAZGRXhfqQES3EW944m3aRNUkBKwJsU
         vJTA==
X-Gm-Message-State: AOJu0Yy4v2gXVdumMdwbZ03rZwR4Gbr1oQx/TivUcwZqLRaGVdTqHN+T
        or7H94pfUZ3BlUbONrZpaB4QXUhyzfo=
X-Google-Smtp-Source: AGHT+IHVrDKM++LQZkN2LzSg6WcdOfxRMOAFY6kT/hLKwIiCJ9XCnT8oB2PxKUWgTuoC0TyN+6+Phg==
X-Received: by 2002:a05:600c:1c1f:b0:3fe:4cbc:c345 with SMTP id j31-20020a05600c1c1f00b003fe4cbcc345mr953979wms.41.1702142050834;
        Sat, 09 Dec 2023 09:14:10 -0800 (PST)
Received: from hera.home.vuxu.org (i5C75CC70.versanet.de. [92.117.204.112])
        by smtp.gmail.com with ESMTPSA id g12-20020adfa48c000000b003335eded7f5sm4760454wrb.68.2023.12.09.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:14:10 -0800 (PST)
Received: from localhost (hera.home.vuxu.org [local])
        by hera.home.vuxu.org (OpenSMTPD) with ESMTPA id 9b41eab0;
        Sat, 9 Dec 2023 17:14:10 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     kan.liang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: 'perf top' broken on intel hybrid systems
In-Reply-To: <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Sat, 09 Dec 2023 18:14:10 +0100
Message-ID: <877clnz4bh.fsf@vuxu.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The error is because the perf top always tries to open an event on the
> user_requested_cpus, which are all CPUs by default.
> 
> Something as below should fix it. For hybrid, open a PMU event on an
> unsupported CPU should be error out.
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c

This fixes "perf top" on my i7-1355U.  It would be great if you could
get this patch into upstream and stable branches.

Thanks,
-- 
Leah Neukirchen  <leah@vuxu.org>  https://leahneukirchen.org/
