Return-Path: <linux-kernel+bounces-162023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCE8B54CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CE01C21764
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C782E41C;
	Mon, 29 Apr 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn5lx9d1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4902940D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385659; cv=none; b=H8D8i1Y2zNCl7HgAEAWbkddu9cwgl4XW4qHQkjgtS7KGK8JB/lNgHseEOa/ZbsFVEnfZIZTKXijlCGRjDJ7i6SGHqEurPxbe+oGqVTdatmvuCc4iBT+vCIhV5k9O2dNS3+l41uZx88y25E8UhVCKtQjzPwA4EQheLda+kJYxBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385659; c=relaxed/simple;
	bh=iZhx68wJoCtRT9rE+JNoWgxvPGXWzCYdxIIYihQYQrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WlEgTx/XUU9jcS/z6kwF1T0lK3ITQ+dS0wcjs21AYHm1UDzZYsXQdYbXjZcVHtM2LSkPiJMOFsyU06BB3nAp091uys6ucadi5hmNjxm9xDMfgh9/t99o/NGQBt+sfSINqZpNW/bJxMI27aGu26w5inUlE93pDCjOWbTpUTemaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bn5lx9d1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8VbfXMl3lCB5xWetPllnoWcCiHmUHWAQe8EmxZGTofQ=;
	b=Bn5lx9d1HWqrLM66r8rwl6wnzez/03KJJARRGHz3MyiIlD0309QYO/PYgHzGeux3ILZq49
	1rY7yAgkNYAaF4VpvuATwN85aWgkgTLxhby2JTzN3SN4fuRnLHwWtcUTrhQKZ7/MNjYScH
	JtethPLg7Ml8dJiGUHLo27j+GP3GUYg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-fAm4CPZDPKOUzxPyeYhXcw-1; Mon,
 29 Apr 2024 06:14:13 -0400
X-MC-Unique: fAm4CPZDPKOUzxPyeYhXcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59CD23C025D0;
	Mon, 29 Apr 2024 10:14:13 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F324F1C0666B;
	Mon, 29 Apr 2024 10:14:10 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 0/4] vhost: Cleanup
Date: Mon, 29 Apr 2024 20:13:56 +1000
Message-ID: <20240429101400.617007-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This is suggested by Michael S. Tsirkin according to [1] and the goal
is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
the caller of the function needn't to worry about memory barriers. Since
we're here, other cleanups are also applied.

[1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/

PATCH[1] improves vhost_get_avail_idx() so that smp_rmb() is applied if
         needed. Besides, the sanity checks on the retrieved available
         queue index are also squeezed to vhost_get_avail_idx()
PATCH[2] drops the local variable @last_avail_idx since it's equivalent
         to vq->last_avail_idx
PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
         for vhost_get_avail_idx(), so that the relevant sanity checks
         on the head are squeezed to vhost_get_avail_head()
PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
         as the terminator for each line

Gavin Shan (3):
  vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
  vhost: Improve vhost_get_avail_head()
  vhost: Reformat vhost_{get, put}_user()

Michael S. Tsirkin (1):
  vhost: Improve vhost_get_avail_idx() with smp_rmb()

 drivers/vhost/vhost.c | 215 +++++++++++++++++++-----------------------
 1 file changed, 97 insertions(+), 118 deletions(-)

Changelog
=========
v2:
  * Improve vhost_get_avail_idx() as Michael suggested in [1]
    as above                                                     (Michael)
  * Correct @head's type from 'unsigned int' to 'int'            (ltp@intel.com)

-- 
2.44.0


