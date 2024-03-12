Return-Path: <linux-kernel+bounces-100376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6C87967A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6334B2545E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046E7AE72;
	Tue, 12 Mar 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="groIalZQ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACFA16FF3B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254085; cv=none; b=fRA/Ha8xdpOb9KaK+bBInhVM/AO65nZDCAeW4KpBBp2PO93xj0d7vjGDBo+EXv4eC8UGmGJO1mrsrZXbANptq80lh02Jheh1RFtUGDV/Zw0rw/mLXVCqIHeE2fxkrriwdEYcPbplRJKblXu1sMvHlLRdcEex/tKenFsexf1ADz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254085; c=relaxed/simple;
	bh=cXh3uEsgWMI8iZusOPz9HdPAX+leG9wjwQ9vb4XC4vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9DuFpnNcQPT3NrKgbmMoQTuZeqjCv1eNCfueMDaqVooNVckjeK+tQVRcQSc8NVV1Lb1cOQN9fh42bNEdWRDZX6+KSga8NB2tv0mULkcO39H+ZqYyCm1Ol8Kr4+pGneS4X9hWVOi4vfZrw++8CwU1jc+cBjDmUi+uPROEDukBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=groIalZQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e696233f44so271505b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710254082; x=1710858882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzzmKMopoCRQwM8a7mNzAcigvxiHAg2EWip7lmqWvzY=;
        b=groIalZQcyiVJwNREciuCO+9Sq6vGaaFVANzHujV980JGPrKTOZIzhx0SsPBP7SpBk
         /G+WK/cBQO1i0AJveQtuzt/QfGvE7BqRExr6tIJHnh4kzqCqY/RzN1eNMbwsv80dU8oT
         jLjWD4SziWWQdKDgXL1KsFZ9KqazFOZbgRIgQlp9KLxe7gSxR4N7KQWgjQRVjpzcRuu4
         Q1Ffdtg7ifplLpDR0f2ezSLqjFEtBT0b5E8Y2Kz+bJpADkuWaPmcUjuKGiXhVlwasrDz
         FsGtSW91l2ue5yNSehfO8PjJvMvIITL3VgmI9xGVdZs5MzXAtcCx45SR81DGqgcsILLJ
         DNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254082; x=1710858882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzzmKMopoCRQwM8a7mNzAcigvxiHAg2EWip7lmqWvzY=;
        b=vJBtZLlE1fHzscJ8mpXQHg2CSlSOVNuFyAsC1nvCMxx1wC95cxHfupv9gYyyOrsqH6
         cdka0yDnFCZ/PUFShGShtPb602qMPEqVIMeIOHgOCIotIgZCepW00z1kLXtWLePHLUFk
         /cJxXmUf/iL8EQdFY6FkL+/MkNCFY/EJLoN/BXbFkwXYwNLTMT1SUJz7SVWvoxkG1Oqi
         UOuk53agGVwv/XMktiT780waCQEBhvhoukuuJj6t/CotjjANh4csklAmdUeXGipsw4tc
         V/ymxspCH3VRTNGx/6XX5fp2LU0L6nGEa5poQPGfwyEYVFM9IH9fV8rAtYvo/Mp9lVmX
         6xIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoqpH63mPe6RJT+XbAbew45RuCJJbjC+zOWLs5OR1quv47f93k6uIxBV9X8dK9l9tVGq/mDzrJ7UyAyMz66MtMFyexB/ex+TGyunnR
X-Gm-Message-State: AOJu0Yx05dCEl2pGgI0f+t8E+DH1KYCa+P1aIBMl9Wt8fv2qoZaIqrei
	zdnHsbQ19+K7dzMO/BHUwmPbD7b0ps8zuKFFBjsD9f76OJl0mib0S9SvkrjO9mbewuBQ8OujsYU
	s
X-Google-Smtp-Source: AGHT+IFDcI8mS2gs9NO0X5lrcuBm9Bmac4hHIKD3R57tXZnBo1tuk7q6bjTSHz+jRGAp0khnB4GNIQ==
X-Received: by 2002:a05:6a00:2384:b0:6e6:13ec:7170 with SMTP id f4-20020a056a00238400b006e613ec7170mr12480717pfc.0.1710254081762;
        Tue, 12 Mar 2024 07:34:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21d6::1197? ([2620:10d:c090:400::5:d2d7])
        by smtp.gmail.com with ESMTPSA id v129-20020a626187000000b006e6988c64a5sm3312432pfb.208.2024.03.12.07.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:34:41 -0700 (PDT)
Message-ID: <8a9993c7-fd4d-44ff-8971-af59c7f3052c@kernel.dk>
Date: Tue, 12 Mar 2024 08:34:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15] io_uring: fix registered files leak
Content-Language: en-US
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Roman Belyaev <belyaevrd@yandex.ru>
References: <20240312142313.3436-1-pchelkin@ispras.ru>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240312142313.3436-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 8:23 AM, Fedor Pchelkin wrote:
> No upstream commit exists for this patch.
> 
> Backport of commit 705318a99a13 ("io_uring/af_unix: disable sending
> io_uring over sockets") introduced registered files leaks in 5.10/5.15
> stable branches when CONFIG_UNIX is enabled.
> 
> The 5.10/5.15 backports removed io_sqe_file_register() calls from
> io_install_fixed_file() and __io_sqe_files_update() so that newly added
> files aren't passed to UNIX-related skbs and thus can't be put during
> unregistering process. Skbs in the ring socket receive queue are released
> but there is no skb having reference to the newly updated file.
> 
> In other words, when CONFIG_UNIX is enabled there would be no fput() when
> files are unregistered for the corresponding fget() from
> io_install_fixed_file() and __io_sqe_files_update().
> 
> Drop several code paths related to SCM_RIGHTS as a partial change from
> commit 6e5e6d274956 ("io_uring: drop any code related to SCM_RIGHTS").
> This code is useless in stable branches now, too, but is causing leaks in
> 5.10/5.15.
> 
> As stated above, the affected code was removed in upstream by
> commit 6e5e6d274956 ("io_uring: drop any code related to SCM_RIGHTS").
> 
> Fresher stables from 6.1 have io_file_need_scm() stub function which
> usage is effectively equivalent to dropping most of SCM-related code.
> 
> 5.4 seems not to be affected with this problem since SCM-related
> functions have been dropped there by the backport-patch.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 705318a99a13 ("io_uring/af_unix: disable sending io_uring over sockets")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> I feel io_uring-SCM related code should be dropped entirely from the
> stable branches as the backports already differ greatly between versions
> and some parts are still kept, some have been dropped in a non-consistent
> order. Though this might contradict with stable kernel rules or be
> inappropriate for some other reason.

Looks fine to me, and I agree, it makes much more sense to drop it all
from 5.10/5.15-stable as well to keep them in sync with upstream. And I
think this is fine for stable, dropping code is always a good thing.

-- 
Jens Axboe


