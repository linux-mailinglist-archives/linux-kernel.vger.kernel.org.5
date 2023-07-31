Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5898769D94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjGaRDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjGaRCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:02:48 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3E1FE8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:02:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79095499a17so122509039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690822941; x=1691427741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE5derB4eYbJpu/3vlhDztTOvurVy780ibA6vwMtb3Y=;
        b=VnMjq5NLh25g6mPkexSFg2g5BH4qNjmX6r9sRd/qWRH/FqYXKiwN1+3gTZGm7yEAl8
         +I2ZeCyk8HXFLHIvwtG8actJJvSVpdq5rttjGK943fe9dTUk2xh+ftl4HNHr2udaP7EC
         Bbd6SqBjZy1+rSPsKVD+ckemrsQTZ8xFYnMJWMEqKOe/Oi3qiZBSbfYWMm81nkRs6tr5
         z4jFohx5QymVVDAXv4k57QKaUbZj45RmcJNp7sIJl11FM6NgJhrClZLa2ULrdZVVkPGP
         yiEKkwxMCN3pM2EDwy/qumoiWTuGhyDfG62+EirwzFWS8g79rjKh9s/gVSvUqywD/T8C
         rOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822941; x=1691427741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE5derB4eYbJpu/3vlhDztTOvurVy780ibA6vwMtb3Y=;
        b=Dt3XjfL4bjvbKx9/vOzRPfiKj9/bOHsZO5kEiyx2ZUh5KqHmxiy2yIIXAMF7H3a6jK
         gllhulzwro2Wp4/kZ94JU0mDnC9c52S4Yyonhx0THrv/fmaFGRYr80L0AnUOljc21pdO
         kF9RHwPmBPdLT7EBhYLfpGo+TJ4hIecSLyPt+Qk+F1/77J7360szOqkcYRELgtr7aIT2
         7acwOqhodRx7bAdKoy/4QdHDkhpMCYvhUYgNslx97Z1RE+JgyFVmM/bH17MWtV/1bRcE
         4gQjoyHNIEDHx4WhkyoUzV9kTBtRD0Vx1dvV3N7YEnC2Rm9EDbujiASOJ7rgWrwWzbkv
         AJbg==
X-Gm-Message-State: ABy/qLZrBisXPytUmHcqbNLkMGXr6S6rgINHjqaSVAxjQzjNSwSY16dE
        jrmxNOS5BtGXsDTWEVAiwKxwFfGo9BSANaT3m9LMOQ==
X-Google-Smtp-Source: APBJJlGa/BnG7+9y8fiFHMf9MT0+f91Pzk1wLWmfZlMTD1SqFOIw8O5CX6tTd7srL4YNkxR3Sme+uxIEQ5JSfpNbp50=
X-Received: by 2002:a6b:7d06:0:b0:786:f47b:c063 with SMTP id
 c6-20020a6b7d06000000b00786f47bc063mr9332620ioq.21.1690822940844; Mon, 31 Jul
 2023 10:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230727011612.2721843-1-zhangpeng362@huawei.com> <20230727011612.2721843-3-zhangpeng362@huawei.com>
In-Reply-To: <20230727011612.2721843-3-zhangpeng362@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 31 Jul 2023 19:01:43 +0200
Message-ID: <CAG_fn=Vm2-sckXeFhbbXekm+ENCjUnuX2rGb-gtPAZifS4NaWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: kmsan: use helper macro offset_in_page()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:16=E2=80=AFAM 'Peng Zhang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Use helper macro offset_in_page() to improve code readability. No
> functional modification involved.
>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
