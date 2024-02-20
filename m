Return-Path: <linux-kernel+bounces-73805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E15985CBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E0285F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE70154449;
	Tue, 20 Feb 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dm+CWoFC"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EED154425
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470490; cv=none; b=NC2xx/6sUGOelkUCThVdspu7EmaBTPoxDYev26hJRlDoL7TtQJIrzbpTyLxefSkrrLcSmlcJWb4vwWH49V81nz0QoQRsK41HHo+xYH7CGUvV5tGXM3Vi2XtvlX4s07G8lx3DXkrnb7eG2RdInnHAa6KEmwEZxPIBbHnHKJwTmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470490; c=relaxed/simple;
	bh=ph4a2df0VI65NePySmrE3vWJDqYEA8i+KxjYQ0+xJSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNCrRsDkHD+01064uwM7TWSNYyNd4fzhxIL6lHX3/vQxMfTybNIPQqMlk1kcNwXwal1F4KwRQrEKLPdMOz8q3HifxOflrg/KVsr6xEc2c7j6Gn6Zrxt3cOwCDOge2qikEeHR9q5F4UBBYNk5xhIriFe3a/EiBKG5fZ2BmO1RkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dm+CWoFC; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6087396e405so6702707b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708470488; x=1709075288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMa4Xpq2gA3A1LeF8lVok8xN9ReJjb3LesYcCiypUgg=;
        b=dm+CWoFCrdWsWNX26MHFbEWWvi1wBc+7Pqe3cIqUIVnuASnImXkHwEHI3Xu7qTszd8
         PekAgvAVXccj+iPTCFGFU//Nq9rTzdpRkrW5kG2GabFSg0vhKhHsqrN4czl9p0abE4n+
         6RBKdFOp4B1Ja3676o3vt3svnuUvO+F1MKw9ntjC2ck3XGTiDrWitk9vv6zEnp4SwjGw
         +uH9R6LYhPIj0mKsxrgzrAxeXb/28GkQyh96duTtIbo7EBf91mpmpUUYso7+DCbyYXY4
         /vTZdAUktdW57L47VazehjwpFF04w9jSaYmF8pK70PVt3CHroC+KR6hdfj8931AN9viD
         oS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470488; x=1709075288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMa4Xpq2gA3A1LeF8lVok8xN9ReJjb3LesYcCiypUgg=;
        b=Q+ftocQVZ1+aDXIQEPYqWJPsHzUZtGYNiccPr4QMaKVFPhpvU2OjvnG0t3+GQ9i7EK
         nj6xtwrD4/GUIkzXbSOIsL00SEIG3yLQgE2gPNtmWU8j7ewncCi/h93EPbLxr/177RJu
         e4qjCo4PCM8tPmuf2wxH+fuRKJOoY+e+cvAYBESVYCpC0dtkPL7RTgiLscIReq+Xzare
         waCF5KbmpmV148sPgpXvv/yiwKHnOUa9meF3rwNLlFaSCUJrmiOfYvLYvVV0UgyVfArI
         bZKpg+CGySE/9hy9eRLq+Oe6yz3hY5mz3NHuDctgVANYWEc4yAZ7KnWxfOjia9oxvKoy
         vMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUE3PDpn6DzlWPs+ymdpgcyBEErrb11pVDffZa4naF6rhc8jAigPonJsI9SvrgMPMaUGGPbXTLzpNN8g3UfhSKqjO3CNk5GhSdquVm9
X-Gm-Message-State: AOJu0YzaXKEEiv80DdYw1rxSH7W4Bx3T4qlan4SWCbrxs4LqL5sdwgV0
	gKCHJRiZHGWoG2ZhTcQEHn/BR0AFLKHW2hW3VJhGCLuW+7z9kDjBIZ/5bBkicB9Wv5wThbWqw1G
	L9wgUsonHsLTOG0FAGjJjCrjfLN9XvOa99jjiPg==
X-Google-Smtp-Source: AGHT+IG3a3isXkLnhLjbaA3WAfu3COn5KIElhpETaOROfN3a/zrBXCsfeHPjiW3NbxHm8CHzA7JRzyjBs0Q6pVYoj00=
X-Received: by 2002:a0d:d514:0:b0:607:cc6a:e1e5 with SMTP id
 x20-20020a0dd514000000b00607cc6ae1e5mr11574717ywd.2.1708470488239; Tue, 20
 Feb 2024 15:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org>
 <1cb90bff-ce5b-c6d1-a3df-24f6306f833a@quicinc.com> <CAA8EJpotiHKT_NYphDs0-vhpvsybgTW281XDYbteUx8qOX=v4g@mail.gmail.com>
 <63bba15b-6d8d-5ba8-d99d-8cd2dd763262@quicinc.com> <CAA8EJpqHmVBry9FyJ6HRB+qdVcVNN3Q7rHZz1daZL1Sz6yeZ=A@mail.gmail.com>
 <69d152d2-6a25-9ff4-ce6b-c4790247a661@quicinc.com> <CAA8EJpo3XynBrm0S_BA_SxGOw963WQT9jh=YvLcT1N24FyEUsw@mail.gmail.com>
 <09928fb7-c5c3-7a36-1ce2-9f4012507d06@quicinc.com>
In-Reply-To: <09928fb7-c5c3-7a36-1ce2-9f4012507d06@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 01:07:56 +0200
Message-ID: <CAA8EJpqEE2QjN5K=_FmUPRNGcXCnCcumJeJ6ShKbT3WHYaUp-g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: make "vblank timeout" more useful
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 01:04, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/20/2024 2:42 PM, Dmitry Baryshkov wrote:
> > On Wed, 21 Feb 2024 at 00:40, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/19/2024 3:52 AM, Dmitry Baryshkov wrote:
> >>> On Wed, 14 Feb 2024 at 22:36, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2/14/2024 11:20 AM, Dmitry Baryshkov wrote:
> >>>>> On Wed, 14 Feb 2024 at 20:02, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2/8/2024 6:50 AM, Dmitry Baryshkov wrote:
> >>>>>>> We have several reports of vblank timeout messages. However after some
> >>>>>>> debugging it was found that there might be different causes to that.
> >>>>>>> To allow us to identify the DPU block that gets stuck, include the
> >>>>>>> actual CTL_FLUSH value into the timeout message and trigger the devcore
> >>>>>>> snapshot capture.
> >>>>>>>
> >>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>> ---
> >>>>>>> Changes in v2:
> >>>>>>> - Added a call to msm_disp_snapshot_state() to trigger devcore dump
> >>>>>>>       (Abhinav)
> >>>>>>> - Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org
> >>>>>>> ---
> >>>>>>>      drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
> >>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>>>>> index d0f56c5c4cce..a8d6165b3c0a 100644
> >>>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>>>>> @@ -489,7 +489,8 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
> >>>>>>>                  (hw_ctl->ops.get_flush_register(hw_ctl) == 0),
> >>>>>>>                  msecs_to_jiffies(50));
> >>>>>>>          if (ret <= 0) {
> >>>>>>> -             DPU_ERROR("vblank timeout\n");
> >>>>>>> +             DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
> >>>>>>> +             msm_disp_snapshot_state(phys_enc->parent->dev);
> >>>>>>
> >>>>>>
> >>>>>> There is no rate limiting in this piece of code unfortunately. So this
> >>>>>> will flood the number of snapshots.
> >>>>>
> >>>>> Well... Yes and no. The devcoredump will destroy other snapshots if
> >>>>> there is a pending one. So only the console will be flooded and only
> >>>>> in case when MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE is enabled.
> >>>>>
> >>>>
> >>>> Yes, true but at the same time this makes it hard to capture a good dump
> >>>> as potentially every vblank you could timeout so this destroy/create
> >>>> cycle wont end.
> >>>
> >>> Excuse me, maybe I miss something. On the first timeout the snapshot
> >>> is created. It is held by the kernel until it is fully read out from
> >>> the userspace. Other snapshots will not interfere with this snapshot.
> >>>
> >>
> >> For every new snapshot a new devcoredump device will be created which
> >> should remain till it has been read. But now this will be created every
> >> blank. IMO, this is really too much data for no reason.
> >
> > No-no-no. If there is a devcoredump for a device, the next one will
> > not be created. See dev_coredumpm().
> > So all the snapshots will be created and then destroyed immediately.
> >
>
> hmm ... I have certainly seen devcd_count go higher than one (but not
> more than 2). I am wondering whether this was because of some race
> condition of the previous destroy / new create.
>
> But anyway, this part is clear now. thanks.
>
> >>
> >> Subsequent vblank timeouts are not going to give any new information
> >> compared to the existing snapshot of the first vblank timeout thats why
> >> we should just create the snapshot when the first error happens and stop.
> >>
> >> For other frame done timeouts, infact subsequent timeouts without any
> >> sort of recovery in between are quite misleading because hardware was
> >> already not able to fetch the previous frame so it will most likely not
> >> fetch the next one either till it has recovered. Typically thats why
> >> these vblank timeouts happen in a flurry as the hardware never really
> >> recovered from the first timeout.
> >>
> >>> Or are you worried that snapshotting takes time, so taking a snapshot
> >>> will also interfere with the vblank timings for the next vblank?
> >>>
> >>
> >> Yes this is another point.
> >
>
> snapshots will still be captured every vblank timeout and reading
> through the entire DPU reg space every vblank timeout is certainly
> something we can avoid.

Ack.

-- 
With best wishes
Dmitry

