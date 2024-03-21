Return-Path: <linux-kernel+bounces-109832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1C88563F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2AD2829D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0131481D5;
	Thu, 21 Mar 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="xUb2dfem"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEBC2E6;
	Thu, 21 Mar 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012383; cv=none; b=ANkOyQth2PDI6ZCoMWWRlMnyo7/DDMkzmMisEmJOVEE44tvFaK04p6WoONiizXU7E3oJ4hpzWM80DnsKhQ/+lsB1LZ+28do9vFjjuohV+o/dwLCAtLlnskOJS68T2Jeiq5fgvsgPLDvki82n9lINqG+aai+0Udiw61AOTQaHATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012383; c=relaxed/simple;
	bh=mfL4lpZfvM7BlCtt4ST58fKYcVjZ6oDkZO2yKupDzdg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JwcXuJGFNMZeefDitOExgfpc3nzjL3ew8W1YwHE75qm3jpmLCt29GxIqmjA55TVoh3acmXdIj2ujb5xFmq/9WSDE29zmbbaH0+qSpIslhQuredbNHWFaDi5dQc4q+hPvpfh5mre9q3DTP16qS9kdYoOp1Ef47uQtzLey9TkJB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=xUb2dfem; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 6B5F710BB097;
	Thu, 21 Mar 2024 12:12:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 6B5F710BB097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1711012378; bh=H5icz46cAcV+OVygu5QLzJOl+JIEFHHjACrVhgKwhnk=;
	h=From:To:CC:Subject:Date:From;
	b=xUb2dfem2WUN2WoYr3BY0Yo9k1HKwuRtVnHud8cZjtiPkx8R7wvb+rfqVQDa0gkdS
	 84xQ9xW3TvwbPxnjyBJlHBpiRRsQ0mX0+aoS2zRZ8/MKehyaYozSc31gqEWFshn+1d
	 X0couzozTxuU38+ayFlG6ZeLjDHsR5nKHX7B8Cno=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 6782A3196652;
	Thu, 21 Mar 2024 12:12:58 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, Guillaume Nault
	<gnault@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH 5.15/5.10/5.4/4.19 0/1] pppoe: Fix memory leak in
 pppoe_sendmsg()
Thread-Topic: [PATCH 5.15/5.10/5.4/4.19 0/1] pppoe: Fix memory leak in
 pppoe_sendmsg()
Thread-Index: AQHae2/2z5M9RYxR80KDHqxv8N3w3Q==
Date: Thu, 21 Mar 2024 09:12:57 +0000
Message-ID: <20240321091256.467553-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/21 07:23:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/21 04:23:00 #24331522
X-KLMS-AntiVirus-Status: Clean, skipped

syzbot reports a memory leak in pppoe_sendmsg in 6.6 and 6.1 stable
releases. The problem has been fixed by the following patch which can be
cleanly applied to the 6.6 and 6.1 branches.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

Gavrilov Ilia (1):
  pppoe: Fix memory leak in pppoe_sendmsg()

 drivers/net/ppp/pppoe.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--=20
2.39.2

