Return-Path: <linux-kernel+bounces-131909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1B898D80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0044B28A84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD112F5AA;
	Thu,  4 Apr 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THdJiLxO"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E857129E88;
	Thu,  4 Apr 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252921; cv=none; b=fpnOoblxHUL9/Uc8xCKrvKUbI617ELdJLte6CZxMrHbRC1WW9J6So2E37PhgFAWoTQtozjWw89ktqWhNnhLBLtg/vuWrvii7Vsyi/8i7ypozCARJmdqvS4vK75MRAyGJqiG9cy0rOTlVP0Ykl3JFMvf99kU4uySsCBw45CUPK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252921; c=relaxed/simple;
	bh=vI4MrMdOzvU45Up4bUbJqH4cKKBdKrNwuFYQDyoAvgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta4jCYkWiF9TL/n7BDzwmdbdqF5gv6nm1+/YvC/NU35rWxwtD8aicOHM/40j8EFFiYxH7PvXmDKuQ1ORSy1KPrZTOkBX6J9IJ1oFyyMW3dmieqHp/wInapnS28Tk5U56hF4L/X1IKVlHEizeY+c4mUjnCG1KgEQ22dcO3tvgsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THdJiLxO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a2474f2595so992595a91.1;
        Thu, 04 Apr 2024 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712252920; x=1712857720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI4MrMdOzvU45Up4bUbJqH4cKKBdKrNwuFYQDyoAvgA=;
        b=THdJiLxOtd45CdBOa5lP3B7wGUPMMqH9QU+JNjtZB1HGMq8GJTSwJXPZDx3/+4BL4D
         gWNv6Z/jRzguwRA4mAi97VJHU6Wp20/myxTl2zMDgfdg7OnadGG5glSDMggcONddPO/T
         6SDgvhuTIC2wPrqeH8SwVwgiI5UxBCpWmOnz/yefAzapKo6ywm1gbUy/ONzXWw+BoCD2
         uYTzENDarPILW3OZexlaiC8IOtRgHXLSPB+SYSTYXy08Lb1EJbkXEgdGqxdWKxNbXYJ4
         z+IABgUqD/tUPGBa5j8vwmDIjYNoA5dKMNa7AmGNsrvLW1NHCxdg6mnrPbXDApO6Z/wD
         lcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252920; x=1712857720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI4MrMdOzvU45Up4bUbJqH4cKKBdKrNwuFYQDyoAvgA=;
        b=xHCRYjVyN7Ntpk19wPrzPzVJpdSeDBNIm9rj7cuaqpA704MwLQ5u3c8fPi90lfHmvJ
         Gt6/YzSLXWotGdDzw6D+miBxiV2EJDLnEes5PG3JLiESWYQtpIgbEhc8/izbZXH8AFq9
         6x+y2QWREZGSdLUOgi4wf9rHlMEoH8XpkXEcwucedLP5+Wzl+UxSYEL8Lkx+WixxkX+G
         jAVicP86LZBpW4IymVqLI+hOK8IU4BtpliYyWmhZk3rYiBiXgfzcgvP9K56doyLqkMxV
         ELm87zg5rxPn0Kp5Bn1wLk2zAEPNu6HfOuUqOQcyIeAA++wh/oJBlKCg9j4MCU3D55wh
         J+bw==
X-Forwarded-Encrypted: i=1; AJvYcCUTfple234HKuArmpHKmjD7q4t84VZ6lcxYlB8Bc/QGkq2mVN3JKCmohkQDELdW7EkujwKSr3NTlRKYOZmcKPxxfnMd+o/KYFJveLjFdx1yMDOw2KLfPt02x7seRk4PYnGlOxaWFsIotWCSsv4uqBXGW0BMpxyHXpgfdFwv3opo5wPL/wA=
X-Gm-Message-State: AOJu0Yw0xLLrKaWwzc4WGah+KYC7ezSLwrm3WT7jJ8SxJt5G3GBOKLkI
	Or+TpLEmRsRCzGCP/kMa1xxAq2ERLSWqJZyqbY8OdSXq+WhwiFKzOGYTW7Rz8bO8GePCRRTMn/5
	Lju62R6diioQZCxh1rqDsRN20Hu8=
X-Google-Smtp-Source: AGHT+IHlscXTFbzvBDaANjdzeyYIU2Bzi1Z2mFW5dyNypC3v8GETs6/WUkm6FkEiMiVsMdRl7+HJ3JxRl5EHvirEJQY=
X-Received: by 2002:a17:90a:e604:b0:2a2:ba9:ba61 with SMTP id
 j4-20020a17090ae60400b002a20ba9ba61mr3674127pjy.34.1712252919635; Thu, 04 Apr
 2024 10:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud>
 <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com> <CAGSQo024u1gHJgzsO38Xg3c4or+JupoPABQx_+0BLEpPg0cOEA@mail.gmail.com>
In-Reply-To: <CAGSQo024u1gHJgzsO38Xg3c4or+JupoPABQx_+0BLEpPg0cOEA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Apr 2024 19:47:57 +0200
Message-ID: <CANiq72k2HQHesGNaU3_yFZ7j8SKtWfZDAWdfoCDxo_bOEyn2ew@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Matthew Maurer <mmaurer@google.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:25=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
> This patch is fine by me - the last patch needed for KCFI to be
> functional in Rust just landed upstream last night, so we should
> revisit this (in the form of enabling it) once we move to
> `rustc-1.79.0` or later. In case anyone wants it for local
> experimentation, I have a backport branch [1] which applies these to
> the 1.73.0 compiler and enables it in the kernel [2] (not upstreamed
> because the feature isn't yet in kernel's `rustc`), which Android will
> be using for the Rust binder driver. This patch will require a recent
> (last year or so) clang, as it relies on
> `-fsanitize-cfi-icall-experimental-normalize-integers`.
>
> [1]: https://github.com/maurer/rust/tree/1.73.0%2Bcfi
> [2]: https://android-review.git.corp.google.com/c/kernel/common/+/2930616

Thanks for the update, Matthew!

I guess the public link is:
https://android-review.googlesource.com/c/kernel/common/+/2930616

Cheers,
Miguel

