Return-Path: <linux-kernel+bounces-77478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C28605DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F7B284D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920E1865B;
	Thu, 22 Feb 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTwbtdZJ"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894A1B7F1;
	Thu, 22 Feb 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708642616; cv=none; b=GN4yOqIGpeZwtGh7fCOoRaxqF1xdQ2IUlJwIIPXlDL5jJmJHVS0iZ1DJ8cnQs4/NFOpAskVmPfCt4am/5AMis9+MNhMGKZn6DkhuACHtl7DVfEZ/hOgsPlW51y4Msbr/m1wEsgn3ICsrmZlxxAs9nhttbzDYRXeVxCDIDXLgTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708642616; c=relaxed/simple;
	bh=MWhQ9OitdtI2L2kqqmn2Abh1jxW5jtLKi+QUQjezWUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/nzNpMBkQpOGN9yuzkfElnTdqXWJGRNgylJhlBuPH4olIjWQyEE88z69a45sWoT6xdiNSH12EdG5Yyyktq4eB/OojKLbOkZwq12wqxlWaitMJkQubMJV4aX6wCNolEwHoqAPUfzpZUswIcLYwFiewP0ymHQ4zmHtXJ6X9OxV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTwbtdZJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2ee49ebaaso85753a34.0;
        Thu, 22 Feb 2024 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708642613; x=1709247413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CXk2yPJ/mVtgjito9mdZBvBKyIgsv1n5SPKheaIBNWM=;
        b=DTwbtdZJ8VEhrI08mZVDdy/XQad0xXPvj5PiXp7VU3tJXUJ/+tqab5CqwdyW2cmYXB
         Vhz1cTPoJgpAXrAqaqSkOg57u0RpDUbzzqjECbuc39SDzHFjWOMGdj9r8NfD9+XiBiRr
         Oy/jYc3Pj2zXNfO1T2M0ejSgEgfygi9ArQhfBJFWMHtaLKP+5qGJw1c1GeUjigC9FNOA
         kdvJ1GvKmGWzCIP825Th0AT3o6S1ZzuJdUjP1H4hjJRj/Lccw887mm3Sp1/5SehMGFFr
         jIpYYFb5c9ScIFN0lLoqEZXfZzRFBoSlHyc4Y5T/FRqAzeuG2L9C3dn2nrDUkC2MOZCg
         Nnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708642613; x=1709247413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXk2yPJ/mVtgjito9mdZBvBKyIgsv1n5SPKheaIBNWM=;
        b=GZop/pLILgdF2XKu16a3+S6sMV5S7l9BwO68GIosl5N1ynKS117UlW0uUvCOS+tmf4
         YuslQWQCO2hH4A4c06/CBOu/FDxN9ydN2mP0tlRKWa367/EFqVNinTj6HnPdK+NeDM34
         VVLG/UY2E8euioSUieSqzG0d90m1WQYzEXnbt+uSgLgfNJGwLupgMn9LeWUaQkT3dFLS
         tWEcdHb5H/Ti9+LQL7SdAi5a9SjPldTqzzh/AXXcl3eEI+/nbvWxmc6VfTpMQW0JW96m
         UmwJ3vH9hcjVULVGvADg+B5qCdhh2McCvV5zCPWB7WlyOgmv0uCsTuZoryF8+6LxzJTm
         FyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkOWTui2hC+9kwtHu38fIQtyNnF+RVP4eJ39ZcZJrqZ1fyEYoxD2gV2Yfvn5xNWBBNBFCp/AuYZn/J8DmanmpoQtBgH18fcStifJyk
X-Gm-Message-State: AOJu0Yx6GyHcTOS3r0mqfZfRUfMG/9ZGeYm6LLi4eA9vFvSQA7/vFCyj
	e2R2QBFwdGM01dW9c3JAMEaF/5jPhLa/4aDVi51KJczyg7/ygdmGLfPKbWhb
X-Google-Smtp-Source: AGHT+IESB0mW2h/K+hIcMqYziPmpTJHRpyy2uKpnUt5HUOHKIcZ4t1EaDg76kaOlpc2Ez1jbZZ9SZA==
X-Received: by 2002:a05:6830:911:b0:6dd:dd28:c711 with SMTP id v17-20020a056830091100b006dddd28c711mr469402ott.36.1708642613485;
        Thu, 22 Feb 2024 14:56:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm10991177pgs.4.2024.02.22.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:56:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.8-rc6
Date: Thu, 22 Feb 2024 14:56:51 -0800
Message-Id: <20240222225651.4078336-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.8-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc6

Thanks,
Guenter
------

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.8-rc6

for you to fetch changes up to d56e460e19ea8382f813eb489730248ec8d7eb73:

  hwmon: (nct6775) Fix access to temperature configuration registers (2024-02-21 13:56:33 -0800)

----------------------------------------------------------------
hwmon fixes for v6.8-rc6

Fix a global-out-of-bounds bug in nct6775 driver.

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (nct6775) Fix access to temperature configuration registers

 drivers/hwmon/nct6775-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

