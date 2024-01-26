Return-Path: <linux-kernel+bounces-39633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A031B83D3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26536B24780
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57FBE4C;
	Fri, 26 Jan 2024 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UG/Cfc5m"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E8C8CE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706245831; cv=none; b=bWQNi705dBrYxhgDfObuAhHyoKlYFxaAL26hsZapFlA+tvzZPpyuQP6qaPlt2nHUl2G2OAzJMTiwqJhuB6qOl6CMknGG2xi3EsbklDii67AMSi/ZlZ65VESm2BVQcCWhlz17RQYtUe4oSwkjKMluTRrTuEHNJsxZa+IFSiJAM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706245831; c=relaxed/simple;
	bh=PWNKgB2N3DB+66pFOK/0j9b8QzacRkS6VBRUK4oWycI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8qKoJ16hKCjf1Iho58CRFtRE8RTA5qjyavDZT6uIjq1hxLaqNE5kNtZ4BBFQoc5ICARvTmhAF19wYOHcnDigauSIzox0weZOtw5HwRotzGWA0qinaOIzk38Qo4MXJvkEbWKHRIiw6llZPbfKPn5VxhbtSku5EJ0+fy5x3kYx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UG/Cfc5m; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso27523276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706245829; x=1706850629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWNKgB2N3DB+66pFOK/0j9b8QzacRkS6VBRUK4oWycI=;
        b=UG/Cfc5mLXF0aViqRa7PohZf/KwLbkMa7Co9vnuotevp79jPXGH2RhI9ixwGwAjg2h
         CMuGYCt3bNgUqxTHhHrkI611v+S43K5IS737bUrgk1UNg072lJaX1M5s6ucXUsuPM5nv
         S56lxusBdZs/EG9CJvleR2O6gwdZatnCg4Xw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706245829; x=1706850629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWNKgB2N3DB+66pFOK/0j9b8QzacRkS6VBRUK4oWycI=;
        b=fhjkCW5+lk1rzhCv/DyjICPxdaKPqEfdqe3YBqQr7gTS82B6eOfKCboGgrp9wdn+6q
         jArnJeZc1hCp4n6tpKDEd31d3M33z9LFus1Uw0Ith0I7MnbIQ8mVhmN7g+q9od1bJ9/1
         RR6Cc5128ri35KgPx2upnxlL8rx8E2kM36z3xhDmqVqyPEAZJY446sqSoMhsgWKDkYKW
         LwJ7pfdjaDYR9gVYOFXlqxdeZHGhuPvppJurg69Kke7ltIp9vL5rHeczKpQSIMGw/ETN
         ZOQlf/19xyhJqDmIHyFaXkzkIGMT7xw1FwPcQ+8zFJ3krKTJYn3PncPu3tZMLLBkdBqp
         yVrg==
X-Gm-Message-State: AOJu0YxynN74bxjVd1URP1zwjvx9/932i97TZ7jHnqRw4oEKEAJEmJ7q
	Lv/rHoitvKakO29FBDdODBCNUmBtgphB94n/0QZLoAYdmpO8oHbifkHdhIWYoZYfnlypIk3i6Rj
	1PxvrKpwii31p7ZNNQILB55+/ETZvbqDtmoos
X-Google-Smtp-Source: AGHT+IH0BWVFfOQVB4B3XDw2qmadyX2DJH67AAmoNam42TDVfLbbO4flPb26opFK9plDdXcih/QQcRuXkYkRfRu/MWY=
X-Received: by 2002:a25:ed06:0:b0:dc6:9ea:3d65 with SMTP id
 k6-20020a25ed06000000b00dc609ea3d65mr752301ybh.84.1706245828072; Thu, 25 Jan
 2024 21:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b5648aa-f83d-d8f7-b0fd-39c859f32f33@linux.intel.com> <20240105135105.1921947-1-zack.rusin@broadcom.com>
In-Reply-To: <20240105135105.1921947-1-zack.rusin@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 26 Jan 2024 00:10:16 -0500
Message-ID: <CABQX2QMg4L3oQe4pU4saBgopXw7CKyGrQa_LKE0xtSwyEKacnw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/ttm: Make sure the mapped tt pages are decrypted
 when needed
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 8:51=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> Some drivers require the mapped tt pages to be decrypted. In an ideal
> world this would have been handled by the dma layer, but the TTM page
> fault handling would have to be rewritten to able to do that.
>
> A side-effect of the TTM page fault handling is using a dma allocation
> per order (via ttm_pool_alloc_page) which makes it impossible to just
> trivially use dma_mmap_attrs. As a result ttm has to be very careful
> about trying to make its pgprot for the mapped tt pages match what
> the dma layer thinks it is. At the ttm layer it's possible to
> deduce the requirement to have tt pages decrypted by checking
> whether coherent dma allocations have been requested and the system
> is running with confidential computing technologies.
>
> This approach isn't ideal but keeping TTM matching DMAs expectations
> for the page properties is in general fragile, unfortunately proper
> fix would require a rewrite of TTM's page fault handling.
>
> Fixes vmwgfx with SEV enabled.
>
> v2: Explicitly include cc_platform.h
> v3: Use CC_ATTR_GUEST_MEM_ENCRYPT instead of CC_ATTR_MEM_ENCRYPT to
> limit the scope to guests and log when memory decryption is enabled.

Hi, Christian.

Gentle ping on that one. This is probably the cleanest we can get this
code. Can we land this or is there anything else you'd like to see?

z

