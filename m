Return-Path: <linux-kernel+bounces-145263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE98A5193
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7921C221DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16971B32;
	Mon, 15 Apr 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MINR683H"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BC208B0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187715; cv=none; b=QfEpeufCRmElblTCRMJobYo606Wt09FZLyRd3HB9w2xYs9fhLnYOF205/HqNvG9XR34ESkLuzjZQqGrpjg3pTFPAzfZPue/PsLbUMPVosIK44DDOkAGSyWzRDBoIwMbCyXj0fiBw7rovWlJcQjWuo/W0foEfMmInlybEfVhY6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187715; c=relaxed/simple;
	bh=U6LCFREtmhAKiNxiTV+c/BEbEz5M9PsN3FdEC6RpvmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yw2qSQQv6cuYb1f9eicZ/kw5DQuYvhKdbb4ySVZydDeb9JiqXtUdYqzY1D3w7GZj55gzGiX6uyjUGPdfTu5ItoXUK5VgSPhZBNAu0z9kr5koOuDcHJb/mJxq8aFZDiHrCQ/4IqkAy8NrqSLD357/Qkb31mEhkoVlCFtV2bodvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MINR683H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso2929913b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713187714; x=1713792514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Q+QyCzePJOGae2CxQZUXd6ef7zaDXiIcFV+FCC8H4=;
        b=MINR683H31gnYTwttDyvw+JWL/KFt19DSUPIoUhKaIs15A8zUiDYPfYx8Tr/TZ6nTj
         iY8FbKE5ivans5BfkcfxRC4OIgR1R21rxEDizsyBhjw/p2vGRovB+AwOO/LjUwPfL9Pb
         NMrkTm6gOTD4sqvVLULKEfrVzfiS0yJPk8WgMnNTTaypA8ePSd44t8p6cs/a1Izebodd
         Yw2no6jmdOe82fJc4AvaR5kQhrAJi6FaBebQibqLue7E/J+vb9WhcBEAfYhBFjOenzEH
         /yXZO8Wn/20W9AWg2BjWiwsKFWp2VSD2OgT+1rgbkFQ4jUC730gwcLgJMqxZmiWcamfN
         zHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187714; x=1713792514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Q+QyCzePJOGae2CxQZUXd6ef7zaDXiIcFV+FCC8H4=;
        b=iNScwwhRzPVOPuzSujsA6vNuzG6xuBVp6UNLPKT9VdNy+pjlcyjDDEGtSH9/4Wl+Rv
         COT1khvw2g75IyabHHiAPKIJjGPFjSw+Zp28JPPwP3k5T0fjnYRi5ICt3M2pxMKK/+e9
         z1G4JpjvLbUbXqIL4V5y+gjLQPGPy+pBmA8ReC/8pDtxkd2VI/uq1Rv75YR4QVep6X5R
         8eDuLhS7btP4fqaX4PcP6WUfYe9LFY2EJLDsQGL0JMerS/MZG20oX8C8xRd8w+7Mhpg5
         LN5e+vmD8Eb7PJ04c+8KBjBojPtuSmneR9ojcMJWTONhfG/8V86d2XwiACOAtsoNeRc8
         rMFA==
X-Gm-Message-State: AOJu0Ywu1yEElP3iNGveQ7LenR3+igWF5K0Uz8d172+sqCGPlaPfkkV1
	jq6quGInhgtMHJoAqe8uTWkrzyQSX6HgZE9cvBR+is54Y/hv1XX5GFt0sZM6EHc=
X-Google-Smtp-Source: AGHT+IFZG46yDlVLpxs9yg8YkzGdOAvSs+gkSOrt2oriHcSFfcYep4yEaxrYO1nCp90o5ApolyAPIw==
X-Received: by 2002:a05:6a20:c101:b0:1a7:3d2a:7383 with SMTP id bh1-20020a056a20c10100b001a73d2a7383mr10580421pzb.18.1713187713799;
        Mon, 15 Apr 2024 06:28:33 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 13-20020a630b0d000000b005f3d2592b5csm7069147pgl.47.2024.04.15.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:28:33 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] UBSAN: array-index-out-of-bounds in nilfs_add_link
Date: Mon, 15 Apr 2024 22:28:28 +0900
Message-Id: <20240415132828.149954-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000209c9506161fd1d4@google.com>
References: <000000000000209c9506161fd1d4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test array-index-out-of-bounds in nilfs_add_link

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0bbac3facb5d

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index bc846b904b68..aee40db7a036 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -240,7 +240,7 @@ nilfs_filetype_table[NILFS_FT_MAX] = {
 
 #define S_SHIFT 12
 static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
        [S_IFREG >> S_SHIFT]    = NILFS_FT_REG_FILE,
        [S_IFDIR >> S_SHIFT]    = NILFS_FT_DIR,
        [S_IFCHR >> S_SHIFT]    = NILFS_FT_CHRDEV,
-- 

