Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE17BF5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442815AbjJJI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442845AbjJJI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:26:10 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2015109;
        Tue, 10 Oct 2023 01:26:06 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F41E840E01AA;
        Tue, 10 Oct 2023 08:26:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6UecopwC75Tw; Tue, 10 Oct 2023 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696926361; bh=VfF6bIHn7Ne2On4krQEB7gkjarSWe7siPrXrwaTnfaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5SlGSJM7uDBpqZUhY+R+8hw8cqYAJFKqGbcwQwQ+bfDGG1tqjtMnOEYwAOzOoZMn
         rJz0k4mmTewn8qVnWBTK9lSkPte+cR9flNCnOgcmEy2t5np4Mf/7Ne4Dc/9T1iEE8O
         h1we6jd5SP/qT9nxmf30YsTW+xPIScX+mAjrICkjPEVrU27sroCwtlmmnGGgRCjdMc
         1v6xqIqFwa9pCpZYtSRhB3OcXOlZ/JcgNuw0EWV3WLGRVFyGdfyr9A7J1fivHoqurS
         4lmGL9opdviNCn5ksnLKlTU2y2U+XYWCXsRcWDwXBR9L7F4EagpxP1khuJ17GBk3A6
         ecvfIi5g3MEX/jyhIoGToxVe1NQPfkiQdKL4bKTxjGGVVKVuOtRpYxuWJCpriICYf+
         ewebiQ1GFtQ5C6SNBImFZ2YdZL5vrsnsrj2ZoqIdAgRUIsSIHTycQmLkcrnQp0HSRo
         lrAUXS1y7q25+y0+v5OvfPzwI05ZaLEik+c0Y6Teec3mycN6V7W28apo5CYBsi1XnN
         SNL5q/3LDxsKuyTRiy44vUnmwU2jGhA2Oi+Y+D5e9DXyNAkbDK7dkr7L/wNZuQ6rXk
         E4FLAjGwZg+023daxcU8SjCK++KyRFd9j4r4hQnp8zDgiq1k5ztRcpy02/RpLS8Pu5
         JgDS09up0UnyJg09y7q3l5Eg=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1DF940E014B;
        Tue, 10 Oct 2023 08:25:52 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:25:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid
 the capture kernel panic
Message-ID: <20231010082552.GCZSUKkHrtqxHfqol4@fat_crate.local>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
 <ZRsUpM/XtPAE50Rm@gmail.com>
 <5b6bdf6a-760c-4ba3-95ec-2d4482ad9bac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b6bdf6a-760c-4ba3-95ec-2d4482ad9bac@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:56:38AM +0800, Zhiquan Li wrote:
> 3. The solution in this patch overcomes all above drawbacks.  It set the
>    flag just before the production kernel calls panic(), which would not
>    introduce additional overhead in capture kernel or conflict with
>    other hwpoision-related code in production kernel.  Furthermore, it
>    leverages the already existing mechanisms to fix the issue as much as
>    possible, the code changes are also lightweight.

And the kdump kernel reads the page poison flags and so it avoids
copying them?

More comments as a reply to the patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
