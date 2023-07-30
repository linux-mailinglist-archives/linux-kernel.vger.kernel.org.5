Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB44768936
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjG3Wyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3Wyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:54:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6B189;
        Sun, 30 Jul 2023 15:54:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5221f3affe4so5236417a12.0;
        Sun, 30 Jul 2023 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690757683; x=1691362483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5id/UpecirppNKHw6frQ7LNJC/s0/wNTJgIw2H535Gg=;
        b=pfLzsG0gwcGduiDbOQnsiHv9rXg4h/DTOju4W/hI9JKQcFbVYt7/Oj/dmPlZDZl4mn
         Zl2G6q6rG/Io1ShjiNrIpZM6Ggyoqd2iGmNLh4+4B+YUdmzpqxLPkeIF+RT6OgRUbCCh
         pfuPZvvJ48JW+eXz+k5cEFOvlW1OE9nSM/WgBpvM+wseJoqfm7hzmQvE9WqFNudHFizL
         2SHlWAIOIQ/Hd9mcpLCxl+Tw3ZHdHmsoDvSaFVhia8ne0CoZVgKzTX/OtbjN5TM9uRl2
         SndIiRJ9wUfKaXVDYHpsPmyxnZjdZAid+HOqooQ1zxYgBdSPqlduAKdvNpvVeb/cUga5
         mnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690757683; x=1691362483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5id/UpecirppNKHw6frQ7LNJC/s0/wNTJgIw2H535Gg=;
        b=liveDx/40dLY1JVtpQvW0flCQkVzZWEu3Z0giz6rm2Amj+/+D4vWQ18qvRuocKz6UK
         ANMfA3e+oCh9wCVfKNcpM2tsX8dqxC3eUkxw+Z2Ljc1cHeldrhefmvRRdyaWkcu5SqqN
         s4ctW5YSoBlb3ZMhapvZxiDTaPJEavZyksikx5+GSrIKYRqEyjx7tpqSB62VgCDNjwI1
         SUySxCqfJE5xgnNCsEPqZ1yMqLFO9OdUQ28LtmrBGM9m2dfwpnAgHamQDTC428/Nruto
         xU7gy5lZRWSRG6avVFVj6IjXU6LGfCip5bAglwTa1fFEo1JS6PzSTxDSbFbwu6Heazy2
         fxCg==
X-Gm-Message-State: ABy/qLbB9AydBl8LhVUwAAvlJNWSAjMZQrMcUde8QlBm60vm21Bv+eEC
        wlECMhUqy3z0XrYnTrDl0Es=
X-Google-Smtp-Source: APBJJlGIQFooEtH+R4RbuRtOKCXAMUOZDuMNzPQFGdNFlju1t+lp6Tmxh/pX9CZ3dxaXuokbu6R9hQ==
X-Received: by 2002:a17:906:a097:b0:99b:d89c:9dd7 with SMTP id q23-20020a170906a09700b0099bd89c9dd7mr3938179ejy.77.1690757683086;
        Sun, 30 Jul 2023 15:54:43 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bq6-20020a170906d0c600b00992ca779f42sm5215809ejb.97.2023.07.30.15.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:54:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6224F27C0054;
        Sun, 30 Jul 2023 18:54:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 30 Jul 2023 18:54:39 -0400
X-ME-Sender: <xms:LurGZDrPinLNvU2nY6Ddh64RG6JT3kkxuM4IszkfwH3m30V622HXKw>
    <xme:LurGZNpzthjNV382ifYBwdXuujj6zoWmO9oTWoVb9rtFiujwl9RdaHpz_DGcdxaYo
    dFq7KTELhHoaNfG8g>
X-ME-Received: <xmr:LurGZAOIHUKBYTfcM8sUnaWbcU931Lk-aa2AiqOTERDMAHhwXB_GLVGm57g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:LurGZG4HbfDSvUVyHV9OPyBKx-4u3URvOilubmsdUSfpjtAIRFP11g>
    <xmx:LurGZC7CxMxdrFKnL3klSS6eRuYXpMgQ17WFwVnMLzgtpbZghjdSUA>
    <xmx:LurGZOidil28DYshv2TC9_ihq3SPwXsGbTdf2TAxf9BJRRx_UDfYYg>
    <xmx:L-rGZOPUVjBHUIhmYeL2cEJskWLPdc7XiyQxgw49fo120iJZ3pnj7w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 18:54:37 -0400 (EDT)
Date:   Sun, 30 Jul 2023 15:53:57 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Andreas Hindborg <nmi@metaspace.dk>
Subject: Re: [PATCH 1/3] rust: allocator: Prevent mis-aligned allocation
Message-ID: <ZMbqBfEI9CuT0FUe@boqun-archlinux>
References: <20230730012905.643822-1-boqun.feng@gmail.com>
 <20230730012905.643822-2-boqun.feng@gmail.com>
 <CANiq72nf4N_HXOAZupM_Gq=c0jg-L__YUQtx4fSRpNuRqt4JAw@mail.gmail.com>
 <AWaNaTAJOJWWnEqJGgGsUTg8NiFGODsiRHl2OJRPb6XvWdXR8IuH7AjLgFn0OH1m_UZKHAcDFoElSPNXKQvgahydWGy3sE4lGEH2W9S-Kdg=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AWaNaTAJOJWWnEqJGgGsUTg8NiFGODsiRHl2OJRPb6XvWdXR8IuH7AjLgFn0OH1m_UZKHAcDFoElSPNXKQvgahydWGy3sE4lGEH2W9S-Kdg=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 10:41:54PM +0000, Björn Roy Baron wrote:
> On Jul 30, 2023, 10:43 PM, Miguel Ojeda < miguel.ojeda.sandonis@gmail.com> wrote:
> > On Sun, Jul 30, 2023 at 3:29 AM Boqun > Feng <boqun.feng@gmail.com> wrote:
> > >
> > > +// Note: Although these are *safe* functions, but they are only generated at
> > > +// `GlobalAlloc` callsites, hence we assume the parameters obey the same
> > > +// `GlobalAlloc` function safety requirements: size and align should form a
> > > +// valid layout, and size is greater than 0.
> >
> > Thanks for adding all the `// SAFETY` comments here Boqun!
> >
> > Björn, do they look good to you? (since you fixed the issue in the compiler)
> 
> Based on a quick look, yes. The __rust_* methods that are normally generated by the compiled directly jump to the respective global allocator method, so they have the same safety requirements.
> 

Good to know, thanks!

> >
> > On this comment in particular, "generated at `GlobalAlloc` callsites"
> sounds a bit confusing to me. Would "... called by the compiler with
> parameters that obey ..." make sense? Or does the sentence refer to

Agreed. It's better. So reword as below:

// Note: Although these are *safe* functions, but they are called by the
// compiler with the parameters that obey the same `GlobalAlloc`
// function safety requirements: size and align should form a valid
// layout, and size is greater than 0.

Regards,
Boqun

> the normal case (i.e. when the functions are generated)? Anyway, it is
> not a big deal.
> >
> > Cheers,
> > Miguel
> 
> Cheers,
> Björn
> 
> (resent as I accidentally sent html instead of plain text)
