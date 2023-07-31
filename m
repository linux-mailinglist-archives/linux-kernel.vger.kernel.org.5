Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7976769D98
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGaRDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjGaRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:03:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B1187
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:02:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-790aeee9928so31495339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690822974; x=1691427774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RayNNN4Qsk5njctZkhjYqrV8F8rSqnb41Z/GqHhScLY=;
        b=TO2rSHWImFGmbwiBXOGkz0MophXT7FiXCOYt7Ou3mfm1etNVbLuYYLoWUHHb9YajCx
         isSRtT65+dD2Tz18FP3v2RKP72XHW1cva98orlSssxWFO8KDgmq2f3eSNEHR+HmA4rx0
         OfJN8ibDuMK2LX9X60EBbpmS9Es8/BhpZJ1oRedNP6Hwmhj3U4s5NveSlDipXk0/dzt3
         hPdaBT0pLwcNjjd1xxIO/jTlEr7L40Y7CH51lwAkpVO+aNnRoksfNBlPo+4EiBby5X3H
         QCe4wbqe0xwZKXfH5MDImW1X8tQsbdugXZyCEkPFEzljzNPkeMnegJYYHr7u/SlP0CBE
         xFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822974; x=1691427774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RayNNN4Qsk5njctZkhjYqrV8F8rSqnb41Z/GqHhScLY=;
        b=QpcBGO5P/3Gy6lBeAgaODbkJEH6ODM+NZEAbiAJPtPcZh8CUDdvEDFbvdYBgqel4MD
         WxetVxlRJRx4ju2SdRk2Sd7tWL5ZP5yUYlZ9QTndZKREOVqNAPp/J+p9DW0gi5OSYwNS
         +4gy3uPfYGIPVxdubvGbAIcziGOU3ajtbM5upd5Ve0QhLNaon3lH9uwR9bxKE+h0P/9+
         93wWd6BE2GMnpaqeL8LDHyjt0g8K1porQvMLZ233UNAtFXQvj29aWSLFcLGj8SgPrfha
         LvWYzpev8WiXcGnIUoxMDbP8v4MERjfXpgvjzEmfahHDlIM6iRnd4vyJnsem9DIh7Scu
         lorw==
X-Gm-Message-State: ABy/qLYVcYMGqfHgAvxzZnAgR0rMNZcQWttMEJcvpOO/5Kb576mFOOr1
        JVUqvLzStCHvEoTaBw3bwIc5fOmpgAdPuZ6CTsKOOw==
X-Google-Smtp-Source: APBJJlF2m5qxDiO5I/OueY6Mdty32bX6eFnZiB429UiSjutxrVSuhm4KrFC4jTZQhdoqwCnwhnRiZlXkWXAwUsALQO8=
X-Received: by 2002:a6b:dc09:0:b0:790:adce:d553 with SMTP id
 s9-20020a6bdc09000000b00790adced553mr2275104ioc.21.1690822974404; Mon, 31 Jul
 2023 10:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230727011612.2721843-1-zhangpeng362@huawei.com> <20230727011612.2721843-4-zhangpeng362@huawei.com>
In-Reply-To: <20230727011612.2721843-4-zhangpeng362@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 31 Jul 2023 19:02:18 +0200
Message-ID: <CAG_fn=WK4Wyh-xeV_-71p3Yms6ZyXbSduAqMZknh1+3XHbgYfg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: kmsan: use helper macros PAGE_ALIGN and PAGE_ALIGN_DOWN
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
> Use helper macros PAGE_ALIGN and PAGE_ALIGN_DOWN to improve code
> readability. No functional modification involved.
>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
