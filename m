Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00180E272
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbjLLDAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjLLDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:00:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09589BC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702350027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/GWabnUccw3NaInncXMDYCSfx9WQ13D52xz9bmZnXo=;
        b=e9TqMgWq1zdVPcjCfOZwvFxzwvDHf2fOMbTNbWuTNXSGaSh0ksqpI9L2s2IpvXHYgUt1E5
        7XjxA9mdC0gC8NMtzESSH0LkYN1PIAzZuET8qAgMQJlKjgYnlgH5PgUG8ELMci20P7Vimt
        pECdYPyoxUWkwkAbrPzXk0YUBx84t8M=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-GG9aXc7qPGm78P6MSkt1Gg-1; Mon, 11 Dec 2023 22:00:25 -0500
X-MC-Unique: GG9aXc7qPGm78P6MSkt1Gg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-590b580ae39so3674462eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350025; x=1702954825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/GWabnUccw3NaInncXMDYCSfx9WQ13D52xz9bmZnXo=;
        b=VemnFBwWm70arlDsXIJ6iNl1vvveMSaGsYnMoAASngkJdJa1sobaMje0oy/DAsoECM
         rTPTyUutqhha3+uigGbZZPWTa1mONeP82r6gROHygetaEGsrnWefx0l+g9lvMCYNLvgS
         DnOkLWeUYxH+kXTGSTpzS8thr4B9XzW1p6E7QHM7Hvz9dBFaHdpda3ReUc0MuQdSQUwb
         lT1yb8enqdwGfJCcp6XOTxX71WwgkcTZnjrsPSpov07JBfsD8ByCX74uK16j+oh0ldqP
         o+PmNe7a4maZLfVZobmBnTeNStxh/fDSHYEN4YMyY9hjU+pDD17IqiAIqfYTyYFTTedd
         gUUw==
X-Gm-Message-State: AOJu0Yy80O1SqMwbuPXRDncpyi3dq99SGOfLQgqlqHgdLnxrwWtxbblj
        Etgde6SN47XRGxiNlBiiXvLMNfCcIhd/D0aFoo7hqv3bb7eV00sRtH5AB///EyBE7s2ND3H1303
        EOZnUU8rhOgmcXOAaa7BHUsDYI6SkFRc9+Fr/T8VxIAr4GRFVOTyqYQ==
X-Received: by 2002:a05:6358:260e:b0:16e:4c3:f8c3 with SMTP id l14-20020a056358260e00b0016e04c3f8c3mr6935870rwc.11.1702350024817;
        Mon, 11 Dec 2023 19:00:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp3OwNK9PoGoQnXeeX4+viPi6Hk3B5tFT4RIMaX8AFHJ44Lb0NnCW5h1v++Uvw9C1SRvVa6MdgSmune5oTLWk=
X-Received: by 2002:a05:6358:260e:b0:16e:4c3:f8c3 with SMTP id
 l14-20020a056358260e00b0016e04c3f8c3mr6935850rwc.11.1702350024367; Mon, 11
 Dec 2023 19:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com> <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org> <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org> <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org> <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231211115329-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Dec 2023 11:00:12 +0800
Message-ID: <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tobias Huschle <huschle@linux.ibm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > > Try reducing the VHOST_NET_WEIGHT limit and see if that improves thin=
gs any?
> >
> > Or a dirty hack like cond_resched() in translate_desc().
>
> what do you mean, exactly?

Ideally it should not matter, but Tobias said there's an unexpectedly
long time spent on translate_desc() which may indicate that the
might_sleep() or other doesn't work for some reason.

Thanks

>
> --
> MST
>

