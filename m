Return-Path: <linux-kernel+bounces-131441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D978987EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5351A1C21400
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E3126F21;
	Thu,  4 Apr 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4I28LMd"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCC6CDDC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233974; cv=none; b=MYIu0Bw57ygawWe4VHtBx7u3P4s+c6wUWBHe4y6Dp345idAaW77SHJWI26OgptEeHaulYFIrwnObeiT5RObv06Rm/T/IFXaSXpZFYpTtJ1QdSZQxnLSB6nxDFWgktLGG8Ak6h2P7r4Vk1UKRChoiAkU2QBCgHiPsAjDLhD6KoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233974; c=relaxed/simple;
	bh=FCba+Q7d/nRYVtI/cBtG4cNHzK5S9qSoPYInruzyPS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H56EXv6q6uzdhSO7k7rt4LTvXloTaDG7Gx4KJx0f0K75ytoUN5XN05SpOi5mwShY5bLeeVHXiDNwQNAc34qkJOeVRu7Nu0Xi4mwaAEp6yitFzggTDAGAww0UA7OwPkJPY7reAukdFQGLXo1vEdyj7vlC3ArDzJQQTA8nKzTF8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4I28LMd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso1035135a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712233971; x=1712838771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXyy4yHP0CZTf1IBrBojXYAs2I6dwIFFKPaznXSQtH8=;
        b=g4I28LMdcSauRzgoGd9NWm2/0Azcdw2i2zH4g9tgLh1oHB31lfA8Caog+Vh9ptF2D3
         1FdVHqfkQ/V6yixohcHk2wJcbtLoE2h3d2Ka9VwIRxXKFvx7yowA8ZQ5Pi6a++SwMJHt
         mC8RRXHceka8IACc0CtlEH1wxqKqP+sJ740KKFxQ3giwuuMkvMDlOkCA9xDSxb3yUOF6
         tEkjUq0OlykIHm5Uv8j9R+uvMFF4t2N7f2xd8s0tBE9+8wWFeewVu9591iNjIPN2+CKY
         /8EiK/XJIiU+npX8uOgrszEsD/4lGw5BDblIAU/uOf65PSQz7FQl2xahCiJkFqxv4Yvn
         rxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233971; x=1712838771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXyy4yHP0CZTf1IBrBojXYAs2I6dwIFFKPaznXSQtH8=;
        b=b1VBHUeekRNFkg7hbquIQhzPKtcfYlVelXMIdc+cKi2PdQWKpUzMHciI8X+oAn2aop
         lxESN5BGN5/Ij6e+okBfOoxUKwbdJ73N77S9Y9JokffXtp+igNifQqPJjFqy9n0uSlwR
         9JvU25+e4XcmL8AfeYCIoJpLsUB40sCSInXbTds2EFzP1LdoomsGP0Ao2BeV9FaiK468
         t5WotK4OHSBr+xVZrb2qNpIouOTXViomQDCT5/M1ImHnj76hD7nz+xRbWIq9ZLDs6b9s
         ukqyNzrap8NCSE/H3h/4Lr+VnL2Z9lAiivl9qa3NsnExKDgFGubrLFwKTZkgnjwrQgg9
         JeQw==
X-Forwarded-Encrypted: i=1; AJvYcCU7zJBKItJmw4Ac5h0bzAmDxIbFeT/Q8dtnAz5G4IM0DAJqEDu/5qYNTTuizFltm5VJpL9LpxWrrAbGCg2BZXZ4G6ncIzAMJMj4Va60
X-Gm-Message-State: AOJu0YxfzzULUZzhVaiJYSaVx1Zgc+fgP4U3pCChp1968ZIm6rFQCDoY
	Y3I3B8PIHY1yWGuib/BrLQXNX91g9NON0oB8oomSzmGzF2URckjgvnQEiMM8SlhYwcSGBDxHowq
	5SJu16ieQwHaDJS6j5erDYNX9fsc=
X-Google-Smtp-Source: AGHT+IFKJiCM2SN2ligv8CNgpJzVYuF8k0i+xEowf+oRyvdrdJO/D69BQmMzHrbs7Ze2WfGJvHj+wCTVv7PdEhfM72Q=
X-Received: by 2002:a50:8a9a:0:b0:56d:f7ce:e879 with SMTP id
 j26-20020a508a9a000000b0056df7cee879mr1553500edj.37.1712233970904; Thu, 04
 Apr 2024 05:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212002.1191549-1-nunes.erico@gmail.com> <20240401212002.1191549-3-nunes.erico@gmail.com>
In-Reply-To: <20240401212002.1191549-3-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 4 Apr 2024 20:32:39 +0800
Message-ID: <CAKGbVbudN7s-Q3oUNkopcq1DdwEyJ+yK2j711cgmD-8g2djAJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/lima: mask irqs in timeout path before hard reset
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	christian.koenig@amd.com, megi@xff.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Tue, Apr 2, 2024 at 5:20=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com> =
wrote:
>
> There is a race condition in which a rendering job might take just long
> enough to trigger the drm sched job timeout handler but also still
> complete before the hard reset is done by the timeout handler.
> This runs into race conditions not expected by the timeout handler.
> In some very specific cases it currently may result in a refcount
> imbalance on lima_pm_idle, with a stack dump such as:
>
> [10136.669170] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/lima/lima_devfre=
q.c:205 lima_devfreq_record_idle+0xa0/0xb0
> ...
> [10136.669459] pc : lima_devfreq_record_idle+0xa0/0xb0
> ...
> [10136.669628] Call trace:
> [10136.669634]  lima_devfreq_record_idle+0xa0/0xb0
> [10136.669646]  lima_sched_pipe_task_done+0x5c/0xb0
> [10136.669656]  lima_gp_irq_handler+0xa8/0x120
> [10136.669666]  __handle_irq_event_percpu+0x48/0x160
> [10136.669679]  handle_irq_event+0x4c/0xc0
>
> We can prevent that race condition entirely by masking the irqs at the
> beginning of the timeout handler, at which point we give up on waiting
> for that job entirely.
> The irqs will be enabled again at the next hard reset which is already
> done as a recovery by the timeout handler.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index 66841503a618..bbf3f8feab94 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -430,6 +430,13 @@ static enum drm_gpu_sched_stat lima_sched_timedout_j=
ob(struct drm_sched_job *job
>                 return DRM_GPU_SCHED_STAT_NOMINAL;
>         }
>
> +       /*
> +        * The task might still finish while this timeout handler runs.
> +        * To prevent a race condition on its completion, mask all irqs
> +        * on the running core until the next hard reset completes.
> +        */
> +       pipe->task_mask_irq(pipe);
> +
>         if (!pipe->error)
>                 DRM_ERROR("%s job timeout\n", lima_ip_name(ip));
>
> --
> 2.44.0
>

