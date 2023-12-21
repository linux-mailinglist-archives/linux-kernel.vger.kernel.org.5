Return-Path: <linux-kernel+bounces-8258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F881B495
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97978B216E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A866ABBC;
	Thu, 21 Dec 2023 11:02:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BA6A34B;
	Thu, 21 Dec 2023 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id CB1C31868D3B;
	Thu, 21 Dec 2023 14:01:58 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gt00sCmcMSre; Thu, 21 Dec 2023 14:01:58 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 7DA651868CE0;
	Thu, 21 Dec 2023 14:01:58 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GtlX3tkcyl9n; Thu, 21 Dec 2023 14:01:58 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.102])
	by mail.astralinux.ru (Postfix) with ESMTPS id E00AB1867B5E;
	Thu, 21 Dec 2023 14:01:57 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.232.135])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4SwnYx0D5MzfYkm;
	Thu, 21 Dec 2023 14:01:56 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/1] 9p/net: fix possible memory leak in p9_check_errors()
Date: Thu, 21 Dec 2023 14:01:21 +0300
Message-Id: <20231221110122.9838-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Syzkaller reports "memory leak in p9pdu_readf" in 5.10 stable releases.
I've attached reproducers in Bugzilla [1].

The problem has been fixed by the following patch which can be applied
to the 5.10 branch.
The fix is already present in all stable branches starting from 5.15.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218235

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

