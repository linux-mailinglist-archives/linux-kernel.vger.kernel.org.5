Return-Path: <linux-kernel+bounces-121629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72A88EB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CA11F2FD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EB12F360;
	Wed, 27 Mar 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uHMkgmZu"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE912D76A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556957; cv=none; b=K29qNY6Vl0zYfRZEQoW3qpWBtcAMPimqY/QAF5SU+4YPzw8hz4hivf7XBQzR8sWXU5cUjbXavIKSh1BPZTGiCacSu0QIk6cKxgJB1x9YWfpX2BS3s1XYTReSBUFZLpUylAMfXRHcTjMNLrYoFAo7r6PD9U2jNwRV8/O2iN4QuxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556957; c=relaxed/simple;
	bh=yzKmcrqxgFemQy0dfPuenWcZqlVFJ9u4XKYFhp7r5LY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t9Wko1lC/+JUqrbl7lz2xB4+AcTryK19hOGsnhkAOv3S8CBJSR5cHPvH6EbyPuj/8oAbnbhyvcbjK9U6Den2ovJ88SWogussr/uuPOESgZjY4tDoopP4Sfr/2x3V/AudkRWz1ILhgUx8N2UQgKY4mORjTHhvgHCjz6MvUGZQDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uHMkgmZu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea729f2e38so11333b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711556955; x=1712161755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IzTyaxEwSLWGHKB2lU+u54hh5UjrFpDvHA1AagdmQE=;
        b=uHMkgmZuhhtr8pcRQrcqTsPkNXHFyXjmLwy3tk9brIfmMokyWTJ4oJUM7TI7hgra4O
         JmcEt1uGsfR8v+o0EuCBPZ7X0UVmURugb4yx1lYma8z2/8zoAwVqRqeR+MDYGg+k9pnc
         21Fvizd/7BM5aGcHngVjwYHKEkEdKx+vfzwAgsxH1J7E616NDE8sYoe7/MDSuKN0TEPN
         Y2dvFEaLD0mJ0na0V7G7C7s2JuRcVyMisVsUiSq1g1o+BIGpQgXCicawPBfNXFjQ//MJ
         yhvuDJWWgBgG0s7XoTtuIVRHv+rQNBT3muj7l9ws8a7wWW53K5BUdLmtMla4lATsYCxy
         lMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556955; x=1712161755;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IzTyaxEwSLWGHKB2lU+u54hh5UjrFpDvHA1AagdmQE=;
        b=Lu1V+oSRve+y/PsVL8p1R+Eeb2e04J3XZ7izi/7tJ0aaGMST3uQ6ZXyv/n7HuS/LFP
         xJ8xxCaZamMuUSnzBf7nkA+W5EcQQ/2yhBAONkOxB3PCgk63b7KTbc9rc5CV6CDH02LF
         lM/j3ZpxU8vK3isOmG1fKQPZN8+aKnCdz0C8dHOCFlbjIR8/IxTXRqky9fymrSWpkIEr
         JxIogsECwjpd0zIr9vJ7gmFfAqIWkh/5Qa+trShsETs/RrtqZrq+vvZQXy0vvyxxgm7Y
         QQ1foJ/ckFmzBov70MAJ1DWN60CL6JsPfLu7vFPgj3fqx8SqJORqrWpHhYRFYPkIURTy
         zM7A==
X-Gm-Message-State: AOJu0Yw2rqXFuQerXLyjI1TvQVmUW0e7VlvyAvHKV9fI338YFnsVm6wf
	2XzQ8kCrhihOtYuy0E/2d5OVyL+doa11eDdebKiRwXCXPZFqCeBfB+HI52wxqzs=
X-Google-Smtp-Source: AGHT+IHvHfOO2nxh6smPSQiUPrNZXci7ylhmNv/x9FGT5+lxx/s6twPlVStZdyUHvqtrVAv5Cqk6KQ==
X-Received: by 2002:a05:6a00:1828:b0:6ea:b9a1:63c6 with SMTP id y40-20020a056a00182800b006eab9a163c6mr368591pfa.1.1711556955165;
        Wed, 27 Mar 2024 09:29:15 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:5ff4])
        by smtp.gmail.com with ESMTPSA id q9-20020aa79829000000b006ea75a0e223sm7998068pfl.110.2024.03.27.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:29:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, 
 Juri Lelli <juri.lelli@redhat.com>, Andrew Theurer <atheurer@redhat.com>, 
 Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
In-Reply-To: <20240322021244.1056223-1-ming.lei@redhat.com>
References: <20240322021244.1056223-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5] blk-mq: don't schedule block kworker on isolated
 CPUs
Message-Id: <171155695404.507853.16905998627647073688.b4-ty@kernel.dk>
Date: Wed, 27 Mar 2024 10:29:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 22 Mar 2024 10:12:44 +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used to isolate CPUs
> for specific task, and it isn't expected to let block IO disturb these CPUs.
> blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
> CPUs is run for blk-mq kworker, long block IO latency can be caused.
> 
> Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
> WQ, the responsibility is on user because CPU is specified as WQ API
> parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
> and queue_work_on(cpu).
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't schedule block kworker on isolated CPUs
      commit: 5f27f3d892743312fce237958a4194859ef93d69

Best regards,
-- 
Jens Axboe




