Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B587EBE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjKOITS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 03:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:19:16 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E57F4;
        Wed, 15 Nov 2023 00:19:13 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a90d6ab962so75282217b3.2;
        Wed, 15 Nov 2023 00:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700036352; x=1700641152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjDVEmD9JR1OfPMPjqIKcU2pjvgfmsvaN1BPdVXkx5Q=;
        b=JbZcFGqX/NrgFkEXCG6P3OsXpVu9+SqKYdWL0tS4Mgunc+qXpUVF6bhXd4QKqUXAXY
         oin2w380UWOhyWu1C+XN1jb4zJgFG6U7+/3k/ux2s3DBxsB3WvyqHbP6m3TGApxKmPSX
         Pnegwxcm/miVwU2zpLrFNXN/iJT4z9y2BnhuCnmV4qjuRZXJq1bm3jotqdgHePy6K8u+
         6zQNK1Zj6Ud7G2O5a7psCAZMGYLrqdUnl8Q7WiDnEXxUg184utIXLfwCbNlSJhwqIuLU
         fRdspW8JoXCsxdhJAic0eTDoaWNiiuihCgLA9rG6J0P/mDfXFrRs/fRFqFYu0DecnGV9
         ytLg==
X-Gm-Message-State: AOJu0YzjJwE6Pz4uukA5W9B1vz7YBUS3IwAiFDMXyVHMwN0XKGOIAd5k
        ogwO+SFOXzBImTznooiFdrpEWQ1nkgFXXw==
X-Google-Smtp-Source: AGHT+IHQb0zWSxXelXZXjHcvvFUFtwMg+y+Ei4Fnz5okSGrKQFNMrT82qcuI0uf76ghCUByl6orv+A==
X-Received: by 2002:a81:840b:0:b0:5be:ae23:c002 with SMTP id u11-20020a81840b000000b005beae23c002mr12082805ywf.26.1700036352405;
        Wed, 15 Nov 2023 00:19:12 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id ck18-20020a05690c0b9200b005a7be2919a1sm247216ywb.14.2023.11.15.00.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 00:19:12 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a90d6ab962so75281977b3.2;
        Wed, 15 Nov 2023 00:19:12 -0800 (PST)
X-Received: by 2002:a81:9141:0:b0:5b3:60c2:5781 with SMTP id
 i62-20020a819141000000b005b360c25781mr13396631ywg.32.1700036351987; Wed, 15
 Nov 2023 00:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20231115082138.2649870-1-liushixin2@huawei.com> <20231115082138.2649870-2-liushixin2@huawei.com>
In-Reply-To: <20231115082138.2649870-2-liushixin2@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Nov 2023 09:19:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZ_gEOkyYxhwROA209qimvy6CzwQtk6LGx9=7=ABUoMg@mail.gmail.com>
Message-ID: <CAMuHMdVZ_gEOkyYxhwROA209qimvy6CzwQtk6LGx9=7=ABUoMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm/kmemleak: move the initialisation of
 object to __link_object"
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 8:23 AM Liu Shixin <liushixin2@huawei.com> wrote:
> Move the initialisation of object back to__alloc_object() because
> set_track_prepare() attempt to acquire zone->lock(spinlocks) while
> __link_object is holding kmemleak_lock(raw_spinlocks). This is not
> right for RT mode.
>
> This reverts commit 245245c2fffd0050772a3f30ba50e2be92537a32.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
