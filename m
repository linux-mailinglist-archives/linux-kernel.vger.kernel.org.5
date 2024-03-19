Return-Path: <linux-kernel+bounces-107677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5DB87FFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06492B228CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA6651BA;
	Tue, 19 Mar 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQEwQzmv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32C657B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859867; cv=none; b=M0bt7YbVvHo2tzDilSjj2km6QPo2rc1rwgLWFy8R1jAzJBQXxY+GW3FNT9Ut7l+2oKTaNylvY1VorTDuE4t2XB1gSLtYYcnFmUFbw1eb0ZT6hnkNh8xzS5LtQKA4aucKB0expLfZQoNBhY9gyBzr5rF/HgYCXif8UkeuRdIn4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859867; c=relaxed/simple;
	bh=1q2GlRCeVWREA8vsfOJ1kqSPuEXC8eAchMauzeL7W8Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YGHQ+2uCjYKbz26BIEBuhzd/JbqD82VNWZ7rFDKyNGRQEJLm2TlXPxtzdC05bSj7vF5ubDKNab7KPwb44NHO10rO4m/DMgLEoBQKHodC83dlQyPj6XADzOfsar4uKGjDLyPzeo0Mm6RgfzoNH7fR1QKgjqvi6DnVnJQW2EVrZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQEwQzmv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710859863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=HtroAqzx3y7s4ngx6ZeX1P9/Uz1LLNN+FAeeDogfPOw=;
	b=EQEwQzmvhkZboDdc6wEUE0eMxLmAmMVZvpz3jFx8Ep70bMyFgELA6dUB71dvSFXUs40LOp
	DjyzrU9+oDrJDj7gkiafsZc7r5u1bY8z4DMZ5vd5TDJz2El2brzuhC/bKnbFP1fl+HlXeO
	8UtE2DzoV0sME6zyFSmO9rEmbvHSrPA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-3FsUfxeBNmq98WMyddn_qg-1; Tue, 19 Mar 2024 10:51:00 -0400
X-MC-Unique: 3FsUfxeBNmq98WMyddn_qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A24F989C8EA;
	Tue, 19 Mar 2024 14:50:59 +0000 (UTC)
Received: from localhost (unknown [10.22.16.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3AAE10E47;
	Tue, 19 Mar 2024 14:50:58 +0000 (UTC)
Date: Tue, 19 Mar 2024 11:50:54 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.212-rt104
Message-ID: <ZfmmTucCNMPUm8EM@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hello RT-list!

I'm pleased to announce the 5.10.212-rt104 stable release.

This release is an update to the new stable 5.10.212 version and no RT
changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 6f80a051d66ad3ad791960ddedf516b139da8dd8

Or to build 5.10.212-rt104 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.212.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.212-rt104.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


