Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA37B02B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjI0LXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0LXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:23:15 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD2191
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:23:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3145640E00B3;
        Wed, 27 Sep 2023 11:23:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kdq3_a9w6O7y; Wed, 27 Sep 2023 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695813789; bh=ofsmmPNFy6EboOyiw5xz1YMtuU/h68iR+Yan+kT1ktk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDHHkbDwedrqNxyXIee2lOdxWCefp/+RtFbABKvewSV84KhKEXbaFN9ToJ/QBGjrb
         X4gGogTpl8CKsrAd+BJuFGUTKC0FrUtN7OJYl7+QsIYg9FWNdzW11iDkZvYGxlKO3+
         OgOkbLxTiktQmDvWnY7E9oYZWZxDEJBjNKm1pcPwwHA1cABHPVRKipCkQaAE8mKDB7
         M//UnHAPYYvDFeHT30IwnnKdwcCnejnuhdt4FddigIlRj4wHYKeoNQo0nt63+50wSn
         tQ20CaB35D+/Y3Rm1S/mAciFC8q7NMSAd334uJEdikyR3nXwEZWsC/59akxrAvgj8U
         8I1e0K+EGanj7y7tqk+2ymP5BaFSPS0iSrMTF0o8+OSlfj9zOQShGmafwXrof2iv+F
         2j94ObnNreaoltPkGX1lYpGNFrITu+p1lXdwU2lPhhkc/zoGZLrEtrYnPn5MtYf9Xq
         t/mBeqjamwRRfQW1YYV22WLmK1nlOeP7g0DxBv3kfu8n21bo7VyzxIspV/3tyLToT8
         S5+JT27xrhkaYhg2NxPvrzF6t8uzZAsmk+dti773ChtGInBQdJi8I49gYlCAzd+qyk
         Pq3YADTa9M3d9JHq0+TvJXpemCtasO+TMHPyZOd5TrOicMidnhWd6HJ3IiSIcqXc+/
         cjHVV4pIeVuM0kzHwwgDJhUc=
Received: from nazgul.tnic (unknown [2.247.249.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8694E40E01AE;
        Wed, 27 Sep 2023 11:23:03 +0000 (UTC)
Date:   Wed, 27 Sep 2023 13:22:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <20230927112259.GAZRQQk78aJN85ULm1@fat_crate.local>
References: <20230926040526.957240-1-aik@amd.com>
 <ZRP6cd6rEymUaiL+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRP6cd6rEymUaiL+@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:48:33AM +0200, Ingo Molnar wrote:
> Not sure how this was supposed to work - there's no 'ghcb' passed in to
> snp_cpuid_postprocess(). Does this patch have a dependency perhaps, that
> I missed?

Yes, it is explained above the diffstat. I'll take care of it when I get back.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
