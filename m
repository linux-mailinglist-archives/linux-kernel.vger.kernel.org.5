Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94AB797DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjIGVct convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbjIGVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:32:42 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53AF1BEB;
        Thu,  7 Sep 2023 14:32:34 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3aa139a0ab2so1004404b6e.2;
        Thu, 07 Sep 2023 14:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122354; x=1694727154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsHh3VUmRRLaCQcOu1L+EjQxG84poDmbYiq9LJBKwWc=;
        b=eSRwr50JvA/murg/vSg4+8oLvZdIEPT4YQFFyq0CXp5fmDuV71X0nkMerhMsLj+Obe
         yBBDRqwk8m4HaH2pRb8L36kzZ/ArTqefEaL4s00TF5uEjeOhYpkwUdRos+VIzTkLb6J0
         XJ952dYA/LK1jpGxtQgLzaxaEUZp7uthcXwZR6S3xSHbVmenyW7QF9oui7tqv+K6PXjP
         w751IdrdTjn1mhtXa8t6lix7873GI2pNOVXWilkq/wi2Mb/TMYal2s2YluunUXaehTWU
         UHDv2rD0ackbDkC3Qz8QOGEdg72HEPezm+CV7RkfX37bpFH0Bvlor5cxq529zleXJHD4
         ePkg==
X-Gm-Message-State: AOJu0YyRAUtUM/2Rhv6h+RR4M7VqXdVZTPixM8FjWOM4OOVu8hzwsKya
        GbGXmraE0bkivRJ36Hc29SDjZ2E4SReSGbdlKtM=
X-Google-Smtp-Source: AGHT+IGNN+hHWcAvfnDsxe5XI0uw6Li7uHgQl2eQUdsEwo0B7bhLmmGwMVtEzRqfIqwMde7/ivw43OAyrnTr/cqdLDM=
X-Received: by 2002:a05:6808:b1a:b0:3a7:3ab9:e589 with SMTP id
 s26-20020a0568080b1a00b003a73ab9e589mr748165oij.35.1694122353849; Thu, 07 Sep
 2023 14:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230903114721.190733-1-adityag@linux.ibm.com> <20230903114721.190733-4-adityag@linux.ibm.com>
In-Reply-To: <20230903114721.190733-4-adityag@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 7 Sep 2023 14:32:22 -0700
Message-ID: <CAM9d7chkvhnfhZo+Whypg40Vik3XiuvbKWZ_3jF0Zpsj+6JfqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf tests task_analyzer: use perf check for
 libtraceevent support
To:     Aditya Gupta <adityag@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 3, 2023 at 4:47 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> Currently we use output of 'perf version --build-options', to check whether
> perf was built with libtraceevent support.
>
> Instead, use 'perf check --feature libtraceevent' to check for
> libtraceevent support.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/tests/shell/test_task_analyzer.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
> index 92d15154ba79..8fbc33c95025 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -52,8 +52,8 @@ find_str_or_fail() {
>
>  # check if perf is compiled with libtraceevent support
>  skip_no_probe_record_support() {
> -       perf version --build-options | grep -q " OFF .* HAVE_LIBTRACEEVENT" && return 2
> -       return 0
> +       perf check --feature libtraceevent >/dev/null && return 0

Maybe we can add -q/--quiet option to silent messages.

Thanks,
Namhyung


> +       return 2
>  }
>
>  prepare_perf_data() {
> --
> 2.41.0
>
