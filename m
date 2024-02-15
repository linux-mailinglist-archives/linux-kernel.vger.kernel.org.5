Return-Path: <linux-kernel+bounces-66725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE948560B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB98282FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297312BE8A;
	Thu, 15 Feb 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gA66lzTh"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDC12B152
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994718; cv=none; b=Bd3kZrJgVO4rypCaLRiNRjtPdzv0r/QvL4ma4XKuC1OTGnntLiiVanIjByKZhNo4ew9UGAok8YLj6RyPXhkI0I6ANbjQsVid97ufLjtky38LG0JqLxkqB9wMWG2txZjU1krxNKECEgEbXOiprnvqFjW7U5Jo5Q4zJsqndghQY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994718; c=relaxed/simple;
	bh=tzDHngKZk6QIBWOoNYjBmQJOk/IA1gtla0htMhR27Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuVnaM09vowPKmapXktDNR40ZVg8chWi4KBm3OgcHAFpwr39eyYeo1dS1gSSF2lONOXsyukJM3It9X6Ayg7GwC66Faolzda7oz3W2PgdNnzIsKAKI6qZkByGVLj2hBDWjhWdA7xltN9lwvCO7STXNqBVkUMNqelQXk2PfrE1+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gA66lzTh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so614204a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707994716; x=1708599516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJvPkqnLdxaKyN0Hdk5m+Q6BeTQyhOtuZMBz4sQhbGo=;
        b=gA66lzThdoTm4RVqUuFEAFNC2bTxpYTBVgTJenOa9z09KiZ5pqF1Xgf56GBq6R6nCA
         ZlcNAJGaPG6qwaHiMGjNYbz7myDAQkoWNcCldTfRrOuArGBe04aRAsDDxaxpy5F6hlPn
         jY3d0QD5Djp6ELW3WVkwQFlJDSpW4LBKop1/ixNuwPLYQpEeYum6oQiJPKmYkTWaUGw9
         xY4XZJJs8ccI2elpPbHc8U83sjRaZ2ZPfxCmlwZPqMZed/URFrOVyPVRe2XDGmfH3j5B
         sPkTKJFx0B4rLdQbjHEERvWYEn2cZ5XhRae/8rKlE21Hg2F21cfwVdk9A7orRnFsDJCW
         9+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994716; x=1708599516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJvPkqnLdxaKyN0Hdk5m+Q6BeTQyhOtuZMBz4sQhbGo=;
        b=uHJA2v+YeJkGWhvaekShEBuw9UvhmCIYg0J2vzGp1Ct0TEr4fz3hfJetHJRb5Zj/+U
         79g4UErZEu8d98NTFIaWAKHcaVRCTdWiMWbdJl+LPz7AfRAb1jd+0g4HChBPTTWui1c4
         zYAoLW2k7Z4ld+cqneTVFeSEBV/Q0/nHW2aXgJyU93zdj+ZnJwri49Hp/bsofbcJ5MpC
         gvnBFtKfQ2+qXhrJ+GgviQ0OKD03R9OJfhDJNCEiHmPodgPI42em0w46aH8TxqDX1n1v
         EmVijyGVMcM5XNgKWJnrGltn8CCg1l5P0K05zgzu3oay7exWgmUJw27uds8P2eEq8YnD
         ztUA==
X-Forwarded-Encrypted: i=1; AJvYcCXP1uu1YABglofqr6/zPYE3m5GfmdJkD/thBR+KtP7b5SlkTKNMYd4KAbR56OvelsaB5BGGm/zxCTKvZrsUbv/uRAqsU8j3vsi8dCK7
X-Gm-Message-State: AOJu0Yw8D1oyh2StfQ/lJfncG2lTj66CsCbJVdaS/eYhbcznRcYwWKQZ
	1fwpSmvgOB7m0HYe5ZICLgiXJPHw3PSb+IjGwXl/WUFtf7Nm06MiKACzfZl60RKl/XHoCELuJnd
	xp+yzWpVikyBxFSbfnQYpseC1aoqNV1BB+9/lhg==
X-Google-Smtp-Source: AGHT+IEzCZBAeq/xYnVu2+hD//hf32Mg4uqn5Mqc4dDYQHNZxNY994qa1bP2ikp+DEEJOhrLGMkMQ/cWEBk62jrYjiE=
X-Received: by 2002:a17:90b:f8d:b0:299:1f21:e54d with SMTP id
 ft13-20020a17090b0f8d00b002991f21e54dmr275615pjb.8.1707994716320; Thu, 15 Feb
 2024 02:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213142228.2146218-1-naresh.solanki@9elements.com> <6wpmx3ivbp5wihdm6nbul6sjxvbkh4oe3sdthdikm4ikofgsiq@vnviyphamouu>
In-Reply-To: <6wpmx3ivbp5wihdm6nbul6sjxvbkh4oe3sdthdikm4ikofgsiq@vnviyphamouu>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 15 Feb 2024 16:28:26 +0530
Message-ID: <CABqG17iiCJQ5=bECMQ8CMT-6LJp6bhtDSfdMYM+n1xWXvjHBGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: pca954x: Add custom properties
 for MAX7357
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, mazziesaccount@gmail.com, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Rob Herring <robh@kernel.org>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andi,


On Thu, 15 Feb 2024 at 02:42, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> Hi Naresh,
>
> On Tue, Feb 13, 2024 at 07:52:26PM +0530, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Maxim Max7357 has a configuration register to enable additional
> > features. These features aren't enabled by default & its up to
> > board designer to enable the same as it may have unexpected side effects.
> >
> > These should be validated for proper functioning & detection of devices
> > in secondary bus as sometimes it can cause secondary bus being disabled.
> >
> > Add booleans for:
> >  - maxim,isolate-stuck-channel
> >  - maxim,send-flush-out-sequence
> >  - maxim,preconnection-wiggle-test-enable
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> this series was already applied and I sent the notification.
> Didn't you receive it?
>
> You can check here[*] (branch i2c/i2c-host).
Acknowledged. Thanks.

Regards,
Naresh
>
> Thanks,
> Andi
>
> [*] https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git/log/?h=i2c/i2c-host

