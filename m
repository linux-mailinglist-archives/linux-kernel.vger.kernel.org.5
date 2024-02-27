Return-Path: <linux-kernel+bounces-83778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E2869E75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F2DB285AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3A146015;
	Tue, 27 Feb 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh2sfoJc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B647A7D;
	Tue, 27 Feb 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056505; cv=none; b=FE/nK1+AAF57rcSVD6a4VkwVFli50v11cq3HgRHW3Tk0u/rNXb4+k8gU2LorgLRSSsRnyon24GHvZE+qgWfP0qZsoS/TLFHVTWLpkkI6W7YYihnrgL4tdNOFNWQEZX1Ocy0BTzWSxweomAuVRvD+dRquT/2mENcy2rECt2aLxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056505; c=relaxed/simple;
	bh=zkHeXCzhJoTyI/FQbYLjcD03+FpKcFDmBTJgvQ0BPN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOptGPqEmy0qv9/IyDV9HxIn5VoSnflRV9sxcFAZylJm5cL2XkromEHbNywiSSHI1wjgRkXNxqfN7Y5C5algIUBZHcakM6YB5JVXi7t4bVV4dwL+n14VEMedQCDPNGUUqIMsh0L6m5M2wd7NBy89GUD7pYflJ+qwahG8iWItGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh2sfoJc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51316d6e026so418606e87.1;
        Tue, 27 Feb 2024 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056501; x=1709661301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9hsMkWNb2m0rp9UNDMRhCeKg3qiWH6hyTt28k7IemM=;
        b=Fh2sfoJcd+657bxWtaNIZ61N6cZFfCyI58WZpCOcHiaurR5j1Q9mKWfPG/hAI/mxYF
         hVqFgVX0sWcIeZrvHXPlzlgK1JqLlN7X3GU8KBQ2NGYpLgclD80thnmNLznFG1s3x9NO
         G2GhYwH4u8Q/V8gTtecl/E1nrxVAV4eUFlkUPpCmfMEcC+eIA/bFo63GQritYHKDAZp6
         KsLVP5KFZzP+VNAdQiN5nneDNGEU1kYcMSq7w91zvCKzfFsXzUVBqPT6pt26KOAi/0PS
         1e4EaNZ42RM+XL4B+Mno62ETgqhS6SJRmhopI3JdS1d5ELSULR+a/5n4BXShDCDQHS7m
         qR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056501; x=1709661301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9hsMkWNb2m0rp9UNDMRhCeKg3qiWH6hyTt28k7IemM=;
        b=JBOW3vTJgzeetteBxfjqvQCd2K2VSe3brX/nCTWNAwTBd6N9eKzbBlxkcXmTxUieDJ
         GJZKavAPWHvLi2CCXj6MPsuzFXQ0nWsZVlVJ5f1dZ/3WodtkuwLfn1voSDuXbabGUr1B
         pOkqxc1UhnBC51i4JbA+oGb/OspYiCU0G8bGQzHNWT30654A9Z9RvlaWqAca5+1Z2S96
         Nd2WEYMptxx3wVzTuz4Q8Ymw01v3CcfiaGZV9JpOMHyhMVPv000gQITomw+5BOw5Y1bB
         vFySrFzEe7W5Uuvl8JKDARAuzunfgwlC6SjAx2LAM1RtPOf4TAjFRWFJUTO8l9sJe9X2
         Vg9g==
X-Forwarded-Encrypted: i=1; AJvYcCWUipYjpnJJxO3vWGsWIzGZdqL32pjGR+zBk4K/YFR1uPRrPRxGCyxvDr3CAQJn24GdhxWYwE13u1r7FXOsPYIXFIflKHXuxPK6imyfnBw18q/mdapA8Nd+OgrVATFdFo7tB/hH
X-Gm-Message-State: AOJu0YyeqVScHGQtpYWHn6l3OVIkt1co+Kddqd53i4T5sCbfz8vVa1zt
	ohl6FF2GH1pgIkR5mXRbk+S0vo7a7hdI8wONFkNWk8ex5eaLeCTf
X-Google-Smtp-Source: AGHT+IE9dhxZ7ad7wfRmMxANudUUQrig4adMJrYPDJkbazV5NXI+e4sfi5Ck2+XlSy3hUSZonquYYQ==
X-Received: by 2002:a05:6512:3da9:b0:512:aa52:5cce with SMTP id k41-20020a0565123da900b00512aa525ccemr8531310lfv.12.1709056500906;
        Tue, 27 Feb 2024 09:55:00 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id fd1-20020a056402388100b00566439b97c4sm629268edb.44.2024.02.27.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:54:59 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: add Amethyst specific SMI GPIO function
Date: Tue, 27 Feb 2024 18:54:20 +0100
Message-ID: <20240227175457.2766628-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amethyst family (MV88E6191X/6193X/6393X) has a simplified SMI GPIO setting
via the Scratch and Misc register so it requires family specific function.

In the v1 review, Andrew pointed out that it would make sense to rename the
existing mv88e6xxx_g2_scratch_gpio_set_smi as it only works on the MV6390
family.

Changes in v2:
* Add rename of mv88e6xxx_g2_scratch_gpio_set_smi to
mv88e6390_g2_scratch_gpio_set_smi

Robert Marko (2):
  net: dsa: mv88e6xxx: rename mv88e6xxx_g2_scratch_gpio_set_smi
  net: dsa: mv88e6xxx: add Amethyst specific SMI GPIO function

 drivers/net/dsa/mv88e6xxx/chip.c            |  5 ++-
 drivers/net/dsa/mv88e6xxx/global2.h         |  4 ++-
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 35 +++++++++++++++++++--
 3 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.43.2


