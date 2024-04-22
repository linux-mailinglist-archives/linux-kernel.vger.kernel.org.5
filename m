Return-Path: <linux-kernel+bounces-153077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400938AC8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1FB22398
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1564CF2;
	Mon, 22 Apr 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfYUo3wY"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200953E35
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777587; cv=none; b=OCRXP+PN+1s2NfTmqvpvyS2P9xUPP2af7fscd3MV0pzKqajiPbUCb1Qhz0WQnEoqEtIZ42aoBqbbloVrU4FZAGN5+avebQeqXi2yzQgR6WKsnjE5iVHORJY7z18Xy6SFaB7SmYjKVdS1dx3rouAXq28yb10jaaafYy6fgCTQBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777587; c=relaxed/simple;
	bh=I45VUWhuXURUSVj+8uJKTDfPULq0Uh+WYABE2W57hjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WOeCkHKuhmzAZxnaKMpboi/VClW8YxfRhDQssFYmIEgJeGoxM7mEP2Yaq0/5SVZM6+fvyYmohG+hlxyrczL+o1rjviHpql4AQBjeD5U9raRFi3XiLzxle5H2HEZlG5bprO84+r2IZMNlSYOEDunBVzxR/mmDec2AQRNUsvygWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfYUo3wY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5196c755e82so5811550e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713777583; x=1714382383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGzCOSU1rFq/B8hSMfK1PNYMgY5AsUXkBH/HL6E/O8s=;
        b=HfYUo3wYeDXsm6pIoCrUmtPOMFwKOVq5RCos2Ti3xiaAglJk70Xslm8sZigY4sk71C
         LXw3JwaiTpjAhm32qdJLQWb2+xsZS+mVuqdSIFc5FOYOjT8wZtz7/RsyaIXK8jKuG3v8
         kLTsz4Dfdy7ThsFNXjo/0ky6HSSxaGbtPcteJeQu0TOgdQNK7dbNNJ/gvltQX4j+gsys
         ZED382hK0aX6IqxOmoSRUymlpHCTLbbfCq2M+zQ734L0cWMOUVRIDwk+AsUpeMBRmx1x
         /nnHMK19ZvP7j9/PSpx+AjTC324m3g17XiBAuiJCcN8fkfg1gtaNj7IfquwTbBZDapbg
         KfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777583; x=1714382383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGzCOSU1rFq/B8hSMfK1PNYMgY5AsUXkBH/HL6E/O8s=;
        b=GQpRaGZblEk59vURUzMQNZdb/pJW20yujjE5KFqvxprYonvDNg5rC4mqTU3Df97iJC
         HcmLo/+FSkbR7qPYdwNlwZMvZhHmAODvLJrOkijzoJeFoUmF96MLOH9RjTLd6rA6oxDi
         xS3yWQSKuFkAIFFu+Qhl+io3kAD7yYQLdPVubQ/HUBpZTQ2hK6k23s6+A7p74ZtTX54t
         2wCo4jjh04B+R9SvqluNq0n40wuo4YyDMKMpBvXwFmtauwfPLlDBR3XdgHnyFwhYN5ZQ
         QEg8Xm4p3S5ygKtQ8EC5bFgm4blPnVe41CKZfygEBwML/B4YDE9usL1/N8kpX5tirm0Y
         A1IQ==
X-Gm-Message-State: AOJu0Yy1gw6GV6ZZRisJagE2TPkObHNSVQkQnSHTP8a35OCnRh+mI9cq
	KaPrloz5havX3lvBMvCJAPkbk0tjEKuWdFFS5Q1wjP9gAU+5k1y5ONqqXjZg7Z6uSTGRf54xqlS
	G
X-Google-Smtp-Source: AGHT+IHK07q6d758NnY7KwadjWeV4oigarBGCihMRrsLu//L5GE8ybqQcQzNHmPk7UG5kqgL3SN8+w==
X-Received: by 2002:a05:6512:74b:b0:513:1a9c:ae77 with SMTP id c11-20020a056512074b00b005131a9cae77mr4832865lfs.52.1713777579585;
        Mon, 22 Apr 2024 02:19:39 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id q23-20020a50c357000000b0056e672573e5sm5560810edb.88.2024.04.22.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:19:38 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 22 Apr 2024 11:19:33 +0200
Message-Id: <20240422091936.3714381-1-jens.wiklander@linaro.org>
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

The corresponding secure world OP-TEE patches are available at [7].

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
[7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe

Thanks,
Jens

Changes since v4:
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Describing struct rpmb_descr as RPMB description instead of descriptor
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Addressing review comments
  - Adding more comments for struct rpmb_frame
  - Fixing assignment of reliable_wr_count and capacity in mmc_blk_rpmb_add()
* "optee: probe RPMB device using RPMB subsystem"
  - Updating struct rpmb_dev_info to match changes in "rpmb: add Replay
    Protected Memory Block (RPMB) subsystem"

Changes since v3:
* Move struct rpmb_frame into the MMC driver since the format of the RPMB
  frames depend on the implementation, one format for eMMC, another for
  UFS, and so on
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
  - Adding more description of the API functions
  - Removing the set_dev_info() op from struct rpmb_ops, the needed information
    is supplied in the arguments to rpmb_dev_register() instead.
  - Getting rid of struct rpmb_ops since only the route_frames() op was
    remaining, store that op directly in struct rpmb_dev
  - Changed rpmb_interface_register() and rpmb_interface_unregister() to use
    notifier_block instead of implementing the same thing ourselves
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Moving the call to rpmb_dev_register() to be done at the end of
    mmc_blk_probe() when the device is fully available
* "optee: probe RPMB device using RPMB subsystem"
  - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB subsystem is
    available
  - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in get_devices()
    to recognize the error in optee_rpmb_scan()
  - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()

Changes since v2:
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Fixing documentation issues
  - Adding a "depends on MMC" in the Kconfig
  - Removed the class-device and the embedded device, struct rpmb_dev now
    relies on the parent device for reference counting as requested
  - Removed the now unneeded rpmb_ops get_resources() and put_resources()
    since references are already taken in mmc_blk_alloc_rpmb_part() before
    rpmb_dev_register() is called
  - Added rpmb_interface_{,un}register() now that
    class_interface_{,un}register() can't be used ay longer
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Adding the missing error cleanup in alloc_idata()
  - Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
    instead of in mmc_rpmb_chrdev_open() and rpmb_op_mmc_get_resources()
* "optee: probe RPMB device using RPMB subsystem"
  - Registering to get a notification when an RPMB device comes online
  - Probes for RPMB devices each time an RPMB device comes online, until
    a usable device is found
  - When a usable RPMB device is found, call
    optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
  - Pass type of rpmb in return value from OPTEE_RPC_CMD_RPMB_PROBE_NEXT

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
 drivers/misc/Kconfig              |  10 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/rpmb-core.c          | 232 ++++++++++++++++++++++++++++
 drivers/mmc/core/block.c          | 241 +++++++++++++++++++++++++++++-
 drivers/tee/optee/core.c          |  30 ++++
 drivers/tee/optee/device.c        |   7 +
 drivers/tee/optee/ffa_abi.c       |   8 +
 drivers/tee/optee/optee_private.h |  21 ++-
 drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
 drivers/tee/optee/rpc.c           | 232 ++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   7 +
 include/linux/rpmb.h              | 136 +++++++++++++++++
 13 files changed, 964 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

-- 
2.34.1


