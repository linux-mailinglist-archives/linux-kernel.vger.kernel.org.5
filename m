Return-Path: <linux-kernel+bounces-123640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F12890C15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38651B25EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99113A400;
	Thu, 28 Mar 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBsg8j0r"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832562575F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659502; cv=none; b=SJRz03lx9Rqoz7eWxrjNv1eRbCw/ELvCKc7DdjTAormxwVDASBwg8CTic6zzArMdHGICpM7801D4TvBPpRH4HsIOEte7zXVzhDnLPaL6YG3d0FL9hLvqfSdsEaFYvNRj04+Yi0qHef3oyTX8BzCmpPND3x/1SLlLmsOCfzgpR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659502; c=relaxed/simple;
	bh=N8mWrmTuzFd1S0eCSYex0s1wl6YZv0zeY2UuGyjv1kE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH5eIGbb+l+WO/2eO9ltIqnhhZ2e39SnMhIRgvRdnjD8RLHbpF5B11tfQWF9oe/ZjP0K4vbYyw51TKqV2QZg1+N6elEawp+xiRTRfcdWkwkeFCZj0Mh2tH+RUo0hMKlJ2WNQtEMffIPw4zDfSlFAMnC3ZZ2aCLvGZqkM7B+JZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QBsg8j0r; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515caffe2bcso729753e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711659499; x=1712264299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZTeYvBsc1oAa4VB+k3glOGyxEenyZ156QMTJ6JLs28=;
        b=QBsg8j0rNf5Ykoch8pU5Te6KNTcD1LGWnJFwOhx72ck2DNCBnmVseRl562J6oXs9Y5
         s8Ho5x3LVFTyjubsQ1RxqJcmCIv9eiICzxy7x1VLqB7ceP4ckGReba4u/K+de2yvAWaG
         EpMSNqDCdAOU+petfs+RbMvrSac+AC1MkQAms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659499; x=1712264299;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZTeYvBsc1oAa4VB+k3glOGyxEenyZ156QMTJ6JLs28=;
        b=Ps7mJSAMXztpQtUSZMvym7uzFus6Kbhz01t6ZYcedmEKjxzLQXcK5bsAy2MInaSUxS
         leFgcYv1pU4oFDz67gegBCCdYtOaW5PoFQlOp+2bVdWGobaQohDXpAlKuu/O2kQw0sKS
         DvEuwY+tOAh1I41Xdv6lg9muyt8GYOFJO/e1oDMO1rpy+pXTsJvmKfzwPKLInxOw6TVq
         Xs4TBkKZI4dIfIrqmnmFBRVHFB1TN9ZXNn+zKwXDCEWWksIdmfW+WzWRRIl9/HfZyszr
         1ZIBldBNIHofa9gI9QAuv4qt6pFWgipRy5KDZAtluW9CM6M1mvaEdy3Jo0pq4aVa2QY/
         7SGg==
X-Forwarded-Encrypted: i=1; AJvYcCXzhXkioQhUJRd5iIbpLelxTkrbx6zJBfKvx7gWKqXZtcmNVpA44ojN+CmCOLEBol0grVMVtitGKx1sCRPOKoXzYyrjP3r4wCSbCznk
X-Gm-Message-State: AOJu0Yyd2zke/n5yAwjVjECsSRd0geUtwWj1S4dRBhlfuVX7nRn21cP7
	Qef52F9Q4gmGlpbazvgGDfD7djAhsLrrIJ1PEmVkXShm3bFzPCDceINQDnX7k9ctjZzw/i5dqhp
	4685Uqh4GW9P6Qvy28CUGb0mNzb2Qp5zuTVxuYUPRJwCG12Y=
X-Google-Smtp-Source: AGHT+IHoxrbzbhkVOP8a4fcpK+Wu8N/3pU+MedZMjdflM+fqjOjEguDaIwsuhXjzqY9Q1I8bN3idizKTu7WUJ11QjeU=
X-Received: by 2002:a19:ca01:0:b0:515:c1a9:7d98 with SMTP id
 a1-20020a19ca01000000b00515c1a97d98mr395135lfg.13.1711659498582; Thu, 28 Mar
 2024 13:58:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Mar 2024 15:58:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com>
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
 <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com> <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 28 Mar 2024 15:58:17 -0500
Message-ID: <CAE-0n503FwcwreZ14MMKgdzu8QybWYtMdLOKasiCwmE8pCJOSw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dp: use dp_hpd_plug_handle() and
 dp_hpd_unplug_handle() directly
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, abel.vesa@linaro.org, 
	agross@kernel.org, airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc: quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com, 
	marijn.suijten@somainline.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-03-28 13:24:34)
> + Johan and Bjorn for FYI
>
> On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
> > For internal HPD case, hpd_event_thread is created to handle HPD
> > interrupts generated by HPD block of DP controller. It converts
> > HPD interrupts into events and executed them under hpd_event_thread
> > context. For external HPD case, HPD events is delivered by way of
> > dp_bridge_hpd_notify() under thread context. Since they are executed
> > under thread context already, there is no reason to hand over those
> > events to hpd_event_thread. Hence dp_hpd_plug_handle() and
> > dp_hpd_unplug_hanlde() are called directly at dp_bridge_hpd_notify().
> >
> > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
>
> Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")

Is this a bug fix or an optimization? The commit text doesn't tell me.

>
> Looks right to me,
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

