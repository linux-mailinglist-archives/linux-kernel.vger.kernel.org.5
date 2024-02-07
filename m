Return-Path: <linux-kernel+bounces-56259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B252384C804
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521D01F2346B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37D24A19;
	Wed,  7 Feb 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzQiPDNF"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D022F1E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299592; cv=none; b=E3Ecla1XhpokpFIfjgGuJDRLyzxK1eZ/V/64RkO+ppCGE7MQk12fg394ncBjf+9DpwxMVnZRiGIoNjeTqt1HxImSPeS5Z7VsHcLLnZpKLhdq1vjfdeWTmoHQcMGmp7Z48yOucSmE+d34bMEinqPzkreJ4igi+b7NvIzxwBfhbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299592; c=relaxed/simple;
	bh=fBagnQpf9lsurAdCpTPPCwp0zC2lC8ox5gnQI1Q20r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaYomt4/N00RNad83njifUxmaW+apbMFiWUG2m8PBRB1BazQVwVcbjMl7ZvCAsdjCfBGuZV5nVSEeiapQWNZ3YSHJmXrrD2Ulkp0rtEe9CV5YmOPjeyTFCwQcrg5R6Lg77fJlgLEs+zWdzcWY/u+UMBFvpmDyl0xwC26VgpdxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzQiPDNF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60491b1fdeaso3485227b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707299590; x=1707904390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D48j7hXU3glDBmXxDOFw5bCwEMnSogYiPviREFd32FQ=;
        b=GzQiPDNFGzV+WacOxV2qmKnevKuNYdxne9ZZf2GPguun7J2rV5ep60zPImNMx1tVMd
         FPt5dKM3bcUx7hOWghjP+f7V7T8AZlu/rmJuH8i+IB/vX/hA2tkaiMT8i2A5v9s8LzAB
         cF0sDnRNQK4G3d4zw2FicrJcJDC5521gaQ1Xlt0uOtLqgthqLhBljxqQ28ngwY2qo7+1
         8NSFjvK4f179Lg38idDuML0rIlQVOm+sb+fSIYk78PjtDWkPWV/DJ6IwFdP5eTxkJ4oa
         LBC7LkP1s62rD7gWyXeqKZc7RlrE+oAmVigSDOVO+El8zL25BoPnIPZvI7wtXL3zVoBW
         g6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299590; x=1707904390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D48j7hXU3glDBmXxDOFw5bCwEMnSogYiPviREFd32FQ=;
        b=Cz19P10yxn+WIjSYY2qHQV9Jrmu5+d7XldZNWh5PNFFRLIexgTGyDHpmUSRWpBIdTC
         TjXj71KHvjjfLHdLYyNB1lBAaG6gG4bbpRGPO4hAtJO+j/lU+h62LePxzb/nKxRlzfJD
         D2LVBwf3jbDo7k5w6cl8Eg+H5Mt3eF4RpwNs7qL/wjx7QcFS4cbfwT4Uo/GDCIQ5p3VF
         awv8fFydP4aSK0D2Q7RIGbAq4ADOloLEy2zPmm8B1kKhCkDNXMKqRNLB87hIQEG9Seaa
         A0zb1g/IXGu7zmoOuqnZuut3QE69SqB5GBasQJfZSlx95q0T8BTm7lSIjN9ixOPxHhcG
         KLBQ==
X-Gm-Message-State: AOJu0YzmdsZO9c5fiPGPaiyDGGvpA9B/zX8AurBZwkFLhZlmChjBoRH1
	O1sFC3P575hhNKGzgetiVoH5OcWBqAcbYnnTnTMVXTIAsEktYFOEJgNOJj3DTYonAyttd1ML1Cv
	s842bAdHXGUPcEh0MakAYp5sxrZL+64q9NiHnqw==
X-Google-Smtp-Source: AGHT+IEh15/3UNFNxwbhtyktWrw5Dq3WwqrIRYrh9/Lre+JIygghfrZgJ0hP4Cue7+98aLmgX4RyI000Dpu6bvDHXZM=
X-Received: by 2002:a81:e60c:0:b0:5fa:5251:2332 with SMTP id
 u12-20020a81e60c000000b005fa52512332mr4349582ywl.32.1707299590157; Wed, 07
 Feb 2024 01:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
 <20240202064039.15505-3-quic_ekangupt@quicinc.com> <2024020248-improving-algorithm-a5f0@gregkh>
 <a2c5e594-f485-4510-84ba-6cd022c4c774@quicinc.com>
In-Reply-To: <a2c5e594-f485-4510-84ba-6cd022c4c774@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 11:52:59 +0200
Message-ID: <CAA8EJppuaPLuH2Xb1Cu6P1HiD3PSjTy4L-Q6C3S82m5RAxfApg@mail.gmail.com>
Subject: Re: [PATCH v1 02/16] misc: fastrpc: Add support for unsigned PD
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 10:57, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
> On 2/2/2024 8:13 PM, Greg KH wrote:
> > On Fri, Feb 02, 2024 at 12:10:25PM +0530, Ekansh Gupta wrote:
> >> Unsigned PD requires more initial memory to spawn.
> > What exactly is "Unsigned PD"?
> >
> > And where are all of the userspace changes for this series so we can
> > verify they work properly?
> >
> > thanks,
> >
> > greg k-h
>
> Hi Greg,
> Unsigned PDs are sandboxed DSP processes used to offload computation
> workloads to the DSP. Unsigned PD have less privileges in terms of
> DSP resource access as compared to Signed PD.

All such details must be described in commit messages for the patches.

>
> Unsigned PD can be enabled using userspace API:
> https://git.codelinaro.org/linaro/qcomlt/fastrpc/-/blob/master/src/fastrpc_apps_user.c?ref_type=heads#L1173
>
> For multimode invoke request(other feature) also I've shared the
> userspace changes with Srini which he will be pulling to userspace
> project.

And this should be a part of the cover letter.

>
> Please let me know if you have any other queries.
>
> Thanks
> --ekansh
>
>


-- 
With best wishes
Dmitry

