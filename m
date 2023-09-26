Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45577AE840
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjIZIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:46:11 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF289D;
        Tue, 26 Sep 2023 01:46:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b8cebf57dso3424990eaf.0;
        Tue, 26 Sep 2023 01:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695717962; x=1696322762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J+OLpxrnRzkDOkIZ6CCVdIXdCfplR7EMqlJwZEj/uY=;
        b=XN3xv64xKDqzBlyU2FxpTl3T0k/KbV8ZMiXl81p25fRcN7lwBbHg6LkvMhjL1GyzWF
         TYE+k+bcVBvmQsbs7re6/9NrOdJNtdpn69lxDViVoMwvY9MimMQ6BROXNiTZjKiF95oQ
         UAESuG9WlQ/pzrLX9T6P/qPyE1wf49QCDecuVzlFAf2APk1aJR0HzefnugiiuAIScTuH
         HvsD8wnrEOi6b1aBAnYs2uoWPQHWtvmUmIsmT4xYKSFMXlc2j/mkkvuWEN4EyU/ZWg0I
         OPwbygUf5NKq2MUI30CXejAS3Uqgc3VfI6aPa22nPH2AydWVQhykCG1WPTbY5swzJZYL
         R0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695717962; x=1696322762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J+OLpxrnRzkDOkIZ6CCVdIXdCfplR7EMqlJwZEj/uY=;
        b=Mc/bu4LnX0/E0d6bY8tMOEOLZZavTABRwqItjU+H/8cd1vAyxrx+ZNRd9n86y3yWx8
         4LinfmrhIJIWGHydwbJLCjvSZhgFjqz88k2FXE+uvb82gRw8J3BumuGxo98ywu0JAIXu
         K4nPplm2eVMCejEn41CW1TR46lWrKnFYAXVXnBo70mKTmvme7SC7owc9eZX5Q7QeoLr8
         s81AjLcy6NUN4opB36cemIf6TKMAkh7xH3Cw3jx3bsprUyFmPNVq1mDw5vPeTvGa38tK
         iKDWBPCO9vkD2i1miaXO84cj3BhAULvAwbmGoY7wAjDVjEmAxolGnPTEqJ90CYOM5A+P
         g6bA==
X-Gm-Message-State: AOJu0Yx/mdwkH0KfhzoItB4XQRvNruz+BKsIq8DN5HU9Fmfqv9po7KDy
        0xClYdH2DVdS9zmvY3f9jXIm8Iq6Qxyx4Lgdj05ALbvms7g=
X-Google-Smtp-Source: AGHT+IEG1jHRunzp2Nv/iIKp3ZRagstgiujcvfGy/lVI0PpKulDWw5pE+vjRuHzQERvucXBXoR+RXNycKAGXW/Encbs=
X-Received: by 2002:a4a:3c4e:0:b0:56c:cd0c:1d67 with SMTP id
 p14-20020a4a3c4e000000b0056ccd0c1d67mr7623526oof.7.1695717961931; Tue, 26 Sep
 2023 01:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062558.1739642-1-max.kellermann@ionos.com>
 <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com> <CAKPOu+-yUOuVh+3818iJ-GH968EHHQ0Pc3d8Rj4veO3k-xLk+g@mail.gmail.com>
In-Reply-To: <CAKPOu+-yUOuVh+3818iJ-GH968EHHQ0Pc3d8Rj4veO3k-xLk+g@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 26 Sep 2023 10:45:49 +0200
Message-ID: <CAOi1vP9QdfB0uxd64XcpREWFTqrJm0QNORYzrGvQBLOu4CrDWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 8:16=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Mon, Sep 25, 2023 at 12:42=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com=
> wrote:
> > A word of caution about building metrics collectors based on debugfs
> > output: there are no stability guarantees.  While the format won't be
> > changed just for the sake of change of course, expect zero effort to
> > preserve backwards compatibility.
>
> Agree, but there's nothing else. We have been using my patch for quite
> some time, and it has been very useful.
>
> Maybe we can discuss promoting these statistics to sysfs/proc? (the
> raw numbers, not the existing aggregates which are useless for any
> practical purpose)
>
> > The latency metrics in particular are sent to the MDS in binary form
> > and are intended to be consumed through commands like "ceph fs top".
> > debugfs stuff is there just for an occasional sneak peek (apart from
> > actual debugging).
>
> I don't know the whole Ceph ecosystem so well, but "ceph" is a command
> that is supposed to run on a Ceph server, and not on a machine that
> mounts a cephfs, right? If that's right, then this command is useless
> for me.

No, "ceph" command (as well as "rbd", "rados", etc) can be run from
anywhere -- it's just a matter of installing a package which is likely
already installed unless you are mounting CephFS manually without using
/sbin/mount.ceph mount helper.

Thanks,

                Ilya
