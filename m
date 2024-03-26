Return-Path: <linux-kernel+bounces-119631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5888CB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230122E9565
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403741F947;
	Tue, 26 Mar 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLRXkW16"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BC482EE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475462; cv=none; b=pu4V4JzXsgdnSoBCybnUx/r4fXuXnBOVQkGRHOPWQxJsErSkygWl5eO3gTORvoLjx6PbqcqyEV7z7vEs7phwwt5td5oYhtpQcFgWMacZWMsXjY6SPqpNYvHjtAHEmFqupXa5IHaUx4JL+PUF2xxB5yiFMANSGzo4nrvgW6uKVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475462; c=relaxed/simple;
	bh=DS+ZVIzfQvfy1mAXlWWMX/Uf1EBmJvBo9ZR6tzEUzmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EP9/NUCd4Rr8mbRi9AkNi+ICPdayqy2rZwGiimu5m12mow+RJRLxM+E81IVH8f5D5Y9HV1KDG4A0iFjIUWDgIyIEBLqhOPPS80ZnG8Gky4WoEGUvDqTKf82cOwoGO0CAgAOss+9rIcYwGyTc2POdVWKqaBPBi3m/pWg9D35MyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TLRXkW16; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db3a09e96daso5427438276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711475460; x=1712080260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQt9uE/ppvfkTcIqGMfIYXRibl7GWLCliTRuigVWPgI=;
        b=TLRXkW16NBLpqOjOFbMpxP6i0yXNfkCKMz9rlgSkfmThbsxGS4bQHcdmPGTTHgUNSt
         8UAaZyTIE6dQibKtu3cDk9ANkJxfPiHn5NYlQ8HdqbGzk2Divili8ViBkbrX+oqz35Mu
         IoMsLKwQK+yUNBpOMBHvuaofzjBi0Uz8jEV1rzxSU5zg6yao0ywZjBkVij3CsT9DrgUB
         XiMnIbO4Ju+k15VcudtdnIcA3PHMdgDCv/E73Rmsi9qXTG4ScUx9JeYISDjKx1ZpRJrp
         JGYF6huxr+kG2qlPeUud9/xzrUxIzhkN4lsyhUdSc0Hy15Hx9tpzOUB01fBkfvgwRQzM
         bAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475460; x=1712080260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQt9uE/ppvfkTcIqGMfIYXRibl7GWLCliTRuigVWPgI=;
        b=Xc/1K3514wh16MJ7fZJYWCGZYPSzMan7TKfVG/9eVauECadPuRtbrjfzZvZxj+taZX
         O7hnViU84pO4o3dPbtJ8PVuZxVuiJsn12sAdmuHmOuHmtmsSRL3ouXtHZDxNK7ccyYJ4
         2R/eDnDJQoN486bypf/WhfVTFDHRZOKiioSQ1MVA2ql5rm9fra7itKBExsbHIwXJ/vFl
         qZ1chLNU56VoX4zBYEIZo64mTXfMGr2ipPLR1/76mZ8GJYdHaMcGdXyQqHC4/nYXIJlv
         9ReceLq1t3365KNaU88ifqWoBwrl8AOzKDTHfYTcXkg6GWL4arC35AxOA333qaty42fd
         rz9w==
X-Forwarded-Encrypted: i=1; AJvYcCVpfHf/ZwelkQf9AHy4YzNjVQiE44lSPknC3aQiWP+dKoFcC88I2nxbSYhVWCj/AERBRq3GjJwMLryiDLxAgBQuEZ8gLieJioqMsDXv
X-Gm-Message-State: AOJu0YwkKK6yBecYAIvKY0K6EGDhyV7sEZzPfYk+3n3uQmq5V77P/7S+
	F1nm8Ghp+FH4R0yq2A4JJFiE6+Gto60cPpTF1kFr8nd0ac9BAeZoz8kqewpXvCZqdC760tiLBpA
	zYCWBHWg9HzDI0htUHOY6eQenee5+fNNjrl+dKQ==
X-Google-Smtp-Source: AGHT+IHgaKfWmnWc7zIsttUGrVkvAZrzsd0nsGPCX83cPi+b3E0jY3GMekdJomBN/FEgwvmEt+1EzeQQuU9eKhkIlew=
X-Received: by 2002:a5b:590:0:b0:dcc:7b05:4cbb with SMTP id
 l16-20020a5b0590000000b00dcc7b054cbbmr8591652ybp.31.1711475459884; Tue, 26
 Mar 2024 10:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com> <20240326-msm-dp-cleanup-v1-6-e775556ecec0@quicinc.com>
In-Reply-To: <20240326-msm-dp-cleanup-v1-6-e775556ecec0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 19:50:49 +0200
Message-ID: <CAA8EJpqce45f1Q+speRQo6NbtEtMq9BZWx36pbTAQGjjTyWCoA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/msm/dp: Use function arguments for audio operations
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 17:06, Bjorn Andersson <andersson@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> The dp_audio read and write operations uses members in struct dp_catalog
> for passing arguments and return values. This adds unnecessary
> complexity to the implementation, as it turns out after detangling the
> logic that no state is actually held in these variables.
>
> Clean this up by using function arguments and return values for passing
> the data.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_audio.c   | 20 +++++--------------
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 39 +++++++++++++------------------------
>  drivers/gpu/drm/msm/dp/dp_catalog.h | 18 +++++++++--------
>  3 files changed, 28 insertions(+), 49 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks a lot for the cleanup!

--
With best wishes
Dmitry

