Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFE7CCCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjJQTzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJQTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:55:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA9E8;
        Tue, 17 Oct 2023 12:55:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3026748b3a.1;
        Tue, 17 Oct 2023 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572536; x=1698177336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36rokymbjL8K6TM3vT0V5xjEIIaYDcCKvW5oeNKnaPo=;
        b=dG2+BKhjldPgk1F7dM9T0pHMhsQ+LxcLilfc5fWEWfKv1xUGjxG3jl5xxmvzl8WYQO
         b9Rft5rKdr3zMomt7vL7x3Y+6yeU7fzOdAgZADzQglqx+LJC486HPLln1bq5zKd+EcWF
         gqL+kU9umPBMvUMndNJxrkoFWWbxDMjHdmUElw0YSFtCo8f9ofmuVET1Jbob3TPYIqcz
         T2a5tWgTnjOuy5nZgM/riW7cYH14EirvqQ2NhE4sRHmhruIoiqLkKabZxQN3WMUDWkMs
         jOBLVG1DK5cIKqw4A4AuLRHB0EE9LyzUt6BA8JofH5lX0rraX/ZnReB9+tlOps/ACjZk
         5fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572536; x=1698177336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36rokymbjL8K6TM3vT0V5xjEIIaYDcCKvW5oeNKnaPo=;
        b=hAB5yOWzYSxsvwz3q86IpEruQGzUtREqPNu29K9WIByUS3pvcbGugID/cwXWGna0qD
         ElepJz2uQBUKPL4SwsbZOPHqYygC9BAtclkpR6Pobb6CHbeLZLnXRC/Co1i8RfWUFjeF
         Gx5CK16md8jAiF74IjHN12DDQfd5E6/r9egKDzsZk26QGnlsqZu5huW2E0fy5bRtN7bv
         Q5RBsJrokgPeg1pkyL6ppznlQx1WA+oSoVj5RgIClnyGOkmInlk3KAXa9SSuq4kY6KZT
         kLFZpPTcEB+Yoj8IKXNqwFPsd4EhZMHG1jIJQKL0rBQg/0cyZpy6hrGMeucO/1+++tiH
         zBDQ==
X-Gm-Message-State: AOJu0YyWU19oBby9gCH88WBpiukpp7S7v6Xpur6harEjA6uHfNvn9Gi1
        8glUohNmY74o+NxgrP8xlUE=
X-Google-Smtp-Source: AGHT+IEvGdeIQZ7l8OExHVGvRi8/KO5WrJYIl/MfA9xxNrgDzK3DPsVlRSOcNPZUhXFjBksqgLt9vw==
X-Received: by 2002:a05:6a00:1898:b0:6bc:635a:aad3 with SMTP id x24-20020a056a00189800b006bc635aaad3mr3484016pfh.9.1697572536197;
        Tue, 17 Oct 2023 12:55:36 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:c77b:3fef:28e3:81d2])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b0068fece2c190sm1848041pfg.70.2023.10.17.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:55:35 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Changbin Du <changbin.du@huawei.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RESEND PATCH] perf: script: fix missing ',' for fields option
Date:   Tue, 17 Oct 2023 12:55:28 -0700
Message-ID: <169757198796.167943.5141979068741564750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017015524.797065-1-changbin.du@huawei.com>
References: <20231017015524.797065-1-changbin.du@huawei.com>
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

On Tue, 17 Oct 2023 09:55:24 +0800, Changbin Du wrote:
> A comma is missed at the end of line.
> 
> 

Applied to perf-tools-next, thanks!
