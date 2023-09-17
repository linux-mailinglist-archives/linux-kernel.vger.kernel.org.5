Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81457A33D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjIQF1Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjIQF06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:26:58 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650E1AE;
        Sat, 16 Sep 2023 22:26:52 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-79ac0d271b4so76698639f.1;
        Sat, 16 Sep 2023 22:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928411; x=1695533211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfO839NuY6Onl0KGlAC2kjo8+d7ohK4fYM2jge+IesU=;
        b=Po62N03k+wbRPiGO5rmQAieAJ49O8VRS7bQ5EDj/Tt95VYfWj4ad3PtB19XFUCOu+Z
         KZydANGvLoE/zOlqt0KgQZhj/SlFpd7uj71IvKJYyoBc9wtkQ0owfDq76hqPtJ83/nLt
         4Ghd15+gwpjvh8SVDv3uNkyu0eBoIx8CbTmqizkNDI4u+J/fxrEK8R11CMOOxIGu5mPB
         6U9RJROa9CItLV+j5pRFp9FISi9z9pAHk9OlZQXpe12sl0wWy1gD2fPtu7U1qH3QbZlA
         3pmK1qJ9yKUuUP8v11e4tAPTTJXcJJeYYreGzdFrbHqAd5mMAWUZWT47mIVSGFphuzIv
         Ghsg==
X-Gm-Message-State: AOJu0YxKtNyHNpOiq3u+cT6NgGun2f7vJLeJ1jKsRR1Yii7kdO4UOm43
        jXiulzISZs2lWqiQQBBe6HI0+0EvFAePUoMl5Y0=
X-Google-Smtp-Source: AGHT+IEcz12DmKsdTPdSZxvRu1pBc0PxhybywnJTfzj5kgqbmjW7wTf1cqOLS0hdhKwE1+iM7g9l+UpfReF0pT1yl6w=
X-Received: by 2002:a05:6602:24c6:b0:792:72b8:b90 with SMTP id
 h6-20020a05660224c600b0079272b80b90mr6665476ioe.16.1694928411437; Sat, 16 Sep
 2023 22:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230914022204.1488383-1-irogers@google.com>
In-Reply-To: <20230914022204.1488383-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:26:39 -0700
Message-ID: <CAM9d7cjNxuOVM95OoYEhuj0rePMt4tfQ0RGepW4R5WHvjX3v-g@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents metric: Fix type of strcmp_cpuid_str
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 7:22 PM Ian Rogers <irogers@google.com> wrote:
>
> The parser wraps all strings as Events, so the input is an
> Event. Using a string would be bad as functions like Simplify are
> called on the arguments, which wouldn't be present on a string.
>
> Fixes: 9d5da30e4ae9 ("perf jevents: Add a new expression builtin
> strcmp_cpuid_str()")
>
> Signed-off-by: Ian Rogers <irogers@google.com>


Applied to perf-tools, thanks!

Namhyung
