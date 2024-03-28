Return-Path: <linux-kernel+bounces-122340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0DB88F564
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC0D2A41DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9641DA53;
	Thu, 28 Mar 2024 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJPZsEaK"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFAE849C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711593159; cv=none; b=qYRWieGchDZqupPZhAJHY//wLHkHCSeTZGJfF8ieUI9kz0EB2RPOKlZL+fnX4JlrrV3DkX9hTDzvfjLtWgqUd01XzSVtM0MFCT1RrBYkz9Yc5PwC3YyXdgzuDos9hjAy73m/JIv7kGpovNccYIPlwbuEYw9MP9u/wlXa8+w+Kzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711593159; c=relaxed/simple;
	bh=FLFY/kfCRksoii1pKjJgIsIEKFYSGdDCzyyy5wOIM+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl4KUi3HvlaeDS7dHajihyy+76uPGsfoy8ImHVAd0QhSg2xKdYTg/BBytZIOYvS40u0kvp8yv1bXFNvUBZA5xqy0Ipa9dXiiO1HD7dotMVJKA4QEaR4VOTTEPFH1BngE+OVyHddkewcN2fOgn5NkPv2DzwHp0w2WtccGbIga8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DJPZsEaK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dff837d674so4091275ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711593157; x=1712197957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLFY/kfCRksoii1pKjJgIsIEKFYSGdDCzyyy5wOIM+0=;
        b=DJPZsEaK/BdZgYL4lqIxTKbwHHBLVXJEdmhWSUrifo1cxw50xnaj000tNPnm5A9Osw
         yi/YlHhg00LaGpc5j8b31VW5Rpe0EZhhleVoy1+1XeKHByfiqMdWx+dcEpIDzPXhPzZl
         8rIs8JcffdMzVgTaDkyS7NWWFX8nsFTGUusSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711593157; x=1712197957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLFY/kfCRksoii1pKjJgIsIEKFYSGdDCzyyy5wOIM+0=;
        b=MEVQ5vxWhuI5ZDGtVQE5gHf7NcWes/aCnePqV1jnn3AgfyjktkUf6mXFLdkDHerhuJ
         vWDOzk9nwPHi04fJwN+pODkFTptcDTlJ/Fp2BB/I8KYvNVS0d6HVkX8zsdLJe4zneRNJ
         Aa9MWKp4J6AnPUJeOulXsSJW9/Z5vAINTo1UkpbOiRZsnfESxAwUiN12KI7P/4EBZFb3
         Ws40gfL850/zdKYm2r0mlHPEAxzEIKA3EQhKhassCU0NBYDWajehs9OX4RxWnE2qR/zi
         QL8RkHNAoXoYTJEtVTSfDHCpZxRW9wqSLIwOW1DfcO78qOrwpcez5lpy5cwcuVdsV2vd
         IWGw==
X-Forwarded-Encrypted: i=1; AJvYcCXEJN/lMsePKxkZ1O3Y2ytSsVwiV+K3FNXU7yIN1crzR8sz06ND5VvpE2L6PuogE6qjvrObMTttbtx/9A/osDVmMqH/5i4C24rGXBlc
X-Gm-Message-State: AOJu0YxvXuj69zWVnhD7in1FQOsC+1JW8ILmfeOptpQY/9Q37eMxjkdV
	c1b3AP+DcwOj74SHdoElaLFvn4LmE+RWLsXoRrrqANk5x0Gp425+rk8T54ETPg==
X-Google-Smtp-Source: AGHT+IFFxwcgunzNtL2vlGvoIN0AIhkUgslnmPFFG9e5z2yTdlTwkt6eJE1o/n4xZqilY9cbaPl8vA==
X-Received: by 2002:a17:902:ce85:b0:1e0:bc7e:6fba with SMTP id f5-20020a170902ce8500b001e0bc7e6fbamr1866709plg.5.1711593156973;
        Wed, 27 Mar 2024 19:32:36 -0700 (PDT)
Received: from pholla1.c.googlers.com.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001dc95205b56sm259481plf.53.2024.03.27.19.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:32:36 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
To: krzk@kernel.org
Cc: abhishekpandit@chromium.org,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pholla@chromium.org,
	tzungbi@kernel.org
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver
Date: Thu, 28 Mar 2024 02:32:28 +0000
Message-ID: <20240328023233.2568230-1-pholla@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <03e1941b-0c8a-450d-9b83-76260817d303@kernel.org>
References: <03e1941b-0c8a-450d-9b83-76260817d303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Mar 26, 2024 at 9:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/03/2024 04:39, Pavan Holla wrote:
> > Hi Krzysztof,
> >
> > Thanks for the review.
> >
> > On Tue, Mar 26, 2024 at 1:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> Nothing improved.
> >
> > Yes. I only added maintainers of drivers/platform/chrome in v2. I am
> > still investigating why MODULE_ALIAS() is required.
>
> Heh, I wrote why. You miss ID table.

This driver is going to be used by the cros_ec_dev.c MFD. The UCSI device doesn’t
have an ACPI or OF entry, so I am not sure how I can use MODULE_DEVICE_TABLE
here. If I don’t use MODULE_ALIAS(“platform:” DRV_NAME),
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/cros_ec_dev.c#L206
isn’t able to automatically associate the driver with the device at boot.
I haven’t upstreamed the change in cros_ec_dev.c yet, but the code is similar to
existing code for drivers/platform/chrome/cros_usbpd_logger.c. There are many
other occurrences of the same MODULE_ALIAS pattern:

~/v6.6$ grep -r 'MODULE_ALIAS("platform:" DRV_NAME)' *  | wc -l
93

I am still trying to figure out why the “platform:” string allows cros_ec_dev.c to
load the driver. I suspect it might be due to
https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L1257.

Thanks,
Pavan

