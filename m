Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEF7D3DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjJWR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJWR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B510F4;
        Mon, 23 Oct 2023 10:28:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BC4C433C8;
        Mon, 23 Oct 2023 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082105;
        bh=TLivfB44UxdfVbE+MzCIog1D5VWcCwPdoKI99i6xnCE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=s5ub6U/UxLnTwuZhn8iz8TW7wK8h0v3A12hCS9WPknjxY4DuOA9IvXI2R5I5YYgO6
         ZVhSNkhpdNaiTdFPFO4scWc4AwhdSZ81hYsVLhun9FBkPQlpfbaiHrbL+mXtBxnh3+
         HWHaby7VO20pqj/Yv8veK8GpEL2tVIinqN8hqzyZYpEyORfqgLb1Y3ZbBnp/P+ER9x
         5Yn8DgXmLkoIAdkiEx1JxqqHRKtnYsYp4XupWlAwYYPYNvTro/wSpc7ww9bgarPX+B
         lKZLw5llMS7nlZq7cBKaY4LFjimipYiuv4vVhxclsRF5NWO/kISm9NfgBsGCKlzHFw
         xbxO4BXKeOaZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wl1251: replace deprecated strncpy with strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wl1251-main-c-v2-1-67b63dfcb1b8@google.com>
References: <20231018-strncpy-drivers-net-wireless-ti-wl1251-main-c-v2-1-67b63dfcb1b8@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808210208.695306.1186396061221375137.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:28:23 +0000 (UTC)
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
> Based on other assignments of similar fw_version fields we can see that
> NUL-termination is required but not NUL-padding:
> ethernet/intel/ixgbe/ixgbe_ethtool.c
> 1111:   strscpy(drvinfo->fw_version, adapter->eeprom_id,
> 1112:           sizeof(drvinfo->fw_version));
> 
> ethernet/intel/igc/igc_ethtool.c
> 147:    scnprintf(adapter->fw_version,
> 148:              sizeof(adapter->fw_version),
> 153:    strscpy(drvinfo->fw_version, adapter->fw_version,
> 154:            sizeof(drvinfo->fw_version));
> 
> wireless/broadcom/brcm80211/brcmfmac/core.c
> 569:    strscpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));
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
> A suitable replacement is `strscpy` due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily
> NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

70bd8e0d01f6 wifi: wl1251: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018-strncpy-drivers-net-wireless-ti-wl1251-main-c-v2-1-67b63dfcb1b8@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

