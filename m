Return-Path: <linux-kernel+bounces-59543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFAA84F8AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB241C219A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D874E3E;
	Fri,  9 Feb 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRyg5ylQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB60745E6;
	Fri,  9 Feb 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492920; cv=none; b=OMMMb69KY8CPmoVpxV+JTT/TJZMq4Q/ssVdsMXD/RVOmOx3yAEkPiEd1Nz3myzBmu2Uw7ujXolSD7TWH9tZ4YvbkWqTsZprn+M+/Tr5RdFwC0NmyNf8Z8H8VDZdmBWKSyU9Zt9kb1ZRx1q3e6YtACJSEWx4oaM1Gbjq1oLNQbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492920; c=relaxed/simple;
	bh=88O1IvNvhoUPItkhJIT17zF6RluHkqoSUqsZ+0BI8RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XY4xRnpkOF5A14djoUuyZDgn+bXBfa53By16ZIW71NiRyhYEgdl2FbumbK1zcvq1ucrhpyXUFmw/rkux85X9nE8em0EOyN/7El4PgkynSqBS6gBxCMrXGDEoJXU6SVF8/Lu0p5Z10iYUtNkbvMWkMDtFOw7xV+QK9DkhCbSHvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRyg5ylQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394ca0c874so596004f8f.2;
        Fri, 09 Feb 2024 07:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707492917; x=1708097717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAT34161EfW5sgXju0iwPtbtso8f8RfBNYR5j0enOeU=;
        b=ZRyg5ylQ5VwU3eH++1JYnwnDoxwOWjmWn+qd2mdr2oQa/l8PuX7QzMyfLM2aGhwzKI
         oAR3wkjtO1Q+tV3hCJMz7zJfoI9kQa8hGimdG18AHVbpydZJ2Ytv6xGbU1EvVG1Z1omj
         7RBdSHyO82eNs0ha6n98805BOoUnnFSW4VxhofRm6z4OgD+KOvn1hWYZX3g/4yzLsrBn
         hcKJCtoZSIzwnD8y4a0ItnuFcKiOvaUD5k4fimhjhkfKQ3XZXwAhTea/h6+t6/5PQYL2
         2rVZf058GzaRYtQAhc1NjEKRH2C9gaXdQ5XdLx5233uQ4NArmr0z6lZYjMhxcpzGvwfe
         VciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492917; x=1708097717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAT34161EfW5sgXju0iwPtbtso8f8RfBNYR5j0enOeU=;
        b=GqSeNrGA0jf1t0FDuX+p2aBWyYJwc3LyKmZMW9QT3Cz0Szj01z7+UGzUKKyA9i9Ahc
         2uH2IFvj3jo+Y7sE6n5Zu3NjfG56aQbtoI3IrZedA5zwfBbCD2FMWvfwZGBGJoElHfJK
         MpVXXKX3WtIXBSvwbAt6hb2HYl5ft/49YTnHwiH62eqDN7kkxLSv+9+BB6Irf2fD7ezA
         CCs32RSialz/DZo0lY/sBOASeoMAR0qDRm8vX/BNsytU5VuGhdqVtC/kvUfm81NXwpI0
         FXzzDgMUIvSvlfF9UTw0CRko6xjAjSic1uP+DVPMtd6hYmI+QAsZz4D3h9+Qz2tyOpDv
         f5ow==
X-Forwarded-Encrypted: i=1; AJvYcCUolCCC8AzscVppyGuoK/qWu72XgYq5pVPMr7Hz+jhj6ol2vxzQrxgrqRsAblIRCf5WRe8Rivyei6ax2MTg3iFazwXndaRhUi7qDTpM
X-Gm-Message-State: AOJu0YxZHkpfk5MOMDfm06KdIgdEXiQpbx/t+TGjZuhhtlfVeMZ7cpj+
	APkPF62rOcbWidyaKxhMtwQnqM3I95giXsz7mKAcxewo6c80r17oHI2m+i9Y
X-Google-Smtp-Source: AGHT+IF6BpSvrmeTFfFPXsyO27Uhod5vrDBE8oBmK1i2RirLBX9b6voqS6A6qbuQEw0POTrPTLAwaA==
X-Received: by 2002:adf:f74d:0:b0:33b:1ae4:10be with SMTP id z13-20020adff74d000000b0033b1ae410bemr1715227wrp.46.1707492916956;
        Fri, 09 Feb 2024 07:35:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqer6QQBQIcidYjgAevcpkEKqSP3hyk5041XdZh/pmiGnOmjaeMTv1mveN66DyD/Ar8HM3HwE2CVBVaTWyFDkQE/5bSaidgUSKUcz4
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600002ad00b0033b59f4d46esm2082117wry.108.2024.02.09.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:35:16 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.8-rc4
Date: Fri,  9 Feb 2024 16:34:57 +0100
Message-ID: <20240209153458.1741231-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc4

for you to fetch changes up to 07045648c07c5632e0dfd5ce084d3cd0cec0258a:

  ceph: always check dir caps asynchronously (2024-02-07 14:58:02 +0100)

----------------------------------------------------------------
Some fscrypt-related fixups (sparse reads are used only for encrypted
files) and two cap handling fixes from Xiubo and Rishabh.

----------------------------------------------------------------
Rishabh Dave (1):
      ceph: prevent use-after-free in encode_cap_msg()

Xiubo Li (5):
      libceph: fail sparse-read if the data length doesn't match
      libceph: rename read_sparse_msg_*() to read_partial_sparse_msg_*()
      libceph: just wait for more data to be available on the socket
      ceph: always set initial i_blkbits to CEPH_FSCRYPT_BLOCK_SHIFT
      ceph: always check dir caps asynchronously

 fs/ceph/caps.c                  |  9 ++-------
 fs/ceph/inode.c                 |  2 ++
 fs/ceph/mds_client.c            |  9 ++++-----
 fs/ceph/mds_client.h            |  2 +-
 fs/ceph/super.h                 |  2 --
 include/linux/ceph/messenger.h  |  2 +-
 include/linux/ceph/osd_client.h |  3 ++-
 net/ceph/messenger_v1.c         | 33 +++++++++++++++++----------------
 net/ceph/messenger_v2.c         |  4 ++--
 net/ceph/osd_client.c           | 27 ++++++++++++++++++---------
 10 files changed, 49 insertions(+), 44 deletions(-)

