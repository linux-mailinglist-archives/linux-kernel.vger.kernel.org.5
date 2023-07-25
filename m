Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A86761363
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjGYLKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjGYLKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31B30FD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690283288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIk2rY8kbIKJb0IQXAUy6YHfdWW3cnFIe2mfNcTspbo=;
        b=XmGrg45GoBLwLHRn8ciWtS/vheV/iLrDIVZ6lcGDNlI6xOtnDAug/0qMZYtIAU+gf4rtgR
        ypUmF55KXOj84sju0LToqpBnRaED8QnRxx3JnJgYL5dmCg3qxykV0iv2qWcaHeCn7FBAF/
        DOTp9CFgWIH+daX480IRwmA7YkLxZiY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-h3T_mLCjPcCyaGxxkpZ_GQ-1; Tue, 25 Jul 2023 07:08:06 -0400
X-MC-Unique: h3T_mLCjPcCyaGxxkpZ_GQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-563b4d68e07so1148702a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690283285; x=1690888085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIk2rY8kbIKJb0IQXAUy6YHfdWW3cnFIe2mfNcTspbo=;
        b=gnYnzfQ1sHDbXTj4xOy0bUMgiSUYR9yALwTHdxlcjcBiZJh/wHjfmzI0YPswjUDsgV
         a3Wb4SqrMCTZREuSSSun0eCGaVh3Cyf+MsdQ89GGfMPmhwFU+FACbVNJ708LTEa4htf9
         CPxCJ+dT+Obs7U52YMzLpdbHegcMSU+4zc0WwLoL/+16juBC9IArzCeLqmWbnHKExI/V
         6o/csAgSCU8aIWGL11nK2HShyD9iWof7AHzXPt2yMdyMoq2EtMShw6PjAb7f1KPxWC99
         q8VgRENC+W0K/p7yqPtOfI+kpgH8gTFd5wAXAX1RtNKTgIRUmj9En15Rf/woY5OeaLSd
         XHmA==
X-Gm-Message-State: ABy/qLY315b5z2FcR7gvfIChuxS4wJCnZSWwJEj23If8upHVUwDRn4Nb
        36CVQ257OXz7iJFGORKRcEiOfbW4G70Z7PwhfozP91Q+MkpXHTzfE4fOUNvocRr4S10gdXkjhuz
        Kdwp2BCFwCMLg37Ngpqy6ZDqUaK8jDXoOndJL5K3j
X-Received: by 2002:a17:90b:30cb:b0:268:abf:6431 with SMTP id hi11-20020a17090b30cb00b002680abf6431mr2408052pjb.24.1690283284970;
        Tue, 25 Jul 2023 04:08:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUO5iRoKmcTndiV1yc+RB63ntBijY7f5j5g118bUiJEFickPVx8jsUlZUrzSyxeXZ1uOPR28AIDchVPKuta5A=
X-Received: by 2002:a17:90b:30cb:b0:268:abf:6431 with SMTP id
 hi11-20020a17090b30cb00b002680abf6431mr2408031pjb.24.1690283284663; Tue, 25
 Jul 2023 04:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230718115607.65652-1-omosnace@redhat.com> <x49lefd4aad.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49lefd4aad.fsf@segfault.boston.devel.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Jul 2023 13:07:53 +0200
Message-ID: <CAFqZXNt5UXWagXu5QR5k5wOAeQJVKWrET4prEzb+5aftFEtyZw@mail.gmail.com>
Subject: Re: [PATCH] io_uring: don't audit the capability check in io_uring_create()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 3:24=E2=80=AFPM Jeff Moyer <jmoyer@redhat.com> wrot=
e:
>
> Hi, Ondrej,
>
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > The check being unconditional may lead to unwanted denials reported by
> > LSMs when a process has the capability granted by DAC, but denied by an
> > LSM. In the case of SELinux such denials are a problem, since they can'=
t
> > be effectively filtered out via the policy and when not silenced, they
> > produce noise that may hide a true problem or an attack.
> >
> > Since not having the capability merely means that the created io_uring
> > context will be accounted against the current user's RLIMIT_MEMLOCK
> > limit, we can disable auditing of denials for this check by using
> > ns_capable_noaudit() instead of capable().
>
> Could you add a comment, or add some documentation to
> ns_capable_noaudit() about when it should be used?  It wasn't apparent
> to me, at least, before this explanation.

This has been requested before, so I finally forced myself to look
into it and only now I realized that there is a subtle difference
between the has_capability and capable helpers. As the docstrings say,
the former doesn't set the PF_SUPERPRIV on the task when the check
succeeds, while the latter does. The problem is that I don't know what
the exact implications are and thus I'm not able to document which
helper should be used in what situation... It is possible some of the
existing call sites use the wrong helper in the noaudit case (possibly
including ones that I added/suggested).

The comment at its declaration says "Used super-user privileges" and
it seems to be used only to propagate into the ASU flag in task
accounting information. But in the case of capability checks that do
not fail the syscall it is not easy to tell if "super-user privileges"
were "used" or not (or, rather, whether the task should be accounted
as such or not after a successful check).

If anyone is reading this and has a better understanding of the
PF_SUPERPRIV flag semantics, I'd be thankful for a clarification so
that we can sort out this mess :)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

