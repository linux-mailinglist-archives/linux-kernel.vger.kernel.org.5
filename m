Return-Path: <linux-kernel+bounces-75904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274F85F077
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F61284614
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08F7483;
	Thu, 22 Feb 2024 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOSUhHFv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DE6FD0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576602; cv=none; b=RHkrceksPJfCb2X1yKBoFI2ogTBU8xZq0GflMrYbqVZXLWCQgos8dBUlNi9sOUYovfWGoROExX2sw02ciwpnlbl9MdB9A0ZR0Q9m0oPKNRz+76MxGHHvLxXQwvs+XK//cqFRpv5LSsjg8rQam/F+QljOHwUHnakEckCys1Ap4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576602; c=relaxed/simple;
	bh=HdN7+AKC8DWX5bPv9sXsmOVezlzmjLelKL9yNEc//sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXZj9VNaMYGGdZICjTezuMNTnZRcVTC3Xs5YEFKepgJkSq9YLV2ST16OeF1dtl7kqO1jPxI53qH2DOK+BUX8gR3umhNcP0G2FGyWWEELZApYIwiPOl/S1jure7uRKyCV5DL3UfAeMPaNo5QTgbl1QbhJIOl7Ny0SKztjBnMGgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOSUhHFv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290ec261a61so4497840a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576601; x=1709181401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xti1IqxCGmLTinz1Gq6w2C6CFTv920wHr0FWiWByAAk=;
        b=TOSUhHFvGQGb/w6nFByf4TMBpeHPLDR8lrchwfaZGzjXyG1WMwKAHPIdQcBnPcc4ze
         9WngE/nEJc6jlKQEtBuOluUPuyN29o1CZLQXT/H6Br92CRBpyWAbWwbUJj3CY83YZ8LX
         KJSNdfw4i+tjXYDmknxNdzHPPurJfY4cqB/DqnMSTQ5Qb8FChB+gQunl++by3YrCpsAz
         cEY3wzIgn+HsCiN9vFT+h8oDaaSn/zOiDRLvwIA65fkS+EHLeH05/Dlm/Q2JYohJ9DMC
         +abaYAPyqXA4D8xLn6FPJCvstdVmspqmyhHgK6zgZtiXWRJ7XVp7x6b9wO4bvAPw7Un6
         D9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576601; x=1709181401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xti1IqxCGmLTinz1Gq6w2C6CFTv920wHr0FWiWByAAk=;
        b=wV2z/vAA+QRx53PUkUtS+jF31um43rEUuLfM9OCFJ0j0dfEEsI1fUOmiG0b2ezOSGU
         JMrAvDHfiAqi5oN+R55JZ2T7MwJEbwpZfNCWl3BDtOnaq9r4LUatgJv61hX+ke+HHX/6
         FvEMxEhiNcoPO2NVUJbGQoSfx0FOPw91OqjkCbbmVl1LiG2ZGeMLxm9ChRW3WGxnL2oB
         xSwdvFZ3/gChYKFpZ5srISrPb0IUBZOgR1tAab6wZWC/uTcohfzy5U/K3177uODIclT4
         70Mars14wxCqBT9PDPspKHAVhcfPcBEtcLz6vRbovzPg5JYKcntQ0Oup70x1umS1RE4r
         tUTA==
X-Forwarded-Encrypted: i=1; AJvYcCVPGpXfAK2tNIVqbiv+Om8cyMKZeUiADwpprsJmDQ6JbdPeeQhO4JFNgZyDfsxRrh3iTkO33WiR4IgsrC+iuR8sWqAj+4UyBjvF29Iz
X-Gm-Message-State: AOJu0YzX7893mS2czrkRWELiAuoIbIuVa/c3ivEdZcR8iryMgCkleMLa
	C6e8G/63Y+RsM6jExnNqja02eI0bMT+TNhKNvKb2cc3CJ6jbvsrnzuc8eJ58utE2yUeZi++6Vb8
	GE5PLNu725TrIZ1XmMuPFm2K05zQ=
X-Google-Smtp-Source: AGHT+IGuUaomOTMXbjHqAw7vmI3o8jPBOJee8wUfvS7bnIWEcW+C4o9IAtihYglDqC8s29Gq7BRG0hv36UkI1a62WXo=
X-Received: by 2002:a17:90a:17a4:b0:299:b60:ff0e with SMTP id
 q33-20020a17090a17a400b002990b60ff0emr16959288pja.13.1708576600716; Wed, 21
 Feb 2024 20:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221174333.700197-1-tj@kernel.org> <20240221174333.700197-7-tj@kernel.org>
In-Reply-To: <20240221174333.700197-7-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 22 Feb 2024 12:36:29 +0800
Message-ID: <CAJhGHyAOzXVwGy5T-KXpwXgcWp6jLaTGGzspPqQU4Dw+x1GqUg@mail.gmail.com>
Subject: Re: [PATCH 6/7] workqueue: Allow cancel_work_sync() and
 disable_work() from atomic contexts on BH work items
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Thu, Feb 22, 2024 at 1:43=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> @@ -4077,11 +4076,37 @@ static bool __flush_work(struct work_struct *work=
, bool from_cancel)
>
>         rcu_read_lock();
>         pool =3D start_flush_work(work, &barr, from_cancel);
> +       is_bh =3D pool && (pool->flags & POOL_BH);
>         rcu_read_unlock();
>         if (!pool)
>                 return false;
>
> -       wait_for_completion(&barr.done);
> +       if (is_bh && from_cancel) {

Can "*work_data_bits(work) & WORK_OFFQ_BH" be used here?
If so, the previous patch will not be needed.

Thanks.
Lai

> +               /*
> +                * We're flushing a BH work item which is being canceled.=
 It
> +                * must have been executing during start_flush_work() and=
 can't
> +                * currently be queued. If @work is still executing, we k=
now it
> +                * is running in the BH context and thus can be busy-wait=
ed.
> +                *
> +                * On RT, prevent a live lock when %current preempted sof=
t
> +                * interrupt processing or prevents ksoftirqd from runnin=
g by
> +                * keeping flipping BH. If the BH work item runs on a dif=
ferent
> +                * CPU then this has no effect other than doing the BH
> +                * disable/enable dance for nothing. This is copied from
> +                * kernel/softirq.c::tasklet_unlock_spin_wait().
> +                */
> +               while (!try_wait_for_completion(&barr.done)) {
> +                       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +                               local_bh_disable();
> +                               local_bh_enable();
> +                       } else {
> +                               cpu_relax();
> +                       }
> +               }
> +       } else {
> +               wait_for_completion(&barr.done);
> +       }
> +
>         destroy_work_on_stack(&barr.work);
>         return true;
>  }

