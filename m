Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB37CE55D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJRRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJRRyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:54:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05ABEA;
        Wed, 18 Oct 2023 10:54:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ED4C433C7;
        Wed, 18 Oct 2023 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697651653;
        bh=UMbYfhLFAk7mnzSPZbWqAxVN7HL/vxhltu6OsLTt8kY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Khz4QCLWvW5mEVSaoaEZVNnUzmZSX11yUaDkq4EO/rD+jmfhn/Z+uz6nmwvq0jZym
         QONMIg61LummTeSfM85rNwu659kBjZd689Wzvbu7w9zTIP6NRA22zaibfPa9W0BT6F
         tMiNb0GNzDaCxu/rUZezOwYHH5q1OExxhem6GOkaZNrfQmGohZlHfz/SwwwPUZ4Tx4
         /TBK8lvwOJNerOxcYselsxRb+sFd398qwFgkN6dHJFr09MftNg0aMnClBTZbFgVHFD
         IWcuINJ+ermXSTmKmnTgoSvoU5AgjlP0uEg29HeU4H3+oNYHSnMQEPH+yFG+pgUZSj
         1xiCLub5y4e5A==
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c9b95943beso60227235ad.1;
        Wed, 18 Oct 2023 10:54:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyz4PfjT8k7lrrbWq6bkY78WjABow5J8wdyUjcPwpDyXSw3eXF8
        bwNfDgXU4TILHhh5tltvSAhwHHxIHlddPwCWdLg=
X-Google-Smtp-Source: AGHT+IHzFP/SWHcjsGV9qi52IfIK/oX7xpaS9D5bsOAhIQ6+BIWEsqvWuuojLLxWCJDUgCMtZ64ZbVMVL6JOL6jZOLE=
X-Received: by 2002:a17:902:d545:b0:1ca:884c:e48a with SMTP id
 z5-20020a170902d54500b001ca884ce48amr129950plf.0.1697651653220; Wed, 18 Oct
 2023 10:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231016092439.493646-1-yukuai1@huaweicloud.com> <20231016092439.493646-3-yukuai1@huaweicloud.com>
In-Reply-To: <20231016092439.493646-3-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Oct 2023 10:53:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4+bn41+LK1y_RmssmwpMML15=WVo6iTL76x8CATzKE3A@mail.gmail.com>
Message-ID: <CAPhsuW4+bn41+LK1y_RmssmwpMML15=WVo6iTL76x8CATzKE3A@mail.gmail.com>
Subject: Re: [PATCH -next 2/6] md: remove flag RemoveSynchronized
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 6:28=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> rcu is not used correctly here, because synchronize_rcu() is called
> before replacing old value, for example:
>
> remove_and_add_spares   // other path
>  synchronize_rcu
>  // called before replacing old value
>  set_bit(RemoveSynchronized)
>                         rcu_read_lock()
>                         rdev =3D conf->mirros[].rdev
>  pers->hot_remove_disk
>   conf->mirros[].rdev =3D NULL;
>   if (!test_bit(RemoveSynchronized))
>    synchronize_rcu
>    /*
>     * won't be called, and won't wait
>     * for concurrent readers to be done.
>     /*
>                         // access rdev after remove_and_add_spares()
>                         rcu_read_unlock()

I am having a hard time following the description here. Please be more
specific about what issue we are fixing here.

Thanks,
Song

>
> Hence remove this flag and prepare to remove rcu protection to access
> rdev from 'conf'.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
[...]
