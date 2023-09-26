Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8A7AEEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjIZOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjIZOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:06:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7A311F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:06:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9adca291f99so1087104466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695737178; x=1696341978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRwJs6LGdBPmfL+586hFfECrrSIQE+7lECzp/i1r0Oo=;
        b=RlRbx2NHhjAn/pAuWXI2fytFzd4stg+4X3dZdI+3MrnGaxJlPL5xPXiGP5/kJlsavo
         W2DEsZ4G/sOjTXKZpFjIqQ82v5TXzzovwoWrIeeexbVRzpxtSX9TKejisI0oF98gQIgV
         cK/VFBNImURPzGTaMf3rheRCHLetCkbWoZ1nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695737178; x=1696341978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRwJs6LGdBPmfL+586hFfECrrSIQE+7lECzp/i1r0Oo=;
        b=sjxCGdpjq6+wBuh76K72NsozgpNS4pRsqe0fVbkUuXvL7WWwVfz8Y+UO/iT3eu1Ug8
         OFhppsIPvEglb1BQdnSNVGAOwN4XKWov5EikBhhNRsTlLNRKAnSnsJ+aWvYPOmKqggF/
         XYlZuPLSZGH9T7NBv8PNYzCyrz9TL4ZzsPrY/1y2ZAgMRjiPdh2cr6rtN/VNT7C6OQgo
         Lq/S+JpbeLQ1rFhdjlCaq1WUtKrjUdcJziYkVVFbwguk7gTGGwYiN7dCD8ri/IlwZJqk
         xs1r7lpSe6HhVsIl+wEueRmf6I7hqAcNBzhkAKAsOz0I29hUZz9l5U7ejNfCf2yEsue7
         lJjQ==
X-Gm-Message-State: AOJu0Yx8NhPnW8LroOY1mThFhpHuOcU8Almaqnm7dLBEs+IVFx4537DG
        HGIZwJmMNF8RoeYlG6gbkXDCn71UsiuzHipWHcBVew==
X-Google-Smtp-Source: AGHT+IFHTAM+tJZjIN9/SFusTb0hi5JKPSzFCgkZBc1/u3GnwtJTR2qZZT7WwfV5yYXqBLz5JWXIo3tjVT1zYGqrLgE=
X-Received: by 2002:a17:906:3299:b0:9ae:6196:a4d0 with SMTP id
 25-20020a170906329900b009ae6196a4d0mr8739793ejw.17.1695737177221; Tue, 26 Sep
 2023 07:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <871qeloxj0.fsf@oldenburg.str.redhat.com>
In-Reply-To: <871qeloxj0.fsf@oldenburg.str.redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 26 Sep 2023 16:06:05 +0200
Message-ID: <CAJfpegupTzdG4=UwguL02c08ZaoX+UK7+=9XQ9D1G4wLMxuqFA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sept 2023 at 15:49, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Miklos Szeredi:
>
> > On Mon, Sep 18, 2023 at 3:51=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> >
> >> I really would prefer a properly typed struct and that's what everyone
> >> was happy with in the session as well. So I would not like to change t=
he
> >> main parameters.
> >
> > I completely  agree.  Just would like to understand this point:
> >
> >   struct statmnt *statmnt(u64 mntid, u64 mask, unsigned int flags);
> >
> > What's not properly typed about this interface?
> >
> > I guess the answer is that it's not a syscall interface, which will
> > have an added [void *buf, size_t bufsize], while the buffer sizing is
> > done by a simple libc wrapper.
> >
> > Do you think that's a problem?  If so, why?
>
> Try-and-resize interfaces can be quite bad for data obtained from the
> network.

In this particular case it's all local information.

>  If the first call provides the minimum buffer size (like
> getgroups, but unlike readlink or the glibc *_r interfaces for NSS),
> this could at least allow us to avoid allocating too much.  In
> userspace, we cannot reduce the size of the heap allocation without
> knowing where the pointers are and what they mean.

Does it matter if the heap allocation is say 32k instead of 589bytes?
 The returned strings are not limited in size, but are quite unlikely
to be over PATH_MAX.

E.g. getdents apparently uses 32k buffers, which is really a tiny
amount of heap these days, but more than enough for the purpose.  Not
sure if this is hard coded into libc or if it's the result of some
heuristic based on available memory, but I don't see why similar
treatment couldn't be applied to the statmount(2) syscall.

> I also don't quite understand the dislike of variable-sized records.
> Don't getdents, inotify, Netlink all use them?  And I think at least for
> Netlink, more stuff is added all the time?

What do you mean by variable sized records?

Thanks,
Miklos
