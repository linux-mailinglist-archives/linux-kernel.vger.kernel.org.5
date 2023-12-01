Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042A800F9E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjLAQJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:09:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58250194;
        Fri,  1 Dec 2023 08:09:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701446951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKxRp/dNJ+BlEYqlGWZid2nfWI8vIHVdIFhT+RiI/qw=;
        b=PulDj90aXiRlz0KIPhVWwqgHjbNY+GfW1XmvAqmiTU2UUTadptMLOgWxpw0sglnecWPxm2
        h3pQxvz/efyUkT0DzR6Zifyj/teIVv7LRNanyfOBCaopUgzyOdYP3BramvDqzLCaPgyMXH
        G2oUSl2ZtKWMTHxX9On5rvWRR93FCNkui+7QBPmn1fSY/iCGndY24luM31PjHukQxZY+ND
        QsyOE8crYC1sCWSj2foqen7+kQNVXcV4Jw3XBAzPRS3pU5nlDBmFRtVCbC4XYuwCPsNN5g
        EAnr8d8MCcDefPToBuDYeCdDAC+tenJqC5OG0gxx1dEo831rwsbpRsdF8dDGDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701446951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKxRp/dNJ+BlEYqlGWZid2nfWI8vIHVdIFhT+RiI/qw=;
        b=MM+my8yufzTM5emNEOVfJBfSeaclWykJ/U1d2msgD5/TqhIRuKqH2clFiM3a1nH+LeR7kF
        F5zFA8wjF+8cUiDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/21] Initial cleanups for vCPU hotplug
In-Reply-To: <2023120131-leotard-deprecate-4e27@gregkh>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk> <87plzqxiyl.ffs@tglx>
 <2023120131-leotard-deprecate-4e27@gregkh>
Date:   Fri, 01 Dec 2023 17:09:10 +0100
Message-ID: <87jzpxykex.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01 2023 at 12:28, Greg Kroah-Hartman wrote:
> I can take them, will do so this weekend when I catch up on patches on a
> 14+ hour flight...

Thanks a lot!

