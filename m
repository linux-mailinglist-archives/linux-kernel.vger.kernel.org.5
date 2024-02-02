Return-Path: <linux-kernel+bounces-50256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89B847675
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825851F282F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1114C584;
	Fri,  2 Feb 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlVx6PbB"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56014900B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895794; cv=none; b=qjUUjCssSSrBviV1jat3MIQvbFo7NjrEh1oycs3MKuZrpnYFGs+6eL3VawSfAsVzGiItKdhzr6TIsRTIGb3HPCvJfaMl04jyiJvAq6DqHfHbuyWjYlrmFXBprXLNHhWDh4sYs4CrLkvvVu8afFiDzGR9/6wsTsGh3SOQuM1J/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895794; c=relaxed/simple;
	bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL+ILUaY0bjfuWEcKBli93LCSCfYcZbHDYs2x2xhK/5Schhk1Qsc8klKQW/rFaENpUWyjBXCDdVMgiR1s0Rg02jSSuUj328UBw+Gv+uidXg1lW8plGjMpHKsvBLvas3kQMKRl0tKpN8Iw3JZI34pfVJMIdUVSLzroghv75PS9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlVx6PbB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2106207276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706895791; x=1707500591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
        b=SlVx6PbB7PYS11tWyXl1FRKQN9gJVKiolOghLgYliRP+lkaopifg6QQvJZOYzHj2RP
         qn7frcav8E4KPXfnOhzhwD0bxDEnRhD6MTvxMcwo+ZVoifkRppGPZdFuzySzyvut6js0
         5zV8CZ3pPYntE97AjeD4gOQzVeyY5Ipy02Qsq04dfWDRX//ylGr+L3smhB0L8SKU9TKx
         /ZlyAY47wVqCFy1kj40ntfbpw3MQe6ry/uZLoD5oXJqrD8ZOg/e0hTzdm0yN9Q23Gp7Z
         OHzNMhiuS9PNAiYfhrbhwkDKtj7stnQ45MmUKPWeIn0v/0mXl1o4vaiLutdSwM5unWkT
         0EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895791; x=1707500591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
        b=IR6AGG0URNnx4GK0lLNPMsGrFa7CXrkAeu+MWkcD3ThJE/GwYW7tbkZz0wd9Jd7235
         Gn6UiJdT7x1NGKMO8DUS0YSka7EOS91jpzF/dhyzjqxcFOUPHfi6vprP0kDTjLs95yd0
         P1C3tvIzCs1vF9U0eLJ43n3Nt0wkIVJ6/YtAxyMhC98zY6yJRAD6p4J6mXpiVQcQhiL2
         FuoQkkpe0Vq0RHGTkWbOYcLY23yfPLB3DnUk/FjiPMELfDRmFoxm4CgcyrQ8uA51eb0a
         n8hoIIp48flx7CkVzD0kayeJr+jGYr0qx4M4ZXv+PzgIzoNm/77Zx/Go23jsU2qzq31s
         5tlg==
X-Gm-Message-State: AOJu0YytFZmNOFNGayP8i9n55DeCSZdmJHA6P6mHUZ20sxGTDa6cbGH6
	IVdU++GwFXNfsTND6nLcFfNaud/x/vIvjXhMXXaK8mUvsiNLZRWKe3TRkAxTJfWuzCy0VfV5OZp
	MRhPyl7Ny9xLVOU1qtPbOOA6AexQFDpnQLYxUHQ==
X-Google-Smtp-Source: AGHT+IHTaFiLwtqyLg8kSKQCyZ9cLuPMVYmKAcJIt8eLghpONdnZGm3WBgei2TskaAhjfRZa6yT6FKg3E1ONuoiITUs=
X-Received: by 2002:a25:5f49:0:b0:dc6:af04:2e05 with SMTP id
 h9-20020a255f49000000b00dc6af042e05mr6356972ybm.7.1706895791304; Fri, 02 Feb
 2024 09:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202140550.9886-1-yan.y.zhao@intel.com>
In-Reply-To: <20240202140550.9886-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Feb 2024 18:43:00 +0100
Message-ID: <CACRpkdarfWFhvJ8vrDZXOk-nhDkgfwOLB+EytVm1S=-dEFKy3A@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove broken pfn_to_virt() on arch csky/hexagon/openrisc
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:35=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:

> Remove the broken pfn_to_virt() on architectures csky/hexagon/openrisc.
>
> The pfn_to_virt() on those architectures takes PFN instead of PA as the
> input to macro __va(), with PAGE_SHIFT applying to the converted VA, whic=
h
> is not right, especially when there's a non-zero offset in __va(). [1]
>
> The broken pfn_to_virt() was noticed when checking how page_to_virt() is
> unfolded on x86. It turns out that the one in linux/mm.h instead of in
> asm-generic/page.h is compiled for x86. However, page_to_virt() in
> asm-generic/page.h is found out expanding to pfn_to_virt() with a bug
> described above. The pfn_to_virt() is found out not right as well on
> architectures csky/hexagon/openrisc.
>
> Since there's no single caller on csky/hexagon/openrisc to pfn_to_virt()
> and there are functions doing similar things as pfn_to_virt() --
> - pfn_to_kaddr() in asm/page.h for csky,
> - page_to_virt() in asm/page.h for hexagon, and
> - page_to_virt() in linux/mm.h for openrisc,
> just delete the pfn_to_virt() on those architectures.
>
> The pfn_to_virt() in asm-generic/page.h is not touched in this patch as
> it's referenced by page_to_virt() in that header while the whole header i=
s
> going to be removed as a whole due to no one including it.
>
> Link:https://lore.kernel.org/all/20240131055159.2506-1-yan.y.zhao@intel.c=
om [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Thanks for making the kernel a better place!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

