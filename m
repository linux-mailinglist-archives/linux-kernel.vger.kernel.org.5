Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF8758CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjGSFAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSFA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:00:27 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D811BF2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:00:26 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76571dae5feso602977685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689742826; x=1692334826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJV+5H7WHAd6FvjZ1TOjL7hWDt3g7V64oyP4LlM0T74=;
        b=LHYzANnXsGO/VDnFyFI2yYLRZUrhDs294AiCUCVYJFv1oCRnrAiCEXXKKr1Wbw4Xi7
         WKyCo3l+241P/vTt0bpy3xBnlu9djZwxIl7biKdikgaUTWY+c7jM/OY8vsiPR8EYGYN3
         QkkFwQY21A37VAGogjtsNMvgcJ4IuBSn8lVss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689742826; x=1692334826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJV+5H7WHAd6FvjZ1TOjL7hWDt3g7V64oyP4LlM0T74=;
        b=Ib9Ev+KpGhdOTwzDtztlZ0inTCeK+ZhewIkfe3BmG8DPPvbeo7jjvIpCnQ0VZabbcM
         PGbopDOcdaKoUxO4FTXNNqmDFyOSRlYvEaqcGaJNfiYAFiEElCV5SdJf54kQDOh+KhS5
         GQx6Sl4FCue2clUUracuutzQUTMOlyY4bc2TRr+eOGyt9P/iG2PL2rgIqYw0pGAp7ClY
         cWRd+RXbKP7xtVz6cL76SrdCRDTP+Ph2hXcJ8gt8F8OKktxjcmKjncLzVgZ4o6r7j4OG
         Fe0xiC6y3kHuFf9bpo4HTOxZxavYGEzdHh0rsXuCc7gGIaK+s382Bkq3B65T+f19BCyK
         1E+w==
X-Gm-Message-State: ABy/qLa648EtYdy0E9QimUN0VjkDf6lWjPSkYx905MdO+0bPsfZ2gvH/
        j7vGvT0a+HlomFdK9WZM8UHOHguFk4PhMsApONc=
X-Google-Smtp-Source: APBJJlH9cUbrl47s/tZ3jmVxzSHae+deP+2Z74B5lJRj1FiVldoMgegBxL27xRdf1h+5cuRV6+N4Rg==
X-Received: by 2002:a05:620a:4724:b0:767:3b7d:687c with SMTP id bs36-20020a05620a472400b007673b7d687cmr2067876qkb.15.1689742825929;
        Tue, 18 Jul 2023 22:00:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fy16-20020a17090b021000b00256353eb8f2sm383334pjb.5.2023.07.18.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 22:00:25 -0700 (PDT)
Date:   Tue, 18 Jul 2023 22:00:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Message-ID: <202307182147.A5B81B67D@keescook>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
 <168963536094.1395996.315062356944871422.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168963536094.1395996.315062356944871422.b4-ty@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:09:23PM -0700, Kees Cook wrote:
> 
> On Mon, 17 Jul 2023 12:33:32 +0300, Andy Shevchenko wrote:
> > Privided seq_show_option_n() macro breaks build with -Werror
> > and W=1, e.g.:
> > 
> > In function ‘strncpy’,
> >     inlined from ‘ocfs2_show_options’ at fs/ocfs2/super.c:1520:3:
> > include/linux/fortify-string.h:68:33: error: ‘__builtin_strncpy’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
> >    68 | #define __underlying_strncpy    __builtin_strncpy
> >       |                                 ^
> > include/linux/fortify-string.h:151:16: note: in expansion of macro ‘__underlying_strncpy’
> >   151 |         return __underlying_strncpy(p, q, size);
> >       |                ^~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] seq_file: Replace strncpy()+nul by strscpy()
>       https://git.kernel.org/kees/c/c30417b20f49

Gah, I dropped this from my tree since it was actually wrong[1]. This is an
ugly corner case with strscpy vs strncpy: the cast be32 from hfs/hfsplus[2]
looks unterminated to strscpy, so it would return -E2BIG, but really
FORTIFY noticed the over-read (strscpy is correctly checking the 5th
byte for NUL).

So... I think we need to fix seq_show_option_n() using memcpy+NUL, drop
the ocfs2 usage, and clarify that the seq_show_option_n() docs mean
"n means _exactly_ n bytes"...

-Kees

[1] https://lore.kernel.org/lkml/0000000000000a88cb0600ccef54@google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/hfsplus/options.c?h=v6.4#n221

-- 
Kees Cook
