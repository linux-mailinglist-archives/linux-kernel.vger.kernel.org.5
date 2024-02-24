Return-Path: <linux-kernel+bounces-79811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4BA862717
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9689F282C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB814CB51;
	Sat, 24 Feb 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yE3DBTUM"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4D4B5A6
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804139; cv=none; b=NFYGNJ84qPwrU4hnFZ22CIbmbbl3IfSIbjmzc8VWPra4O2NU4THUR0lWQp35OAddfDM1y68YjgW+DhbQIs4UDAQn4JcueWMcTjy7stLAj+2dUfZY8R7gLXWexdIFzPoFTLu536mGJU1nxwOKsQhIXuunMUxfU7gT7aZdijIpE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804139; c=relaxed/simple;
	bh=o7Jjs3TaAPlouujgnP/cSfzC6OWeJ7UN9H1QdYLOBSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mRtCWCTHjg7gMYQNSijxd0yeTMgoA1UOe54jpUigGtIoyZ5fFTFl7lmtu9W9Fbeq9YorRRrOgmnJvokK4QYPpyXa9Dzj0VmMiPeI7pl8i3yUMLkRvkmyfla31Fj/oStcZvD/Tw63XeYmA58H8ugLl2YmPLKgYmVYauCYfdDwnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yE3DBTUM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-58962bf3f89so691258a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708804137; x=1709408937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUpB8lafalL38sJImqCa3LAl1ysZO9xWvK8Dx/nTsgQ=;
        b=yE3DBTUMjVDVD9OLGD9dLMXEk9MvPtZatr/oeyaLvoZGNkKpiDQan1vLZZZ0KnNpTO
         OBBGog7/tDJinexi2FtVS65v63BNPPJHOsGqKOFyJDEXdeDm4ljQRoYvtpB3Frwm27B9
         rBYEj92TOe1dsgCLyI5ZXL2Fpp5XUsBqPlvgBF52hQysz7NDT31eclF/vsB9P4HfgfBA
         qLGz80jc1/BunDiiwAYagcHWED97Nj2ihG2zdLO5+6k5j7QTc7adhA6SLdP7KlZBnHWU
         Imoo38Y5bM9S0hl64V/RTt4gW17HmD/aci6A9LPO+F8RKEXl1tpiiHIqdoJ+Na6WGifr
         U14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708804137; x=1709408937;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUpB8lafalL38sJImqCa3LAl1ysZO9xWvK8Dx/nTsgQ=;
        b=Bi2s8d7WxUdAfQgeY6k1/s9QY3XehMCkCwlqlejG4gnzJFXnnwnDooRlY7S9/6/LGa
         rWBrp9trXECXxiISKIjm6ianL89yM4AsIZzHtPb7CKBArIxsiO6b0VFqDPMvV8xYjBuH
         zMQpRF4qACwnbI1yyDirAii/K4hZpfeAeqDHdrTiSbh/Hprkpy1is9JwVTypNX5U0D5E
         lCFRpN85/yAr+bayc+T+dL8Ccbd5Z3UXZykqu1lSdbwG6DoYMvrMd3TGHStWAV9+Raje
         nPbR7ytemvmzo4dzmnLzhDWewnyCAOy8hzlbICdTVw+4/Cn2c1CfcQk+ue0P3/GeE+sn
         4Cng==
X-Gm-Message-State: AOJu0YyKZ0z0Swfb1S6pjEUJWKjOoGp5GtdnGbhIZqoFz+1bZQxLL4CF
	Q4rZZUqp01/Hcq9qwLR43Sq2fwjocXh7nKsP9ijsbmtFna5tfGEwKU343wV1K9E=
X-Google-Smtp-Source: AGHT+IFVUPzXTU160JAO8/8pMC3SuLnUckq25tDL2fnU6xkHvxBiLRbMM/oZSCdQET0JtNFc7OofYw==
X-Received: by 2002:a17:902:eb15:b0:1db:5b21:dcef with SMTP id l21-20020a170902eb1500b001db5b21dcefmr3556474plb.5.1708804137356;
        Sat, 24 Feb 2024 11:48:57 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7472:2249:6d10:d981:9c6f:5d24])
        by smtp.gmail.com with ESMTPSA id jk23-20020a170903331700b001dc35d22081sm1345691plb.50.2024.02.24.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 11:48:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20240223155749.2958009-1-qyousef@layalina.io>
References: <20240223155749.2958009-1-qyousef@layalina.io>
Subject: Re: [PATCH v2 0/2] sched: blk: Handle HMP systems when completing
 IO
Message-Id: <170880413600.87395.3583257732140064720.b4-ty@kernel.dk>
Date: Sat, 24 Feb 2024 12:48:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 23 Feb 2024 15:57:47 +0000, Qais Yousef wrote:
> Due to recent changes in how topology is represented on asymmetric multi
> processing systems like big.LITTLE where all cpus share the last LLC, there is
> a performance regression as cpus with different compute capacities appear under
> the same LLC and we no longer send an IPI when the requester is running on
> a different cluster with different compute capacity.
> 
> Restore the old behavior by adding a new cpus_equal_capacity() function to help
> check for the new condition for these systems.
> 
> [...]

Applied, thanks!

[1/2] sched: Add a new function to compare if two cpus have the same capacity
      commit: b361c9027b4e4159e7bcca4eb64fd26507c19994
[2/2] block/blk-mq: Don't complete locally if capacities are different
      commit: af550e4c968294398fc76b075f12d51c76caf753

Best regards,
-- 
Jens Axboe




