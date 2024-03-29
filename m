Return-Path: <linux-kernel+bounces-125113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5B892083
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5A0B26FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C113D518;
	Fri, 29 Mar 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZUTkH/M"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1A13CFA0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724942; cv=none; b=YBV1sWdD/X/BvE2DpML5Ta+zOkzejAJYYj50oXxPnKHzAp4+8d88ZYuFYrQTPhCqe7eASRYH4OYQRWmXOrZLA4VAn2v4WIo2WKo+TYYOi6kF3dYZalmVSc5bKDRxm3VDPfVG02Y1FTCQ9wQnpt02X1qNtYXOu6d2htYKghAlGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724942; c=relaxed/simple;
	bh=daePYgjkq+cQ2AzVZ2YunxMLLLX5go5iQcMTmOzir+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1j2HiRlObqhahCA3VYanpIUV27k84ybOqwAIe/x/WSv4caoExSWAjWAnDtJZ1z0PDPZgx+Ym3FO0V+ic/k5e2Nd0fi8R5pZRsOr2octuieq6lEkW3kABDkwvzBPW8GoCmjoyZxxMOpXI9WXVETO349r+t/xKC6TBEExAhBpNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PZUTkH/M; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c38eced701so1232247b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711724940; x=1712329740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daePYgjkq+cQ2AzVZ2YunxMLLLX5go5iQcMTmOzir+k=;
        b=PZUTkH/MOC0Jceh/rkKgCr1YUcNqSVErVjXTgkANc2osLlrRtFOZzNfTIQYE2TBvc4
         b2yI+okOM/oRgloxsKePl4gDxp1WBaswllpybF/BzyZCFjDOpgvBnM4ap/qZcEj/EGN4
         QduGIg5fH8zwajKdZNo4btz84A/wyPHSqhBAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724940; x=1712329740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daePYgjkq+cQ2AzVZ2YunxMLLLX5go5iQcMTmOzir+k=;
        b=nEjFfHeY7sPACrtp/JeL9rsyJCsvQq8ukEdWs7znGi7CEHMo1mK/fxKH9EUkSwJi92
         xj6WefeTubWb+is98MPI8d4ielEk0+1bqbVADVI2t8pzg7VkRiRjjtFLjauS5NMIL9P2
         Eux9hxDMtwMnlF3efuzK5bfokBt1eBjxsCFCTT4o7iCSpqJRzGpNTlaKfVjvBFxf5Vbt
         iok4GaTvPy+fnwx9wSEMSnyL9EHphGKkZmY7zuio0wHcv6R2/vp99wMd8gOqcOU9jOKe
         qMVEt7LW1viD65dbC6R6GJH7Sz0Qt7FB/4gzqLylw1nNivGDY2Uiqf27oisdvm14kENk
         bhMA==
X-Forwarded-Encrypted: i=1; AJvYcCWf93hn98XpNGwD8xZeSYWFAz0z5yYnWWQtcZ7c1ZZfjcce1dsCyYkj+4Nykml31Zz93IYntVRipviv7yGOtI2f/BMmd0QGQCOSnlaR
X-Gm-Message-State: AOJu0Ywjh8lJMyA1a8iOQn89Rh8TB/efWQqdYyicmhX41L02qS6IuXN8
	STTe4ZoEFA79cq6vqNO9b+EEqllKCLQkKpEwo0fR5+8bft64CXCBPb8ARb20TozJ9vfZqwMg6b8
	eotLB4bbOucIxPYRqgpfYmo3EvKUYCMlEPUHl
X-Google-Smtp-Source: AGHT+IHkCQP3YZsgrbXv26rrddE1rn42JrcOzPiLaSGOjMcGGGjCzEJoZhIHs5VGpIwznGGn1zH7hw2r9eb8NNiLD8o=
X-Received: by 2002:a05:6808:1792:b0:3c4:2f37:f158 with SMTP id
 bg18-20020a056808179200b003c42f37f158mr694924oib.30.1711724940397; Fri, 29
 Mar 2024 08:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
 <20240325-public-ucsi-h-v2-3-a6d716968bb1@chromium.org> <1b040be3-acd7-40dc-bc9b-24ea6d4b8377@linaro.org>
In-Reply-To: <1b040be3-acd7-40dc-bc9b-24ea6d4b8377@linaro.org>
From: Pavan Holla <pholla@chromium.org>
Date: Fri, 29 Mar 2024 08:08:24 -0700
Message-ID: <CAB2FV=614YLrsj6yPxRd1uVsF4n3EabLoXwL1Mtrk9Eg+5Mo9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for the review.

On Thu, Mar 28, 2024 at 8:32=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> While it's fine to use platform/chrome for platform drivers, please
> place drivers which have a subsystem into the subsystem dir. I think we
> don't want to hunt UCSI implementations all over the codebase. Please
> use drivers/usb/typec/ucsi/ location for your driver. This also removes
> a need for a global header.

I agree with your assessment that drivers/usb/typec/ucsi/ is a good
location for the driver currently. However, the driver is still in
early stages of development. We may have to account for PDC/ EC quirks
(we have multiple vendors), add FW update functionality outside the
UCSI spec, or add PDC logging functionality. While I'd like to write
separate drivers for those, some of this functionality will need to
acquire a lock over communication to the PDC. Even if I were to write
separate drivers for new functionality related to the PDC, maybe it's
better for all ChromeOS PDC related drivers to reside in the same
location. I am not sure what form this driver will take in the near
future, thus I would prefer to keep it in platform/chrome. Maybe
cros_ec_ucsi isn't the best name here, cros_ec_pdc probably conveys
the intention better.

Thanks,
Pavan

