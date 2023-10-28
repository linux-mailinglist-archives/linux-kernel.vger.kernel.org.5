Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268497DA6A4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJ1LGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjJ1LGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:06:31 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC960C0;
        Sat, 28 Oct 2023 04:06:28 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F82140E0171;
        Sat, 28 Oct 2023 11:06:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kPqXeTtDDo9z; Sat, 28 Oct 2023 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698491183; bh=EHjBb96lcMnmWWDcbNaD4wXBmqS+NphkqDuHPnHecec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtY4ftls8QE2bTI6UlkII5vgHpZDr946Z5wLzVI4b+EqGpZX0QOrAdqXl6GuXlsoR
         xYA9/F6VbaKNNhUnuKA1aI6JSePqlZrm5v9k5xoGAm40uKreUPU6WM4VTxT5Ee2nz2
         hFmaeo0wKpYxzoE1o3/beUTixBnskz0v+rbE6cbUAsmVFWouQ3bEykTm3MXuxGFBVG
         iLyHGhsQMDgS9oJ+LQ6B38Hj6iGJMM/s5LiDescjhj0kn1F+ChxNjskhu4jKjtbDnl
         oDoAtjt6/vvF8qPRU/NgZ7ctWREEX+OcHY3U44MbzFxDHX/0MW8I2RIVsQElTIqLju
         zljXPpWDJS3fRMGSkFA8MBxCpJuji8yaWvRuwHR3fByzDda2UmesgxA8DAwc0fck7J
         /9rs62sWTn6AsGQ4914uT3dHZP2j+KLbNCDyf2P8wtvev2Ibn1hrnP9g5GcOr6l7f8
         MUAYbyh0JNdr7HaREza30ZChjyVNUAI+cBWa5zFWPxsjuLgOoEqfvCa/pj/BHkXJNW
         CYJuySDFXF3Pk1grJBBoxYWgfTqA0aIOtfTqi5fE2Pka6Jv5Z0S0X5xElWXqG6bCPY
         M6en9OhQ8CAntqGN9GEorQrtCV8JovYdU6uBIHc5Wl899IK+vuILYrFLVh2ugmzfIk
         72ZKBG9OsUn4VrOTbzVR0Fis=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F7E640E018F;
        Sat, 28 Oct 2023 11:06:10 +0000 (UTC)
Date:   Sat, 28 Oct 2023 13:06:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeshua Smith <jeshuas@nvidia.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH V3] ACPI: APEI: Use ERST timeout for slow devices
Message-ID: <20231028110604.GCZTzrHKnsDB+Dmljr@fat_crate.local>
References: <20231027223309.22883-1-jeshuas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027223309.22883-1-jeshuas@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:33:09PM +0000, Jeshua Smith wrote:
> Slow devices such as flash may not meet the default 1ms timeout value,
> so use the ERST max execution time value as the timeout if it is larger
> and if the ERST has the "slow" attribute set.
> 
> Example:
> A NOR flash spec lists "Page program time (256 bytes)" as 120us typical,
> and 1800us max. A 32KB error log would be (32K/256) = 128 nor-flash
> pages. Writing those 128 nor-flash pages would then take
> 120us * 128 = 15ms typical, or 1800us * 128 = 230.4ms max.
> 
> Without this change, when pstore calls APEI's ERST code to write a 32KB
> error log to the NOR flash in the example, the code will flag a timeout
> after 1ms and return an error to pstore. With this change, unless the
> max time value from the ERST table is exceeded, the code will not flag a
> timeout and will return success to pstore after the operation completes.
> 
> Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
> ---

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
