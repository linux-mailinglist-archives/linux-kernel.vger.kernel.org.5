Return-Path: <linux-kernel+bounces-151887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0908AB548
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2E61F21895
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC8139CE8;
	Fri, 19 Apr 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIFgQKGM"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973522071;
	Fri, 19 Apr 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552770; cv=none; b=hBcfy645LfwN/iHK7+eW38rzDspRY3TL83YMK3uDhnz2onzdSlcewk5SwR72qr8tah8FbGrQIaaOQP0z1QMVVq4kmUM+tHj8RcqKP4jqWn9Br6z3uMERjBGofPSZKRZu5Ps/IUvSGR6hoD4b44mVzX9DQhOhL0IHhD6jI1HReLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552770; c=relaxed/simple;
	bh=U09zZHjB+LeME5+ai5JqJLnKOWOODtaYa79Abej4COY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=c6dbNMso0+7d5PXSc2jz9IlebFpBTp6sKSz7THYF2IzvjcWkMRHJZ311Cr43vuoMeqgEsbXBNhUyTC7ZZZmtsJ597daE++HGTx3fCRM52WV4fnJzbx0sBj+4VuS8WxtJH5lCeolZ9QitPiNt93TG16aWGHW/DPj1dW+OXkTbpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIFgQKGM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed112c64beso2161481b3a.1;
        Fri, 19 Apr 2024 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713552768; x=1714157568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U09zZHjB+LeME5+ai5JqJLnKOWOODtaYa79Abej4COY=;
        b=GIFgQKGM7UZvAJxWDW5H0HV11jZ7taoOFX6bXJfUEojBq1SdIGyQcKs/CJRQgTNHow
         gDicpbF2Qx3gBUfFq0z0+zVzA/hDoGmnMQTCbN0+vwByDXW6QVae6uA0z5jor3H6gh0I
         yqgE6Nv1vbgwjR3J1M4K7B2gO6DWCV1en3DbbVfjG1YEVwAhiEHtZGJju8vWS+eGm65T
         F5E88q46i2wena1Rh+4qBrawY+VQcFkTrmt43SakHYds1y4/Wcu251WyMzxVh3PncYx/
         jCBEidmBC9ujpjjZIUEMkwYLchmxS9KEuaECPVNseJVodrTcil9VPSw/0XBI0YFHz+q+
         dnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552768; x=1714157568;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U09zZHjB+LeME5+ai5JqJLnKOWOODtaYa79Abej4COY=;
        b=BZNAjGfj/bYpFH8OJgV0KcgXCVc5lJ9mK6ZRGzB8S62LToNcj8rmHY4MRIH2fBIS1K
         7kDPQ3zupazmVrDRkMqGV3D2myAzAfxpgkK/olXtDetV+y5giFrSzwp1Z45Oil/5C3ec
         ea7HW5Lw/+zSLqv43qFJ4mRc5nrfsaZiLAICjg23u4R3xnLumVM+okbqpp+GpHEw4u6R
         z4BBvPxOYYwQbRdnjDhPD1P8xyckjURitVei9gEMrUcQqSCh80kqVkM6P9xRSP3fK1XL
         7YhbQfx2p/pcukxSt2wzzbuaVpE/wBcz70JFwL7RtViBg1ihePuGX9VVx1MjWeDB4o93
         Aj8A==
X-Forwarded-Encrypted: i=1; AJvYcCUT8pfGij4rdtD1lLjL3fO4Doe/z4hIY2I7UErI5N9xBABVYw9ZGty5bkUEbN0WoQDsbgJ8dqZzmBvjKbaOOyZUUKEYIeU5US95WFk4FfWYc/QI50IFYetbWmhkGhRxeUoItT4YlGyO81A=
X-Gm-Message-State: AOJu0Yy0oowaCdJ5ZiWT1qSrwWMRlW3yUKpbsDst1t8CoH5Zh3IPBoP5
	dJy4QVkLcGIO7Pb1Kj4v4QXJMUtnTnMOGsl9u0rWZQe3hFfy4+8u
X-Google-Smtp-Source: AGHT+IHEQHOBvKuseE8etys53e1nv+ZkHGMM/0X950aYj5fjviZRpom/z8ITcLkYd++IcqbesMEaPw==
X-Received: by 2002:a05:6a00:1794:b0:6ee:1b6e:662a with SMTP id s20-20020a056a00179400b006ee1b6e662amr4300891pfg.32.1713552767935;
        Fri, 19 Apr 2024 11:52:47 -0700 (PDT)
Received: from [127.0.0.1] ([106.194.121.201])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000cd300b006f0af5bfda5sm2272744pfv.102.2024.04.19.11.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 11:52:47 -0700 (PDT)
Date: Sat, 20 Apr 2024 00:22:41 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: daniel.thompson@linaro.org
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
	javier.carrasco.cruz@gmail.com, jingoohan1@gmail.com,
	julia.lawall@inria.fr, lee@kernel.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shresthprasad7@gmail.com,
	skhan@linuxfoundation.org
Message-ID: <819a56c3-bbaf-4d5e-87de-78c1312c56d1@gmail.com>
In-Reply-To: <20240419111613.GA12884@aspen.lan>
Subject: Re: [PATCH][next] drivers: video: Simplify device_node cleanup
 using __free
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <819a56c3-bbaf-4d5e-87de-78c1312c56d1@gmail.com>


> Please fix the subject line to be "backlight: <driver>: ...". I came
> very close to deleting this patch without reading it ;-) .

Really sorry about that, I'll fix it.

> Do we need to get dev->of_node at all? The device, which we are
> borrowing, already owns a reference to the node so I don't see
> any point in this function taking an extra one.
>
> So why not simply make this:
>
> =C2=A0=C2=A0=C2=A0 struct device_node *np =3D dev->of_node;

Looking at it again, I'm not sure why the call to `of_node_put` is there in=
 the first place. I think removing it will be fine.

I'll fix both of these issues and send a patch v2.

Regards,
Shresth

