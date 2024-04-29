Return-Path: <linux-kernel+bounces-162668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8E8B5EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A09F28119C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D983CC7;
	Mon, 29 Apr 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPClMrM/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC97537E4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407441; cv=none; b=ISPc1ShjXbMiaIKorNDnDTl57kEf2CMN4YvPMA8/jVQsCHT633iaTdh5YafqTFLbKswdk+jOO7l1FfwrGKU+Rdrq5TKucxjb1NlFi3XZpYPIBpqtYrgPDJdVNVd4ryyv+OyumFlhNqFNVXP4BtI8IC8OX+tbrSlHrKp/jAZh7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407441; c=relaxed/simple;
	bh=8apCda2dg9sFprjl2aV3u8rLtR+m+OnWQC6LwJ75hRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8VaxHvkII77pSKaehVA6LCyg54/7ABKtbjkhD8U5xD1hEXz/poN+0rCoNrL/PDLGF0BEo+2DPVJ+1JL5egvjAU3d02/zLPp6Us8SPp/YhxqI5lOxw6emUKQOlBQUQyXM2I8H2Mri4EQVKRHTdTD+6Ixz9Saj8uFv8WAHk5+Ygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPClMrM/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e50a04c317so24615445ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714407440; x=1715012240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRMKoMiU/Afm1XtdmExTEtbRCQKoZqGaLEqC0n57hg4=;
        b=UPClMrM/flyNUTZztkv+r6+Yz0hF947plZ/I88Sw4+2t7S0T0EwsBtSjSrupd/MK8B
         GqfqHxdJt0GfsyHMikd/nBVgH5FmPIYvXnPWDYllJP7UzaWKKH1qdHtNn1dZ1pb6H5vS
         UOtWZGjF6mFVKe9UTu52LJUB9HF6oLrivSC2dTCo7vvd6m9VClBwkABQxvmcXVDKK1rC
         DJqNJo7oTo02vvuSy7o6tK85/x+JXFUHUyfdOy0Mhj9lXmfExxCGLsLoZWSyAeUHiIB3
         GagexuXaRkJCEc7u6kKgcA11XQ9IKBmYG157d9uX2VDliDl/9G49NatYREHvvOl31Ou9
         FW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407440; x=1715012240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRMKoMiU/Afm1XtdmExTEtbRCQKoZqGaLEqC0n57hg4=;
        b=VIKFdOj16qGqPL6peE7BoGxZHznS0hZ57RvB+MBBPeWATnboxla04XSkoPkFo/AS6i
         GptbhSqeM57L6dB1fOlyJJnQ9Bh01eHyA3nQFbphOQZVboVJsZsibxcYWfg66b9zbxo/
         t6xI8k1H2y1ZuQA54fzi0Nh1gMLZQi9bL9lWrwVzr9NBi6UpyYUANQvBInDUsBCuv6JY
         XV82v0sP+y+ptJIQXJxkCKhBfsgl197B5vqiDgKPArwacCvSFcaY6HfS3YR1RVXl9LPU
         CfLEdxt2gqjDOLi9Tdn3KnPjrLgJIHNolIR6sw7p9R/rthVIsV2P8bLcQm+6VXnWhgR5
         lrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtDdh3IEqv4p7p2IKc3e7TMxQ7jPt+m/UBAE/rqHnRFuKlLnRtSqPuAqrOqPEAptMIv5UeDrpqZ5V5xm6YwGbVI20EMUEEyz0uxU6h
X-Gm-Message-State: AOJu0YyDrdeBj4P4So60Bz5MG8dAXSlnTxt4D5v6e3QQlHscKJMqQ6mF
	8iICXxEh01n49x5tyLHl5m94xYCdacF5myFyRMJQd96JG0psSfH2zgQ2C8ugQo8GZlDG183PlGe
	w1IdaikabUMQc7Z2vT0WFEyhsjJw=
X-Google-Smtp-Source: AGHT+IEYtfidfKq+b3S83zX8F5vtIn0LFk53vWsPXGIKpVjO3e5gQeGzDXpOktH7FLFDFcfhzQbH+xpl7vUa7FeRXak=
X-Received: by 2002:a17:902:848c:b0:1e2:a61d:905 with SMTP id
 c12-20020a170902848c00b001e2a61d0905mr90550plo.63.1714407440013; Mon, 29 Apr
 2024 09:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425032330.36812-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240425032330.36812-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 12:17:08 -0400
Message-ID: <CADnq5_MoCTVtMqwTcVkxEmxa=MTw0MqmNWL8kEURg2mXptC5=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate dcn401/dcn401_clk_mgr.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Apr 24, 2024 at 11:42=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c: dcn401/=
dcn401_clk_mgr.h is included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8885
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr=
c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> index d146c35f6d60..005092b0a0cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> @@ -21,7 +21,6 @@
>  #include "dcn/dcn_4_1_0_offset.h"
>  #include "dcn/dcn_4_1_0_sh_mask.h"
>
> -#include "dcn401/dcn401_clk_mgr.h"
>  #include "dml/dcn401/dcn401_fpu.h"
>
>  #define mmCLK01_CLK0_CLK_PLL_REQ                        0x16E37
> --
> 2.20.1.7.g153144c
>

