Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A61764007
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGZTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGZTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:54:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F381FCF;
        Wed, 26 Jul 2023 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ggP5H7w1XXe6Pn8tc5ubVLnfADMh2YM5dZyPh1DYnJM=; b=PqDLDw1H/IErVhXbabxAJAa84v
        UD6UGwGqEjkU3+nOAlA3+4uF4Y5mJM1iIqsncKuw77gGHlWMPp1RRQanxXM3m5BBm0C4d9vzM+yCL
        kdHGThtRV3fbmAqjhsozF8DzPDzVZ33f+M9MNVFUdjm1VZdtwg0/kWuyZD0E09MWjg38EZ4wWuq1a
        fqM5dZpJRrJB4VQneACewPslZNN1DJdJ/ilsBCbMdN9QknzX/VIMkCXzhfdAvZ5BpfOjOLqpLm1RD
        Jd4HxHH2TCc+56JRyLoGqB6/SkH/NgQFgpITylm3E46ko0oHHK6C/yIpdoKhAaB933PXB0LVbRHa8
        R+XGnmYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOkan-005ynR-0I;
        Wed, 26 Jul 2023 19:54:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44A0E30036B;
        Wed, 26 Jul 2023 21:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEA9F2029F9EC; Wed, 26 Jul 2023 11:29:17 +0200 (CEST)
Date:   Wed, 26 Jul 2023 11:29:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-ID: <20230726092917.GB3802077@hirez.programming.kicks-ass.net>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
 <168904025785.116016.12766408611437534723.stgit@devnote2>
 <20230726122317.9058a6bed272835f0c1a3b29@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726122317.9058a6bed272835f0c1a3b29@kernel.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:23:17PM +0900, Masami Hiramatsu wrote:
> On Tue, 11 Jul 2023 10:50:58 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Prohibit probing on the compiler generated CFI typeid checking code
> > because it is used for decoding typeid when CFI error happens.
> > 
> > The compiler generates the following instruction sequence for indirect
> > call checks on x86;
> > 
> >    movl    -<id>, %r10d       ; 6 bytes
> >    addl    -4(%reg), %r10d    ; 4 bytes
> >    je      .Ltmp1             ; 2 bytes
> >    ud2                        ; <- regs->ip
> > 
> > And handle_cfi_failure() decodes these instructions (movl and addl)
> > for the typeid and the target address. Thus if we put a kprobe on
> > those instructions, the decode will fail and report a wrong typeid
> > and target address.
> > 
> > 
> 
> Hi Peter,
> 
> Can I pick this to probes/fixes branch ?

I'll stick them in tip/x86/core, that ok?
