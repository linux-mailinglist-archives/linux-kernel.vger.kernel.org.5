Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746C07D8759
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjJZRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345508AbjJZRL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:11:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15785198;
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b709048f32so1107594b3a.0;
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340285; x=1698945085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D85lFdCWmQtsZx66clLkUgk0g1bjlZ8sBGHleszKtQg=;
        b=OBTWx8A/w2pjqrnULKETnCf0uyLBzYz3ifoA1j6Mk+JSyeHx0yricCac5wRwTk5anU
         /o05ADy1219J570zHTH0gciXkrXjb/WZl5x2ehRAmS3NXgPrv6vDn35CiBG8zcTD8Zmc
         /jlgaAVTvkLpxjQf9S4SQ4azrJbCc9POQqHk9ekc4GqlRKiOaKctpUz64Fd2Qr0R0A4+
         urQO2QZLzf1bzxePXE13s+uyxfzVDPkuoWJLAt3zghF9mvcclxYFuVe/UNfdXvMF8QUp
         4X1jHd2wZ1nz2uUSnothj3SM1ux1CEbkGyY3t1D0LmxW5TX+elIKnX6YluDaBLYEv+pb
         eA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340285; x=1698945085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D85lFdCWmQtsZx66clLkUgk0g1bjlZ8sBGHleszKtQg=;
        b=u6porAkQIXbaXfoYSmS05O0EYBXOkxhmHFIRifvNCeP/l4p4TmoMVSbwLOQJlozVVA
         WJih65G9buiMgK2yJXLJFs3dvkKj+N6GvD6H21y2XYnuoIP94g3oSH3onPWWpGhiIjav
         B5LrAbly5y/DgJXusgDH1J1dmglUv8+/gBxwJXP86D71t71kCOfrwABMqaNHeGHTtZ34
         MTcVcfJ3fBUfKzIfo0C6G4uVe09XnHjp9c/nMgSiDg0Wou2hhFmZVDQkOj+JAevhrGw5
         azgjiTo5ygE0lAgAqwkxHfiZZrazgEkbiV3Tkl1hqYOYuSQ+exCAEFdaBBicbVCe8PsB
         zbgg==
X-Gm-Message-State: AOJu0Yy6PAqFi2bJjveN0kH8Dsv6nXCasvVdHgCfq9iYkoMQw/pW+Ynv
        i3prN+kwib+oHd5ZlzrIfSU=
X-Google-Smtp-Source: AGHT+IFb3a7kbrHNiEm9tR5u55Ww2ou21gHCA9nXz9yoK/gBVovaxhWJVmDIylm4eAEHThY+Gn+tyg==
X-Received: by 2002:a05:6a00:1345:b0:6bd:f760:6ab1 with SMTP id k5-20020a056a00134500b006bdf7606ab1mr146195pfu.14.1698340285296;
        Thu, 26 Oct 2023 10:11:25 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:25 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4] perf bench sched pipe: Add -G/--cgroups option
Date:   Thu, 26 Oct 2023 10:11:13 -0700
Message-ID: <169833996379.1181734.14450239393575810758.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231017202342.1353124-1-namhyung@kernel.org>
References: <20231017202342.1353124-1-namhyung@kernel.org>
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

On Tue, 17 Oct 2023 13:23:42 -0700, Namhyung Kim wrote:
> The -G/--cgroups option is to put sender and receiver in different
> cgroups in order to measure cgroup context switch overheads.
> 
> Users need to make sure the cgroups exist and accessible.  The following
> example should the effect of this change.  Please don't forget taskset
> before the perf bench to measure cgroup switches properly.  Otherwise
> each task would run on a different CPU and generate cgroup switches
> regardless of this change.
> 
> [...]

Applied to perf-tools-next, thanks!
