Return-Path: <linux-kernel+bounces-37259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3E83AD62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E291F25781
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F57A708;
	Wed, 24 Jan 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3ClJx6cS"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B17A707
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110262; cv=none; b=Nr04e4ROTqguvC/Z3NoPHWXRtwWTXE86l9+7fy8bdOSS2703XKA03JENXlKozuAfNKtQ5E9VuRNL1tgUa+x1yD+mt9B8xKk0I9vlpuwEPs6UBKKWhZ6t32efxxbPEoZC60WUXyggopQyHaX1GrG2XMdwTCOuJoqR5EQLz5UVnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110262; c=relaxed/simple;
	bh=RoQut5AVHZuhcbsg5rERP3+10LBVd5UTRpunDEoOXys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rQRVd//D4IzaTVy96konveaIAXLzXKDf5emToMyjEifSQRyocUZcOpS8sioUN23TlRSYApfRL/eN8Dg1W6VEwUwOO9waRuro3TaY52Tw4uZDUuB6Bat4swCanc3FalpZcNleaV/r4eZ7I2Um+YPpY9dR/qqRJ0BKdSlk0dMJnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3ClJx6cS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bed82030faso73958639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706110258; x=1706715058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv4/8CDW8QIlduDHXHHg6GE3LBQ6HZvZ3aGnmpvuq+E=;
        b=3ClJx6cSNtblLTPIBhe0FvfG4QYncPrN0slzIyn3sBYELAW80YXz2NBB0XG2OhuJIl
         Z71SX9nBY7HtcY/wsmdrPwSK/FoJ+YKMj5x+Bo7xGoBmRAoS3A48FPlMSivGddMY4SwJ
         Lmtfd+ZWrZ4DJs0xEE5l3yV4snRNyVn9VvMlPD/x0N/H1KQ2S57QsCXq7cVV+hu8JhRy
         K3ZvA/iiG/jo1/IgkqN24qJy8WuafJ2UeihF/Q2+MqNpfaX3KUKqzTC5ykhUPmWFAy9E
         ++bkPzCAickJ3NQX/j9Ndkbg7DhPlivUqjZ22uyGcHjSGEQQhFCpJlG/C3u9/CesUmMT
         ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110258; x=1706715058;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv4/8CDW8QIlduDHXHHg6GE3LBQ6HZvZ3aGnmpvuq+E=;
        b=n2Xlrl7CoFx1CaazuNQfQWfwo6nQG8J0ujhMkB+a9hqASuF/e2mH2yt1VAXjDTjUxt
         bhgKDRZOlyU7XeF/2QA2Zps0TOA4gJIlEfyxVqlt/Meonx+Pn/2yj2I/Ay95DXCG9hd9
         j1vDJ3DeJKyVctPZm7yxgY0Fd3t+8KoSpe3F/jKeYVQTBeuT3Szk930PPwYjCZgKMJyD
         gZ8e7sM25pLyptpL67yFRsCbIRqoJtzmUXgEkG4a0lxeZRNTsf18WJqR4m4/GIZGoLrH
         dbb0OUK5fwj3SRTyNZpqYOygzt/DNtj3YCnjU+1yuanJtb/xhFZ8iAGSZxFyJ0TtI3pU
         cUQA==
X-Gm-Message-State: AOJu0YwfGEbglFybTBdnXPNmefT48YOqWCphzWItU+5zVfD0QNUHbUmc
	mBSmC9PrOUo+m8okEfud7whCxfsgdEiT4UrZyF+K0ydoveEj6pT5ImmAEXkdInKYioz/OHRFoHU
	1YdM=
X-Google-Smtp-Source: AGHT+IH7F3rrjrPWkFhZDQe8Kjz8JwG9WX12tOjmn6LkuKcDAei6tT85d2CDl7oJ0hRoJWTK/Fpvrg==
X-Received: by 2002:a05:6e02:1d95:b0:361:969c:5b4b with SMTP id h21-20020a056e021d9500b00361969c5b4bmr2895875ila.3.1706110258312;
        Wed, 24 Jan 2024 07:30:58 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o3-20020a056e02068300b0036194d1dad6sm5297438ils.40.2024.01.24.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:30:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124072436.3745720-1-bigunclemax@gmail.com>
References: <20240124072436.3745720-1-bigunclemax@gmail.com>
Subject: Re: [PATCH v1 0/1] aoe: possible interrupt unsafe locking scenario
Message-Id: <170611025731.2148128.9958144886915388505.b4-ty@kernel.dk>
Date: Wed, 24 Jan 2024 08:30:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 24 Jan 2024 10:24:35 +0300, Maksim Kiselev wrote:
> I'm using an AoE device on board with D1 SoC (riscv arch).
> When I enabled CONFIG_PROVE_LOCKING option, I got the warning below.
> After some investigations, I made a not very elegant, but working solution.
> The patch sent with next message.
> 
> I would be glad to know what you think about this.
> 
> [...]

Applied, thanks!

[1/1] aoe: avoid potential deadlock at set_capacity
      commit: e169bd4fb2b36c4b2bee63c35c740c85daeb2e86

Best regards,
-- 
Jens Axboe




