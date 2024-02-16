Return-Path: <linux-kernel+bounces-69072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238185841E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B487A1C22A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48787132469;
	Fri, 16 Feb 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Nl8IRR7E"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAF131725
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104549; cv=none; b=SL4pxuTzPs6DF6g/oKUQc0uBiHHwludbEolbSDjqNW8rqH7ksYnW+yblHFMj5bhs+8PQBMvHXbYMBUzdZ15PA1JOHeJSk6xZ2G7iMdMOWiLs+rnlQ8zMP2wou7eFHwI8c0i171JeBBSoFoFpmPUrEBttiVrzR5T0xEuw06Bl2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104549; c=relaxed/simple;
	bh=0Teybl5JHhiV6DnZbswElanAsqpzKyqCP1XKyIoIurg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njVhobD/pgtyRdrKO2mUN7zp280IrlgGUildMRCoFGwbZ46TlpxROW6jSjDrjTgw5IH7YgHwiiMxOGU4AU0261480AweNcxI2hV+/4bEx/ydpl0dOd6NSlsdL7C55mkCBV7vj9g4J7pDJf2gNZwCBHqH2ghRErTCJ5MVyEP7qbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Nl8IRR7E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71cb97937so23845855ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708104547; x=1708709347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jToflkmCwyQs7UQxuBMga09E3BgvdBR868wOQKG7TEk=;
        b=Nl8IRR7EOuTBQ6HsXWnixUabUanLLNRj8sX7se5fdmp9Cszr5P0cytlWUp6Jx+kZeC
         a1cjDT9mM7gALdgSH0M9zX5qsSqwFoJoAHtncg6/uAdMyOCDv0LkBySfntETz+tfq8kH
         6DwEZ4OwTAR+ldU5zDA8+PMXliE66HAEAmXA4PBtk25EZW/li5sYtH6YuI4Iu4TOadk7
         O70gM47OsI3yrAbsLBCJ8ySUAKBnyEg5GTewKQ80XZQDqKGtSGxQl2IdGGwJIqbyBjXE
         mgO4Zaj0QvWBrmDL8dD3H9+sv/aQQcyLq6rvobBVjeVOtIDLi4KnbBASRLgdHcf4vuew
         NfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104547; x=1708709347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jToflkmCwyQs7UQxuBMga09E3BgvdBR868wOQKG7TEk=;
        b=QI+v+gh9Kpd1XGTJd3kE/XkBLA3tzNGFGvHXrD555Agrnp4kMBvtL9CwZVgHMkM8zf
         IZ8tyyW/WNsDcHM6EXT7QfBuYkB8faDcp8dXFWSuphOny1ZMhxCJwCLYEXk68a7GUIuw
         Zv3WQP1tpxzZNe4TwgqevaMFNJPvfV6VX7e0++tulL3JYBm80KOwzi5R2B7G0GRq7OJb
         CwiWEZAq8szH79I5C5D3bqU3f6J6GLiP6QirbMcL80yhPrI5tb5F7JcIBjbd0WFZr1lJ
         Cv/n1QoO+hDYpK1wIh+lGul98QYd4hcKwFxbbSaeo89w1ZdKW3sNtfF6jyoDsH9/JJX3
         hK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8giYX3xBdG6d27S+ZdasJlnNKUg5d8ZMspEoLN3pRw1XJCIMbRuySo3vqd4a/Q+ReL4ofD6WNWbWfAXgWg0wTmfvRv2mp3xlF8nwt
X-Gm-Message-State: AOJu0Yy32jH+o9wEd4At8/OzQRsNzYqnBs5milKpB5GglTkHaoei0NQd
	nn5apCsSnyCfkIT3KztB4uHsVSd+OKDA9mvBvZyYoTTAvG+UVuGWMvlCIschHSw=
X-Google-Smtp-Source: AGHT+IESxNHybvNFa8HrTTID6zBA++mulMPcSfUuMOWbHKtQaqgemGU1QFrFWQQDiUduWiByQnFFTw==
X-Received: by 2002:a17:903:32c3:b0:1d8:f071:5067 with SMTP id i3-20020a17090332c300b001d8f0715067mr6779809plr.35.1708104547360;
        Fri, 16 Feb 2024 09:29:07 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902dccc00b001dbb459b357sm116271pll.233.2024.02.16.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:29:06 -0800 (PST)
Date: Fri, 16 Feb 2024 09:29:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <20240216092905.4e2d3c7c@hermes.local>
In-Reply-To: <20240216094154.3263843-1-leitao@debian.org>
References: <20240216094154.3263843-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 01:41:52 -0800
Breno Leitao <leitao@debian.org> wrote:

> +static bool netdev_uses_bql(const struct net_device *dev)
> +{
> +	if (dev->features & NETIF_F_LLTX ||
> +	    dev->priv_flags & IFF_NO_QUEUE)
> +		return false;
> +
> +	return IS_ENABLED(CONFIG_BQL);
> +}

Various compilers will warn about missing parens in that expression.
It is valid but mixing & and || can be bug trap.

	if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_NO_QUEUE))
		return false;

Not all drivers will be using bql, it requires driver to have that code.
So really it means driver could be using BQL.
Not sure if there is a way to find out if driver has the required BQL bits.

