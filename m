Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901D678144F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379987AbjHRUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380008AbjHRUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:25:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DC3A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68874269df4so1125996b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=egJ39qsdNDnaP8eBPC82Q2jt0LO0zgNc95KY2wtH+1V9wbBTLh1Ky6jQ8rTauBiJ/b
         ht64aXi61KNBL+Y8bEkkcaHZ81EwY79cKy4mJrPXZWraEd9SsbYba8O66Uznhj9BPFlo
         Uapx6baXCoHKgND+281kPb5nFph/dYaduliqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=Kwii5i+ynEfNgF/3+eNPlv9Fwvwyk8eyXGQzXVHa98X4DWPGgbrTSY47j28livVqWU
         TPE+lQmS6CYVnsiRWdpTqLljpuWc4IRZePYnQXzkXecyfgS3nu+JU3uryCFm44H1bxPZ
         U8Q6M3yn8LWx2XBfHASV5bYETFSPFPfdPBKY62U/oSFGcYt9zbns+T+Y0ItTeBBFXxkp
         mruvtkY+edKuOZV/IqUVx2n46NHgDx0DWZlLxSEF/Iq8F/XR8OBxpLWg1MNUcquxYWOP
         RmWIQonEwNFZTPLCqLgqdQqcCBwld9raLkZqpPOb1J/krnA74VbQphvwIO8r4ju2ilMF
         O41Q==
X-Gm-Message-State: AOJu0YyKoEUkX3HO36V7rXmh2mA/AU2b2T/C87+ZDavAT0IrQ40CcG34
        oRIm0Udp/sNSbDbNQ4MEOgHqcQ==
X-Google-Smtp-Source: AGHT+IFzZ5xua6284VP9UIz+L1TCJGOBeZWzRVDjkLYvOiLi5m1A3dBrZZ7aSqweUnt5zS1+NUVOeA==
X-Received: by 2002:a05:6a00:24c6:b0:687:3022:9c1a with SMTP id d6-20020a056a0024c600b0068730229c1amr298176pfv.28.1692390299149;
        Fri, 18 Aug 2023 13:24:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b0056428865aadsm1755227pgp.82.2023.08.18.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:24:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 13:24:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-ID: <202308181317.66E6C9A5@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook>
 <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
 <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 04:10:49PM -0400, Jeff Layton wrote:
> [...]
> extra checks (supposedly) compile down to nothing. It should be possible
> to build alternate refcount_t handling functions that are just wrappers
> around atomic_t with no extra checks, for folks who want to really run
> "fast and loose".

No -- there's no benefit for this. We already did all this work years
ago with the fast vs full break-down. All that got tossed out since it
didn't matter. We did all the performance benchmarking and there was no
meaningful difference -- refcount _is_ atomic with an added check that
is branch-predicted away. Peter Zijlstra and Will Deacon spent a lot of
time making it run smoothly. :)

-Kees

-- 
Kees Cook
