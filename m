Return-Path: <linux-kernel+bounces-162666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D688D8B5EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136D31C2169D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5E84D0B;
	Mon, 29 Apr 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEgCPSL7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA57535A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407370; cv=none; b=CVGES5PFzyL1M2Iy+ZvbqZzQugj46ztFeV+H7LhdwHmTeG3ZxOhdoYCyoND1UEnTahjhcMT6ReIyFM31gjixkdDBvz+MNm9gVjlBUrbFsbZCoonyhXzmWQSfLMH/8CQAruAgkYjWNGT2wqJb+1Ftzf3ZjRpOo/nhmtyFiovAMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407370; c=relaxed/simple;
	bh=owIzVogv4Qw/oYcoIXYyMgnDSnVXcxUoyS/wWNB0VVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWzEFQUlIh+6xyAwbduRUcAscB/0w+17cmmzhP2a0kktfqLRIz83XFRpr8zIeKRh74u6BPYn4bsdtfoMT4dyYc1aBjIF0jeyRrP+oW/ajl1erBpcZANd8LIVezGoEqM5SB3tRGK0tZXTeqi6VHy4aBtSTupcBB6CIF5/NyLkeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEgCPSL7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2bbc2048eso40474415ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714407368; x=1715012168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up3/fdKYbKn8KYnOeLYCwwUMCKqtp/CYqkoyNeCtLiA=;
        b=jEgCPSL79gZekHzp3/45SFkDRo7ypQYvHUyghrJfKqhhlpRa9ZMSHQO2uVm+DGUCe1
         UowY5URBdF6QVJoyHwCq8G3RhKsaR28D3MgtvUWHtzCwK4JHZoRRy8ueVCq9xgRbzRCt
         fMm8qm1VgfaUmLyluNPBSZZoiM2jbWo7M484bhHQVFsUgHbpb1oIcF9iV5BP9nyDAun/
         RPz0Fz+dJG5bZFDcyWA+sprvBr40fZvr6In5BGYEwXI15axUSOgDDqeMi5AkGRAHCQzM
         Kq2G9mvJRx5pjsh+qwlOnC1iLQiamWHy5g5v7tl3+/NfdeyYDJ/1m7hC6sAPDQEIc5Bo
         ot5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407368; x=1715012168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up3/fdKYbKn8KYnOeLYCwwUMCKqtp/CYqkoyNeCtLiA=;
        b=hUUhBnFCInMQvnvO2/n+YBLl0O44suZqxOLdxg5/wJlzVbvVVsSKAKe8UIIv70eCFd
         eBMxfSUzaE6eM4YtiwuczAobgWdr+7ml4JVZRNKffv72Wg6p+iZzBPjFvHAoYGv/ahmH
         5TrCW/eVhYbIyf2xIrFDACHCrUmN50XtsUwqs084R7xripBbUtJeawxhJMVlbMGnl3Bf
         /w0J9/gaPkz6vU84VNPdbm3ZHvtf2XnHD+fhQpCjiHGuTDSfyozJnYhOraTyknxbjzeQ
         xua+CirblvH3OUTsDmA43EN+LLh6MSYlLyVFl+Jl2/aXuszDLLrm8xspqlNiFNI/SoC2
         qYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCNGFjnx3Qwl4zt2thrlumKMpBJMoPqtscIvCm6RWNu7F0Uv8Cc2qcGIH87T+ndyxe5+P622ho9I1gNZ82S6lAuKxyv0Xfw18sXb+C
X-Gm-Message-State: AOJu0YxQwghApRea/VLNYR755VWFm9lRdl6hhTqTsPnuq/lK77XzBkAJ
	b4cPmoJTakAkzscu7DQ7CD615fB1+8AfuObxRKRubZhkoMtvpYg+NXASCAzHZYjU2a10S0IRPDY
	NgCMOL+rLNXVPcprkbxHIcIqiGtg=
X-Google-Smtp-Source: AGHT+IGfPQVfcz7PbTTS7VQY2ZPnXSQy2u3EbjBP8lla+K7zNwQzvnmc4QBBgeu2oV6hTU4MQBLIuwwekvrVEROpSrg=
X-Received: by 2002:a17:903:1246:b0:1e4:31e9:83ba with SMTP id
 u6-20020a170903124600b001e431e983bamr13341631plh.1.1714407368452; Mon, 29 Apr
 2024 09:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425013553.35843-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240425013553.35843-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 12:15:56 -0400
Message-ID: <CADnq5_OcjDhKHeH32VZrie4j2S4umkxukzSygXyfC3sq-zY2gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate spl/dc_spl_types.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Apr 24, 2024 at 9:52=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/inc/hw/transform.h: spl/dc_spl_types.h i=
s included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8884
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/transform.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/=
gpu/drm/amd/display/dc/inc/hw/transform.h
> index 5aa2f1a1fb83..28da1dddf0a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
> @@ -31,8 +31,6 @@
>  #include "fixed31_32.h"
>  #include "spl/dc_spl_types.h"
>
> -#include "spl/dc_spl_types.h"
> -
>  #define CSC_TEMPERATURE_MATRIX_SIZE 12
>
>  struct bit_depth_reduction_params;
> --
> 2.19.1.6.gb485710b
>

