Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC07DC791
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjJaHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbjJaHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:46:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A61E4;
        Tue, 31 Oct 2023 00:46:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F32C433C7;
        Tue, 31 Oct 2023 07:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698738392;
        bh=g2XziSccx+MTDgQb4k51PyXlsNg5Uj2V1xR5ZbJYWag=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WGcrOe5ObTvGcRZ6pX6hkz+aPhA7kHHm0mt4/hIdYnyiW2UVQ/9FZqh3qiSEr1J7F
         zGxm8fgALAca4sN4K4RV3P367XQeqTSHIYgGYCwB91RArrx76cGmP5dAC1S2rCldW9
         9OtRU/CNsRDOqPUcqb7jwOheo7yDrvhAWQ0wkbpH6l6j7pmQEB4DNaDWa4VbH9xf8w
         OhbK4idB2x5uuiZSnjtu8b0BDBBjlHnO7B8p9isuy5AfUFmFiqmnnX6HOZg3Nc7dmK
         AluiO7zIYnKFcBxAVYHwJk2xMDIOy9Zv1P7UvzeZzWLa76iOoeeLWt14dPsNWBiSAZ
         WZ0IwQibD8GkA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: replace deprecated strncpy with memcpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
References: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169873838825.2137176.1962660661621825377.kvalo@kernel.org>
Date:   Tue, 31 Oct 2023 07:46:30 +0000 (UTC)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated [1] and we should prefer less ambiguous
> interfaces.
> 
> In this case, arvif->u.ap.ssid has its length maintained by
> arvif->u.ap.ssid_len which indicates it may not need to be
> NUL-terminated. Make this explicit with __nonstring and use a plain old
> memcpy.
> 
> This is also consistent with future copies into arvif->u.ap.ssid:
> 
>         if (changed & BSS_CHANGED_SSID &&
>             vif->type == NL80211_IFTYPE_AP) {
>                 arvif->u.ap.ssid_len = vif->cfg.ssid_len;
>                 if (vif->cfg.ssid_len)
>                         memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
>                                vif->cfg.ssid_len);
>                 arvif->u.ap.hidden_ssid = info->hidden_ssid;
>         }
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ac2f43d3d34e wifi: ath10k: replace deprecated strncpy with memcpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

