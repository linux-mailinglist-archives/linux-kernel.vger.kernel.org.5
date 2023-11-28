Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF917FB65E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbjK1Jx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjK1Jxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:53:55 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A164109;
        Tue, 28 Nov 2023 01:54:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8A4C40E01B1;
        Tue, 28 Nov 2023 09:53:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bH8nQNUDPbpB; Tue, 28 Nov 2023 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701165236; bh=aoMnhTr7jFd65n5Bx4KqYKvZ0RjDqIT+i/qp/fJf9sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDs4/28UNi7ssKZUpSxEQAK1JKNEFUDteBwUljeJdP1EjxfBr73XRShv17qhnE29j
         Nf09IzxD+prQAm/Q4rOhBt85lPfBZiCTMRhQ9NoX5QIPwbFEix/+iBCG5+vxIOX98q
         /NHeUoHAO18Of1mgtQH8/PuVEmf5Fb+rl0mDobbU5qiD7ptINcz2Eq73gPYwBCpH9C
         qA9uASBrO9JaCtJT5E7ahhCs1Xie3EWLOLbdfWofmx5MGdX4g6Xwo2IHyGDRyw/So1
         8UVeLkmc2VUZvqwlkbkNpjOoqkVxGhEcW7dgbGQtUoU+BaSRpcTEyZyFn58R0xAI7G
         AjTaLWdZXbOi0lvAQE79lhCDmmqS+oLctYcxTJ82oWH0j5RPue1TUtCPisLSB3xEJZ
         cMLZz3hOt6Np+xbUrFWqu3iZjOSrlFaxohNLV4uoAuto/1l8eJGgz9lFzdRTj+OdAT
         FOHxijYdEySTKyj/1+Q/EKl3+WvDTXVazCchOy4n78gFYKZe8SiP7bmrdyIhdRcItk
         DWXt4pwBXpMxosc56Zeo1QiMHBq5iDNcisNfkHf0Dk57xnhOlBt9kvuONbMGmiJ0RW
         CEkO7XTK28htgUb78Jk8jfxji1wVzlYL7VOje+gqe5m1pSejuzet3rgDYLIblYpcfH
         fFzIm7U20KE3ud/SyQRiGiIs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9763840E0195;
        Tue, 28 Nov 2023 09:53:34 +0000 (UTC)
Date:   Tue, 28 Nov 2023 10:53:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
        jgross@suse.com, ravi.v.shankar@intel.com, mhiramat@kernel.org,
        andrew.cooper3@citrix.com, jiangshanlai@gmail.com,
        nik.borisov@suse.com
Subject: Re: [PATCH v12 20/37] x86/fred: Disallow the swapgs instruction when
 FRED is enabled
Message-ID: <20231128095329.GQZWW4mTdTdmhZ+wS4@fat_crate.local>
References: <20231003062458.23552-1-xin3.li@intel.com>
 <20231003062458.23552-21-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003062458.23552-21-xin3.li@intel.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:24:41PM -0700, Xin Li wrote:
> +	 * Note, LKGS loads the GS base address into the IA32_KERNEL_GS_BASE
> +	 * MSR instead of the GS segment=E2=80=99s descriptor cache. As such,=
 the

:verify_diff: WARNING: Unicode char [=E2=80=99] (0x8217 in line: +     * =
MSR instead of the GS segment=E2=80=99s descriptor cache. As such, the

Just do a normal ' - char number 0x27.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
