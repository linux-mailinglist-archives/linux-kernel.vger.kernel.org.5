Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08557D8703
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjJZQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:49:52 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A71AE;
        Thu, 26 Oct 2023 09:49:49 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ce353df504so683088a34.3;
        Thu, 26 Oct 2023 09:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338988; x=1698943788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtqSxE+Cj1hsQmTK+4OZRpgIIfycTnch7HQYY5KhEog=;
        b=BPlmZPLZD80mfcVFsqSAGuomfWoCaKYkP0vRr+1BxYlMP9Td4aQNICCx+wEkVnLbP4
         fipYrstvQio8NsbGqxvx5gqFdZCW/4IIS5CFQ45Cz/SzNex9BWI5IEQLvsPOUsOfHkps
         2I+t3WDo8ub8zMj5/5xcj9Eb+LxPJwCEGHKaKvKZp+pcLAJ7jyojxcrmbw2RBngzcUo/
         a4dDhavgUhXjYt8o3q+DYTqDfWA+NjibadvbIm1xl4M9xVpnAFo3cS0bQ1qMXV9XW4YQ
         jLpTLAnU4qPDWeoJim7gpX01qOBjNUl5/EkcuBt7+L7JfUH6ox4WEStyNN7uwrWt8gJL
         b5bQ==
X-Gm-Message-State: AOJu0YxEJna8ujn6HBuXT8jrTrIanzG8c7qTUOqY1lnsVtxqRlcIuqU0
        rzii1Df7N7ZFJpuxk7RTQwqk2PYAP0ccEA==
X-Google-Smtp-Source: AGHT+IGrUz1xrXBah/KAgmvMjA872kopPK+jai+gKl9F2xZA2EieLJG/gN9NBwD/vuMFQtDHndS07Q==
X-Received: by 2002:a9d:7ac6:0:b0:6bd:63b:4b21 with SMTP id m6-20020a9d7ac6000000b006bd063b4b21mr20187806otn.15.1698338988693;
        Thu, 26 Oct 2023 09:49:48 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id fk1-20020a05690c334100b005ad586d2691sm2525631ywb.43.2023.10.26.09.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 09:49:48 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so790829276.2;
        Thu, 26 Oct 2023 09:49:48 -0700 (PDT)
X-Received: by 2002:a25:374a:0:b0:da0:3b6c:fc22 with SMTP id
 e71-20020a25374a000000b00da03b6cfc22mr8654234yba.31.1698338988025; Thu, 26
 Oct 2023 09:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231026164114.2488682-1-hannes@cmpxchg.org>
In-Reply-To: <20231026164114.2488682-1-hannes@cmpxchg.org>
From:   Luca Boccassi <bluca@debian.org>
Date:   Thu, 26 Oct 2023 17:49:36 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQ56cm4Txgy5EhGYvR+Jt4s-KVgoA9_65HKWVMOXp7a9A@mail.gmail.com>
Message-ID: <CAMw=ZnQ56cm4Txgy5EhGYvR+Jt4s-KVgoA9_65HKWVMOXp7a9A@mail.gmail.com>
Subject: Re: [PATCH] sched: psi: fix unprivileged polling against cgroups
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 17:41, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> 519fabc7aaba ("psi: remove 500ms min window size limitation for
> triggers") breaks unprivileged psi polling on cgroups.
>
> Historically, we had a privilege check for polling in the open() of a
> pressure file in /proc, but were erroneously missing it for the open()
> of cgroup pressure files.
>
> When unprivileged polling was introduced in d82caa273565 ("sched/psi:
> Allow unprivileged polling of N*2s period"), it needed to filter
> privileges depending on the exact polling parameters, and as such
> moved the CAP_SYS_RESOURCE check from the proc open() callback to
> psi_trigger_create(). Both the proc files as well as cgroup files go
> through this during write(). This implicitly added the missing check
> for privileges required for HT polling for cgroups.
>
> When 519fabc7aaba ("psi: remove 500ms min window size limitation for
> triggers") followed right after to remove further restrictions on the
> RT polling window, it incorrectly assumed the cgroup privilege check
> was still missing and added it to the cgroup open(), mirroring what we
> used to do for proc files in the past.
>
> As a result, unprivileged poll requests that would be supported now
> get rejected when opening the cgroup pressure file for writing.
>
> Remove the cgroup open() check. psi_trigger_create() handles it.
>
> Fixes: 519fabc7aaba ("psi: remove 500ms min window size limitation for triggers")
> Cc: stable@vger.kernel.org # 6.5+
> Reported-by: Luca Boccassi <bluca@debian.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Luca Boccassi <bluca@debian.org>

Thank you very much for the quick fix - this was reported originally
on the systemd bug tracker by Daniel Black (I do not have an email
address):

https://github.com/systemd/systemd/issues/29723

It is very important for systemd services to be able to do this
without capabilities, as using capabilities means in turn user
namespaces cannot be used (PrivateUsers=yes in systemd parlance).

Kind regards,
Luca Boccassi
