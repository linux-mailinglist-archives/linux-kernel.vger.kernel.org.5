Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C07B3A00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjI2SZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjI2SZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:25:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359E1A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:24:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5bbb205e3so130719595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011897; x=1696616697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWNSZ3YxPSHD/wio/2AsKjYLKGNLPQGZGcZxYSYqi2M=;
        b=QIALHOm9ANRQCMnMJxBP3mFzMMdWFv1aKlg7JaqJ0u9/J0WeWiOxJ7i+k1lUPYupPr
         SPhM4bm3q3fe1PW6ts0P2FibvvQ6FNwe7GpFQhujJLXWOuX7m4Mc73CjXneXxUj1eVAJ
         iJgx+P9Zk5olYkY83FbSJkwd7sWaOckO1OImg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011897; x=1696616697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWNSZ3YxPSHD/wio/2AsKjYLKGNLPQGZGcZxYSYqi2M=;
        b=VTwEoaGzBNZx/1ZMd98Fkj2CrEP4t3M2LSGO/8YtYSfQ8rUoHJ6MbeSQQRwAEGLgrf
         xuU8VaLvQnIFpT3uRICOGz9DncRMRpWp63Xvn66G2V4D8/7b/FH2koADY3vF3aGHk2PL
         qYJHH6bjv4sHuWmuBfun1ZZIREl1y0cEdbUgg/8DasKfaQRi4Adphi1yS6lktpVwvesu
         fAqRN6/8k2vCJIIfy+MjKn2XnKkkcLtbzK6SpGAHQcuJjzFvY6aAfNJnfbDzvp6W+xIq
         qiJPvY9eg57msscfn14bLCVUyqRMe3YrE/1wTgxK3LDD+lpK/oGKAv/AXYzG+P6J24mt
         6pjQ==
X-Gm-Message-State: AOJu0YxkDoyvRxAQ7OY0/zfBPCbR3stAm0z4LY38Vo6dgQk7e69CMRaS
        n0qwXoug2oiTFqMO+RS8oaW5rA==
X-Google-Smtp-Source: AGHT+IH+io+uCaRSxHZk/J1NeIEam43xU6xtIgqyJA5qlIvuBpSZvJBrUWL83IF62539ghY3HPzuQA==
X-Received: by 2002:a17:902:e746:b0:1c7:3f5f:1bc2 with SMTP id p6-20020a170902e74600b001c73f5f1bc2mr5042481plf.7.1696011897524;
        Fri, 29 Sep 2023 11:24:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001c5eb37e92csm15126138plb.305.2023.09.29.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:24:57 -0700 (PDT)
Date:   Fri, 29 Sep 2023 11:24:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <202309291123.FAE665CC7@keescook>
References: <ZN5DvRyq6JNz20l1@work>
 <20230818193810.102a2581@kernel.org>
 <CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
 <20230821114802.1d1ce74b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821114802.1d1ce74b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:48:02AM -0700, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 10:35:29 -0400 Jamal Hadi Salim wrote:
> > > Sure, but why are you doing this? And how do you know the change is
> > > correct?
> > >
> > > There are 2 other instances where we allocate 1 entry or +1 entry.
> > > Are they not all wrong?
> > >
> > > Also some walking code seems to walk <= divisor, divisor IIUC being
> > > the array bound - 1?
> > >
> > > Jamal acked so changes are this is right, but I'd really like to
> > > understand what's going on, and I shouldn't have to ask you all
> > > these questions :S  
> > 
> > This is a "bug fix" given that the structure had no zero array
> > construct as was implied by d61491a51f7e . I didnt want to call it out
> > as a bug fix (for -net) because existing code was not harmful but
> > allocated extra memory which this patch gives back.
> > The other instances have a legit need for "flexible array".
> 
> Based on the link provided it seems like the Fixes comes in because
> someone reported compilation issues. But from the thread it seems
> like the problem only appears when sizeof_struct() is modified.
> In which case - you're right, Fixes and Reported-by tags should go.

Gustavo, can you please respin this with an updated commit log and
adjusted tags for netdev to pick up?

-- 
Kees Cook
