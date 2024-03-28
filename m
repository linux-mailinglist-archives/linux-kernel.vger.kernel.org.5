Return-Path: <linux-kernel+bounces-123030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EF89013C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC671C2AF85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6012EBC4;
	Thu, 28 Mar 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7cc6Y26"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05512DDA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634883; cv=none; b=lQ8Sbf5JmLZmS5iKzjcIm/LlMBxyowy3lTc4+2QONBiEldAVhPiUr8brL/zLBfMBm61fRCr92Km26Khj2T2wVrz59Yqy6v+iZVd8CM3yPkD1Tcrwfbtn0eUnVlvcs8krmW0rGZaGjEY/ANV9YB0ZCJlVKbXPkl8KcxltpFWhSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634883; c=relaxed/simple;
	bh=BDHeiy5x4l219ebTle1HBlwon+DJR86izkGnTQaTTqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMY///2XamHEttWFWEeB/f8reZj9xDADTb3YlUPcsv4NUZcts8Pc5ru7Exq9cgNsSmHWGxGSXl6AF5ilk2ys2bG9Wawtam3Zs56Jf3PaDz27pVkGfqDtFENmvfcTUklgSabsv8uPcdOhvY2SYih9QDm5tOHEZ47iSUdOuEKCVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7cc6Y26; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29de4c33441so832779a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711634881; x=1712239681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDHeiy5x4l219ebTle1HBlwon+DJR86izkGnTQaTTqY=;
        b=F7cc6Y26XhUZHMqOg+WNu4+nmWon32jAMGJw3HOx2nOESqVrj+Ifxi64Doy0xd6NLd
         r1xNJSgVi73RH7tS+ezMgTVH0MEHJFP7FBTB3EGXRvCtd0cTh2ARv1qhzwQq26VBgxMe
         ORk46klvNvBi+1oYzmiAryJFouwaiynvDiTj4BB0IVz4FxKeFxSl5KzC0ldKU8omHtQr
         yEFP0whb/Pv6qKYTTaVNz7OcDf2YiFL6OnRReBIR6nddpVzuNUKjjazrRTywiPo110O/
         TNsDjBli9uC0aQcIv+5PIpVCXgxxZtlaKyrv95MlcCj8QkGXBG/nW4b27o5CppF+54Hy
         SeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634881; x=1712239681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDHeiy5x4l219ebTle1HBlwon+DJR86izkGnTQaTTqY=;
        b=dAE75rNauSasV3xLPC16WYC/ORe6Ju60Uo8S0Z2hbcDUlcUYoK/+mLWL1Qlb31LHXd
         19zAR7mkdqRZJKiNJrWalOXcGK9thjdqvFTfh0lokRkVsinFdab2akcnYbqpq1QDqdUH
         rKynQtyxmGbE3vvIHuLFCHDAr2BfmGRM4QijmEJQbqlVPFJoUdcBpjpURymzyManVuln
         xbOcIyZP4ecso8pFMGQjsLDna97pvI6UIkGJVtOoJpLjOsNnhc/OfLJ1tm2zDYRG5O1/
         vnv7t8qxa0gHfssDmyjA/aEo86CxtJiPmZGuzHOdmX1GY7IyYe247e/Z3q5FFnGFcFjE
         gKLA==
X-Forwarded-Encrypted: i=1; AJvYcCUgmGZHeVcbBTWIW4kNNyvpRLXTRCo8G/MDXagh3NCfxb/bdp9l1rPZm4i2URQCMuwbWONB8j10fOnMnzQL8GIFvckmXn1YirkRr+hW
X-Gm-Message-State: AOJu0YwxMYSM7HVy2QQUpMiAPk1wGlWzc0ua235RRAIjBC9pmRypR4mW
	FiIWQo8EuQNGYwi97BbvQdDYkJFfqt0c3s0XMIb5G1OA6cG9JJyFeftojyqzobgrz/EE9Yd3FM1
	xg4xwzZ5jA70oAW1Uu1WaexBJ2l4=
X-Google-Smtp-Source: AGHT+IFIWrhKeX7ce8KjxR2/tVtAq3kXc8zJr8TS91l7PXkMz9P3mtiS4Y6NCckBLcO3qKsiyOW+wSty0gx2JmJTJMA=
X-Received: by 2002:a17:90b:2d8b:b0:2a0:310b:2cac with SMTP id
 sj11-20020a17090b2d8b00b002a0310b2cacmr2519425pjb.25.1711634881431; Thu, 28
 Mar 2024 07:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327175556.233126-1-ojeda@kernel.org> <CANiq72=kGWSQR7TgKDnAaef+FS3VGQeo3ri5vv1wxpW_88vdqA@mail.gmail.com>
 <20240328-quantum-bettong-of-contentment-7c7841@houat>
In-Reply-To: <20240328-quantum-bettong-of-contentment-7c7841@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Mar 2024 15:07:32 +0100
Message-ID: <CANiq72m65iv8VpwvuZvW-VOewZ2-Mf3knJf-tPAzfwY7F-ZBLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
To: Maxime Ripard <mripard@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alon Levy <alevy@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:18=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> "a while ago" here being 2 hours before your message :)

Ah, I meant the original reports that Nathan mentioned in his message.
Yeah, the message itself from Nathan happened right before :)

> I've added a Closes tag for that report too.
>
> I've applied both patches to drm-misc-fixes, thanks!

My pleasure!

Cheers,
Miguel

