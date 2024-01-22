Return-Path: <linux-kernel+bounces-32526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D54835CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C51F1F22B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E8210E8;
	Mon, 22 Jan 2024 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bdYdp+Tu"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0D210E7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912349; cv=none; b=dtp657WH8rLuAsI5xhgddWc7zqz2/Tw+za1y1QPRsq8vBNvGXCnjhU9IaQ8CkjxEKXkB48byyFgcg/GvY1fuulOgJ8ygbnl/3VMVya+Pe09Tw0gTjRPln7MMakwMow2CQ/zBFSQdw6WeEzN2yBRF7H/DoE4uPPax4yayGeYXuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912349; c=relaxed/simple;
	bh=EtZqJ4B2FZGMNOG4yGL0LqaMUtfMJG6rR103zhhA9JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msBYDuCfQiG/Y/WJ+UcYpBCy5skVbqgJqUcWnLkgWePRZLzXep7hKnOy2ePGKIPsMIO5e6yKkI9NzkwEx9A3pcYrZu+aUvkmhY5ddQels2bJrU7VeGGO59ulm3Ia7V0ryTdcyS6PKVBH0/v5wzi4uetjXi+OEa/9cfZRvfTV/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bdYdp+Tu; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e0a64d94d1so1788296a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705912347; x=1706517147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtZqJ4B2FZGMNOG4yGL0LqaMUtfMJG6rR103zhhA9JQ=;
        b=bdYdp+TuXRfRBehgBifvY0KMawrvPIx+nnDVB9mt1AZA8zWLvt/KqVkZlIJ5fIa6yV
         EerlZys4NMeVUDwg5PwagyEAQgv1jFGsIRPInBo7+tLWb2zrKPyCAFwNCVItuDqxXxHJ
         3zRghBtU5/UltVpobhswoJPC8TY+hQ93F3xMc45chv4T3JWafM7aC1rxR2Dm1TiAV+7m
         KYqUnmxCXwDFvE4kaRCnZtLSKW5RE/vcFPfoam+2e5NHkkEDVFw2HfliMi2kMBR55Beu
         KV4XyiTg5vajukgBwNCOsesTe3F32R9J/FT7xSSqygXvGNm+Ipv7QZpn3o1F1rtU0V+2
         UcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912347; x=1706517147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtZqJ4B2FZGMNOG4yGL0LqaMUtfMJG6rR103zhhA9JQ=;
        b=SjB0PKkWU7j67a1iWDT7iwJViG+VJ7IzFDPqJYaLFkl/W8sZt6CnJCPMjJDvA5OQuu
         BPdnKObVh3EnxO3GxEShyvy2DyRxtQZtDivScvifbd73eZnqoF7yNDpNrz6GBrtk67pH
         f0WFYgZQDK0BKeS5zPjfVde9oEvc58pnu8cA3hbs7GDxnL9dirwCmyPKnm9c5hk4ODxy
         ReANbeDVYDKxltB8zLLssYmgu3Z63RzGjZ1jpjKG91xSwQWtZtjjMofZZSvL70LKnn2c
         M2VpMu0lmu/Nl1kn3gAGcTrkjItZIeYXFTaSTDFcXQRdd7GSVDyNgCa0q0j1qxvGBQah
         Th/g==
X-Gm-Message-State: AOJu0Yxgj6+3FfgSnOvvHmMyAwlNXUdLiYXtjInblhcxVvFn6Qfwre4K
	NZ3/CE3RM5rCuj6tZ9DcTQj6LThxbECK3zLxbmEp/rnhmNHmTunzwIZDfJ9LQAi4wFIkr0JStzI
	W0oaRoEJ6jjbF/G/e/q2BHhJoR3Ok9PjIHHyaCA==
X-Google-Smtp-Source: AGHT+IFnq3h8ethTPUxLz6Ya3PNnAQJ5O4TRAx+X0AmSFv8u3tvvhEcM78yKIkf+FYTTqsGGlgcwgNrYHjSv6VXjxEg=
X-Received: by 2002:a05:6871:494:b0:210:a266:68e4 with SMTP id
 f20-20020a056871049400b00210a26668e4mr1768579oaj.9.1705912347326; Mon, 22 Jan
 2024 00:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122013510.55788-1-cuiyunhui@bytedance.com> <20240122-boxcar-conical-c728a709aa5c@spud>
In-Reply-To: <20240122-boxcar-conical-c728a709aa5c@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Jan 2024 16:32:15 +0800
Message-ID: <CAEEQ3wmX7_VP-YM9NkesAhd+5zetw79AW9bo0YO7KGAeJX4eRQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: cacheinfo: add init_cache_level()
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	conor.dooley@microchip.com, robh@kernel.org, sudeep.holla@arm.com, 
	pierre.gondois@arm.com, suagrfillet@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Mon, Jan 22, 2024 at 4:09=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jan 22, 2024 at 09:35:10AM +0800, Yunhui Cui wrote:
> > When cacheinfo_sysfs_init() is executed, the general weak function
> > init_cache_level() returns -ENOENT, causing failure to add the "cache"
> > node to /sys/devices/system/cpu/cpux/. Implement the init_cache_level()
> > function on RISC-V to fix it.
>
> If you recall correctly, I asked you to explain how to reproduce this
> when you sent the patch.

In fact, the reason has been explained in the commit log. As for how
to reproduce it, you can check whether there is a "cache" node in
/sys/devices/system/cpu/cpux/ on the riscv platform.

Thanks,
Yunhui

