Return-Path: <linux-kernel+bounces-164480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B978B7E09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264F61F21E91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEE194C94;
	Tue, 30 Apr 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FuP8MEkU"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5A194C8B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496295; cv=none; b=n9Q88CK85P0g+m6kDXsRqqlIHucOpCUTyoBl/FwQdlf+cWyxLsE3jD+YkI8kycdqZuQb1Eu99vPRy+/DIxIE+D4znNvyzL8tCDmz06uN2gSyonsIrEYYR/Uh2yseSbr6/mocLyEYg4M5YfaRn0s+/fg/Hmx8RAH4FInQbD2J4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496295; c=relaxed/simple;
	bh=QkfJFTFyKMJ+kVgxuEE3AQrJqaYnRFGmC9I1Mn6xiVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm9BxoHczdVHqxH/Idl0w+tHYwcRpW2Nle8aVE4WJr7yPnbUYM81F0ePU+8DWWIHZTcxRUXNXnJk5o3YZN/8k3toB4GOCoSKpjO/8TcRAtDQ5cIu0b/WDItaTA0OizTAqGyMOn7rWtz1w3KQhJWRc31NgL+srZR7zlPLfoEZJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FuP8MEkU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61b92a83216so67704787b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714496293; x=1715101093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhsHDApFOzKxvZegHRHM15ZG+UwJ3QKwm7gSotJL04Q=;
        b=FuP8MEkUWULbbzAkPoZQbsRHuOR2IN6MYEIjSDqd6XK5aA5nEYFzYAeAISub5hEDIo
         ZfX31lzonLp4yM0kBbU21WkoiNrr8lEq5y8s34emKL0lcZkoN9pMeGN+s8TYJsP21ct9
         ps3SFgF31VQygW3G+KKWC3fgUr3hvE3XpcELY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714496293; x=1715101093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhsHDApFOzKxvZegHRHM15ZG+UwJ3QKwm7gSotJL04Q=;
        b=ReNeUiQIYywjQFl+9gMHuOBn+tL7U2/Ax55GVutOrICCHVNPVOkHqZUA/kEduS96IO
         CrXgLRLakg8wExv0xaZweAtxTM5H5BTXg1qzjjXqu2ocFir0xhzotgFQRK7+H8/yjMnn
         qQ80UwdZhpW9+JOm/0TElhMBsQO2rtA6MMjsgH5TeQXZOECsmTiK1yp1r3w1nAm2YFko
         0kAoTD095b5E6gC9s5vvBKPEj3oWIaXJZk3u18ThNZnVUaBeNcNz1pxBqtSKU2Y3Y4rW
         CRGCnkWD+J0IcRhvpju1BX+xkIcxEPUYhn63OmbotYRbEX3q/5N4WL8BBYHqQcIcTbtZ
         kELg==
X-Forwarded-Encrypted: i=1; AJvYcCUARenz+ZLjWibr4qD0RYX293Jcc16CzSxgSZ/k2vr9+WB6z2XuhjvoJJTHC+0TdMicDbD5ZQzF35/9LaVbelq9Ckgst0mo72pMTckI
X-Gm-Message-State: AOJu0YwsKMkwl2yfQxpXHT121VWeoWP63tYOhFNs4pUlFJipGJacRs/E
	tbDQaKGPz699M7okkuI2EP3XDHDdnjoK/Hra9A4t4ZxYApTR63k/sqMfLFcu6FRBT9NclMeuEZU
	o/TmD6v2vXCsAYhuLnrI312qIwttZFFXn3OFY
X-Google-Smtp-Source: AGHT+IEufEupGpoWNbTp62WPlu4GRC1He3RH0HcNEB3z7nVK8uNG3hsfauLa66+BmmlSEZGF4HO8JdUNC0LzjE4LRtk=
X-Received: by 2002:a05:690c:108:b0:611:1456:c817 with SMTP id
 bd8-20020a05690c010800b006111456c817mr116663ywb.51.1714496292774; Tue, 30 Apr
 2024 09:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417012917.66046-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240417012917.66046-1-jiapeng.chong@linux.alibaba.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 30 Apr 2024 12:58:01 -0400
Message-ID: <CABQX2QPOoSPN5OHO_-sXxDEzUsTrKaicB4Xag3dw6BANbzjm_A@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Remove duplicate vmwgfx_vkms.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 9:29=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c: vmwgfx_vkms.h is included more th=
an once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8772
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_vkms.c
> index 7e93a45948f7..3bfcf671fcd5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -31,7 +31,6 @@
>  #include "vmwgfx_bo.h"
>  #include "vmwgfx_drv.h"
>  #include "vmwgfx_kms.h"
> -#include "vmwgfx_vkms.h"
>
>  #include "vmw_surface_cache.h"
>
> --
> 2.20.1.7.g153144c

Thanks. I pushed it to drm-misc-next.

z

