Return-Path: <linux-kernel+bounces-168177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B278BB4BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82A91F260B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD52158DA1;
	Fri,  3 May 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+n7AbYn"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B3158D88
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767810; cv=none; b=TGdW891eqWMjE6Z3rFbaYEL643uYCY5CkQlhOatS3q0gCfg0NK2rJNO50RiCoWU/BhLKDRsduk0Kmvw7m0XsNOCkexUFSdqH29tW+TPkMqqT6eQK81IUQgeauQ/Ub7NM2lOWq2O5r+rFhOBKHb5ZkjErMyZImml3aN9FzDmUwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767810; c=relaxed/simple;
	bh=5dIcFgEunJbX7jK5o6sgRQrbUTHAIMYhrVE6vaWwB3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbL7Q0kyZzcZ0yD4+5KQIWabM7v70Zg3ufmQzmCpH9QbHAWDtNxyuFO+CjW1M5tj2hkVR9y1xfR8dsqETo3vhjUlC7/gProLp1qMBt9+xzcn5HieAbRB8uUOlPg/vm59k1+d298oNWNOh1/ods85hK7C5KIVCRK1d8/A+vr7GhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+n7AbYn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de45dba15feso94517276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714767808; x=1715372608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRmAFj/9U+Uajdd6x3M/dD18I6JWR5bc4eiv7eGP42o=;
        b=L+n7AbYnfNbM3nmDZLXbCtKQakXgCoeKkOrgqArhdL9/FyyjPFRC3CMx3cTHy7z5Or
         av5MA2jnDuQdqNKamre69IwrMF0qWmz6jg1XSpvbEQX6r2FohrNpLRIh+CbZW96Fybq1
         1JB5UdikpapsOlL6F1wtkGmBUFxi4Cw4T/2NZV7qUJSlh/XSQ+rRVyOQNMNlrk0dA/cj
         HH8mMzX1QU2UUzADeEwd8Ea8eJC79jaHiOgzCQiS0a2F3Zx3TWayWDR3fVUYwdmMb3NG
         9Mr4DCaMUvkwoHPpBw4IJkx18MzMB7GzWcpHl8pItRh2zVBTbVAxPRx5rN3L8i5I4NIq
         PjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767808; x=1715372608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRmAFj/9U+Uajdd6x3M/dD18I6JWR5bc4eiv7eGP42o=;
        b=Q21Q03l3/qoLXDxg0DDcFy6JYk1yjLWx6wmAiUKCZ48BnXojQB2idstvvf2g58VVix
         qStHwAAlM3wVQE/dZTkguAIHRY/7F8ns++vRo3+AkH78+YvczSm+iQzpD1JBw2gymszQ
         HH5Hu2Qdv53u1g2PP86zDS/GJ5ypX482MBgI5fkLdDgFygUMIPCdu7aJZvnCnGzySo1B
         5biNpLk/oOe/p3xItO9Am2lXYETvbUIhlKBG0hhbvvqaAlgJHDHP+lW8bKgDtst/4/V6
         01GEF0fkDiGdQtSRH0WgmMZLDHHlheqdxVQLI81KpstKlZDfCZNLwEAVgD2WnsknCI5b
         7Dug==
X-Forwarded-Encrypted: i=1; AJvYcCV+FltZbPQBrqPc/KZyjE2HUtEf1sKMoTRwLGVqhkfeTgVDgI/zVJ5GFDFMmFcrV1sqjxRtV84WWaFDt1ouR0oBnppZ9WaF49UGTBip
X-Gm-Message-State: AOJu0YzNStBeGELlVhgGXmyHb1LkAPTbNkHbORdlBY4FgEjKXPg8rXVB
	IWgBhsj0cCde1hJhhpNcGxNqmWjKep1YCZmMCvB7FKAT9n9MjT65C4tBvrtE+scbfc/MwuJMDx6
	KdruSxjIho+127/F9qeIDkzUcqft6OoA2QdV+pA==
X-Google-Smtp-Source: AGHT+IGvQha35/imk3620zAp+cduQL37Ue4t9pcxEoFaRdg9M7Ew2+UWFyuG6+rsdeo7pK2XRYbn1ArX9BPa00SR03Y=
X-Received: by 2002:a25:698d:0:b0:de5:4c3a:5ab6 with SMTP id
 e135-20020a25698d000000b00de54c3a5ab6mr4052983ybc.3.1714767808227; Fri, 03
 May 2024 13:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
In-Reply-To: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 3 May 2024 23:23:17 +0300
Message-ID: <CAA8EJppDNYR1D4NacrurY2e_xf5ycrtFBAAWaB2QVRBgSMESnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/msm/gen_header: allow skipping the validation
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 21:15, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> In order to remove pointless messages regarding missing lxml, skip
> validation of MSM register files against the schema. Only the driver
> developers really care and/or can fix the files.
>
> Keep the validation enabled during one of DRM CI stages, so that we
> still catch errors, introduced by mistake.

Helen, could you please ack merging the second patch through drm/msm tree?

> ---
> Dmitry Baryshkov (2):
>       drm/msm/gen_header: allow skipping the validation
>       drm/ci: validate drm/msm XML register files against schema

-- 
With best wishes
Dmitry

