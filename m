Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A177CCCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjJQTzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjJQTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:55:41 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB5ED;
        Tue, 17 Oct 2023 12:55:40 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57e40f0189aso3215072eaf.1;
        Tue, 17 Oct 2023 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572539; x=1698177339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eA2nFZj1wzdGS7YxyIDKBexw77sgLNg1YSUDsCcOvw=;
        b=DwDawMPSVtWC9uGjguOqKD7J7aiG0rbFPXus+kC556/ORlRT6XgsMxzYU+whWYN2qk
         ZqvmYuBygYPFjzZqkoY+9e5OO29w6WYq7bSukrwkbwS1LGSbnas9onBs8liceclfkX9m
         25hgtKKXQTHAgixiFzCguu07gWTnv5LtJ3/sZR88DxAMkrIJl7nY3MpnPi8qSkC6YND3
         dW9WFF8WEaoekaxgxTlrC5Z49+w94Uq1RdDMy8Mw5DrUR+UiMRHGy5V2L/gRj7yJalkZ
         wPrpZ1KTAIXajmS/mow7yK07u9C7OiRZ+RtI0os4/2ua+veUM1bTg9ueWX61Vx0Xg1EJ
         rZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572539; x=1698177339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6eA2nFZj1wzdGS7YxyIDKBexw77sgLNg1YSUDsCcOvw=;
        b=Urdb6eV9pDpL5nLN6SQrYcJl0vJ0I7gu7kOn6COqEyx3oVw784IaDG38Ljko13LKog
         jCexn+yFQZzzuVfR1R+KkelCMBp8MoDewi3KxoAJgzOcGF74RzxZUPRd72Z9lCED8lHM
         joUOzFs8bY1ahTJa00dQ3P2mL+vuxd79LDVm/Wi39h/B8sYsOH6tK7FUm3oyE1bnsMiU
         XBKWJBWpdhZmUjRe8iI7mpl81+DLqhdIw0Rce+0codLABn1jHwYqDI/Aa5rb+YrzQIhA
         FYut/+RNl8etT4bTYvy3ru4b0UqldFM7t1EKR/NsjX5WPoAAdoE/FCaAnkLYamz/jGZ/
         eP2A==
X-Gm-Message-State: AOJu0Yx8OsMR3hQQSotUwDzbUnm63+OjQTtqu0El5xrBG2v0V1cLkcfS
        RcDDJ45XzvQgzxru2WMY/us=
X-Google-Smtp-Source: AGHT+IHJU4qw2rYt2MWhCbJ9de4DAvbX9iFmXe9orXLWzJmeTm5oGQlas9DcFBpgR+dqGF6Teq/0zg==
X-Received: by 2002:a05:6358:ed7:b0:141:162:b0cd with SMTP id 23-20020a0563580ed700b001410162b0cdmr3444338rwh.19.1697572539218;
        Tue, 17 Oct 2023 12:55:39 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:c77b:3fef:28e3:81d2])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b0068fece2c190sm1848041pfg.70.2023.10.17.12.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:55:38 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        John Garry <john.g.garry@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org
Subject: Re: [PATCH v1 RESEND 0/2] perf cs-etm: Improve timestamp tracing
Date:   Tue, 17 Oct 2023 12:55:30 -0700
Message-ID: <169757198792.167943.16079905055591841742.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231014074159.1667880-1-leo.yan@linaro.org>
References: <20231014074159.1667880-1-leo.yan@linaro.org>
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

On Sat, 14 Oct 2023 15:41:57 +0800, Leo Yan wrote:
> This patch series is to improve timestamp handling in per-thread mode.
> 
> The current code doesn't validate timestamp and always return success for
> per-thread mode, for a sane implementation, the first patch is to allow
> validation timestamp tracing in per-thread mode.
> 
> The second patch is to respect timestamp option "--timestamp" or "-T",
> when users set this option, the tool will automatically enable hardware
> timestamp tracing in Arm CoreSight.
> 
> [...]

Applied to perf-tools-next, thanks!
