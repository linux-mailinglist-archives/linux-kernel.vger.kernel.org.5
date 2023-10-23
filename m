Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097407D3DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjJWRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjJWRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:31:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8905F2D60;
        Mon, 23 Oct 2023 10:30:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0E0C433C7;
        Mon, 23 Oct 2023 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082258;
        bh=3TVGdnVGcjFnlnGB5RwJ0L+ZqBdcRdweUO0HpE0MTFs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MPUoyZa3Qp5zScMi+2cX7NuMz9mMUZRZJ6YnI8kshNRcjLzGrLVfnxG0zObPo5iBQ
         lhsEJHd4UCNHKEkKR5t46wMvgZPBusQ4wh19yE+52Jk8fW9gShWzRw43upFRILdJmR
         pDhRs2nB5OCFyWJPdEsYy+wdOPNxgAW2WhyxppYEMklYIUKLivoNWrXqkzrMcJTQXJ
         +4zzVbIpqgv0lMDhDMTmuBCtEUJUGgizvdx8IC8ijEH/rgKK3q58y9Xh+N7jcBlW1r
         CZDb6dvQtpg+hKll0ZkyuBfK6n8f67891ab8cOZ8Oqi3/9rsOt4zaaXABP3xsJCM9+
         UsQrWo/p5F23Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: atmel: replace deprecated strncpy with strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019-strncpy-drivers-net-wireless-atmel-atmel-c-v2-1-52e46fbea083@google.com>
References: <20231019-strncpy-drivers-net-wireless-atmel-atmel-c-v2-1-52e46fbea083@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808225560.695306.1625165630823500076.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:30:57 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect priv->firmware_id to be NUL-terminated based on its usage
> with seq_printf() and strlen() in atmel.c:
> 1420 |       seq_printf(m, "%s loaded by host\n", priv->firmware_id);
> ...
> 3884 |       if (strlen(priv->firmware_id) == 0) {
> 
> NUL-padding is not required, which is evident by the usage of a plain
> strcpy():
> 3891 |   strcpy(priv->firmware_id, "atmel_at76c502.bin");
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also replace hard-coded lengths to be `sizeof(...)` for buffers
> that the compiler can detect the size for as this is less error prone.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Failed to apply:

Recorded preimage for 'drivers/net/wireless/atmel/atmel.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: atmel: replace deprecated strncpy with strscpy
Using index info to reconstruct a base tree...
M	drivers/net/wireless/atmel/atmel.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/atmel/atmel.c
CONFLICT (content): Merge conflict in drivers/net/wireless/atmel/atmel.c
Patch failed at 0001 wifi: atmel: replace deprecated strncpy with strscpy

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019-strncpy-drivers-net-wireless-atmel-atmel-c-v2-1-52e46fbea083@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

