Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF07E1998
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjKFFQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:16:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C60100;
        Sun,  5 Nov 2023 21:16:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27e0c1222d1so2944747a91.0;
        Sun, 05 Nov 2023 21:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699247798; x=1699852598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMahlO8uhra1dh8HKnzq7Y9z6mUAC2Qeqp72jyzvlME=;
        b=f3q4H7CgUt1A9HlGRb3LIq4ipQMQDd6z4XYGwl1jhr/QvlSmMhDLRdpILKuYEesSq4
         a2k9LfYxcL9vWZrapPpR1fZXQ/wq8WPgcJG4axWv/oZPI+SVqZC3ZCpEACv5KP1rutPq
         yXEQcT25na9DU+556iNrLNFh3ElebKGwKbC9+Im28lLR1o4uU56fFqt6+XZxDJQn/qaI
         UNqRB8EPOJuhABEgTeMCKffJbPZLvMbJ7mtTmqgpCbST+jQjTrnZEZczExHAWv7JGJee
         hG6XI+R21unVoKBSxOFMcH/8dgX5CmdRP7E50Mis5k4lTV3eyumPuGk4DjlShHdaZw5y
         2oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699247798; x=1699852598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMahlO8uhra1dh8HKnzq7Y9z6mUAC2Qeqp72jyzvlME=;
        b=lCqIjTFGcAV1t+VSRMSrUVMhua5TN5HHHgT9EGhn7871EFGnx433xQBU2k4wntLISL
         lzlFBL9JRhcn0dgTMb9GEhxKQGlj77dhNUvIWKSnQ/bEE/RPyT2cYFAZzLEtFkej6Bwj
         uTDwXYwdiZDakbh4W+4XpEe+ovymY0EjDyGS6h6AfnT84rKs4iiX2TP/8gAyx4HObRfW
         ZzpIhrtpBeAr7YZ0OgHqniDrQN3KSZ8WoUy+m9D4dXHA7L7pFrK017ZHur7ss4cv/j3h
         Dgw+nPefdYCpjpZWIDn+6RXdtsBjIaHRoJmTfRb7a//lhPjCR1Toi9qB5GQl+xV6eBAN
         MznA==
X-Gm-Message-State: AOJu0YzB3oOPPX/d/6du3KwWSdYUOvQ0HUII42PMxhmEv5wOGuMyfjVq
        IkXIlcb959m+w4EI6dcpaTs3B9dY4nXR7vUxnGFibAbzCOcEQb03Rks=
X-Google-Smtp-Source: AGHT+IEV2oMfUMpM+20+iumvFq8XgD3hQAuTI75T8uyMImuaXofB4yMbSC3qCrXmKFZtTmwkOPiydu3XW7QjqZpn9mY=
X-Received: by 2002:a17:90b:100b:b0:27f:fcc8:9196 with SMTP id
 gm11-20020a17090b100b00b0027ffcc89196mr24029499pjb.32.1699247798133; Sun, 05
 Nov 2023 21:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20231106043957.815407-1-zyytlz.wz@163.com>
In-Reply-To: <20231106043957.815407-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 6 Nov 2023 13:16:26 +0800
Message-ID: <CAJedcCxoDVS-7jVwLvsWOWiv0aObyYBiG-GmqX4bq+Qp+i3iTw@mail.gmail.com>
Subject: Re: [PATCH v3] brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        johannes.berg@intel.com, marcan@marcan.st,
        linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
        linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the candidate patch of CVE-2023-47233 :
https://nvd.nist.gov/vuln/detail/CVE-2023-47233

Appreciate the review and suggestions.

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=80 12:42=E5=86=99=E9=81=93=EF=BC=9A
>
> In brcm80211 driver,it starts with the following invoking chain
> to start init a timeout worker:
>
> ->brcmf_usb_probe
>   ->brcmf_usb_probe_cb
>     ->brcmf_attach
>       ->brcmf_bus_started
>         ->brcmf_cfg80211_attach
>           ->wl_init_priv
>             ->brcmf_init_escan
>               ->INIT_WORK(&cfg->escan_timeout_work,
>                   brcmf_cfg80211_escan_timeout_worker);
>
> If we disconnect the USB by hotplug, it will call
> brcmf_usb_disconnect to make cleanup. The invoking chain is :
>
> brcmf_usb_disconnect
>   ->brcmf_usb_disconnect_cb
>     ->brcmf_detach
>       ->brcmf_cfg80211_detach
>         ->kfree(cfg);
>
> While the timeout woker may still be running. This will cause
> a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.
>
> Fix it by deleting the timer and canceling the worker in
> brcmf_cfg80211_detach.
>
> Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Cc: stable@vger.kernel.org
> ---
> v3:
> - rename the subject as Johannes suggested
> v2:
> - fix the error of kernel test bot reported
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 667462369a32..646ec8bdf512 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -8431,6 +8431,9 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_in=
fo *cfg)
>         if (!cfg)
>                 return;
>
> +       if (timer_pending(&cfg->escan_timeout))
> +               del_timer_sync(&cfg->escan_timeout);
> +       cancel_work_sync(&cfg->escan_timeout_work);
>         brcmf_pno_detach(cfg);
>         brcmf_btcoex_detach(cfg);
>         wiphy_unregister(cfg->wiphy);
> --
> 2.25.1
>
