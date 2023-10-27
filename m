Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92C7DA08D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjJ0SdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjJ0Sc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:32:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA626B0;
        Fri, 27 Oct 2023 11:32:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so380635066b.2;
        Fri, 27 Oct 2023 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698431547; x=1699036347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wL6rsP27kyhBgPNjGAE37z4bXgSpgcwn8+JkklueuV4=;
        b=TfeI/fScNFSOqMUaSTf5jAQmfJLPSzNfPgYyKiDwaBL67ZJcmj9YL0kO2rCbeK92Bj
         InDKkgD8+fMj0wfFwiJtBZYmVLBYHCfITWaudfXiYQeOMk8wFPPuQBZfQDGWbQBmOk8K
         7DiVDvNvJHl8dBFEFxgVN6eUYqxvoXrjCRwrFNShaPSMDVGdr8w+f1UKOw1/J1RpbSln
         MMyKQrC7cZYyE3X5tXVhYcQ51T8bVfp/n2GdFu1eBcxGGWAhUCZxWsU6Ljl0ZeY4uxud
         B5FQdfNu+XMHLtjmFkoeERnz1Us6ppM8dTm/BIZvsV48t19VSf4hIT15M7BwCi4A6HwY
         D1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698431547; x=1699036347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wL6rsP27kyhBgPNjGAE37z4bXgSpgcwn8+JkklueuV4=;
        b=v2xVIO/cDaBBMsEZFiBuhceoJgHajP/zAerWjxLKRFlaRXLSuir3P4naWNof9lHq+r
         Lk9JR6QwyPVW4/uAE5Y0585uqUD+joUHguJGe8nkwSn7pnh/icos/hV8sjDGGcYPgbRx
         0eUmuu+fFmxnWRxc29kxe91lQLdo6AdcnU24tpJBgMXlly/mDd5IlyjuOwrw2+gChdMT
         /BC80vkjsLM1yHA8bNlg6SYg0tbDIzZOu7HhfMj2FE6jQP+bhYnka7Z9hFFiAEXq4Flw
         4FbAj871N5cp1zTd5aKzxIlFVUAJte7KrKEYRVi1T2dVqJ3DG8IyF39L5Hd29YEt4efj
         OJ9Q==
X-Gm-Message-State: AOJu0YyIA189FwmlcU14kZ3ZfiS5Cwr5hNOu25XwDlCMqyJgBhxI/3Sk
        Y44HG4AY/uPEk7j7CLn9XQ==
X-Google-Smtp-Source: AGHT+IEseHwXORBr9sJ631o9racXkSS0mpkOkeFDiKUjuXjwWnaaKLPyzrP3KLBhmO4nUsL9dB9gVw==
X-Received: by 2002:a17:907:31c1:b0:9bd:a165:7822 with SMTP id xf1-20020a17090731c100b009bda1657822mr2862145ejb.47.1698431546635;
        Fri, 27 Oct 2023 11:32:26 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id gt11-20020a170906f20b00b009bd9ac83a9fsm1571360ejb.152.2023.10.27.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 11:32:26 -0700 (PDT)
Date:   Fri, 27 Oct 2023 21:32:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <c9dd71ba-bb29-4e2d-b8cc-d49d493ffb32@p183>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook>
 <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
 <20231026095235.760f5546@gandalf.local.home>
 <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:59:28PM +0200, Geert Uytterhoeven wrote:
> Hi Steven,
> 
> On Thu, Oct 26, 2023 at 3:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 26 Oct 2023 07:39:44 -0400
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> >
> > > While it's nice in theory to have everything documented, it's not much
> > > use if no one can actually find the information ...
> >
> > Does kerneldoc provide an automated index? That is, if we had a single file
> > that had every function in the kernel that is documented, with the path to
> > the file that documents it, it would make finding documentation much
> > simpler.
> >
> > Maybe it already does? Which would mean we need a way to find the index too!
> 
> ctags?

ctags is a tool from previous century. It doesn't help that "make tags"
is single-threaded. It needs constant babysitting (loop-like macros,
ignore attibute annotations which masquerade as identifiers). I think
"make tags" became much slower because ignore-list is one giant regexp
which only grows bigger.

> Although "git grep" is faster (assumed you use the "correct" search
> pattern, which can sometimes be challenging, indeed).

I tried QT Creator indexing at some point (which is parallel), it needs
to be told that headers are C not C++. I didn't find a way to tell it
that .c files are C too but F2 jumped to definitions quite well.
Also hovering over identifier/name works (being IDE it understands
popular doc styles).

It can be made to work reasonably well provided that you did "make
allmodconfig" and added few header locations. clangd parses like compiler,
not like human and kernel uses a lot of CONFIG defines so some config
must be chosen.

But I need to recheck all this stuff now that new version was propagated
to distros. It should be better (and less segfaulty :-)
