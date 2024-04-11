Return-Path: <linux-kernel+bounces-140516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283718A15AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A22287518
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A251514C3;
	Thu, 11 Apr 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LC+0coqd"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B14F9DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842464; cv=none; b=dCmBMEgxdnsV3YbnCMOVQG0Gg28tiDTE5ULghM700d3A2oqjAg+g5KY8rNnRxO2k2h+8SqMGLsqr3kE73AwyBm7dgEHDWzAQwUOz4oIghVmMSMAgZ93SUJo2SP0PNX0fx9TREYXUUtVZVY4vzSV/g3g4zK7LHplAvPFlB1ZP7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842464; c=relaxed/simple;
	bh=RxBpwU/kRRGgr7s9/OHBVmoLUXFS+qobsZ+FAmDrctg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VxVUk3CLU0XHj5iA+MVBG39VkIDUnNebM7/RBP/qnRBfYVm9ssx16zNjGCIKPpekTB8A30lLDKGSFgMDHP4VCASg14163MCBYC/NDwPv0W8PxFjBOWTo6PhQzLzDLQ2xtNWC+ZRWNVu1zJV57bRplZWCgoSsRjhd4QuBHk3DgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LC+0coqd; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso177615039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712842460; x=1713447260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV7BST669sfKAU9q9E3PjsM74g2J5F0Mood+knoqfgg=;
        b=LC+0coqdTkgpTbgkorzzXpIMonNy0zuKuSw0ismcr4Dmz9x/07tiIUP8IyJYtuo9Qj
         ysIjv964TxfsfTlvj6NZee6ynVYb38MNFN+4YJ1dJhwkLjZngslVSn77t2LmY/TC+maA
         gMP642YwcMRla0qhzRUMV1KkXESLMN8E6IAYddTiH3IVStA5Ar3aGvPP0KtTodZbhIN1
         MnUiFY8iq/tFasW+Hy5M1X+kfbweBvFqvf8j9M/0uyU/5sCBVNM53adtyOqgoUJWIMSM
         5Lh9u25qsEFYqTZhXAgs8n7t30NYeYI9dzgN2bLKqKnj6lt3OGJT0EFSg9LVPCZ8rKce
         c8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842460; x=1713447260;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV7BST669sfKAU9q9E3PjsM74g2J5F0Mood+knoqfgg=;
        b=vfjlDDfl64aAmidvS3pCQvIUZTWWlFtEHhsETI+rh3ubGYnG5wqQ674nNEX+fPmVtc
         fn/TgnfgCRNwImORFK4ystAyrHeJIKwvYJq/sb7TA9gXDZrz9IKw/o0IivFjct9c+RdR
         PDklVmefUVim6BhNF5PlhnqVPPt1KoWq64Qc3BMuUL+TEsy398rY0La+su6q0KiCDaK3
         t19HzVCSlyTe+3gmOpfyhjTtOMi/TnUpHgL6d8P+Uz7Zc8G01XojhUoCf1F9zR7TzgcB
         EODIpg4USORPDPwVSgmcVP5St3D6cgPNn58RtmjTD1LnysJfCQK+V3OMq/fd+GKLeru3
         cukQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV0183Mg0PDhx/tsWKRIiQcSAuX4qBCPuzAKORtTfoYO326qjKC8/KtwHLiCh8qWnpryrZD+iYcriidQUo7sowuw9YRrPIjoNUQZp2
X-Gm-Message-State: AOJu0Yx9R8tAnf+2kQ5DsI/2NvvCJtrXBaP/tsjFmT2atLzldoDpm5jH
	kPFD6KuyiHeIXVAXto2DbDyYHRkwLkbFOcnGqp1J2Cl2ciZZqjF3qKupDrBjwr8=
X-Google-Smtp-Source: AGHT+IEG6+vVsFTe7a6HgkCt4LmRNF24rYL9lHjQgXZx6ZeAEiB7i5mPrzAnIpYtF2GFHjZNEP6aVg==
X-Received: by 2002:a5e:8d03:0:b0:7d4:1dae:da1a with SMTP id m3-20020a5e8d03000000b007d41daeda1amr5848363ioj.2.1712842459538;
        Thu, 11 Apr 2024 06:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g5-20020a6b7605000000b007d65ee260d0sm394777iom.6.2024.04.11.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:34:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ruyi Zhang <ruyi.zhang@samsung.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, peiwei.li@samsung.com, xue01.he@samsung.com
In-Reply-To: <20240411055953.2029218-1-ruyi.zhang@samsung.com>
References: <CGME20240411060014epcas5p1658ee85070dfc22544e4fbff9436cb46@epcas5p1.samsung.com>
 <20240411055953.2029218-1-ruyi.zhang@samsung.com>
Subject: Re: [PATCH] io_uring/timeout: remove duplicate initialization of
 the io_timeout list.
Message-Id: <171284245862.3311.11180570371949756929.b4-ty@kernel.dk>
Date: Thu, 11 Apr 2024 07:34:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 11 Apr 2024 13:59:53 +0800, Ruyi Zhang wrote:
> In the __io_timeout_prep function, the io_timeout list is initialized
> twice, removing the meaningless second initialization.
> 
> 

Applied, thanks!

[1/1] io_uring/timeout: remove duplicate initialization of the io_timeout list.
      commit: 99e440c5b1d70084eeb2097bd035e50c2de62884

Best regards,
-- 
Jens Axboe




