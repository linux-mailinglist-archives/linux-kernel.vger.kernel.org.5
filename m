Return-Path: <linux-kernel+bounces-114714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91EE88914B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E8B1C2C886
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D26E61D;
	Mon, 25 Mar 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1tRwGI6"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0964252847
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322640; cv=none; b=bQA7fiPgTA50ORTf7Sgz9tKP9jXjxV7Qay0vW5vVU719waMvpcqYQk/6IGFAXJCY4VAqr87ID6+Ctcdi7eu7tTgFW38+ibuoppLMKB2AMkh+oqzM2SKSJk46m0uDcvzb90XYqUBw9UBkHEMk4Vh91co4hznTXA88bYAuulf6TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322640; c=relaxed/simple;
	bh=vUOw5Ktu5x24n3aLaI34f3N7oIcNo2h6oYoKJI3Pp2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtPlutmhCoO/26GV+1KnIsrFT4EjvOf0wGqN4m0FpG3l1XySEUQbSyZNWXDLUNriVO80ZfoO83s6RkulvMxXXFae5iAHTY4oaxWLHqN1Ptu65NKfRGAZyR6F/7fDsvT4pskHSINX2urAqUm4oPy/r9Vz/fXpjVBKTOk7lhlMcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1tRwGI6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2546990a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711322637; x=1711927437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr2Cf82o25fp9daEntXPX2qWzpAZqJg/jLy0faLOqfo=;
        b=Y1tRwGI6PEvzc8aIsgmBhTR3dcsgN+2V+lTOy5cojLJURQ6gTbE3zNOxAlO6AzO13I
         J+PgNYewceSGeFmT+D2/7+mPCAw4B4tnx8CzzbBBDYQBorsOzaTkUavCWiOCGtpnFerR
         O8H7TWVfwe6eWmvO82FPGP0o0PD8odCvU39OYNQ8RkKlaNm60zI91AmP6CfDhv6c9PS7
         eT/skHkUDUHLvhNrKYgMR55yveb/y+EZZY3wkRs7KobqP+ts3/6/nOT9TFfbdZIqnYLK
         tW0UZ4xd9yeXNCzjdaFIknTfbzpu4JNQh2rKpB3xoyIMrHEPmSPYAIJ5Bz9X+c85C8HV
         WKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711322637; x=1711927437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr2Cf82o25fp9daEntXPX2qWzpAZqJg/jLy0faLOqfo=;
        b=KI4M8eyIJzo8HhCwfiQjvOjWej3OFoIdEhWGNvdsh00S6JR0ksoGtI3mkNQ6WuxJv5
         4QFtwf0ITU5zZeDpKRDvG3E0SCwuz6YXt3akLlkNIe7DufKiY6vFG40f0G96GwfrjA07
         VMh7a02Wfj+5AhdkW3/nd1ZR5O8dZuL2MqripCiRn7KSY8PYSEGtUw58sb+rzPlwVRrH
         h0vtsV5jtFd8ibUJNabmD4+Jc2WxnIGy2wTH/6gtMVnTKyTlA0+aMRBMbxN8xJoC3rSQ
         /RoJvlps1swygkMo7wvzKJ1d9WoEnwZGRtuEtjfwVs27dNH5lWJTvm8eKPxWd2QdE05l
         N28Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTgI4UQufJw14HY5wIO7F8lpa95wv1o0QyWwm+Vdlbe6EWs+x0CjlHsgdtSqbnGq0CkcPajPe8giR6ZQb3IPohDL2uRJbBHK3jBJsM
X-Gm-Message-State: AOJu0YwbKQrpDKTXDxbUWFE5ufRdFFp4mf1H82s3yCFOHw1ih/4juyYp
	pSSg0k+XRrjJsaSKIInEkfCDNxp0NPhtcbpcLwe5lfPg1wwpaA6FREeEsGkhfip4rP5qnZ87WXC
	/Q0JfZ55xAtldVujqvSpydtRdI2Q=
X-Google-Smtp-Source: AGHT+IFMOMfeUxQyKzPFnUMoVWDwkbdGKmRMYPWEC+HKw+YXJ9EhRRfrd0ilgf+Tk07qVbRcktkVNSKiwlufFCxvaZ0=
X-Received: by 2002:a05:6a20:8ca7:b0:1a3:40e3:318a with SMTP id
 k39-20020a056a208ca700b001a340e3318amr5663622pzh.60.1711322637106; Sun, 24
 Mar 2024 16:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307221609.7651-1-hannes@cmpxchg.org> <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>
 <20240314170948.GA581298@cmpxchg.org> <20240323145247.GC448621@cmpxchg.org> <c8efae98-3cf8-c21c-bfa4-d5998ab92a0e@amd.com>
In-Reply-To: <c8efae98-3cf8-c21c-bfa4-d5998ab92a0e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 24 Mar 2024 19:23:44 -0400
Message-ID: <CADnq5_OGSLpLLEJqh86_SAZcqv-Cv6AmZJRZyaFtSmTHJ8ybxg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix deadlock while reading mqd from debugfs
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 4:47=E2=80=AFPM Sharma, Shashank
<shashank.sharma@amd.com> wrote:
>
>
> On 23/03/2024 15:52, Johannes Weiner wrote:
> > On Thu, Mar 14, 2024 at 01:09:57PM -0400, Johannes Weiner wrote:
> >> Hello,
> >>
> >> On Fri, Mar 08, 2024 at 12:32:33PM +0100, Christian K=C3=B6nig wrote:
> >>> Am 07.03.24 um 23:07 schrieb Johannes Weiner:
> >>>> Lastly I went with an open loop instead of a memcpy() as I wasn't
> >>>> sure if that memory is safe to address a byte at at time.
> >> Shashank pointed out to me in private that byte access would indeed be
> >> safe. However, after actually trying it it won't work because memcpy()
> >> doesn't play nice with mqd being volatile:
> >>
> >> /home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:=
 In function 'amdgpu_debugfs_mqd_read':
> >> /home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:=
550:22: warning: passing argument 1 of '__builtin_dynamic_object_size' disc=
ards 'volatil' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >>    550 |         memcpy(kbuf, mqd, ring->mqd_size);
> >>
> >> So I would propose leaving the patch as-is. Shashank, does that sound
> >> good to you?
> > Friendly ping :)
> >
> > Shashank, is your Reviewed-by still good for this patch, given the
> > above?
>
> Ah, sorry I missed this due to some parallel work, and just realized the
> memcpy/volatile limitation.
>
> I also feel the need of protecting MQD read under a lock to avoid
> parallel change in MQD while we do byte-by-byte copy, but I will add
> that in my to-do list.
>
> Please feel free to use my R-b.

Shashank, if the patch looks good, can you pick it up and apply it?

Alex


>
> - Shashank
>
> > Thanks

