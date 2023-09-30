Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B97B42CD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjI3RrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjI3RrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:47:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA541E6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:47:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d84c24a810dso17013929276.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696096031; x=1696700831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bRw5quNEV0M9cb0HcdjknkRgJ/siG4MMp5H13L+Cls=;
        b=mQnoxRoolRZo3SzsJ2Sf6QDHx442H0O0UDytGSx7nAfy5aWa8ZSf8meFdmppMbUqfS
         wsYtOovh5uGvsv65gxP1yXFOdBVhyUGfzSzJV1ioIt8hsEbpSJf1ryZtzm22VMcxTtes
         S6EyDvZtFY95RZHereHjwxRuIESizrd+F6s4hAmKAG3aPKaDsIKf2gUUXGrnVRKPdGg9
         m+KVXBQhT+rQvUecW/xlvVuNhR7sJEsdxla/ARCSO3STbtJ9xH7aJGzg8/9FznEc11RX
         00Go+DbaTSWrRGxvz+WX40U3jntVfwzy7k7fElqMyNclNtBoFSobKS72PTz+Y3iqKhhu
         WypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696096031; x=1696700831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bRw5quNEV0M9cb0HcdjknkRgJ/siG4MMp5H13L+Cls=;
        b=CrR5RrdlYWz8A/+O5hLIVsXpg+lba0iqcvh4ZJgU+rJzo9uBk07YuPsBCQqBQwlrPB
         jvAJ4N7lDPpxHL/+HGrcJKhLb1Dq1bcvF8Rh41j4qsJ7kzx5mUVVbc/p1ECH/1RyGYoq
         vOHyGUsCdu4DZegVgqsr46F9khM7WcrkXdYAEeVRJ3lYby283eeTamiXHw/YPsO/hCLk
         ogOUOGv62OS5jIS5s6UG0EpvmwWpyUSgzgr8qt3ul8oHaFmhbyXCya763UBv28gp7Lb4
         IYzp2y8t2b67aqQYfxkMZ/QzR+LxIUADCKHHqhejayE84WG7XwAoksKyHIx1R+URyppc
         ejUg==
X-Gm-Message-State: AOJu0YyljQCSPc6gzo2QcF8YQd3QhRr7r9baj3/YFji9bqyze3FePlQa
        McagxyclIgNgsbUwrtanjdLferLByVvt0qTMY7yY5A==
X-Google-Smtp-Source: AGHT+IENFMeQdLk+rR/U55AmckbI5FKhXjp8G3li3k+tIvbb7G4Nd/lRvb13bcWvSJRQjCirrEzryGpeVGHfAN/lqDY=
X-Received: by 2002:a0d:d086:0:b0:598:bad6:8e67 with SMTP id
 s128-20020a0dd086000000b00598bad68e67mr6880097ywd.30.1696096030870; Sat, 30
 Sep 2023 10:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230930161443.58812-1-xubo3006@163.com>
In-Reply-To: <20230930161443.58812-1-xubo3006@163.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Sat, 30 Sep 2023 13:47:00 -0400
Message-ID: <CALNs47s7HKb7n14waq0Gyty4Py3csKrJ1YFidJht=CMiXo9gCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: add Soft-RoCE driver basic structure
To:     AllenX <xubo3006@163.com>
Cc:     rust-for-linux@vger.kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 12:32=E2=80=AFPM AllenX <xubo3006@163.com> wrote:
>
> add soft-Roce rxe device net driver basic structure and Rust security abs=
tration interface

It looks like your patch hit the list twice, see [1] and [2]. Also,
the body should be hard wrapped [3].

Since it's usually the first thing to be asked, do you have a
real-world driver that this is intended for? Typically new
abstractions don't get merged upstream unless there is an in-tree use
case.

We can still give the patch a cursory review from the Rust side even
if it isn't meant for upstreaming as-is. For future reference, you can
have "RFC PATCH" in the subject to make this clear (`git format-patch
--rfc` does this)

[1]: https://lore.kernel.org/rust-for-linux/20230930163256.60779-1-xubo3006=
@163.com/
[2]: https://lore.kernel.org/rust-for-linux/20230930161443.58812-1-xubo3006=
@163.com/
[3]: https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#=
the-canonical-patch-format
