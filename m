Return-Path: <linux-kernel+bounces-167031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2898BA3A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D12281438
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0A1CA8D;
	Thu,  2 May 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHJAIlu4"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0991BF3B;
	Thu,  2 May 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690912; cv=none; b=gQvs9xi29Fzr1Ur3rxEI/qi8jwA6rCsPwM8VxHTWsedjWzvIKo2Ih5NF9TSM0vMupO4FFwDlCPPD1l28NoxKKp7I9EzxIrsQqBn81xYpW5CjomuNjlr/bVZyh/izHZXEaoPaLeDarhSh4PSrfTImAfpS7K7jawlkekj1PzCmFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690912; c=relaxed/simple;
	bh=uzuM7TNYRLaC7ZjpI6en8/48B/eOKBl2O3vykFutHqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SanDkubYF9KpIfwOJ1YHA91ivCPa6LME6BmegXppfnc+ajcL8MlLH5mv2siE8a+gUZOdNaPIO5gCF00Nt5jp+h3hgkRxYCYGWNvGzbeaoqkCMEs+DNMzyr9LEMLEHohKhSK5lfRanZhxernH7AIlDN1V0NEz6dbPYC39gaH3s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHJAIlu4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b432d0252cso29191a91.2;
        Thu, 02 May 2024 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714690910; x=1715295710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCgtG1nwu07ZwZE9dSCljwhtr7EDaNxVfu99sHhwnkM=;
        b=MHJAIlu4pOFhQypnZfjuwx1QOatZKzrKWL1xnsG5iIxoYr3ljT08x7tYGkqTsdE8qR
         FmQp5yu64PdSbCeSC1d7b++ukBsQlroJy5Ur+l0V/cW8TbpzTXBt/0Eda0Vte38Wjq33
         90fwGZ2yqKmQma7Fa8oHgo5eH0IGuzxFdStapd2aluilpF+fRjUXFR6Uj0BC3gf0Wd2o
         fNP1p3oqF52VGv8rL5GKG87EK7F2HQHyKNmmRbtAerr836vE50sCuPp5XYkKmtXxAF5y
         3WRn2igF/Aep78Dk1LjpKEW0sSqBOUWlvbKwu8oDVnCOrMbXvgVK581L7NfccsZWBkip
         Q6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690910; x=1715295710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCgtG1nwu07ZwZE9dSCljwhtr7EDaNxVfu99sHhwnkM=;
        b=u8+cPXeACuiuzegYhYR4Wl0ojGGgxrEIfDvJHtauFOShg+dgLfyRATqGvgus/vxc4x
         xp+a3QDYbv/1SzpXz1IuR8Mv4yDYdL0y2LqO84XQ+iIMX6Gz6XLIsQ4mD90CqyVq/Anx
         lr+hu9DxDW1zkeSgBWaQT8a1vKXrJN+I7FVEq14VvzGHly2mQwXN8vWNWD9hWPLu2MMO
         n0R8X50DLCFNltqfx7ShHq6kkml2M2/mJO75CpbvPdsKlc8jv4f968uhJOzibgXjz4Gs
         rJQ7ppbVrnf1RyLZYGvdB1VvKALfWe71OR3T2LgwwdOdBMxgYch80kX2KrthyqO7983n
         hc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO4BkE6F9Qp2fIZ1/fKzjCrnyFm2wKacN5d4Wsmk1J5ybvYRFhcXJAP5kIUM7XX2k0CBptUwFClslc9cqyyIeNwU+YsgrF5vZfEr8ByDcd1lUc8cBO1ECaZlHUUWBFY8652tnvEP4hSQ==
X-Gm-Message-State: AOJu0YzdQ6VoScQ8oklsRJqAM2dTqdmzcOZqnJkbHn/eXHEmLNFPp1xi
	FrGEoHtM34Bw2Ky0xMOzW0wSoMbJnZJBDBuZX2TEp/kchzAd68HNqHQsDLNEArnZBpknNDEJA0v
	Mas03fcqao4DvOc16sWYNNygHplo=
X-Google-Smtp-Source: AGHT+IFq0Ma/DIdow1xoRPp5Dc+4pREzgwQiKnt7LZodL1844R/VAlyKYhooFHEruzpy7OVyTvmmVgJEjI7sGzzil9k=
X-Received: by 2002:a05:6a21:998b:b0:1af:650f:d06a with SMTP id
 ve11-20020a056a21998b00b001af650fd06amr1353918pzb.6.1714690908455; Thu, 02
 May 2024 16:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502215747.2832126-1-christian.gmeiner@gmail.com>
In-Reply-To: <20240502215747.2832126-1-christian.gmeiner@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 2 May 2024 20:01:37 -0300
Message-ID: <CAOMZO5CY8PQN7b01N+oNO=92CVtPPfWzuzxphs49gh+4H+58Mw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8qm: Add GPU nodes
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Christian Gmeiner <cgmeiner@igalia.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, May 2, 2024 at 6:58=E2=80=AFPM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> From: Christian Gmeiner <cgmeiner@igalia.com>
>
> Add the DT node for the GPU core found on the i.MX8QM.
>
> etnaviv-gpu 53100000.gpu: model: GC7000, revision: 6009
> [drm] Initialized etnaviv 1.4.0 20151214 for etnaviv on minor 0
>
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/=
dts/freescale/imx8qm.dtsi
> index b3d01677b70c..54879ae1d7d5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -467,6 +467,7 @@ drc_crit0: trip1 {
>         #include "imx8-ss-dma.dtsi"
>         #include "imx8-ss-conn.dtsi"
>         #include "imx8-ss-lsio.dtsi"
> +       #include "imx8-ss-gpu0.dtsi"

Nit: better put it in alphabetical order.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

