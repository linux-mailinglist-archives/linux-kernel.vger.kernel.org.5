Return-Path: <linux-kernel+bounces-44009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086D8841C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B927B28C34B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F7433BD;
	Tue, 30 Jan 2024 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOuHuQMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF951C28;
	Tue, 30 Jan 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597340; cv=none; b=DPb1+c+rJYLhaemFCm0WrpTz3RdYxt5jwG6XBTSQT99VjuV9YewxAMPQSbYDWqc6vrd1TqmcLICVphNWl1DbiaksddV0yWoAZROJz1bqyQIUUB6UL/yIpqcCRR29bIaUmBXjBV9OJUMXGivK8CoG/qf+OiUaep8LXf/C2LR0ppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597340; c=relaxed/simple;
	bh=Lts8NYTRMQPuSuYLjhsH+P4qkbE/Ml69VrRBffpn1Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0RliZB6DYrkn2QjG10x+MgzC1QUrHTWt1rMhXIJcQgNKodQzw2DAgat3/8n68MmyrFnX/9WofeLG44lUfCO0+SN+R01+/F33n/U86F4q3tcHNvPsZb6EbeXNMZfRYMMfZuQ54tlMHNwS6Sjyn+wyxH1Fuh51KvdmFWIj3Y79ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOuHuQMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEA6C433F1;
	Tue, 30 Jan 2024 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706597340;
	bh=Lts8NYTRMQPuSuYLjhsH+P4qkbE/Ml69VrRBffpn1Aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LOuHuQMY9w8eOAwzqLsbzFyCI5GJ5QnsChIHsioy4d+rYr9kXPMX8tCfh3VBTsEfq
	 uT8dAWzAFCPdg5PRpRIYPpOh/koMCVQ/R5FZl89SPX01vDHPyT2ntja6ZjoC5Zn4R9
	 v6xBWq3bAbVYm/7canFTbJbSuk0fGyc8TYKSF+rS27Diwr2GKI1PnUfjQ+ycL+gSTK
	 Mi7MRaje/cLevt5p3tTRES3rzmUAcrP3i6AFESPBjCLmBxCNWcxvf4nmlq2zSv8se6
	 eURQIg9oQQWUyQdaNVtXndL2xOy6y8nG8h2tG/+y3rjwotdj2tasP0ohmwihx80sfp
	 oolWMn6nT5BjA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5110fae7af5so2049797e87.0;
        Mon, 29 Jan 2024 22:48:59 -0800 (PST)
X-Gm-Message-State: AOJu0YyqP9GZqyaLmA6euokkIV9v5nHUTS4+5EuUgomrNUBE1floqpx5
	EgPGwBP6BjCDl+AqQzwVDoDZBfNpmBIMz5vCFfvIVS6GNvYoVOLEYAtZAmdi8rE8HpW95MCNh12
	fa6IVaf8H+qSH4AVVRY4gUq1BAxI=
X-Google-Smtp-Source: AGHT+IEG6PZtQZ8527EmUrzzi+1+TLEcyHZvqYxC5x/00oIk5/z/xWerCrHKhb8y1XuQZStMl8LoBkeOo2N0vqIhqpg=
X-Received: by 2002:a05:6512:280e:b0:50e:b25e:94d8 with SMTP id
 cf14-20020a056512280e00b0050eb25e94d8mr6367837lfb.41.1706597338147; Mon, 29
 Jan 2024 22:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229070500.3602712-1-lilingfeng@huaweicloud.com> <c47a4ff6-43a0-a536-29ff-db2d1a931181@huaweicloud.com>
In-Reply-To: <c47a4ff6-43a0-a536-29ff-db2d1a931181@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 22:48:46 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6YWnG86fTRcPeeGfk219dG=Rm=LeFde0OEJJjGnqgaZA@mail.gmail.com>
Message-ID: <CAPhsuW6YWnG86fTRcPeeGfk219dG=Rm=LeFde0OEJJjGnqgaZA@mail.gmail.com>
Subject: Re: [PATCH] md: get rdev->mddev with READ_ONCE()
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:55=E2=80=AFAM Li Lingfeng <lilingfeng@huaweicloud=
com> wrote:
>
> Friendly ping ...
>
> Thanks
>
> =E5=9C=A8 2023/12/29 15:05, Li Lingfeng =E5=86=99=E9=81=93:
> > From: Li Lingfeng <lilingfeng3@huawei.com>
> >
> > Users may get rdev->mddev by sysfs while rdev is releasing.
> > So use both READ_ONCE() and WRITE_ONCE() to prevent load/store tearing
> > and to read/write mddev atomically.
> >
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Sorry for the delay. Applied to md-tmp-6.9 branch.

Thanks,
Song

