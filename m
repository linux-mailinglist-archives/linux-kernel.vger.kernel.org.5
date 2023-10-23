Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93267D3DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJWRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJWRa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7B1FE7;
        Mon, 23 Oct 2023 10:29:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCFEC433C8;
        Mon, 23 Oct 2023 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082173;
        bh=TFyddzODnA71wlttcWczDl2ULr/aiDXiJcRsmEttaXE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FR4CDg9m+SAmdKCzpr0yZ9kRTMHdtjdTtTLzAcWdAH2yo8eedoUNIFEorpJTshynG
         +YIHrRJaVeB96pyOq7vW2AX/P/YINun0pPUCFpCCio2CmrzoPavpNxejtI70mgOJ/5
         vVFQGjBFuDNHix5xbmPTuwhcJ5KoMpeX40B4+FlKw/nvvY+i2I6+rZyuWuMWPUi3pf
         5GXWapp8Py6yGmz/5vSyzP5pBPr0jVD8vtoT9tMu3OtsIqDm927tLF0BaKBi82fKDc
         c+IlEQDp6L/d55EOUO6VSwaas0pX/MYgeRVpkLcDJrjhH+MuHvT6gEKZRbmDORnX3O
         DtF8zDpM4/ZXQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: wlcore: boot: replace deprecated strncpy with strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
References: <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808217070.695306.9829944196418700359.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:29:32 +0000 (UTC)
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
> We expect wl->chip.fw_ver_str to be NUL-terminated based on its usage
> with DRIVER_STATE_PRINT_STR() in debugfs.c:
> 491 | DRIVER_STATE_PRINT_STR(chip.fw_ver_str);
> ... which uses DRIVER_STATE_PRINT():
> 444 | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ... which relies on scnprintf:
> 434 | #define DRIVER_STATE_PRINT(x, fmt)   \
> 435 | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> 436 | 			  #x " = " fmt "\n", wl->x))
> 
> Moreover, NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com/
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

75fdaa28f103 wifi: wlcore: boot: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

