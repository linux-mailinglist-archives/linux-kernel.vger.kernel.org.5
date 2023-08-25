Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB2787EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjHYEFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjHYEEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:04:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647B91FCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:04:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so57075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936286; x=1693541086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8zO0asgndu05lgdJRYWrStoMGvKZjaJhbWRwDTI0fg=;
        b=NA2PMdJF1PgvNmjQyIBstuwWumZcbju3xr6NUz5czQNMYYcaJRr/uVmcs96F0llmhf
         5Phrsi9Qrs9udPZu8zv8nacE2EZVlkYC+GvdxkCmCOgwiIRlosgEHcwHzrkZRvlsRKUq
         oYvAy3IqXwPhDNQ24pioNoLxuV3Q4vIfJzKpxDgqZosGOBXu8j0qksO4TJ6uhlv0lDGc
         jp9Qsh5QusOl2EftXRG3xCHA+3mR06AMQT3DM6p/U1aP9zUhQFOdfXg1g2y3sQyo5C2J
         bmEBprYbYO5qr5jrKlFi64jwYVseB1EZ+rBCo791829UChplU3cy4bF1qwH8fnRHKc/y
         Bd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936286; x=1693541086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8zO0asgndu05lgdJRYWrStoMGvKZjaJhbWRwDTI0fg=;
        b=k+h7e/4hTcQHKBbwL6MZ/4O7KIVIbZP3CjbpKkexMPuHiEfCuDB/nYjr5Gw7I/4lLm
         wL+aJJGqwUBiSox4rbUlndapujQcR5J+3lz5G+U9mdgjA7J+bsvucYKA8mqMiMFp1Jwj
         grxSFC0szGhyz/JCM89PoG2GnkzDzi4XHt+B35I23l5EkEN7Bw7CUs+EtInK1WjRm8/h
         IZm5GTINVlPWcoYW6Rhn/WDnuvnjiTLVy5qToLXAZADmRDydgksHJjeTJVzYNxw3Omq9
         GmotASZiM6GFbG8c3ymE2sILxWAt8CgYO50uIaIljEtqmvOCuViRQYkZr0W8zlW6bW0Q
         3pBg==
X-Gm-Message-State: AOJu0YymrITeyjD0L/cIy37NIzbTeezgObGa0K6pI4T8LOzopeXdOv/L
        +6h77T6xG4Vn7s/1799SEuZAO2cWp7xiTnx3v/VR
X-Google-Smtp-Source: AGHT+IE6hasfDR+TbOi7IY/j5h4bO7nA+HqEnMgwwFzAZoadmsfgRFX/494nM8PDCYmLBYWLI7owjJlHhuxBjAT8ZQ4=
X-Received: by 2002:a05:600c:1c92:b0:3fe:f32f:c57f with SMTP id
 k18-20020a05600c1c9200b003fef32fc57fmr119903wms.0.1692936285815; Thu, 24 Aug
 2023 21:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230818012014.212155-1-peter.hilber@opensynergy.com> <20230818012014.212155-4-peter.hilber@opensynergy.com>
In-Reply-To: <20230818012014.212155-4-peter.hilber@opensynergy.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 24 Aug 2023 21:04:34 -0700
Message-ID: <CANDhNCq38sESJqYS8+onu9G4FS--JR6pF0fA6wJXwSDon6QkRw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] timekeeping: Fix cross-timestamp interpolation
 for non-x86
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 6:20=E2=80=AFPM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
>
> So far, get_device_system_crosststamp() unconditionally passes
> system_counterval.cycles to timekeeping_cycles_to_ns(). But when
> interpolating system time (do_interp =3D=3D true), system_counterval.cycl=
es is
> before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
> expectations.
>
> On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
> interpolating, setting delta to 0. With delta =3D=3D 0, xtstamp->sys_mono=
raw
> and xtstamp->sys_realtime are then set to the last update time, as
> implicitly expected by adjust_historical_crosststamp(). On other
> architectures, the resulting nonsense xtstamp->sys_monoraw and
> xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
> adjust_historical_crosststamp().
>
> Fix this by deriving xtstamp->sys_monoraw and xtstamp->sys_realtime from
> the last update time when interpolating, by using the local variable
> "cycles". The local variable already has the right value when
> interpolating, unlike system_counterval.cycles.
>
> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supp=
orting slower devices")
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>

Thanks again for iterating on this.  This looks much better!

Now, I've never had an environment that used this logic, so I'm
trusting you've tested it well?

Assuming so:
Acked-by: John Stultz <jstultz@google.com>

thanks
-john
