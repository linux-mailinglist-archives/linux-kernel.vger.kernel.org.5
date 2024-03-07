Return-Path: <linux-kernel+bounces-96116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD01F875753
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476951F2206E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE9137C3B;
	Thu,  7 Mar 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t8UwAeD3"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FF137C25
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840146; cv=none; b=aTn3GY6EBtX+4qgfPzORyomgUKjH3AWOD3f2PuIpuZSQ+6ve+f0LrCblwqIXbFR1kQcVNu4cB5zLz7KFWQa9iutGJU4TXLQzwThM4QyFHth0fIk0j7UHO4y1CtC8Xl0Ssv2gfQpQNWkwCAUQTTmgNm6Fn024mW56fajTg2uTe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840146; c=relaxed/simple;
	bh=XGzy/yU3cwLp08z5LAoNOaWDfPUzNa1jnzFazHPuxY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZdxYZfpwHJjKsLWQ8P/9+rD2soHY2PrkZC6yYVEFivsDDwlzlPz3otLnfU/e85sOGS2DSFoGWLPRcfWqr1I0+uSA7Ug9n5EuXXc6W1AFBhCiG9rEfaWge9lEG9Dx6IJEY3qR4S5GMZU2BAczjUNwXJnrn6ZiDScuwOsEO3JPBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t8UwAeD3; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso1082639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709840142; x=1710444942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhPCXrbfwd4USwifoJOKfqZrrGIHCw9MK1mweX9uH+Q=;
        b=t8UwAeD3MDBh+dEcD3dn2C55Nqz3zcz9nH6BV7ZeAkB6B8TaZW6dHzZlaQ/vgkp59a
         rpaD8xBFsytTuSS6XbWbAJh2INaqutDb5ZoEIYMasRrGw9IzR5tmi5x0IJkK5hRJ6xx/
         TaSMUJkeBLHnVVs9XhYSRs5WGvwaNDRmxjyvy9Zx8LJLeZ70wkoYvI3+UMtxaFLSnnR2
         U8acF49RQw6t1M+ZqUEJ9gIhpLoxbT8T2NGjPlO7Ex3vNGsjxHgnNt/IgzLKgKXUmwsD
         zXlYcmn27RRbH1jeYWG+feNV/1MuW+xRroWK/IfyX1jhxeonEIgJYSnDlrkFBrg1sulS
         8etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709840142; x=1710444942;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhPCXrbfwd4USwifoJOKfqZrrGIHCw9MK1mweX9uH+Q=;
        b=OgYNUDo4lnHrh9oyRIbgI/U0xc96T94LjB2ophY9dc5UxveE28QVSZrYJgoAJXNdwz
         Jv+/pbT0ZTabm+/lppvIvlAYBEj8RAcE35M73WySNNbCbkdtu3yghntYx/ZMRil2oFG7
         k1PXlIAqzUl/p98x+JdfiJ74CHKoSmDZiB3LK2q+hFoIFeCCLVTiSaCw5yA+ii3i8aGs
         gS3fGJ3s6YVX0W3JIKzjyYtBSTwbHrHlLlaKNNNq1NZE+1v4pIFUnz8PiAmH4KhiJJt0
         FqKCis22SicNXpoWHHsa7nwZ93n8oUSpjmBrivqL1OAqzXblUYtt2XCIh7MSB2/VGmUg
         opGA==
X-Forwarded-Encrypted: i=1; AJvYcCWB4XOTPFtGjNlsi6gbgAnvnGs5nU+nyjqNt5rrxOVrxgoVfqpfm25S4BPCLQz5GLi413oelhFfx4tpvkv9TvnptnYOer3yT1I6aM5L
X-Gm-Message-State: AOJu0YwCATrPD+Bl+AmF8UMmgJVUM1W+ApNncL+R00C0yHayOaC62uPd
	ih6sFpOF37AItq+yfKT7sows/4WOZxTphL1jf47wg9z39YDLDPlqQU0C78wFxvKDK3Mzs9U1jHv
	P
X-Google-Smtp-Source: AGHT+IFJefM2Yqi/kOIg7PxHES2sAFzM2W6GX6v++wukR1B6ACHGHAIHAnT8Y5mkvp399tfbcaQnpA==
X-Received: by 2002:a05:6602:2183:b0:7c8:814f:923b with SMTP id b3-20020a056602218300b007c8814f923bmr3304029iob.1.1709840141920;
        Thu, 07 Mar 2024 11:35:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dq14-20020a0566021b8e00b007c870de3183sm1382315iob.49.2024.03.07.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:35:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Hannes Reinecke <hare@suse.de>, Christian Brauner <brauner@kernel.org>, 
 Jack Wang <jinpu.wang@ionos.com>, Phillip Potter <phil@philpotter.co.uk>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de
In-Reply-To: <20240307180837.190626-2-u.kleine-koenig@pengutronix.de>
References: <20240307180837.190626-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] cdrom: gdrom: Convert to platform remove callback
 returning void
Message-Id: <170984014091.501426.12348420904865022114.b4-ty@kernel.dk>
Date: Thu, 07 Mar 2024 12:35:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 07 Mar 2024 19:08:37 +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Applied, thanks!

[1/1] cdrom: gdrom: Convert to platform remove callback returning void
      commit: 0dc31b98d7200a0046de5c760feb0aaff6c4b53c

Best regards,
-- 
Jens Axboe




