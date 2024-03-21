Return-Path: <linux-kernel+bounces-109541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23941881AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78541F21521
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51E1877;
	Thu, 21 Mar 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qTRHndQK"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AC5660
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985034; cv=none; b=Al96hdCyEIRjze3h718+BisZg1eQa1NfiM6/JyM+VOMUPxFpDbjjKoiU1yuANJlr3SdBFIm6kOZ3S2+vNjpnHsU7k5MGfpOyRWbk8PUul1NhM9dTtSY9ijNt1iER49Wb8MABuq9iwj4UaXhuOZiu7UE/wiIDNutXM2YR2wX4JAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985034; c=relaxed/simple;
	bh=pV7ahaGIemw1j5hZGQAz0tCVo6kmDYrAEp6ydQuo+Sw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ErPY2RzVY5srX3KiKsJVGqzZRb/Aw+J+/JC7HFRQKV4zBQXRnbTzKsV93MT28fp57A5/WErT5d+WsVKawgQsK2Mj4/zXH/pJ6aAjlN63rXqMOfHWTGwUB2xCSsLYdEoYCKyjSOAliSFA6hBbGOSFH5VloDE+5kaT+mQV+/3NS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qTRHndQK; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710985028; bh=b8uiz9+V2+Fvh4SmZjLlpcxudpBHnV2ToDJ3AyZtqbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qTRHndQKm82a/ZaaCG0UthdGWH8Z/HUwBJSwmjPf7k+VdiYjm4KIfK5uFVW8Uib2s
	 ftIoFFfF52La7lG20moHxj+eWAk2JGhD0rgC+ZdpEG8b+QFSkIDa1ZoXMf988rERF2
	 cdNs0JyjTgIui5PdYsbvqFZHMXJeUIYZSZT0ALKE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 9463AE5A; Thu, 21 Mar 2024 09:37:06 +0800
X-QQ-mid: xmsmtpt1710985026tu3zp38wp
Message-ID: <tencent_9E7A866D382C796FF8943CE8A6ED26CF1C0A@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1Xn1VYbDdYGMPWooLp0POrdkSKMhxFt2lYCiONWmoLQY1bLQc3j+B
	 ILwJhW6TR2XYCA+yXUXSRg0UMcOcZmPW3kXf1RaDMVKI3mdOQqzDAGcmhJttMl0uzD+ZhfSntR7H
	 2KkmXmHJU4KnAAbKUDTXmXIWeggiwHbjf7MUhsfVtQxzgpVs3j3p4O5p3aa9hCs9Az3XoRLPKBWY
	 h+HUyLL13GZBNpQONNKwprg/WeF2Exw4ZxDCplhMV1EL145Em+n3K+SLts6Qq8QbAsIavYzTFiad
	 kIZYOxGZWlPGJuZ4De3/kqUzW1yZ0mw8DMkYNYBuEJxczNWRaASrPfe/DeGUv0kW0ie7JOtlEJdv
	 /Mibm9hO3OhtM3Dd2wu9+Yt6VBBozGub0r0BOmrakglvSUg6mWKafRcW3CAyeqnwMxHjN8GypMz8
	 kS1JKDW1uVPTs3p+3v/K/uG/O3RPKcPIIjjc5ye+5W3rQbQhYqcua+i9mTAMcSYyRP8/1CWM5EXy
	 l17I0K+/J9OYEi7HufvLPTEFIun2CAPNubNz1Eioa5ZPLT/hCtc+IWMSpJsJ68Ti392pPfdXmsHD
	 EHOwrenzowLvR1c3i5NpJv33Q08tbCyt0YO5OLUL7fm8fxyelb0cXbcIZS2zTIFNVh/OavSf3JtB
	 zH0wwKSxtDmv8WgloKUlrgkyRAxvPPGRYBjz185FwcXT+CvcUjBGTMlOJ6lGzP+OXvZMoT6fWoFf
	 x39iUt3ttMzW4lI8LVGGUEX3K7ZafSr6gpEzoEKrSbsKl8z5RpjvYPsLHljnVAA2vrVVxm/uvhLh
	 kikUmjCGXlUiTyrlN/ukvGn9om7QbhTxl6PKDo8XzzkeR5lvb7oM3UlhDYyRzIWMKjTOeTz5qd3H
	 An3rXSps7ciDmw4XiXPyFWhZYe47NKRrteQ8453uxRoARFG8MwBMyOhCdSNlSql4GHQrV4nslY94
	 5pXwmR3BI0BNGJAAGh4f8otjaImNPCafGUT0iWWssz+npAG3iruU2lHuaphrCho1vBkCWXuuqgZb
	 f9lqhbDGHINY8TDEHT
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d832e7bb0f8bf47217f1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (4)
Date: Thu, 21 Mar 2024 09:37:06 +0800
X-OQ-MSGID: <20240321013706.1783078-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000048fbc0613f4eff0@google.com>
References: <000000000000048fbc0613f4eff0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in _snd_pcm_stream_lock_irqsave

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 15b07d09c4b7..c501faa30040 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -409,7 +409,7 @@ static void snd_timer_close_locked(struct snd_timer_instance *timeri,
 	struct snd_timer *timer = timeri->timer;
 
 	if (timer) {
-		guard(spinlock)(&timer->lock);
+		guard(spinlock_irqsave)(&timer->lock);
 		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
 	}
 


