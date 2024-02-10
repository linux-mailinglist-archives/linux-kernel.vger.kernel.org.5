Return-Path: <linux-kernel+bounces-60193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADD85013E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED27328ADC9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BD5231;
	Sat, 10 Feb 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PczHgql1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1146B7;
	Sat, 10 Feb 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525208; cv=none; b=lQleoQFAuh+zaJi/1ThgBNRyIROWyG+THe7TaAp5iX1z/owdPhvJhA/NZVfZuDj2fgXvgy+gO0oJ8hsSjMbAQ5pjxI9tqaGVK7Vtr5i7qU4U5kf1Na8yzyK9kIJapSaE7r19OL7fcP4QawonP1ElH0gbM1bkABYeuKMDo5TkZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525208; c=relaxed/simple;
	bh=uPqddtDeveMUR9lDQdTvz4prZw9wnSAFOhZG+7wNXis=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IsCn3ghrjWqFFCUf7WjPt1lT/ZU4IyHETk22byD/xJwpzcNcLoMrLE2l9CQ5IHreijKk3wy1qe83IaCs25/rvayNlufnbnPuzyWjdH5bziX/yWkVO2k2nGbzwnaaiw+St8srFCJ0v2u9jZVHHu/9rwES8ZpDSIzNW7x/pHNKjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PczHgql1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0aabed735so20075981fa.0;
        Fri, 09 Feb 2024 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707525204; x=1708130004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVmXUIQ9UJWry6RwNVeR+t5g05HdWzy5ayEHtArp6E4=;
        b=PczHgql1WYRP1W4YRkQU4PG9o9J9LMNKYeo5yZRZZFlFf5cJfS1NPpFYQ7l17Jl9cM
         Y81ZIBpCLPoIPvBC0MBlN9KLiyHzu1Xu1Jb+yKIyJI9we+jK3axXe2sPyMZOLaPaPrfv
         7JtLBxQT50ik98tYAw3Rp2Dl3HaD4Rzvd9DBgy4f7NlSQEfK4DIhz6kewqd/o7BiooM6
         wy+HOAubTb7eZIPv2HIpZKUwNV5mITam/Uude4wgWjQOYfZOCeXXDenMASAqwM/jNt3p
         f5C9SS024pOxjmtRx1aD2B8G6/UGZH8PWAjXCasuAsSGDYzlQFUOz8DWXV97AymSrGIY
         jv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525204; x=1708130004;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVmXUIQ9UJWry6RwNVeR+t5g05HdWzy5ayEHtArp6E4=;
        b=UtkZl7x67IaSu2w4T15alDoIu0kf+32lBFi0Gu/o1OI6Dr66AsyhWvlYHpM4Bs2zKP
         /SmCKJSdNz6Hn3MYptdd6PmaAENmasSeFo1Bn3gsr8xX1Z0wy5hnnsBLKGbSd/Tl8G97
         mlacIaK1+2ijKGXb9BNxiduuf/ICcWvS11z7YXzi5Kw0QuTuZweaGgJcYoN0uG2DnfpF
         4xlBE0V9mYtxhc+/wRnIIT0AmTXtMrWydalALY9dfa1OYbiGcZ/E/5u6pJ2W9Wd70pUS
         m7XigWV9l+iBikrvWNfvEI3i+ld0r2QzJnJNiOKqvf39Vii8hauhOzupW5PjUh/6j/Xk
         BKAA==
X-Gm-Message-State: AOJu0Yx5nTR3thpUwxQq+m09t+i8ddGdP3NeoqklW6lnGoFTxcG64C+l
	ZGev2frs76NIx0EAUop3Uak7l7YfFnamPs5DtYOXh50tcP4QbZv5oZh5paYZXye2mS5/Ulfwwks
	qYyB1vy1aGmANV4AycYiHZCCj+NK5N4IcJg7U9w==
X-Google-Smtp-Source: AGHT+IF9ChRIDCiwt+wUBQq1Qzk+lA3hp0qHKPg7z08bb8ffql0BiLWOn16JSc21/uv6xvd2ibr19W975hs89La7Jfk=
X-Received: by 2002:a2e:9218:0:b0:2d0:c176:ebcc with SMTP id
 k24-20020a2e9218000000b002d0c176ebccmr393297ljg.18.1707525203824; Fri, 09 Feb
 2024 16:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 9 Feb 2024 18:33:12 -0600
Message-ID: <CAH2r5ms4uMTJ0V-eLhFcrpQe8f-LYYr-PLp8ixGyXwaWzjxH7w@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc3-smb3-client-fixes

for you to fetch changes up to a5cc98eba2592d6e3c5a4351319595ddde2a5901:

  smb3: clarify mount warning (2024-02-09 14:43:27 -0600)

----------------------------------------------------------------
Five smb3 client fixes
- reconnect fix
- multichannel channel selection fix
- minor mount warning fix
- reparse point fix
- null pointer check improvement

I removed from this P/R the workaround fix for the netfs/folio data
corruption bug (ie
simple patch to force cifs max write size to be set to a multiple of
PAGE_SIZE). This
bug is important to address. Although the netfs changes targeted for
6.9 fix this
they have other problems - so lean toward waiting a week more to see if we can
identify what in the folios code broke this before deciding whether to
send you the
workaround patch.
----------------------------------------------------------------
Paulo Alcantara (1):
      smb: client: set correct d_type for reparse points under DFS mounts

Shyam Prasad N (2):
      cifs: change tcon status when need_reconnect is set on it
      cifs: handle cases where multiple sessions share connection

Steve French (2):
      smb3: add missing null server pointer check
      smb3: clarify mount warning

 fs/smb/client/connect.c    | 11 +++++++++++
 fs/smb/client/dfs.c        |  7 ++++++-
 fs/smb/client/file.c       |  3 +++
 fs/smb/client/fs_context.c |  2 +-
 fs/smb/client/readdir.c    | 15 ++++++++-------
 fs/smb/client/sess.c       |  3 +--
 fs/smb/client/smb2pdu.c    |  6 ++++++
 7 files changed, 36 insertions(+), 11 deletions(-)

-- 
Thanks,

Steve

