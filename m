Return-Path: <linux-kernel+bounces-55312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB084BAC2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC01F24363
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759D134CFF;
	Tue,  6 Feb 2024 16:21:56 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E2134CE7;
	Tue,  6 Feb 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236516; cv=none; b=tX6/YQe1cqxqcA1GxTQCTr1KU8l8ehj0myz7w8Gzndu86ytmif1S3ewFcZsmgn6y4S/EHFnp4b3nvdJZLsOmAgZs7KtvoAuVin0OcMUTCC8OmOgnVyloy7xwfoFJ4zd+k4OyLereY/4L1PcR2u3ciYP+l64ZHlU2gG/PM/9cB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236516; c=relaxed/simple;
	bh=NbkL5XfG6+SdYyqh4jAsn7dWL31t3PQHaDc2LY+xSQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsINK8BSi0mOgGThKYTa0l6nwTSFRrS2/kedT6aj20xJxBk8sO80xOSoF53l8r80pTv3rv/LT9GIg/wDOogbTgFNT8i5FATHDG06HhQdKTOuYmQFcpqf09B8kQfLwRgMU8tNBNDrCgO4Yb14JV8ZLn56X9fy81KsZIO8EQ7bcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id A655D2F20247; Tue,  6 Feb 2024 16:11:48 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 350FC2F20247;
	Tue,  6 Feb 2024 16:11:46 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	keescook@chromium.org,
	sfrench@samba.org,
	pc@manguebit.com,
	harshit.m.mogalapalli@oracle.com
Subject: [PATCH 5.15.y 0/1] smb: client: fix "df: Resource temporarily unavailable" on 5.15 stable kernel
Date: Tue,  6 Feb 2024 19:11:10 +0300
Message-Id: <20240206161111.454699-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ATTENTION!
Before applying this patch a conflict patch in the queue needs to be removed:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15/cifs-fix-off-by-one-in-smb2_query_info_init.patch

Describe bug:
After mounting a remote cifs resource, it becomes unavailable:
df: /mnt/sambashare: Resource temporarily unavailable
It was tested on the following Linux kernel:
Linux altlinux 5.15.148

The error appeared starting from kernel 5.15.147 after adding the commit [1] "smb: client: fix OOB in SMB2_query_info_init()", in which the buffer length increases by 1 as a result of changes:
.
-      iov[0].iov_len = total_len - 1 + input_len;
+      iov[0].iov_len = len;
.

[1] https://patchwork.kernel.org/project/cifs-client/patch/20231213152557.6634-2-pc@manguebit.com/

Error fixed by backported commit in next patch  adapted for the 5.15 kernel:
[PATCH 5.15.y 1/1] smb3: Replace smb2pdu 1-element arrays with flex-arrays

P.S.
I have already  backported similar changes for the 5.10.y kernel [2],
but I did not know that there was the same error on 5.15,
since I only deal with kernels 5.10 and 6.1.
Therefore, this patch is to follow the rules of backport to stable branches.

[2] https://lore.kernel.org/all/2024012613-woozy-exhume-7b9d@gregkh/T/


