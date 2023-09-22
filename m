Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874797AB557
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjIVP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjIVP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:59:41 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2283
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:59:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33DD940E01A1;
        Fri, 22 Sep 2023 15:59:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ssducMo90Vo8; Fri, 22 Sep 2023 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695398372; bh=0ZLg4VYlIjwPHr08BBP62mVZAPff7ows6VjlG9/ep48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9iVlr4i7pEoeBPQiYXMZdi2tIIrIbB565/mivAwefVijGxP8BfWV5euKtdnynOgN
         TbL2Hl0mI8EddJcwIb67jNb319Yc4ax+qawBW2UU2AbNPdmeSkAk3uO4OoyJlkA0YP
         0vzMo3iqwDJu1LeCBtSUFCQjXYM0Ana0tobYgdeSNgJa/IF/SmcnuykKm7ED5gzskc
         fzWVaaGzMq+2qRGI3UfUAK/OUM0hRwCz3QEXnZlTeUIuc6oizMtR8nHz/SJyDX5OVr
         COBUK5/tbbUuX4pV8fiWHubKj42A2MvHfs7gwUE23jiF0sMdKcmnD6s8zqL4gqnYuU
         ulp3BxXx13KsXXDmETGD9Vef+3M8arawXx6Y8lSycWqoALDXHFFpQvfe/esnVR7Yvi
         0SREgCntzGTblk53n6b/i2A1Nd8WQBqpe8OldBR4m8r/rGszL8CRDb+tcSDWWzv31D
         4cD1QbJFgwSRlQ1OLKLtBrWl6LLjkoIvF4KB1RfMhTVXH3UHAQLjqd19jyx+9LJmYn
         90Y5aDxcgX3b9jfCL6F3owdmAKq/0jyTnwR/Ya0+smd1XC3RqtmiQuqk8q5Ny+SQvq
         KqxxGKIrFbLhU98P/UZ2p6WmO5lCzFXpBIj6ivY9opOB8mRxTERdHtAE+zwsguexd2
         IFgWBLkxKNaEQ4uFEEyvNnwM=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D875940E0176;
        Fri, 22 Sep 2023 15:59:25 +0000 (UTC)
Date:   Fri, 22 Sep 2023 17:59:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 19/30] x86/microcode: Clarify the late load logic
Message-ID: <20230922155921.GJZQ252T5TbOVCYDc1@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.961705755@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.961705755@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:13AM +0200, Thomas Gleixner wrote:
> +	ret = microcode_ops->request_microcode_fw(0, &microcode_pdev->dev);
> +	if (ret != UCODE_NEW)
> +		return ret == UCODE_NFOUND ? -ENOENT : -EBADFD;

I know this is short but let's make it more boring and readable pls:

	if (ret != UCODE_NEW) {
		if (ret == UCODE_NFOUND)
			return -ENOENT;
		else
			return -EBADFD;
	}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
