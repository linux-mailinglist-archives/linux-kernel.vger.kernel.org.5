Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C07805F67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjLEU1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEU1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:27:33 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC3C6;
        Tue,  5 Dec 2023 12:27:40 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F018040E0195;
        Tue,  5 Dec 2023 20:27:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0DbshhlbnEIz; Tue,  5 Dec 2023 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701808056; bh=uA2hJ4fVupdMziiNt0kfklNPGuoMpg4ALqlVG80QktE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4QJXKFl4RtofbKfcrV8Od1c5MXix6a4l7FeCuYf8nvptijcUjjQHMFPuXKoz57/6
         Kyce2V3ri7B+CzbjEB7H7UG0I8aFePTBPyz7/lCaqLLgtx0wsCJXWcDOPXr3kv4Cc6
         CUAByGkaqOQEAj0kqj9/e9FqT86n9DhpVxiuPlGUM56csvruCA1M01J/ul50TpO5hq
         yLSQHnIkH1zb+hWXLrm0zDPkUH2i2m01pjXO5QBqZlwq5AmyFGSsMllztFWXFiKZ7k
         VROTu8ZdnO/IDjk0vkyyxBfoOESwWocsvqqFxCGaCDo+/ddWhcU8NshDBZWBcLS0GV
         UYgD1HyEJzFZayMtWOLkcC/oTEowJKYuh4mwjzpkHfmGwyTBqFykoqsEU173p229IQ
         GFT1I2sJjFYZe+pX/mI0D3FjIldJ/P4h1R9skZ+wDHoL/StmZ4qmqxI1uvwftn+E6k
         rV2acJ5oSIlbQZLdxxJ8a2vUVVTvoSSNw3ftv1AbjpOt0lIz0eXYXaHWcljPl9yv6Z
         P/C+ZqKvo2B9v9Kq4uM4Icgng7geUrNwu3jM/yEBQbJM82WwJXNwklHVt2YqVI2BuX
         6/pIygb17U9sOzs/IqIkyeSQyPLdJ4RlQOlVj9C818BNJ1GMymh1MX1OhySCmD9eD/
         kkI+j0u2Yj92vcJoQF5eGhVM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C412340E014B;
        Tue,  5 Dec 2023 20:27:08 +0000 (UTC)
Date:   Tue, 5 Dec 2023 21:27:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, dave.hansen@linux.intel.co, bp@alien8.d,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        netdev@vger.kernel.org, richardcochran@gmail.com,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
        akaher@vmware.com, jsipek@vmware.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH v2 5/6] drm/vmwgfx: Use vmware_hypercall API
Message-ID: <20231205202703.GIZW+Hl814mKqEDy/m@fat_crate.local>
References: <20231122233058.185601-8-amakhalov@vmware.com>
 <20231201232452.220355-1-amakhalov@vmware.com>
 <20231201232452.220355-6-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201232452.220355-6-amakhalov@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:24:51PM -0800, Alexey Makhalov wrote:
> Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
> Eliminate arch specific code.
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h: implement arm64 variant
> of vmware_hypercall here for now. The move of these functions to
> arch/arm64/include/asm/vmware.h as well as removal of
> drivers/gpu/drm/vmwgfx/vmwgfx_msg_{x86,arm64}.h header files will
> be performed in the follow up patchset.

Same note as for patch 1 - no commit order in git.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
