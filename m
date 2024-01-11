Return-Path: <linux-kernel+bounces-23627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A782AF57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB5B22122
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7EE16404;
	Thu, 11 Jan 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSZjIf9E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609F15E96;
	Thu, 11 Jan 2024 13:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5064C43390;
	Thu, 11 Jan 2024 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979063;
	bh=RYqKMbpjBidzOlx6lTN2kCw5Q/l3CzHQ4m76Yj5HwPg=;
	h=From:To:Cc:Subject:Date:From;
	b=RSZjIf9E2W4q5LKDYPH3GimlYPp2ZLobrWHdSrqIzAAcPh3NJYlTXIkL8SUCbC8Ig
	 4NyjNGboBTdA9cFE+G7/uYzRDXePcjXS7naKXwMAewmN1fHUjrxoHkECpMqUZds6Jg
	 cDtJDpUmR7L4ftGvoSHODdNH4q0eYrroago1EMTN8ewn+xL5Uqy1qDj6KUgVf2IA6l
	 zR1RB1sxBRm3dJV9uNtEcM2FUrQrknVwr08I1Xpvp/4oOf3hBbEDjLHEGk2RrfIIsA
	 tiI+HhUSntapJk1AstH5zaaQdzewQQlqwrg/IvhgxrMvIMauAXBTuC4QyVIvMyiNVb
	 i91WlaT7J2p4A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Andre Hedrick <andre@suse.com>,
	de Melo <acme@conectiva.com.br>,
	Joel Jacobson <linux@3ware.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	Richard Hirst <rhirst@linuxcare.com>
Subject: [PATCH 0/5] scsi: Replace {v}snprintf() variants with safer alternatives
Date: Thu, 11 Jan 2024 13:17:21 +0000
Message-ID: <20240111131732.1815560-1-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a far better description of the problem than I could author, see
Jon's write-up on LWN [1] and/or Alex's on the Kernel Self Protection
Project [1].

[0] https://lwn.net/Articles/69419/
[1] https://github.com/KSPP/linux/issues/105

Lee Jones (5):
  scsi: 3w-9xxx: Remove snprintf() from sysfs call-backs and replace
    with sysfs_emit()
  scsi: 3w-sas: Remove snprintf() from sysfs call-backs and replace with
    sysfs_emit()
  scsi: 3w-xxxx: Remove snprintf() from sysfs call-backs and replace
    with sysfs_emit()
  scsi: 53c700: Remove snprintf() from sysfs call-backs and replace with
    sysfs_emit()
  scsi: aacraid: aachba: Replace snprintf() with the safer scnprintf()
    variant

 drivers/scsi/3w-9xxx.c        |  44 +++++++-------
 drivers/scsi/3w-sas.c         |  36 ++++++------
 drivers/scsi/3w-xxxx.c        |  46 +++++++--------
 drivers/scsi/53c700.c         | 104 +++++++++++++++++-----------------
 drivers/scsi/aacraid/aachba.c |   6 +-
 5 files changed, 118 insertions(+), 118 deletions(-)

Cc: Adam Radford <aradford@gmail.com>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: Andre Hedrick <andre@suse.com>
Cc: de Melo <acme@conectiva.com.br>
Cc: Joel Jacobson <linux@3ware.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: Richard Hirst <rhirst@linuxcare.com>
-- 
2.43.0.275.g3460e3d667-goog


