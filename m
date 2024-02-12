Return-Path: <linux-kernel+bounces-61250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440D850FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B91C21CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474E179AA;
	Mon, 12 Feb 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnbSGPxK"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287D17BA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730514; cv=none; b=bWULRRamc9f72awVvwISFUMCORdAVgF8gn9xKRApKjYWBLhKy21fGiKwY4O1MfrOljaWC/CNmdK3R/LmwDHxrapXAX6+e1XUWgst8bz797h3Po3FO6Uty0wEC6TyhzKQ7/Avqm4ni38pR8lzsJRtVsLHr/Efi2TQAE1VyD+Js4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730514; c=relaxed/simple;
	bh=zMsYBJdefRbRS1oJBVQytEShuramaVpb8rAhJF8Xwa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/TG2KqQ0OoC1anKOvYdAcV7qv7QL9zYVMcTte7oq4+obXXjtgUjgH8YdtU4qeuvz21WmwUN6JiX6z2heH/vO+ucm3FCy1BSzDhadbbkCdafhDD8Osk7U9rLlnY7QhDapjmLZyn50HsJ2avWqdlSMdVZSzxCkb9Qe5TWhkHDlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnbSGPxK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56154f4c9c8so17068a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707730511; x=1708335311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49Pfy019p7jCH4WHQFV/itn58Ta0gVCaehKec6pDwNU=;
        b=ZnbSGPxKRvRLNGToMwx03CMepsQz3Q7jGIh3nGp8iwIkJNV1XF2BulSFRzpqjsiBTx
         /jxmSVwmZUEcCE9zH6xW9FLc5nerWIEs04lXg5FK+1sfMJf/5RTxEO8e4ukWyQFeEa/P
         YDWZ5l242S3BoygDjTvkw2WIH3F8WKU6sxg6nzU6GJdaFlQPpHAOjeZ2Fq7FEgANvPvA
         AXqOYJ/x176Gyj6iPWnOMimIW9wOj6xTJa+NAMt6t8ZGovdyvhH5f3pwHeuqzepaSNM9
         m7Gb9hlQ4/GuiumbIiA1CacCeZI1XKcRCe2IDZfDOvAKP4cxDbIXSF/bzDHLczuW/IrN
         SsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730511; x=1708335311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49Pfy019p7jCH4WHQFV/itn58Ta0gVCaehKec6pDwNU=;
        b=IT8fGgg3bKGuHChiTv5kft8+kHhCcV5UN1ahJVN+Aeot6mEYmqnP6r6Lxpr8n/HRGJ
         pxJ7KmtvVUo44jb0h204WxNX0IrNanlE8WLdtZ91ZI61teckPwvMkGObiVsjjxqYVa9t
         b3O+YcXFKjB1fmh5Cm1U1X+w/5f58feiFqP1FUN2ApCUv6iL7FCVK4tbrVG65vxQEvtk
         yXF9rVxi9yTAHEPorV8Do9NGmd6hZ6eatj0ZRfjNkCsve07d9KzKyt8eGsvfyz1FUykD
         x9hhjsuBm4K4lHAfAooGxtCiWtvwtceuOBhkhblT2ql2Q8ei8kE721NOr1YWwp/TF+2v
         zsvQ==
X-Gm-Message-State: AOJu0YzRSFIAp/bsy08V8XVgE+Pc/0MVi/ZbduV4aN5ZZgyJ32XPdnY4
	xUkiYGleHiDlfbaCS+HUH1KzWZPL2ZAj5KAXHjVisY8+wXSKUR6YBmcMZZAsXH4tmG/oON1vLiT
	zM5DBcCZFWpagN0SoI7MFoVDLSYXVmXghq2Ut
X-Google-Smtp-Source: AGHT+IE90DP2qYdtoREl/pW8hB5dGkqsSq19HY3bQagXr/qZHS6Eb8/aPBg38eBJHnzPK77uufxVPlon7RmZfubM88I=
X-Received: by 2002:a50:8a93:0:b0:55f:8851:d03b with SMTP id
 j19-20020a508a93000000b0055f8851d03bmr183753edj.5.1707730510754; Mon, 12 Feb
 2024 01:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210125054.71391-1-remi@remlab.net>
In-Reply-To: <20240210125054.71391-1-remi@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Feb 2024 10:34:57 +0100
Message-ID: <CANn89i+4SHqf7NCX4uyr0gCJZKSzcmxAGTCwqwrfRPBnMvd1Pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] phonet: take correct lock to peek at the RX queue
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: courmisch@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 1:50=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
> From: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
>
> Reported-by: Luosili <rootlab@huawei.com>
> Signed-off-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
> ---
>  net/phonet/datagram.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Fixes: 107d0d9b8d9a ("Phonet: Phonet datagram transport protocol")
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

