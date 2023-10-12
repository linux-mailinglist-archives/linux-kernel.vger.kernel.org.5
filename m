Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30DA7C75DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379655AbjJLSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379577AbjJLSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:31:29 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2DC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:31:26 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b74782be6so690681eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697135485; x=1697740285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kmUopNj4SKl1oz8w54FsmEGmf+2bTIjcRS6uvAC4XKo=;
        b=nMRJwDb7lLq45Vq56/8oKuRCxXSym2fA17TvfEEtl/Np1rAVXrvr5bzD7D+wvTe1di
         YfigpvNCXV18e2daBOAOTx+fJ2SiKYJKRg5xNJD/NZTwgAOlQeuGIM6Vs/d8DnVeNvjU
         66LpLgCt+Y7EwbE+V43RmcPQUUuf3MqLj/hwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697135485; x=1697740285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmUopNj4SKl1oz8w54FsmEGmf+2bTIjcRS6uvAC4XKo=;
        b=eYMy5lTgkk9gfyhxyPlxacJ91zUV77bYv7cOToWD1w5KhioznI3Zha7HLfpyaSyW0g
         dX20VYo6n+JzIVbKau7xjwOTSrIMdGhOmE/sYWgafC9EDZwcU6Sif+Sq7y6dj/WhCsPT
         gMX0KWp0y3buCMbAQqg5LkA6d/QlKLv3wqE374hRxxqTaa4Dv8FKxC9/kRwnO9t7MLQp
         yKLA3dGKfrTV5ulQKFxbvDz0nIGhzHGbInxW7nOW3zui7Y8FUtHSO/YG8ygU42kEPEKq
         KED/rZI/mVd9GB2rKQ+GTZay2wcvrVzKOG/tLsOcswUTB/SL+sCU1R33fyyRflXrWAml
         eXOg==
X-Gm-Message-State: AOJu0Yyy+XSvQDnftWpfbUf6zj1WLVKnguhCZXM1UpBh307A6Ry7m0By
        m0jLt894d+ZPd0YcMt+rhBrd7Q==
X-Google-Smtp-Source: AGHT+IFb1ckH/xhcO6Zgz8KHFb8znJRiSnNP1u2o9ir74qQo0GMUO1tDivlCPnScZzkxDX4RIMu5BQ==
X-Received: by 2002:a05:6358:52c5:b0:14c:4411:2f4b with SMTP id z5-20020a05635852c500b0014c44112f4bmr32545120rwz.22.1697135485618;
        Thu, 12 Oct 2023 11:31:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020aa793a3000000b0068a54866ca8sm12088064pff.134.2023.10.12.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 11:31:25 -0700 (PDT)
Date:   Thu, 12 Oct 2023 11:31:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
Message-ID: <202310121130.256F581823@keescook>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
 <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net>
 <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:50:36AM -0700, Sami Tolvanen wrote:
> On Thu, Oct 12, 2023 at 3:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Oct 14, 2022 at 11:34:30AM -0700, Sami Tolvanen wrote:
> > > On Fri, Oct 14, 2022 at 11:05 AM Miguel Ojeda
> > > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > >
> > > > On Tue, Oct 11, 2022 at 1:16 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > > >
> > > > > Rust supports IBT with -Z cf-protection=branch, but I don't see this
> > > > > option being enabled in the kernel yet. Cross-language CFI is going to
> > > > > require a lot more work though because the type systems are not quite
> > > > > compatible:
> > > > >
> > > > > https://github.com/rust-lang/rfcs/pull/3296
> > > >
> > > > I have pinged Ramon de C Valle as he is the author of the RFC above
> > > > and implementation work too; since a month or so ago he also leads the
> > > > Exploit Mitigations Project Group in Rust.
> > >
> > > Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
> > > and he expressed interest in helping with rustc support for it. In the
> > > meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
> > > issues here.
> >
> > Having just read up on the thing it looks like the KCFI thing is
> > resolved.
> >
> > I'm not sure I understand most of the objections in that thread through
> > -- enabling CFI *will* break stuff, so what.
> >
> > Squashing the integer types seems a workable compromise I suppose. One
> > thing that's been floated in the past is adding a 'seed' attribute to
> > some functions in order to distinguish functions of otherwise identical
> > signature.
> >
> > The Rust thing would then also need to support this attribute.
> >
> > Are there any concrete plans for this? It would allow, for example,
> > to differentiate address_space_operations::swap_deactivate() from any
> > other random function that takes only a file argument, say:
> > locks_remove_file().
> 
> I haven't really had time to look into it, so no concrete plans yet.
> Adding an attribute shouldn't be terribly difficult, but Kees
> expressed interest in automatic salting as well, which might be a more
> involved project:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1736

Automatic would be nice, but having an attribute would let us at least
start the process manually (or apply salting from static analysis
output, etc).

-Kees

-- 
Kees Cook
