Return-Path: <linux-kernel+bounces-66076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5985564E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F1E1F22E60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4113B78C;
	Wed, 14 Feb 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VAWpfSDR"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C762250F6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950770; cv=none; b=D/51+PdQbSdgzwfBx1NtYjKrYSwv+RRH+WSw2zTTEv7q7UOyqMMauLvqwvRqEG4s6Nv9tL3yB1raGxf+bimgRY30r07zcEyBYqGFo/NvoHg2J5QuVP01T8vVKSIv5AZ3+DwZxQb6pLxKyCe0yWkqbBWCluvzxP7UGXZv9v2SxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950770; c=relaxed/simple;
	bh=8bT3amGiS3fLKoyxXO7JZcJjrrEaDQwfviHZsFxAkb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwZCKaBs0avfgnBRWaB0vKteKRKEYumnmM/mao+11jsrxcs747Lt7HecYO2wCET3MEMmyGZbVQmqEVR9KlKoK3D30HgBbq1wKWphkgNwKYZFVXkFjFQFkH5HPPijJIICBSX9x1S8C2L0/9kjbenD5hHiiZ89c4kJcc1DoR5G5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VAWpfSDR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so293553a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707950765; x=1708555565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZP+BxUxePmCLWZ8ZfOeiaW4IXKd0KvZFg6WZ8fL0so=;
        b=VAWpfSDRfN4q7rvZU3wN2Mv4O4s0TQzoEaJsIKv1i3is3KnIdo4MxOLIfYqGouaZ9n
         wMTGPZ/vLpqnrpbuLemu3bcevOmWWF4hyIC6deoCOTQvvxuS8hfjrlFjeAneydjX8Z7P
         /RZaa+rzx5SlRizCRRllXzsFjEdMnhQjRKKGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950765; x=1708555565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZP+BxUxePmCLWZ8ZfOeiaW4IXKd0KvZFg6WZ8fL0so=;
        b=eha+dBwPbrjQmCdoGPJ0QZZzEuQte7/xxdHSAo7M+cShLc79WgZV+rCSxuyUrNYsQo
         t5WCdwSMh94uCF8sFIp0/ZtQBiDZ/3XdBINmJ79q4HnMlix63ikCFVI0BBcSt80uzbJg
         qUJEhqm79/oC/C3N2nMt5cTfAV9qEbyyRYxsRHXnN3d5O0ePWZ1WcmoZ/Ql0BQbh6S+U
         fqloubafVREq0mqN8mS7RGb+BQOI9Mh/+A2ToZImuByxliseohYeGoXpns5fgmaq6JOm
         OjAM5bhJ4Na6V0G0yo1FMEmpPTm9twELj7XPRmVCSXMM0nIKHRyzPmv2uqBhdSH7nMvP
         GCrA==
X-Forwarded-Encrypted: i=1; AJvYcCUDg9U26u+UJLSTYD6e0EW6cQQpDEEb9xUtR9sa5InQxcKXwty92exkyP47/efH3+fkE5c3Vf9ArneG7xz42IX3iH9Zfn4RjEtgv/43
X-Gm-Message-State: AOJu0Ywgd3qPQQHX+5f2luW/lo/rTpfc2oOTPA6+HVDdplDB09kx2xwk
	A3ztimjFQW83if6nlSHq9RQJENstlZzWnMJSo3q20SPO3K5Cpihd6jKSt0frHw==
X-Google-Smtp-Source: AGHT+IEwKqfIdExn5GXKXrbxOA/cEMTv4gqm1KamsNHD/d7odYizVrN8PnY95/ALxTdDxMyMcTnEUg==
X-Received: by 2002:a05:6a20:c702:b0:19e:b9a8:bc7a with SMTP id hi2-20020a056a20c70200b0019eb9a8bc7amr256992pzb.60.1707950764884;
        Wed, 14 Feb 2024 14:46:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUGkaK+uG2HYDYpAKvRgJiRcIWuMgkS/9TgsR66J3nWtHqH9sZHwNHgaLV+Aw5I+5Yho+5LbjqF8WB7N2Ph3FGaG04qfiX5QSW7kmtzs5fyp0+pnVsK2+EfOXM7A8h9CUEhYuH8ztUU6gvjoHDgG8ZFkOG4w4mxDvvkYX1zzkjjzbu2uil2DaCQkewklC5noE8NtF2a36TymKP6b36GAD19eg25KxsFC0voQhzwQqjoDGrzhYs5v334PjeVpU1+m9rcgmsVBQ8FDh+pxGBjGUUKCGQk2vpZjj9j1PfF/7wJziaIGF3PdcMWCbQXb9pzJ5XoIAH058/e8a9vWQu4MX9n9FdQokJvA7jfyf2ZI1mzQz8xM5JryGztpVJddSUITqxQjIWsZHEti2kDugz+Prl2/Awio4EURa09W9UG3QIzXZ+M48m/Dp7Pi9RlMRXQO4YvvyK+ZGSSYER2RPjfYSjPGeTewRJItDlUIyHhoQp19SCBj2U1/IN3KCSE37kzpZ5VrE3mAnTjD0Y/J72QxkuvPBskpwFXlC6w0RWQBGeeYUeZFukAt3A253vVftrPFmwd1ozzR+ElMzLA9NdZkSYEhGJ8Pc=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j20-20020a056a00175400b006e04553a4c5sm9894509pfc.52.2024.02.14.14.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:46:04 -0800 (PST)
Date: Wed, 14 Feb 2024 14:46:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, tech-board-discuss@lists.linux.dev,
	workflows@vger.kernel.org
Subject: Re: [PATCH] Documentation: update mailing list addresses
Message-ID: <202402141445.F9E9116E9@keescook>
References: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>

On Wed, Feb 14, 2024 at 03:09:53PM -0500, Konstantin Ryabitsev wrote:
> The mailman2 server running on lists.linuxfoundation.org will be shut
> down in very imminent future. Update all instances of obsolete list
> addresses throughout the tree with their new destinations.
> 
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Thanks for this! I had just updated the TAB's internal docs for the list
changes too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

