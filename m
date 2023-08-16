Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6677E1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbjHPMs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbjHPMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:48:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46126B8;
        Wed, 16 Aug 2023 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GGCu/GRD17jPc3T/ys+sZ+kMnjtC7ErwGI2gheEw0qU=; b=K8687z2pGUf/NoX2Tztey5Skr0
        FuVc/9GciJIND18ICW1H1NqqlTjoNsE+hrNYEfGEgA4nb2QlmaU4WvxBBgUZsFjELCEliU+0LELZd
        gXU0GgnhpvSd67l7DRkKUnj3Nj+0u43vFVHP0Z4xKwZKfkK/4EN+h5hsUQE5ZucLEOy5H7ushWWTv
        8g5vOIOhlieydk4cjwVid6nYgzvahGW+xevf8qp9nCRO58GbFOAeH0y2BPsLvsWfJJ0xk01fUH1sq
        A7GoyamD06qAtkejIW2MgX3faVq2M/ZYcT3OhsoLhu8HBh4Gm00WkPusy80SCQZuUg8/4bb/Q+EBF
        a8sV/5Mg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWFwM-00D0bf-1l;
        Wed, 16 Aug 2023 12:47:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0925D30020C;
        Wed, 16 Aug 2023 14:47:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D730A2C99C213; Wed, 16 Aug 2023 14:47:57 +0200 (CEST)
Date:   Wed, 16 Aug 2023 14:47:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <20230816124757.GB982867@hirez.programming.kicks-ass.net>
References: <20230809131442.25524-1-brgl@bgdev.pl>
 <20230809131442.25524-2-brgl@bgdev.pl>
 <CACRpkdavsv3nJnhtdqW8ANAVfxbgHdM-SpcfOv4p_t-7EOaOHQ@mail.gmail.com>
 <20230815155253.GK212435@hirez.programming.kicks-ass.net>
 <ZNugkmhj1Joygorj@smile.fi.intel.com>
 <20230815203117.GA971582@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815203117.GA971582@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:31:17PM +0200, Peter Zijlstra wrote:

> > Moreover, maybe some macro that can predict the API call from the type of
> > the parameter?
> 
> The whole type inferrence in C is not extensible. That is, you get to
> write a single _Generic() statement, and every case that is included in
> it will work, but the moment you use a new type, one that is not
> included in your giant _Generic() statement, you're out of luck.

Additionally, spinlock_t, does that map to spinlock, spinlock_irq or
spinlock_irqsave ?
