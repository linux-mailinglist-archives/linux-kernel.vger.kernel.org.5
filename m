Return-Path: <linux-kernel+bounces-153735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D38AD27E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04C51C20E19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D8154431;
	Mon, 22 Apr 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/KvQ4Ex"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36934153BF7;
	Mon, 22 Apr 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804133; cv=none; b=j9nVy3iTdobqmNFp+zVB7SZPDfqmSuAKFGuQnJkn0+mD+s5HRF4ceku+KK19mUcwpq9CRL9C6Aj0cpuwlTHjrjhNYcTEjGBXhmFYWOz2q+8etT15GezaaqMpuNsgVZoYCUTvug0w/AcGD5QcWZI5YK1dqQ73e9wFRsoTB61SfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804133; c=relaxed/simple;
	bh=4k4l2I6DGmn+gj2ky1zg3DSJ96wBO9Y/fF4JVtQyMUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W/49fHBM3N9nmdWZNc6IpQI+PCnKZa3FW9NFRV/dqDmrKpVJSIos1HWjfnl1ZvUJvAjGwNJiusqOp3nGgZWGyMZAxQ40Y1jAcCQdIeOAgcRJ2E8oET33FLmuZwiAlpPdAa1M1oXATU7hGu/O1E4WPArbgjb5VX4YDjy56s/7FZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/KvQ4Ex; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e5b6e8f662so35962175ad.0;
        Mon, 22 Apr 2024 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804131; x=1714408931; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ/s9bshwX2Z/U5SUCiWUY86dhIqbJUGtlQVX2ISVdU=;
        b=b/KvQ4ExVqmKddxjtkltFTZA8xjaGylYDvtpyAAFC0HFjf+zGYSOOFc/ZAe4sa1IZw
         bHnlwvVp0WErMqfs+c1MeIBqcvu8xPl1O4kkjapKVEwuQ0973EFKQ7UYklh5C/mWWNBt
         ADIDxtF2JHmOtDOct5pvXbULwX3zlWbS/BOKU+8t1AnyD4kjrpFo2MBGJbXRJXoEUKPn
         3A40ERdsmjIzadR0eD+LotnW/cJe7jCi+x2CnFkHxjA8ANsN8m9KNFtj1X6CdlymIkAa
         g1uxDlZlO30XnOWm4Qi8o77ruXGEDUcuHeG01FNTft6JGryX3/CTNAXQZA9nYLQy02f4
         /rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804131; x=1714408931;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ/s9bshwX2Z/U5SUCiWUY86dhIqbJUGtlQVX2ISVdU=;
        b=Jjhx5n9zDJO/pzvhwTbNWv313ErPfuaQ7AqfOkj4qjwKs+toTSu1htvfARpipuKPIt
         xYTOreRF2dI/hnA7UrpxHwZHXTwXZYtn6Kbp4723IzCHD41rb4Gq/eBKTQft/B9mdE9d
         IciwO9ad/2mbs1kqLaSyFE9Ai/xs9YlUfO3oGzAh2m69XdRR6d02sn7xNc0pSsdMDs8V
         kX/Hv5o1AaZAj0BO7Y08JkbyySXm50Igq7Oqj0YHAMAGaTw21YHOFATISbVoL9oi00Sj
         lnmD+xVPBAR2t8dTuL8tbntmEkbc86J7HJy/tyKFUn4s4OisXWGGiQymjuJM1VYghDqj
         A7dg==
X-Forwarded-Encrypted: i=1; AJvYcCUPqxGYGtFRAyc8CCsYku3dM9LQ/VebXybl/GoVvDeVsJjekBJh49+xYoLlvPRHMVcy/9CaRVE4OGM5XDINFfpyK7ejc87/JNtiCEqiQlbOM5yxxEbjy9iy9EXSbrcMOc3PSoMGu940oqVNlbKugz+Q40hhBzv9nULvBiUXRbINlkTn2odvPwBejkE0NzcQ9oYx+HoI9M9c3jE1eT0=
X-Gm-Message-State: AOJu0YwKnX+HVTzxsIdt8T0L60ncD2EmKLD9lxtnKuppEKH447deGt3I
	FmeLJl0lwViOOEqyewCKdmcqDl41JH8crO7d1rWeaIC8KeezohE1
X-Google-Smtp-Source: AGHT+IED/ttmM4v5ReF4QaWXjGqNL66DutVSsH/8jOtbJsWcX9E8Nfp6e2ZYUo/WyQMOpfHpKmMv3A==
X-Received: by 2002:a17:902:d4c7:b0:1e2:76ad:cb2 with SMTP id o7-20020a170902d4c700b001e276ad0cb2mr10960924plg.15.1713804131274;
        Mon, 22 Apr 2024 09:42:11 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:f32d:f608:a763:3732])
        by smtp.googlemail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm8461702pll.225.2024.04.22.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:42:10 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH 0/5] Ensure the copied buf is NULL terminated
Date: Mon, 22 Apr 2024 23:41:35 +0700
Message-Id: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+TJmYC/x2MQQqAIBAAvyJ7bkFNsPpKdLBcay8aChGIf086D
 sNMhUKZqcAiKmR6uHCKHdQg4LhcPAnZdwYttZFGawz8Yko7ZnIe1ezIhimMVinoyZ2p+3+3bq1
 91dxRI14AAAA=
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Krishna Gudipati <kgudipat@brocade.com>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>, 
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, 
 Manish Rangankar <manish.rangankar@cavium.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>
X-Mailer: b4 0.13.0

Hi everyone,

I found that some drivers contains an out-of-bound read pattern like this

	kern_buf = memdup_user(user_buf, count);
	...
	sscanf(kern_buf, ...);

The sscanf can be replaced by some other string-related functions. This
pattern can lead to out-of-bound read of kern_buf in string-related
functions.

This series fix the above issue by replacing memdup_user with
memdup_user_nul or allocating count + 1 buffer then writing the NULL
terminator to end of buffer after userspace copying.

Thanks,
Quang Minh.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Bui Quang Minh (5):
      drivers/net/ethernet/intel-ice: ensure the copied buf is NULL terminated
      drivers/net/brocade-bnad: ensure the copied buf is NULL terminated
      drivers/scsi/bfa/bfad: ensure the copied buf is NULL terminated
      drivers/scsi/qedf: ensure the copied buf is NULL terminated
      drivers/s390/cio: ensure the copied buf is NULL terminated

 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_debugfs.c    | 8 ++++----
 drivers/s390/cio/cio_inject.c                   | 3 ++-
 drivers/scsi/bfa/bfad_debugfs.c                 | 4 ++--
 drivers/scsi/qedf/qedf_debugfs.c                | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240422-fix-oob-read-19ae7f8f3711

Best regards,
-- 
Bui Quang Minh <minhquangbui99@gmail.com>


