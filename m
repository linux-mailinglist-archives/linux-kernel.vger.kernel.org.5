Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1B7A141C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjIODEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIODEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:04:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B82709
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:04:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-573ccec985dso1329177a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694747065; x=1695351865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGCU+XO9lmHPleHOolcpXGUsBUX+De3p5Ob7hsvn5gU=;
        b=bOdxjYVmZFExLQqE6s04p5bhi6dKZXSETT/LUwxFif98o31Wn69f9ST0qoGPyI2U9O
         jRB+Jg3PGWFMIt1LKCK/8opG6eI9qaO6BOb0dikQ3e2q0C6o9CcZKo8YvdVSn8v0AbgN
         Toco2CmdGK7zbAmuk0HCdars+SEYJ1Kf6RvJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747065; x=1695351865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGCU+XO9lmHPleHOolcpXGUsBUX+De3p5Ob7hsvn5gU=;
        b=kzSnueQM9xR+lrSa0eaNFVtxs4ABm9nBn5Ciwlwl8brAh/ggROsmXkla5tmpD/bJUl
         Ccrc0wm9M8Z3MHBH/mjpp9Q1sT+nelIur3v7Q049zVhFm7mciBWgIBBx9AZtA9iUwBlG
         NQHKGrDkhlUJ1nGmdQ28P4rjFhonDWR4yMzMpH2wngHJ6XISD+1M6LJfGdL9kqoKt1HT
         140pT394DWQZEh8kp82LYR2QH2cDhYJ34PtMoqUaxnuykgdoiSR1beiaoSe5e/gzTg+o
         CMyqfYyxQRxkeEe+8JVS4AJlg4tu3neQlSub9zFspWEItjead/F6DCNhIDGvSWhka5PJ
         mLqw==
X-Gm-Message-State: AOJu0YyOMAlDsgCGfpIh9QcnHjEcUIhxro1st+bAoMQ4xJzvMUiupdgv
        YHLvm5B8t16/AW36r+3rR4XEfw==
X-Google-Smtp-Source: AGHT+IHpVAX3ysYHUhi4mt+g7HzKFEpt+mObL2VXXl0TVoEcBzg8qVGdqPoLpuTo5z335w514/jdUg==
X-Received: by 2002:a05:6a21:3e0c:b0:14c:3218:c1bd with SMTP id bk12-20020a056a213e0c00b0014c3218c1bdmr621008pzc.11.1694747065687;
        Thu, 14 Sep 2023 20:04:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0026b45fb4443sm4209388pjg.4.2023.09.14.20.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:04:24 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:04:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
Message-ID: <202309142001.9C351F8D2B@keescook>
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
 <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
 <CAFhGd8r9Ow2xmJ++apef0rn2DHBhKm9BvfLooMTqzyaOhqbEgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8r9Ow2xmJ++apef0rn2DHBhKm9BvfLooMTqzyaOhqbEgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:12:35PM -0700, Justin Stitt wrote:
> On Tue, Sep 12, 2023 at 12:36 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Justin,
> >
> > Thanks for your patch!
> >
> > On Mon, Sep 11, 2023 at 7:53 PM Justin Stitt <justinstitt@google.com> wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > >
> > > `gate_buf` should always be NUL-terminated and does not require
> > > NUL-padding. It is used as a string arg inside an argv array given to
> >
> > Can you please explain why it does not require NUL-padding?
> > It looks like this buffer is passed eventually to a user space
> > application, thus possibly leaking uninitialized stack data.
> 
> It looks like it's being passed as a list of command-line arguments in
> `run_helper()`. Should this be NUL-padded due to its eventual use in
> user space? If we think yes I can send a v2. Thanks for pointing this
> out.

No, it's passed as a pointer to a string, and the clone call will
ultimately make a copy-until-%NUL when building the new process. This
doesn't need padding.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
