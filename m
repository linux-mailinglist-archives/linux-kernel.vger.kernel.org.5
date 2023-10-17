Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6937CCCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjJQTzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjJQTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:55:40 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DA9E;
        Tue, 17 Oct 2023 12:55:38 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57b8cebf57dso3206418eaf.0;
        Tue, 17 Oct 2023 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572538; x=1698177338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr6iIx34rTQ2mmt9kM1eh444YeAY0zEmKwl7Qqi+iQU=;
        b=TsAaqVD58w/4dyDU/k1htIBnrDWXPaibm3Q2DnToivFBwrt4AZrlDvBskUYGjMaSOK
         /v4LwtU3Xe0YhTR6ytg7CBg3MSbVzG1e4AhggFTJtup5ScjWZjcrRS6plTjwyKjjDLhX
         b+aKdasgTIMw+LrmXReCt4fYC1OIf/ttSAfg0OxbhwF8TQitlIXFQtgTv22hkyZ6bkFA
         4PBhU41j6tqtbfnYJ+PGWp7tnsy9Km87Ogh3K+0Ql28dZck1hkfjUWcRqNXTTuEyuQZ7
         Im1GTzAjYoFDKJMP5WqyeRfdx+P30vICP1jbEgbzGcd8jJOIcBskEygFRAkVoNDQjIV0
         lh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572538; x=1698177338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hr6iIx34rTQ2mmt9kM1eh444YeAY0zEmKwl7Qqi+iQU=;
        b=BUDN5NDHbYu2W3MWUartTSZev3Idu0JAjCErPhxSNLrP/IXAzo4y3MWosEawft9PKl
         xE8KHDr06fdVZvoONBfJ4RVv2V6B1/OTQKFEguwsCMpYCZ6QeFHqvGjNkYQybUiKnJQL
         qYgGeNbS9PTiNWcAdsRE3xT/WgmjIBxEAw5gF9bdV5BWKcZUOUTf2Yf/jGirLpfW+tX1
         dl9ZH5xxNjC0z2XbqNeaD57+p2XJIkwrnKgqqRWWwILInSweRL+jDiXbkeQWD4Z4HOQO
         U/N5Pr4Ki3ivCBmoOWcNpgy82hfP2ly/Lv1aRpKVJ98TwuMXjecz/FQtLd5btfejjrR0
         0XyQ==
X-Gm-Message-State: AOJu0YzypNKIzNidGcN8+Yoh/c5pCgkJdsmzru8vsAanF5Jv53l6EyEw
        UpelZur3pNUxlMy8GUjLbos=
X-Google-Smtp-Source: AGHT+IFs5zP/eVXPkHMzGmr0+zD8r8RbxGzsnYjyWPhcZt78cW8m1uf2569gvsCLGJNY5rI5WjnAWg==
X-Received: by 2002:a05:6359:8091:b0:134:e4fe:e162 with SMTP id re17-20020a056359809100b00134e4fee162mr2878726rwb.13.1697572537867;
        Tue, 17 Oct 2023 12:55:37 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:c77b:3fef:28e3:81d2])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b0068fece2c190sm1848041pfg.70.2023.10.17.12.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:55:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Mike Leach <mike.leach@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        coresight@lists.linaro.org, Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 0/7] PMU performance improvements
Date:   Tue, 17 Oct 2023 12:55:29 -0700
Message-ID: <169757198792.167943.8358990853717369246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
References: <20231012175645.1849503-1-irogers@google.com>
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

On Thu, 12 Oct 2023 10:56:38 -0700, Ian Rogers wrote:
> Performance improvements to pmu scanning by holding onto the
> event/metric tables for a cpuid (avoid regular expression comparisons)
> and by lazily computing the default perf_event_attr for a PMU.
> 
> Before
> % Running 'internals/pmu-scan' benchmark:
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 251.990 usec (+- 4.009 usec)
>   Average PMU scanning took: 3222.460 usec (+- 211.234 usec)
> % Running 'internals/pmu-scan' benchmark:
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 260.120 usec (+- 7.905 usec)
>   Average PMU scanning took: 3228.995 usec (+- 211.196 usec)
> % Running 'internals/pmu-scan' benchmark:
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 252.310 usec (+- 3.980 usec)
>   Average PMU scanning took: 3220.675 usec (+- 210.844 usec)
> 
> [...]

Applied to perf-tools-next, thanks!

