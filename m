Return-Path: <linux-kernel+bounces-63842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA385355D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1929B23EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137285F845;
	Tue, 13 Feb 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n43bYSSt"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01425F48A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839762; cv=none; b=oC4piUjYft2Xfo8iTOReABYF1r5hCiGgY2gu7Nk4RTCcaOJ8qhelZ6djKUUVtVA32V1WK7z36Q7LF9yCAZmsrJkyrW3Dv+laZvcP+HCRbzEiU+DXsRBqRplHWSmQCpcf/S3pHKbF8IvbZ/BUaT39cCYiVeML57fM3UEa6ckkIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839762; c=relaxed/simple;
	bh=oC2NFUiPz6KNjQfbEYAP3hQ9ne7nidbfMTCAjfTNbaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Md9PEuelRuDnk2dJcFPybrffRq/iZDNOFipg71uDeyzZgX1lxpMSIRQmqQh5pw7WGOxUzOXlRg0N60/QEecBgXj9ycrq19o1exU2VnNVB035v13IT/iJf/isz59TxwDZRolV7RvULqN68Z4iReeDZk5Za9fJNf1YCl4adOV+bpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n43bYSSt; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso22123639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707839759; x=1708444559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPsZ61/B147XeUCItHAVNy9atLHaMQ7vWuQvVfNBe/E=;
        b=n43bYSSt6qA420G2XrpbuDz+t8MJlEuwY6wQhU79/6rRxe2cnn9QC2m36jvBeKr0Rw
         RL7U9k5Hkxy9+YWCA7IK18DnmGn/QmhNKgjHevrBZJnQZLoC5uN1QOv2hJqEZ9uADQ59
         fk6RUsm2KFk1g7hVNGCbDfLR7lFa+S7Ae0vOt8kENeXfektWg18i7alX8DVqDYu8Zd+I
         +VTU2piqoUBpKkvCJOnNlqhHR0oZ0yvxJ7W64FJLdpSmvpTOaUS7JajLWB6pf2ipY1yR
         dXl0nVSMRvQC992yZCOlbsh11QnGp5C2keRpA0ux5+f0lJ+/r2264OGJoJtojakbdeI7
         QRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839759; x=1708444559;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPsZ61/B147XeUCItHAVNy9atLHaMQ7vWuQvVfNBe/E=;
        b=STLQDpXPqiMFjo+8G27U3/NHK8yxGXZdDw7FPRiGI8JKH+BpXuxjz32vqPoMeKYlDa
         wmIzRe/RYaBIX389yRTWUt4rX7FskDTL4kX9qZ/+WSl4Ww4KfBcm2Z+sCpT1mLGs10VC
         EHuJMsuKcfRRLsBaAt4kUhyqbmlzv8aJw8IIlfNcoKF92EatfpXsyhQr1+yJ3IFY7ktU
         npT75gnxshx81yA4sDkqyR+Bm0NxnkcbNVNOwvMwKYW0XzniyDYS7JwH0Y91CfbGT77D
         jnnCKrMWvnOVXyOq3gChSZFeHw+DCv9h7RLVoOPmoZ4SZlCzkJvYm6hql355MSUnzqeP
         HI8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8MdSaUR4rQvKeU77vwxZtaeL0vNevxF2nTC523rVlJnn6NxCK/rsXZCMPQmMD/8KbOrsriwZFlOwhsNqc9MlypjYxqNcY/9sLZWrN
X-Gm-Message-State: AOJu0Yx/aCdSXCmeGbu3SQ5Kxp3BDDtSiNn85SUxM1p9vr1SJYO+IZGs
	GvrgWN1PnybhM5vjBKhNXR9sJ8OZGCjASxU8YTllqRohbsCfURNRGf117jRNiGFjnY/Bkjigo2s
	7
X-Google-Smtp-Source: AGHT+IEslLXJyHXnsj51AumuBlOy6N0oP+uPR/PHnApNPg2IYUR26OYsdB25n355+SMmGoWI5yZEXQ==
X-Received: by 2002:a5e:9411:0:b0:7c4:4f32:8311 with SMTP id q17-20020a5e9411000000b007c44f328311mr44941ioj.2.1707839759646;
        Tue, 13 Feb 2024 07:55:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/S1UrM7pG0AjHa4py/2k7FGa1SDtErFeE4Lc7xt6L3BDoPYiSiEH8JVbfCLyHDMUwZX01txjBWgNqXC64Iu9aqLcJfFHHI7xpcYPORy8iC7EDl3VY+S2Lqywgj5yDCpGsRu4GV7OnCVgiqP9bcCOe2UmDctiD76nULVMnih/Uyj4QlWnvDk4EaMDWm+8H1/wOI4CnL6t24O5IYvTiykt8dQDIoaeH/C1J/feEnXtVKKsf+hM8qmhcEDs75hQS5J7jN3WCoqYt5uj7vFEN7/vCqXoOPJeBr4p3P/O9L80ITraOIB60kfgD9qqndGwK0Be6h0BLEFUHkBAXfmTLwCMyaUVOBCOzfyoSf11lrQjKfQRRk35dCwwSpqWKrhBynySDIqvRLcY2MDTlZemxzBVCcssGSPxAEBpgZovxz9kqglYJ47RCIK1NgDeiWXAa1FY=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056638411f00b00473ca57bfefsm403153jab.124.2024.02.13.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:55:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, drbd-dev@lists.linbit.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20240213100354.457128-1-arnd@kernel.org>
References: <20240213100354.457128-1-arnd@kernel.org>
Subject: Re: [PATCH] drbd: fix function cast warnings in state machine
Message-Id: <170783975824.2331975.17734171438051214868.b4-ty@kernel.dk>
Date: Tue, 13 Feb 2024 08:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 13 Feb 2024 11:03:01 +0100, Arnd Bergmann wrote:
> There are four state machines in drbd that use a common infrastructure, with
> a cast to an incompatible function type in REMEMBER_STATE_CHANGE that clang-16
> now warns about:
> 
> drivers/block/drbd/drbd_state.c:1632:3: error: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_resource_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1632 |                 REMEMBER_STATE_CHANGE(notify_resource_state_change,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1633 |                                       resource_state_change, NOTIFY_CHANGE);
>       |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/drbd/drbd_state.c:1619:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
>  1619 |            last_func = (typeof(last_func))func; \
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/drbd/drbd_state.c:1641:4: error: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_connection_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1641 |                         REMEMBER_STATE_CHANGE(notify_connection_state_change,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1642 |                                               connection_state_change, NOTIFY_CHANGE);
>       |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] drbd: fix function cast warnings in state machine
      commit: fe0b1e9a73d60f01fdc391925be74e823af7c91d

Best regards,
-- 
Jens Axboe




