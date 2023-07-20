Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAD75AF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGTNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjGTNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:16:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028F269E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1lUx4dPqIzmUvRIIeoBsSJ/oceUFmIU9b7XhudJ2c+8=; b=AOtOAXXXRvzabYI1HO+7lR6Nb/
        zWGsrxxxGJjbaTiZuFYQSisVZ7yMYBBYc3D+WDAYi0zeM2cw1vU57BGshyo5f5PIU5KuwFRhxEoMH
        +Ku+i6za52vIFiChAXcEHVBGr1y5wYEc3i3KgOiDLg3RXq6w324TWvDLYvy4YvL1uITKaQ8Z/mFY5
        1P9yjvrwB1aMMLw1lvLo3Tk8wIC0UX7gP7DEferhcJUc7XdSnDt5t+KzfArD4hKP8hQrKst4crN9M
        Ndr6DWwN827f7ooRUtuZVO/QOFKN9QZIWiNS1q59A7Bm580i0+UwLaT4QE5RkH662BV2BZG8OPTx4
        8IlTerBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMTVp-00FbxV-31;
        Thu, 20 Jul 2023 13:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EFBF30049D;
        Thu, 20 Jul 2023 15:16:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA63129E775E8; Thu, 20 Jul 2023 15:16:08 +0200 (CEST)
Date:   Thu, 20 Jul 2023 15:16:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Message-ID: <20230720131608.GE3569127@hirez.programming.kicks-ass.net>
References: <cover.1689855280.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689855280.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:28:03AM +1200, Kai Huang wrote:

> Kai Huang (11):
>   x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
>   x86/tdx: Skip saving output regs when SEAMCALL fails with
>     VMFailInvalid
>   x86/tdx: Make macros of TDCALLs consistent with the spec
>   x86/tdx: Rename __tdx_module_call() to __tdcall()
>   x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure
>   x86/tdx: Extend TDX_MODULE_CALL to support more TDCALL/SEAMCALL leafs
>   x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
>   x86/tdx: Reimplement __tdx_hypercall() using TDX_MODULE_CALL asm
>   x86/tdx: Remove 'struct tdx_hypercall_args'
>   x86/virt/tdx: Wire up basic SEAMCALL functions
>   x86/virt/tdx: Allow SEAMCALL to handle #UD and #GP

These look ok to me, thanks!

This does not yet re-order the args structure to conform to the hardware
index order as per kvm's requirement, right? That will be part of the
KVM series?
