Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E67892EA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHZBNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHZBMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A526A5;
        Fri, 25 Aug 2023 18:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE4C63615;
        Sat, 26 Aug 2023 01:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D422CC433CB;
        Sat, 26 Aug 2023 01:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693012362;
        bh=OQ26x+tEMNJBBkGWJkcon/6a688RQ4dIz4lrVLT1l2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d3UQ8etPKlMUm0R+U0jULX128F+h4C0Q8XoW5G259znIN71RtNlV51ll1RrDyGh4c
         VRGy3jyfLUwn/KcVpFWfWJikZhhAMx4eaYzgo8YVm8fsiPaO1Aj2Q4Cjeinvif6qDK
         eLCDf0n7zoXuGzMbGVw4rwm2D30bRFPvwRZzrLOxzUdITx4zHFzOhWIR7KHo8kbsqV
         2xJ/kwiMxFMLpW4+l5vexCXQy0sfLhBET82Z23rzWasWEF4k7YGoBqosP0Yo+t+AEm
         pYIvMW1Or6rzulfUpm+0MLhd8IkJEmC0TYBCgPBYc1QTOKBInKd7cV170/T1ojMor5
         I+SB0tJn2kCNA==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b9a2416b1cso1130625a34.2;
        Fri, 25 Aug 2023 18:12:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNVrPaBP2O2r7bSqHM4jGAQL1I5nDECNMMz/gS/SWUbphvp9ee
        2XYAdROfHgSK3zqvTHwSICcwWI1f+ZD3L6HvbCM=
X-Google-Smtp-Source: AGHT+IFwTw95S53Gjz/EMBD08caLzkooGqvKHhHEpR/ybHdcdF5g+Z6MqybqWuaXC+YpYvQ2u257qzPWCjQEmrAZJok=
X-Received: by 2002:a05:6870:f10d:b0:1bf:5559:4aaf with SMTP id
 k13-20020a056870f10d00b001bf55594aafmr4815734oac.34.1693012362214; Fri, 25
 Aug 2023 18:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
 <20230822061203.GA610023@google.com> <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
 <20230824012027.GD3913@google.com>
In-Reply-To: <20230824012027.GD3913@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 26 Aug 2023 10:12:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvDBwN7X8X0mVqcQn6dKxGFhkgt9Qb5CZ6p+6Eafxd0w@mail.gmail.com>
Message-ID: <CAK7LNATvDBwN7X8X0mVqcQn6dKxGFhkgt9Qb5CZ6p+6Eafxd0w@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ying Sun <sunying@nj.iscas.ac.cn>,
        Jesse T <mr.bossman075@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Aug 24, 2023 at 7:50=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/08/24 10:00), Masahiro Yamada wrote:
>
> > For the MFD_RK808 case particularly,
> > I believe Kconfig showed MFD_RK8XX_I2C
> > as a new option.
>
> I think there were some other unmet dependencies for MFD_RK8XX_I2C and
> I don't think the new config was shown. But even if it was, we still
> would have no idea that this meant "MFD_RK808 is not available anymore
> and the corresponding code won't get compiled". So the "this is not
> recognized anymore" is still needed and is quite helpful.
>
> Would you be OK with "list missing" being a warning (not a terminal
> condition)?


I am fine with implementing both.

But, I'd like to implement them as separate options.
(one option for warn unknown symbols,
another for for turning warnings into errors)



As I replied to Tomasz, I am considering about
env variables vs command line options associated with W=3D option.





--
Best Regards
Masahiro Yamada
