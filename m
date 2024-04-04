Return-Path: <linux-kernel+bounces-131425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361318987B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF00E1F22A68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7751332A5;
	Thu,  4 Apr 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rr7itNQW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AF1327E7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233632; cv=none; b=f1+E7JffTgjWKw0rikAZegdulzVq8rgL3GbLv8iB/bXlDrn/L6tcieqsvxr2Gwgloe0RtOwBXv3zvO/rSdOujs9zwTMfwExatRIhJ4RiiYvKSAhJLEERcqr4uVTx72FO/3vIUSnYoF7fVjYe4Ocy7JZu/509IbTJwxiF2kVsJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233632; c=relaxed/simple;
	bh=6AaqtxccIWghtb/UtGyHHUuuDFbxr8NOLfecjzX6K1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv885HcQXhEXpJoHokyE5di9r0qqfVQYZuNJIjiSV3kESKDsdjljvVBe+hmLOJtQXMvhySkqNVLw5MV5kp7I5T8Qb+s0p6bTshJpE9lQlNh58PXvnPSu7+0IgLd72zlWNef1q93JORvIQTuA1UCYSEZNoYd5HQZjLxeYnQjw1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rr7itNQW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0f3052145so8291865ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233631; x=1712838431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QR0Y+B+yOGaAYXg8JSyYTv57ScUCaP0rjY0sMY2UN5c=;
        b=rr7itNQW2w6wPK5qYUIvtZue2JapDu1hyWra8Kp3AgYUQqXZEoQQP5IGfB4gN1fT8i
         GT0r21GmfL3k1cEE5uKetL61ZiOxLl7fFIwaPtqqjCIRi06ux+r56ozk2McBbqOqOukH
         kdRrCNZT3u1YA4bNllTMXXJ1KvTaRMOuukRIrofSf5Ixq64HWm+IUhxSC8Y3ucwHlzUj
         NoLqeybNHOXmPeAVGpof1hqo9ZtILix84RfCPTZd1lgTVVvZiCW6ybsDG3MAdtub4gaQ
         xSK9FKSsVfNSw2Kf4Pth3ZIEm3Z5K7Rgcgduvb5pPguPfZIdS6nZ2DqqAQJ1glv1h6eZ
         L6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233631; x=1712838431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR0Y+B+yOGaAYXg8JSyYTv57ScUCaP0rjY0sMY2UN5c=;
        b=TzXCCXpMVjypLWKVg4G3gq4TYYO+6BTY9iaJVp9Bx1A9UcX5baAQngyapIsfZlDAaD
         QKZRR3BhRShImmEsGlOgj3kxTVMft3XI2HRYNqyeQzzl3ldlHcrvNpNKWg84NP6AG1Ny
         Hgd9G4D46xAMNQTIfghOcWCxgEZnu5z7dzn+fljfxSQhqPncqJxDxDAeCSdWhiy8ow1T
         wfxprwG/9u4nif/0+wNSZsG6vT3nszrIcgGJPgv3Oy+eahCfh1ErJqqkynqm+fd9T1b0
         vkGQwtHWsOzNCcm55HlZ5BlnXgjXjpzGt0cgrPSxbHgN8BcrsEdusLRUkuYmp3o+KIlt
         xK3w==
X-Forwarded-Encrypted: i=1; AJvYcCXOfBhWyLNEnsMjWnvZRLNk8fxjHW7g/4GVvFOlCAhMYoyGmzE+Ty1s0+BDhVpPuNYS99+8yTNc1D2A9oOUT1+KUEBmWDxJ9LiVOLJl
X-Gm-Message-State: AOJu0YwOIGArfSU0LG2Z+dDUmvFSyGB0eXxr7ThjbF7vx8793Cg9iKCy
	CEue2GqJn92ZoAyWMDifMOALhb7fOIaroaNq10iz1EeGcOjlLipEPLpLs0LRO0s7Ja1W50vRcoO
	4+vGFNNUU5perD9y+Vff3BFPO6YpPS1WnjuaM/w==
X-Google-Smtp-Source: AGHT+IHmfnSnKXCI7Mxb081VVyHmquQ5fGLtObMlW6Quf3xRZm2lKjkbd3bd04nWmy3CBVOS6JlK2CWqIaWbSxC1Lck=
X-Received: by 2002:a17:90b:3841:b0:2a2:abc1:cb48 with SMTP id
 nl1-20020a17090b384100b002a2abc1cb48mr2309448pjb.18.1712233630660; Thu, 04
 Apr 2024 05:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712147341.git.vitaly@bursov.com> <03b7979666088f8d55db301c6649e0c75c727d6e.1712147341.git.vitaly@bursov.com>
In-Reply-To: <03b7979666088f8d55db301c6649e0c75c727d6e.1712147341.git.vitaly@bursov.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Apr 2024 14:26:59 +0200
Message-ID: <CAKfTPtBCxpa0Pxx7=84dV1Mf_as6+YqcROGgGVr6Qpt-=ybrLg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] docs: cgroup-v1: clarify that domain levels are system-specific
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 15:28, Vitalii Bursov <vitaly@bursov.com> wrote:
>
> Add a clarification that domain levels are system-specific
> and where to check for system details.
>
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  Documentation/admin-guide/cgroup-v1/cpusets.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index 7d3415eea05d..f401af5e2f09 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -568,7 +568,7 @@ on the next tick.  For some applications in special situation, waiting
>
>  The 'cpuset.sched_relax_domain_level' file allows you to request changing
>  this searching range as you like.  This file takes int value which
> -indicates size of searching range in levels ideally as follows,
> +indicates size of searching range in levels approximately as follows,
>  otherwise initial value -1 that indicates the cpuset has no request.
>
>  ====== ===========================================================
> @@ -581,6 +581,11 @@ otherwise initial value -1 that indicates the cpuset has no request.
>     5   search system wide [on NUMA system]
>  ====== ===========================================================
>
> +Not all levels can be present and values can change depending on the
> +system architecture and kernel configuration. Check
> +/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
> +details.
> +
>  The system default is architecture dependent.  The system default
>  can be changed using the relax_domain_level= boot parameter.
>
> --
> 2.20.1
>

