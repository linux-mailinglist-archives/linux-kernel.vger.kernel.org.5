Return-Path: <linux-kernel+bounces-145010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BB8A4E17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945F71F2106F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CD679F3;
	Mon, 15 Apr 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="bYv9RlUA"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994BA79E4;
	Mon, 15 Apr 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181866; cv=none; b=u3djua9MCihYESugXO6OjCYmAFNsr5Edbv8yp1uvz/9QX2qCSQsI+57DRIHQ3wEXeOgDt6RKegnxCsVIyjPL1KM/3jyR17Xk2Ind6cc761UGO2DCGbEdTIf2Sls1Hzzocaz8wDCT5HRB6aYfAIgr1LrjG926j0h7JJItc66elrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181866; c=relaxed/simple;
	bh=mfL4lpZfvM7BlCtt4ST58fKYcVjZ6oDkZO2yKupDzdg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hf8asPtx8ym9FQa20GQ6xkhoS5psrQDZn7sMiqQo8MBU3NWCw4H82lHXeW1SKCeaM0InN4cdXvXP4vt8/H/xdAfsmoSizl+iYXsU+kqY++RcrJAX0qKMyAbCggdDzRhJCHpieULQQyrbMAEoGh+w90O0yEMkXT8fSJ0ZSt0TyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=bYv9RlUA; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id CDFFE14FFA23;
	Mon, 15 Apr 2024 14:51:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru CDFFE14FFA23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1713181862; bh=H5icz46cAcV+OVygu5QLzJOl+JIEFHHjACrVhgKwhnk=;
	h=From:To:CC:Subject:Date:From;
	b=bYv9RlUAPSO2DMhlEPyicmhZdzl+7aviwdrAcpJm81r6dRs0x18YIDzpzCoHvX1NA
	 muHSFqBiZBy4NoPtFtyj4UIkVUAUpi+r4iC75pInqKQ2hF4ugYmWPhFdW/zXwppUld
	 A4d+/VZpsjAG1SFltJHO44IfV3Um2I6qsKwzN34M=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id CAC65319A98E;
	Mon, 15 Apr 2024 14:51:01 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, Guillaume Nault
	<gnault@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH 6.6/6.1 0/1] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Topic: [PATCH 6.6/6.1 0/1] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Index: AQHajyswWUg9DipKAUu6zaSephjulw==
Date: Mon, 15 Apr 2024 11:51:01 +0000
Message-ID: <20240415115100.3914582-1-Ilia.Gavrilov@infotecs.ru>
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

