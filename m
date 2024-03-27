Return-Path: <linux-kernel+bounces-122110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F488F1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FB21C26BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4B153839;
	Wed, 27 Mar 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M2OjER05"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9B152DF7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579287; cv=none; b=JtknPvw6Ou5d0RyRrm+4G4MwSdwbvoNzo6Tjor9muAFy8C7Hr1p0ji0eb6FyEabkRbORgFG0Ru6BxfmSzsXQWd4Uig6qbkki/2SWtN78MbW9e+qzJb90wHvAyzX7ELLiAUVbR+wHZHe9I51UY+M1HHnKb+B3jD3f/wePCyh+Rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579287; c=relaxed/simple;
	bh=5ThBrSQJKBnrNYoKklFaEy0vcISKtZg0KHuySC8oZ0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjVt1Co/fbq9ZRkerfPj2/oI1n1efJFkfqE5QaSHpp8u0Seq23C7C7SUuSQlOYcWLesh9tCTPVUoNBXIva7l+WF/2lhtdY7Bbs3hCupSiFofWglBVdj67CqbL7yydK+mVUXhnlEjK3xmtMPsfAw8rbvbDY2HAxF0GZz6QXpIj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M2OjER05; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-476fb301777so113807137.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711579284; x=1712184084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ThBrSQJKBnrNYoKklFaEy0vcISKtZg0KHuySC8oZ0c=;
        b=M2OjER05vDZL5JKglAA8Zmvu7orL/ZMDJoTehMHHNCNbFGVpVUx/eLED8nTSz6PVHH
         MUitC4HWN6uKpJg6MEcNdm60t111nkL6yLeWYW4M1ZSq/Bt++XvXgG32cP9zPzExG3IP
         z3m1D3G2ELxtzNr76ibZc0cw6okpRiskwVGzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711579284; x=1712184084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ThBrSQJKBnrNYoKklFaEy0vcISKtZg0KHuySC8oZ0c=;
        b=ncQyJiyR3YaYxBJPuuer2jVaZBjeLnkTGeFIA67g0N4eEnjaEvygZeuhtDSuErGuQE
         tenMkDwjx4nVwCjxTwNQlF18ZflsBNs8Tjdwu+Tum2cHbJ/oSVMZnXkbTqbvScooMez1
         KVxcDPGPQ7V0QMp1YGXCw8Zb/KviLSFsQP6aDXhA5zgj9OMAE8gs1h/dXZd3EbKaoRKe
         R9DIJ8hNkbKs9pFteTO4TpgRTrNvre0ELR0j/jH4SPceOnUtfbbA+S8BDs3MUk71+YvO
         ZxkVZuAm2zZYlgVSns0/GRUqL6L3sU02JG1cgLsEz+JpsBR1JYsL3Hu5ed/9cgSFXRci
         Uzcw==
X-Forwarded-Encrypted: i=1; AJvYcCXI/MbWoAjN+H7Lap2qQM1FPm6iLT8vABE6b3QNk8hpTihYaY4S2zQ0PhXKBqk7TrAg3p9jS2yGuF15C1qBVcqZQRQUcRfrAVX8Xobu
X-Gm-Message-State: AOJu0YzjwrhT8DMsT9Yxnftj2dtvotFwxdTHZk1EW5br7O3DzSLQEeKY
	R/tAuPGjPRywB9BcyZjduZS6qP1LZ8zsQBOBF24ZGzv0DKZIgs9v/Me0hZOF2QsISElKLBuqFgH
	rJvDcY4hdNnGoluezAMJxz5sucXat21Mn1BpX
X-Google-Smtp-Source: AGHT+IHNjjYQGq2X8tle/LZvZCaDTr/ZB2zjC3mCynbSiO5UyriTzUT7hxsMKWXYIiTf3AnTUZQ8LoJQK77rfY27NGw=
X-Received: by 2002:a67:f242:0:b0:478:2f66:f641 with SMTP id
 y2-20020a67f242000000b004782f66f641mr1446935vsm.34.1711579284703; Wed, 27 Mar
 2024 15:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
 <20240325-public-ucsi-h-v2-2-a6d716968bb1@chromium.org> <ZgQBXFzuZLJcmH4h@kuha.fi.intel.com>
In-Reply-To: <ZgQBXFzuZLJcmH4h@kuha.fi.intel.com>
From: Pavan Holla <pholla@chromium.org>
Date: Wed, 27 Mar 2024 15:40:48 -0700
Message-ID: <CAB2FV=7OnNt_-fTzUV1Rrg342jPuh5haUmy=EogVNwyGWyAy0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Import interface for UCSI transport
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:22=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> I'm pretty sure somebody already told you to merge this into 1/3, so
> why haven't you done that?

v2 was uploaded a few minutes after v1, and only added a few
maintainers of drivers/platform/chrome to the email chain. I was asked
to merge commits after uploading the last version (v2). In hindsight,
I could have waited for a review on v1, or added new email recipients
in a reply to v1.

I am working on some comments from an internal review for commit 3/3,
after which I will upload v3.

Thanks,
Pavan

