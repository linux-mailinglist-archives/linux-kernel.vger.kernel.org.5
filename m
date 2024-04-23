Return-Path: <linux-kernel+bounces-154882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E988AE26A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B7281C64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE596311D;
	Tue, 23 Apr 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="F888TDTK"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54F1848
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868834; cv=none; b=SSbTOGwsvXZRephuLRtDTyc3oyCeQHigyQNSE4gRF3mqQlChFp/+eHcdMvqG7MBWn/Mb7nM+9/nLFTPdng3DpcqYGL6zMoitPEGZppsExnb0PYA2LNheh221l7dm20K8oXzy6rqZFLCAhJ74boGUNRiXXgcufDvoJu4VGM/wdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868834; c=relaxed/simple;
	bh=PnWUD+Sqv3+TieM+uGRjPKScvH7Uy5HVrA46uvF1aIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMV2hUKRelq2KVTFHwW4VNkfBin5ju/eujrtiSY5yDuCzZvSBl//nvH9qZYnYnMeCaVegJl+RD91AF6aTo2k1wGHdhw7zxypyk82AxcTUd9XUsLQNvR0i34z7Y7eeSz4gC1IyCxpuItPNzGz5uNOp/nOqFy7GU/o8MvUYvltDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=F888TDTK; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3b13:0:640:bf9:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id E4B9860CEF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:40:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MeHq0QCOr0U0-cNh1w8fB;
	Tue, 23 Apr 2024 13:40:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713868822; bh=DTN8m/cCmxiNz158XvI3+KxfPWKaEUQgWEoaJc57/BQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=F888TDTKaJMOkqNoYUu2sfulrDHZUIsAMsMGZOBYY4E0dAafM6KNOix/MQXtwYVty
	 fS3lj04n828fKhAKqMK4r0vQjyBI7JgPgv/mb1ehqF5lk4PbABbVoIRl3vFc9qO2P2
	 Tiyv5OJSpppCmTA8qMQYB8tjVE/4acotfnFGOCvc=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>
Subject: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Tue, 23 Apr 2024 13:40:00 +0300
Message-ID: <20240423104002.9012-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch-set implements the OA2_INHERIT_CRED flag for openat2() syscall.
It is needed to perform an open operation with the creds that were in
effect when the dir_fd was opened. This allows the process to pre-open
some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
user, while still retaining the possibility to open/create files within
the pre-opened directory set.

Changes in v2:
- capture full struct cred instead of just fsuid/fsgid.
  Suggested by Stefan Metzmacher <metze@samba.org>


Stas Sergeev (2):
  fs: reorganize path_openat()
  openat2: add OA2_INHERIT_CRED flag

 fs/internal.h                |  2 +-
 fs/namei.c                   | 52 +++++++++++++++++++++++++++++-------
 fs/open.c                    |  2 +-
 include/linux/fcntl.h        |  2 ++
 include/uapi/linux/openat2.h |  3 +++
 5 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.44.0


