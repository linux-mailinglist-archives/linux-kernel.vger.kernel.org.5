Return-Path: <linux-kernel+bounces-116978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B64088A781
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861ADBA196B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DBC3DAC05;
	Mon, 25 Mar 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzqbmB/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5834E1C6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368630; cv=none; b=AEdh0j1+/lriG4ZYzOnDT4a31nAF4KwXGOSZBF7tr89+XNSwufKjfTcWXOnoCyf2FFSAKnX/gb6Ky2iN9lgU2oiy9FvGMNGHiauGRJ/8ZDpdfc5JoAZg0/l+u6uooQ8w3FcYEe6zUw6xZ3UJ3X6F15zdBdpqVZRBST1FvoUD/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368630; c=relaxed/simple;
	bh=K71KdlxYZsiIMFj5o/hNwVsIU+3ZrPbx4L7G25LkjLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH7ii8ZAEOIxSu0r1er2sf/HvEnbVdyM0M/W9GlYLo8/6JRInfkqQZm6Ml1bSDgG7bWnlgcThTWpj119nRmZ8BI5tTyayLcXf1CWPMVSMtGSi6mxMqzrkY2n/rdAmi57KGoTC5TyrjwF7K2tAk35uGvPRGcD8r+JDC5JpyOuq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzqbmB/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711368627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LN0ZWoyXU4SKqZ/oMmr2x3t+IqeauNxfkUGdiuWye84=;
	b=MzqbmB/IXND5iJZIfbh16csZqvaNNv3Ydu+MggVWkL/1DhQH38aUGVwyjh1sYSDc7G0COR
	8JqZQ2ePNUI7iSmYQVGJWvyIIxwQPp7/L919UKE/bQJpVOFdhK+oj1bc+L6ro0sgwO5nqM
	nr0Z/nKE/3RxzXS5CG3rdGyxwVltIFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-1HWGQpVFOIWVJFIIuZ5MEQ-1; Mon,
 25 Mar 2024 08:10:26 -0400
X-MC-Unique: 1HWGQpVFOIWVJFIIuZ5MEQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C156A1C07F39;
	Mon, 25 Mar 2024 12:10:25 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 077E4492BF5;
	Mon, 25 Mar 2024 12:10:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fix
Date: Mon, 25 Mar 2024 13:10:16 +0100
Message-ID: <20240325121020.337540-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello Linus,

please consider pulling the following gfs2 fix.

Thank you very much,
Andreas

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-fix

for you to fetch changes up to c95346ac918c5badf51b9a7ac58a26d3bd5bb224:

  gfs2: Fix invalid metadata access in punch_hole (2024-03-11 17:11:18 +0100)

----------------------------------------------------------------
gfs2 fix

- Fix boundary check in punch_hole

----------------------------------------------------------------
Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

 fs/gfs2/bmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


