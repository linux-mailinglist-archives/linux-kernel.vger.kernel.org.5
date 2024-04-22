Return-Path: <linux-kernel+bounces-153517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38C8ACF04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB95B28246C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4A1509A6;
	Mon, 22 Apr 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QGu/lL7h"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE1150999
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795051; cv=none; b=NKgLFQgjVcfk1exXjOogqc3PDx0aVB9H8oabHCpu03XM2ouKv8nUQdc1A292Ju+wwq+y1DadQwjKED3HoH5K4M/hmMyqxmvmMyFXbHjMla9bnbnq49P7eYZ6Ei97WjkiDvLv1YgJReaAIcOa6MVELXuy6XvnwWTEjtD8/ZOLRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795051; c=relaxed/simple;
	bh=zYVHZ/S1XYTcfZgmpvuPgVe4dQIPKZyJvLnKnJPJEkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO3nYyP9Wx/3n07QRcGhD1Id4LGiTuG2glz9KomkIQSdNc+8Qw0LqOK2G8oWiQ9QPnLYCpVFwxb5FSEC9M6YW1kLaF0aBjFy912fNSgPulGt/dRmpy4teGtlm+OZ69AnTHyNh/URk5HIPRzm3twWns3JOTzi+eKwxp1Q+4wDflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QGu/lL7h; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-434b7ab085fso42220591cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713795047; x=1714399847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgjTo5Gsy0Vsq9HceSa7BTmtZ4tw4e+SgvrPUoLWsZY=;
        b=QGu/lL7hnirmVyeHycmZWX4ioJ8Q/MU9VkQdiFsZqkB0sFIxz6TQYS7vRi9teIj4qR
         ywNrtuYp4zvmvc1ur3IDHLb9BzAXKhriLDr1JuLQdq+8sAUZ+ZSzlH6KQ6dXHM88VGjB
         73S71P1lIlkKKooBV7+YkWoD0Qc1VbSSDfcxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795047; x=1714399847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgjTo5Gsy0Vsq9HceSa7BTmtZ4tw4e+SgvrPUoLWsZY=;
        b=njDA6KTA0q+OTKvarGV1hdoNRq8MMTjVlsPoW+4b9dudlhpCHDTjJ3KsAoDx4ZO+Ke
         mKMsRGnxN/GBj1deqprEEapKl8oBpzbYb0RWFe5E9GhRSQOJ+vwnLcNd09bVRJZLMTsW
         HYCiGLOGbPDNYEiSIL0y2BpOEu6CAu+91RhcYA/nSTcuBeklU9SqzsWwCxSreo95c4au
         LgGlvLfAks+HWtoRqztGU6H4Rh8Z/WRUz2sQofazck7/pgclvVXdRTtlbTkSQgPzMQh0
         IihxLe+xKFUysfYpSLmAUlZLXHQbebDR7Pfe61n55dghjcobAH6PdsfG/oPt2wRMtIo5
         t6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU2FXcl0SUhWDXtPQXXSKiK5/tGR5MhqDimsKbVJk6d3FIXu5ZdOK446XUfNGPcf5qGOLp3Jyf8M/mLs7NNONMhs1bT/uKiDa3Hrwa5
X-Gm-Message-State: AOJu0Yy46C0aYTRBXkhr3YuDG2bQ+PYfgwUrYPpQxxTTm7MkKskwf/Hq
	g+IjFvnL4f9EGxCDMOU2Ht94W5IVOjQncYWL3oM9bqnf2r09myt7ZhVgfkvw4s2vwdYl417l1WA
	=
X-Google-Smtp-Source: AGHT+IE4lvicMccpTcZpchrDFdEHt8FtVQpCgRTZEyuLPwXwYdIhSkGlJRgA/FgNG1Via7fZlUTYbQ==
X-Received: by 2002:ac8:5a0c:0:b0:439:8e4d:356b with SMTP id n12-20020ac85a0c000000b004398e4d356bmr8402259qta.14.1713795046993;
        Mon, 22 Apr 2024 07:10:46 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8498c000000b0043496744c5dsm4286545qtq.52.2024.04.22.07.10.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 07:10:46 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so348331cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:10:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPoNYo80EE/OBedROzEvtQE97a03QlfoONntmxxQx2PILy7NzdcKXHKyS5vaEJYxejuh9BtoIc41mIdzF7GkEtaltiaDJ8hLZnGzp+
X-Received: by 2002:a05:622a:a081:b0:437:b429:c953 with SMTP id
 jv1-20020a05622aa08100b00437b429c953mr405598qtb.14.1713795045405; Mon, 22 Apr
 2024 07:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 07:10:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com>
Message-ID: <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 21, 2024 at 11:09=E2=80=AFPM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> Add support for the following panel:
> CSOT MNB601LS1-1
>
> Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index d58f90bc48fb..5e0b1c94bc62 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2036,6 +2036,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>
>         EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50, "MNC20=
7QS1-1"),
>
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "M=
NB601LS1-1"),

Are you positive that both this panel and the one above it (which you
also added) are correct? You identified both of them as CSO panels but
one has "CSO" and one has "CSW". Please double-check and let me know.

-Doug

