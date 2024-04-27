Return-Path: <linux-kernel+bounces-160888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B38B4411
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF991C215F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1C3D387;
	Sat, 27 Apr 2024 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFGovkoV"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E23C06B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714191867; cv=none; b=uvPW6RqdG6hqkGoDRkJkTlo+ct25G1xUpItUxm5FtCZ0IjoJvAbmFFT73VdVdZSklC/JqMpHprWlcagRxzwY3Xl1hF9dcsIUFbusSOLV+wc9oNMMkQO4IJEbbTvYoWprSCBimKM2EKD5WirGOzHMrAhotFeIy2BdVnP42yD3oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714191867; c=relaxed/simple;
	bh=GF3vuRGY/dMb/2+U/QCXGtAoTBJg+SK/sms8ndt4Nq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3c7/TXFetee6OBpja9zUwMQ3SZ25LaSOHhTVzVdL+ViVxEx/myk9d4uup31X+d8EWVNq29pvLTrquM1PdWyvi5zmTbG/32cbIbXskVMlChObQQaGDmFfTEgJLKJmNtSmOfzXH/JkiMCAnK3xeNjXlrWT0w7L909dcg4bq2e+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFGovkoV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db13ca0363so43815831fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714191863; x=1714796663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNxrgthpetuuJLIByo953//VQpDMU/PX1l8amEjeAbY=;
        b=bFGovkoVAFazBp8+HC9vaHz7phaaQo0Xqa3TB6AiChFGW7zVBU8DYgI5LZW4kgIoc7
         e7aDEhil2fnR8aoszNytgKVNzAjjI42FpFA5Hm7x4fORXF5rXfQqJ+qBIAjOuATt471w
         LW5Tr3BlTb4Dh3bLtHfMaZUJPQT05XXBes8bts+4nCdf+Fk5K+LO+68ZeF8wfcP1wu4d
         b0y4NyEGsBrRKi0TQq5VNEPPwnm1ILbPEPzMiZuM1XNJPiOaJHYB9QppNmx4h2mgVY5h
         Ox/U/UtqCPmUtT828F5jtBENejgUAjIHc4RCtqYrMB4nU6WPb85TVRree7OBv4i9sqM1
         THXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714191863; x=1714796663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNxrgthpetuuJLIByo953//VQpDMU/PX1l8amEjeAbY=;
        b=uD3Gr18pK2e0SMShkDS8n/sai0SEbNxyQ5heWsSdF8FPew4kJkFEB3rR+pQ0FXi44n
         Vs3IwujiAMjoeqkNzyMEgslpupo4rSaANAb5utaRgPl6LmPgjx9EtD5fETp/88RPi2Ik
         0YGaGDbhKhGlJQanWY5rpyUJp3qwta+1jzrEJVjN5oufL2ETqigYI8GarskcXt1g8bMs
         CMEa24+WZVAQc8EYW8O0BCWM0kN8TAMzDdBOlXj5kcgehssnxsKWB3EaRMcIjeWw2Lfp
         +Pt6iMQwP46rTv0lZKcPT9uMudwhV8h7xj/jHhaX/Mk/yIoQ5QXcrbqTOuHKP2znd6e7
         7A2w==
X-Forwarded-Encrypted: i=1; AJvYcCUe6wP2Kj9DPjRvVjrntUMxuWIZpIOwCtUw8WotoI69AhDu6G83ZaHjuaOSdkroMVeCksO19k7zXdyzxUmuToJY9HY45PzSVJpqQGpt
X-Gm-Message-State: AOJu0Yz33yrzQp2ktAM/wAtV8oMHg8wuMdbeZxo2HfmUFNfPv2sIqiX9
	Kt33AN1+o16r9Rzs6xF110XydivChQFxe5GFLfdJ9uBXtPVTiBmm15Z7KPNqnJfPFHeC+e9M5ij
	XAjnI7GWXYw+DyO//Tju+2ghWyizzaGzWgkhz
X-Google-Smtp-Source: AGHT+IHo9p4JF6aSQDhZ+sGs4DSm+21yCY59QKzJAfgfI4cda+xzrQHekeg5PgpFIA651GAjXQtUPVUubZs18Io42GU=
X-Received: by 2002:a05:6512:20ce:b0:51c:71cf:efc9 with SMTP id
 u14-20020a05651220ce00b0051c71cfefc9mr3280756lfr.49.1714191863232; Fri, 26
 Apr 2024 21:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com> <20240426160859.0d85908e@kernel.org>
In-Reply-To: <20240426160859.0d85908e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 26 Apr 2024 21:24:09 -0700
Message-ID: <CAHS8izNs-LV=6FE39sjF3V7qVfveOsOAOJ_X62TSzWpvamsS0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Apr 2024 12:20:59 -0700 Mina Almasry wrote:
> > -       if (recycle && napi_pp_get_page(page))
> > +       if (napi_pp_get_page(page))
>
> Pretty sure you can't do that. The "recycle" here is a concurrency
> guarantee. A guarantee someone is holding a pp ref on that page,
> a ref which will not go away while napi_pp_get_page() is executing.

I don't mean to argue, but I think the get_page()/put_page() pair we
do in the page ref path is susceptible to the same issue. AFAIU it's
not safe to get_page() if another CPU can be dropping the last ref,
get_page_unless_zero() should be used instead.

Since get_page() is good in the page ref path without some guarantee,
it's not obvious to me why we need this guarantee in the pp ref path,
but I could be missing some subtlety. At any rate, if you prefer us
going down the road of reverting commit 2cc3aeb5eccc ("skbuff: Fix a
potential race while recycling page_pool packets"), I think that could
also fix the issue.

--=20
Thanks,
Mina

