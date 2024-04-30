Return-Path: <linux-kernel+bounces-164783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790B8B82CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878A7B20E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB2B53E33;
	Tue, 30 Apr 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LR1+SD3b"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADA2C853
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517712; cv=none; b=IJAf0u6KCqb/oCxskO8NcMNZn4qFiqi+ezaVmJ3MJYXYCFYNcQ4HgqRQ+1k4wrT9gUU4xGGjm516a2Glr1IeN0ulZtC+O/wpgH3L80uuRolgVMWUxorMTa/+H/EDsKkPfnVyoKrlJnQIhDd0sHWRJZvCAzhHDj77ppu+G0z5UW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517712; c=relaxed/simple;
	bh=ho9UgidLiuIiBiXIVvh/lWotAt12lUioguVCFMrGAmc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=HGHKWnyLB5cLL30aa/duXZloE2OIKFJM7oyZByGgBbGAFIYDufv/zh1tY3+44rfnCb55ddfmTDK+TeEYvjLLK6kAOHToVmq0Xg8imdCXbCf4VFZwwpO/s4V3OZ9Zk1RX5mEGZHOXdG0yNsPjbzIXM6OJW4VbH2prnzb/7P5phHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LR1+SD3b; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso2362114276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714517710; x=1715122510; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qAxmFkbAsUiCyvuOdki7NFBNiRnXQiLD4GpfQPzTS0g=;
        b=LR1+SD3biqdcF6A6o9pUxIPnARLIy/lqOU8lmNIDYmyGTvDQoCNNta3I47of2ph6fW
         eGU8a2VXkCc9WQHGyIrUzkQUy42/i03fHhhhxKgdYFtByYb2hheXB01p5erwO6Dxtr+Z
         WdczpBnzj389dx9qVi49wWn4YB1UJx18mPj2LD0Yj4+TCjqOAIWbnfMDFhufIUjGH5BD
         wBTrckUCqxK0i6Sk7ZX0TxfeStHOWZlLvpEpY3KTiH60NL5z0/CBwZiHzP7tBhMUN3+6
         211G1wr87B4266HARbONbsivvTlga/RmPxYfxE31efayQkQPqQLAwh/sbvSQN+5xKv/g
         79jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517710; x=1715122510;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAxmFkbAsUiCyvuOdki7NFBNiRnXQiLD4GpfQPzTS0g=;
        b=wTtEDLuBdvWSAjY9FH/XjPN3L+XzczFcdWc+0elKgv0W6wUFNAIeSRVW3JN4Pc5eRD
         DoxV3uI4R3NTv/2rgRu7QNxslzSIkafHQ/qkAJ5Cl2TMpv2Err49U6u14OIaQ6YsIik4
         ubNqzAv6kHiMbl534wGtswO6rXdnWHnwzUNSKLkk9OhEVar110LUa5LZmKb8TgJXYOlO
         Id3E3cEwcdlyXoyqTEz06l1Kt9Eu85LAQPoKeJTc519brt/w/irhD5b08o03aF2wQp3B
         OEK6F5l7ZPT0NghNqrKeKT1Wg4CHFmJzp4V4qoqELrjgwiiYFgN2COydnNx4q3RNhw1f
         3n4w==
X-Forwarded-Encrypted: i=1; AJvYcCXDXf1M/lFdFew8XozEhttYoprMP8mlVB2+ThSQWPWich8Qh4e+gfMqdtOSJULKDeoyIsgale2QkkN87eCIHYZUHyGuxoGg3O+EyPGP
X-Gm-Message-State: AOJu0Yw1WAdJzhyEP5g63wpx05pEMgwZhkvVpDfbBsfdinbv8Jada8W3
	kGVzDetnlQU9SiHxvEbs0kbYv2/pB+/9RtL0mtjI1/acgRgX1ge8+6Pz8wKGqQ==
X-Google-Smtp-Source: AGHT+IHK9ZYLCG8b4npZTwuIzKwuk6dxY3kvvWa4cO4t/DUmBAbDvkYeEA1Yoj55aGkAuQsGiPcMbw==
X-Received: by 2002:a25:e08b:0:b0:de0:f74b:25f3 with SMTP id x133-20020a25e08b000000b00de0f74b25f3mr1085836ybg.60.1714517709840;
        Tue, 30 Apr 2024 15:55:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id do7-20020a05622a478700b0043999fccc10sm8941117qtb.62.2024.04.30.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:55:09 -0700 (PDT)
Date: Tue, 30 Apr 2024 18:55:09 -0400
Message-ID: <6a578214df994a783c067644c62aa443@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selinux: constify source policy in cond_policydb_dup()
References: <20240405161042.260113-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240405161042.260113-2-cgoettsche@seltendoof.de>

On Apr  5, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> cond_policydb_dup() duplicates conditional parts of an existing policy.
> Declare the source policy const, since it should not be modified.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/conditional.c | 12 ++++++------
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/hashtab.c     |  9 +++++----
>  security/selinux/ss/hashtab.h     |  4 ++--
>  4 files changed, 14 insertions(+), 13 deletions(-)

I had to do some line length fixups, but otherwise this looked good
to me, merged into selinux/dev.  Thanks!

--
paul-moore.com

