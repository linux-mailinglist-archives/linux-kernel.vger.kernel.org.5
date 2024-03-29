Return-Path: <linux-kernel+bounces-125219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED1892267
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF9BB239B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D185924;
	Fri, 29 Mar 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYosX0aM"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223585653;
	Fri, 29 Mar 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731972; cv=none; b=aQFzBTiNhbArOeYD85aRd9eOtsh93pfgSFcizNTIIZik3PfkcFJg5VqnMOBRsYmhJzeZp1sPqb+++0hY8k8MCW47Lnrqce4Hl13qzMZUmJRSsvEbdOokEgofQ1nb7HTSdsuh61LScnv2hW2v6dt4VqSuLX6k4RqQnyjJxN9Y6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731972; c=relaxed/simple;
	bh=emN8HEbkvTibwNLYB6Ii61y7sBtWV3zGH2FxiaLNX+w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hFe2ZmJR2t2apaoep9G1wj1uWxuaaw425R+jGfEssnWc2vj4pZUJx0mixL0RW65gyqz4q3ZlHOly5VNyk3D62YI9fu7gIbWTv7y3IFQ8zPDhoz5mZEeUQKsye+MkUpiZzmBFqS0bjbK7MO232OvYIWx0b4GCE8IRn4lh12iL2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYosX0aM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d247e3c4so2088392e87.0;
        Fri, 29 Mar 2024 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711731968; x=1712336768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luX+DmUYYHFgxqblUqu9C7w+57DrptU0k/Sko1xxFeE=;
        b=NYosX0aMvLmAITV10ldLoqOFAbVYSJbVWmF4BXPu+NrlGkhnC6w4WRjBnyvZqlh5J/
         /1L4dcAFa9zHQXeM2KzakeycU1/LCylxaOsHQZRexQyGDuKBM8VGu7PBuljIdjDzMIIT
         o/ZwI3fPbUdUJI0xK20UX4jSdOXDErC9CD15+mbMT/oqYdpT+Pc8uGm5xVi6YIeO+oi7
         LG+tsGlu78Ro0z3hXU1659TNl84Ll4hyNNfxEB99Fhx4wNjL8cA1jggvVoqm5awhPe4E
         ry2o5Zeevfhm4LXlLCNl5UQKBpxI9/uFoW4usdKNSl/EbhDtSHqYR1upzCtD9Yj9k6fe
         mk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711731968; x=1712336768;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luX+DmUYYHFgxqblUqu9C7w+57DrptU0k/Sko1xxFeE=;
        b=HWp8wxbw5IyY1chtdenDy5mUPAp8ySfg+Yr0DuWGQOECx4hL2cLYvpqdqyJZ27RTtd
         gzk7G2c9I17KKIFpTcnV7rDh+KYZ8+txEm2Q+4No/+TWxKkY8RJrwP9Een0tkHiZkH4+
         aqdnJGsOQnxg8vNjXubtBXJEGvRvFd4opptm4sGgFMWDdsZuzvoVx/9vEd6izscGq6b/
         OaRIXz/M/UeovK8lnWjO5lSZ/Ghs6iAMtdjosn2FPzrLoIhRMkLUL1K0baH57yP8UzN+
         rQUSjks7ol8+PjQHnt6+/MG+aSxsD6h4yfD5/P3d+KFRt2YqJ8U8RUJu0ohKOd0xsVQp
         02sw==
X-Forwarded-Encrypted: i=1; AJvYcCVof4CEkovgOlCyKMSngW6ri297wE5gMLu0E3A63PV9O/mR730EgEvrUfOREfvXn0g7cfciOxqadldiy6rLrEchIRPAaKJxCyA1cQ==
X-Gm-Message-State: AOJu0YzYU+EdlqLSw5Hnt/Z+perH2owvoXU8BnmHDZqu7Oq5omhx8QFx
	ez7WxY5QBjKBs3dUO6CknzisCxBu3r6z3S6b1cOQ/mM6kGymYwR0Ad24wCBPL8a2pmqnJPo9RvR
	XK2UgwPjSJG2SIhnOh9khVvKHn4aXat4j7VM=
X-Google-Smtp-Source: AGHT+IFfNKPut6sAyzGL6pv19W8IpT0PI/HXYHvK/mSoTl/Yy2bxpum8EzbinPO0/ZNWjdrRMHaaOrF0K10f93fdHkU=
X-Received: by 2002:a19:8c48:0:b0:515:c17f:725c with SMTP id
 i8-20020a198c48000000b00515c17f725cmr2087032lfj.2.1711731967585; Fri, 29 Mar
 2024 10:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 29 Mar 2024 12:05:55 -0500
Message-ID: <CAH2r5msjPvJv9-aW016XACLRDQtW2JC9EDnDXbYYMz-wEObWqg@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc1-smb3-client-fixes

for you to fetch changes up to 8876a37277cb832e1861c35f8c661825179f73f5:

  cifs: Fix duplicate fscache cookie warnings (2024-03-27 12:04:06 -0500)

----------------------------------------------------------------
Two cifs.ko changesets
- Add missing trace point (noticed when debugging the recent mknod LSM
regression)
- fscache fix

The important password change (key rotation) fix is still being worked
so is not included.
----------------------------------------------------------------
David Howells (1):
      cifs: Fix duplicate fscache cookie warnings

Steve French (1):
      smb3: add trace event for mknod

 fs/smb/client/dir.c     |  7 +++++++
 fs/smb/client/fscache.c | 16 +++++++++++++++-
 fs/smb/client/inode.c   |  2 ++
 fs/smb/client/trace.h   |  4 +++-
 4 files changed, 27 insertions(+), 2 deletions(-)

-- 
Thanks,

Steve

