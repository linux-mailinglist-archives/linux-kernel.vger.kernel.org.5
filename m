Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6E777789
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjHJLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHJLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:52:05 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222EC91
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:52:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7251C40E0140;
        Thu, 10 Aug 2023 11:52:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 13SIfGwS_Vfh; Thu, 10 Aug 2023 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691668320; bh=hU/esJ6axzb50m9NoUBoNbAP8V3PR3dqISql0OaVNFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgLCbc2y9/VPQj8Mm7ZpOEWTtiGzDXpuv7zxpUviHPiBr79XBbxyWhXiutQogBJY+
         5TkILS56Y8dwD0NmbCQB+UrzCXvH4LFnpPAcM7qXdHjKhpOuDH8d2QKLYdGvRvcjoH
         TiVQ4kYdZwBAuznIiwbqq/IzAhSqJwGd725UP+qkNJeW4KZI7+R0C5zoKV66cYbJOp
         k0SFGuj5vn88VrPXqsRpUtJQmmX/Ki0KdgiyWaX5LU6qNc6AqSAPu5vHLSJKKlC+Bw
         cfQl9JJMN8vJBfy608Q3ZXoXHBVKnXf/12gjQRw5R8l5xQyaZNORsag/9eHCMtAWEa
         dkmsydhJ8NNn71CJuppbCKK35k0l99CG3hANCq7RVwKJ8SHzsT0RJ/Zy+qie8vgo4N
         SUXIgeOXGpV0mLJfQJFGK2WMgnTVai8HGg7zR7Nmfr6kFbmADAXeAd7Pq0PhqLjzrD
         PUY0oCoweU8FE1AnnHMP442ZC4KkeyjQ1RYV6I1bn8qZrKNPwYMHDU4QDNqsY1/K8J
         FAwqN9mn8ujxmR5pIO+5wyrhjsHvEYs7hz6pEXfiwkuFbgR4Hd76mJz7v0c0cvqlJe
         K2zBdSAoB9x5wAaYim/DH8zGoryqS7iGVUv4m5yqXjcOGhOifDmQI9CXlIwZvPLS3q
         znFOtsg9XQ3s9DRsGx7dhanY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58CC640E01A1;
        Thu, 10 Aug 2023 11:51:53 +0000 (UTC)
Date:   Thu, 10 Aug 2023 13:51:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.543939260@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:20AM +0200, Peter Zijlstra wrote:
> Where Zen1/2 flush the BTB using the instruction decoder trick
> (test,movabs) Zen3/4 use instruction aliasing. SRSO adds RSB (RAP in

BTB aliasing.

> AMD speak) stuffing to force a return mis-predict.

No it doesn't. It causes BTB aliasing which evicts any potentially
poisoned entries.

> That is; the AMD retbleed is a form of Speculative-Type-Confusion
> where the branch predictor is trained to use the BTB to predict the
> RET address, while AMD inception/SRSO is a form of
> Speculative-Type-Confusion where another instruction is trained to be
> treated like a CALL instruction and poison the RSB (RAP).

Nope, Andy explained it already in the 0th message.

> Pick one of three options at boot.

Yes, provided microarchitecturally that works, I'm all for removing the
__ret alternative.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
