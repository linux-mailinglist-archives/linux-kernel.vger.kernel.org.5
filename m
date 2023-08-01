Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147BB76AA0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjHAHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjHAHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:32:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C0110E3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:32:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690875173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJL2tIvckSO24QBSDI7+BH2GdcdF8o4VRSAgm/TNMxI=;
        b=xbuFAx6hNlizmVBSh3bish7bD7+HC3W6ZnHNKA5TmQQmDHH2OMIRzdA7xqBxnyposa3R5r
        G9sUj8CBZOK37Mh/RXrcNBCxCrvfVzF3qG8mK9ywNLGN8TkrvCX0dZc9anzF6B7j4UuZcX
        fQ5eszo+Q9loAQqgSMSOOYbGmLfCead7rea+aYgBtK5hTe5nLxrS7HgXOObw83PFsuRkHP
        w2/xEBtZ5htU+ig4oL4sRg4QWdAbKVIaGvyic4MdA7mgQBXVpdUEYHGCwqlVn+Y6dyGjls
        kKL2HmF6eg+TGAIKtrZRYdBi0W/I3jNBFQRoh43IuOH5HgR3w3tsClXZ+vUdPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690875173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJL2tIvckSO24QBSDI7+BH2GdcdF8o4VRSAgm/TNMxI=;
        b=qr6DSO8XfPCG2ukCXLTyybszZ/bCZbCMdnSj6PSjo1rf+w06TNWVtkK+jKZQbU9HD4n5sx
        1hH4RbuyQN1hQWBA==
To:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
In-Reply-To: <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
 <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com>
Date:   Tue, 01 Aug 2023 09:32:52 +0200
Message-ID: <87o7jrkyjf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01 2023 at 09:08, Juergen Gross wrote:
> On 01.08.23 08:49, Juergen Gross wrote:
>   void __init xen_init_apic(void)
>   {
>          x86_apic_ops.io_apic_read = xen_io_apic_read;
> -       /* On PV guests the APIC CPUID bit is disabled so none of the
> -        * routines end up executing. */
> -       if (!xen_initial_domain())
> -               apic_install_driver(&xen_pv_apic);
> -
>          x86_platform.apic_post_init = xen_apic_check;

I don't think this one is needed.
