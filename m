Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0563078CC74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbjH2StP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbjH2Ssw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:48:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADAACD5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:48:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1e780aa95so15035775ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334927; x=1693939727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WlpFwu22BuXcdAslyPLnhdHAaPNdS1lUhQ/bzoXJHU0=;
        b=KjzHMEZS1fi+BT9hdiRi+W2XW02HxQYoYIckKHIXt6urLwJwvMF1uKUCljUVryZ3Iu
         cf8z584cgA8JVHL+So+nlfKCTisXkUFWAXt842plGp40TLCpDNlBtnqfeg6ZNxNNCCkW
         grXX0rANGAXeDphxdobpmuEsJZhMU093xuD3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334927; x=1693939727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlpFwu22BuXcdAslyPLnhdHAaPNdS1lUhQ/bzoXJHU0=;
        b=FrOXtkOqdaybBx80V5Y7oGt4dSi1XgXfks5v+N5CicVjqdpPIub8b2YxUPK2SV69kf
         DM/Fqjuf6UjC0ptlTOPt/lcFEseJioGzkxugfA5cH5dhCNNiRwtApJIHLx02SNToYzKd
         aGK+aBZRU6nGGopKyrS0icbQmZle+2MVuLQQ5WgR31niyGoHo/sV9i5myCYWwiB22saf
         qEG7JuOAru9eaBAfGsMas2ITOrcFRGwWGxhZeWKJjCOPnio2A2zO9yWcK5t+TsWPqvvQ
         8y/VN70K0QO2jyEPGLpKOp2w+i0dU9Qm1+HNi9csIckLnNdVNxMLrFTDKSErOylRK98V
         6S1w==
X-Gm-Message-State: AOJu0YzXCKilPh+yHqN+Z3hX6v7BbkWXyy+r6cNt7Mtl/z+rYurhe5p8
        kXy8aDm+GhkVR2Vui0yFYekF0w==
X-Google-Smtp-Source: AGHT+IG6Sdl5CBNfsQf6qLGj2msuoi5Z+xNqTfNTxcW4FtLo4dCGfrPkxFnX0y+F/LV9qNNxHbnxKw==
X-Received: by 2002:a17:903:1212:b0:1bd:b8c0:b58f with SMTP id l18-20020a170903121200b001bdb8c0b58fmr29470329plh.50.1693334927083;
        Tue, 29 Aug 2023 11:48:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902748600b001b2069072ccsm9708751pll.18.2023.08.29.11.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:48:46 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:48:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 0/2] scsi: fix 2 cases of -Wfortify-source
Message-ID: <202308291147.2CB91AB9@keescook>
References: <20230828-scsi_fortify-v1-0-8dde624a3b2c@google.com>
 <CAKwvOdmaeupeLgJWjMD4iJ1pi9NFTN-MTp3uC0jDVp2T2+Ctxw@mail.gmail.com>
 <CAKwvOdmpSmWGUA-SHJ9PofayfxFc--MJuxgQ0cU8bnDB6c=wag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmpSmWGUA-SHJ9PofayfxFc--MJuxgQ0cU8bnDB6c=wag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 09:33:55AM -0700, Nick Desaulniers wrote:
> On Mon, Aug 28, 2023 at 4:41 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Aug 28, 2023 at 3:25 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > clang-18 has improved its support for detecting operations that will
> > > truncate values at runtime via -wfortify-source resulting in two new
> >
> > ^ -Wfortify-source
> >
> > > warnings (or errors with CONFIG_WERROR=y):
> > >
> > >   drivers/scsi/myrb.c:1906:10: warning: 'snprintf' will always be
> > >   truncated; specified size is 32, but format string expands to at least
> > >   34 [-Wfortify-source]
> > >
> > >   drivers/scsi/myrs.c:1089:10: warning: 'snprintf' will always be
> > >   truncated; specified size is 32, but format string expands to at least
> > >   34 [-Wfortify-source]

These should just use sysfs_emit() instead. Then all the bounds checking
against the PAGE_SIZE buffer gets done correctly, etc.

-- 
Kees Cook
