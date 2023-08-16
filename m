Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0077EB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbjHPVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbjHPVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:18:45 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6F7128
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:18:38 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA7EA40E00F4;
        Wed, 16 Aug 2023 21:18:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3gBbn6fbKb8y; Wed, 16 Aug 2023 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692220713; bh=a5C9F/eySwaMtmiEdx/5UwOJH+63iNr44P4PZinEpK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9vhEPm2I1MTimtz3vHH3FH5TaIWXi9SPrbRtB8eDdEmSs/iTqCwA2FsllHSut5l5
         CKodtmucZLLr0MSERtNAN20oi4d5EXwm3raoPx6TZoAbSMTkJtDXPnr2+JB02rvo74
         oJVtNCrcogd0ggOob3AnH3WoYwMmZNulXK8EhXUVz0y2iICR0tgQod60BYoqebvDpn
         ICqFW5PPPO1rHWUDAtPFqL8EKh8HU6Rrhrtlb9saOd+s6IqHZAQG4RzpujDgPZBw1k
         gr00b4YYEI6ZRW2b3KZyb/Cky//mWZ/3a5Pedjq1AD5tSGkm9AHyjFVfU/byoz8Dky
         Geb0yfARkZEb80t2T9WYHXunzMieK+14SohX/N/Lpb+DemJ9w6yi/0MZjXoDXlzuJv
         AtfOEhe/sUgo4c7XoZCKuwihMmKSDZwnqYcuBra7MYLE2Fkzmpws++Wa6g97c17vZ+
         Kb1X4ZyOri3DDmHjXjATBZwPAeTdUU1+GDPQ7jFx6I6CNhEpWK7FjAGdOx4f0nhUw1
         wloRTesNwYppJeQA37dkyI/2BLEHJjJQybfKyvq6CaVaF6Ssc2MT+5TqLgokBt89/J
         4ClqvJJD7u1JmHESrm42hms0fy+9M9bXeUqJkkl1mzJMiAMC7Y6LGNLw2WeOWZnozU
         LMwKZUb3yyFqtmU2wZjPcEQo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 245A640E0197;
        Wed, 16 Aug 2023 21:18:28 +0000 (UTC)
Date:   Wed, 16 Aug 2023 23:18:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jim Mattson <jmattson@google.com>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Message-ID: <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816201700.589822-1-jmattson@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:17:00PM -0700, Jim Mattson wrote:
> Is there any way to tell that a microcode patch has been loaded on
> only one thread?

Only the example you see in the bugzilla link above.

> And what does this mean for SEV-SNP attestation?

More specifically? The CPUID page or microcode revision?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
