Return-Path: <linux-kernel+bounces-96085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40A8756E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9A4B21587
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A069135A68;
	Thu,  7 Mar 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkJ4KqKk"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19521332B3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839103; cv=none; b=V/pZ2y/coXzzf126YKXGlP7vDrG7oUbS8DOheDWV5vPIeBCnFLMBS5YYUKuwhIP21aQyhN7eaFWOCwj62Tngm0qrteYVIiJLp/9wWQ4BxacvPEj3FoT/m7VDyUe6WeYAS282qd9vV+Xu64ZM3O+/cB5z8jxrJjJU0FkEM9R6b6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839103; c=relaxed/simple;
	bh=UO1XFH8MdNoqyg8FyriFhdlwi1Fa/9B6L+VIzBIKplc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sskUqOy9T4GzJpRXPlTCQ9ejcpCHit+FT/re6hE02PG2TQR61/hk/nYex70d4boT9PX9FJ4QLSf3DGylo6AYFpzofc+xNtC0movtX8I/0ths7Dctk8jprJyt+2JUgiikCTIThz25tip4RIm451fyCunJ7uDfDLNRpGsl4IOOcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkJ4KqKk; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7884461d926so111909385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709839101; x=1710443901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IUcbpgXT14ijwo0i0o66tU/rwBo9RUA5TlAkXg/6+sk=;
        b=AkJ4KqKkK3f/6ML7qOkIoUXrx/kF7MYxigcSMVIYxf8B1NiFZYEjRXflcwTrIP2UJG
         gVrjxDc4+0GbakJ8rsoo+/1x6cJRSxUuuU+eEZxel4fRVSvpMv6MBV95P/qCXxFrg5d9
         QqIJJv95cEXYFvZ10WpGyPr7J+u5F84f8YgOlnXB56FplFMmvdfZbnBdvctff3yppOVO
         pC22k8DU8t8nSf2fYl4SVXV1mfar2krPcno5ahKBg0FBj2BiLo6vchhX6FnpY25ssV0x
         xZh6ptR18U1H8vLPqt4Ra6x70FSmqbAAfxUmHD44+oAlDpgTRzHXs63Cc9/EY85qXnJ4
         xfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839101; x=1710443901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUcbpgXT14ijwo0i0o66tU/rwBo9RUA5TlAkXg/6+sk=;
        b=ryw8u46M6dOpNtRFuvCwQLzTJuV3udGsZDetiqm11r5CVbD4R6W9lxPBgvtgXYghL3
         Rz1ahgdN6xCAAxqxqvVKpGWQIgsyu8Id4gLrasL5BMsawdISHRxYE7JcKo7Wp1woM9bn
         queLzjw/2XYkmPOdJ1l7g7lUW95EcSBolqqEBE4kjNKgF474285T19KwqPB4/B6gY1M7
         hoCZGopxnA5c4MpFoVC1ghmftBx9gX0/o8ibSmt+y9MYNmkUZrwtRc0rcOPFOp4ohYkm
         Qh6KzRSd3S9jCEjEHVtLVZlNlnMtwjBPBUAzoECtTvWGSOth+C+8TRhUFny397TrImUo
         LSvg==
X-Forwarded-Encrypted: i=1; AJvYcCXLQfb8yxX1facU51ebbWGcrBQLyRM5m69yJnqOopGnsjds1tbZ4F/eJHatUHbquRI6RlHTETapvMpP09s3Jbd3UW3dAtMhDKyomXM1
X-Gm-Message-State: AOJu0YxSfwOn6OMaCg7mDvgDlaI2HIER3RS8wlQhOStG63UOli9f2/EX
	4LdZEjNmpnNEWiQFKtMlw+tiRemnwFkS/doBHMpNnsH+ImXqEyiN
X-Google-Smtp-Source: AGHT+IF9MeM1ABWvNmsZcRe8ULj3hdGLeMEL7M/i4Bz+23B6tNjVwKln114k4+Ax/Fy+ojLQcCs7yA==
X-Received: by 2002:ad4:4f14:0:b0:690:ad27:bc77 with SMTP id fb20-20020ad44f14000000b00690ad27bc77mr2212712qvb.28.1709839100861;
        Thu, 07 Mar 2024 11:18:20 -0800 (PST)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-d46e-8590-8b01-6ff9.inf6.spectrum.com. [2603:9000:9f01:67cf:d46e:8590:8b01:6ff9])
        by smtp.gmail.com with ESMTPSA id jh19-20020a0562141fd300b0068fef023e6esm9042555qvb.88.2024.03.07.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:18:20 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH] nvme: Re-word D3 Entry Latency message
Date: Thu,  7 Mar 2024 14:17:34 -0500
Message-Id: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Some words are alarming in routine kernel messages.
"timeout" is one of them, so avoid using it.

Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..2601dc1c4f42 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3206,7 +3206,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 		if (ctrl->shutdown_timeout != shutdown_timeout)
 			dev_info(ctrl->device,
-				 "Shutdown timeout set to %u seconds\n",
+				 "D3 entry latency set to %u seconds\n",
 				 ctrl->shutdown_timeout);
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
-- 
2.40.1


