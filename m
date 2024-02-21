Return-Path: <linux-kernel+bounces-73965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A485CE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232981C20FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41F2836A;
	Wed, 21 Feb 2024 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aixZDuUu"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABB2E632
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483158; cv=none; b=skIbzILk34U+G2SZqPkcBc/EjhbQxOGk/BtplUTaihaGuyXOxQEPSScVwNDRi89ep8KGqcb1+/8UL+0ULIHDhuZffL+JAwFegl/GzoS9KvK55GoRlXLBJBmvYn/ynpY9w5j9EjYitg90Lp2IIvy0YFH0SnmVd2O/mxuViHKP3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483158; c=relaxed/simple;
	bh=1qWObMFBRyR70js8RTU5T14VhYADPv0/ruiD3TiWGj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjHIblVYvslpBDXK6H7LvDQibKFlOiQBDFGXPjS65rxTsYQppgAo26hD3owrvfZzvjTqsIB9DX+J1nf+Eef3/MP9LP7F78bhazChW0eEc0wPxkFnDXeMDIp3eBJHUAAqKDLmkvOn9Jpz4xee63FhpgIOfujrLhuMN00DQMEk+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aixZDuUu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so5111459a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708483156; x=1709087956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8lEpDwN25kJocQ0ZnkfcJKWbT07COY6Pw2SWJ/RJ54=;
        b=aixZDuUulWsCEUpf6XR+Zt0wU37Ss7HbM9dEzgcwId4SjH9fM1VvCrD0NENbI9x3nj
         D2YbE+3ByEIGdZ9RDPTYmltMtLT2Njd/Ua/TW9EkwRq/11U0CTtGleq+QPoz3g6bWeqV
         S1qtIArckv/m9x/HwkClDfhH4bkmxRVd17Mk49ksNj8By0RXBlRrqu+DRaUWcImwg4qO
         GI+gkwGcAd6aoo0h8KtaZA6v02qhPJGVBluqhNjfqGAB09ELvx4v08gxyfmEpC4zhlea
         tMB+0INrnrVV3XcXbevNvxBBYNgDK5dSuD6PBMgoTMPZc1N9hbfRC2YJQy6xqRWsTFQK
         Raww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483156; x=1709087956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8lEpDwN25kJocQ0ZnkfcJKWbT07COY6Pw2SWJ/RJ54=;
        b=PzFGC81uvZqmHaNymtsIHg5xETS8FGjEFNqI/hnRiNLj8S7TyQTwVYMgGrHJPlU5XG
         G0eYSkCdZEXN7fKR7vg01+4jkvjAcX03MoC3HSUA0M1diaadqJ7E8AeqoQsI2+8E7u/x
         eTAgKYZcmSNvNbhKZg8J2grpVoUaY1228avzdoaXY8HR1Vtvb3r1Gq3Lof3onZ2Rom2h
         uap7XV6ASZajB2HlYDc4BU7OLuoIkN377kh5Vq9/eXitnz5oTb2FwVDOL+8xdMxsoXXt
         ywTTJXneFgUQadIWjE6ja5hXa3MUs4GWLwkYFPbsxB7kPKFEivAax0jM9S9lKRTKzHdr
         ZtiA==
X-Forwarded-Encrypted: i=1; AJvYcCXucC7n3H9OM7YkFTcaO36kLLOWOYudmcyIz0rvscjp8QoVhf/z7s9LJJ7SZehqtRAwQGS7FAgUQWVVysLGsuDMq0jyzxVhfyrefPdV
X-Gm-Message-State: AOJu0YyrDQhMGTfL8j5HjK4n3nHMUhz4haaVkZSRZ/brq/h3nM+xZ8/3
	gD4juN4TMrE2pocGepZ1jCtIUbDo5SoAf5lxsarAvOqU1UMq9JdR6nkLL0aEovsGK3tuhld+a+O
	nIDeoHVL2+p1v5eh4I64omoDpGyU=
X-Google-Smtp-Source: AGHT+IGudAOlDCt2Y1zLFk0spncwb1Gkk/lxSUNHFoJyItNMfZXBLSBEY3yYKRhBVt2Mmbbu11PBQhluW4ZuCLUcuRo=
X-Received: by 2002:a17:90a:fe07:b0:299:69bf:1ddd with SMTP id
 ck7-20020a17090afe0700b0029969bf1dddmr7461993pjb.49.1708483156450; Tue, 20
 Feb 2024 18:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
In-Reply-To: <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 21 Feb 2024 10:39:05 +0800
Message-ID: <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:26=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Feb 16, 2024 at 08:04:41AM -1000, Tejun Heo wrote:
> >  0001-workqueue-Cosmetic-changes.patch
> >  0002-workqueue-Use-rcu_read_lock_any_held-instead-of-rcu_.patch
> >  0003-workqueue-Rename-__cancel_work_timer-to-__cancel_tim.patch
> >  0004-workqueue-Reorganize-flush-and-cancel-_sync-function.patch
> >  0005-workqueue-Use-variable-name-irq_flags-for-saving-loc.patch
> >  0006-workqueue-Introduce-work_cancel_flags.patch
> >  0007-workqueue-Clean-up-enum-work_bits-and-related-consta.patch
> >  0008-workqueue-Factor-out-work_grab_pending-from-__cancel.patch
> >  0009-workqueue-Remove-clear_work_data.patch
> >  0010-workqueue-Make-flags-handling-consistent-across-set_.patch
> >  0011-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
> >  0012-workqueue-Implement-disable-enable-for-delayed-work-.patch
> >  0013-workqueue-Remove-WORK_OFFQ_CANCELING.patch
> >  0014-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
> >  0015-workqueue-Update-how-start_flush_work-is-called.patch
> >  0016-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
> >  0017-r8152-Convert-from-tasklet-to-BH-workqueue.patch
> >
> > 0001-0010 are cleanup and prep patches with the only functional change =
being
> > the use of rcu_read_lock_any_held() instead of rcu_read_lock() in 0002.=
 I'll
> > apply them to wq/for-6.9 unless there are objections. I thought about m=
aking
> > these a separate patch series but the cleanups make more sense as a par=
t of
> > this series.
>
> Lai, would you mind reviewing patches 0001-00010? If you're okay, I'll ap=
ply
> them to wq/for-6.9 and then post the v2 patchset with the rest of the
> patches updated to reflect your reviews.
>

Hello, Tejun

For 0001-00010:

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai

