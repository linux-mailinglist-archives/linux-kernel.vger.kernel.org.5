Return-Path: <linux-kernel+bounces-58429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E084E669
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BDC2853FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4C84A25;
	Thu,  8 Feb 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NCkfAQFd"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5881AC6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412369; cv=none; b=tRSCtP0OtGkMObYDBB6PINudgb8etTPdkbf1P1PD4gHhnl5M/Gk+SDd4UqHfdeZgOY5z30vaHI16vnY9dlTYGiWU9RywFw2Z07ugwY3OneUBGKAqN0oz5p4j7M2ZpcwHWZiTruaEe92Qm701vdkuLB+huQL/S8dv7Mwa9f1OnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412369; c=relaxed/simple;
	bh=AIEgU0V1g1nSho2UWkRURvPzJPm9oPVlHGX6wRLgm6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uMjj6IFWVLWSjQeromzjn5DQdZYzeE1z/ulem1LsVJXpRoSV+sMNFAEezannc1/Lzj5ewd7WlWOBjmlfi0RETpoejZI7YWrZjPg2v7mUWgo4XG42X8xOM2dVnTxmNuq7vg+k3ql0s9ZNnUyhBPHUDaTRp0cw6Il6jWDR2U30VR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NCkfAQFd; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so4132539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707412367; x=1708017167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsCIZkl0nmR84Phg+akbf2xIXLOesyEDRMsbgKsDjIo=;
        b=NCkfAQFdqMH9ohzyEphPAE2XdnKgwOnqg3lFy9X1l1AcYjXq8XWw75LsOCGOwMcBFh
         M0wuCnuSLfgELfIKmxOONPNxlOwBU+5LZMTXR735BvRSIBJCQRV0L6eVtweVeuZxx6MP
         dnfeVNsn3/n21on4WaRPk1aSzgfnIU7ohWdxtdXOYb5BrxV8z9S1FYQBqZQ/a3SkFM2E
         FqJFYbOey5BSaMFCKSPamrkoCS6/shD1bXgv4Ed0GqnkJ9i6ARj2a/IBieQra7i3m1/Y
         oGb02vihDIsgfrSH5dro+FtE1f8dCBVnwC/3n3gji+HfjV9saqvmTMBI5shapfRBCcb4
         hlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412367; x=1708017167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsCIZkl0nmR84Phg+akbf2xIXLOesyEDRMsbgKsDjIo=;
        b=n87fw2Y5pd40wpnj+6MVEulqRwllYLlfYZFtQ0JtjmOsCo/TcucWs5FraGRHJCfO3k
         wFrKUBEOV2NSHUiRNGOAzWnI/VrNrRbLXttIhq/Y03LtWdLh7F+1GrGHWgTB84RYkcq0
         azAqAL+0HG7cNNwPPTCyv6EeqWt4p+u6iQd+yH8ASha1VIHN3DY2P6r8sxG9CAl2/rrD
         ygyjs3pug7fAwwwtIRMXNabCTppZDmFssO/LWP5ykgHrhdTRa1W6REKPr4khtfb/SllY
         K/6lE7b3i3VVJ1+wCOTU4TFIAws9nZiusfDN+cYtsDahXsSLx+Gt/w5rGQVX8jWeS+e4
         g5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdbWmrlm6nvo09OOczQmc2qnp9ypE4+/3O0I0gVvv3TJTN+1A3kIvQoM8WH9k10FNHPYXixWVX2kkpwwaQfvckFdR6KG/pr7ShLBoo
X-Gm-Message-State: AOJu0YyTmGCq8DYSSOi7x3V217vA/5u7hiPDIqmzj9c+y1yBAVMAHI4y
	RnM3sfKN96VwKMVNUjmcOIZksI+DIALiv3IFTGQTWojYB5QsNfU1gqPppzXnu4o=
X-Google-Smtp-Source: AGHT+IHTeFLLa4+D4qPa0huYZiUSegoj8zJfG3N22QhdohjlsQlehD4ZYeolut4A2dGViw77zuv9yg==
X-Received: by 2002:a6b:671c:0:b0:7c3:f955:ada6 with SMTP id b28-20020a6b671c000000b007c3f955ada6mr245680ioc.1.1707412366769;
        Thu, 08 Feb 2024 09:12:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0zKLtzwp/gGBW9veUdkDIdKwee5n7OzI3gMx5Q9bg40rPF69E8Bm9vIFHoLqjjYIl7jEQ+5PndyCFlXnS0JYJa5qhRvtoP7vF8F5Ds4ZhCrxwwXPDjZ7qlIhjDMDG/wb2Y21heBXXuEM=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b23-20020a05663801b700b004713f3c2831sm993173jaq.61.2024.02.08.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:12:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>
Cc: =?utf-8?q?Breno_Leit=C3=A3o?= <leitao@debian.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZVvc9L_CYk5LO1fT@slm.duckdns.org>
References: <ZVvc9L_CYk5LO1fT@slm.duckdns.org>
Subject: Re: [PATCH block-6.7] blk-iocost: Fix an UBSAN shift-out-of-bounds
 warning
Message-Id: <170741236605.1366825.11529079339239149351.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 10:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 20 Nov 2023 12:25:56 -1000, Tejun Heo wrote:
> When iocg_kick_delay() is called from a CPU different than the one which set
> the delay, @now may be in the past of @iocg->delay_at leading to the
> following warning:
> 
>   UBSAN: shift-out-of-bounds in block/blk-iocost.c:1359:23
>   shift exponent 18446744073709 is too large for 64-bit type 'u64' (aka 'unsigned long long')
>   ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x79/0xc0
>    __ubsan_handle_shift_out_of_bounds+0x2ab/0x300
>    iocg_kick_delay+0x222/0x230
>    ioc_rqos_merge+0x1d7/0x2c0
>    __rq_qos_merge+0x2c/0x80
>    bio_attempt_back_merge+0x83/0x190
>    blk_attempt_plug_merge+0x101/0x150
>    blk_mq_submit_bio+0x2b1/0x720
>    submit_bio_noacct_nocheck+0x320/0x3e0
>    __swap_writepage+0x2ab/0x9d0
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Fix an UBSAN shift-out-of-bounds warning
      (no commit info)

Best regards,
-- 
Jens Axboe




