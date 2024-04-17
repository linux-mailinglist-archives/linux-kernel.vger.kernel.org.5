Return-Path: <linux-kernel+bounces-148805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB08A87A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53231F2582C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C0147C7B;
	Wed, 17 Apr 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="GwuniZAC";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="SaZWuFhR"
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F913959C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367879; cv=none; b=f8kYuqCpyZNVVeXtiACEpbVduwVWWfHlD0q+Cy6jZTRocoeSH0PkqB3Huo1GNQxRZ7aXwH7udORij58pGpZ6HvFsb1Ywqznvn+NMbpmX1HEOFNG11DMWCpNLtzFiK/l2Ck0I25NKGJpzOAGJKkZ/9Zz8YiJQ/+WMS7LlHksV2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367879; c=relaxed/simple;
	bh=dgCz2SWncqiO+Q6bWQmQ5trn7DREaGzNKuFcjXqMQKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=unNLlW/vEt+DMbe26qH/F93J2ox16RX74UDQKpmb2qrU6gnWJ6A4M+G+mykWra+mw3QsnOR+MkvIeoJWA+3cjmd+HWpAPdfZ3ATbnQvLGchM1Uux9/NpI1b7pFb6i5/lHVWQXflJz4aq0pBtOgk74K0XJCoOwvQDE7GtAmh6toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=GwuniZAC; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=SaZWuFhR; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rx7Fg-Dv6PUh-0c;
	Wed, 17 Apr 2024 15:31:12 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Wed, 17 Apr 2024 17:31:10 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 0/1] backlight: mp3309c: fix leds flickering in pwm mode
Date: Wed, 17 Apr 2024 17:31:04 +0200
Message-Id: <20240417153105.1794134-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Apr 2024 15:31:10.0467 (UTC) FILETIME=[4621B530:01DA90DC]
X-smtpcorp-track: 1rx7FgDv6elh0c.HztCDgdIVNpNr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713367875; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=krcOgqXsGe7x+1M7PzgJWjOituJS8hooQQYOs5GAeeo=;
 b=GwuniZAC/HCPIh90Plo+jX4muvL6NrGmgGnz5Q+3e3A/kETm7scqyN0INPudztdzm7tRu
 JJSVxGju6aHHVY9I2UmVY8ifubkM1X1KE0jsnkFl/PmlNdBju6WOubi/T6TfnThzMQIsxu2
 NaLPk6mXo8VPjLdL5jTWnrJuhoWTXOCnIWuv6zoAh2wfzPuF4m6MOnHTDsAAKPkqKMbJA5f
 6c9xKcKS0gtOl8W7z+OK2n5Xd2p0mJ0S3BzvaqIUdCqdD+YKqcT0B5WS76p1+BZDn67Ux7w
 kBpcAw3ty09xddW1TL84ak98LDatZynHoZrrZDAzRwCUSCu2feX0Se/F0S5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713367875; h=from : subject : to
 : message-id : date; bh=krcOgqXsGe7x+1M7PzgJWjOituJS8hooQQYOs5GAeeo=;
 b=SaZWuFhRRDRQH7WyFm9OKqiEnaeAHC7T8yIk2sTX5X5rLjPFt2gwhcnNCmo/ug8bCj8/0
 rJVd1Ah1r5DqSqo2NG0GeFfiuKRijIFfAdBZKaXSKMIGb/oF1eY/TeZAi4IMRCKKrdtA+43
 WMmjI+Km5vHM8UbtJ2D1tGTbRATiPXJaSX34qNbCGFvWV8KaRfs0AtvL5NweKYO5u+kaGj0
 oDUQvozeMXF7TJn2nxDo7sFuD3VnCSFrVVEPfDXmxOVLJ5OK7XVn4ZHVlnu16yV7X2WLLP2
 ZeejHFetuezYk5vFfPh4Q97OTSD8S1CR3Dvf+bbsi3wI591unWzGqXbQBfAQ==

The mp3309 has two configuration registers, named according to their
address (0x00 and 0x01).
In the second register (0x01), the bit DIMS (Dimming Mode Select) must
be always 0 (zero), in both analog (via i2c commands) and pwm dimming
mode.

In the initial driver version, the DIMS bit was set in pwm mode and
reset in analog mode.
But if the DIMS bit is set in pwm dimming mode and other devices are
connected on the same i2c bus, every i2c commands on the bus generates a
flickering on the LEDs powered by the mp3309c.

This change concerns the chip initialization and does not impact any
existing device-tree configuration.

I created this device driver for one of our boards, where both dimming
modes (pwm and analog by i2c commands) can be used.
This board uses the same i2c bus for the mp3309c and for an at24cs32
eeprom.
During further tests, I realized that, when the mp3309c is used in pwm
mode, every read operation on the eeprom caused a backlight flickering.
This is why I made this device driver modification.

Flavio Suligoi (1):
  backlight: mp3309c: fix leds flickering in pwm mode

 drivers/video/backlight/mp3309c.c | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.34.1


