Return-Path: <linux-kernel+bounces-25281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0F82CC9D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C4EB22B25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5B210F3;
	Sat, 13 Jan 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="PD2gf3WV"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698A210EA;
	Sat, 13 Jan 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3F10640F1DE8;
	Sat, 13 Jan 2024 12:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3F10640F1DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705148170;
	bh=pztDEiVv/JTrPlxIE4dKwnm5K1/LAKTBaRFR2rt1P68=;
	h=From:To:Cc:Subject:Date:From;
	b=PD2gf3WVCf/07T/Z491LAw57ctIf56C9+WM0RlTGAYEnWpvdlI52uNZdowMqYpF+n
	 Ap2+RNSpVAs3c5VW816FiB55bbq/rB9psKG6oAzQBiXb/3E20pPBlBUmCwe8DozDdq
	 yzTDNvkIfUI57Sf9QtSFykO6VuMlUmFhJ7JhSjG0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: John Johansen <john.johansen@canonical.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/2] apparmor: fix namespace check in serialized stream headers from the same policy load
Date: Sat, 13 Jan 2024 15:15:50 +0300
Message-ID: <20240113121556.12948-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is intended to fix the supposedly invalid behaviour of
verify_header() function when checking unpacked profiles namespace
declarations.

Consider having a profiles file called 'testfile' with contents as
 profile :ns1:profile1 ... {}
 profile :ns2:profile2 ... {}

then packing it in a binary format and trying a load-replace operation
 $ apparmor_parser -Q -W -T testfile
 $ apparmor_parser -r -B /var/cache/apparmor/ac27e0ee.0/testfile

Per dmesg output this leads the profiles to be loaded into the same
namespace (trimmed for more convenient display):
 [  414.616098] audit: apparmor="STATUS" operation="profile_load" name="profile1" comm="apparmor_parser" ns="ns2"
 [  414.619304] audit: apparmor="STATUS" operation="profile_load" name="profile2" comm="apparmor_parser" ns="ns2"

while the string "ns1" unpacked inside verify_header() is leaked:

unreferenced object 0xffff888012ff9b18 (size 8):
  comm "apparmor_parser", pid 1198, jiffies 4295081077 (age 164.892s)
  hex dump (first 8 bytes):
    6e 73 31 00 80 88 ff ff                          ns1.....
  backtrace:
    [<ffffffff81ddb4b2>] __kmem_cache_alloc_node+0x1e2/0x2d0
    [<ffffffff81c47034>] __kmalloc_node_track_caller+0x54/0x170
    [<ffffffff81c224dc>] kstrdup+0x3c/0x70
    [<ffffffff83e2e4ef>] aa_unpack+0xb5f/0x1540
    [<ffffffff83e1e9c6>] aa_replace_profiles+0x1f6/0x4040
    [<ffffffff83def008>] policy_update+0x238/0x350
    [<ffffffff83def33e>] profile_replace+0x20e/0x2a0
    [<ffffffff81ead03f>] vfs_write+0x2af/0xe00
    [<ffffffff81eae556>] ksys_write+0x126/0x250
    [<ffffffff88f54426>] do_syscall_64+0x46/0xf0
    [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

With the following patches this situation is detected and the whole
profiles load set is denied because of the mixed namespaces.

Note that the following multiple profiles load will also fail after these
patches - quite similar to the namespace check inside aa_replace_profiles().
  profile profile1 ... {}
  profile :ns:profile2 ... {}

This behaviour may directly affect userspace part of AppArmor, though I've
not been able to find any valid use case when e.g. the user writes
  profile profile1 ... {}
  profile :ns:profile2 ... {}
and expects `profile1` to be associated with `ns`. I think it's actually
an invalid expectation so such profiles set should be also denied with a
'mixed namespaces' explaining message.

There is no difference in AppArmor regression tests with and without the
changes.

