Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2439D7F507F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbjKVTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:24:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3818E;
        Wed, 22 Nov 2023 11:24:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf56e28465so864875ad.1;
        Wed, 22 Nov 2023 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700681095; x=1701285895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hol4kxY9z6nDPa7JhSgwu09hyjFOyiqBtHvwqvFaQO0=;
        b=GLPxxVZx0+I5BnfPfs7x0vedNTJxk2jHdJgK6W94la2GCVep5u/apgEWgGS21bT8Ji
         U2sDANKfrrHgxC/77GiSsKe1NFsZwT0VkN8o+uJGto5LqKh5QclnyrmYkblOJNlHIdNO
         Epyb8jbY+RyL8amfz4H95ojt1aDBkKMGQWv8mUXMi4QN1sQOH6ZkGtRzxEQgovxBasc1
         gvgQ62bE1vwLm0I2iMZLt4BQaRYor4pXNbKawGeKOOVk+3TzPd+VEU3rbWE2j3GCNkA0
         BYiwHyUUByx5XMKNsOC/+sZqDVC33DtTWMj0w5CRTeeh9LdoiWt7xeCzu3ZM8hXukTR4
         +Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681095; x=1701285895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hol4kxY9z6nDPa7JhSgwu09hyjFOyiqBtHvwqvFaQO0=;
        b=n2Y+uoeg3z6LYnSAE+JgEYpLYa0UIwoh9wJIAxkt4hL8QvPSrcSNBfC/gQ1Cf26tfu
         iL66cnL0e/XZfU2nLiHFlqT1Oc4me9ghw2f1YPCZysO7ky8/wNpIQ0kwV7znrviKvE6a
         LKBFMCzJyVUxaKgTZPtPQspvOTlqu6q0xie774P9c8cBXuiuStxVUO5kBnmPNZ3U70va
         HrR3rKHmUEFxm40kIzfXHO+SDH0lmfgKyQsgxwZL1o+Au9jybjIuJ4SDlJ0y/FYpGs82
         C/aYGC75/BI94+qrzM8FYFw0S6bZESIfDD9orQMDxzmoUMjI2GCAv33DNSuM46pFrM32
         FrgA==
X-Gm-Message-State: AOJu0YxyEE+vHAXhXlkDqSOmbcxAjSqUwPEJYN1Fx/wbRkahTNz9/4fF
        AxAQet3JWhKrKQpIi+n67As=
X-Google-Smtp-Source: AGHT+IHOIY4oQhShMp7XC27o5w1jWo1CRUIOfFrJMtXCdSfnY0Ywhx6IFuVkWxaqsSIUkUd1q82xhQ==
X-Received: by 2002:a17:903:258a:b0:1c4:56c8:27f8 with SMTP id jb10-20020a170903258a00b001c456c827f8mr3011932plb.68.1700681094962;
        Wed, 22 Nov 2023 11:24:54 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ef5b:f5a4:3bf9:1731])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902f69100b001c726147a46sm29009plg.234.2023.11.22.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:24:54 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     avagin@google.com, daniel.diaz@linaro.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        irogers@google.com, acme@kernel.org,
        Yang Jihong <yangjihong1@huawei.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] A few fixes for i386 build errors
Date:   Wed, 22 Nov 2023 11:24:43 -0800
Message-ID: <170068099708.2334730.17653997760705514012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231118024858.1567039-1-yangjihong1@huawei.com>
References: <20231118024858.1567039-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 02:48:55 +0000, Yang Jihong wrote:
> Yang Jihong (3):
>   perf kwork: Fix a build error on 32-bit
>   perf lock contention: Fix a build error on 32-bit
>   perf bench sched-seccomp-notify: Fix __NR_seccomp undeclared build
>     error on i386
> 
> tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
>  tools/perf/builtin-kwork.c                  | 2 +-
>  tools/perf/util/bpf_lock_contention.c       | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> [...]

Applied patch 1 and 2 to perf-tools, thanks!
