Return-Path: <linux-kernel+bounces-67901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5EA8572BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC23B286ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECF5C83;
	Fri, 16 Feb 2024 00:43:16 +0000 (UTC)
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA93FC2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044196; cv=none; b=C47KMnuJEkbbsTLJsuifF3MsEytQSBaV9uUakgG4CdnH56YvmgrkHI22E6ZZ8IGMEdRFSstTd+Bk2IidKEiDHgEUoL/gNHEMF/afrZd0Iv7PxYRhik5GbPRSHPBYq4HGMJ2I3ZEp1GCedMBoRQDweE0UkHKVuAYYDfpkrqwer8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044196; c=relaxed/simple;
	bh=wSbxXqIKJT7TaCDvgURgoe+5TOEp8hHL2YDsmXjPoDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hht0hbfiCY4uMeyB7QyrWDICyTkWKOdhtEurakVoNV1xvJlcrKkC1lTQxNLbGEHIaufQOc5tr3Hfe9My6dXXYsoXg/SQ0qrIQCknf7lOjY6TasIPUUjRA0rxhjsxzRggQbEizns4Do+ZGjKP1esM9VvONlDhonDi5H6phUUvFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.24) with ESMTP
	id 65CEAF94000064BC; Fri, 16 Feb 2024 08:43:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7824531048585
X-SMAIL-UIID: A00B892547194C9EA311F605BD03F386-20240216-084302-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (2)
Date: Fri, 16 Feb 2024 08:42:48 +0800
Message-ID: <20240216004250.1196-1-hdanton@sina.com>
In-Reply-To: <00000000000028b68806103b4266@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 02:22:39 -0800
> HEAD commit:    f1a27f081c1f usb: typec: qcom-pmic-typec: allow different ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429ed40180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ y/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	pvr2_context_destroy(mp);
 }
 
 
--

