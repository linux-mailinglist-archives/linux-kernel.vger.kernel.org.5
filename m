Return-Path: <linux-kernel+bounces-131197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A91E898457
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A611C220DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1474BE2;
	Thu,  4 Apr 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca76V2on"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1174438
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223594; cv=none; b=hLCZFApGjZnV9DA5chiZMSQxJIFnKSTiTIZZVzgJa8KQw4JLVXMx1J8mvTDOLjhe3ukmBxxQ/4YPtplPMyZgLRtq+rX7iK/icehStbGlQV+hoEZqFrt5DpxZj6yqBwcjWTM/qvoAAmlooCTgsngA4mz9j7CUN8NE2FDjeYhrI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223594; c=relaxed/simple;
	bh=Q2J0SHdbDDTKk3cBCCZk1JWW4uClXx9Nvjj8wbCUCz8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=co4egBoQyxLyvMQ+qXz7YT8LGfhcyHhwJKFlZhJ7TQ7DcEHPbAcJ7+WjVVqcvJmip0Z3SpaDGNGcO53EiDK7mKxMoh1iUdnNJYrYXp66ghn8aGjkM6nAtvPoUq3m0JntCOlSogM/B4TfxFAK5b4Dzuqb2nS9Kz4S9jG2R1eg8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca76V2on; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712223591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Q0Gv0d6rBwe65qsruTCiuIlit9fW3dRsJmEeNPjWAs=;
	b=ca76V2onUiOFhuKmtGMbMiibCyZgHaYh6RUTr1oCgzXzM+pLXzM0Yf0C/7SXRVJxZhJlUL
	3AK3xIUG34NEX0dne5Ho0WoshT3Fa4euMa7yllT7zIedBBDvsSaKF97A1izMtGoDOiA8VS
	mV9Go1omdevASO/b8B+1KJ80eTiY5Z4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3KsI3PBNM1-8XJ9da5_nog-1; Thu, 04 Apr 2024 05:39:50 -0400
X-MC-Unique: 3KsI3PBNM1-8XJ9da5_nog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C004485A5BA;
	Thu,  4 Apr 2024 09:39:49 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 337BE1C060A4;
	Thu,  4 Apr 2024 09:39:49 +0000 (UTC)
Date: Thu, 4 Apr 2024 11:39:43 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux maintenance release v2.39.4
Message-ID: <20240404093943.jkyn4eimk3humbw2@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


The util-linux stable maintenance release v2.39.4 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.39/

Feedback and bug reports, as always, are welcomed.

(Please note that the current stable release is v2.40.)

  Karel


util-linux v2.39.4 Release Notes
================================
 
Security issues
---------------

This release fixes CVE-2024-28085. The wall command does not filter escape
sequences from command line arguments. The vulnerable code was introduced in
commit cdd3cc7fa4 (2013). Every version since has been vulnerable.

This allows unprivileged users to put arbitrary text on other users terminals,
if mesg is set to y and *wall is setgid*. Not all distros are affected (e.g.
CentOS, RHEL, Fedora are not; Ubuntu and Debian wall is both setgid and mesg is
set to y by default).


Changes between v2.39.3 and v2.39.4
-----------------------------------

build:
   - only build test_enosys if an audit arch exists  [Thomas Weiﬂschuh]
dmesg:
   - (tests) validate json output  [Thomas Weiﬂschuh]
   - -r LOG_MAKEPRI needs fac << 3  [Edward Chron]
   - correctly print all supported facility names  [Thomas Weiﬂschuh]
   - only write one message to json  [Thomas Weiﬂschuh]
   - open-code LOG_MAKEPRI  [Thomas Weiﬂschuh]
docs:
   - update AUTHORS file  [Karel Zak]
fadvise:
   - (test) don't compare fincore page counts  [Thomas Weiﬂschuh]
   - (test) dynamically calculate expected test values  [Thomas Weiﬂschuh]
   - (test) test with 64k blocks  [Thomas Weiﬂschuh]
   - (tests) factor out calls to "fincore"  [Thomas Weiﬂschuh]
github:
   - add labeler  [Karel Zak]
jsonwrt:
   - add ul_jsonwrt_value_s_sized  [Thomas Weiﬂschuh]
libblkid:
   - Check offset in LUKS2 header  [Milan Broz]
   - topology/ioctl  correctly handle kernel types  [Thomas Weiﬂschuh]
libmount:
   - don't initialize variable twice (#2714)  [Thorsten Kukuk]
   - make sure "option=" is used as string  [Karel Zak]
libsmartcols:
   - (tests) add test for continuous json output  [Thomas Weiﬂschuh]
   - drop spourious newline in between streamed JSON objects  [Thomas Weiﬂschuh]
   - flush correct stream  [Thomas Weiﬂschuh]
   - only recognize closed object as final element  [Thomas Weiﬂschuh]
po:
   - merge changes  [Karel Zak]
po-man:
   - merge changes  [Karel Zak]
wall:
   - fix calloc cal [-Werror=calloc-transposed-args]  [Karel Zak]
   - fix escape sequence Injection [CVE-2024-28085]  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


