Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1A7D3E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjJWRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjJWRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:31:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D48268A;
        Mon, 23 Oct 2023 10:30:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E09CC433C8;
        Mon, 23 Oct 2023 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082208;
        bh=deh2wsvZ61fWtmEQc1gLXLTEpTjWtn+nTqnym4bzUIU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sgP7r5/n6+Unly72cTqpsqVIhg/a8KatNXbswT9Oy1lXIh5aIgLrwLp4mHBWSbBk/
         ssyjQQKIi01YY2uxf4hIk/vy127Fs+TgKwcD3t26qNQy35hSyA0umSUWJ5GKzFSHbv
         oPO1Ce5t2yVWTPOFiunIPyzaehEwrJAnmCBpH3sHvoRXwUI4/hDX79i7FHh1BU564A
         v7ZlmCW+oO03F1cOYM1DbIqBY7pj+Uj8AInOXZFsNYMpTtjGDjzMCn/sXR9F59ET4G
         /7I/2PmB6Zn0EGu9omG7yShQiQWCkG+oXBTj+ZpTH880Xnz8tOqg3LV/vs67Hp0Z0l
         /eh5a2XgQ/t0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wlcore: main: replace deprecated strncpy with
 strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com>
References: <20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808220419.695306.17268024250828658883.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:30:06 +0000 (UTC)
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
> We expect fw_version strings to be NUL-terminated based on other similar
> assignments:
> 
> wireless/broadcom/brcm80211/brcmsmac/main.c
> 7867:           snprintf(wlc->wiphy->fw_version,
> 7868:                    sizeof(wlc->wiphy->fw_version), "%u.%u", rev, patch);
> 
> wireless/broadcom/b43legacy/main.c
> 1765:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",
> 
> wireless/broadcom/b43/main.c
> 2730:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",
> 
> wireless/intel/iwlwifi/dvm/main.c
> 1465:   snprintf(priv->hw->wiphy->fw_version,
> 1466:            sizeof(priv->hw->wiphy->fw_version),
> 
> wireless/intel/ipw2x00/ipw2100.c
> 5905:   snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
> 
> Based on this, NUL-padding is not required.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

3f791c60cccd wifi: wlcore: main: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

