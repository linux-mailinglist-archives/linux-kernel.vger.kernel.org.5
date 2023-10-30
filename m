Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735FD7DBEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjJ3RUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3RUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:20:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63FF8E;
        Mon, 30 Oct 2023 10:20:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3464BC433C8;
        Mon, 30 Oct 2023 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686448;
        bh=J/BDKDmt4ytWYut9+XphDd+OA2xYRaH3LWnmAbLoFQE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Rde9Dv9j3N672wNfHkJUA0SIvXLKmsAIx2651HHsMohDpXIk6yRPthyTABuWJqL7w
         f5Ap7RlKuHXOqxPJmFFyk+TfPHMGPnmRezQAwe6eWsZR0WZ2rOW7e+Hmn2Gr2YRDad
         Q/DAoBJ6qX62/83GIuNVYlNHJx3OpOm5E2PRmI/wd5w1ZSeOd96daq/Drl1bLvIuT5
         VbVMISEFqX6DH1gdc70xHkV4OHXJZgEQknZ/IbYQhemtpNBXaQNvwjqxTyGzrtjn3u
         1KJvTE8ELQVZJDfDOK8NiBz4C/ngUgWlVV0tvfOTRI7Rj7RSMcWMFuvoTr0vNlIyzY
         ro/6w+2ZpJemA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: brcm80211: replace deprecated strncpy with
 strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868644429.1993746.5520695482478737730.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:20:45 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> Let's move away from using strncpy and instead favor a less ambiguous
> and more robust interface.
> 
> For ifp->ndev->name, we expect ifp->ndev->name to be NUL-terminated based
> on its use in format strings within core.c:
> 67 |       char *brcmf_ifname(struct brcmf_if *ifp)
> 68 |       {
> 69 |            if (!ifp)
> 70 |                    return "<if_null>";
> 71 |
> 72 |            if (ifp->ndev)
> 73 |                    return ifp->ndev->name;
> 74 |
> 75 |            return "<if_none>";
> 76 |       }
> ...
> 288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
> 289 |                                              struct net_device *ndev) {
> ...
> 330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
> 331 |                 brcmf_ifname(ifp), head_delta);
> ...
> 336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
> 337 |                brcmf_ifname(ifp));
> 
> For di->name, we expect di->name to be NUL-terminated based on its usage
> with format strings:
> |       brcms_dbg_dma(di->core,
> |                     "%s: DMA64 tx doesn't have AE set\n",
> |                     di->name);
> 
> Looking at its allocation we can see that it is already zero-allocated
> which means NUL-padding is not required:
> |       di = kzalloc(sizeof(struct dma_info), GFP_ATOMIC);
> 
> For wlc->modulecb[i].name, we expect each name in wlc->modulecb to be
> NUL-terminated based on their usage with strcmp():
> |       if (!strcmp(wlc->modulecb[i].name, name) &&
> 
> NUL-padding is not required as wlc is zero-allocated in:
> brcms_c_attach_malloc() ->
> |       wlc = kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);
> 
> For all these cases, a suitable replacement is `strscpy` due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

2 patches applied to wireless-next.git, thanks.

9d0d0a207040 wifi: brcm80211: replace deprecated strncpy with strscpy
a614f9579705 wifi: brcmsmac: replace deprecated strncpy with memcpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

