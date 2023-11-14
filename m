Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98577EB221
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKNOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AACA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699972519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3F2j0JiuR8XZ8evNWA/bI+vEdCE1IIEmzFEJwB5MjA=;
        b=gdlbdftuw7nWwSS4TsNdZdfzVO/13sotYKaqg/ihHIicZjv2QIpCSYXyz2RHxwlVpEJUFQ
        +x97vmx9jr8e/mGx/EAKXWofjkNHTszdp6vwPNqkmiecc89e9+Ydk0rgkwnMV2pOD8UG3/
        i79yGkPRHPJa/+WZRROwfGKUpJSTOWw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-pKu0QtoVNpOAaOsMzsB9Sg-1; Tue, 14 Nov 2023 09:35:18 -0500
X-MC-Unique: pKu0QtoVNpOAaOsMzsB9Sg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5411a36a37fso6601962a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699972517; x=1700577317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3F2j0JiuR8XZ8evNWA/bI+vEdCE1IIEmzFEJwB5MjA=;
        b=U97jlgGg7xlNX9ViaSF11Gg5TqkMvkfPHi896AKCTXZRZ+K/lUbyGa8F3Fi/TH5dSo
         qYGgs0twmJNK/VMDhPYkpXACfnkJ1d13zaPbAF58ie8+beN+x8F691FqpkrB2BFm6etp
         HBbB7xWsf1nd83Mo95sVFSgrKWmwuQIj03PBw598E1mKJGXiZ0YbXFWu6dQdULO/As6V
         UAh8Wr4DFcSUP5hiH96tFRQjHPhPnphF4BebRMDzuYyLLbns208suzbYNPLOTnAMfNKK
         rJekXt2Kv97mBczk50BsmZhPW6Qr1/96m9SibTn2jMYStnl5n0ggy12oOZeTKLB+Hao9
         VYxg==
X-Gm-Message-State: AOJu0YyPzWfLYF/a1v4Nafgym4kefXJyWEi7Yt20Po1TJQAaDTzJpN9N
        Xu45DL4FY//LGWztjD2gt0/DRMEFxUUGKUtTGktfalbliRMvFxTt1pUYkIP0xtZxdDzAfFCcTSs
        GSJ/cvI1ChE1oarYTwQQsUGTELoi11pJQxZRFGuwN
X-Received: by 2002:a05:6402:27cb:b0:53e:1207:5b69 with SMTP id c11-20020a05640227cb00b0053e12075b69mr2664433ede.10.1699972517209;
        Tue, 14 Nov 2023 06:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdSryw7raoU9ySotrmC5FMNKbu0UjsMk7IFkmWmdlR/d/2dPMxtfYsvx9umGin7g5Olj8xHSFqU1l5I2UkuBs=
X-Received: by 2002:a05:6402:27cb:b0:53e:1207:5b69 with SMTP id
 c11-20020a05640227cb00b0053e12075b69mr2664419ede.10.1699972516924; Tue, 14
 Nov 2023 06:35:16 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com>
 <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com>
 <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
 <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
 <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com>
 <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
 <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com> <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com>
In-Reply-To: <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Nov 2023 15:35:04 +0100
Message-ID: <CAO-hwJ+jwmTE-v7FsPi3f70mB8SqUha7Ek9DtptZ0auiFpGM7w@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Nov 13, 2023 at 11:08=E2=80=AFPM David Revoy <davidrevoy@protonmail=
.com> wrote:
>
> Hi Benjamin,
>
> > Here is a little bit of history of why you were encountering this bug [=
...]
>
> Many thanks for all the details you wrote about the bug, I found
> your email so interesting that I couldn't resist to copy/paste it
> on my blog[1].

Heh, glad you found it interesting. Too bad it was tough to understand :)

>
> > And that's exactly what happened in your case David. Which is why I'm
> > so happy (also because I fixed the tools from an author I like and
> > already had the books at home :-P):
>
> Please send me an email in private with your adress; I'll be happy to
> send you an original drawing. That will be my way to thank you :-)

Oh, that would be wonderful. Many thanks.
I'll send a separate email.

>
> > Could you please once again attach the hid-recorder of the Pro 24
> > while doing the following sequence:
> > - touch with the tip of the stylus the tablet
> > - while touching, press the upper button (the problematic one)
> > - still while touching, release the button
> > - remove the stylus
>
> Sure, you'll find the action (repeated three times) recorded here [2]

Thanks a lot. However, I realized this morning 2 issues (sorry):
- you made the recording while the HID-BPF program was attached, which
is now obvious that anyone would do that. But the program sometimes
discards events, so I am not sure now if sometimes the device is not
sending the spurious events, or if the filter was acting correctly.
(Note to self, next time, while in the testing phase, do not blindly
discard the events, but remap them to an ignored report)
- that device is really "interesting" in how it behaves with the
eraser mode emulation: when you press the second button while touching
the pen, we get a spurious release of the touch event... And this
leads me to think that I'm not sure about all of the transitions we
can have with buttons :(

TL;DR: there is still work to do for me and for you if you still agree
to send me more traces.

>
> > you could also give a test of the artifacts of job 51469284[3].
> >
> > The points to check are:
> > - if you right click while touching the surface, do you still get only
> > a right click or some weird glitches in addition to it?
> > - if you right click while not touching (hovering), no glitches?
>
> I tested. It's a bit hard to tell if it causes glitches or if the
> behavior is normal or not. I'm not using the right-click this way.
> I always use it in "hover mode". With artifact or without, the
> behavior is while the tip is pressed, the right-click quickly
> 'disapear' but it is probably normal because I test on contextual
> menu and clicking somewhere else makes this type of menu disapear.

AFAICT you used the artifacts from job 51469284. Which is good. But as
I mentioned above, the tablet is sending a spurious event I haven't
anticipated, which results in a left click (well release/click) from
the host point of view. And that very well explains the disappearance
of the right-click menu.

>
> I hope this will help,

It does, but there are glitches that I'd like to fix. I need to iron
out the bpf filter for those use cases. I rewrote the tests today to
take those into account (assuming I understand the HW enough) and I
think they are better now.

But I would also totally understand that you had enough debugging and
you would rather focus on using the tablets, instead of debugging
them. In which case, someone else from the community might help me.

Cheers,
Benjamin


> Cheers,
>
> David
>
> [1] https://www.davidrevoy.com/article1002/how-a-kernel-developer-made-my=
-styluses-work-again
> [2] https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Ar=
tist-24-Pro/XPPEN-Artist-24-Pro_pen_tip-contact-and-action-press-release-up=
per-stylus-button-x3.txt
>

