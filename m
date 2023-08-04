Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B076E76FB52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHDHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHDHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:40:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B93ABE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:40:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bba54f7eefso19700855ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691134816; x=1691739616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+S/9HOpKs+1jF9GSXyS733mVpklGbIJgO96+jDBzHA=;
        b=fxgjU+IoMNHEYmoEJLl4XaO1ytDgzRbm9Mu+8tVQJDpnJwpOkW6RB8OONKaubdlpxn
         RrpMvvKVPuWFxusmkY74T5X2o1qRTWu17iWmY56NydavR89C3npXYpl/lSib2eK0LgK8
         yzo8ChMPoroZwEQlSkc+lPVGqKOeR4+DxMK8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691134816; x=1691739616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+S/9HOpKs+1jF9GSXyS733mVpklGbIJgO96+jDBzHA=;
        b=bvzQFdPXgTIlZ1EsYBjCnEpb7W/+vFgbg7OPq6UNnyfLvbSwWWghukDwTsUpnvq391
         jFFr+HlhTRSr65zX6C07ThRTdz25kIByRf5TPB/WWx2KBQXg/mcLUn/YtNw915VHw8oB
         E0Jmp3pdQ00ZmzXl3KJVqXQLx6RQUyZNO8KXKOLVtmAeWP60HfMvxG9glomxDznXkwb8
         DfhX14jhBB3JOqetuX0xPW1VSBp8X8MEvZopthP5P5WUr7ICzP+CDiqhfh9U+Z0oG+rI
         zfuQNLVqlLXnDqcudXcDSrMegdED4+t3b2KXFVrKGExzEbEF0lK21Qj5DTj4Vbkg1ug5
         TTJg==
X-Gm-Message-State: AOJu0YycToBq+WZ7xIXZDAHuwIjPriDzflGNfaeEKnUlOECGVZpdSASX
        lPVcjOm3580gBtg1lePiR6mUfg==
X-Google-Smtp-Source: AGHT+IFsmqQUMHGEjD/HoJ7z9cdXciny8xZesWp4+Fj8uiyFOUA9fz/ha/zaCCgefg4s9kErw4dayw==
X-Received: by 2002:a17:90b:1e10:b0:268:94b:8d0 with SMTP id pg16-20020a17090b1e1000b00268094b08d0mr1404750pjb.11.1691134816644;
        Fri, 04 Aug 2023 00:40:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a64c400b0026307fa0442sm3577655pjm.49.2023.08.04.00.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:40:15 -0700 (PDT)
Date:   Fri, 4 Aug 2023 00:40:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tomoyo: refactor deprecated strncpy
Message-ID: <202308040039.D9B575B3F@keescook>
References: <20230803-security-tomoyo-v1-1-c53a17908d2f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-security-tomoyo-v1-1-c53a17908d2f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:33:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> It should be noted that the destination buffer is zero-initialized and
> had a max length of `sizeof(dest) - 1`. There is likely _not_ a bug
> present in the current implementation. However, by switching to
> `strscpy` we get the benefit of no longer needing the `- 1`'s from the
> string copy invocations on top of `strscpy` being a safer interface all
> together.
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! This looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
