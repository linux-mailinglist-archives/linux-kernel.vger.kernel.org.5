Return-Path: <linux-kernel+bounces-151550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E448AB065
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FEA1C22FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15E12D759;
	Fri, 19 Apr 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OgRlcTBz"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC412DD97
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535684; cv=none; b=WvGLregIFL2W1SCQ8pzyX6t3vt0l5HCyEKRtjo+76u1NRHKqe5J4W4ora23c+xzgBiZ6c6CR91U0KJ93lVmb93OhQkYtGrHEEXEaRd6UhZayNC1OupkVeXByxFRdXjlW89CWFvx8KrzigHtUy2T9KbB9xcClhN1Jn+/pgYAuBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535684; c=relaxed/simple;
	bh=xyu03HDQ5HqUivNlWzij0bKqi/bLZ6SmDe0+HX8RqMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d98yrPU8nRZJr4T5+Af+Gk6cl4DL0hVDmZsWkAxD4FuFp5wZhEt7W9MXV+FnoevjmupVR/WVO4UZyNyfuChVWYL6hem81jZ0dYDjCTpbiEMOPfPrkeuTPktDKPNqEC52NRRAdNpl4RhsfyurYlXA3AG8kDw77eDGli+dmy9LjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OgRlcTBz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e45f339708so1649155ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713535681; x=1714140481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSDKTiByg68gLYMeDYGEiSgE2cD3L++faVxv3kdVgt4=;
        b=OgRlcTBzvFxJSkSv9T9WJe4Rjc1Bp014KuSuZFS5tKt6EaZdRrb7uIQrnFCKAqjDRr
         Y6XcLiqT4hRCfnPP3hMo2vEzylfikAFg75VHOhhIlJ+QNIkYIuPwNV3gslciIPwPLFiz
         lXacW/5XE/mcJZgP9XXWwl2nGxcvYzCw7YqR74xsPjnkNtDxO3LHmDpPAYNBJtK9w6fJ
         vXjnKP2yLMpV9lGk1M9VolZNNi0A1TLrwyvrHTK0zPCjzjwR2f6Hm9kUF9U35yLkhV4u
         nkhiDQ9RSAYvtYrFw5PylVndPGK/rP5SmwB66IN2zAnjx3M/MgOCsdeOgIVzaCGD1d4t
         UV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535681; x=1714140481;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSDKTiByg68gLYMeDYGEiSgE2cD3L++faVxv3kdVgt4=;
        b=iaVcwwy3F5O7p/basUycKLURWKu/y0oTEI+OLfN6rFX4egD0aGkWS77FbEeaKV85/+
         8osqAfmh/OigvsgQrWdDwiMsLAxk1TOqK+lTrzWPNERGO9INPUiQVxdzluNnWxJMMKw1
         cB4Wpp4lbE/w0QWxa2LBsuOwEgFLzy/shSheDtg7EHUteJUCjfDEkDCtr2Mke1w915Xf
         iubZJngqiGpEA7xsL61eUlTV4w3diF4s/+B7SLipWKIRzDQdflSIHX6cz8o+IH63yw1T
         wa80xeWlzsEB4zwkYHMMcNZNvX7CzEdtO7+StHiyT+NdgCLQEvtxbrtyz1sDPWG/zfP+
         1oew==
X-Forwarded-Encrypted: i=1; AJvYcCVUKJsR5RIV8bLF4qlJv9cCi30kWZYWOLgMxVQerAin6ScJfz8Sdlq/0PImqYMXWqyZzcq6P4gDZWpHv8MYEfGJourmUffcu+eI5ck3
X-Gm-Message-State: AOJu0YyArGg1CS5aoXlKk5icyVxxQsSDw17KR6+/XGXz2QVd57UASid5
	dlfqyk90msbvhqszCEYUf9D/XyuZXoJ8qkpWPDowaKdbUN87MudxBqeMvXb+gLg=
X-Google-Smtp-Source: AGHT+IE9KKSYVwG72VSDmoU2t2kLvppf7ICd7Pg14moTxUpcllBJ1abOnSOdZ8iLgrSUhwkRCTMeHw==
X-Received: by 2002:a17:902:ec84:b0:1e8:4063:6ded with SMTP id x4-20020a170902ec8400b001e840636dedmr2404122plg.1.1713535681289;
        Fri, 19 Apr 2024 07:08:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm3365406plb.307.2024.04.19.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:08:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, linan666@huaweicloud.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240419093257.3004211-1-linan666@huaweicloud.com>
References: <20240419093257.3004211-1-linan666@huaweicloud.com>
Subject: Re: [PATCH v2] blk-iocost: do not WARNING if iocg has already
 offlined
Message-Id: <171353567968.448662.8909505678465861389.b4-ty@kernel.dk>
Date: Fri, 19 Apr 2024 08:07:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 19 Apr 2024 17:32:57 +0800, linan666@huaweicloud.com wrote:
> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
> is intended to confirm iocg is avitve when it has debt. However, warn
> can be triggered during a blkcg or disk is being removed, as
> iocg_waitq_timer_fn() is awakened at that time.
> 
>   WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
>   Call trace:
>   iocg_pay_debt+0x14c/0x190
>   iocg_kick_waitq+0x438/0x4c0
>   iocg_waitq_timer_fn+0xd8/0x130
>   __run_hrtimer+0x144/0x45c
>   __hrtimer_run_queues+0x16c/0x244
>   hrtimer_interrupt+0x2cc/0x7b0
> ps: This issue was got in linux 5.10, but it also exists in the mainline.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: do not WARNING if iocg has already offlined
      commit: 01bc4fda9ea0a6b52f12326486f07a4910666cf6

Best regards,
-- 
Jens Axboe




