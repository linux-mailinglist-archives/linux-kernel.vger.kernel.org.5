Return-Path: <linux-kernel+bounces-150889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C48AA646
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E3C2820DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA810F1;
	Fri, 19 Apr 2024 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjyIVPbA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D47E1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487210; cv=none; b=ttADsE9oCgDA6YzURHscUE01xy18t9g1C9jqfyENg9fd3WwJ8tWApXGVT6rZkd19g1xo9gL8AP7cw/R/dFga9wRt72xPweaYWhJXk8/OwFnucCV8+5J/FRTn2CvhUQX3pj3e7d3hz6dmPfqU32bSPOTJ3JP866jfyV4+G0ge1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487210; c=relaxed/simple;
	bh=uSfbOIFusL7yPA50dYF5H5x/u32T7cdQCxoVsUks114=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cdQDjEBk6N0DeHAV0cLgAMV9Xhy3RZ7C+j7cLB3fIOs81xfZ5DIWOfKOowXZtaMUQZKguPcKNn0cdEkgKD6yNzaEFTfdZfmvHGbdnBf+EO9WcGoOyPfVK7agyaDWGqJTtDg1rnrrqSlickDowfGAxmr1QztS1YYQK5+MvT4djUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjyIVPbA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=m2bpW9rm2qv+2Wunav+fPG5Qki620lzFcR5jp/JLSVc=;
	b=cjyIVPbALnNM29lrmYYZwbxUDx9FfQBuZFJ0ij+W0AX1VSqLL852aBVpMT7ZMPktytMlsp
	KZkoL5npWtgliaty1wobtOy6yJcCbffTfvo61NnvklhVzIUhAydY09VuCeKlSFkivLM1Cf
	ZDUm2hywLH9lsnEVPkWOjBenOs2ULec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-dhEQf1NgPf6CB8kNhSyeow-1; Thu,
 18 Apr 2024 20:39:55 -0400
X-MC-Unique: dhEQf1NgPf6CB8kNhSyeow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECA383819C64;
	Fri, 19 Apr 2024 00:39:54 +0000 (UTC)
Received: from localhost (unknown [10.22.10.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EAE9D1121312;
	Fri, 19 Apr 2024 00:39:53 +0000 (UTC)
Date: Thu, 18 Apr 2024 21:39:53 -0300
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
Subject: [ANNOUNCE] 5.10.215-rt107
Message-ID: <ZiG9WanmSqCUNTuq@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hello RT-list!

I'm pleased to announce the 5.10.215-rt107 stable release.

This release is simply an update to the new stable 5.10.215 version and no
RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b850d563e91f696a605c28e8d6a968a950cff491

Or to build 5.10.215-rt107 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.215.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.215-rt107.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


