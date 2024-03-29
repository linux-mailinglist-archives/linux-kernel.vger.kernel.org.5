Return-Path: <linux-kernel+bounces-126222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD28933E6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2251C22DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962E156998;
	Sun, 31 Mar 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aykzkv5m"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FE154425
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903213; cv=pass; b=TDqH4m9+o2hyk8WuO7P6p2L7eMVe33MSraOCEDobowHNt5lZOAh2Rct2DkG3aIfzIJLkJOA7S5aXpKnoAI/NsxArjHleYSrJwL2KBAWth99b+K2KwxFDRlI+3EIfyS1lBYFRZzxbVzUTtX9M2y1h5fPawqb5KC0nB62SJeMgaWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903213; c=relaxed/simple;
	bh=MmKPUNxZ+susb4kr/ZOyBooFet2Ni9V6EkAgfthmPGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dkbUiaoPq1vGAZp7NtwrwYczgDtMS+7ypYjDNggsGK3TfIJaAD9puZjAIYvwlHYMyA2LIHqZbeDr+vjNeknpP5yiE9BwSBpaAkJgPpkoaXZm/gdSc1u13D4gk2mcuP/vfkjDhfgaWJJsFgnpIIhe994oxCaUxfUlaa4WbKbc1/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aykzkv5m; arc=none smtp.client-ip=209.85.215.172; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2BFC0208A3;
	Sun, 31 Mar 2024 18:40:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FN5D0zVq1uST; Sun, 31 Mar 2024 18:40:08 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3478E208B5;
	Sun, 31 Mar 2024 18:40:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3478E208B5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 26CC5800050;
	Sun, 31 Mar 2024 18:40:05 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:32 +0000
X-sender: <linux-kernel+bounces-125393-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com;
 X-ExtendedProps=DwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEA8MUJLbkECUOS0gjaDTZ+uAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAGwAAgAABQBYABcASgAAAPDFCS25BAlDktII2g02frhDTj1LbGFzc2VydCBTdGVmZmVuLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAw0WmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwACAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBiAAoAfAAAAMuKAAAFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExvdw==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14583
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125393-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CAC76207E4
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744401; cv=none; b=LMfXCVjOARREdPh59SeagJj80xlOw0dTUCM4q20h410Y6v4CmiQz2Me4sL9de4b33Gcn2UBduAp3ZWzu5rIastXXmqiqJV+xj6RG3RZjIeUyEEEuID0+uBzcdCfHEuCZLcYWJ7UrjnUpcj3GGTqKipnf5yxZ1ocI0l8vi0ndyq8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744401; c=relaxed/simple;
	bh=MmKPUNxZ+susb4kr/ZOyBooFet2Ni9V6EkAgfthmPGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM7AR9T7dpbyRK6baVBAbGwCRx5D2EY395moEytKOwQ3qdDU1InM+3PyEOamXUzrf/6Pl+xycJVTi/JlLi4GdQisKwAkDB7Lt1f0ueQZus3CMYc4p8c0UZZSKRt/Q65TGEuVAlK7+5oyb5e/5cG9KbdyCqGElCCa7PbarJk39/w=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aykzkv5m; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711744399; x=1712349199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9y/dxoUHYnuLJXM/FbNFKWazEIf0YDN2gZikUVSS61Y=;
        b=Aykzkv5mDRd/lxI3VDy59EQ9qPOOG6nKG1MM8biF7qFLX0I11mEhe3oHndMtx9BNnD
         7fkqg29CCeK+vp+a4vt8yUK2PDSIWmdXHS28EK3ynJc1kCZCu8YIu4SYF7D365KbqL87
         3sdkvxybrySS9K9v4RoE3s9uTHD/szwnH3odJWFbguw+Jb02zQ1I1nWcwRjCvlOXt2tp
         r8g4dO9H70P4CaPIU5dD0mu6V+kd2E1Ds9/5j3mGHi/iYBccNhhY6rsJW17AHJdSUM5j
         CG6FntBF8Vpb2ufYvduBn4EM3OntJUk/r0xR4g91QwMKLVLyLuqDeGHDk2GJ2ipnVnJ3
         +aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711744399; x=1712349199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y/dxoUHYnuLJXM/FbNFKWazEIf0YDN2gZikUVSS61Y=;
        b=hhMXzo2cPp1qMHmbJf8ndUV9OLFKR3+CPkx1hFGqYJUTeLu/WKqlDymOhWyP6pI7gH
         f0qAZEcqto4/9plR5FIq4VesU2VsimUifj6U4C/vs70ZoV44HZhjqsu6XJjTpsZQtd4E
         OBTX/K7yAJvnsCLKNMGMf/pBsDLCshC/2KDvV+0EUMOfUHtsNwlYveBdFt8RRDYlSaRw
         WNocbOs53AsEursNUdvBJpwT+nuuFgwRFzjvMmhEoU8YN2gyFJp1+aBBBLIA7VYaF00s
         fl3WV3xtrtJ+f80fE3A4rOfCtWGqN5U7jGzRc2vrPOQTwCpjNSD1byqI8NQShASpOypQ
         rE7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRzpcFib2bdOq9gQnhZtMnV3KPXK0MIX4forYdOrEC1l7u0AWAKKTTOt2aoYlLn+f+GJ+Z1d2ogD/MvNyKdfOPgG2oGFmQGvVZ18D0
X-Gm-Message-State: AOJu0Yw/XhnP12JRZosFEXpriPPGSQCkxpOEbzXaNn+yKDw3OHU0ii6b
	gMKsNuWBQKPg+G1Zaw5Lzl5Kha20mu+VlCVNioELFcc+WEgPq7Lj
X-Google-Smtp-Source: AGHT+IENv1wF/FlhJUBdDw7gbHcuc9C7OqOL6VgCxshez/VMiYYzHneKoAE1DtcwhSriDloEUjcrhg==
X-Received: by 2002:a05:6a20:3d07:b0:1a7:1c5:4746 with SMTP id y7-20020a056a203d0700b001a701c54746mr1717945pzi.1.1711744398901;
        Fri, 29 Mar 2024 13:33:18 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	christophe.jaillet@wanadoo.fr,
	prathubaronia2011@gmail.com,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	u.kleine-koenig@pengutronix.de,
	frank.li@vivo.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH] staging: axis-fifo: align arguments to open parenthesis in axis-fifo.c
Date: Sat, 30 Mar 2024 02:02:24 +0530
Message-ID: <20240329203222.12889-3-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Align some function arguments to the opening parenthesis of the
function as reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c51818c56dd2..a70af76be7fb 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -376,8 +376,8 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-			read_timeout);
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+						       read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -517,9 +517,9 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		 */
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
-				 >= words_to_write,
-			write_timeout);
+						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+						       >= words_to_write,
+						       write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.44.0



