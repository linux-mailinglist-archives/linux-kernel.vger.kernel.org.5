Return-Path: <linux-kernel+bounces-132370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413098993B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4511F22ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96B1A26E;
	Fri,  5 Apr 2024 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwguyhA0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EF134A9;
	Fri,  5 Apr 2024 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286931; cv=none; b=uWQaNB4qWR8pK5i8Wqse3XT5RIQbWes8gMl3pKaDP90ykm+CljOxPAiSWuuBo8GZMPTOZSGcmX/7ic29uhRhF8Y1MdGEQ+HCHc/goi8EiXJTzGQXfJz1iNlzcZMttS8fPzVNwYaWPmFgRux1764ukss4uS+1a+7VFka8NPspPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286931; c=relaxed/simple;
	bh=nAVbPlUqGAsTQ3HFoJUiyqLIjkDI7SXCM1ieLBgGMPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ci9QvFk1IIZ/FMe/sYiHaEMFt1WjsmYQf2GoKRsVcAMrvZIIKlExk03e3VJTiCniSV/MOzsEhHrYDwSe1iu4ecxQ03Z5bReHdSa0S4zXSjtVvKj+zruv+0b90u+yev7tknQcWa4W5yWoVGeTcYnSrltm2QqdHl42ZOM8+eH8Oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwguyhA0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso1793511e87.2;
        Thu, 04 Apr 2024 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712286928; x=1712891728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91czYunPWBLhPDn+zFcXed9eaGbL99qvQu+dhQ8//8w=;
        b=GwguyhA08bOCvnVBDrXC95JMeLvaxulpe2cqamF71EazJnEkQGSXwRBf8HL/NL10ng
         1wQjsr0RKKXyuODw3KH5byPH7ItzyLdDgBsClMftqWP7I1Zyw6YHvRADCfTTROEpqlgq
         HZC1kpmoaZxjlBfQH8N/CtjeF/yRnN0Z2FDRPlrVaYM6f82Xjhjlk6/NSiyPOkMNnV/r
         2fkYIvTCtBnC+e6JWHITmxsXhtXA4ymY17nf4GG3lWHgcTt9IFIc6MkFVuWpU/VyVjYo
         aebDtjtPY2OCtDnQftFlC9qwsXpl/7jcUGWMwAPCJLFe9Mpn2Wy2du9s9oT9a6F6EofP
         aWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712286928; x=1712891728;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91czYunPWBLhPDn+zFcXed9eaGbL99qvQu+dhQ8//8w=;
        b=C5x9PlQ+Thjy1CfEdEPJnxzvsy1NTytBZ9w+Ul+VyEjgvEgwddBkAXNHZqqWSh156+
         WVXAn3vjQHRneq7Hpic0Iu/pZm79GyTyaj88lALsNQXdWb2LPbGGMGKA2ZZzqQAe3bwp
         SxYOCmD2nizNnJF0ce4SHotMtRbCukah0aZDEJFQhh7Qbw3+hav62oYprI88h/efO7jf
         QHc6HjIz29yeYHNvKl0VvVNTBtuSRzgLAMxzIcEvbGcyyzoPG40kbOzJ2zmha1NwH4AZ
         tV2rGYqvTC8mcwOCbCTnzoAJocDNLqQ55JbR853knzLnqupXIbH8V/ORwcv5bwSLa2lW
         fidQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkpvMx0x+mzUr1DIiYs1Cd90JNJJthAJBIpVRuLSDeZ+Nl4gMnOwqtNoxgBTANO9dzaL1wqi5Vb7+OkuJ06UAEHeApcDQWcqaq8g==
X-Gm-Message-State: AOJu0YzGjl299ySoABR2wte385ieARiNiHhMJnIU/bxsG592vPLShJF5
	KFv3mHKp+6PhaAWF/0q+Do/vqDHEKiHUxZrY0mflr4luHuEfS/UInjzvUW5tJcPsstc+iJXlC0m
	gQtihhDewGaXQjaRafy70VZEFXdU=
X-Google-Smtp-Source: AGHT+IGEIAc02Mac6DkbCdONkjMZ0vUx+x5/w5UhzScwv2QpxamdJvCwLId/8vK54e3JC46bhphbg4crXDPY82V5VZk=
X-Received: by 2002:a05:6512:2387:b0:513:de8d:203c with SMTP id
 c7-20020a056512238700b00513de8d203cmr151803lfv.28.1712286927823; Thu, 04 Apr
 2024 20:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 4 Apr 2024 22:15:16 -0500
Message-ID: <CAH2r5mtksWKZNn7WmHGT4t9fi6duL_nuTgdMwrx9c2gqw899YQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.9-rc2-ksmbd-server-fixes

for you to fetch changes up to 5ed11af19e56f0434ce0959376d136005745a936:

  ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
(2024-04-02 09:21:25 -0500)

----------------------------------------------------------------
3 ksmbd changesets, all also for stable
- encryption fix
- memory overrun fix
- oplock break fix
----------------------------------------------------------------
Namjae Jeon (3):
      ksmbd: don't send oplock break if rename fails
      ksmbd: validate payload size in ipc response
      ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

 fs/smb/server/ksmbd_netlink.h     |  3 ++-
 fs/smb/server/mgmt/share_config.c |  7 ++++++-
 fs/smb/server/smb2ops.c           | 10 +++++-----
 fs/smb/server/smb2pdu.c           |  3 ++-
 fs/smb/server/transport_ipc.c     | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 8 deletions(-)


-- 
Thanks,

Steve

