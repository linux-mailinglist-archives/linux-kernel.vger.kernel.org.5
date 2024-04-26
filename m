Return-Path: <linux-kernel+bounces-160071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876228B38B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88FB1C20884
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA3147C99;
	Fri, 26 Apr 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vR9Qfkd/"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6C824B3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138854; cv=none; b=Gd/7o166zZhQs9yY02NIpJHLc05cyvDRD/phXyNpLWFnbvk2HppcKe+6lP9uwW568bbvizSvSvMrGXOLETUqm2QZr6aLN6xCJkKvG0gt7kkRljmlOCm9q4VyeymWyGOH7nJnoqMB0XwTXvaOSu6L2QtAWPDsmqbdYb20PJCQbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138854; c=relaxed/simple;
	bh=JCJDTBds+a3tbNd3ShHOf/AGk6tUWyo+qW7RdyRA9F8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OZUp7YVwASI6Vm34crwydZpiHKYDulvIe7CtqAroFazQEXWBflLiZQmy8MYqCWQtrbENz3f+M7TsWB0UYDHGIr/xUlpXnf20x83sn1rz2w47gIn3pU4Qt70Hm6P1wOf6ka/BeLWg/aouT+V0N4xrFifCrgntt/OCzaSx3mTvPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vR9Qfkd/; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d9c78cf6d4so17166739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714138851; x=1714743651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQVjNTLjf7VGhqiwo6xWa81d5ljtfH+fLb0sr9Vc0PA=;
        b=vR9Qfkd/CNfgMqdHA6L1fuVG/Kf179E/6sjmL1tGBGt5/vA6kbfgcDIMBXZF4SeB1V
         xAiLL0o5yMNjR4sMjl4/n4XdvAbpv/HQGoZMhDGNui5VtrXP9ym0xOVUcigS7bzMM3KI
         B/hVa9WsyFukuxIX0Enqc/vhqJ4ZkKb6w8dv+GfqU/2+sJl+RBXjAcq3A3vgutfiqk1b
         QM3ig9HI7PYleDeAa5nZaRzJp2xB7rfLhHgXlp+cgN/XeJcZ3UFNBJbOomQgksG8lJwV
         cZr7ipv8+9tLOEvjb/zg4FbVGWAwOSH0ZhuxMrSNzFvqgUgUmEpGQokIRnrcoveEE8ei
         TR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138851; x=1714743651;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQVjNTLjf7VGhqiwo6xWa81d5ljtfH+fLb0sr9Vc0PA=;
        b=lS3/OVDjWh6fBOQeLU08j6yzxl0xPlsPF5jIv1VRFnjARShXsBixempfD+pJT5DSgr
         4Kvl0D6qZPMn9+sm88yVi60a2srxHVMzGMO4dc7LlrHXjo7/XnJdbzWVUqB7new6tW7a
         eWlMrTwAaAJLIV/IM9Ip3g+PYzwhApZVx22xXan1cdEQzkWqYRvAoVCyjLT7wnWCIAm3
         nrxP7AAGv+2zkFksPD8wMmyqkUp/Lge5MrRLb8BUf6on9EFI7Ovv5IuvPiccbaBl/hu3
         pp4tYb89c3vvrdXDe8faspiZhuwQ0MVMa2yp+R/lVfSLZ29BkepUe8Nj0awg4XPkxEpR
         I4tg==
X-Forwarded-Encrypted: i=1; AJvYcCVKHTI8hLsT91r9cgYnOD3NBQZ3QddNYTqWGmBxX7cZM92bXiW1k0mEZvXp876eMcYWERbyiLDVhiMGH9utX3TKfyrV10CYwU/J59Hr
X-Gm-Message-State: AOJu0YwVLBV6Z3j8o/HVPB2eIQLyts+ZxI60Ds99qMpzBoYbCv8dY/DN
	Yusf5stKjICRrfnKXx6mYjf9wzOaGmJh0hOngJVDhhYdRiK0g4M7q2z/FSLEFbg=
X-Google-Smtp-Source: AGHT+IESz+VVFibB4v7kcRuR07qQ5guc4rVZROLiXv/vGQeFvCRzC594gVmkjdesOS1PumJnF390fQ==
X-Received: by 2002:a6b:c503:0:b0:7de:b4dc:9b8f with SMTP id v3-20020a6bc503000000b007deb4dc9b8fmr263925iof.2.1714138850823;
        Fri, 26 Apr 2024 06:40:50 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a0566022ccd00b007dead4fd0efsm255275iow.18.2024.04.26.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:40:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Pavel Begunkov <asml.silence@gmail.com>, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_F9B2296C93928D6F68FF0C95C33475C68209@qq.com>
References: <tencent_F9B2296C93928D6F68FF0C95C33475C68209@qq.com>
Subject: Re: [PATCH] io_uring/msg_ring: reuse ctx->submitter_task read
 using READ_ONCE instead of re-reading it
Message-Id: <171413885012.211722.950447967094465539.b4-ty@kernel.dk>
Date: Fri, 26 Apr 2024 07:40:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 26 Apr 2024 11:24:37 +0800, linke li wrote:
> In io_msg_exec_remote(), ctx->submitter_task is read using READ_ONCE at
> the beginning of the function, checked, and then re-read from
> ctx->submitter_task, voiding all guarantees of the checks. Reuse the value
> that was read by READ_ONCE to ensure the consistency of the task struct
> throughout the function.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring/msg_ring: reuse ctx->submitter_task read using READ_ONCE instead of re-reading it
      commit: a4d416dc60980f741f0bfa1f34a1059c498c1b4e

Best regards,
-- 
Jens Axboe




