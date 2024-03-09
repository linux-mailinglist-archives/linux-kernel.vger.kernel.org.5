Return-Path: <linux-kernel+bounces-97849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8229877075
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9591C20CF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF728E22;
	Sat,  9 Mar 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Y6hIV699"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F202C190
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980342; cv=none; b=VbhhdptQFfYeVUkpHik1caQld+o4GNeNIODpNx6nzA3y6Xcci3CySSV7+tfis6Iz93e7e0lFZl5uPTO2ivmfpJpfQsXYKuTHMzCcgUd0a47MJ1zVdfTi2pCRFKchj09V3ZaUu6NZTQv3nOPe75mK1zkw6lJq0ZH+vkvBFeJo788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980342; c=relaxed/simple;
	bh=DFcN3e/R6TGUqr+AzsRffrJlV3Th+IGA7Bc8vujPY+8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jfVWVSgwqgdNd7DUEgKpUJhDpVtevXFmcARRF177yenPJCCy5mvuRm/LGx6lzIQ1ILUejQelxy+Eek91BPe+tHEHk81aeEbqgAO8/wDRm7qIqpeXZ3YR72FknZuzq2O+3mO4WMRi26WE6Gyj8iT/0RVCNKD622J8wtjmn2VktE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Y6hIV699; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980331;
	bh=IXXH1Xi7DwBkbAN/wZY6ft3uS7EohqGjoHwcUbtIRg0=;
	h=From:To:Cc:Subject:Date;
	b=Y6hIV699aGQrS8ws4B28o2QsX/IIYOGn0E3AJa0buGdHy2r/uHu8yAraLY9ysu7Ad
	 trpZUVTK00GgeRylQGNN9vlu8UfCyfmnPlCbzNMPs9wjzfTDGmjRdoSEFFuTLjTO1A
	 SJV+LHS5jRvVUDZY1kWtV3X58sbieOgQS4e1dyPE=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980307twvau7uu6
Message-ID: <tencent_C5E6023F97E7CC2A046AAEA09BC9ACF43907@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujH5sp+LyAoZwpdimsMPqYsVYGz8U6tI4kbnKRqXrhyOnj/OKsgE
	 2k3axqj7XLr6sAqU927YWOfRUrid/ZOvIS3HAaMK59vf2prxtMlvxE7r2FjOEdDBZ5veJ1CjUoGZ
	 pgvB3CPWHEhff9nwxY0VbmBeAxLBIheKhYdvXtKggpNAlsSOzLH1RscgAKLKZtFNxYad7Q85QDhz
	 d1qGjnM76l1VpcniiKnmYqswQ/cECg9SYBpXoA8sh7ut+YMSZOIDLsxy/KVIF9aYVesgWodXcqHY
	 HJK3+SyotrPCp7V6TkPK2rAgM9LPDAj+ePdPCVbpStRep1O3PoWI+w81exXirKleaqC0X34X6iLy
	 XtlX1N+v4Y8P1N8jdCpMH3d3qHoJ0lQ2LJkJSWYxtXk+/QYdCrBagggD57/RRpxfvV9TGjb9dSPt
	 Bk6vi0tibnlDp70/lInJjoIBEsi4pwH/1DWQaWeJNBCvfsYt9XWYKYxJySQjVetKIsWez4tdeL30
	 6HWYzdkB7GheN/LhEMw4JVfX7wher4dYRd1wiIopmUom8CLPC7CU/D9j0ZXUcu27wxUBT9cgws4b
	 884gN1g/7hqJaDgsbzkVrEC48tGpYtqjRp1Dpsvdxt2Xf1BqUO85LReRj0q+cXLWGA8mZMDtQ95r
	 Oc9QtayPMDTrra03ngiwAsw7CrTjWGke5s8l1kiDD+zjMzOT3mCi2L7hwVPAln6BKro2TQWUdGBD
	 QTHaQg8i1CcFgYfxzY/d26I7I7f2QPRtq73HSlm30uAtSA35EdVQzRHsDZMw3JyR8tOEl35pIual
	 RzH5To8oqfphKspdPXYHhV2kHwYWbGAW45qtYjVkTzdBDX/Bh8Vq7hjxfeCsxSGe3MKtapG6x2oe
	 aV/9eDnCslRY0uNiR0t1REvcvKaV+/PexRoMjU2G0pBW/QC5o11nTEUNDWmyXw/esB10b47yglgD
	 XstMx9fUO+k+bee/4bYZLzGukSvj5RRS2HrDTBj1pXrsCQealajaj0GeE8a2x/gF9bDt/cT+aHsI
	 opYB0SVlH171ngxSr22kju9QXokx0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] encode the values directly in the table entry
Date: Sat,  9 Mar 2024 18:31:17 +0800
X-OQ-MSGID: <cover.1709978655.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

The boundary check of multiple modules uses these static variables (such as
two_five_five, n_65535, ue_int_max, etc), and they are also not changed.

Eric points out: "by turning .extra1 and .extra2 into longs instead of
keeping them as pointers and needing constants to be pointed at somewhere
.. The only people I can see who find a significant benefit by
consolidating all of the constants into one place are people who know how
to stomp kernel memory."

This patch series achieves direct encoding values in table entries and still
maintains compatibility with existing extra1/extra2 pointers.
Afterwards, we can remove these unnecessary static variables progressively and
also gradually kill the shared const array.

Wen Yang (9):
  sysctl: support encoding values directly in the table entry
  kernel/sysctl-test: add some kunit test cases for min/max detection
  rxrpc: delete these unnecessary static variables n_65535, four,
    max_500, etc
  net: ipv6: delete these unnecessary static variables two_five_five and
    minus_one
  svcrdma: delete these unnecessary static variables min_ord, max_ord,
    etc
  sysctl: delete these unnecessary static variables i_zero and
    i_one_hundred
  epoll: delete these unnecessary static variables long_zero and
    long_max
  fs: inotify: delete these unnecessary static variables it_zero and
    it_int_max
  ucounts: delete these unnecessary static variables ue_zero and
    ue_int_max

 fs/eventpoll.c                   |  19 +-
 fs/notify/inotify/inotify_user.c |  49 +++--
 include/linux/sysctl.h           | 108 ++++++++++-
 kernel/sysctl-test.c             | 300 +++++++++++++++++++++++++++++++
 kernel/sysctl.c                  |  61 +++++--
 kernel/ucount.c                  |   8 +-
 lib/test_sysctl.c                |  12 +-
 net/ipv6/addrconf.c              |  15 +-
 net/rxrpc/sysctl.c               | 169 ++++++++---------
 net/sunrpc/xprtrdma/svc_rdma.c   |  21 +--
 10 files changed, 571 insertions(+), 191 deletions(-)

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org

-- 
2.25.1


