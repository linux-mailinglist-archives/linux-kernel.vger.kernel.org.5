Return-Path: <linux-kernel+bounces-107989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D7880487
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B023CB23682
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FB2C6AA;
	Tue, 19 Mar 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xfk9pT+l"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9D42BAEA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872167; cv=none; b=Gesiwf93Ii9oHbj1DOAkPLh7yl8SizczPfqR2va3+B9sBTbA2ktLNbbkV6EeAubWUq0BhrqxybUQ3zn0PEgFFm6JuNVNckm/9nMzJd0JXYNRSWduY87yZq1Xvj0xqD0mYSE66LyiLNlBMJpkbJgo69Z1ft36aJQbjXflcayedZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872167; c=relaxed/simple;
	bh=3rkOtNqRZGNeJ0BmlK/wCNlX+LHzHZmWg6oBPJO2b7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkSduGl2zMXMWgIUjzswXh8GOUrg9PH6x8kgM9Upm0Lk1v4VZRG92XU/Esv50c+01FX/Cl9dM3eN+7dHF1JbWjVsQuVHL+klcSyJE4yiPp/QrbWnTJvnmrTCc3ZNOvAS3602kM8ehGdR1VinbyhcOFnbZLKhVH2PiMeVtqixmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xfk9pT+l; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6969855c8so1385965a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710872163; x=1711476963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY3JC7lCg0J0NbLsthogiU7IlW38IYTYvI5MHCluIsY=;
        b=Xfk9pT+lbC6sSIIcTKhTGdAFiMJHi85OVBxvBA2OEh1w1+YVNxCd+1YBNgH63Ho1em
         hAjbpYu/Kgv8JCNriwPi3c+X8lXS6qNwj6o5OhyiT0ihPyVa4lazNECcJPTc/NxHQGqr
         Ohp5sw33xZQmRYS29szxXBE0R5NzUAAU2ukYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872163; x=1711476963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY3JC7lCg0J0NbLsthogiU7IlW38IYTYvI5MHCluIsY=;
        b=dN0lLEp98mbTf/XeP9vIktmdkjqJJDk8u2W8XmC5LRVN3djrF25E//pbQ3oBXmM/bl
         7N9MV8FbZY15DRvCHgUmKA2Ya6be+pBRppWlZeivsSfLhzzFWQeT2+ZvG0y0CIcWj8rM
         BgVI+ZrViQtgS4sh0q95NwZG1bgIsWif8Vu8g3Fwos2yJ580Bbm8qYjvKm5/g91Q9E8m
         n59kcnPGbZl7XnY1IC7ZqqNzKrATvSD1raw62dP2X0kFJXRODld2VGAp+geOeyraFKb8
         k1UtTtgFTHH8KWKQ+aeBhW0l5g5Hklm/yCPICMpFhkk8GWVKXxi7ULG5kA2F+200xHIj
         739w==
X-Forwarded-Encrypted: i=1; AJvYcCX07ucITTHjCHidsxFH1+tWPhAd0H76VCV8/rzSVnfaVUw1L90GQULMVJeLlSZEUp4TFemFV98YVpFalfDZ1+8aTqNQHgEeaw4EJNRQ
X-Gm-Message-State: AOJu0YyLxgOYwjGLS5NROxieDdTFKLbVpbn9MXxz8btLe0TYZpVA27jS
	XXNeFzJbayaqvIT6nnRIKMU+vlstpp49w5GlK8Y9CvsB5qayRYVB5QYs/hRAchffc4jJisj7EHo
	=
X-Google-Smtp-Source: AGHT+IHInn8JSl6UE1OCDLRX4P+DhxU8HFCrs2gUlmlUs92b5/eQP7A+twOPAo9Ge7wFwsMnPcVEDw==
X-Received: by 2002:a05:6830:1548:b0:6e6:84b4:5f35 with SMTP id l8-20020a056830154800b006e684b45f35mr3632773otp.8.1710872163176;
        Tue, 19 Mar 2024 11:16:03 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id ou16-20020a05620a621000b00788618c8c3fsm5722678qkn.34.2024.03.19.11.16.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:16:02 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-428405a0205so42591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:16:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWklwgpujqWUGBSu2qjy3dLiO0h2XACHcK+Ygyk3PtX9SA/bBS4n1YMAHHicKAqJlDqSRxxfYTRiqivf/gYQffZZukNYGeLrddl6YKU
X-Received: by 2002:ac8:7f0d:0:b0:430:ed72:bc0d with SMTP id
 f13-20020ac87f0d000000b00430ed72bc0dmr39379qtk.26.1710872161807; Tue, 19 Mar
 2024 11:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315213717.1411017-1-dianders@chromium.org>
 <20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid>
 <e2319b19-d999-24e7-48fa-bbc19bbfbeea@quicinc.com> <CAA8EJppau--vt3RLkH96K0SF2x-QGWz+5U8tErvLFDvz-GQN4Q@mail.gmail.com>
 <d04711c1-6df0-f988-9227-2161f4109dd1@quicinc.com> <CAA8EJppcuftv4hfKkZeaXCDQJ4Z5+8-P99wHc9X8WgYJbk6CjA@mail.gmail.com>
In-Reply-To: <CAA8EJppcuftv4hfKkZeaXCDQJ4Z5+8-P99wHc9X8WgYJbk6CjA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 11:15:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMbqmU1q+6hJZV9a16PdPUtdDJuMmsQ1wb27jDdeQFmg@mail.gmail.com>
Message-ID: <CAD=FV=WMbqmU1q+6hJZV9a16PdPUtdDJuMmsQ1wb27jDdeQFmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/msm/dp: Delete the old 500 ms wait for eDP HPD
 in aux transfer
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Rob Clark <robdclark@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 10:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 19 Mar 2024 at 19:13, Abhinav Kumar <quic_abhinavk@quicinc.com> w=
rote:
> >
> >
> >
> > On 3/18/2024 5:55 PM, Dmitry Baryshkov wrote:
> > > On Tue, 19 Mar 2024 at 02:19, Abhinav Kumar <quic_abhinavk@quicinc.co=
m> wrote:
> > >>
> > >> +bjorn, johan as fyi for sc8280xp
> > >>
> > >> On 3/15/2024 2:36 PM, Douglas Anderson wrote:
> > >>> Before the introduction of the wait_hpd_asserted() callback in comm=
it
> > >>> 841d742f094e ("drm/dp: Add wait_hpd_asserted() callback to struct
> > >>> drm_dp_aux") the API between panel drivers and DP AUX bus drivers w=
as
> > >>> that it was up to the AUX bus driver to wait for HPD in the transfe=
r()
> > >>> function.
> > >>>
> > >>> Now wait_hpd_asserted() has been added. The two panel drivers that =
are
> > >>> DP AUX endpoints use it. See commit 2327b13d6c47 ("drm/panel-edp: T=
ake
> > >>> advantage of wait_hpd_asserted() in struct drm_dp_aux") and commit
> > >>> 3b5765df375c ("drm/panel: atna33xc20: Take advantage of
> > >>> wait_hpd_asserted() in struct drm_dp_aux"). We've implemented
> > >>> wait_hpd_asserted() in the MSM DP driver as of commit e2969ee30252
> > >>> ("drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()"). There=
 is
> > >>> no longer any reason for long wait in the AUX transfer() function.
> > >>> Remove it.
> > >>>
> > >>> NOTE: the wait_hpd_asserted() is listed as "optional". That means i=
t's
> > >>> optional for the DP AUX bus to implement. In the case of the MSM DP
> > >>> driver we implement it so we can assume it will be called.
> > >>>
> > >>
> > >> How do we enforce that for any new edp panels to be used with MSM, t=
he
> > >> panels should atleast invoke wait_hpd_asserted()?
> > >>
> > >> I agree that since MSM implements it, even though its listed as
> > >> optional, we can drop this additional wait. So nothing wrong with th=
is
> > >> patch for current users including sc8280xp, sc7280 and sc7180.
> > >>
> > >> But, does there need to be some documentation that the edp panels no=
t
> > >> using the panel-edp framework should still invoke wait_hpd_asserted(=
)?
> > >>
> > >> Since its marked as optional, what happens if the edp panel driver,
> > >> skips calling wait_hpd_asserted()?
> > >
> > > It is optional for the DP AUX implementations, not for the panel to b=
e called.
> > >
> >
> > Yes, I understood that part, but is there anything from the panel side
> > which mandates calling wait_hpd_asserted()?
> >
> > Is this documented somewhere for all edp panels to do:
> >
> > if (aux->wait_hpd_asserted)
> >         aux->wait_hpd_asserted(aux, wait_us);
>
> That's obviously not true, e.g. if panel-edp.c handled HPD signal via
> the GPIO pin.
>
> But the documentation explicitly says that the host will be powered up
> automatically, but the caller must ensure that the panel is powered
> on. `It's up to the caller of this code to make sure that the panel is
> powered on if getting an error back is not OK.'

It wouldn't hurt to send out a documentation patch that makes this
more explicit. OK, I sent:

https://lore.kernel.org/r/20240319111432.1.I521dad0693cc24fe4dd14cba0c7048d=
94f5b6b41@changeid

-Doug

