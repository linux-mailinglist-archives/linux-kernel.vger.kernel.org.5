Return-Path: <linux-kernel+bounces-94134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF0873A64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092E01C24172
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B513774C;
	Wed,  6 Mar 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOonDNvE"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EA135A47
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737836; cv=none; b=SNB+JEvQFKtrQJzpBbsWRgey5QsvM3xKgm9Xrh3i3rNVT34zgQd8MA0w4iSFEDXvZuj9/yBYYsKGFiPRNvcS7U8IzbLUcJSpnuYm95SG3WNo3bNXq5jv+gcFBuTDguEsVqcJheVqE+uJuuH6K3cYCX4vXe/9MrO0TSBINql0VCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737836; c=relaxed/simple;
	bh=svR1FpRoPaTFR5mm9A8iXFzpJ3wocvei0li0/0Nt9FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpleI+HqMqt11dB3ZAVd1uWYh1kL/V1lUjK4ki9DweGrimf5+2FOMjkx9Mwo37R9BsO8FvTLAfGeO0ewjz/Z8DwSPF3UmhQeJKlfXh7TrOy+J3onMdSA7S24IB0d34mNphmqQPnLUwZDjoWtk2pr8CeGPNyp25mYyDIY9ZzB/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HOonDNvE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68fb730fdd5so26827286d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709737833; x=1710342633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOrkhaixLjiui7k6IQZDRBbES9GKSHpQRKMa/zH55cM=;
        b=HOonDNvEbNWl1LeTWgNZvzC0fZORWn9Z+zQVPlnJNMK2jCgwsRj6UHVH/k8FpK4s2j
         p+AqM6aMTSwcHmvLwlLw29oadJH/w6d5EtwfFzxHlLXZcaQpQjnupfOJtlwMMgWQoSFO
         zpScPYYQKQnlVdmoLd42TzHmL4zZEGHxrE3d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737833; x=1710342633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOrkhaixLjiui7k6IQZDRBbES9GKSHpQRKMa/zH55cM=;
        b=qmLBTBH/Vrngu6swh1iWlI+Z7YJ9ViG4mHUASFD50uCswLBVlata/ykTXRoabYiJN3
         HDhF8plJnX3+yXOg/7scXfKBb6VH+aByTRgXVROMokI9+5B0ObyHvfB2hD787o6Zrwf/
         g9EPCNAFTwAqqNdHdLOdxpXshkSbyg3cRl2M9nsNTnQ4N/I6VlV02E7S4cwghsd5wSQT
         KjVmPiFK/dNePqBgVF3rXD8FvUD8HlFKorqI1Sbb+0cAYfvsW61qOLOK80M2IPUufPlW
         Y7CfywqlF6+Kz5N4+TsO3ASwKsIddwJ3l87ZC320LxBKXcoAzbNt9yRLvmJkueni82OI
         Gy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxTNQhICiuorx895+hHbSKkqnE5hAFSLHzt85KRfJNpYOa4e0j1Yaq+FtbFvUhnlFqsS32t7XRdRb2pJYmpPQGyh543pr1cWbsLnEQ
X-Gm-Message-State: AOJu0Yzv1kUA2eEV4tEFIuT/vAn75PWplAdO0vQGzB7/si1yKmxTtqkz
	HiB+WB9+0Bqhk7D8fyktmfAlK7C+E5T3TZMgsXPbPujPwBdJINxx5l5ooB6jrpSJ6fvAbVhgSTv
	Wz6i9
X-Google-Smtp-Source: AGHT+IEpVINhfl0pJD0ghi6BOgZvqQmWPh3rkKfX0mfbihSFHhZqiSFIvqMpjy8XA8izOzqDPZvj7w==
X-Received: by 2002:a0c:ebc4:0:b0:690:50d1:43bd with SMTP id k4-20020a0cebc4000000b0069050d143bdmr5812003qvq.1.1709737832734;
        Wed, 06 Mar 2024 07:10:32 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id lz4-20020a0562145c4400b0068f4520e42dsm7510842qvb.16.2024.03.06.07.10.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:10:32 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so274241cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:10:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbyqZwxRy1A2E7z15w0kAQxYvvzPpwjr2ftAcwhEquRyc0Iy4PNNXx0bMDVSSntp1/60OnyNYbNoTjGo+1bs2/C9CNbZvuS3moKYv5
X-Received: by 2002:a05:622a:38f:b0:42f:a3c:2d4a with SMTP id
 j15-20020a05622a038f00b0042f0a3c2d4amr323669qtx.11.1709737831437; Wed, 06 Mar
 2024 07:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
In-Reply-To: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 07:10:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XMqNwFyswz0CBVPRa2wxZ-G8eY8QT2-6uTrNROjvOtkw@mail.gmail.com>
Message-ID: <CAD=FV=XMqNwFyswz0CBVPRa2wxZ-G8eY8QT2-6uTrNROjvOtkw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/udl: Add ARGB8888 as a format"
To: dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sean Paul <sean@poorly.run>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 6:38=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> This reverts commit 95bf25bb9ed5dedb7fb39f76489f7d6843ab0475.
>
> Apparently there was a previous discussion about emulation of formats
> and it was decided XRGB8888 was the only format to support for legacy
> userspace [1]. Remove ARGB8888. Userspace needs to be fixed to accept
> XRGB8888.
>
> [1] https://lore.kernel.org/r/60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.d=
e
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/udl/udl_modeset.c | 1 -
>  1 file changed, 1 deletion(-)

Pushed to drm-misc-fixes with Thomas and Javier's tags:

317f86dc1b8e Revert "drm/udl: Add ARGB8888 as a format"

