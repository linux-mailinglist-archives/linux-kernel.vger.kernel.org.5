Return-Path: <linux-kernel+bounces-46921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE33844661
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FBC286E51
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8A12F582;
	Wed, 31 Jan 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVTBHn6B"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D612DDB6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723047; cv=none; b=pYnjxwc6sLyPSBbmfDuVQcwaFYmK3BAZIpnPErvpc6C3BV4zopGWAuCjf72dhs9w3Bp5W25m9+TxRQY3PLeh7742FpsS7MaR2lkr4JBBmUJZIJ7jZjHQjNMryRyDfXzwql66WEz3CbyARtaffujhTj3/VfNuPKVsBHUKchGmRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723047; c=relaxed/simple;
	bh=Ugh7VKi1ShFc2ClVvC5jt2j8eAiyzly2zEmvFpkPRq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jm/krOK4bvlNcLFrd4KliF+cuSV+B5KL3lxc+98AHJn20btqGe8p1VPBs9T0BsZ9u8LSWcC0DvOjwqqSHj7KELXo3vQR9aa1bgptudWn5IkdyiQQlYF23iTTcKClXwM0+FwzhM0Bp9NnWNbuIqwC1EcanBlpsxC38pWpAS5Lc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVTBHn6B; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d061f1e2feso1164551fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706723043; x=1707327843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZCcNBKKhxrakI+OhQYIle3EemdgasQai8TCykdufEg=;
        b=oVTBHn6BQBH6ygP/CuTNOZjl7xynV3Hkafxvi7NmjHlvVJW/Al8AvIezVh24Z4iKPo
         X9LyxgEJR/RdxJJy8TN1FG3gkPJcf0s3KiyZlgoLZL+oeOZ7vJWOn230uBa9mAxBI0ML
         azesH2/APLM+BMk1kpkf55R8damu7E81QiTjONnDObP7mPQISutTeZzmvp73Dg835CJl
         UAidZYgfvlM/sET5fMEace0rAwQLNgrEkRv1rxvV3x7zbJMJqGtFN1Go+KhkKHKpmKGu
         3Vc45J3QPZd9hsFAWylBDuC5tQeDL7rNzhDWkM7UZQmzLzt+SpK9hgNkhoxgDdeavren
         MIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723043; x=1707327843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZCcNBKKhxrakI+OhQYIle3EemdgasQai8TCykdufEg=;
        b=hl0aOTSr78JKBQcDRS1ovD+q447mr84PdlDUcl5UFO03PFr62VgFPlP2dwPlNSSGIY
         /CEBWfSZ+sWEjP0BDLQnFKUwKMaYf4pf3HBJEVpAeKyuq9FeVFsJnK70aQ9iE1efVtvm
         QPaaJ07/FPpeeaQ2qkzttSRu2yJY+m0EY6EpuKMYSxJSMx0F4jOjZirLfMW81++1wSi8
         2DuWsgyLpE/GqROhAVqp58XDINytsNRjkxtTuQCY1iEu62Y3mHPQwsN7Nve1we0Zz4L6
         k9yHWpZ5m7T3tWM+ewKNuYt2p1BDfvJSknmTcgsov3kZW42VPwiKGSJ3LJC3jDKpOo78
         H3XQ==
X-Gm-Message-State: AOJu0YzLcD0rKB3xaAeHP8+8JmE6NutQysNN3mxqsP5QFgIO4vtgSoQ6
	xKsVzgDmHPW48SShfn7cFhnWDiPAnI27gBSEgLtt8SK556vmbhqMFtlXhWKHzU4+krsUEKZVl1M
	h
X-Google-Smtp-Source: AGHT+IGiBf1KX8X5Acdx0UeH4kD0KnV+WqmqFs0cWzamA+feCMrQ4xSy1eInuqd9t1AnQ2s1jZ/a+A==
X-Received: by 2002:a2e:950c:0:b0:2d0:4ef8:3472 with SMTP id f12-20020a2e950c000000b002d04ef83472mr1595779ljh.47.1706723043183;
        Wed, 31 Jan 2024 09:44:03 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402444b00b0055d3d1653b3sm5712985edb.31.2024.01.31.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:44:02 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 31 Jan 2024 18:43:44 +0100
Message-Id: <20240131174347.510961-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

It's been a while since Shyam posted the last version [1] of this patch
set. I've pinged Shyam, but so far I've had no reply so I'm trying to make
another attempt with the RPMB subsystem. If Shyam has other changes in mind
than what I'm adding here I hope we'll find a way to cover that too. I'm
calling it version two of the patchset since I'm trying to address all
feedback on the previous version even if I'm starting a new thread.

This patch set introduces a new RPMB subsystem, based on patches from [1],
[2], and [3]. The RPMB subsystem aims at providing access to RPMB
partitions to other kernel drivers, in particular the OP-TEE driver. A new
user space ABI isn't needed, we can instead continue using the already
present ABI when writing the RPMB key during production.

I've added and removed things to keep only what is needed by the OP-TEE
driver. Since the posting of [3], there has been major changes in the MMC
subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
is in practice completely rewritten.

With this OP-TEE can access RPMB during early boot instead of having to
wait for user space to become available as in the current design [4].
This will benefit the efi variables [5] since we wont rely on userspace as
well as some TPM issues [6] that were solved.

The OP-TEE driver finds the correct RPMB device to interact with by
iterating over available devices until one is found with a programmed
authentication matching the one OP-TEE is using. This enables coexisting
users of other RPMBs since the owner can be determined by who knows the
authentication key.

I've put myself as a maintainer for the RPMB subsystem as I have an
interest in the OP-TEE driver to keep this in good shape. However, if you'd
rather see someone else taking the maintainership that's fine too. I'll
help keep the subsystem updated regardless.

[1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.microsoft.com/
[2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
[3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
[4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7269cba53d906cf257c139d3b3a53ad272176bca

Thanks,
Jens

Changes since Shyam's RFC:
* Removed the remaining leftover rpmb_cdev_*() function calls
* Refactored the struct rpmb_ops with all the previous ops replaced, in
  some sense closer to [3] with the route_frames() op
* Added rpmb_route_frames()
* Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
* Removed all functions not needed in the OP-TEE use case
* Added "mmc: block: register RPMB partition with the RPMB subsystem", based
  on the commit with the same name in [3]
* Added "optee: probe RPMB device using RPMB subsystem" for integration
  with OP-TEE
* Moved the RPMB driver into drivers/misc/rpmb-core.c
* Added my name to MODULE_AUTHOR() in rpmb-core.c
* Added an rpmb_mutex to serialize access to the IDA
* Removed the target parameter from all rpmb_*() functions since it's
  currently unused



Jens Wiklander (3):
  rpmb: add Replay Protected Memory Block (RPMB) subsystem
  mmc: block: register RPMB partition with the RPMB subsystem
  optee: probe RPMB device using RPMB subsystem

 MAINTAINERS                       |   7 +
 drivers/misc/Kconfig              |   9 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/rpmb-core.c          | 247 ++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c          | 177 +++++++++++++++++++++
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |   2 +
 drivers/tee/optee/optee_private.h |   6 +
 drivers/tee/optee/optee_rpc_cmd.h |  33 ++++
 drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   2 +
 include/linux/rpmb.h              | 184 ++++++++++++++++++++++
 12 files changed, 890 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.34.1


