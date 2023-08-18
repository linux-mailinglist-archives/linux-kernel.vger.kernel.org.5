Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C2780766
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358730AbjHRIoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358745AbjHRIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:43:59 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313F3A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:43:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B038640E0195;
        Fri, 18 Aug 2023 08:43:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rEyc5zcPoyfI; Fri, 18 Aug 2023 08:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692348233; bh=RGdSw2x5psnUl2tQhcWFk+YIzPjPxUtHPRgkagkI/6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSOUumU3DRNMMErIJj1q3ToD462qTZK8BellK3sRdyfhSnJJy4uN0eQ0xzOQANk8J
         JNxljC+zFdF9vZ0btlrlbOcawHy9EMQ6V4dMnvOrEW3NRciqkTZsMn+bctEbV/EeDP
         F+g4uKforoLNlTmoDZIas8MQrGCx4GoBmlzTQBDE5KdytBdgikvQmPEnE5FI29xQO/
         88PvUAhzdlW3+ugNUOV5trI6YZI8kK/g82tzktdq5hAIOBcEn6eIeVUagWObQwQ/eq
         cAe+vi90MxSn7Ef4RTkzP1tVNpY2zB3WSULqsSxDi5ublL3LlOAnebnSqO1y77pf6a
         eon+nX/XsiG4gILS7D/ixo/sodYnE1irJe8x+CU0/XhYFZbRqLwvzuCMxGMph1xEce
         BgN4SA1ybDOi3T4PHNxcgs2ll7OkIXy4ApZHRB4x2SGX8qRwGAZS1ikkD6MQsgV0x9
         a3rfx8EyrCfACwfNCdXM13XoQAIPEzybSey6i6uH8NoMYpDIVpdBA9NT+QMo9k/bV/
         QN35lXDO/E+S4xkDeQgflOt3QEk8ECy8oJZ910K6QLpOXxgwfrHcp0d2s3BQxQ/BK3
         W/XvWrbcSwLepU392Fs8/JMOHWeF2Ec4x6KJB9eopknVIp4K97fFzHjO0FJ1NCNAUd
         flbotpoaMT8yJ4c51ximTUVk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BE6940E00B0;
        Fri, 18 Aug 2023 08:43:45 +0000 (UTC)
Date:   Fri, 18 Aug 2023 10:43:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Shier <pshier@google.com>
Cc:     tglx@linutronix.de, Jim Mattson <jmattson@google.com>,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Message-ID: <20230818084339.GAZN8vO+NSwFKgjQg0@fat_crate.local>
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com>
 <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
 <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local>
 <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
 <20230816215854.GWZN1GniMWRL0GnyVh@fat_crate.local>
 <CALMp9eSbdLuUr9ZvHOA5=vvvA58S5j+cePNKxbx1RxEprRMLZQ@mail.gmail.com>
 <20230817154044.GGZN4/fGMRuvFVtPjD@fat_crate.local>
 <CACwOFJSZ=WV1UxcZeCjaKyPk1mQPbra6k+Ax1kyCoRwD0fws4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACwOFJSZ=WV1UxcZeCjaKyPk1mQPbra6k+Ax1kyCoRwD0fws4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:02:21AM -0700, Peter Shier wrote:
> > tglx has some patches which verify what has been successfully loaded where so hopefully we'll
> > be verifying more in that area.
> 
> Are those ready for some early testing?

Yap, I'm sure tglx will be happy if people test and report bugs.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
