Return-Path: <linux-kernel+bounces-87782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D186D8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236641C21083
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB92E40C;
	Fri,  1 Mar 2024 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIvwGQoO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192C2BAE7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257099; cv=none; b=DDTomB6eao+MNRVFG3j+a4JokxaOX/qR6LzKvqICq7CaQSAEqydn7pPJQYiw7kSjdG/wQGboWocK+/6IRLjTFeYEa+jHI/V305ih9zH9a5iMr/zii98xVxid6w13DXZnhhlNHIOXlKFbrGi770V7/RlKlDTArLsVC2c/A1tetqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257099; c=relaxed/simple;
	bh=KMpxKpbpjeoQqcOIhlHPKvhUGkSROvNhsAYmAL2oE2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZPw5m8T3ZWG/nb5YX8tPWj4TNfJSCagu8InWhBIktkAlrmMwXn42Y/AivlDOrQyp5jlZdRRXK0QXvkhpLYEZKxIOE8qNKit+J/eUsELM9ccS4cW9HsFyk7MIqXF6+Q4bQ5vJ5msVfnstftaBLC6jNd7PDidaAMrtHmjBRKDBjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIvwGQoO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2738583276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709257097; x=1709861897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CWSEzr83qDpP+Sd5Vt8txQd9Oa0cdIaTZ7C0izQO4eA=;
        b=fIvwGQoOvFWge1dBEWoKXM+lpbDLzacvG2+mc+8DzCbwZlmiZF/obxOftllakc873O
         TO1JAaEdhcyW1oj3MlxBj5oj8+omC5oldVHdO1oqTckZ0rqlehWEX5A3jfGq5y1dZRZ8
         oDXkYw0KEQoRMqahc2bykMoM1c9YRJvITd14Z5HfesnJQpOyxWnKwjM+Vl7OnUecC8Dl
         1LmHspnJILDxt+6g5FjvP4KA0va/P6kLLEkivlm7KnOwKeEvU0mHvYqYlWGBXUN/DOMT
         lMjuTFrC5GnV0u5/bW6bpMKZPBFBX2IqVr9uBmLLK/x3CBkmCmqRmT2DlcqEFRSOelQe
         sDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709257097; x=1709861897;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWSEzr83qDpP+Sd5Vt8txQd9Oa0cdIaTZ7C0izQO4eA=;
        b=gYwDs3ppjbtgCTi3MUDCYCox4H+D4ZwCOTridiroMFcT2v2ZXsnKDtPCtIx1F48jUK
         nx6IBbHdo0CiYmpSg05XpXaszGzOTqkF8Uqb4H80GiYOh3EkHJ8g6nKD9peqhO8Yeh+I
         fXPsUcDYkrg3oIFeSpjhnmTLxA8xpwaNwrT3u1gfltG1spk4wAL1L23b3MCcFychdmif
         kiTlRrheVf1Jevzxkue68ZTB4Tu2a7yKWAkAUDiZw2zl97EzP2mpvpJwW8tfefsqhzxK
         l0Wgb9QOgjxKrDmtitp20HpGmE1Xlz/EdDuyewUoQz0kBGY68ovx7VOaYX12sTFkJmCM
         lfrw==
X-Forwarded-Encrypted: i=1; AJvYcCVaoxxrZzP3JpudiUqWA1aYTDVJueTXNk079RboSvQtmB3pA1dXv4ngCcIdlTJeoVbhrlj+58roB54k8SIPQz8nnYeuCUm7ioxaUqZM
X-Gm-Message-State: AOJu0Yyi0wuXlpNSZaApOqi4YPDY1Z4jYUpGBZlUF08MfAbHZi1mPEzw
	8+Hc+YUZjedyzwPwe2ghoBUAGJzjsU3xr5S37zZAEbTtgXSYnhwll0NyDyCh8yMxmmOIGzSV5Uz
	v7l/UcyxR2Q==
X-Google-Smtp-Source: AGHT+IE404rz7EDy2MtSWy82xprXTyrLWHNGQHVJXAyHGYB3tIhAtfRmvWt9ht+SCiuuaQ95Ip2J5VNwdGzIlA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:3564:51b2:6cdf:92fb])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:728:b0:dc2:1f34:fac4 with SMTP
 id l8-20020a056902072800b00dc21f34fac4mr42691ybt.2.1709257097144; Thu, 29 Feb
 2024 17:38:17 -0800 (PST)
Date: Thu, 29 Feb 2024 17:37:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301013759.516817-1-ipylypiv@google.com>
Subject: [PATCH 0/3] NCQ Priority sysfs sttributes for libsas
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
attributes cannot be used directly because the ata_port location is
different for libsas.

Igor Pylypiv (3):
  ata: libata-sata: Factor out NCQ Priority configuration helpers
  scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
  scsi: pm80xx: Add libsas SATA sysfs attributes group

 drivers/ata/libata-sata.c         | 130 ++++++++++++++++++++----------
 drivers/scsi/libsas/sas_ata.c     |  87 ++++++++++++++++++++
 drivers/scsi/pm8001/pm8001_ctl.c  |   5 ++
 drivers/scsi/pm8001/pm8001_init.c |   1 +
 drivers/scsi/pm8001/pm8001_sas.h  |   1 +
 include/linux/libata.h            |   4 +
 include/scsi/sas_ata.h            |   6 ++
 7 files changed, 190 insertions(+), 44 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


