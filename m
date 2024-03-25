Return-Path: <linux-kernel+bounces-116673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A488A181
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F325E2C739C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0313792D;
	Mon, 25 Mar 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bAuH2K6s"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402D13B296
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353198; cv=none; b=CKyh2fnV1PmRZmrbgviQ2kAhWssnyNy1hVMEojop5PtvbPPxvL78BFfRRQixv6o0qG61ojbsRchzDUgDm8aSAkhFuTA3IC8xfEj4uCPNpUbv6+Dh17GOQZ8Cr3jog7JGrS1TtVQlqM7QkntxlNZ/l6I9+EYVT7TBko3WCWs9Mco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353198; c=relaxed/simple;
	bh=2KgIcp2UQ8SEteLfGQF+L2YAktZ4DsY+zNGZuttyUiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSy7pzoVJW8AR+3G7iTWeYgOImT71bDmhhEzfbxUHGDrfNs9N1UAAMTNGb4ZgI3zeuNp43584b7YlUEseWI//vwmB5tOT5bLBULamVyhOYy62efUUIwrzph/GLdssxgSfue6nbkV3p1wXmZ/ZFqcOzUBoKxn31MTaZIjpcB26Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bAuH2K6s; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so2076535241.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711353195; x=1711957995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KgIcp2UQ8SEteLfGQF+L2YAktZ4DsY+zNGZuttyUiQ=;
        b=bAuH2K6s9N50+nNomhrtxYRJSDMiaK6doOW66uelky01iQLg8+zHelcW0KcAXECvfc
         Je/0uW54O8fVOx1jj+r+8fe4A3zhu74Upd2LJ/bHwN9h6sgPkcr8UKSryTr3iMQYq60N
         nIYst+8b8aktxLVXsU8dG9l2IWYPuw64zyEdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711353195; x=1711957995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KgIcp2UQ8SEteLfGQF+L2YAktZ4DsY+zNGZuttyUiQ=;
        b=Bl6GSF2UrMwzioBxR5+4iHHZsKKCKWnFdldxyqRWbGyN3UhUXEBdH0OYU9YUFMNFiS
         LOkpNZna8jFw4yWSVzdtt1H7gYesO1YJFnD3tCtbiVlbm2yBgCEqGWwGjEe9L+S951kK
         lQvvfWdMF8J2sgjYxynZ9/DrsVFtCMHFZFto5cft1z84De/r7576X4dmwx+KgpgyjVrS
         FcVMUkK99h1BCMBnLxwNAiMcXuryNB/1zCl6Vs6wmQoYVI23Z0k5T66rZ6yzSu0GacTH
         NQmP4nS6i8SST6w11uayKH8MmRx5e7TbqxTGglyQunTyvgCXzG6Zr7GYRS4WVjanRFIC
         SW/A==
X-Forwarded-Encrypted: i=1; AJvYcCU6LVI4bUd1un70HPog9VmoS+ZgMl33X0Cthtm8m8EVrbyH7gDE7nHX8evvk2LAWjGRkFguqLaKhCi8jaOZWVuX9J8es9jCAt5imRaU
X-Gm-Message-State: AOJu0YzvJFd3GvBGSjbuxwJe6y1v3uQw8fXFZKP2c19hEafk+DSzCqeq
	9BrvpUWA9zKGkL5nAJX7M5zLNzZ6ROgm8hUdqny0Bj46H9mrDdZAonsUmPujYeLNW9bXTsppk6Q
	=
X-Google-Smtp-Source: AGHT+IGnkwuM40KoaEUch+Y4kEJjM785UoNrRR0fHyIF7LJlmlga9OTDywlpIPU1YME7MvJT8xZOxA==
X-Received: by 2002:a67:ba14:0:b0:472:d4df:a69a with SMTP id l20-20020a67ba14000000b00472d4dfa69amr3855011vsn.9.1711353195579;
        Mon, 25 Mar 2024 00:53:15 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id v3-20020a056102226300b0046ed66a9051sm884853vsd.17.2024.03.25.00.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 00:53:14 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d44beade3cso1417129e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVlpHznJyVmY0NSVfaQ1+GG/54kcXoJ1HYbySUUcp0K7zV2LXc1x6MsAHE+X1WNVENDdHbrX4Qo2cHs2dMmQqd+H3BX+tPcdwcW1gI
X-Received: by 2002:a05:6122:468d:b0:4c0:1918:27de with SMTP id
 di13-20020a056122468d00b004c0191827demr3569976vkb.16.1711353194258; Mon, 25
 Mar 2024 00:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <20240323-resend-hwtimestamp-v10-3-b08e590d97c7@chromium.org> <2722561.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2722561.mvXUDI8C0e@natalenko.name>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 08:52:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCsnOdTaW0Eg68+-niPXwPhYc3Br6cWoGiHytZrFOGmcZA@mail.gmail.com>
Message-ID: <CANiDSCsnOdTaW0Eg68+-niPXwPhYc3Br6cWoGiHytZrFOGmcZA@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Oleksandr

On Sat, 23 Mar 2024 at 13:16, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:

>
> How do I check whether C920 (046d:082d) is affected too? I have got one, I can run tests on it as long as those will not blow the webcam up.
>
> Thanks.
>

First of all you need to enable the hwtimestamps in the driver. You
could do that with

```
rmmod uvcvideo; modprobe uvcvideo hwtimestamps=1
```

Then capture some frames with yavta
```
yavta -c /dev/video0
```

After around 5 seconds all the frames should have a stable fps, the
fps is not stable then your camera is affected with this bug.


Thanks!

