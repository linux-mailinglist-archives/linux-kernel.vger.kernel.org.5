Return-Path: <linux-kernel+bounces-133766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFF89A85E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8EC1F2173A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA713ACC;
	Sat,  6 Apr 2024 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kMDveTdA"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B7F4FB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712369280; cv=none; b=rhhPiZ60UY8dFbkkz3rnnAHG175eh+tFf89/8vm25jYve4xH5sUBM8LbRAAVPe1dcDcvVRjFxwwGDcu+7UpHJyMdN7s7tvoXSMVVoZvFhspTVKg0nSnGjumNX4WNEd6XLHvj+7Gnq6tm1ORsSCmBI1zmyhDBi7/N4o4g+ZHat18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712369280; c=relaxed/simple;
	bh=NRDSrd//lw3VipjgP/KmiM8Kzaxra2OkM66vbPYRZmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q5IEg7IAi/YVdPi4s98+rdTyRDwiBkarO5r4grLp0dvZrtmfh/bvkfn/7IfLfXf6M0ZLFZcAmsX76tcbR8o7tnn8SVc26k9QfAt16nT1O5cn/623lrP6YuBtmwBC1Z1aZNd4nAAsghX1sIJBf/G8E34O2xt6i4so47gOtraYn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kMDveTdA; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so56977439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712369278; x=1712974078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfyeTnbUOHjE4JfMs0wGJdvVcv7mV0yWrczNYacKGfg=;
        b=kMDveTdARaGNPMxjo/wgLDzNKK55H8YINc2kt5VgWqq6U0fbw9YT20kEtmCfjdQr0A
         sDLgSXC4mVWvKO5aO1dp6LMkYCIpS17Zyao3612UoUYYkoZ+R0FapHF8v4I24LHzti+y
         tsnJHSDOhXVFfoZ1sNRq1aXs0cPQIBaLiGwD7pFp9GhvrVucx8Fhg9OzW19wDEyu8Df2
         SuLoxm5aSsQuaUkAlk0uce/MctYeiP5RX98KjGHg+goXS6ETe2fh8FOg6xHx1Uqviu5b
         5Qk3CyMijFGt34L4JWzkXAS6diePL6Hx5gnj7FvoAptxDa0dlBvULwRlri5lqdS+C0PK
         YcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712369278; x=1712974078;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfyeTnbUOHjE4JfMs0wGJdvVcv7mV0yWrczNYacKGfg=;
        b=emRu0Ss0T4jagISLdBLDqd3FxRdDEIbS3X1lrzNUrrzJQ6ipMekv92qgsmZSo8w3M8
         OtmJCRhpPgcssSedaJxzuWTB1IIVuifQxZYmLrE6w2B5ilT7/iDphmNqg8c+GE4H/xRB
         4ysanfZBSG6fJLgugVohcG3V/axVZ76WgYP82ISm2lORfTnoJWox6iRXKVGWtcz7OIvp
         AZHrl6sL2CcbhhFQPbK95uPi24HRfBJ9sIrfi32uiY1TLpMD3jGKRa/0n8QbrbuxWE+d
         nVWXeQQQM2cFxU8ZGuq3kVbdhzSGfeNKNSzqFp3lhK/uU/1c7kOlOkobi/qbuZNtCAYq
         3ftA==
X-Gm-Message-State: AOJu0YzT1fnzTFTH6X4nMSso0Ey46ofkZJ47n2eIUWYhmOBBmcqFzGZl
	NSo0EB2f+e00nlf3Ts7CmAHIHtowRA9FwTeAl58/kZmvFqBdeWGlsZmjrigPMWg=
X-Google-Smtp-Source: AGHT+IH/HsleWvwHw/pVrctaalvVy7+rmbzL5bu+lHTyu0TKoHSuajK+U2MSGalABMhK3FGF/GMHVA==
X-Received: by 2002:a05:6602:1644:b0:7d5:cc9e:9d96 with SMTP id y4-20020a056602164400b007d5cc9e9d96mr501025iow.1.1712369277985;
        Fri, 05 Apr 2024 19:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.135.167])
        by smtp.gmail.com with ESMTPSA id jb6-20020a05663888c600b004827f5def6bsm28853jab.4.2024.04.05.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 19:07:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Cc: kernel-team@meta.com, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20240404123253.0f58010f@imladris.surriel.com>
References: <20240404123253.0f58010f@imladris.surriel.com>
Subject: Re: [PATCH] blk-iocost: avoid out of bounds shift
Message-Id: <171236927113.2455316.5665277976518467416.b4-ty@kernel.dk>
Date: Fri, 05 Apr 2024 20:07:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 04 Apr 2024 12:32:53 -0400, Rik van Riel wrote:
> UBSAN catches undefined behavior in blk-iocost, where sometimes
> iocg->delay is shifted right by a number that is too large,
> resulting in undefined behavior on some architectures.
> 
> [  186.556576] ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:1366:23
> shift exponent 64 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> CPU: 16 PID: 0 Comm: swapper/16 Tainted: G S          E    N 6.9.0-0_fbk700_debug_rc2_kbuilder_0_gc85af715cac0 #1
> Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x8f/0xe0
>  __ubsan_handle_shift_out_of_bounds+0x22c/0x280
>  iocg_kick_delay+0x30b/0x310
>  ioc_timer_fn+0x2fb/0x1f80
>  __run_timer_base+0x1b6/0x250
> ...
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: avoid out of bounds shift
      commit: beaa51b36012fad5a4d3c18b88a617aea7a9b96d

Best regards,
-- 
Jens Axboe




