Return-Path: <linux-kernel+bounces-37047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F262F83AA99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311AF1C27A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8E77657;
	Wed, 24 Jan 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FWtYSOot"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187977642
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101481; cv=none; b=HjgFOLa+dOYGiI5O+a5oQOVkM7+qJoaaZ3Detp6wgeUC5AZofpVF3Z4dIbHCZl9P3TIag6a/LsBVYPf9zGiuznYafZeWbp/viCfmiegYQgUGxymqMZHLZEdGmkCg5VuxtARLBrlubPEy4aZu0dfc/QDvJCwTSpWW6hEMMtKitWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101481; c=relaxed/simple;
	bh=B8cA1ZmYL6Ndv77osRknh0AO8zS0RBiPjzqoqdqEtmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPKOzFu7zm99vWC0ojJq9mV6V/MF3qspiDS3X7h8MlXN/qY0zKc5F6w4WNUfQv+cIMxE09vObUzJRy75AgcYkGTLE7PffqO+Yk+uy4lxB7GqiFoZlmKj19Hjb6ZIhM+M6tNErt7m24ZjrnA6hDH/kGZn3tQI9lSUCxwWoCal+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FWtYSOot; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so6168242a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706101478; x=1706706278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B8cA1ZmYL6Ndv77osRknh0AO8zS0RBiPjzqoqdqEtmI=;
        b=FWtYSOotdyfGaMOcvwjlQ6E7Nsuz5KtKZQTmTV1laYkjraIR+ta8PuGwD4TnarRBdU
         eT8vzw/PY2+DlNudy4xl9OrE9fsNNwKNetywUse0h0thMW2UhvUlOjr7TgGiqa27QRWj
         NeqHKQ1m2As1tAeHLhKTAazJgRD42xI5lFIdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706101478; x=1706706278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8cA1ZmYL6Ndv77osRknh0AO8zS0RBiPjzqoqdqEtmI=;
        b=fAfxPCe4HA7uzcQMIF40SlS4NGhSsuCDU4Jj0Vnj5EWZDEinrM9E68D26Gak7JZhJ7
         t7QhzLKzqx/ittCk4jidphETia9TvMxFcnW8MSOnaNcFQf0NIn9okqUlX5rcYTWGKR2z
         aXDpKmDKpMMd/8fkEX1ImNigp7Pry9h2ERBfDVS9b+AGOqYmeTWalPthiA3wHdR0cGpV
         qbsaH7UccvuCdxMYTfJ5hnbFpVIe56CurRCVDm8OhxXN3OBSw8lGA+Jq4KjD8on51A3S
         ZhB7He8fjEjltgU+t89bKK9uUd6tjj59Jt+geLteK1gTkXPkk3Zp9a+OdjoazRU6C79K
         7u+A==
X-Gm-Message-State: AOJu0YwMl0doIwiipXM18xngLCGgQRJGklc2zO/eXDBLGijc0NjyhYy8
	3AKRsuD/++jRrkE1EGBbpz0CKuNAV+AgqQH/vWDRJT1EHNMW0+6aJYWg7Dc+WVLjHVgpD1khA6L
	zzAJHYyxX2QGsRKgYEvdGey19FlCQ7/M7VValVQ==
X-Google-Smtp-Source: AGHT+IEy9B2Lm4AXkR4V27MbGmnG2tBa71pYnFnuANaeGsI16VlKXncM9PMqvReHP7q0zCWmA/NahulZkCVWrcCihCo=
X-Received: by 2002:a17:906:ae4a:b0:a31:1178:8e6d with SMTP id
 lf10-20020a170906ae4a00b00a3111788e6dmr608924ejb.70.1706101477686; Wed, 24
 Jan 2024 05:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124113042.44300-1-jefflexu@linux.alibaba.com>
 <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com> <96abca7f-8bd1-44e8-98be-c60d6d676ec6@linux.alibaba.com>
In-Reply-To: <96abca7f-8bd1-44e8-98be-c60d6d676ec6@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Jan 2024 14:04:26 +0100
Message-ID: <CAJfpegsk-zjpOKhE7y7zmUd1sZr-Sn3jbKPjDLCSU7KmLbjr5Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: add support for explicit export disabling
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 13:50, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> OK I will rename it to fuse_no_export_operations.
>
> By the way do I need to bump and update the minor version of FUSE protocol?

It's not strictly necessary since the feature is negotiated with the
FUSE_NO_EXPORT_SUPPORT flag.

Despite that we do usually bump the minor version once per kernel
release if there were any changes to the API.

Thanks,
Miklos

