Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FC7B1B66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjI1Lrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjI1Lrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:47:51 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88422122
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:47:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 53CC540E01AE;
        Thu, 28 Sep 2023 11:47:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dFpUkaN31vNv; Thu, 28 Sep 2023 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695901663; bh=GD8sQRiGfznYgyokYz6mYypmrdkYeCX92OoBRtvmk1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq9bJ8TOEgUSwHQVW6USp++ya+9LFjbrMudK4g/mo8v/UXGSxhblINxdXPafWMeTP
         Om/AE3+ZBRPcf2Dl57kaNbCnZrgB8InJ1JUm9nz3z3jZiaklatNjnbgb/wMP7NIvIR
         s6P3OW6KTcpDTqyo3wKm5pHGjk6eqC2zyFSRJ8HbVuL7+9eD18aK4KpyamdZW35M/b
         7o0vtLBrCK+pTV0FWYAHo7hWgQILsz+VazIQK7Ta+qCj51hp61H9IOIz47qMy0zRcJ
         h51qpkcE3yalLNmkza0NxVVcG0eRgbK2aouIVjvIXqrq2fRUuEwcuvzNIV5cP+YB7I
         XDsE98MeGdRVvneIrYJ1oZkEdSFqbgcYXmEcVfp0s+rrg90ZH4qWqinErsWCAC76Oh
         UpGxw/SEhS4B2ZGZXxgu3aWN2Kz2OlynlfmCqaEXCCCCWa/ZiuSz0TG7R9n6YEjwD6
         78XSnA62q7P3coTepDH36DhXWryv9ieWmu1LpYqeY42ogVtHvmj+pmCbUOfyq6SwVq
         sSyc7pr+bwA6tvWWR2XQOpLFctmUrfpBEcmnTmIYGvCamJQhRr6WELRhMEYvVLT7Yh
         jtmzjSfGm3AUgpj55UKZ/VSLSo4WjfDCLrtECFWGIyjuTreOm4HlWQ/70hSkufw2kj
         8ZYXs3OS2EgOZMf8PvfZ6EFE=
Received: from nazgul.tnic (unknown [2.247.242.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E74CC40E0176;
        Thu, 28 Sep 2023 11:47:36 +0000 (UTC)
Date:   Thu, 28 Sep 2023 13:47:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 29/30] x86/microcode: Prepare for minimal revision
 check
Message-ID: <20230928114733.GAZRVn1R4wvnS6AXIW@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.568284573@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.568284573@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:30AM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -46,6 +46,9 @@
>  static struct microcode_ops	*microcode_ops;
>  static bool dis_ucode_ldr = true;
>  
> +bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
> +module_param(force_minrev, bool, S_IRUSR | S_IWUSR);

Yeah, it's not a module anymore.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
