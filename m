Return-Path: <linux-kernel+bounces-29600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D182C8310A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B891C21A88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EAA6106;
	Thu, 18 Jan 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8umDRlv"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5C5665
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538980; cv=none; b=pY1FBEVjIPztJB+ta9oKl0fcBogOCx8ZEercm/xQ2kooa1Qiv0+3Ppekn0ORJRFZYvm+hSZKOAJNvr/t/ez11YtR4ypj/Pf/xUCMuWdzji0O0mHFCq7mnsiatCEjlM+dR7JQ/eI1ga38i8UQvzWi4gtZsAJS9Ww37CLsL/W1PDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538980; c=relaxed/simple;
	bh=IDOzoZHeJ0iz3W+/xu0WzKtDcoiDLr0s8G+dfR08B/Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Fva/Dn78jg72Y5RL/DdYkAXle0RmY4m8stKLTFpiHDLysXfOfbw1Ky6a8TsRPb3qFGFtxpAS21vIc3TFnJ3ZHzF1MVT16tu3NlWKtzUsrHDKyUlEQzXb+IGNT9grelKzIed8uqpHCaVJ9wiYl8R+dPIghbVDeJEUI0Tt/n4fAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8umDRlv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee328027bso247737339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705538978; x=1706143778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9FUEFaMWmeoSw6S1OOVKDbETXX42mqL6s2E3UevsRs=;
        b=l8umDRlvuxM/x4tS987qjVL4Xdf1sRg/nF/Lh7kpx3A21j95P41M+54TZJGMf3x8ch
         mzLT4+TToWg/0ZQWDgkMrDPgPdUcxnmSRll0ycYJBe6uBPaQgT3P0QG5uaqo2mT7PueM
         v3dXpMLuFAd+sTACywBHdyliRy61dRq6rXZLcqiSs/USjYnSxnP8iVKGMyjcsckt1YwD
         zMlSVm+dB4PnfFnVPT6kiBCE6G+b1ATrR00UnmRbyk5ZvXWilOmAPn1SrLq0fUnM3E1N
         DI4Gt271s2pJQ5LicjRvhIpbmajyC9FH8BmKlvx2dkFenfQMNl50HPQTzV6gbec2K+0W
         UZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538978; x=1706143778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9FUEFaMWmeoSw6S1OOVKDbETXX42mqL6s2E3UevsRs=;
        b=fyXjiFPLRHAxIHZ3Gu54BDL/Wx6/oDZXtB2wBPclTIugG/RWNAi9uq2auwILVKLd8S
         UVdiUAASx5zcv9qtz1KNUbWL8QSGW+9ljhXa4/O3uttUxFsR+pQN8/LIPuUEsQjD/lZJ
         iZFwUH4oINSJ5NneTGx/f0BrR7zJQZYOA8gkzKPdPCIpeO7bHWRgOGHhZx8uyqJ6cXoJ
         eZBCfYPMRq6kPw6qWZoAvePPspV72ydyTyXpCnxbhb7f2rggAgtegfHMlsDZgskxUD9a
         QAjxmgNHBhE9RBiRRGsVzLR6EUj5RaVrNXkKV35uj7szRB2NPEZqzOu+S4fOm7fQk03N
         2zsg==
X-Gm-Message-State: AOJu0Yy63vvfOSgRIkjmWRJpQqBu9YDuh1ftRImwZTNsVk9OCEfu/9yq
	BMM9Y4bvQoT7mtdFZD9aLNkZJmc+6XDikqySLluVFsIicHVNiBLO0Uj/0lXMhJ9JfNOs5GuhPNF
	N3Z9+Js+m7XkRr0kKvOchQbKl8RTEeRxKNN4=
X-Google-Smtp-Source: AGHT+IEKIq02Ewrir+fRl6LRtXWVhTSY6TGQKd55rzTbquHWYyPk5EQ+eYA6cD2jzSLJ77Jm9KUp+ZsB/fcmq4sxqc0=
X-Received: by 2002:a05:6602:3284:b0:7bf:7321:40aa with SMTP id
 d4-20020a056602328400b007bf732140aamr180962ioz.43.1705538978433; Wed, 17 Jan
 2024 16:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
 <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com> <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
In-Reply-To: <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jan 2024 16:49:27 -0800
Message-ID: <CAKEwX=NhNtggdv5q8F35RrsP5rQ=_G=Gs-v177Onu7piezK-jQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:18=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Wed, Jan 17, 2024 at 3:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > > Currently the xarray patch should have everything it takes to use RCU
> > > read lock. However taking out the tree spinlock is more work than
> > > previously. If we are going to remove the tree spinlock, I think we
> > > should revert back to doing a zswap tree lookup and return the zswap
> > > entry with reference increased. The tree mapping can still decouple
> > > from the zswap entry reference count drop to zero.  Anyway, my V1 of
> > > the xarray patch will not include removing the tree spinlock.
> >
> > Interesting. What do you mean by removing the tree spinlock? My
> > assumption was that the xarray reduces lock contention because we do
> > not need a lock to do lookups, but we still need the lock otherwise.
> > Did you have something in mind to completely remove the tree lock?
>
> In my current xarray series, it adds the xarray alongside the rb tree.

Hmmm why? Is there a reason to keep the rb tree around?

