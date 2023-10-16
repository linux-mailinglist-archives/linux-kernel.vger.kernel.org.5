Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7C7CAE41
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjJPPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjJPPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:53:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9340F5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:53:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7e5dc8573so57806037b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697471592; x=1698076392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYpi+Y74+blfqQ7+iyjrYGXZgsEgnThgUXh2i1YfeDY=;
        b=WtoG/k5nNQxQLxND1DwlOC8E2KNVBIdA5k6GffMiAOquxJ701M3N/82inuFiBXwzsV
         GtaXZtzOkRFoyh/BebrY+nJOCPNEZ/9J9gIDRVFTUyXGb8xcURz+KZWJnTNdYDAhEfpK
         z6izCBo2NqEUStCHgXJGZOH0G1CqP0RrEJgLgALnyatBUVNNjFXjpgKUzpiaEsLhAHzg
         hwXSQnjxYrnsyt7+CYGGGjzFubc9Ow6jnc3ZcgEeYJ2uhaIKPsAhOnYuYW5CqycEPJ2P
         Z/yqPpBk9sBJsI/x3ehG+KonwLKMEmSUY7sF7O+22OgZaO0D3E5uTe7oEqLD9c1BOqwH
         Whug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471592; x=1698076392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYpi+Y74+blfqQ7+iyjrYGXZgsEgnThgUXh2i1YfeDY=;
        b=qh+Nn/A2AJQHOUULfMkTUFCXzp/NjU8nUqCXDDja6WEl+NC5KQFEZ80WySlALhIn1S
         5T/btNOQd8nUaHvdymtMXZSvGxUgjWF+Y9Jtaga2CKt87s9oncN9/OSYLpob5lQfS2ie
         5g1be0LMuT2VTleJVplGjbOnsD7VN+E4jsAhAaZybD+KcXrrpUUO2Hi+Zfg583mha6fg
         dhPwaIGC603zHm0RPr5WYa909MA2CZllhjV/JexT5HRSn1xpvDLs6jLVNHTjy0C9KE9w
         wwgxR4qSXknW8/AouLJnAp36efeSzR6c4a3zAjA87FqO859cUXUnykwdlPX7ZdgAqbrW
         XI1w==
X-Gm-Message-State: AOJu0Ywy2/3Ta7iRgRhWicGRrzGWFT4OCBZi7C3mvEgFs00pUo95tj1o
        dBmpL27DQkKNNPmCfZeSQNnLFFXGh4ue9EtgCOOorg==
X-Google-Smtp-Source: AGHT+IF3He1oSv8hYDtN0FKigJZ4uhzs+6+PQONNXTwI+veyurOdO0psDFUB99utg8ZO4cTTyOYKSN9Sckl5fP2Sssw=
X-Received: by 2002:a0d:d713:0:b0:5a8:72ee:463d with SMTP id
 z19-20020a0dd713000000b005a872ee463dmr3725033ywd.49.1697471591735; Mon, 16
 Oct 2023 08:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231016153446.132763-1-pedro.falcato@gmail.com>
In-Reply-To: <20231016153446.132763-1-pedro.falcato@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 16 Oct 2023 17:52:29 +0200
Message-ID: <CAG_fn=XA5B4CO2q-+fSeKbT3DwYs+fExMP+h_x5qqdEKfejcow@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kmsan: Panic on failure to allocate early boot metadata
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 5:34=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> Given large enough allocations and a machine with low enough memory (i.e
> a default QEMU VM), it's entirely possible that
> kmsan_init_alloc_meta_for_range's shadow+origin allocation fails.
>
> Instead of eating a NULL deref kernel oops, check explicitly for
> memblock_alloc() failure and panic with a nice error message.

For posterity, it is generally quite important for the allocated
shadow and origin to be contiguous, otherwise an unaligned memory
write may result in memory corruption (the corresponding unaligned
shadow write will be assuming that shadow pages are adjacent).
So instead of panicking we could have split the range into smaller
ones until the allocation succeeds, but that would've led to
hard-to-debug problems in the future.

>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
