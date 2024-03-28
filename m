Return-Path: <linux-kernel+bounces-123788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCFF890DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3442294DED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F8383AC;
	Thu, 28 Mar 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vT99pGml"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B617C9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666216; cv=none; b=SK/E/MaNQunxE7qMDFtVQaOb1ggjLBD7pcgz6dmObt3oCT5XR+QnlMHCJojzZw6ly8Ihj0oZ9MPgVbGF13ZnhcpLPcxBEApl43zjcROh3yEcwG8ubwD5hyX/vkhi1YnYO0X/5BVvJrc835h4aMf1G+4SkUxPy33c+0qOLTCB6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666216; c=relaxed/simple;
	bh=yoP3sHjaI3AmvFwFYVJ+C+MxnU497kh1zCU4RdsuJCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed7jBE/sXFHiC0N4lxhjxcv5tiSZCQylnap136cP8kgowmStMKlK2imSZYWazpZoA+fdlayZQFYtBpUHDysOYE3vmve54pJiza+UBAvu2CnHRk6iz7/M+gdbVC3Xykr7y6zguhe8AHXANwQVNoSizp9IseOHpnE4bEKdMTSDAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vT99pGml; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso1107121276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711666214; x=1712271014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaQuR2VabRjZ0oAgjAGPW//AvQ63fYK7rByYxplN6rc=;
        b=vT99pGmlKH1qv0sxpDso4yGuqA2YUgJshoGdNnWXoTXgQdmTEKwW+OLSkuOsJHmGdM
         ENl9Vd0tGa3pGXL3mcmnV4juLMxcNHJcnqpSqx1ByV+7ZBFuRNYMtKXmLx8rW49mCZqZ
         nkeymtRLxhpFozOidor2/8gn7tNpMvgEOrZKfY09JQ+WIpMGkRK0t0TU1uxw6OAIUGhY
         JVKLe3Mqz4J1+yjp0xpuQlPuCxbQI6XDSk6Uxbug4fC5hv64xxMToanKXxcSmpDvDWxC
         liwPvSMmjBQThqyzKN74MXZ//pn/2ocg0hfZ2PeMSY8XkdCffSdNAyn2qURXhgKwre3m
         K0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711666214; x=1712271014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaQuR2VabRjZ0oAgjAGPW//AvQ63fYK7rByYxplN6rc=;
        b=T3dpyYwgfxX65+KrIvJZ70zDYcK/4lTL2TKEvpMQGJQWm+kOCKBAVrMBoi+q0AFdvM
         b0b2D/Py+M+3STyWrXQgPgiFeoBFXgR7Hl/ZMXylMXekxb76xhw9In4HWJeKIjNcQ9AD
         S6kf/f06ISh86nWPdwBgxpAlA1J0rkdZdF2dAeqczmopfmFf84z6/IUBp5Q8WL682RHx
         0VptswcNeC9y3W7KXB5G552wKOl6Y9RMoX2KMO9fHOphnhU5LYa6wvuVoqfYBa5Tqeai
         C7dYURLoPOfr7xYCA+ql0Deygkne7v3R+VdXrtNIiEtqCC4ANCnT0BPF1qs3PnyqFlIj
         GEbA==
X-Forwarded-Encrypted: i=1; AJvYcCWW5dxMqgwYqJQRSv8+VhnWkk9YoFUhM5g7yOfDJNNBNzaNJRUF5Ew4kJrVbfeZ5X6NKWcfJqBfrdwvYpm51ooSNJU0tCBsiS7nG6MM
X-Gm-Message-State: AOJu0YwrZLbz+fE0X9997LBe/QNU6WDjkegeLedW+2wwC/YcGDpeQDxm
	uL3KRqmcbJHlwBnRC3z6RqwHfC53x7wlr7e8/ush3XhwHfYT0OHHHaJxBxJZVmeKg6MuIJCDh6y
	j2/tqLeI07KeuPk2r4CgOjMa2bpgXPUDHhi0yUA==
X-Google-Smtp-Source: AGHT+IHUMLL2iU8wC/AsSPxTtWu9xIrlrjkxQvLqc80IB8CQp05SICYUOEAvO++CEa4YtWB8E6zViYeXbYy3jssQEtQ=
X-Received: by 2002:a25:2188:0:b0:dda:bf8c:f278 with SMTP id
 h130-20020a252188000000b00ddabf8cf278mr702978ybh.47.1711666213923; Thu, 28
 Mar 2024 15:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
 <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com>
 <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com> <CAE-0n503FwcwreZ14MMKgdzu8QybWYtMdLOKasiCwmE8pCJOSw@mail.gmail.com>
 <23de89e9-3ef3-c52d-7abf-93dc2dbb51a4@quicinc.com>
In-Reply-To: <23de89e9-3ef3-c52d-7abf-93dc2dbb51a4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 00:50:02 +0200
Message-ID: <CAA8EJppEWXnsQzDD1tdNuMb1ijEVtE7LQct9jt1fwVwMd8ch_Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dp: use dp_hpd_plug_handle() and
 dp_hpd_unplug_handle() directly
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, abel.vesa@linaro.org, 
	agross@kernel.org, airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org, 
	dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	vkoul@kernel.org, quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com, 
	marijn.suijten@somainline.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 23:21, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 3/28/2024 1:58 PM, Stephen Boyd wrote:
> > Quoting Abhinav Kumar (2024-03-28 13:24:34)
> >> + Johan and Bjorn for FYI
> >>
> >> On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
> >>> For internal HPD case, hpd_event_thread is created to handle HPD
> >>> interrupts generated by HPD block of DP controller. It converts
> >>> HPD interrupts into events and executed them under hpd_event_thread
> >>> context. For external HPD case, HPD events is delivered by way of
> >>> dp_bridge_hpd_notify() under thread context. Since they are executed
> >>> under thread context already, there is no reason to hand over those
> >>> events to hpd_event_thread. Hence dp_hpd_plug_handle() and
> >>> dp_hpd_unplug_hanlde() are called directly at dp_bridge_hpd_notify().
> >>>
> >>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>> ---
> >>>    drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
> >>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>
> >> Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")
> >
> > Is this a bug fix or an optimization? The commit text doesn't tell me.
> >
>
> I would say both.
>
> optimization as it avoids the need to go through the hpd_event thread
> processing.
>
> bug fix because once you go through the hpd event thread processing it
> exposes and often breaks the already fragile hpd handling state machine
> which can be avoided in this case.

Please add a description for the particular issue that was observed
and how it is fixed by the patch.

Otherwise consider there to be an implicit NAK for all HPD-related
patches unless it is a series that moves link training to the enable
path and drops the HPD state machine completely.

I really mean it. We should stop beating a dead horse unless there is
a grave bug that must be fixed.

>
> >>
> >> Looks right to me,
> >>
> >> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>



-- 
With best wishes
Dmitry

