Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CC7F3691
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjKUS5e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 13:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjKUS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:57:32 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89568110;
        Tue, 21 Nov 2023 10:57:29 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5bdfbd69bd5so49423a12.1;
        Tue, 21 Nov 2023 10:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700593049; x=1701197849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7nd5iX6ZJEmZiKwOnTC252kYXXi23G070RiX705xqE=;
        b=wB9/ElwECpCX7dGZJ5a2L0IXpia31OvL3/fUQ7q0Amcj6AKr445vnDG1Xg4xer0Ttb
         qs9zxi20l9S5prIvp1kk4gyQROn1y14du7bdfKznVVUo8bP7ptEuTNb2/oHVhqOjdw8c
         HgdoNOX2aTCYlfNCXTGROPTbASI/GgFVJRMipnvIFtCnkPAWV9ePVEx4E6d7b2bzlWuG
         tOePTQSMisWt1HaRa8b+otgJthfYmq44kMb/snHy2zvWieiQu+D3onlFwIvRt7/AjHC8
         Qnz6tBI7TSo1tQRVqF1918VJ3xhkFWIBt7dYsPVUnGrXwiN6xBD8AVfYlGnQJUpLXw9i
         7x2A==
X-Gm-Message-State: AOJu0YyRvYSvKQ8BhsLKmz70KiMzmNFc0Sy/r7ybxSSgF9s8WpEs45fi
        FMNCATB5RB0HhF8Y95YJpHdGDQreoZmnC1RTFwI=
X-Google-Smtp-Source: AGHT+IFuNxznNK2HJRa7VA1pE8Svesap4SN7xD+x4Dhimb/KuqtOjdJ+q0k7CEtYwL1GcfcA0qiJMB1qHBB1WFjvwmw=
X-Received: by 2002:a17:90b:4d8d:b0:27c:ecec:8854 with SMTP id
 oj13-20020a17090b4d8d00b0027cecec8854mr406468pjb.7.1700593048898; Tue, 21 Nov
 2023 10:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20231118024858.1567039-1-yangjihong1@huawei.com> <20231118024858.1567039-4-yangjihong1@huawei.com>
In-Reply-To: <20231118024858.1567039-4-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 21 Nov 2023 10:57:17 -0800
Message-ID: <CAM9d7ciAcjjncBEbA0zAoyThQUwJbeNHXuTX9mEWzUcS4FbLew@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf bench sched-seccomp-notify: Fix __NR_seccomp
 undeclared build error on i386
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        avagin@google.com, daniel.diaz@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 17, 2023 at 6:51 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Fix a build error on i386 system:
>
> bench/sched-seccomp-notify.c: In function 'seccomp':
> bench/sched-seccomp-notify.c:46:17: error: '__NR_seccomp' undeclared (first use in this function); did you mean 'seccomp'?
>   return syscall(__NR_seccomp, op, flags, args);
>                  ^~~~~~~~~~~~
>                  seccomp
> bench/sched-seccomp-notify.c:46:17: note: each undeclared identifier is reported only once for each function it appears in
> bench/sched-seccomp-notify.c:47:1: error: control reaches end of non-void function [-Werror=return-type]
>  }
>  ^
> cc1: all warnings being treated as errors
>
> Fixes: 7d5cb68af638 ("perf/benchmark: add a new benchmark for seccom_unotify")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

This is already fixed by:
  https://lore.kernel.org/all/20231017083019.31733-1-jirislaby@kernel.org/

Thanks,
Namhyung


> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
> index 4798f9d18fe8..9de35df1afc3 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -26,6 +26,6 @@
>  #ifndef __NR_setns
>  #define __NR_setns 346
>  #endif
> -#ifdef __NR_seccomp
> +#ifndef __NR_seccomp
>  #define __NR_seccomp 354
>  #endif
> --
> 2.34.1
>
