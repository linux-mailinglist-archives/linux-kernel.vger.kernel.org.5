Return-Path: <linux-kernel+bounces-159519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3A58B2FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9920DB22F01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957913A265;
	Fri, 26 Apr 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chK9Rx4C"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E2139D18
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714108129; cv=none; b=OTIwDYBSIRLNtbk3f6tJG3eIEtSYOjsZnDNDwcQNEUiKFr8gSzA0I5qQbmOguMu1oBG1iPwurBUTrvuobdFvghhP1zrMRJ7oLP1yFkkNQ+Dn3vZkj/AOB+klWz2U32Y6jVU3Wi5Q56YV0g4BM53p3z1YLeYAEcyyu5g/OrS4jRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714108129; c=relaxed/simple;
	bh=1LBhiAAzsix5kBJ7XstPViIgPB3xqpoWGEuihbF6h80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwA9nAYVUKIOvbOL8HiMxK5foKn5Cisc+lTAcEH2pAFeCZWJssl+1c2zIFI14Eph5h13qx0HCnToGte5kyNrKzT/oxblSZzufbIS+8ODSMdDwDuzS5uxnisyJktCMDBLTNtHW5bwaSnhFsPb7O97fBPzF8RLkgwUTT/WS5F5fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=chK9Rx4C; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so1975295276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714108127; x=1714712927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9qYK6scXFU3hWFQO57QP2e7QzwrtzpT92BwSQPl/Ws=;
        b=chK9Rx4CmSO4WB1nmYQwDfCdxOIaxwLzFuaC+HA1lYR2aNZiNMdp4Ql+tYUEsBfs8V
         2GpH4pe3envr6cD9PuDnQJAJtDwhaENtuWpkhm6bEXxX3mTVuLi/o2H0x7mlEDooJK4A
         BzAyd4EcMbS5/bZpiAQavopDUc/AXHqM/S4lisFU/thGEEg9ZDTSLpOC1L2WXEh2dz8v
         17D+CtssRtq8hR8Y7QfWuLKuJlws9I6bW0rYGTpr+8AnD9LhBq+isyU6MxrGgEX8Ze7A
         82iIrWnQIWCCh+DAGuSNlJBRT7tldnwPc1gC+MLjDxm7kfAg+s1StF0Lb/BzwozCMBQX
         5Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714108127; x=1714712927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9qYK6scXFU3hWFQO57QP2e7QzwrtzpT92BwSQPl/Ws=;
        b=u1i5tDsd1K2njHTx3iTewu++tG9fuphHbjnH+RA/ZwE8Sr1Ss9gdX67JiVKKPM1I+v
         m6zT/4j/gxo+BsFEORKkYA3JpCbu+qwVdgZlRPO1d1FZnElUWomBqzmSMyY+JNj6wcVV
         WohVX9/nNxpqOpEV+SC7k7h7M4Aclj34gJKcjxqJuRQhAiqzs3VD47veA/sFt80IaOgQ
         UtRsRCGZKvTs2U6eFYa2ICxNz7oZdHjA1APKczK8aEqFQ8IYK0pd2KfwXk6QVUW7f1Hy
         T5UgLHJrpxMmrMQME5fvTeNx5JP9N0oS9/IEJ4NexUA1e43Sewp5bZmwFpkuh0hjMPSl
         kSBg==
X-Forwarded-Encrypted: i=1; AJvYcCVHyAy+l9RDYVwzXyp6prhYXYFl/ScttIn67r3KaAg0+GryOFl7EuV9OpdQVGSXzUdVD3yYw0RsOk3CPDtMtpUq+RgyNsqywe8WBbMP
X-Gm-Message-State: AOJu0YyIhceM6KFtwfx2QSJXklh7cReJ+SuA3x3a0sBcQh7to4Vgp/aR
	W/YgEvpgdsPctJ4Yy+P2ngnQFTYsp83+Dmt5/N4JC7onytBKp7MTLf7HckT1d356OjTYfNmXPUs
	Kzn5O4+ClkFgszIeoabjjIgi6X1f5x2uM/n4zIQ==
X-Google-Smtp-Source: AGHT+IH16hO8vwDnyxZrKnMooAxMmGR34X0+CmzuCVy2Rc0FqatpjC5Clkv6zfTfOM8jNaRnnuwXmkNi1ffzofnr41g=
X-Received: by 2002:a05:6902:2303:b0:dda:c5ca:c21b with SMTP id
 do3-20020a056902230300b00ddac5cac21bmr1953339ybb.37.1714108127133; Thu, 25
 Apr 2024 22:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Apr 2024 07:08:10 +0200
Message-ID: <CAPDyKFovRYQOCM8UqFcsP+MiUd2ViKJhgHUMH6hgBiqtdBxmkg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
To: wsa+renesas@sang-engineering.com
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 15:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>
> For development purpose, renesas_sdhi_probe() could be called w/
> dma_ops = NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
>
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> call from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>
> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Wolfram, when you have the time, can we get your opinion on this one?

Kind regards
Uffe

> ---
>
> Changes in v2:
> - fixed typos in commit description
> - limit the comment lines to 80 chars
>
>  drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index f84f60139bcf..5233731a94c4 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -589,6 +589,12 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
>                         sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>                         priv->needs_adjust_hs400 = false;
>                         renesas_sdhi_set_clock(host, host->clk_cache);
> +
> +                       /*
> +                        * In case the controller works in PIO mode the SDBUF
> +                        * needs to be set as its reset value is zero.
> +                        */
> +                       renesas_sdhi_sdbuf_width(host, 16);
>                 } else if (priv->scc_ctl) {
>                         renesas_sdhi_scc_reset(host, priv);
>                 }
> --
> 2.39.2
>

