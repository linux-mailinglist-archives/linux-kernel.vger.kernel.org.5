Return-Path: <linux-kernel+bounces-37550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12A83B182
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02282B27911
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE9131E33;
	Wed, 24 Jan 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/VKxFaV"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCB7CF1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122245; cv=none; b=AteAMG1C/dVgrYx4XxiEb5zDCNg50MA13V1Q9FZhv+7YQJMeXUZlAo6DZ/DGNNvJqLnqy2Nl3hBwPFV8kHyxiM8pgFoTYX0E0TdTJ3kOBi1AvVbn9pq4kikvuNc/YAm2q02KODPShX/qpcsCJ3H5tcMqI+w3ziRcrGcMoByclAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122245; c=relaxed/simple;
	bh=8KUE5Ar4cZJiQdQdzub7Ie8v6YPuyRdfxDbasY7sD34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaivqH8bjkixT+oNNG8YbS1Bo16xZpz595SOMvJwWrh6nJwh8HslxUk9qDqoZ8fkGb9YbjA1pHr2WSfYHfONjukH151b6ciZid23hM3aLOHM5dBlQM3+AXm8aS9eNRwfXWLX3u409Ex7idR31FRnprYfQgz0gq9mn2EN6JHA6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K/VKxFaV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68196a09e2eso34382846d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122242; x=1706727042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KUE5Ar4cZJiQdQdzub7Ie8v6YPuyRdfxDbasY7sD34=;
        b=K/VKxFaV927A2W6w8W0zuoB+y2N8ThlE/w0UbJE6NbPwTLQLgyUFP2tkcamx0w99Xe
         v+JCgpZPq3s6i2Q7zYUiZX6/8DEjKu00mivB4ymYS5nQA/JX7a/xfp0lnN+sL07g5smL
         rN5cdG74vpcxg24of6Itr02QCBd17x/J9/88o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122242; x=1706727042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KUE5Ar4cZJiQdQdzub7Ie8v6YPuyRdfxDbasY7sD34=;
        b=CoEABKrhhpoHrnfPlIKch3aj7cKWETaAfnitqDH5Xg3p09WInmXU5J4hzz1Q70dxsW
         DCVMMnrh6vWhWPJi5tRuzkwyK6392bhFCxvg+R1cxNgJs2W6zhz4C77quY41p1F9scE9
         UaLMkakJwhUWlblHkNJXvOqfg29c4hGTM2HoL6SD0Rj9sf7siZftBhH93FuTwN5I17YA
         u9xTVJZQf4pAhvkZR9w2mnFnvWgj1kdRm0/vZ1cXkQ3hRC9dnZs+70S5i/HcKxMDc/cy
         6lPQI2XDLcl4Yt2yZJRcbw8SYCidbOrBE3Pz3uUiUIuEi6q06HMl9kaj03Pu2RT8fhUD
         ItOw==
X-Gm-Message-State: AOJu0YyVkHfApXhdLXYUw31Z7Nx/nUsFEU+XfF3eLqmjz+BcyfmypQ6A
	ERyT01avBgMeDXLutdH2sGHKp+Vv1db6ETsgKdOtsRC8INvrdXAKguJLXEPOjIdr/CJGAHdy2Oz
	5n8jbZL7I6UsXQHYDpW9MI4IapPcytHxLIsuW
X-Google-Smtp-Source: AGHT+IETEgEHVnoBCl6tSd5ly6jPw1LbPISDppDEH/7WrohkBoOXGwU9cZSsg4zzP7dPPUTFxfWxwry3wrim9dTMmcQ=
X-Received: by 2002:a05:6214:20a6:b0:685:aa5c:5176 with SMTP id
 6-20020a05621420a600b00685aa5c5176mr3059902qvd.92.1706122242588; Wed, 24 Jan
 2024 10:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com> <20240123143026.v1.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
In-Reply-To: <20240123143026.v1.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 24 Jan 2024 10:50:30 -0800
Message-ID: <CACeCKadc2P92WTmtkN-SEDeWk7NVOVQhz2FpfgF2eWxXsx4SHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] usb: typec: ucsi: Update connector cap and status
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Abhishek Pandit-Subedi
<abhishekpandit@google.com> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Update the data structures for ucsi_connector_capability and
> ucsi_connector_status to UCSIv3.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

BR,

