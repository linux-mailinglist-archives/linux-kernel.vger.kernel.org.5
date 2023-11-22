Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA697F4713
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjKVMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjKVMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:54:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0AD1AA;
        Wed, 22 Nov 2023 04:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/en2W2qMe4bf5PACMrPIed21n2y033al9A4KjOp1ZRc=; b=JSwHG4187m66WrnPv9kNpkVMPD
        Sym152JF+R5/hBZyAAp1AyC10pEMz4aE2ATrtXnvZgiPiiEY+n6BY7nTHkUjGdvSwVIAbR/6F14bG
        KKqHXdBD4fsKMfGMg8t4egIiJYL0jz8rLBq3jU+eAYBLsnfj/QtdR18nj9JrrTNHLaxPhOiuC4opj
        YvVI+0Kf0QTpQyj5sMzQW7DCQWb/qOiWRjYNAuy+W7llU654ad+poP94iEQKDJCEWIV6O6MDrKc8J
        vd49pv1GmXLttKG4qaa5oREul29VepXM2nXtq09A7BxziDTS88Bo18WrGBSLXO1yCwCb9fMHvX0/N
        MoDpoXiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5mk9-00CJRO-2X;
        Wed, 22 Nov 2023 12:54:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 322BF3005AA; Wed, 22 Nov 2023 13:54:13 +0100 (CET)
Date:   Wed, 22 Nov 2023 13:54:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
        mark.rutland@arm.com
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <20231122125413.GQ4779@noisy.programming.kicks-ass.net>
References: <20231120144642.591358648@infradead.org>
 <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com>
 <20231122111517.GR8262@noisy.programming.kicks-ass.net>
 <20231122124134.GP4779@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122124134.GP4779@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 01:41:34PM +0100, Peter Zijlstra wrote:
> +#ifdef CONFIG_FINEIBT
> +	/*
> +	 * When FineIBT, code in the __cfi_foo() symbols can get executed
> +	 * and hence unwinder needs help.
> +	 */
> +	if (cfi_mode != CFI_FINEIBT)
> +		return;
> +
> +	snprintf(fp->aux->ksym_prefix.name, KSYM_NAME_LEN,
> +		 "__cfi_%s", fp->aux->ksym.name);
> +
> +	prog->aux->ksym_prefix.start = (unsigned long) prog->bpf_func - 16;
> +	prog->aux->ksym_prefix.end   = (unsigned long) prog->bpf_func;
> +
> +	bpf_ksym_add(&fp->aux->ksym_prefix);
> +#endif
>  }

s/prog/fp/ makes compiler happier
