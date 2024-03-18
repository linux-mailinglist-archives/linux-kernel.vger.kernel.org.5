Return-Path: <linux-kernel+bounces-106568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6987F06A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619691F22785
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F256470;
	Mon, 18 Mar 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDlDzAPt"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC056763
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789992; cv=none; b=YgFpSGW8vK9UBObWDQBYgK0vtvu/xsOIg5884Cv/Y/3nyY2cR4gdajZMjJd0vRWBb3HHSqYdeMn5i0I5BktSwpw/IRxQfjIZbqnlYObusH9X/vvaGPgZG9uTzobhgg/5IkvKsgwUnRf8ARnBd6lrrOmYDWEdpByLUGDCrp26vUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789992; c=relaxed/simple;
	bh=xvwBqy02Lt//XY7TKf5p6Szodv2siVQMtlWkmKgSadE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxsb7USwrh6zSni2ma5pL8iYpHV/39Z2JJfl/PVXF9nkTpxEdXplYpXx9hkOMP5xGP0Ha9bWJgjMUrJhRByYNTIrT5bNZfvFRoHiTIKOc1AW2JBzfOX/imOg2OZ6fvZ47blMTYfGO+jZw0G6IepVc0vNP0DMq7Yz5LWVucaSqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fDlDzAPt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so18554021fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710789988; x=1711394788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvwBqy02Lt//XY7TKf5p6Szodv2siVQMtlWkmKgSadE=;
        b=fDlDzAPt18Ei8s8QtbQPupUnvUc1kL0d5rgaM5yfoLBBypKUG4zj98gKcZg9J8a1Nv
         nnL9ECUdf2gu+a17Hw5Dxkxqir/Kw0jHBIINKFB8qtYheaERJdzstJGzRC+nmtkb4lU2
         uEKa9pdMuHgLG/EI3+dnxasbkicna7Vne6Gu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789988; x=1711394788;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvwBqy02Lt//XY7TKf5p6Szodv2siVQMtlWkmKgSadE=;
        b=p99u6S5iGB3bUVvJXQxnwZyH8o+43vcDEYeWezB2BlWo1gLiCYX5rxlVw2RRMEoACX
         DUqfdjKWBKWzNDcvB6iyZfRLKSUEz84s/ZegnrqIab4RIOiaSi4GgE9D2wotAnepYxVV
         G/CCqafnbOM2eyjGd8P65DuoJF98AUoIJNGWetLUJojfpFEhEbZGLpwgJu8LDOkln95j
         AjQEuaKhzTTwyr3Zj0Pk+lLBdW0rRrD9V969QDH4LsEzoECrPzHVlTc1oai42BpyFLmc
         TOwPYZiz7VS3RlsaAqkkBvqodc7uFJ7WeHsaSNpXl+6+t6zLwLdEh99gPs2fpv/gRu6s
         Jxcw==
X-Forwarded-Encrypted: i=1; AJvYcCWb6hu7PSFZF9/u2uZrHNE9UWrBzirh5bZchrqFGEcrYFEeTnOZQxwZhcjCcvPnO6aES1AKQN7+K1WMpu3Z34l0WNOb5MfnXBYa8hOV
X-Gm-Message-State: AOJu0Yw4wi1/z0j8+5LqtwTdx3N3fz5wUQ+jNcqCqPmYOS7KK4C3KjBf
	uWifPgP1+3KMI3h4l4M737KTzYcuzZRzEIFKNosKKZxQlwHxx/jRl5xDUJ7/33UBt4cnonAQ4fJ
	DXKrhZnQJt9m73VtMmkwbUR55gzoIn97+mpQj
X-Google-Smtp-Source: AGHT+IFe4SIqBk2a4Gcqz06qiXmOLolMnAnmlf22UjLfTc3cWz8vho8vUCaBS8BcelwlfYICaPBpPRtqxlh+N67N26o=
X-Received: by 2002:a2e:7c19:0:b0:2d4:b061:d9f8 with SMTP id
 x25-20020a2e7c19000000b002d4b061d9f8mr1711566ljc.39.1710789988109; Mon, 18
 Mar 2024 12:26:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Mar 2024 12:26:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240315143621.v2.4.Ia5dd755f81d7cc9a4393c43f77b9be4ed2278ee3@changeid>
References: <20240315213717.1411017-1-dianders@chromium.org> <20240315143621.v2.4.Ia5dd755f81d7cc9a4393c43f77b9be4ed2278ee3@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 18 Mar 2024 12:26:27 -0700
Message-ID: <CAE-0n51baqN8cEubSqDegqDwL7O6=iEfN5Ho2OykqjmkjQDcvQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/msm/dp: Fix typo in static function (ststus => status)
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2024-03-15 14:36:32)
> This is a no-op change to just fix a typo in the name of a static function.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - ("Fix typo in static function (ststus => status)") new for v2.

This was sent at
https://lore.kernel.org/r/20240306193515.455388-1-quic_abhinavk@quicinc.com

