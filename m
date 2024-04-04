Return-Path: <linux-kernel+bounces-131256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E69898559
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70011C269C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CCA80623;
	Thu,  4 Apr 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KucgOAAX"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07A8F7D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227634; cv=none; b=frQ+5KE3oV2s+gU6o/nt8NezFVEEK1UYed9LyvdOempvsgntvFQwGKJyuU5eBlU4Q7lUkgazzzijYbdZeiD6mW1TbDjhWsF+R6cFvMPiHRO9elA8FtQzQkNkyD+c4fJWNMCMRdhU6MdvnrakiD5c30t1n+VwiILH99waInh98NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227634; c=relaxed/simple;
	bh=V8wv6frzZebJQXeoCr9BTYoZ7AS6+o1u8akU2yyz/1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvLRs4qR9KKFWLH05Cw58iAU8xFc6youAsjmFWjSiKJ+KcpiKIc9MhaBHxZCsAlQMYdSRRcsMs/fOKpImcYJkl2My5waCiO9+wysDrEETDK6RBizvwniTo0FYyL44mEvILcPCYOi4IahOzVOOsIypR5lNvyLReQSRIO8Jva5NPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KucgOAAX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so843046276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712227631; x=1712832431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Ykm2W1S1p85sujFPKLol+N6IEGAfeW2v8P+jKKQlQ=;
        b=KucgOAAXGyvDLgVlFP79uaBNM0lHxRPP5SI52xTns2+d4W2BQOqHa8JuQeptXuGAJm
         90GFrPLkysgTdYAt8MFAGVgacGXtW1ploArIf8cG+nqUyX/3TEwXYAOenldcxdldCNpj
         0KiH1//m/HioVu4L5Hd91RDkiAMUpK/52Z9l/Kxv+9AiEEW0qsBMxQFdsy+Nbh5bkORJ
         sTCIT299fHyDOcB/cfoB5HyEN4NMlwc4TllsrfvLAXeU3rk7YfphRXmtOqWVGA/fMKjq
         j1gL4vEvXRj9vnrdAbKbqzY8mnug+7ydjfSH2IOYvAMzNPDdwUNYtBOThQFZcnBycDaL
         YdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227631; x=1712832431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0Ykm2W1S1p85sujFPKLol+N6IEGAfeW2v8P+jKKQlQ=;
        b=voF44dHw5ockUSl7lJ5lpp7nIpCKYXstpu3tDlxMBwjEMcw1wpCZu5yNCGNuC0s9Fw
         zGvRPr3oRYOVZUfvW6oLP9wLhEFFHPN4/p6j90XO6mLwUbEN1/yScR05SJjW4aL7uQEo
         Imn+QHsXqsJtYq/Syl8D29vd7IKig2pZANKvTt2kqlRu/5b1Cgb5Lymg++wOtDBvwlKF
         cEwIjXHfo96McYaQCfMDvzev11nJQd4wcjW9uxzQfQjEaAO3DLzW+PEBy04QaWKtHjsx
         ElEGqQueOQe6MsAoQCaEENb566VayqUOE+FB7u669sH3TxfSBnCI0N1YXCS1Df4kiaj7
         VbGg==
X-Forwarded-Encrypted: i=1; AJvYcCX4uFeS76kKnLQBitM+IBnf42nKDfBwO6BtE5VGuEzO7AxUXiOd+EI0WzofIjfN1HOkpu145AZKAsHgDpEMuawavOW2peIOv2LU/RJu
X-Gm-Message-State: AOJu0YyL7ctiUgwcaEGNstSdqahfHYMGpRe+5HU/2Ril7cUi4wfX9ptM
	MQRihpt+UQpWGJZkgq1X+N8Dg9DD/aFjiS4plD9ngeqU7BXrMcjzdkzmYqY4/LyLL6xbJSNdmDL
	spGpGc+sF1t4Mv2800V+DgPO9aC12U5ygPYGLTg==
X-Google-Smtp-Source: AGHT+IG8QfWI6GVdC6qLbyKBp8gOwWy/t5BNQ+Yfrm5Mn9ZdgBynu+9KPMQrhUmNrccslE7argS+hG9yXel1mv9D6SM=
X-Received: by 2002:a25:9111:0:b0:dc7:4f61:5723 with SMTP id
 v17-20020a259111000000b00dc74f615723mr1910942ybl.39.1712227631181; Thu, 04
 Apr 2024 03:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329044142.3095193-1-fshao@chromium.org>
In-Reply-To: <20240329044142.3095193-1-fshao@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 12:46:35 +0200
Message-ID: <CAPDyKFqr2wPHGScSAdwocjOF8jUTJnti+j5sWMYW5kg5x5OmyQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mediatek: Add MT8188 buck isolation setting
To: Fei Shao <fshao@chromium.org>
Cc: Johnson Wang <johnson.wang@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 05:43, Fei Shao <fshao@chromium.org> wrote:
>
> From: Johnson Wang <johnson.wang@mediatek.com>
>
> From: Johnson Wang <johnson.wang@mediatek.com>
>
> Add buck isolation setting to ADSP_AO, CAM_VCORE and IMG_VCORE power
> domains in MT8188 for proper buck isolation control in power domain
> on/off.
>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
> [1] was reviewed but didn't get accepted at the time.
> This rebases [1] on next-20240327 with revised commit message.
>
> [1]: https://lore.kernel.org/all/20230315114505.25144-1-johnson.wang@mediatek.com/
>
>  drivers/pmdomain/mediatek/mt8188-pm-domains.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> index 06834ab6597c..007235be9efe 100644
> --- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
> @@ -175,6 +175,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>                 .ctl_offs = 0x35C,
>                 .pwr_sta_offs = 0x16C,
>                 .pwr_sta2nd_offs = 0x170,
> +               .ext_buck_iso_offs = 0x3EC,
> +               .ext_buck_iso_mask = BIT(10),
>                 .bp_cfg = {
>                         BUS_PROT_WR(INFRA,
>                                     MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
> @@ -187,7 +189,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>                                     MT8188_TOP_AXI_PROT_EN_2_CLR,
>                                     MT8188_TOP_AXI_PROT_EN_2_STA),
>                 },
> -               .caps = MTK_SCPD_ALWAYS_ON,
> +               .caps = MTK_SCPD_ALWAYS_ON | MTK_SCPD_EXT_BUCK_ISO,
>         },
>         [MT8188_POWER_DOMAIN_ADSP_INFRA] = {
>                 .name = "adsp_infra",
> @@ -524,6 +526,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>                 .ctl_offs = 0x3A4,
>                 .pwr_sta_offs = 0x16C,
>                 .pwr_sta2nd_offs = 0x170,
> +               .ext_buck_iso_offs = 0x3EC,
> +               .ext_buck_iso_mask = BIT(12),
>                 .bp_cfg = {
>                         BUS_PROT_WR(INFRA,
>                                     MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
> @@ -541,7 +545,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>                                     MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
>                                     MT8188_TOP_AXI_PROT_EN_MM_2_STA),
>                 },
> -               .caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
> +                       MTK_SCPD_EXT_BUCK_ISO,
>         },
>         [MT8188_POWER_DOMAIN_IMG_MAIN] = {
>                 .name = "img_main",
> @@ -591,6 +596,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>                 .ctl_offs = 0x3A0,
>                 .pwr_sta_offs = 0x16C,
>                 .pwr_sta2nd_offs = 0x170,
> +               .ext_buck_iso_offs = 0x3EC,
> +               .ext_buck_iso_mask = BIT(11),
>                 .bp_cfg = {
>                         BUS_PROT_WR(INFRA,
>                                     MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
> @@ -618,7 +625,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
>                                     MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
>                                     MT8188_TOP_AXI_PROT_EN_MM_2_STA),
>                 },
> -               .caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
> +                       MTK_SCPD_EXT_BUCK_ISO,
>         },
>         [MT8188_POWER_DOMAIN_CAM_MAIN] = {
>                 .name = "cam_main",
> --
> 2.44.0.478.gd926399ef9-goog
>

