Return-Path: <linux-kernel+bounces-136203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360389D109
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9765528556A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D454902;
	Tue,  9 Apr 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHm9rLa4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296522572
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633395; cv=none; b=t7Ab7BMSoxq73dxdw30tbgZALDBSI5NU0OzhiouKHB3zKglt0OqiEO6a+AO7JkKDE9iwL6YTyGrAUVGStobFxaafo9ok80QluFm4fWupqv5xUY/EJHjTgcmk1rD2aDtb5KgetFOH5B/2M8k2R2dNaudsUBr9a2MIIf5C2RAeC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633395; c=relaxed/simple;
	bh=kSFRKyKBm6MkXHpQFx28T6Qb9DFlvLxWEW69gk54tU8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NJwAk4IZtrafD4mg1HTjRoW6ON8f+POPWcGWYuxiLNEyECEFXY7yTub3nShJFh7sbwsMduNI95wC2aKsVvZmxqkpb12+lqZTS2d9LZ6DME7yxIkiMa7NGMswbf90sPVTfV4ZhgCOwsQn50Ev9Hq5xaG3E3kZGFsZhsHuLHwlwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHm9rLa4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51ddc783e3so184906266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712633392; x=1713238192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=joAq2N38aoIlqm7xfkJJG+CXn5j7wZMMcXjDfZYpbSM=;
        b=SHm9rLa4oMuDsSIAsnd1g9SOIXVpdh2hZ/21FuH60GcwEOq8FsUtNZ95MB7t8cir6H
         Dt9D9LmH76zJ9wuYF0FcyVYmGWe0fWUvtmLczI8AAB/7J4l+qFzFi9cKo9Mz+xhEUjRh
         9Wafq2cXPz4V/iqXa5rp+YlndxPbrxmLJIsj0uJ1tzNLtKOSI/BE7t2zCXFmO/Qdpx5r
         AEaPPRKgQyYsacPCwQJBp69Sdso+niwrXhMLwKVxddeLh0wQOfAwevHBGL7bHonHelee
         g7eW6Y4d6T6OsfomWhKJzRifWZqHQmi/gUAH08wDSVLxOfPHJJUPtvzzr+X8S1f6nSp+
         1TEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712633392; x=1713238192;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joAq2N38aoIlqm7xfkJJG+CXn5j7wZMMcXjDfZYpbSM=;
        b=HyVUfnHYSY8bT9Rl1pYub/zcGS9zITpHwD7LDs/wAZ0vVOpyR8WWq5Vs2khV2JHZq4
         q1zTAYbb73Srn1f3Vrmt7j/A0cr8CHnFNpLwM9JX9lWPmfvrX5JzUo1leKXtkND0MEBa
         s2SyW1Y9mKgQFoqmBD6N9NmRUq50z9hqoW/kdun7PNgv884PpEPnT36p8nCEYEA978z/
         K9Dgx8y9g4rBEvS18QqksVNDfThFKx4jtyCyX1dEyKaTPDu+ZAw+vPpa5SOmnH/mwumh
         NexjnZA3VThuy7fDBR3Cv8prMvJ7dL0A3nH3m1vlIcvXqSrpdw8aQJta7ZImLV5ies9B
         YGdg==
X-Forwarded-Encrypted: i=1; AJvYcCVi+ofU/M5YKNEZD98FnGR2HTKezeola0lACzH5n6ah87Atkv2bj3VVnpuMtYtcAqLLR6txdpLHJHdHxf7alPmI+OGUUV94EahyNH13
X-Gm-Message-State: AOJu0Ywee6qJgviS7/ZpVp6DZyqzBCTe4KowbNsiteG0JofxnWqGcpOp
	ktEHIpz5V3NNXdhkqiBVmIICp9zI+OBfVSHj+Y4vqMP1cV9W+DoGTsySX+xezs1yLiYbkeKO4Sf
	knh43EfCbZkLkMqykMyod69B5Hjo=
X-Google-Smtp-Source: AGHT+IHs0JV1E8bUqajO4WPrFcRBHm2Q4MG0qurmd1AQ/SfbgRh3WnV8UCY6D4Xu3I+qlbzQShgOyUlamumtqo5ihbc=
X-Received: by 2002:a17:907:1b17:b0:a51:da29:6f67 with SMTP id
 mp23-20020a1709071b1700b00a51da296f67mr2907187ejc.20.1712633392237; Mon, 08
 Apr 2024 20:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 9 Apr 2024 13:29:41 +1000
Message-ID: <CAPM=9tysq6sxv-HRUf4+AoAoC0YA_s0tUz6ujms0FcxrgtOUdQ@mail.gmail.com>
Subject: [git pull] drm urgent fix for 6.9-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

A previous fix to nouveau devinit on the GSP paths fixed the Turing
but broke Ampere, I did some more digging and found the proper fix.
Sending it early as I want to make sure it makes the next 6.8 stable
kernels to fix the regression.

Regular fixes will be at end of week as usual.

Thanks,
Dave.

drm-fixes-2024-04-09:
drm nouveau fix for 6.9-rc4

nouveau:
- regression fix for GSP display enable.
The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-09

for you to fetch changes up to 718c4fb221dbeff9072810841b949413c5ffc345:

  nouveau: fix devinit paths to only handle display on GSP.
(2024-04-09 13:14:13 +1000)

----------------------------------------------------------------
drm nouveau fix for 6.9-rc4

nouveau:
- regression fix for GSP display enable.

----------------------------------------------------------------
Dave Airlie (1):
      nouveau: fix devinit paths to only handle display on GSP.

 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c | 12 ++++++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c  |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

