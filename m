Return-Path: <linux-kernel+bounces-135998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4889CEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CC61C21822
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ABC383A5;
	Mon,  8 Apr 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfUfF1PX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FA381DF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618003; cv=none; b=KH09SrhvSrQ3DI0bokZPD+oStQveI3wPMFvIel7vzaH0a8KiPrfTcZ35r1/yDu+M6PAAGhgrkSa4tpW5fVRXILLVinskShIJ1PI/IKgy2aubdCQBT2YNt1yAaNdIMqMvQa5hpOtIKY9K0SACbnQpcAKAXeeKFPBkffg5FPPBVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618003; c=relaxed/simple;
	bh=x9mwVZCtRJZxj4SxW0pxGiYFzzdRxitCW4paJ8e6Vwk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=nFZ4jLOUQ2sOrLbl65fh9FMAD11Ehkhz+CKvw9uZDWkIoXDEoUGD/2wH0j+xRcxZj4fpT5sEgOZbKD8iRD6HUDfZ3d0/Pf2Vtv0aDecwVy36PCvVicD9/hw/YTtqs/tHCbUB/xnGXLHfw8tI4qKe3sYs/ZeGKnbTtXqFZ93YJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfUfF1PX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610c23abd1fso92899127b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712618001; x=1713222801; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8KR9ZDVpmFlaIwvKuBx+EnAZl+aysJrEDZLL4TycsvM=;
        b=tfUfF1PX/ufUeMkiwBfJE8B2Dbxw/WmajPZ105zDKfBVIZ9eg33wauBAvVOhenKp21
         VTV5ca2mPMiwo7MsCYkqY/lcPrZG6qt3iV7crDBTqHL0ilpvMQkJCpOJBt4wXSvXM3gq
         QoqN/pHlRJyr8flcdomG8fpD5nybyDE3XUaxXPOUuAxUL53EZxUH1EG6kM39g+xnlsuP
         W/uURi2mV+pHGZrnIVRJKSW9yqUAAJ2fOb5e+8T1oPFXMBIC2S2/o9PLZXmAK/cdIx/c
         RCqsu+EW59nXMSN9ugUboQy1VxMdtz8p0HoZKGSAMmQ29lqt+dLEnrg4lc+2lbow+DBJ
         zGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618001; x=1713222801;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KR9ZDVpmFlaIwvKuBx+EnAZl+aysJrEDZLL4TycsvM=;
        b=PJflqu3B9HALewEscNi448NfJhJxLlsm24Q3zzcZ1hww8FJu5LaTwcFTdrlw87SwJB
         Z6y/+LgeCjR0deHi/IZ43aTayM14gH69hWFHw0vXDOG3n68wyHCcSIRx6hcfqAhi2mAG
         QIp83JGhi+dxwmySXwYG6zYPTKWBGG4eg2mTFJSRCNQCO7y+uBF1vj+H+6KRF7xXwfSw
         kcflnE92Xcz8AwqApATUeE69VUMam0TZiTHf1teeGEfmsGtII1gzEQ6rakWBNzWMrbeB
         NNP4CUueaI21qE/IF8bFLyVxeupQW5MZ5yuJgts6ZhXbUeX+sfHQpVDvm/RKFOe6CqFx
         u4CA==
X-Forwarded-Encrypted: i=1; AJvYcCVbBxI6i/GqtMaZly6raFlVOa3rOsTLNH40sqFqyqJ8Pz3ZzReL6VMBn4J+m9pnF7rXYpvGWDrOAR0Na/LUbN2ekOh+MxS6PDTt0LxP
X-Gm-Message-State: AOJu0Yy73xAJHOx+MfydwguxoFxDNU3Ar+1XEurzMrOM4KGtCxTL5H/2
	WitvC3UC8Bka0E7rmXew1F9feGooOjDa82HPfTl6S+hbOE0oCQ8nsPBO9S07pbdDExhFyI45FXB
	dCKOQkSyuB7BkhA==
X-Google-Smtp-Source: AGHT+IEiBKuFp9QTgBmavvNyeuDLhVieZKacyXA60iTXYXv5owwSC1k0jFYE2SUKHElIfDGTrdBpXZCX+VZqUfk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:96d3:321a:67f3:5322])
 (user=saravanak job=sendgmr) by 2002:a81:73d6:0:b0:614:2c5c:d275 with SMTP id
 o205-20020a8173d6000000b006142c5cd275mr2854389ywc.4.1712618000795; Mon, 08
 Apr 2024 16:13:20 -0700 (PDT)
Date: Mon,  8 Apr 2024 16:13:07 -0700
Message-Id: <20240408231310.325451-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [RFC PATCH v1 0/2] fw_devlink overlay fix
From: Saravana Kannan <saravanak@google.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't bother review this patch. It needs to be refactored better once I
know it works.

Geert and Herve,

This patch serious should hopefully fix both of your use cases. Can you
please check to make sure the device links created to/from the overlay
devices are to/from the right ones?

I've only compile tested it. If I made some obvious mistake, feel free
to fix it and give it a shot.

Cc: Rob Herring <robh@kernel.org>

Thanks,
Saravana

Saravana Kannan (2):
  Revert "treewide: Fix probing of devices in DT overlays"
  of: dynamic: Fix probing of overlay devices

 drivers/base/core.c       | 10 ++++++++++
 drivers/bus/imx-weim.c    |  6 ------
 drivers/i2c/i2c-core-of.c |  5 -----
 drivers/of/dynamic.c      |  9 ++++++++-
 drivers/of/platform.c     |  5 -----
 drivers/spi/spi.c         |  5 -----
 include/linux/fwnode.h    |  2 ++
 7 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


