Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076F7CB119
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJPRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:10:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8914C10F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:10:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1934279b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697476237; x=1698081037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEgoT4wnSbfKqiobyL8tOMupICht6HOuE8CfHQmqQMc=;
        b=SrfgRR6OB9ruKuwnVYsao2wZlIXJFg/DSCUoRUaquXHEkBswrOqYrQloMFry2vhlej
         bMREr3gJqUNAz+aChbiEJ/Ybg+SkoZ2RQkKHzpQsDPgDImjWfIRDjcTquCB+w+nW19ne
         G2CY6rurvfMGgYIR/bETjRLrDtVmN9/EwUPwOeJyjHpvLrP+c7eq+JPAXEGvmFtREa3x
         ElnVAoEgXi5dIrJqc8tZ2iD3EClw1C8coQeLr3lCZOXeZR80bhUPihXs8fZOZhq66/J8
         IA2gXeTwur3/RSiH0rSD+LvJ6HpcQcDrOgM5bPA0+5HiS/qCGCoEQAwi9/nU0pJsFwrC
         URRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476237; x=1698081037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEgoT4wnSbfKqiobyL8tOMupICht6HOuE8CfHQmqQMc=;
        b=th7Fj09E+/r9oZ0MvMuVOaRgl20i5ADFdm7f86FMQLA08b6GyHhiMr6XU8l9TsyEm2
         0hgLyZHRX0aNswIV3v/WGwkWaXd2ZKZySItzf+uXjxSiP3b3JuK3hVNm7Xi/ufK3QKlg
         c9mDNfEe7mpfcS/fR/A2P6a9Q+eI5G1T43JfiDtGmX4Fa8BWVQHHbC/sDH6qWpqVZGdL
         tOG9bqMt/f0jofQPYVawlsRtjjBszrhFLvbQD+gwxzB9fPTyeWmSKQXtNThIw85zwEQe
         OrNkHRHMZSQ07BdduOKEqcOMYGkcjM/TphjHSZV1jDvSJYUz3TLrBs6rwRXlcz7c4hEx
         ofGA==
X-Gm-Message-State: AOJu0Yx+cUjVjAZ4H4YwGRq+dbfaNOJF45GNa9S6i38nyZcWvXlnZ7hM
        m545hhpnY8BMKdwPEWpDz8hYtw==
X-Google-Smtp-Source: AGHT+IGguDhVITJIvhBzWf+6Op1xFKO1SJ/TmEkeSW6nK5Opr8475dRlcc4zfVYS/Ev4Bc6d7YnIDA==
X-Received: by 2002:a05:6a20:6a03:b0:15a:6733:24e2 with SMTP id p3-20020a056a206a0300b0015a673324e2mr12179788pzk.25.1697476236976;
        Mon, 16 Oct 2023 10:10:36 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:619d:5ad3:44b1:eec4])
        by smtp.gmail.com with ESMTPSA id k64-20020a632443000000b0057c44503835sm5910283pgk.65.2023.10.16.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:10:36 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:10:33 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZS1uiXORq2IRPnId@x1>
References: <20230912072232.2455-1-jszhang@kernel.org>
 <20230912-trailing-pampered-52738ec6f009@spud>
 <ZQHSLdPufI6CXApg@xhacker>
 <20230913-faster-spotted-9df41a0d7787@spud>
 <20230920-pesky-stalemate-88f5036b8084@wendy>
 <ZQwL6fxi6IkUEIMc@xhacker>
 <20230921-4a1fe80384e083c67f38dc27@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-4a1fe80384e083c67f38dc27@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:08:28AM +0100, Conor Dooley wrote:
> On Thu, Sep 21, 2023 at 05:24:57PM +0800, Jisheng Zhang wrote:
> > On Wed, Sep 20, 2023 at 09:36:19AM +0100, Conor Dooley wrote:
> > > Hey Jisheng,
> > > 
> > > On Wed, Sep 13, 2023 at 04:44:18PM +0100, Conor Dooley wrote:
> > > > On Wed, Sep 13, 2023 at 11:15:57PM +0800, Jisheng Zhang wrote:
> > > > > On Tue, Sep 12, 2023 at 05:27:31PM +0100, Conor Dooley wrote:
> > > > > > On Tue, Sep 12, 2023 at 03:22:32PM +0800, Jisheng Zhang wrote:
> > > > > > > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > > > > > > dma coherent, so set dma-noncoherent to reflect this fact.
> > > > > > > 
> > > > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > > > Tested-by: Drew Fustini <dfustini@baylibre.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > Since v1:
> > > > > > >  - rebase on v6.6-rc1
> > > > > > >  - collect Tested-by tag
> > > > > > 
> > > > > > Does this mean you're expecting me to take this?
> > > > > 
> > > > > Hi Conor,
> > > > > 
> > > > > I think I will take this and send PR to soc people. The reason
> > > > > I send v2 is the rebasing on new rc1 and v1 wasn't in linux-riscv
> > > > > mailist due to typo;
> > > > 
> > > > Great, thanks. Please ask SFR to add your tree to linux-next.
> > 
> > Hi Conor,
> > 
> > I'm not sure how to do this. When MAINTAINERS patch is merged, send
> > an email to Stephen Rothwell, are these steps correct?
> 
> Sorta, yeah. You don't need to have the MAINTAINERS patch merged first
> though, just send him a link to your tree and the branch name(s) & he
> will include it in linux-next.
> 
> > > I lost my main x86 box over the weekend (looks like probably a dead
> > > motherboard), so I may have missed a response to this.
> > > 
> > > Did you see this email? Additionally, can you add that git tree to the
> > > maintainers entry for the thead devicetrees?
> > 
> > I just created a tree in
> > git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux.git
> > 
> > But it needs time for cgit to take place. I will send a patch
> > once it appears.
> 
> Looks to be there for me now. Thanks for doing this!

Hi Jisheng, I'm writing the cover letter for v2 of my th1520 mmc series
and I am wondering if this dma-noncoherent patch is in any tree yet?

Thanks,
Drew
