Return-Path: <linux-kernel+bounces-90338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D388A86FDE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1187E1C21B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4DA210F8;
	Mon,  4 Mar 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChogTRID"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820451B7F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545513; cv=none; b=MZklwZTkeauPoXw8Wt7WbZKGjKOQ8LPCnIBKsc2vNtE+QDzpzfwHHgrAND1v6k2RtvzPPzfvlUAxmu50qtJ2b4oD+El6AJMJotJMmEDir+jGdDLcvZd8AeC00sKmk+RlcDXSYckHLHhviKBQ4yVVz+jugccCIFBi5OJBE00LNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545513; c=relaxed/simple;
	bh=nDfe9LdmYUu7ooEFf8+WqyNex+ko1P2v5qgCy8lQKjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIpBULBvP78X/mrzxw88ec9A9z9rN9GpbVboVMcDc61vR+2yR8bE8dAgZmvrcUgxdWyKEyLMJcW9+Z1YFMgHWSptUie9FlJp8ljdpFVMAF+hRynGYEjq8qWqrtvKhHY1AfiS4LxxGRrbB3AR1+w42+WKbCVj7EOjPyaHac3XVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ChogTRID; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4304618276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709545509; x=1710150309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G38jlOOjWdyF5F5/2JhgLPVjp/JQd8aCZTbhP3PI+LQ=;
        b=ChogTRIDMt1yug9BX6XYWi7AGwNuTYODE+CZP/4Ke8swPp3CC4O9MTJwu+0KaGcz3y
         yuXY8Zjc+2D0E5SdJt8xdT1f4imFrJ3F0vLXV2Majx0g2mNsitcJ5piaYGZbVdxfoq51
         8Iy3RVUa65hmJsEJxhqUq5Ahjcfq7wm5lgTs6EtZ4VgeEYP1+3JUdh1phs9gZtfsQUTX
         uWWF2Hmo7LoBxLoKb+cbDZTyrTH6b1mCnbMItj/avlNh3yEep8BUpmC3R0fvqy/oQsCD
         614Zbr7pEZ6UxBv1I2u+zHwYqqhffNegxKFFyWhVXOS0uA12iJDELdmxOVhEQAjZiyNv
         OOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545509; x=1710150309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G38jlOOjWdyF5F5/2JhgLPVjp/JQd8aCZTbhP3PI+LQ=;
        b=NQ0T/UcZXPTuDpyuxfpG/eJiwcrzXBy4nGLNk2JAvMWUfrQy4dhbaFsRU2n17OPZv8
         z7mN0HmxrX9SELUnX2ncvPsREw/CkdsK6NWsjiCan+q/Hcl9GrwRjoHlatmPKNO8JyCZ
         u39hxp3w10EVvtzvvxJfRwafbnUeMN3IwUR0/hzWsemLJXr+AhNjKxUo2WaVt3Hk+Y8d
         xCCzdaEor8fJal/Mv4bJHuwMYJnQ8Z36QD7BIpoHDX00HM3CYvTUdIsM/72lv1kDn0q1
         VRsJxrkti9QnTJ41G3g6tJNUgFK4msPpqnyoG6ESS3VOfpMQPuz9qlzJOeVswUqAHXAp
         W8ow==
X-Forwarded-Encrypted: i=1; AJvYcCWgB5C1ZeOyh1QoOD93lGyDahAsFHu0dCcyP9A4+pEpZpLmgGbhgdbitjg43ZnU/SVSmr9wHZDIVu0IS7FMyxEr9HnceVWwA9Qu51PD
X-Gm-Message-State: AOJu0YyggEVRMBxyh3K8agq6Oo8w6CFTLLAScFKbzN5dDP/7Kn1x2xmN
	meV0Y6PlPuChAeo7jtxu53ag/5TGETIwYMLu9LbaJfHyo7au5v0V/yIaBw8L4D85g8qliqLmPz1
	OpBumwFTK3nX8bjbsx3KhCX3fkfJQAVJLxynpfg==
X-Google-Smtp-Source: AGHT+IEB6xVfWdbAxpki5Q7d1ldQdkm96MPwnQOjlKKbuMgTXowcNWPDNc1CazVdJ5aCY6xTSuMxXPchvKcEkvfWLWo=
X-Received: by 2002:a25:6b49:0:b0:dcb:e82c:f7d with SMTP id
 o9-20020a256b49000000b00dcbe82c0f7dmr4198546ybm.41.1709545509594; Mon, 04 Mar
 2024 01:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228194730.619204-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240228194730.619204-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 4 Mar 2024 11:44:58 +0200
Message-ID: <CAA8EJpo1O9kDeYt_z9YHAu+nQXJ2XenejOGxm1fjED--brCWgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dpu: drop unused dpu_kms from interface initialization
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_parellan@quicinc.com, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 21:47, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> dpu_kms seems unused while initializing DSI, HDMI and DP through
> their respective _dpu_kms_initialize_* functions.
>
> Hence lets drop the parameter altogether.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

-- 
With best wishes
Dmitry

