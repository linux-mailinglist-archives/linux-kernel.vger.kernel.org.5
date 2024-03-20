Return-Path: <linux-kernel+bounces-109203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB1E88161E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BA1C22349
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C369E16;
	Wed, 20 Mar 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB12JCYv"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5969E0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954429; cv=none; b=O0xMC/iQnivLLHUU1jibJtAdfABECPver6iuDlt7QzG/rr027Vt+M2TbKckSqnksS/7cu944+04vI5x3qfqevYLxPgptgCiOS39G9ulpbQg08zuHmUeOeLkoXGHShHaEiWC7h2zqRuY50EKclyX2CogSaMps7ikR/ejR0JvIBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954429; c=relaxed/simple;
	bh=S9HoGsZhuXTXpMv45bUaideIMkuI7ajIyTOpNXFqcgg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=diWn5B0yrMqDKlM5KBFuGnl1gHHIEpEkh04wSNN0C9Cjt6uXxmyOpIynad5s+83MtMyM2RP0fPdZBujkjvI8tyD0fsnbwWHa4N962rEhi46H5avV2M3I2Q0t+g8gJ4q/EY5l6OvmOWC3V2M1J7kCXG+kAHkMRwwhNb8ROzLqg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB12JCYv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so1845291fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954426; x=1711559226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dauDd7p4nihuYem3p7oKL3fbGPFzYZoE9wtIVNIfXUM=;
        b=UB12JCYvx5yHZeoOALsCl49r82le/7nhXLpf4gv7ZEOX7AoWijxiN2tQ8Aq2HvNVPy
         B8rjQZXT9ITJC0x6CRY78dpiELNEGE5gccjtxw+HU4ASMHlOrL0H+z4heydGtmlNXGmP
         VHM0fx+oDXA4MC0/2MY9AQtipXaqHggySe/X/9kJ0J+L3WSBIHv34EaeR7LDyJR5DzYs
         dQoMNv9XZU2fv2XwuB5TlCcXlDl2xzTDAaK2GldxgnJEyjXSCSeKJdEedAHBpa3xqqKm
         9iieKj2XrPdJnk2bI90ieS0b5dB5pDqdcOEXnZqNTUQybVyEb7nsxtG95D6Z/NQHt3Yj
         CGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954426; x=1711559226;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dauDd7p4nihuYem3p7oKL3fbGPFzYZoE9wtIVNIfXUM=;
        b=IBsbIQpWF8lG/wTdwYJrvEQ3EtPQrJ94JOvtpKyFubOD3qrkBqbKXH9jObZHxFsqVB
         HzpMGU0KMm4I/2WP8T1hqDAxuE44X4pi6H3HzLVa7PwrhAMEh+55dBHc0/suFXtE1QZv
         jfgZGXBnEBjlNJdgMgo0WavPLkB8UEgyEBvZoQOaZ3JZiptmPqqEVwuEsxwIcrYieeMX
         XfxLNbZoDEwICpRtwSeSNH6I8eAIzCmVXJwX78jimkZ0vWkGa8iUxJnp0uIwZuH5knGH
         HwfoRUA7oMFNrWA+QH5X1zMXEE35oxeN01xknYJr2TMQb4lk5/m5WD3pWDHO8tf8J8yS
         ehxg==
X-Gm-Message-State: AOJu0YyZoeWQXb1Ew58kQmrGe/GrUeRJeCZhD9Z38ITcfpDdfftHPkuB
	YRLnQ0bC3qPeKoSWZCxT5u/ISp4IIZ9OMLgmlVFqoBa6NlaHpNop8bTLMsKUMaQk1+wr/FsBlY6
	momyNcY4HaySWVXXhTGlux3IicbYFnk0dxkA41g==
X-Google-Smtp-Source: AGHT+IG83UymRNC+OdCOB6w0QG6zsyWkOzymCrP8gihG/UnBd8vGhA7VCP+BMkGdTpv0nsWd7lP357Wx3ZwqAUz36yc=
X-Received: by 2002:a05:6512:3e1e:b0:513:4fb4:5388 with SMTP id
 i30-20020a0565123e1e00b005134fb45388mr16007797lfv.41.1710954425409; Wed, 20
 Mar 2024 10:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 20 Mar 2024 12:06:54 -0500
Message-ID: <CAH2r5mtyoxmUyhmD-RA0TzAvsanU2VaCRi=OpTqCVjzdv0QykA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.9-rc-smb3-server-fixes

for you to fetch changes up to def30e72d8abaf68da10682767e584519c234c4c:

  ksmbd: remove module version (2024-03-18 21:21:38 -0500)

----------------------------------------------------------------
Nine ksmbd server changesets:
- Two patches that add support for durable file handles (an important
data integrity feature)
- Fixes for two potential out of bounds issues
- FIx possible null dereference in close
- Two getattr fixes
- Trivial typo fix and a minor cleanup fix
----------------------------------------------------------------
Colin Ian King (1):
      ksmbd: Fix spelling mistake "connction" -> "connection"

Marios Makassikis (3):
      ksmbd: replace generic_fillattr with vfs_getattr
      ksmbd: retrieve number of blocks using vfs_getattr in
set_file_allocation_info
      ksmbd: fix possible null-deref in smb_lazy_parent_lease_break_close

Namjae Jeon (5):
      ksmbd: mark SMB2_SESSION_EXPIRED to session when destroying
previous session
      ksmbd: add support for durable handles v1/v2
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
      ksmbd: fix potencial out-of-bounds when buffer offset is invalid
      ksmbd: remove module version

 fs/smb/server/glob.h              |   2 -
 fs/smb/server/ksmbd_netlink.h     |   1 +
 fs/smb/server/mgmt/user_session.c |  28 ++-
 fs/smb/server/mgmt/user_session.h |   3 +
 fs/smb/server/oplock.c            |  96 +++++++--
 fs/smb/server/oplock.h            |   7 +-
 fs/smb/server/server.c            |   1 -
 fs/smb/server/smb2misc.c          |  26 ++-
 fs/smb/server/smb2ops.c           |   6 +
 fs/smb/server/smb2pdu.c           | 509
++++++++++++++++++++++++++++++++++++----------
 fs/smb/server/smb2pdu.h           |  15 ++
 fs/smb/server/smb_common.c        |  11 +-
 fs/smb/server/vfs.c               |  12 +-
 fs/smb/server/vfs_cache.c         | 137 ++++++++++++-
 fs/smb/server/vfs_cache.h         |   9 +
 15 files changed, 716 insertions(+), 147 deletions(-)

-- 
Thanks,

Steve

