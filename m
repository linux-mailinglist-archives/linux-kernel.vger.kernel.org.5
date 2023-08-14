Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FC77B6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjHNKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjHNKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:35:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474D612D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ErfS2y8qItlREdXWuNkGttCjb/q6nrNKzOfNpBqoMVU=; b=HQvDh0K4bfWxqdr3y/DiC5L2bO
        5N86af3XF5swSNerZ73e5bKwCE2ChSMtN1t4j6nyunManXmdmreQG8DWPLQY43uO0BZNXVHzE6hL5
        u3oiCy/M09/M1610EIkWgNE3ngfxjFd3PzP3+Jn0drzms1kr8HjPB8YSlP6cRxnaZUhcI2OC7IEsx
        1KxTigAbihGFzC7Vnp9cATkzi9eMNsMNDrgZzbsJuZKIONZAwmbFc/RZK6Of+b6N+ZxvhD4cigm7O
        Z4Phb8wq5/gfEk5NoIfJQ+eF4JOEK8GxyO2b3fxUMMw8FxwzfLuq8lsItMSLn87v6+ure6ImIbGG6
        MWGvObyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVUv1-00AW7h-1x;
        Mon, 14 Aug 2023 10:35:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 395AC30020B;
        Mon, 14 Aug 2023 12:35:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B68920C1700F; Mon, 14 Aug 2023 12:35:27 +0200 (CEST)
Date:   Mon, 14 Aug 2023 12:35:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Message-ID: <20230814103527.GD776869@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.922634286@infradead.org>
 <20230813103657.GCZNiySRVa8TcT7SAW@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813103657.GCZNiySRVa8TcT7SAW@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 12:36:57PM +0200, Borislav Petkov wrote:
> On Wed, Aug 09, 2023 at 09:12:25AM +0200, Peter Zijlstra wrote:
> > With the difference being that UNTRAIN_RET_VM uses
> > X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.
> > 
> > This cures VMEXIT doing potentially unret+IBPB or double IBPB.
> 
> Can't - I have a separate flag for that and I set it only when !IBPB:
> 
>         case SRSO_CMD_IBPB_ON_VMEXIT:
>                 if (IS_ENABLED(CONFIG_CPU_SRSO)) {
>                         if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
>                                 setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
> 

Of course you can, just also set it with regular IBPB :-)
