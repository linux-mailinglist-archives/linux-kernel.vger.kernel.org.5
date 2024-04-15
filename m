Return-Path: <linux-kernel+bounces-145019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3557A8A4E44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B511C20D85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694267C43;
	Mon, 15 Apr 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="ar85pjeZ"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6266B5E;
	Mon, 15 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182415; cv=none; b=bXMYqQyEiBblBdcmt+iJtqUaJFMlV9QYNkSr8NCucmIyZxk3f5UHlnZ53uHQf97QJ0n0on1dsIVppIM49UCWY4ECe0aqv3O3lLjSGhGIljpHBgHTlne2iZwaS0q8ux6T5le+ldz5XJ5OreS+vu4DxRHT74w8CW2FckW1SBMyvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182415; c=relaxed/simple;
	bh=ZZUy1xI7pLJyHVR8GyZICsFTKD+f1gi5zCnPFjtGcvU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YyMpDR31Q69K/6+a1L4Yr98cbKXDvSzb22tQFrnAVbCe3VTlqU8QoayO5BTekk1n0N7Xf4sra7Q+eS6c/BHt8nb7movpfcaX87NJYNl2SwaTFXgqt0c2erggaxwjngT+3IpiG4gmhm7oaIxDVGbydmA39U8eyDKnXG44RsK5UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=ar85pjeZ; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 3A53610064FA;
	Mon, 15 Apr 2024 14:50:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 3A53610064FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1713181819; bh=1JzukUDnPECi4/20s24sBuSFQzc/kxxeFzOxjMJdXG0=;
	h=From:To:CC:Subject:Date:From;
	b=ar85pjeZnGsrOwfMK049cSm+nZP5pwId99u45lPAkdVGAAyRNcG7itd0QclXlZJ8Q
	 o8RRTzy7k/Nvw+ExGZmBG0Ey/hMf2cZor6CwQVdBnHQPknItQukuip5CSDg1Oy24IQ
	 aGZsrs8f6x+dsT99AeuhDldtslCPZX2HI7pcYjb4=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 36C553025FD4;
	Mon, 15 Apr 2024 14:50:19 +0300 (MSK)
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
Thread-Index: AQHajysWljFSLnmM8Ee7tNlnszP9Ew==
Date: Mon, 15 Apr 2024 11:50:18 +0000
Message-ID: <20240415115015.3913760-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2024/04/15 08:48:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/04/15 09:42:00 #24801259
X-KLMS-AntiVirus-Status: Clean, skipped

syzbot reports a memory leak in pppoe_sendmsg in 5.15, 5.10, 5.4 and 4.19
stable releases. The problem has been fixed by the following patch which
can be cleanly applied to the 5.15, 5.10, 5.4 and 4.19 branches.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

Gavrilov Ilia (1):
  pppoe: Fix memory leak in pppoe_sendmsg()

 drivers/net/ppp/pppoe.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--=20
2.39.2

