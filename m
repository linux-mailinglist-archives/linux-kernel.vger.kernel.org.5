Return-Path: <linux-kernel+bounces-103683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C087C2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F37285BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E374E03;
	Thu, 14 Mar 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f91HnRit"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42874C17
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441806; cv=none; b=KvPJp8+ytoK57jZGrEFgfb3TQcBMN1nL0lFR84U1tTui93wcHV3wihSLajozRKQuhBDXUaKUAiBKLsz9D4eVyou7bK4bEEwAERIhsTVqeJm5DqPH5DzImSkp5kEihJZB+F2nuzwVUGiw0dcHjKbI8Ib/DfwTMj3mowpWwZbO+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441806; c=relaxed/simple;
	bh=nI9ljV1P4oULiL6aEE9RUXCmPt/OHU+mpJxQBdt5abk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RFLNTp/MDCi/GkE2wsKHV7mq6HDwLxTR70IYkGJ9HZmUdI9+5fuHOPwLgCs3riLkkjbr4YqrO86BttwraMiVLaf4KMt9UvmF4UAXJ3lTpiVJsfMGhfN5SdQY8ano+lfSxEB9PiazKI0TGK46w59FIODfXtd18/LiHVYpjn4F42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f91HnRit; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710441804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SOY7Ku6lBK1MUVkI3MgivQbxl+Npm8EWVdz/D2Q1yMo=;
	b=f91HnRitKw/54dFXz0Q75KTJbncBbPUyJYhW+0CNzim/ihxwcPLhx1b7+kdQNljpHUdlQ8
	9yywK9BRVbxnVY0GhWCl0BAOTYNHfxD6HO3Lwd6KTYINUw9e5TPaX47Gi1LVDULCJA0SQ5
	lDIsjlg2JIPUBpJpWE5c+INa2eULO2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-TlQBXOeOMpaGftmfF8WMkA-1; Thu, 14 Mar 2024 14:43:20 -0400
X-MC-Unique: TlQBXOeOMpaGftmfF8WMkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BEEB8007A3;
	Thu, 14 Mar 2024 18:43:20 +0000 (UTC)
Received: from redhat.com (unknown [10.22.34.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5185C04129;
	Thu, 14 Mar 2024 18:43:19 +0000 (UTC)
Date: Thu, 14 Mar 2024 13:43:18 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm fixes for 6.9
Message-ID: <ZfNFRg-KxTCTPf92@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Linus,

Please pull dlm fixes from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.9

Fix two refcounting bugs from recent changes:
- misuse of atomic_dec_and_test results in missed ref decrement
- wrong variable assignment results in another missed ref decrement

Thanks,
Dave


 fs/dlm/lock.c | 10 ++++++----
 fs/dlm/user.c | 10 +++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)


Alexander Aring (2):
      dlm: fix user space lkb refcounting
      dlm: fix off-by-one waiters refcount handling


