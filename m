Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D527D50EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjJXNFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjJXNF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:05:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84F46B0;
        Tue, 24 Oct 2023 06:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E84C433C9;
        Tue, 24 Oct 2023 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698152605;
        bh=I0dSpBX3t5um7hzyjuoG/wfx+Ovwc+XCo8n1ONBIcrk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fCWDTK1pLN1jpUbmC6WIp5dGPFWrtFA/2fMUPsTEV/HEmsmNTS9V3/BcAn2qTSRns
         uhJ7q0HomcAn/lr5Qqoq2zFdJ5VEEa2Al1fdw50QtTHcJVHvQ6Li2my8RaZxtfWR8q
         AQtgXoPZgbKjVnaMoZA56A6ete3Gre2NifTL65x6v/aM7wzz726hATJZ0rD5v1GNne
         HT7SMBriGccFJIRwU7H6uxdJSO1SvQAnTDexTPg16+ANWWpw4Ed5c5VM1Z5DAShu8H
         TxyFIy4QqLx0eoHht5uK4eV8Jis8eta+H6k6aMHFU6MguPn5w5WEmU1VmyK/+RZ5P9
         68Q6N2NfT3WjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
Date:   Tue, 24 Oct 2023 16:03:21 +0300
In-Reply-To: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
        (Justin Stitt's message of "Fri, 13 Oct 2023 20:33:48 +0000")
Message-ID: <87wmvcxjdy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> writes:

> strncpy() is deprecated [1] and we should prefer less ambiguous
> interfaces.
>
> In this case, arvif->u.ap.ssid has its length maintained by
> arvif->u.ap.ssid_len which indicates it may not need to be
> NUL-terminated, although by virtue of using strtomem_pad (with NUL-byte
> pad character) and having a destination size larger than the source,
> ssid will, incidentally, be NUL-terminated here.
>
> As strtomem_pad() docs say:
>  * @dest: Pointer of destination character array (marked as __nonstring)
>  * @src: Pointer to NUL-terminated string
>  * @pad: Padding character to fill any remaining bytes of @dest after copy
>  *
>  * This is a replacement for strncpy() uses where the destination is not
>  * a NUL-terminated string, but with bounds checking on the source size, and
>  * an explicit padding character. If padding is not required, use strtomem().
>
> Let's also mark ath10k_vif.u.ap.ssid as __nonstring.
>
> It is unclear to me whether padding is strictly necessary. Perhaps we
> should opt for just strtomem() -- padding certainly doesn't hurt,
> though.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/ath/ath10k/core.h | 2 +-
>  drivers/net/wireless/ath/ath10k/mac.c  | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 4b5239de4018..ba9795a8378a 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -607,7 +607,7 @@ struct ath10k_vif {
>  			u8 tim_bitmap[64];
>  			u8 tim_len;
>  			u32 ssid_len;
> -			u8 ssid[IEEE80211_MAX_SSID_LEN];
> +			u8 ssid[IEEE80211_MAX_SSID_LEN] __nonstring;
>  			bool hidden_ssid;
>  			/* P2P_IE with NoA attribute for P2P_GO case */
>  			u32 noa_len;
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 03e7bc5b6c0b..7daa007bd8b3 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -6125,8 +6125,7 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
>  
>  		if (ieee80211_vif_is_mesh(vif)) {
>  			/* mesh doesn't use SSID but firmware needs it */
> -			strncpy(arvif->u.ap.ssid, "mesh",
> -				sizeof(arvif->u.ap.ssid));
> +			strtomem_pad(arvif->u.ap.ssid, "mesh", '\0');
>  			arvif->u.ap.ssid_len = 4;
>  		}
>  	}

Using NUL-termination with SSID makes me always cringe as back in the
day we had so many bad implementations which didn't use SSID with
specific length parameter. The firmware should only check for ssid_len
(though I didn't check) so I find confusing that here we are suddenly
NUL-terminating it.

What about using just memcpy() to make it clear it's not really a proper
string:

arvif->u.ap.ssid_len = 4;
memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
