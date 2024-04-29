Return-Path: <linux-kernel+bounces-162672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB38B5ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53B2283F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770984055;
	Mon, 29 Apr 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/zT2816"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5417640E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407535; cv=none; b=EhRpO1jNSvQ0kQ/LEllBpzdIGWDJ3f3iTapJeNTBIXvhd7wpPDhB18Q51lqZdhSUkecPgPoGLI8P7OZJ+nuVHLzk1bnrBmJ/WwoYjKXXiRlF77o2TN3H1TLkxeAVJFBvsGsp0AxKTVYAoIemkVYfGHcih6yAIetE9OFIaK1/ZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407535; c=relaxed/simple;
	bh=9cMtz0QD13mMuQHCIVx6vJSrcJxCVftA8URM9zk3hdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM4oi3LdVGssGZNy0P/ZacQHalHTSjtvgcHf4CuG2MCKOMhXOvCnqkFrdy29SNvDPLXQKG2rxVlSptJJOesGl/vhQPqEEPSeW4Uke6nYxnraED4BI2GAR915uLlNzsbXtMryUoX/D5DcG6jJzATAGLHOe1i8vtE6bX2jeXY+Ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/zT2816; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e2c725e234so43894405ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714407533; x=1715012333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbq+qEr2TR9K519cRuEv707kWrofqjZGYqtbIYY/ePE=;
        b=J/zT2816YWXXaGa3Ot6tQdcVAWf/oaM3q/VZJcUM17wfviswOLLgSL2nr4UP0nZsa6
         3UKu7KMxi1mWJHeGjgF4atW3L4dYSYUpBVYDk6ZvARSYhacSH4moGHs4BbL2PEGS605o
         ggMVL5GvoSr1u3jbtjcjH3q4beEkGFUZfIRiD0W4saUBQuqvew+EAVdMCX7ZTDStiPoq
         dJ7NFErKO7/NKSkw8UetmIKzWr3j2vNzh8hfbwF6bs/nyDhI282fGfXdQ2XCf4bfSDMk
         dBBGegRV9GSvuK4dgic2KcwKeq5QWrrS8xbw5iUX6RilfugJTi76DT0cSIwzFqoL8n7h
         aaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407533; x=1715012333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbq+qEr2TR9K519cRuEv707kWrofqjZGYqtbIYY/ePE=;
        b=E92DP5shtdmVjKtOqemSdADP33EJsHepmuwp8m6wwYtXzboEU4FgbD5ruUdBet9xMo
         zkbwIzXG96JowxQsD6gVSmpbzN3wMb1uDXStofUH836Adc+bwng3FaUXVoTOtIepzun2
         4KYLxJSpioP46Hze5eWNV0sl9q5+466G8hVidBVcPKcMBPS86j3MOns4d/FzEZkrm20N
         d/FhNs8nkShNAunoeP7CU8kEb0w4nfLSHh8dObBAVHLZnlnBAM/tvoxhlzpRaYVqMLUQ
         PsPOC53OXQH6Tl0SKUzOTgE6feM8tTbFIk5Za5KlaUrmAEjKWgprJ4swBcJ6D/uasDot
         8YJw==
X-Forwarded-Encrypted: i=1; AJvYcCXvxRL8drzfUUX1MQK9tf2GGrYDg8J3GYv05/Hih72xfqsfJFDJITZPTURS8avpIVQxIAPYhr4DpR+EXTkov1y1wNA63bZRErjHNE6s
X-Gm-Message-State: AOJu0YzSm8lZf0ffIQaICIQFiHtp512rurgtNu6LKzkUpcsnZf2bLoBp
	5GL+6hxBexb/hzbye9f46ybqTP2+XWxWY3yT7bNUNej3AbkA9d3XKx0lmoqvaZPZ2Ci23T2Jrh0
	O0V03exvqzERfsqQPzrISXd2Ag6s=
X-Google-Smtp-Source: AGHT+IEf/J7+wLIAUMjrhtDR0os0Zz2NgPOtqOal69+ua+96Gx2aPoVGTOLn2bIe1budyCyht7VDIGVIOEAiTKStuWQ=
X-Received: by 2002:a17:903:120e:b0:1eb:7855:43d5 with SMTP id
 l14-20020a170903120e00b001eb785543d5mr149588plh.30.1714407532804; Mon, 29 Apr
 2024 09:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309014732.722139-1-tjakobi@math.uni-bielefeld.de>
In-Reply-To: <20240309014732.722139-1-tjakobi@math.uni-bielefeld.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 12:18:41 -0400
Message-ID: <CADnq5_PeBwXpxnKgW0YmcdeMDMZ3maEZmN6h7ZgHKDji3pyjwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add MSF panel to DPCD 0x317 patch list
To: tjakobi@math.uni-bielefeld.de
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Mar 8, 2024 at 8:58=E2=80=AFPM <tjakobi@math.uni-bielefeld.de> wrot=
e:
>
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> This 8.4 inch panel is integrated in the Ayaneo Kun handheld
> device. The panel resolution is 2560=C3=971600, i.e. it has
> portrait dimensions.
>
> Decoding the EDID shows:
> Manufacturer: MSF
> Model: 4099
> Display Product Name: 'TV080WUM-NL0 '
>
> Judging from the product name this might be a clone of a
> BOE panel, but with larger dimensions.
>
> Panel frequently shows non-functional backlight control. Adding
> some debug prints to update_connector_ext_caps() shows that
> something the OLED bit of ext_caps is set, and then the driver
> assumes that backlight is controlled via AUX.
>
> Forcing backlight control to PWM via amdgpu.backlight=3D0 restores
> backlight operation.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 7a09a72e182f..5a017ba94e3c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -68,6 +68,7 @@ static void apply_edid_quirks(struct edid *edid, struct=
 dc_edid_caps *edid_caps)
>         case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
>         case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
>         case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
> +       case drm_edid_encode_panel_id('M', 'S', 'F', 0x1003):
>                 DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with pan=
el id %X\n", panel_id);
>                 edid_caps->panel_patch.remove_sink_ext_caps =3D true;
>                 break;
> --
> 2.43.0
>

