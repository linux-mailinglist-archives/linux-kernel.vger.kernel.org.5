Return-Path: <linux-kernel+bounces-129790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62346896FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FCD28F955
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542D147C94;
	Wed,  3 Apr 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="cqYY4M1g"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815666DD0D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150110; cv=none; b=BOUvVrbd8LAQhcyWBmGzG1OmGT3fpb54oizJQlEQe7XoO7gYc0zst8F4xmGyGsBVyP8OjwicPcMlluWkgWxRMtdmIt85P3WMtc5lVrdhaaShnqPzM+oFhTyyy23/cUXxTZH8inRxrWiBfb45JNGzwFCDwvUACgz0o11Z8fqmCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150110; c=relaxed/simple;
	bh=m8vRG88FNKwizdEjO/c/t64mIYd2qCldOAH8zF37jpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeLswsoQkJkoym8tBzz85uOU0OwAGFUuRfnSpk3ujHdH0cb20FEvsvvyov+qVGH1cgIS1nMN9txVYrwmgxDy3yGYzwBvVIUJ5Yh1G6+pcatKNn/XHaP3gGhXKcWFF+Ev0moRExQO7n9HgZnkOzgrS3H3/LxnWTFoPmeXx/MZOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=cqYY4M1g; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a51c063f99so3469303eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1712150107; x=1712754907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPbrOyf+WH3LEFByBVjd+RN6Vyy+2vOeO98hIRaqQ9s=;
        b=cqYY4M1g+b8WUZFExEXo/50OWYWU9KBmNSevCfHbEyA+vcxVnl8+oVxvBM1sCtBsbu
         zKevR2dA69np57NkONLQcmPkt/D2Qk2Iis8pVs1xhuciVjiB1EQO29GnoTisTOYXi9ct
         E4RoBSDG+kRRDugaDdCN18pNrFqFYVCqimMWM6dk6JkuPFn8N0IbrnTwDeWtaq/wAWxg
         ftovQTLgAcZN4372gT2t/EV1eELtitRXYVz1SsEB66DH0ZiFxm2T2thd8Afl4jYWKx2I
         3VTG7AGbhVACwqH1Y3A8x8r6+4nkGRcg9ipiHTwtqkiKo4AXJhv4A9hIdApLwRJcTXhy
         cJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150107; x=1712754907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPbrOyf+WH3LEFByBVjd+RN6Vyy+2vOeO98hIRaqQ9s=;
        b=MzzU6IdLnJkNMLvB/QYE0hJQO9PuZTcA8G2MZGXwYkwMbFiv1RJeAAHXUPxVYq8+M/
         p/kF1vvnQ56nGshqHauxrDdBUSG5ZZO107uwDTUSfS2KjpjAdM+D0uxgEnrPbku9tOUr
         yK7yPxVcvVcI6R7sinJ2gRp1kHceDw9Wm+51pgX2WzruyFdqrHfHirjeBbhLZ5jl/c+O
         jDFAx6JLFKxh/LC8d3E46lVlG/KYcSuEyue2d8ff4GNW7RT8WDVmkNcUaG3nYyuW6DDw
         iPtGUBOaf/F+dLlz3UXNW5S+Q3HC+MI/ZqR3oAlpMOOmgy77WrVl/O2ZDLLE2sboL/tp
         UQBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQwovOiAColtPylBn/RT4HUPNrUvmAYi+AGCpw1PCs31V1l1ineGmDkRcBvn5WeiDfkAid8XD5PXO8HpbXPqKOmVlzrjT3JU/qRdOg
X-Gm-Message-State: AOJu0YyaioWOXVCjVYyorMDT8NtHxd62GtjV0em5wbwfw0Y0SZozljt5
	uT004e/47Adu+XeAnHG79wkP64X14XDBPxTdt/JOpH32+xISbT49F3/yHFmH/jW1X40FAGZlvSR
	948VOa/zBBpNu0CLX3+dmFCe9as3L5d1SCxu+
X-Google-Smtp-Source: AGHT+IHynG/6vnesdgrFbSespFgf+tjzJxeuEecAnZ9LoEzbZsyl/DJ98pbGh+3WDjfxscRbv5KPEGx2DICPSrmMYeg=
X-Received: by 2002:a4a:dc98:0:b0:5a4:ae86:118f with SMTP id
 g24-20020a4adc98000000b005a4ae86118fmr11506801oou.8.1712150107554; Wed, 03
 Apr 2024 06:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>
 <20240401-redewendung-retten-132ff0ea272d@brauner>
In-Reply-To: <20240401-redewendung-retten-132ff0ea272d@brauner>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 3 Apr 2024 09:14:56 -0400
Message-ID: <CAOg9mSRa0PnFHSJAjOO=kjJKEG1_usREYO5QM+_Wt0VYsbVf8w@mail.gmail.com>
Subject: Re: [PATCH] orangefs: cleanup uses of strncpy
To: Christian Brauner <brauner@kernel.org>
Cc: Martin Brandenburg <martin@omnibond.com>, Justin Stitt <justinstitt@google.com>, 
	devel@lists.orangefs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi...

I b4'd this patch (I love b4) and applied it to 6.9.0-rc2
and ran it through xfstests with no regressions, so please
add a tested-by for hubcap@omnibond.com.

Thanks...

-Mike Marshall

On Mon, Apr 1, 2024 at 4:53=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, 22 Mar 2024 21:41:18 +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > There is some care taken to ensure these destination buffers are
> > NUL-terminated by bounding the strncpy()'s by ORANGEFS_NAME_MAX - 1 or
> > ORANGEFS_MAX_SERVER_ADDR_LEN - 1. Instead, we can use the new 2-argumen=
t
> > version of strscpy() to guarantee NUL-termination on the destination
> > buffers while simplifying the code.
> >
> > [...]
>
> If this needs to go separately from the vfs trees let me know.
>
> ---
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] orangefs: cleanup uses of strncpy
>       https://git.kernel.org/vfs/vfs/c/fc10fed37526

