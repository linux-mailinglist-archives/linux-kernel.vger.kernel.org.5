Return-Path: <linux-kernel+bounces-100917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA4879F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38592825BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAE47796;
	Tue, 12 Mar 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IlqU9ob9"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F3546447
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285510; cv=none; b=cAaLU4/kIQR3GxWMykN0MO+XyCmRY8ZiXGT75YHwW8GPvNkZIaKu7r++lce6nMpAVBJT8iDNRXeeVTlH6wooxaED4iEXVCfQUrKmrCkjoqC3UmEfxZ+6HwB86vo8IEFkWlQjXFS9qLedI9SIp9znniMTu+e1YBy+zIeRNWZQIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285510; c=relaxed/simple;
	bh=q39NurgIHCOT4qDzjQ4+UPaZ8eobe8ngIwBFL/onrQs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=MAtNmj9mcLIi4bQA34KFzhX/rwkMR4novL9JVPYOjrB83Q/tkku/KC+8p3eqt/pOv2yAtsPsuF5sQwwQU9FS6WcqHLeznZWkyKRPu78HKLDyeyBOOFnQM851zsZ3+t71AiF7mdCEkpQbXFwldIl/gqhV8RKqmi3RPJc4SMwYjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IlqU9ob9; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a1fa3cf5eeso247657eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710285507; x=1710890307; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODZOS4ijNm0/2adr74Or0gSBtAKP6h+U6y8x5b0LRUw=;
        b=IlqU9ob9nM29aBlyNTRHy9g4eoFB1UXjTd5CcH0kwS0tDgDpscH07VWUjAUacgDGGQ
         NF+/VhNg8jgSKnGKzcHtO3MO6LtPOksacBYiokCTdAysJaAfU9QqONU6ZuiPfVSG9jhT
         vR6A7Lp3PO58Wdmh/AVlys0oNIzGuLjfwy8aZDrnKkomZ10qJ4J2Ln1YgMo2SPuFvA6e
         rokER93JPuXDLT51pKeZ3FYRjL2QT/OkUO6nw8YFRjxmsRVK9AHb4o3nwlhvQyr/Hu9f
         KUy1wq28cJ4aYsjIpGwMRvwAyjKlusW2AVxkL5eZW3rBNJLzfiSKSF52/QxeAm9KNtIi
         AXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285507; x=1710890307;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODZOS4ijNm0/2adr74Or0gSBtAKP6h+U6y8x5b0LRUw=;
        b=q7H4AqDcjvkZ8kVYIXXO2FU0hwfTORFJBJIVjIsnnj7UXf/7/brg0wE533BPAUkWQi
         UfW3d0iJeKWEBsuXIR7M4TOimknm9/unuhA85IR2vBpXqCMzJt383rdqEBcpgKzUfUE9
         hHxOsJYJ8HRhcv4+VEXSf+APe8IUGnTf7ApfLWI+RihLPVgTLjg3xc6lreQNZGFFnQjK
         zsWHzEI1+QqfzZQ1gA9E0R7amnxyihwYeK2PsiLfefUoSzdQSgMJzge8h3AQnoK8mCu/
         NLBXau7+Qyva5YrPdZ+5LJwMIoIqD/4zti9rTDcEXCHDIdsSMj6MBZtGIN2wt4uAF9DD
         rW8g==
X-Forwarded-Encrypted: i=1; AJvYcCVrQZat/PSmRFXVLSrDL+8+XPx1QV5xRPDCS13VgdX9TyuFZh4VnoeUUsgoa45F23PLpIt+c12Cj1Rdh3MN7mIpp4V1DHYmhu2eitib
X-Gm-Message-State: AOJu0Yyu8hptEY64T7Z/h4CreZ7VjSfMy4zhoYqvVw1Yu8ITRF1C9Oze
	YRUZvVdcROoa4SzPKerQhgwrkds6Tk5SPqJVtNH8WQwsq7qZpVju42XcNnCPYVGT0xIhiz9ncPw
	=
X-Google-Smtp-Source: AGHT+IE/A50saUIS2DU+jf2y6h4ZR3UoebNxqmu2cL/8eRDB6toXSOlnwm7IByHka4/goR5f3+ORAA==
X-Received: by 2002:a05:6808:a0b:b0:3c2:261c:7829 with SMTP id n11-20020a0568080a0b00b003c2261c7829mr4258326oij.52.1710285507128;
        Tue, 12 Mar 2024 16:18:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id dw15-20020a0562140a0f00b0069102f97e08sm554827qvb.97.2024.03.12.16.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 16:18:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 19:18:26 -0400
Message-ID: <f584f8da8096351cc7e941d0586b2fa3@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240312
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Linus,

There are a number of SELinux patches for the Linux v6.9 merge window,
but as you'll see there are really only a few notable changes:

- Continue the coding style/formatting fixup work

This is the bulk of the diffstat in this pull request, with the focus
this time around being the security/selinux/ss directory.  We've only
got a couple of files left to cleanup and once we're done with that
we can start enabling some automatic style verfication and introduce
tooling to help new folks format their code correctly.

- Don't restrict xattr copy-up when SELinux policy is not loaded

This helps systems that use overlayfs, or similar filesystems,
preserve their SELinux labels during early boot when the SELinux
policy has yet to be loaded.

- Reduce the work we do during inode initialization time

This isn't likely to show up in any benchmark results, but we removed
an unnecessary SELinux object class lookup/calculation during inode
initialization.

- Correct the return values in selinux_socket_getpeersec_dgram()

We had some inconsistencies with respect to our return values across
selinux_socket_getpeersec_dgram() and selinux_socket_getpeersec_stream().
This pull request provides a more uniform set of error codes across
the two functions and should help make it easier for users to identify
the source of a failure.

Please merge when you have the chance,
-Paul

--
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240312

for you to fetch changes up to a1fc79343abbdc5bebb80c2a9032063442df8b59:

  selinux: fix style issues in security/selinux/ss/symtab.c
    (2024-02-23 17:26:09 -0500)

----------------------------------------------------------------
selinux/stable-6.9 PR 20240312

----------------------------------------------------------------
David Disseldorp (1):
      selinux: only filter copy-up xattrs following initialization

Paul Moore (23):
      selinux: reduce the object class calculations at inode init time
      selinux: correct return values in selinux_socket_getpeersec_dgram()
      selinux: fix style issues in security/selinux/ss/avtab.h
      selinux: fix style issues in security/selinux/ss/avtab.c
      selinux: fix style issues in security/selinux/ss/conditional.h
      selinux: fix style issues in security/selinux/ss/conditional.c
      selinux: fix style issues in security/selinux/ss/constraint.h
      selinux: fix style issues in security/selinux/ss/context.h
      selinux: fix style issues in security/selinux/ss/context.h
      selinux: fix style issues in security/selinux/ss/ebitmap.h
      selinux: fix style issues in security/selinux/ss/ebitmap.c
      selinux: fix style issues in security/selinux/ss/hashtab.h
      selinux: fix style issues in security/selinux/ss/hashtab.c
      selinux: fix style issues in security/selinux/ss/mls.h
      selinux: fix style issues in security/selinux/ss/mls.c
      selinux: fix style issues in security/selinux/ss/mls_types.h
      selinux: fix style issues in security/selinux/ss/policydb.h
      selinux: fix style issues in security/selinux/ss/policydb.c
      selinux: fix style issues in security/selinux/ss/services.h
      selinux: fix style issues in security/selinux/ss/sidtab.h
      selinux: fix style issues in security/selinux/ss/sidtab.c
      selinux: fix style issues in security/selinux/ss/symtab.h
      selinux: fix style issues in security/selinux/ss/symtab.c

 security/selinux/hooks.c          |  28 +--
 security/selinux/ss/avtab.c       | 105 +++++-----
 security/selinux/ss/avtab.h       |  74 +++----
 security/selinux/ss/conditional.c |  68 ++++---
 security/selinux/ss/conditional.h |  23 ++-
 security/selinux/ss/constraint.h  |  61 +++---
 security/selinux/ss/context.c     |   2 +-
 security/selinux/ss/context.h     |  41 ++--
 security/selinux/ss/ebitmap.c     |  56 +++---
 security/selinux/ss/ebitmap.h     |  42 ++--
 security/selinux/ss/hashtab.c     |  23 ++-
 security/selinux/ss/hashtab.h     |  35 ++--
 security/selinux/ss/mls.c         |  83 ++++----
 security/selinux/ss/mls.h         |  58 ++----
 security/selinux/ss/mls_types.h   |  32 +--
 security/selinux/ss/policydb.c    | 405 ++++++++++++++++++++------------------
 security/selinux/ss/policydb.h    | 192 +++++++++---------
 security/selinux/ss/services.h    |   3 +-
 security/selinux/ss/sidtab.c      |  69 ++++---
 security/selinux/ss/sidtab.h      |  36 ++--
 security/selinux/ss/symtab.c      |   4 +-
 security/selinux/ss/symtab.h      |   9 +-
 22 files changed, 721 insertions(+), 728 deletions(-)

--
paul-moore.com

