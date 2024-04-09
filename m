Return-Path: <linux-kernel+bounces-137379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191489E135
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42618286465
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40815574A;
	Tue,  9 Apr 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgpnfeFN"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6312E1D5;
	Tue,  9 Apr 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682735; cv=none; b=VYBjRbEqMPSIU8AzBaGXC6CBNXQrBm0QZMxkyaJknn3JfClAZD93wcmtKT/uF6f0QHw6eQFlgxL/LKE2ScefDP4XLUPrQWCoqPZjhl17lv22I3QswAJtFZKTlmkRatl9lUgEfNWBr38GsHKeTdA8DMG+kii0lb17NUbowIeM2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682735; c=relaxed/simple;
	bh=avtQoYEPbu2+Jr0W5m1ghEuAGynrnjvGqeyVENfv9tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA5DTzNjVWzDlA+CySAg8GT2+JWRYfFXJXALXrkoBHHcD8inBsDSU005AGQHqL0Nwvxil90MwNgH2t3LjtZFniPQcrbEFysNSav/WZxsHuIUd8IBYK9I1ovLB9h4IQ2pFYjBwqBMdHuuzplfNBIqHnTsmgxUr3c2QJ5HHkqZwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgpnfeFN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso7900714a12.2;
        Tue, 09 Apr 2024 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712682732; x=1713287532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avtQoYEPbu2+Jr0W5m1ghEuAGynrnjvGqeyVENfv9tU=;
        b=RgpnfeFN5RTt9XLtfwViH4g2S0SpXVv5rBHVXvdfPEP44G0gSYJrkp2+2pDyn3CjBK
         GSy7G6JE1PzB4haSCZ9VqMIKOh1kRNASZrZ5rp7jDWIEEqaDwqwYDgnA//5XS12/iCYE
         LwB9cDmz0V3CBq7w3sHHcaLtF2m8nFQtbc5+IgJkEGP8rGX5e8+Bcwg+0DrS8ZkWdVEX
         AgrJR3B27DHM+VWIugiV1URbz+O9Ug8SS2CNwJXYd8wtwwhIFr1GS85tCPuTerMQ4V12
         gdx/sX3yadrDm4nsjsP7Tk8xNVmb6h4G7MVftJbEGbci27cOX+eZlAZaEW9y6DWbzDlL
         NayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712682732; x=1713287532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avtQoYEPbu2+Jr0W5m1ghEuAGynrnjvGqeyVENfv9tU=;
        b=k/YQ3z4n9xQd+huRLLWpp9G7k7zaHxIvH4vklN1UZNMrwcVP2bZ8fufJmP9AeNXIqD
         R7q474k+ybnLqtBAs4ckFGxDGshJxOIXGCdWRt+ZNpvQtMB/36dJNcukkw00dJfNUBRR
         pAgBOJdUusQO+beHVm61uetnjs7o2NauVleUyqG9xTclayMxo2p7F0SjztDP5YYbaXP7
         2s66TN5Q9B84/zQa2Y9ERoulIz7Azk695DwaZA4oATW65F0AnN8KCyY497DfuPxQf7A9
         gIvqpVxpHkgN/+uNJxQiB30E0DaEV3gWIc3OJu2eyOcCK6gEmQsT6qc1TSHjryLETvQw
         YNEw==
X-Forwarded-Encrypted: i=1; AJvYcCU8l1o7VpMMEyLxFnDr/zdUZN3pvYzF4HimJwwdgmsUpllBS7KGLt/xmUgok76kFLE0agXaoLnSsSqn50kjIWx6S46/R65sdPV5hlFniS/q7DwMFXV1B5KX3aEXkEeb4kBbXPNz8FxgQKlpKl71aI3/pXmg1UBFH+SO6gz/w4PfyRgxJboIh4o=
X-Gm-Message-State: AOJu0YybLNUc++3WQ6kjbMugMrtOssRSU/e+SQHdNqEqldc420PVsLQ3
	sTW/mmnqs6S8TW8JMUpnEsWg62c1s0Nj4OBkPq3eqzcozE84vuSQtOrOAsSRRzfdiVUJ7aBoxk+
	872PVo/jL6Jsh5wRrfNKPphoWOag=
X-Google-Smtp-Source: AGHT+IHDsDzpN80Q+dT8Z1O9ekHUAbkM8i2z9y0uAzBM2Co9XDpeUNjqG0qPrG/s7Ymg03pkuU0oARufzvBH2JCkaX0=
X-Received: by 2002:a50:c305:0:b0:568:b622:f225 with SMTP id
 a5-20020a50c305000000b00568b622f225mr85452edb.30.1712682732145; Tue, 09 Apr
 2024 10:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
 <pncr7ecf4eir36skul3iwt2nf5bpuwd5zjfzzfwwnxjwe4hoes@6z2xe54crijp>
 <d8a2ef87-f29e-4bdb-a9b8-591b8bd5d2b2@linaro.org> <tkcbl2iwcy3feoggbk737gx32qsxe5p4ad6lfrujy2pazccrhm@kif3guuzay6h>
In-Reply-To: <tkcbl2iwcy3feoggbk737gx32qsxe5p4ad6lfrujy2pazccrhm@kif3guuzay6h>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 9 Apr 2024 10:12:00 -0700
Message-ID: <CAF6AEGsg2xCCC27t_Gqu=MMQ6tckVw=Zj90p4x7EuOm+VKA=ig@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin value
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:23=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, Apr 09, 2024 at 05:12:46PM +0200, Konrad Dybcio wrote:
> >
> >
> > On 4/6/24 04:56, Dmitry Baryshkov wrote:
> > > On Fri, Apr 05, 2024 at 10:41:31AM +0200, Konrad Dybcio wrote:
> > > > From: Neil Armstrong <neil.armstrong@linaro.org>
> > > >
> > > > Usually, speedbin 0 is the "super SKU", a.k.a the one which can clo=
ck
> > > > the highest. Falling back to it when things go wrong is largely
> > > > suboptimal, as more often than not, the top frequencies are not
> > > > supposed to work on other bins.
> > >
> > > Isn't it better to just return an error here instead of trying to gue=
ss
> > > which speedbin to use?
> >
> > Not sure. I'd rather better compatibility for e.g. booting up a new
> > laptop with just dt.
>
> New speedbin can have lower max speed, so by attempting to run it at
> higher freq you might be breaking it.

Usually there are some OPPs in common to all speedbins, so picking a
freq from that set would seem like the safe thing to do

BR,
-R

>
> >
> > >
> > > If that's not the case, I think the commit should be expanded with
> > > actually setting default_speedbin for the existing GPUs.
> >
> > I think that should be addressed, although separately.
>
> I'd prefer to have it as a part of this patch, but I'd not NAK it just
> for this reason.
>
> --
> With best wishes
> Dmitry

