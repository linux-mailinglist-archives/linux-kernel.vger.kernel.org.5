Return-Path: <linux-kernel+bounces-49632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F275846D25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BBA1C27903
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415777F28;
	Fri,  2 Feb 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2i1QSxW"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDE605DB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867985; cv=none; b=bX33oeKospYz93/CDZ3KMHef56C2vBIsrpPyfLJOICkC5mlPMfVNXD83P2xQbFzbVns5yYhEUP6Mm76vhoVu8OGvPhLvet/iOR1jVYgF807qSXOrmX5Ph3jwOhcjP4YXwlO26sJSKoZMx0OXY//8g/Drpqg4NnYvLOyC2rspy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867985; c=relaxed/simple;
	bh=dc8rQnh6PDoB1TWGzNuLOJkPoGzySAD7iS8TKBzVRPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MY4kHmfFoEnkcr4BPG0lK+1AvW83/C7BqeCmMjyvMLh2prQF4cXi/DZtggFzA4omSor4Eb9AveO3PKZ/QCZSpTXk8mEtQOv9Kd0iPTmo8jG58wPqh0YKBnRLJrRS3AP8O7clNgrM6AINqTfY+c4UEHleVr8qHrYXCS5RDIkn/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2i1QSxW; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46b24280725so353806137.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706867982; x=1707472782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGyYTzfbWHLJ9icv+vr2JH/WdzWZ6KgDnIC2V14paRI=;
        b=Z2i1QSxW7NutcqfA7Zy0AUOJOb6cderHycpxrrWTlI2QqmvKyvGFtJmcs+60jtVrr2
         PNOsy2KHVdXdzCwRQi1kcXVCpWVFJTcPXJ+j3VyipMzRbDyxPF9cr5AOjp86LKKlSWJJ
         yjZHj5oqT0O6WmoTvHBtRUB9s6PDWfCs4YWfZxEexMcgcFvR9nYEfVeI8aqfVoGZqqVD
         x2MwCf4DsHtFhG6oJIRWptofVB29z4E7whwC1v7Od6oX9Nq1GcgZuo6+pzRo3rnC5bVM
         z+WgMuLDKnlE1TD0FdoVWkpfMHZo7K4novF3xeqU8aenv/UA4yrNvRzG8nOlZ9nEw4OJ
         Kvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867982; x=1707472782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGyYTzfbWHLJ9icv+vr2JH/WdzWZ6KgDnIC2V14paRI=;
        b=bmNByIAxQ1HAG5FzctLd2QRv6sqva3uOi8MXMggj8Fh6e9fxv4bIxdf1+gB7ZuzwBk
         J/iGFfHAfLRQ+0cVBcYiDn2A1swkjyUGPTPkKMVMlQDJnuPAaUbXo40elDAUqdbMQFHa
         TV681jqW08yC9siMp8KD3+3FHoCnHkgpyH6s7hX9P1EPl2nBkC5avToLT+zN6gRxfS2L
         5oSl5Rb2dntP8o2mOcqLz9vbOYaykSlaD9ihVKL5xJSUJZ0aO8ykq3shOGm8oot2AhQt
         WvIH/H3qnsUTATIDD+7mJCxEpAFpubNet7MR+/5ukkyZ0O802uApFWdzqWXke/jubaRk
         Xlmg==
X-Gm-Message-State: AOJu0YwUDKa72iOFOnxxpRlHxzby5NWLEJEE4zYPbithinyJ7v/VffaZ
	dckUlJTPgj84SV4fEj3I4fS3GGBuKFURwIM12/boXTarF7fTW9HH4+Riqj7y4R/fyFF5UgyihD2
	9+zKjys8ODMF5MZ6YCJPtQMXiZZGIt7CBnvTwLQ==
X-Google-Smtp-Source: AGHT+IGx011pU/uYoeRaO9GDRIyKMw5o70O5J6j1cmokVIok+jvPB4MJkIPn0wNMToA6OBf4Al+Gz7jgxs56x66TY0U=
X-Received: by 2002:a67:f61a:0:b0:46c:fc76:7746 with SMTP id
 k26-20020a67f61a000000b0046cfc767746mr1201018vso.2.1706867981911; Fri, 02 Feb
 2024 01:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
In-Reply-To: <20240131174347.510961-1-jens.wiklander@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 15:29:30 +0530
Message-ID: <CAFA6WYORTtuRsoiDhjCdPwaDHyJ+ixZBu_-VQHPE2RhCprKQ0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

On Wed, 31 Jan 2024 at 23:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> It's been a while since Shyam posted the last version [1] of this patch
> set. I've pinged Shyam, but so far I've had no reply so I'm trying to make
> another attempt with the RPMB subsystem. If Shyam has other changes in mind
> than what I'm adding here I hope we'll find a way to cover that too. I'm
> calling it version two of the patchset since I'm trying to address all
> feedback on the previous version even if I'm starting a new thread.
>
> This patch set introduces a new RPMB subsystem, based on patches from [1],
> [2], and [3]. The RPMB subsystem aims at providing access to RPMB
> partitions to other kernel drivers, in particular the OP-TEE driver. A new
> user space ABI isn't needed, we can instead continue using the already
> present ABI when writing the RPMB key during production.
>
> I've added and removed things to keep only what is needed by the OP-TEE
> driver. Since the posting of [3], there has been major changes in the MMC
> subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
> is in practice completely rewritten.
>
> With this OP-TEE can access RPMB during early boot instead of having to
> wait for user space to become available as in the current design [4].
> This will benefit the efi variables [5] since we wont rely on userspace as
> well as some TPM issues [6] that were solved.
>
> The OP-TEE driver finds the correct RPMB device to interact with by
> iterating over available devices until one is found with a programmed
> authentication matching the one OP-TEE is using. This enables coexisting
> users of other RPMBs since the owner can be determined by who knows the
> authentication key.
>
> I've put myself as a maintainer for the RPMB subsystem as I have an
> interest in the OP-TEE driver to keep this in good shape. However, if you'd
> rather see someone else taking the maintainership that's fine too. I'll
> help keep the subsystem updated regardless.
>
> [1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.microsoft.com/
> [2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
> [3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
> [4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7269cba53d906cf257c139d3b3a53ad272176bca
>
> Thanks,
> Jens
>
> Changes since Shyam's RFC:
> * Removed the remaining leftover rpmb_cdev_*() function calls
> * Refactored the struct rpmb_ops with all the previous ops replaced, in
>   some sense closer to [3] with the route_frames() op
> * Added rpmb_route_frames()
> * Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
> * Removed all functions not needed in the OP-TEE use case
> * Added "mmc: block: register RPMB partition with the RPMB subsystem", based
>   on the commit with the same name in [3]
> * Added "optee: probe RPMB device using RPMB subsystem" for integration
>   with OP-TEE
> * Moved the RPMB driver into drivers/misc/rpmb-core.c
> * Added my name to MODULE_AUTHOR() in rpmb-core.c
> * Added an rpmb_mutex to serialize access to the IDA
> * Removed the target parameter from all rpmb_*() functions since it's
>   currently unused
>

Thanks for working on this. This is a huge step towards supporting TEE
kernel client drivers. IIRC you mentioned offline to test it with
virtio RPMB on Qemu. If it works then I would be happy to try it out
as well.

Along with that can you point me to the corresponding OP-TEE OS
changes? I suppose as you are just adding 3 new RPC calls in patch#3,
so we should be fine ABI wise although people have to uprev both
OP-TEE and Linux kernel to get this feature enabled. However, OP-TEE
should gate those RPCs behind a config flag or can just fallback to
user-space supplicant if those aren't supported?

-Sumit

>
>
> Jens Wiklander (3):
>   rpmb: add Replay Protected Memory Block (RPMB) subsystem
>   mmc: block: register RPMB partition with the RPMB subsystem
>   optee: probe RPMB device using RPMB subsystem
>
>  MAINTAINERS                       |   7 +
>  drivers/misc/Kconfig              |   9 ++
>  drivers/misc/Makefile             |   1 +
>  drivers/misc/rpmb-core.c          | 247 ++++++++++++++++++++++++++++++
>  drivers/mmc/core/block.c          | 177 +++++++++++++++++++++
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |   2 +
>  drivers/tee/optee/optee_private.h |   6 +
>  drivers/tee/optee/optee_rpc_cmd.h |  33 ++++
>  drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   2 +
>  include/linux/rpmb.h              | 184 ++++++++++++++++++++++
>  12 files changed, 890 insertions(+)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
>
>
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> --
> 2.34.1
>

