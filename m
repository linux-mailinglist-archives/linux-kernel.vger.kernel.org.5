Return-Path: <linux-kernel+bounces-43709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024784181A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BFF284BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D6E2E821;
	Tue, 30 Jan 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh/wCZ7k"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E37339AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576875; cv=none; b=Vm3CUqn5CvWZBGGJN1J4Td/ePQakJ4LE2EQWpRJO0D8vLrQc+J/+awbODucdhssyD4R1RwCGpzlUDR9qDUlMOo4c4uXYJbqgu/121KqVM/BzAI4WeeoNfjOIP/Bug0+Gb6RKmBK0tmb+X6cvBpfziQlukOp2Y9SA3a5R3ZBUAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576875; c=relaxed/simple;
	bh=w1h0N16WUcapd8TAoWs7Im7ROcbBWsE65mlOKFZZNAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpFJgQOdExe6EDDPZ34dids35/MF/qjMk8rnguYSb7CUiRXKhl3t82vqOBxj45gnq5QQH2pEZ1k1JGHKRdsg4sxmRn/d6EY6O/OwCfNRqdeWxh8srTMvt89KIgLsillB7sBz8bB81DlNZIyTzvF3XCewUXDoD9T5FVjRRo2yFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh/wCZ7k; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-510322d5363so3449863e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706576871; x=1707181671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XdaeecGW0oQf3cb0p/gxE71D3OQbZDICKx8BTb0+2M=;
        b=Mh/wCZ7k8XDTYVZbeauqevRR8HrjeuFaSGXOtVMQF1vGi1wVzs1bjhWnJCHJzL8wTK
         YFKcJx8PNzzx9JzFwh1c3h/+5MKG7WXt5E82FYSUpglzBproJoTriA6VaFg21veKBFrr
         j06UehE0MLpYDy7wLQTn4CLx35MZvY/WhI489ygR9LH6RZE/KsPyDVdSsR9rRXuEfx0p
         oNMQlmMdgquF/1NdM8ht/dqr0EdDaKh91qqB3BZHLTOLg8Xteh09/7cuber2PMI8TuGm
         V7KYeGlnd4I75M22SjdArYIpXMko7c6O/QuXC8CkaUmoAl0Sh2XiDFBODmz2/uASaCNt
         kQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576871; x=1707181671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XdaeecGW0oQf3cb0p/gxE71D3OQbZDICKx8BTb0+2M=;
        b=aS6eeGRf+zGw5n+L1r5uzWJSNYTG1nX8uQr8xB/JlOVoYT0Tu1PyQ4gI+7MpOn0juK
         q4Bnj8DQ9gaJk6z1RG9Uu/S5HmFgH68/b2jSvGTYJwkNXNpVJ3eklPLCazrwqMMz8Ttg
         qG5FPgzfbi0fdzWjdo1jYRCGIyrVVPnKwkDMNA/7RoELjxc5i7ziJjUOiHCQ/00BgYOB
         02wyYFHywv8vboNttiurf7FHPEHhuopVkRin4vas14BerCICVtZkLta6nLPGjb7TnzEP
         +zaXEjwN32CcizUVJvRJdO1F+mG7FIY0Jvbo0ky5ZQAwsZ4xPRCAOiq97OsZD5K85mTP
         IDZw==
X-Gm-Message-State: AOJu0Yws81UVVY1/cfJHmbMzToeLH5VDVkhLiycT6VQiJNxqK2TKx7rc
	kQVjUfXC6nCWamiKrEEdNi3erEuKAQhnaBa+uWB9l3r13hwlkzGlBIMYiSztFge9GTk7z+47eEp
	ohKHiG7k3hqdaGCyhcZcEsOFEQyg=
X-Google-Smtp-Source: AGHT+IFsgG9FObPN/wblpnKndRJFW5tL/xEfSRGC7qtD0er79TFifrki5HvcerMcno8no9tOL5ncD0ozhMFy2bX1eW4=
X-Received: by 2002:a2e:beab:0:b0:2d0:5925:75 with SMTP id a43-20020a2ebeab000000b002d059250075mr346788ljr.37.1706576870869;
 Mon, 29 Jan 2024 17:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025947.2110659-1-nunes.erico@gmail.com>
In-Reply-To: <20240124025947.2110659-1-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 30 Jan 2024 09:07:36 +0800
Message-ID: <CAKGbVbtAe5jnAwb7O8epq3g4FqLC-ggof3D=5gO9hJf5OuH0OQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] drm/lima: fixes and improvements to error recovery
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Serial is Reviewed-by: QIang Yu <yuq825@gmail.com>

On Wed, Jan 24, 2024 at 11:00=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> v1 reference:
> https://patchwork.kernel.org/project/dri-devel/cover/20240117031212.11040=
34-1-nunes.erico@gmail.com/
>
> Changes v1 -> v2:
> - Dropped patch 1 which aimed to fix
> https://gitlab.freedesktop.org/mesa/mesa/-/issues/8415 .
> That will require more testing and an actual fix to the irq/timeout
> handler race. It can be solved separately so I am deferring it to a
> followup patch and keeping that issue open.
>
> - Added patches 2 and 4 to cover "reset time out" and bus stop bit to
> hard reset in gp as well.
>
> - Added handling of all processors in synchronize_irq in patch 5 to
> cover multiple pp. Dropped unnecessary duplicate fence in patch 5.
>
> - Added patch 7 in v2. After some discussion in patch 4 (v1), it seems
> to be reasonable to bump our timeout value so that we further decrease
> the chance of users actually hitting any of these timeouts by default.
>
> - Reworked patch 8 in v2. Since I broadened the work to not only focus
> in pp anymore, I also included the change to the other blocks as well.
>
> - Collected some reviews and acks in unmodified patches.
>
>
> Erico Nunes (8):
>   drm/lima: reset async_reset on pp hard reset
>   drm/lima: reset async_reset on gp hard reset
>   drm/lima: set pp bus_stop bit before hard reset
>   drm/lima: set gp bus_stop bit before hard reset
>   drm/lima: handle spurious timeouts due to high irq latency
>   drm/lima: remove guilty drm_sched context handling
>   drm/lima: increase default job timeout to 10s
>   drm/lima: standardize debug messages by ip name
>
>  drivers/gpu/drm/lima/lima_ctx.c      |  2 +-
>  drivers/gpu/drm/lima/lima_ctx.h      |  1 -
>  drivers/gpu/drm/lima/lima_gp.c       | 39 +++++++++++++++++++++-------
>  drivers/gpu/drm/lima/lima_l2_cache.c |  6 +++--
>  drivers/gpu/drm/lima/lima_mmu.c      | 18 ++++++-------
>  drivers/gpu/drm/lima/lima_pmu.c      |  3 ++-
>  drivers/gpu/drm/lima/lima_pp.c       | 37 ++++++++++++++++++++------
>  drivers/gpu/drm/lima/lima_sched.c    | 38 ++++++++++++++++++++++-----
>  drivers/gpu/drm/lima/lima_sched.h    |  3 +--
>  9 files changed, 107 insertions(+), 40 deletions(-)
>
> --
> 2.43.0
>

