Return-Path: <linux-kernel+bounces-48222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D68458BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157551C25DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC153383;
	Thu,  1 Feb 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOP0XHyD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6905337D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793626; cv=none; b=HrYek47blyT3tvVfA8hHIm3DD9On4Gm45alTaZqFdRBFCQhdMJVFEl6d8PW2+kbvbftmZzmNMua9OYJawTUQGQYByriIgXA4kXKAAfLCKHC2G38vnQPMZ5ELgG3o5Zmlpoi6WpsT3dsiwWv0503lP45t3aBOGX0lR8y9CWZMK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793626; c=relaxed/simple;
	bh=cvmolqsTy/2d7Qe4AIyBfFK8LhPyeVmcbRhnUpYL8s0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N4nnLKleh6kgX/fNw5okbosJGRhm+vsNrzPbU02tPKolR1PikIZRwMkYQVOPvAqsEVol1WukXZS018D7FRPYorAsMCOb21y/Hn+TtYCdMZO0dEwf0FistsRiyfIiEr1gSNnvWI3jWxqfNNHPCi1UHDVp4Sy1wvqYtpGLHd29GB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOP0XHyD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706793624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jJtLN6yrGN0UJpNCi+cAIRSxr/Pu2NijAWYXx1ZxLuM=;
	b=YOP0XHyDlaw0YoyY0MYBgWoB4sUm75UVj5J8qLhMLW4JhNei05NM5g/XOCFHv8VGQJHb9e
	Kz3mgJcllxqgsEHRPQgBdJ0885cNmeRQ3ftI5s8eAsqyhJjeH9ehWHqztrw0iMjuhwj9eq
	WtZaIkJQsarKTP3WnHBMoExrJcLWLy0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-XfMEe3h2PhujXu_UcV7_kw-1; Thu,
 01 Feb 2024 08:20:20 -0500
X-MC-Unique: XfMEe3h2PhujXu_UcV7_kw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 606473C0C487;
	Thu,  1 Feb 2024 13:20:19 +0000 (UTC)
Received: from localhost (unknown [10.22.32.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBA51BDB0;
	Thu,  1 Feb 2024 13:20:18 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:20:13 -0300
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
Subject: [ANNOUNCE] 5.10.209-rt101
Message-ID: <ZbuajQ0wK23kW84r@uudg.org>
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

I'm pleased to announce the 5.10.209-rt101 stable release.

This release is just an update to the new stable 5.10.209
version and no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 2ff8470513b9651ecd42aaa0983ed13841b2fb1b

Or to build 5.10.209-rt101 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.209.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.209-rt101.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


