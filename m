Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15F7AA0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjIUUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjIUUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:49:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1A59C4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Se1dRTlwycZbc9kSpJwmLvgZk2vvUpDv6XHiE4EnDTI=; b=PbuwlmbXbqRR39QfTZssqDsDpe
        oD5hnOA5/0gfVpmZTG3UcdVjoL0TA9j2T4yG50PO7ZSZNz90OBHpdW01zESSvktAULDNpl3Mc/DLv
        9w1SbugAcidKpTnglwW6tdJrgM8wlfr+wG1Z5ItvkwRJWpPChhm/h7sysC4ITFSort/k+GABJ5psE
        Y/Jiu4tTTZvai58L2LPxQn8ynGvi4yR8UrPKrPoyEvsXLtHFiLjOtwFwtz2fztgdJ4KeO72yzumwP
        57R9PsweG5eO8a56XP4XSNYGumvWVFPRDcxsi2eTQGmS8kPFUi0cjKaBC3Ef8LAciw58FpZaIZ1l1
        g9GrMefw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjQ8C-00Fcch-2C;
        Thu, 21 Sep 2023 20:18:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4655B3002F1; Thu, 21 Sep 2023 22:18:37 +0200 (CEST)
Date:   Thu, 21 Sep 2023 22:18:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for
 annotations
Message-ID: <20230921201837.GC39480@noisy.programming.kicks-ass.net>
References: <20230920001728.1439947-1-maskray@google.com>
 <20230921072655.GA14803@noisy.programming.kicks-ass.net>
 <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
 <20230921153537.GG14803@noisy.programming.kicks-ass.net>
 <CAFP8O3K6Lgxe=Res9d2GKipRYdXqzv3wa_0PLtDcyn7g7H=z5w@mail.gmail.com>
 <20230921171900.GB29413@noisy.programming.kicks-ass.net>
 <CAFP8O3JpkWTXnxYxa45uANNMQ34g2VUPnfj7-oWn3oq9egUb-A@mail.gmail.com>
 <20230921192253.GA39480@noisy.programming.kicks-ass.net>
 <CAFP8O3Kmep3zXNk3=s5qpMQ3-TnfEYxeCkLi3e-DTqQc=Fs4TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3Kmep3zXNk3=s5qpMQ3-TnfEYxeCkLi3e-DTqQc=Fs4TQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 01:07:09PM -0700, Fangrui Song wrote:
> On Thu, Sep 21, 2023 at 12:22 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Anyway, thanks for bearing with me.
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks!  I assume that the patch can be picked up without me doing anything :)

Yep, we'll get it sorted. Thanks!
