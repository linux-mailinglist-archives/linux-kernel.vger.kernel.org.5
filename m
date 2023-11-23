Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF77F65F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjKWSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:06:49 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB291
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:06:56 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5be24d41bb8so818616a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700762815; x=1701367615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW7KxP8ZBJngylS18OviNYrxyG4ErcVeLDijrBizFds=;
        b=R2+tBZ4HGtNumt4BAoOI2IAwUC9+oBoig+fiMY0okXBnC66GSa16pD+U3srYR6JAu1
         VdbGBQst5Nu8plZq02mLk7nsenbKaL7LruFzTO0fD0Hi8A57MNCZkGE7KAbV1Naq+wW6
         rh6WBTg785JAJOGjw8tvnJsBiPgTw+xjwmyhgbIetBh+0AzpdpPIzgHnoZ7B5gNs1umK
         Io6xqURTiz2TpKj9/3//mVyeC6WRd9k/0ZmYFwPsL7Ye5o72akHQamlip3Zz1G9uxQBt
         EFT2EwnT2iAgOSsZrz28Dq/n+084jp+ax3iWUbg+pUVfHHq+26an24IQFG9GgGebO09g
         7K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762815; x=1701367615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW7KxP8ZBJngylS18OviNYrxyG4ErcVeLDijrBizFds=;
        b=UvThf9KB4SmDBtJCgNHgfcK4ObneBz/4NyAGmxqkVJwDbv/mc9dFj1strYJu5wcg9k
         hopitjfqUOQFtpTRAsyh4GCp1VCOfllZK3vPHYxZ6g3ld9vq1QkKY79CiUAFF7Z5J1HO
         bdwO82yT9xwBiKGetnBSDpJ6d73C2J/0N3gLQjPoJN8GfWipwjH1F4bkN7QWDT0duSAd
         83eklzIRaebegVMSO4xHmDwqEvbu0vFfUAffqGpD1+GAeD0i2pZcfujjRQOhS0L58TGv
         1iO0XKGEbuRryxp499jfwolIZnI5NV6mxwUBdDNbXoSYEc70oUqT0bq1ufd/H7L6L4+l
         l1eg==
X-Gm-Message-State: AOJu0Yy/E2adz+O9kYbUSglgD+/ELgNYYNHT/E4jVa/DFhfkrtG8dam5
        gJH9tCSWvXJjTP1quXgGZicvYhV5B1ebqf22mw4=
X-Google-Smtp-Source: AGHT+IEErHSh/+XevzkeTtdgWJgR7etj0nkwGBv9/WdSfgoHCJ6rkhdd0wifMbIQ/DW9cQUc+Im19nyI5s/44BnDGrE=
X-Received: by 2002:a17:90b:224a:b0:280:299d:4b7e with SMTP id
 hk10-20020a17090b224a00b00280299d4b7emr4710858pjb.19.1700762815638; Thu, 23
 Nov 2023 10:06:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699297309.git.andreyknvl@google.com> <ZV42s_c3BzCAEwgu@elver.google.com>
In-Reply-To: <ZV42s_c3BzCAEwgu@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 19:06:44 +0100
Message-ID: <CA+fCnZcx-a8EfzQiFtfquXzfCyzL6Fy38o65G_HUbk+Pw+hTpg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/20] kasan: save mempool stack traces
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 6:13=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Mon, Nov 06, 2023 at 09:10PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > This series updates KASAN to save alloc and free stack traces for
> > secondary-level allocators that cache and reuse allocations internally
> > instead of giving them back to the underlying allocator (e.g. mempool).
>
> Nice.

Thanks! :)

> Overall LGTM and the majority of it is cleanups, so I think once the
> stack depot patches are in the mm tree, just send v1 of this series.

Will do, thank you for looking at the patches!
