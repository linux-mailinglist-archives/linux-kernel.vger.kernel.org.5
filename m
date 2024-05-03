Return-Path: <linux-kernel+bounces-167166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA58BA526
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0181F239C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971831C6A4;
	Fri,  3 May 2024 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="H5k68sDS"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E791BC49;
	Fri,  3 May 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714701808; cv=none; b=BFyqd/OPozzUPnkHimSlAAKZVsFLA4DKeWn30JnWsH4SnldqizXi+Jx3A2gMiLTgwAIguCFVQainE4+9oMFlbUHej9gWZAt+UMpnENIZrAYnrBtZTBzL2E1k2butw7dFiE8ckw73S9pH6jHdBA70hiNK91b6UU2gY0PZpqoC3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714701808; c=relaxed/simple;
	bh=SVHHtn8OKM9t8LE9cQrAjdRlkmcsVzh9eDpnFhbnTjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDEi1uiSSeRmN80X/gonpOMQT+871Z7pleq0lwga4K6KFiteHNsXWMZdIyqKjr+UwXrlvtBMyoFU+w+MkPyDpf7bKP/J+KDcXnoyvUZlDJ0skQwEeMN3DRCMwF/FAVnJc1FkFIjc+1oSMhGPypYpU+/gCbq/113e5UNIS764WLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=H5k68sDS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714701803;
	bh=O2rIImNa5eTX5JMS2gK4B5+p9DQZTIlWwqfyVhLPEjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H5k68sDSmC2DbJz+33czp8ldQxidcRYZnKOy5boIYRoBRouyDG78TxydSwEUPk+U+
	 r94Agvp8BLRxLOGOxj0MJqqQpKPbOMfZvdphYSpPBx9pRTF+IMCS7niDPzXn7kS2oL
	 dgc4JJf3xI+wurpAbKMqW8pO2nHH8MLpdFB7zfdG5YzGF8c9bkNZf2Gpz6V3477v1W
	 VN5Zb1r8ULqYPNlMJxgWijx4y+2uOSwomPntynB4Wvd1EtESkKyKAnCUWCfbRZSYuE
	 vxFEbobYnEYwZmCzp70+QVJfXaf3SBBXJ4utTr0l5UTHcUr3ceJKDCmXJmLV4BcZkN
	 knTSkRFwnTSDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVvGc44T2z4wcg;
	Fri,  3 May 2024 12:03:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Allen Pais <apais@linux.microsoft.com>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 target-devel@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 jejb@linux.ibm.com, hare@suse.com, martin.petersen@oracle.com,
 linuxdrivers@attotech.com, tyreld@linux.ibm.com, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, artur.paszkiewicz@intel.co,
 kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
 shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com,
 jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH] [RFC] scsi: Convert from tasklet to BH workqueue
In-Reply-To: <20240502203433.15811-2-apais@linux.microsoft.com>
References: <20240502203433.15811-1-apais@linux.microsoft.com>
 <20240502203433.15811-2-apais@linux.microsoft.com>
Date: Fri, 03 May 2024 12:03:20 +1000
Message-ID: <87ikzv3b4n.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Allen Pais <apais@linux.microsoft.com> writes:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>
> This patch converts drivers/scsi/* from tasklet to BH workqueue.
>
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/scsi/aic7xxx/aic7xxx_osm.c          |  2 +-
>  drivers/scsi/aic94xx/aic94xx_hwi.c          | 14 ++--
>  drivers/scsi/aic94xx/aic94xx_hwi.h          |  5 +-
>  drivers/scsi/aic94xx/aic94xx_scb.c          | 36 +++++-----
>  drivers/scsi/aic94xx/aic94xx_task.c         | 14 ++--
>  drivers/scsi/aic94xx/aic94xx_tmf.c          | 34 ++++-----
>  drivers/scsi/esas2r/esas2r.h                | 12 ++--
>  drivers/scsi/esas2r/esas2r_init.c           | 14 ++--
>  drivers/scsi/esas2r/esas2r_int.c            | 18 ++---
>  drivers/scsi/esas2r/esas2r_io.c             |  2 +-
>  drivers/scsi/esas2r/esas2r_main.c           | 16 ++---
>  drivers/scsi/ibmvscsi/ibmvfc.c              | 16 ++---
>  drivers/scsi/ibmvscsi/ibmvfc.h              |  3 +-
>  drivers/scsi/ibmvscsi/ibmvscsi.c            | 16 ++---
>  drivers/scsi/ibmvscsi/ibmvscsi.h            |  3 +-
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c    | 15 ++--
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.h    |  3 +-

Something there is giving me a build failure (ppc64le_guest_defconfig):

  + make -s 'CC=ccache powerpc64le-linux-gnu-gcc' -j 4
  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_init_crq_queue':
  Error: /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:370:331: error: 'ibmvscsi_work' undeclared (first use in this function)
  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:370:331: note: each undeclared identifier is reported only once for each function it appears in
  /linux/scripts/Makefile.build:244: recipe for target 'drivers/scsi/ibmvscsi/ibmvscsi.o' failed
  /linux/scripts/Makefile.build:485: recipe for target 'drivers/scsi/ibmvscsi' failed
  /linux/scripts/Makefile.build:485: recipe for target 'drivers/scsi' failed
  /linux/scripts/Makefile.build:485: recipe for target 'drivers' failed
  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_probe':
  Error: /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:2255:78: error: passing argument 1 of 'kthread_create_on_node' from incompatible pointer type [-Werror=incompatible-pointer-types]
  In file included from /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:56:0:
  /linux/include/linux/kthread.h:11:21: note: expected 'int (*)(void *)' but argument is of type 'int (*)(struct work_struct *)'
   struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
                       ^
  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c: At top level:
  Warning: /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:212:13: warning: 'ibmvscsi_task' defined but not used [-Wunused-function]
   static void ibmvscsi_task(void *data)
               ^
  Warning: cc1: warning: unrecognized command line option '-Wno-shift-negative-value'
  Warning: cc1: warning: unrecognized command line option '-Wno-stringop-overflow'
  cc1: some warnings being treated as errors
  make[6]: *** [drivers/scsi/ibmvscsi/ibmvscsi.o] Error 1
  make[5]: *** [drivers/scsi/ibmvscsi] Error 2
  make[4]: *** [drivers/scsi] Error 2
  make[3]: *** [drivers] Error 2
  make[3]: *** Waiting for unfinished jobs....

Full log here: https://github.com/linuxppc/linux-snowpatch/actions/runs/8930174372/job/24529645923

Cross compile instructions if you're keen: https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels

cheers

