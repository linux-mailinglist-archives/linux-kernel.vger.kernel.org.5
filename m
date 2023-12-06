Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC380687D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjLFHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFHed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:34:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625AF122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:34:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso5197a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701848078; x=1702452878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrLGOurk8L5L0NnPLUV2I7uNbYLxUdBqrFGq7mAToT4=;
        b=RVgXsKxLYCuPUrDTXabS/YaKPggmrfdjbfeFicZ+ty34bG93X6Qbr7MrmwwVDkiro8
         gi8vX159tHoXz5e4VcjKjGrE90vdyimjZ6pNtipmXzYTgJMXVGba5b9kuUowW4JFincb
         Y/fR5IXQ6bzPh8WvgpIT9QWwifm1YEvNxMVPnX4U0pGUCGfFUWRcQGRTJ5oiHzOGSBB2
         SO1dQCxh4N9EMPW74vmxhmTSOHMbTVh6Mw8qLShws+tvknuJHnq4HiX3Zl9JVRtUCKDy
         OHFjmf5I6j4DwubaYzIrrpFAXHlIiAZ3LyDzv4chD+yAZnKVJbXKBD9xsv4caHCiyNGO
         /OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848078; x=1702452878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrLGOurk8L5L0NnPLUV2I7uNbYLxUdBqrFGq7mAToT4=;
        b=OTumKFBCWSw3B843NwMcAjYzjFlCzEyJhz3AMkKW3+dw6I3D1Hl4q4nRwTJpJYt0BG
         g4ZLGEK4LUc6k/U92KdoY5m+i2YgSfexc00AT1g5YhrEyRkUaYmbhDG5N5qpuzHBF76s
         7L25iVTMXXIQHKTFrcy9JgztMVc13a/+I8iaM8X/bxWJR9U1CEPS27rLeXwt1vG2EmXc
         xfPEr2AnKxuptJBY2qh7XQd2nvIv2dstaH3uo61QC4/afdgaKCHK/M+jVjh2Tl5O5sOP
         bIT9Dgtrm2aPys+rdurfBZKWamjtGEUcmf1agF2a+iYD+xQ2IVrEFN2o8QZ6dUMW4Vmx
         vmdQ==
X-Gm-Message-State: AOJu0YyqHnh9E3jWFZf60p5n+jj31eE4OpgRUBXnnwZ+i1+CHNBBLVr/
        OrkRKb64QvzrfjtXbL231eNQdDdutV2GJjo586dREg==
X-Google-Smtp-Source: AGHT+IGldiRIFyGKYysUNKi5CQSdX373OFF+v40mkRnSHG6nIDPkTDJD/kDCf/0mazNx1HSyGQ9CMJ5qmSJ/VPpXWqA=
X-Received: by 2002:a50:d744:0:b0:54c:384b:e423 with SMTP id
 i4-20020a50d744000000b0054c384be423mr40767edj.5.1701848077557; Tue, 05 Dec
 2023 23:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Dec 2023 08:34:24 +0100
Message-ID: <CANn89iKiG0oLhkYQj=OkhvcWyR_kfSsot_2zo9hFCm1A7u-tWA@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org> =
wrote:
>
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=3D1000 which expects tasks to be able to schedule in
> with ~1ms latency.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
>
> ---
>
> Changes in v2:
> - Use ktime_get_ns() for timeout calculation instead of jiffies.

SGTM, thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>
