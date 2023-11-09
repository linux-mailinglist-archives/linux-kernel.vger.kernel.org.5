Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52E7E6BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKINy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKINyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:54:24 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654DD272C;
        Thu,  9 Nov 2023 05:54:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6707401e1edso5663596d6.1;
        Thu, 09 Nov 2023 05:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699538061; x=1700142861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z42HWweLYTdSGX0W+HlQsOPqVhtBfxSukaDoEFV1YIc=;
        b=Y2rEq1T9KvlTrchTQ2UGZ1IkHn+b9gr+ie7Z3wEcXA1gbOYdGWlfGs0WMKRlLWERmg
         kQLg4PWuhotFisZ8V8CX5buLRE9kkihc9YazASSOq0RxFO7evjPE5tp5eL81oGFQ7W8g
         i/cRBndnrJh8EE6SWm96M+cWL5Ke11iwyyVGbWU+fK1qxs96V8bYRsYwFDW2qFmOjA6+
         Q6EmLGd0En4GR+AkW4s0DJZcqoVRJKIq8NZr45s5Tnk84akvUg/ByqfLIohjn3mTjsey
         EZgPUCPWkPf+ezrnZP88pGoW1zsWRAVTPUmTMzskTpwRE6Dr4N7DO5DMmTV1JYl8E5Bd
         zAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538061; x=1700142861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z42HWweLYTdSGX0W+HlQsOPqVhtBfxSukaDoEFV1YIc=;
        b=g59UySEDgAGmE9R/qXi4QDcF/jDnE56QCwuZQXx/M8HgOMM39gQ9KsjN6xlscR1JsC
         wmly+HfJNp14whRqCDFp8woeC6rRgTH/AFo11YFR43TIojlEWsp2wIdvTG0qqwDZShmt
         hkL3U6GpB1mpBd5GxZjbjTthTMGbV1uoBtTIbZy9VBnc5Tj4/RwF9shvObQ6WKPNCaQW
         rlwGoda0l1Xrz8sY/+BSeEHwgTS7dxfZJWU2N0TMDMx0SjYLk7YH9XpiKziPQsiyvTmP
         UvydLBcLnHytMt8bM3ms7YTm3NvBaS6qJoEFrfMB1r1VmuTVB2Aef++8L3HWWQCzypNK
         d1jg==
X-Gm-Message-State: AOJu0Yzboq2obdR19qQtyoZMwBZ3u9/dJNUusEHkgfp/19cM3zMq+WuX
        3Z/QAhh4HrZsOfoK/s6/umaz3vtk6wU3AiU8vLk=
X-Google-Smtp-Source: AGHT+IGADWikO6oNTwaA0U14hvH4C+OCIsQvy7sSD8b7QQ4FEnhv+kPj1zSEv3ve+XNsJqkQ0pLn8siSSOi7dUBWSdg=
X-Received: by 2002:ad4:5e8f:0:b0:66d:627e:24c0 with SMTP id
 jl15-20020ad45e8f000000b0066d627e24c0mr5336741qvb.38.1699538061503; Thu, 09
 Nov 2023 05:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20231109085419.84948-1-heminhong@kylinos.cn> <ZUzSM37FWz6sgH9n@rigel>
In-Reply-To: <ZUzSM37FWz6sgH9n@rigel>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Nov 2023 15:53:45 +0200
Message-ID: <CAHp75Vd5Ea_yFb7tEQw5ZBr90CcETa-_BsbfpfFshFx8ddZqQA@mail.gmail.com>
Subject: Re: [PATCH] tools/gpio: prevent resource leak
To:     Kent Gibson <warthog618@gmail.com>
Cc:     heminhong <heminhong@kylinos.cn>, linus.walleij@linaro.org,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 2:36=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> On Thu, Nov 09, 2023 at 04:54:19PM +0800, heminhong wrote:
> > In the main() function, the open() function is used to open the file.
> > When the file is successfully opened, fd is used to interact with the f=
ile,
> > but the fd is not closed, it will cause resource leak.
> >
>
> All open files are automatically closed when a process exits.
> That includes both those returned by open() and by the GPIO ioctls.
> So explicitly closing them here before exiting is redundant.

I would argue that this is a good practice for GPIO cases.
More the GPIOs we have, the more line handles we can get, then default
MAX open FD limit may occur. The best is to combine both.

--=20
With Best Regards,
Andy Shevchenko
