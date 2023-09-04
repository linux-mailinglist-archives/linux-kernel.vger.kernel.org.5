Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB99791D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjIDSuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjIDSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:50:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA43DB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:50:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26fc5a218daso931281a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693853412; x=1694458212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf1kOMDJycx1EhXIXAvvdW5Sk/cZAAEVFAKi6ah34Mc=;
        b=xxZxk0Wjw/ZjPZeVX4MkS6P5K4lR4twGvYaCcte1beOQcjIUhfTademzb88TOZvutm
         h9H1yKmivhsOY/nrj6iT0r5j4c/M9EhZ6G6BTCbrg5KmkXF7vMVITgYXgUJ12jq3fZTI
         ZYxu034iG7IioF8k4L+ZyRRiAPqHljTx3TvabnP/dAzAujcpDi4mcXmGHJeiVpdwKo/4
         M1lIX8fqza8s+cB/aQkxHrVsXu55QVEa4UGNRMH5ZsOtF7RuFejhMpNv5ClPNWk+zN48
         mIcMZdnENK+XLrkH4rXz4+oWinH3ZYmsF5eXQLExOgkny5/Vv9gVsKhzfPSKIt5UOGF+
         9z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853412; x=1694458212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf1kOMDJycx1EhXIXAvvdW5Sk/cZAAEVFAKi6ah34Mc=;
        b=GLSO6R4DakimGiD1B+2hmDQNXWq4ZXANpiF+0SMx6MXSqZciS4H8yeR/bH6OEuHG60
         kG/HIuB3nAmoV5EyISjK6NvZQP3Oqd7e+cOYlckyGppaoXuuuQyD6+aZ0dWSf5vLYNhW
         yLxETN4dpp2/l/7yDZQWT1+Ai4ex6a2H2B70LQL+EBlBWAON/tCvlwlZsueJA78O2wPb
         6/pfbGludjcxtM7pX2PkSrm0ZtUU/4Wc61H9pbh8o1FN2fC+GzpR5JDE8iQ+ULt0v7X+
         19g6w9FWlbeQfMSJsUdk5JwzSLC7tMWsG5DWPa5EnXaEPNWKh6pvJARbGF58uvjHw5N0
         DTew==
X-Gm-Message-State: AOJu0YyHN/t6zVMjbqe8AnYvSIGCqQPZi7ZTRKczPoSOG3vqeoBbU+ZI
        2/yztyH3Jo/i9FbSzG+fwtnm5Q==
X-Google-Smtp-Source: AGHT+IEVP+hJormX1Eur4mwRVG0JSZQfY+VMOFl6HpD2U+AUVAnaRoOKLQ/Bfg+HqlHUGlzs5PLo4g==
X-Received: by 2002:a17:90a:6e0d:b0:26c:f6d2:2694 with SMTP id b13-20020a17090a6e0d00b0026cf6d22694mr8751480pjk.12.1693853411971;
        Mon, 04 Sep 2023 11:50:11 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:e0eb:2a3d:8122:b588])
        by smtp.gmail.com with ESMTPSA id fa24-20020a17090af0d800b00268032f6a64sm9266991pjb.25.2023.09.04.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 11:50:11 -0700 (PDT)
Date:   Mon, 4 Sep 2023 11:50:09 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZPYm4S0GKr/TEtXk@x1>
References: <20230820115353.1962-1-jszhang@kernel.org>
 <ZPUXhe7ogxvaB6Eg@x1>
 <ZPXtl1iWlsYwmixc@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPXtl1iWlsYwmixc@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:45:43PM +0800, Jisheng Zhang wrote:
> On Sun, Sep 03, 2023 at 04:32:21PM -0700, Drew Fustini wrote:
> > On Sun, Aug 20, 2023 at 07:53:53PM +0800, Jisheng Zhang wrote:
> > > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > > dma coherent, so set dma-noncoherent to reflect this fact.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > index 56a73134b49e..58108f0eb3fd 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > @@ -139,6 +139,7 @@ soc {
> > >  		interrupt-parent = <&plic>;
> > >  		#address-cells = <2>;
> > >  		#size-cells = <2>;
> > > +		dma-noncoherent;
> > >  		ranges;
> > >  
> > >  		plic: interrupt-controller@ffd8000000 {
> > > -- 
> > > 2.40.1
> > > 
> > 
> > Tested-by: Drew Fustini <dfustini@baylibre.com>
> > 
> > I tried this on the BeagleV Ahead. They system booted as expected and I
> > did not notice any problems in the boot log.
> > 
> > Are there other patches such as the dwmac series that I should test this
> > with?
> 
> Hmm, this patch is necessary to test dwmac, emmc ;)

Would you be able to share list of patches you are currently using so
that I can apply them all?

Do you have any changes in the device tree that you are using that is
not in mainline?

I added the linux,cma node [1] with compatible "shared-dma-pool" from 
light.dtsi in the thead sdk, but that did not seem to make a difference.

thanks,
drew

[1] https://git.beagleboard.org/beaglev-ahead/kernel/-/blob/master/arch/riscv/boot/dts/thead/light.dtsi#L88
