Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A17CCCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJQTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJQTzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:55:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F3ED;
        Tue, 17 Oct 2023 12:55:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so3311535b3a.1;
        Tue, 17 Oct 2023 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572534; x=1698177334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJulstcUd5/uTxrCXWl5kYXpRYu+VuExy2t32bX2aJ4=;
        b=Bc1kwd3a5Rdby4zu+v7ZhwzNtly43d1+xhQGsckCHj7qTPutAORTEWqOee5pUUjNlB
         JMQf14p6ExU3L3+yzFdKe4nMBFy1oi1bAIqXAOIOZgRpma09rW0NpM7M4wHvmzVgn420
         A7C931iz1DsiHHa54IlfUJBqoGygJw9rMQUZROfv6ECNMv/L3qMdGlOc/AJR1IAr7UyY
         YYppPP0ZgRppKqk/WZTr+99noegu2zLVnwn3oPyDMMv1Gdyo5YtnRDJsA249nnxVggAP
         0KH7ImMkM1B7XI+RTdeR/ZoRD64WzjZ9r3cP5XoiGFA+GX3zsc4i1rid7b0PgGDqjOHi
         toDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572534; x=1698177334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJulstcUd5/uTxrCXWl5kYXpRYu+VuExy2t32bX2aJ4=;
        b=cd1aUkyoaPRb8ORdEL3nxMdn+8l8ceNwshSBmSu8FhsyqFpbgnpAsPI6APn1bFxDRn
         uHk+JL4DbxAcARW9eEJ59qFtavmqR+gqo1ITOOF5K3EgKCJRsM2ptsLwmvQx+r8QSx7N
         ENeNS2V9PgLLyRcNUlyShDkYLlEbXm3OyqQcNnWOl61B/tmlGVUfLLk2nOThKLy3ewip
         4n1H7G6SjnlXKCBBYQGytCCxdWZh9prqw86RxxhzxtkKxXV5CBrph3UhVwlRbctVAo9j
         8hVklfwFkQbxlMyDEM6gdYE/fPLUfCzmQmHkyTsxfXMgZgmArNoC+YRMy3JtqA3j1tr4
         9lcA==
X-Gm-Message-State: AOJu0YySnH8aav45eUJitE9Q/Vxi6YF+Y/uj05EDE0+zBlc8uKGP5tIP
        7BnjkkuHn3jOICWwv2J6OHzRbSReELY=
X-Google-Smtp-Source: AGHT+IFVPtvMGRNNqkk6KcRmPHqM39EREZ1KiSDdRWgdSxuPd4g4MGW/CAIiKgMyPjMp9o9/z70fwQ==
X-Received: by 2002:a05:6a00:134f:b0:691:2d4:238e with SMTP id k15-20020a056a00134f00b0069102d4238emr3530984pfu.6.1697572534136;
        Tue, 17 Oct 2023 12:55:34 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:c77b:3fef:28e3:81d2])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b0068fece2c190sm1848041pfg.70.2023.10.17.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:55:33 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        kjain@linux.ibm.com
Subject: Re: [PATCH] tools/perf/arch/powerpc: Fix the CPU ID const char* value by adding 0x prefix
Date:   Tue, 17 Oct 2023 12:55:26 -0700
Message-ID: <169757198795.167943.3033399687445090221.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231009050052.64935-1-atrajeev@linux.vnet.ibm.com>
References: <20231009050052.64935-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 10:30:52 +0530, Athira Rajeev wrote:
> Simple expression parser test fails in powerpc as below:
> 
>     4: Simple expression parser
>     test child forked, pid 170385
>     Using CPUID 004e2102
>     division by zero
>     syntax error
>     syntax error
>     FAILED tests/expr.c:65 parse test failed
>     test child finished with -1
>     Simple expression parser: FAILED!
> 
> [...]

Applied to perf-tools-next, thanks!

