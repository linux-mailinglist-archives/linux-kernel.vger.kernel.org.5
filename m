Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E0E77826F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHJUy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:54:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A476F26B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tVNc8xtFHD/5MjY48Rsdw7GPmJfCwnCNm1CX1ELPct4=; b=N++tONipnXKWQRJ4+lJlg8Vzy4
        mEgbZ0/3eDZ145YfoFHWOfFJZXUda7P+lu+GTuYqxXQhaQNBSoxNSm6k8A61ynmOrpP9XxU6VfP7G
        UFBfQvsscREDozcZj1ccsxQTBz2QmvX4YwtQfO/lmKJARapwZ8Yv1Brh4Pnw6JXqfuQ1+oYYl9UrQ
        yAxFsP7avCwkstbShp8Nw7dsC8QsTk4XvFaEk8D4ptl+fszoPQKgARBgTHdsDZfScSih18QkCpbI/
        Zt2Dx+cLPBMn0Yw2CuHrlEgOLiYhndNX/WyLuyKheJIxOQwNpMu/WRvw8ledQnp1i+dZahBXy+R1I
        LaSPUXog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUCfs-006kTI-1J;
        Thu, 10 Aug 2023 20:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD47630020B;
        Thu, 10 Aug 2023 22:54:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE9922103B6B4; Thu, 10 Aug 2023 22:54:27 +0200 (CEST)
Date:   Thu, 10 Aug 2023 22:54:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 29/30] x86/microcode: Prepare for minimal revision check
Message-ID: <20230810205427.GG212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.617422055@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810160806.617422055@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:38:09PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Applying microcode late can be fatal for the running kernel when the update
> changes functionality which is in use already in a non-compatible way,
> e.g. by removing a CPUID bit.

This includes all compatibility constraints? Because IIRC we've also had
trouble because a CPUID bit got set. Kernel didn't know about, didn't
manage it, but userspace saw the bit and happily tried to use it.

Ofc I can't remember the exact case :/ but anything that changes the
xsave size/state would obviously cause trouble.

