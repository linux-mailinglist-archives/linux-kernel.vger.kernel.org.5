Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76827B3C21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjI2VvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjI2VvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:51:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88F1BE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:51:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fdcc37827so848507b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696024262; x=1696629062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ98meF439fDlbDs5bAR/G0m1owNdqgEbq46LFrbqGU=;
        b=L4KnPbZYfbbjr6tdDvM96PRevPAbSVRnSxLjW8WKX8lAc1OUAaktRBmNcO3ha7E+AZ
         t0niJskLdtX67nd0cvOPOheyaXL5ukypfgrwCAExZpzUCQ2QTFJBV5hyESrC2F1pDMIR
         +9w132x/wSscnUqpSSfuS6LtZV4ZdzbYM5gSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024262; x=1696629062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ98meF439fDlbDs5bAR/G0m1owNdqgEbq46LFrbqGU=;
        b=Lg1mr5nAxdgBGcAqmmfFpvZ6bBdkiUtml4hqhSA+616iWbjqf1UsaG/cZxTpGmdu2o
         uFpYBUn/Bn5uCj6wWSPuV/XX3Oqe8l/0wnhBayGUjoqtJ+pPqDSmVEozziht+SBL5A8g
         cZn+qP5l4fhvIu5gU14zBkuYU3cdIYU2QzoylaFgKi1GUu7Crqytile2HsS8F5eDwgzI
         BFKcrsXYGCxeCYUCnlo38Bd2/Qy3Ok350sw9b9MinT7bKtjUVtGx1IUW2XcyjWtoqG+Q
         kRJvYD8JLbczBJrwakV7IH0iC6FB/H3xhXQkmvsqIUzVoB1iUJDsMogyHxJNSQqcFsjj
         MJJQ==
X-Gm-Message-State: AOJu0YzFObZHZEx+2Pj7DiWXuPH/1pvtgcVu7mcvSaz+E2OcD2/pxJN2
        g5c7iISjt5q5atNi1eMPWijWhw==
X-Google-Smtp-Source: AGHT+IHTiJ5wqSsBC/Ti87qgGkYT07bfiI59uolyZwfnU9sNrZIYWr4gwcgRWYX+5dDl1H+O7sSxIA==
X-Received: by 2002:a05:6a20:3242:b0:15e:4084:6480 with SMTP id hm2-20020a056a20324200b0015e40846480mr6416231pzc.27.1696024262280;
        Fri, 29 Sep 2023 14:51:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690daae925bsm15491197pfb.51.2023.09.29.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:51:01 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:51:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Message-ID: <202309291450.E78582CC@keescook>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
 <ZRc+JqO7XvyHg/nB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRc+JqO7XvyHg/nB@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:14:14PM +0200, Ingo Molnar wrote:
> 
> * Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated and we should prefer more robust string apis.
> > > 
> > > In this case, `message.str` is not expected to be NUL-terminated as it
> > > is simply a buffer of characters residing in a union which allows for
> > > named fields representing 8 bytes each. There is only one caller of
> > > `tdx_panic()` and they use a 59-length string for `msg`:
> > > |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> > > 
> > > [...]
> > 
> > This appears to be trivially correct, so I can take it via my tree.
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] x86/tdx: refactor deprecated strncpy
> >       https://git.kernel.org/kees/c/e32c46753312
> 
> Please don't apply - Dave had some reservations, plus after the
> change the comment would be now out of sync with the code ...
> 
> Also, we generally carry such patches in the x86 tree.

I've dropped it now. Thanks!

-- 
Kees Cook
