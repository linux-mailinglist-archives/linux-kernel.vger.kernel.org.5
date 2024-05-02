Return-Path: <linux-kernel+bounces-166355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4558B9985
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A21F2235F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4035FBA9;
	Thu,  2 May 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pq962d+e"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D0224DD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647525; cv=none; b=JS/ybJRGMWNwFf9jLazl7YwIdbq+RfHfxvNzHVol5Mj9reTwYrvp4JOQpCUb4HulTunBi5GspkRXR0I6WfYDxMrILaHpemAZ4q9HCT7WL1FStZelg2yzq9vofaPioz5l04+Y4m7/4q+onksDlF79G3LxmEMby75npoBQQCadnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647525; c=relaxed/simple;
	bh=ti0ouWJHAwbLC+g6TCd2UFHI7N7nD8Gd/HgwX3mScTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVEba1WeYoHrM3cZbpB8mmw7GDbfGVcucUNVUB4Sni9FY8f8xtkRGGhtbAdyk7DzTSvaEQrST+OKgLECxDdCXK5YSwy8CnIdeGe10fja3vCZcX1LOw62X6cW+fRUh/st599xuVd763a/iRZmU0lk1tv+wvnEsjXuwSaLDpNElMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pq962d+e; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572afdee2a8so1322a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714647522; x=1715252322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti0ouWJHAwbLC+g6TCd2UFHI7N7nD8Gd/HgwX3mScTk=;
        b=pq962d+ewTILyCP2bKQX3Gvm2a+0V1X7IiYPX4MDvDaxXqRv06R7sKL9mq7f8HZ4xD
         MMm3Jazisuie1XxAwv9HMOfBgGraedgKz2Mxm35pCBDB8+TmbtMyK56+Vb6ePQN3d5V9
         HxJ+E0Vg9+CKOhcA26RQ6M3EJtAGsYc2qTADjF33Qi8JH5ppnTGRlHkkFAEjhjJ4vgcy
         2dPeq9vKzph9Kb9SQm12SHt8t82BihQBBNUZ3q1QspXcl0+JEm2Taaie5LUhe7NL5jxD
         cA2Ja6aCELyymNIb4Q2DEz/fstUR7ZhiO3qjJHnfFzLn4PwnwWZkIIDo5cEXAzz1kSrq
         kybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714647522; x=1715252322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti0ouWJHAwbLC+g6TCd2UFHI7N7nD8Gd/HgwX3mScTk=;
        b=Bwd+kVY7PLAf4ZkiaLvgXv0qeSDiJGyT2PUwGgQF++uqd2GrL/mogatH4T/RFrjryE
         +BZdz6DtxSEvM3GP8bIhl/J1lV48Or0S8eyjGq0pRyWEk1i2f9SWNOtcrL24mYPZTwIJ
         oRPn+rN3oqgrMAsXvs6oxqjj6wWI7vbzJcYQrZvNHfHStLe3To9Nb0reA3+QZkkmisuw
         gp63rxRUNK9Q2ck8rg5JXPaQ4PyZQYQtZimXNqyJlaKVD8RK+L9Ig3JsT0/hdca9UZoq
         Qf4wA+htrgnOw2uvt6HZ1oqtj/BHFZLHuYDNp4f7zYwfTZtCXzAOYtD/IxqUJDvTnOHQ
         EhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf1HdAiA5lvB8E91UFl+C8m1/LXVyT0cnJ5uLXDPM2KkymdY8jI3Tac8S9hKFWO+q2kjvK4KeNJMKNRB7wdJ8vpiqRTBZML9Qw5RWR
X-Gm-Message-State: AOJu0YwFKYAh4gmv+2HbrV/2VDmjWxKSxZqJ2aKGsTqXKvehyu+020Nh
	Ea9udD9A1o4wggsm/pCe5cz7F05v2K9mrKULWdrxIQxFjHHf3qgXb5AeEPcqWabnVLFeUrWY0Wd
	8rcgNQRy6jPKEM/asRIaN4stR11AguHduQqzIWzc72Dj9tvLRXg==
X-Google-Smtp-Source: AGHT+IFRSe4PucIslK+BGM9vZ9APHFpXULwivi+bdtDezpxEzGPf3xkvdjfQ3WN2cF+wpM/yvRzgtwL6OOEjqvLZdls=
X-Received: by 2002:a50:a6ce:0:b0:572:a1b1:1f99 with SMTP id
 4fb4d7f45d1cf-572bdb3ae19mr112653a12.1.1714647522208; Thu, 02 May 2024
 03:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502084450.44009-1-nbd@nbd.name> <20240502084450.44009-4-nbd@nbd.name>
In-Reply-To: <20240502084450.44009-4-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 May 2024 12:58:28 +0200
Message-ID: <CANn89iL_=fn8TuH_LL8u1empT30PV25zoe0+dSaTumAEYF+s3w@mail.gmail.com>
Subject: Re: [PATCH v5 net-next v5 3/6] net: add code for TCP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:44=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>

