Return-Path: <linux-kernel+bounces-158979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A98B27B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D32B23DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D614EC5C;
	Thu, 25 Apr 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm2h3KA6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353C14D717;
	Thu, 25 Apr 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067163; cv=none; b=FKa2hChUm+IRNjfJfkHRf8Xy6sEgbyuDvz5ewAm6dsYEynPPQyieJzY2O3j/XzRCucLm5zO72fDeyZX3dgjSk+Ida+F+IQWiofVP7P3hVWsLkUUauJ+MMrxizcMgr0O+7wK0V5g3thKaZF7FCPK9gBdf3W+m8tAydt1CXq5WRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067163; c=relaxed/simple;
	bh=u6VHbUgWvnhPzuiFRQi98TDJ5VvKfyf8jXNG9LpvSfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=esys6tzNqwvxp/tlaF5stZNlAssAxc+nZETDBzle/3eY/0EDsGqlpYkDChTtjT2D28xFv8JrLK/CScM8V0XeepFst6h1haD2eJoLjNtXd8HBZU0RZB+M9tZ75IBt8dXMEyntTZfvRMBQAyMBdhW1jLUz7w9HXlPkKUj3Ct2RSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm2h3KA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F085C113CC;
	Thu, 25 Apr 2024 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714067162;
	bh=u6VHbUgWvnhPzuiFRQi98TDJ5VvKfyf8jXNG9LpvSfk=;
	h=From:Date:Subject:To:Cc:From;
	b=lm2h3KA6eG7H6aTF+EDN+6I5AvJMFwua4IrDnXM/AiX2a++dLRWj+4cLoZZo/BWFK
	 ORlrdMR4QRSwQcfPVpYgnPd88pRmSXWMh4z9I4eG30Cl4uZA0elkggC7TKnp/DedPw
	 Ffo0qMglbuQw9EOkalxpTLDwB1qdfcAflg93P92dllXmVPlyIbmvfuvCq7snV5I/XL
	 yd+tJOIYYcvOvLgJa8si4O3OcX5W9DqYbvJXGvOYNz9vNHqbL4ADTQLHFgmRXrYq44
	 v0uZvW5+IWreNxR96oxn/ftKB7NTw1HUZmvuThWtk3AL3cXw2Tan2KZevN+lJQKJ+L
	 iD518n9PePSuw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ac970dded6so324714eaf.0;
        Thu, 25 Apr 2024 10:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPZBIqm86Nh+RROAG6X4ifEk2mp8t+Ki/HXxoAK4z/vRtjgRlf7hkDJro8RzXgY4Reulk7fp1FPued5KrrmWj2t8xGq1zcYaNV+Wsb4tJphkug2ckxxSk6N1HD9aHvHegZgAwShDQ=
X-Gm-Message-State: AOJu0YwPi/LnYjqfPIZ+xkLMJuCtT6exXqCuAOqxXKqVbx6skFOzvfqF
	2NOQy8MppyiEvdVT3fDcVtbgLuEivRXP07+gLRm1G7kiknCcYJ0GJ/V9JWxZ/pLkuz6Y+To8R1O
	qjyhKyO1cjWV6Q8I93BwvrfvHYRQ=
X-Google-Smtp-Source: AGHT+IGPajutv1KqTb4cDGtBjIo9HYS6TkwwfhsJ6bmXS7u4fTNJDVzpSMpWTqlnm6R6e9kA4jqZO5Rwhr+dhO6715s=
X-Received: by 2002:a4a:d247:0:b0:5aa:6b2e:36f0 with SMTP id
 e7-20020a4ad247000000b005aa6b2e36f0mr575585oos.0.1714067161748; Thu, 25 Apr
 2024 10:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2024 19:45:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
Message-ID: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.9-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.9-rc6

with top-most commit 2ad984673beef7c3dbe9e3d2cabf046f338fdffc

 Merge branch 'acpi-cppc'

on top of commit ed30a4a51bb196781c8058073ea720133a65596f

 Linux 6.9-rc5

to receive ACPI fixes for 6.9-rc6.

These fix three recent regressions, one introduced while enabling a new
platform firmware feature for power management, and two introduced by
a recent CPPC library update.

Specifics:

 - Allow two overlapping Low-Power S0 Idle _DSM function sets to be used
   at the same time (Rafael Wysocki).

 - Fix bit offset computation in MASK_VAL() macro used for applying
   a bitmask to a new CPPC register value (Jarred White).

 - Fix access width field usage for PCC registers in CPPC (Vanshidhar
   Konda).

Thanks!


---------------

Jarred White (1):
      ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Rafael J. Wysocki (1):
      ACPI: PM: s2idle: Evaluate all Low-Power S0 Idle _DSM functions

Vanshidhar Konda (1):
      ACPI: CPPC: Fix access width used for PCC registers

---------------

 drivers/acpi/cppc_acpi.c  | 57 ++++++++++++++++++++++++++++++++---------------
 drivers/acpi/x86/s2idle.c |  8 +++----
 2 files changed, 42 insertions(+), 23 deletions(-)

