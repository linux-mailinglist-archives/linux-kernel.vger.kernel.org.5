Return-Path: <linux-kernel+bounces-123014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA2E890114
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BCF2994F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F948288F;
	Thu, 28 Mar 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSIBj/z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B553D387;
	Thu, 28 Mar 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634730; cv=none; b=E+zMxlSPbsuLL5OX4zUG0+FOsWMO86pY6EujB3kXagcw414q2UQIfnV31G4nEc5yAbkl1JmEZ4imlljV4mknjnWMZfYOcSuqnfM7F+myMfUNTOEm5iuvgAFTpwtuTf31gGqpfm1HHyotu9gzH3XVhNbmoBKRNNUS213hb43wEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634730; c=relaxed/simple;
	bh=DyPPajVzJsQEhnad3V3XmULXNURr7x/hE7W3jpIhYHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1a6ueWB4BUtbTRLzwtIjeug+VyHDG5UvL6xj82XS3hDxWFktUwbUaDjZl9Et6JwybgAUsRJsAjk0v9MvoWyGQDGLy7CEWC9Ici3a8Ky4RoLSqETaGrAV1orI3/WIM8p1zEUNU4SRHIAsa3ird99hlqbDdDbM0KOw+LJvSxKRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSIBj/z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2767DC433F1;
	Thu, 28 Mar 2024 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634730;
	bh=DyPPajVzJsQEhnad3V3XmULXNURr7x/hE7W3jpIhYHU=;
	h=From:To:Cc:Subject:Date:From;
	b=YSIBj/z8FiuLEgDqBHCsbNl9cmMUDFKkjhDyPYeuiZwdnRhaWzQB1qy5bUc+cEoyn
	 TgUgizmrgNHaRrJXrUOrR+GdgNy6Jcz8XE1oOPfSpaFhiEmf4RgxaXmRRkMfBs3XvJ
	 Wdamgkwsoalajey9FhYVrBXHHnDc3hfmz1/sXLzA38s+j7m8rRsVIbogv2merkfHvl
	 7NGUhSAkFPNi5a9tOFYSVMmfUJIhgs6J2mztKYfkmZfdJyHIxoNs7A5AsNpAjEutO0
	 MTG5hno3yJ9IL2S3wchli/Txbu6/jMN5FjWKlXiRfuxNfq/iu1yN/a5CzMTTL577iG
	 hodYTkkA1QuNg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	Alexey Starikovskiy <astarikovskiy@suse.de>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devel@lists.orangefs.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 00/11] address remaining stringop-truncation warnings
Date: Thu, 28 Mar 2024 15:04:44 +0100
Message-Id: <20240328140512.4148825-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

We are close to being able to turn on -Wstringop-truncation
unconditionally instead of only at the 'make W=1' level, these ten
warnings are all that I saw in randconfig testing across compiler versions
on arm, arm64 and x86.

The final patch is only there for reference at the moment, I hope
we can merge the other ones through the subsystem trees first,
as there are no dependencies between them.

     Arnd

Arnd Bergmann (11):
  staging: vc04_services: changen strncpy() to strscpy_pad()
  scsi: devinfo: rework scsi_strcpy_devinfo()
  staging: replace weird strncpy() with memcpy()
  orangefs: convert strncpy() to strscpy()
  test_hexdump: avoid string truncation warning
  acpi: avoid warning for truncated string copy
  block/partitions/ldm: convert strncpy() to strscpy()
  blktrace: convert strncpy() to strscpy_pad()
  staging: rtl8723bs: convert strncpy to strscpy
  staging: greybus: change strncpy() to strscpy()
  kbuild: enable -Wstringop-truncation globally

 block/partitions/ldm.c                        |  6 ++--
 drivers/acpi/acpica/tbfind.c                  | 19 +++++------
 drivers/scsi/scsi_devinfo.c                   | 30 +++++++++++------
 drivers/staging/greybus/fw-management.c       |  4 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  5 ++-
 drivers/staging/rts5208/rtsx_scsi.c           |  2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  4 +--
 fs/orangefs/dcache.c                          |  4 +--
 fs/orangefs/namei.c                           | 33 +++++++++----------
 fs/orangefs/super.c                           | 16 ++++-----
 kernel/trace/blktrace.c                       |  3 +-
 lib/test_hexdump.c                            |  2 +-
 scripts/Makefile.extrawarn                    |  1 -
 13 files changed, 64 insertions(+), 65 deletions(-)

-- 
2.39.2

Cc: "Richard Russon
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devel@lists.orangefs.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org


