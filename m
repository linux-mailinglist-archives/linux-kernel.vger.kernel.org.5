Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645617AF708
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjI0ACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0AAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:00:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469DEAD10;
        Tue, 26 Sep 2023 16:17:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF245C433C8;
        Tue, 26 Sep 2023 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695770239;
        bh=Hx5q0X6p+d0LIi6fY+AaluSPneQQ4+sDt0fmIZmmu50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T67r0BI8aRoDL8IwCXP7IJmDQXV4D32Lv1WpwdIhVxHaa404HJBSZIbvGjT9nBE+L
         0++VqThkAltnkmVUESk768kFI3Aq1aHyxqLjAe1aowyUYeLpQSU6qDH/qn0Uo+Pyof
         fsdyQ8pZTv61xuhjqfyjbRQU+VUyWcf4b4UTG+vlQKC8H/nToETYK3s9tUGvA+wdf9
         RT/l+8OnHerziunqeWYU8GW12Du/PZS4egXsmHPzvlDVwJzuGM3yi0BANb1fzGDdm+
         TGmMMWpaE0yFuqkMwIDUNyTERxKoxOupVnayFAI3iuRm9MU5QE7ytb3JLbZGHNaXqD
         s9o3cXg5lYJTQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5041335fb9cso15874785e87.0;
        Tue, 26 Sep 2023 16:17:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2DkglQWI+imszMx+5rcksD5shG+h/Rqxky3ZwbFPdPPi7DtGs
        nAVJLrZhwq7iizPffc8jzIQYz/NUtrdtbuz2yjw=
X-Google-Smtp-Source: AGHT+IFeQf3Z7lYgOfsmxkyHI8Ar4AHjFWstrfAjs0ZUWK5+nLdfE9piS+uWe3MXamZtlhWr90MkmX5oj+FlziEorII=
X-Received: by 2002:a05:6512:12c3:b0:503:314f:affe with SMTP id
 p3-20020a05651212c300b00503314faffemr157768lfg.17.1695770238000; Tue, 26 Sep
 2023 16:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230925-strncpy-drivers-md-md-c-v1-1-2b0093b89c2b@google.com> <202309251122.6E3E678140@keescook>
In-Reply-To: <202309251122.6E3E678140@keescook>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 Sep 2023 16:17:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6MGr=ZA1yoHSH3YdG4Z5x5+qcJt8cMoNqG2cb7EqJYcg@mail.gmail.com>
Message-ID: <CAPhsuW6MGr=ZA1yoHSH3YdG4Z5x5+qcJt8cMoNqG2cb7EqJYcg@mail.gmail.com>
Subject: Re: [PATCH] md: replace deprecated strncpy with memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:22=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
[...]
> >
> > So really, all these instances have precisely calculated lengths and
> > purposeful NUL-termination so we can just use memcpy to remove ambiguit=
y
> > surrounding strncpy.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> I agree on the analysis of the replacements. Thanks for all the detail!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to md-next.  Thanks!

Song
