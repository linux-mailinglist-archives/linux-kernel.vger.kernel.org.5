Return-Path: <linux-kernel+bounces-103839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B515887C530
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E775C1C21485
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2311A38F6;
	Thu, 14 Mar 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="Y3uSTebv"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33690399
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455869; cv=none; b=OZbsWea2BQ2RCKjq9poF56X3U1etrMaKoJtiwZvR4fSsWFsc+Kxn5nzXFU3jSnc1l5VGjUM2/LGnz/TMfSijtm1xFFPd8etUG0UrF+reRsm565VVoZc8CCtkOmIx6T8C4uCeOwCGeZyIgl6kl2bJLLo0a7nyQv7ct2QXv30WeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455869; c=relaxed/simple;
	bh=DYwGccQ3nzekMxwIlD+dlesOQ3m//0eGti0QnHKOE+c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LvTY9wVXHuroHAFMMVWxrh5Ha6dTkqQL4SVaE0RnJcIOdWtoRUVynF0mLb1vApAiqLLu4Nhvuw+7vbsWWQ/izKBvCZZb5ERmtzbR2lLuKIvRWwlIxdz9juSXRPNZDeAHOUpjdw3dDTe+6oobmpiMEaey1y8dJ7H8ANb6NsC3Dbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=Y3uSTebv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a1e1e539so1254838b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1710455866; x=1711060666; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVhA3coOgn/7Uvgol5ZvrCmIFQUcKJqMv636I1Hr4vs=;
        b=Y3uSTebvlyYRN3zw6oGbmEl8m6LT/123oiIaQYAbh/kc9CoUjvADidWaqAiaxjsn+x
         z76p3qG7whVMFHvvdlMyYag0ELTzuXpyKA7IpVgx2N2PAZE9RZRNZrT/jnclAyh+nMmm
         FQUBf0o898KhC4zlow7iNaYkozFXI/n60nitU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455866; x=1711060666;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVhA3coOgn/7Uvgol5ZvrCmIFQUcKJqMv636I1Hr4vs=;
        b=vVcJYxRFQcXnaAFkHUTsjsGOiwBoj1t7v2VM0IiYT3V+uJhBHJPnHYWSyP+A/tgiVR
         KlnMFfCFAj9QKXSbT5Wvpynx2rZ1FJbSdkhsCvkHPype4qr9RdmBvvZSeynIhu3aLUEf
         fFL0mS0Fa/WZ9dqMcy1NiOy8jOMHhg3y0FhGwIUwbLFrrfhv2sEl12iGHkVVQ3LXZg0r
         /OjDEgioDgayxJfN/s9bVXXnvhKvvXgUn9g1sLk9NDBvop5hw3yw+Rl0gSOQnEOHtMuU
         ObXGRPDeOkC0cN6y+3WmV6Rnt4k6H1wKHQZ4TD73WekQBvVqmKf3YzCgTct7+U4Ao0xW
         YIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4KBrnD6Un31j5FUZKsPQyoy+bLqJQCWrwTpUM8j6jkl0XC6cECxnlK18jwoLRhXIZ1x2uG0v4NeAjRfs+8ccbktV2v/3EDFPsYbNi
X-Gm-Message-State: AOJu0YxWWBVXIyStWbDP7/+G2npTuixuTmN6AQ2QFEhVhFLxaOJ013He
	t0r2wzqOGAplacPThPGMlYzP/oaDy/OofiYIfsZb9Fs5Leq5KreC1CRNs8N3AL0=
X-Google-Smtp-Source: AGHT+IGAOOfRBySCiMQZGBg8qH5/0uKU1q+54GPrmNNw5gNbPKI8lYxygfrAgcHz+INi2pgYVe1neg==
X-Received: by 2002:a05:6808:f12:b0:3c2:aa94:3399 with SMTP id m18-20020a0568080f1200b003c2aa943399mr3004344oiw.2.1710455866201;
        Thu, 14 Mar 2024 15:37:46 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id de33-20020a05620a372100b00789dd526bc7sm826447qkb.129.2024.03.14.15.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:37:45 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivor Wanders <ivor@iwanders.net>
Subject: [PATCH v2 0/1] platform/surface: platform_profile: add fan profile
Date: Thu, 14 Mar 2024 18:37:32 -0400
Message-Id: <20240314223733.6236-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Second version of a patch that switches the fan profile together with the
platform profile on Microsoft Surface Pro 9 devices, improving the cooling.
Originally submitted in [1] which describes the changes in more detail.

Changes in v2:
  - Use u8 instead of char for the argument of __sam_fan_profile_set.
  - Made profile and profile_le variable const.
  - Added link entry pointing to the Github PR to commit message.
  - Rebased the commit on Torvalds' main branch.

[1]: https://lore.kernel.org/all/20240302170147.13026-1-ivor@iwanders.net/

Ivor Wanders (1):
  platform/surface: platform_profile: add fan profile switching

 .../surface/surface_aggregator_registry.c     | 36 +++++---
 .../surface/surface_platform_profile.c        | 88 ++++++++++++++++---
 2 files changed, 100 insertions(+), 24 deletions(-)

-- 
2.17.1


