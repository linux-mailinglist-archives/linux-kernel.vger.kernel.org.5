Return-Path: <linux-kernel+bounces-167827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA18BAFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EB81C2214C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94F154432;
	Fri,  3 May 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j7GX9NRd"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867074AED7;
	Fri,  3 May 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750393; cv=none; b=ckLQ6gdoltVjZ54e/yzi/6ggGPpyOdR4VWlwGeJcn+ATKzcAJPGaKSbmXI7S0r6vk9ipD9fUqhDNyAeeTKtK7VueQuN8M48Zwe0CKqAN8GOhrHy+tnoihjrBt8gW+BlujIPOZU77irsmxs0uaPVbCOuRFsBFIHqbsTo3GzcQKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750393; c=relaxed/simple;
	bh=5vVoaQnaeX4ZEWoRos3DDBrLSSzPUHQmGGInmUp8OPI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jx8uAn4VDsO0rkhUUcebsV2C2cnw25WFeOT/j4KgJwbH1HMgNL1JfziveeXXMCe5YcfC5Xb0JmPCWlIuAJtxAVPfAWLNa5pVaPKDGtK/7aRes7DfcXxCmg6ab30D4RkeUaork3Ihlppx8YypaTFeHeFnLiydkWcqb0d6Z0Tfvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j7GX9NRd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B6D420B2C80;
	Fri,  3 May 2024 08:33:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B6D420B2C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714750385;
	bh=u83roOV6ApUdhHCZFPvPha+Yc7iFIOLJNXHoxhkiXF4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=j7GX9NRdjJ0f1JXprYqP4mU6AOIdq5ljmyVYLDipoLA2YOir4KFl5vXntDGJZySEO
	 +i6qqAmEEQ6LcXBnrtvruAXjmxQTA5e8JAMjqBOUmB46Z27e18e+wlNX8l+AN1Plu1
	 xMs1Pj7h/O/y+V8LcuGoEpVLUmg98XLoU24jOVMg=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] [RFC] scsi: Convert from tasklet to BH workqueue
From: Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <87ikzv3b4n.fsf@mail.lhotse>
Date: Fri, 3 May 2024 08:32:54 -0700
Cc: linux-scsi@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 target-devel@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com,
 jejb@linux.ibm.com,
 hare@suse.com,
 martin.petersen@oracle.com,
 linuxdrivers@attotech.com,
 tyreld@linux.ibm.com,
 npiggin@gmail.com,
 christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com,
 artur.paszkiewicz@intel.co,
 kashyap.desai@broadcom.com,
 sumit.saxena@broadcom.com,
 shivasharan.srikanteshwara@broadcom.com,
 chandrakanth.patil@broadcom.com,
 jinpu.wang@cloud.ionos.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA5F645E-7DC6-4737-BCB2-6CD8E2C4471A@linux.microsoft.com>
References: <20240502203433.15811-1-apais@linux.microsoft.com>
 <20240502203433.15811-2-apais@linux.microsoft.com>
 <87ikzv3b4n.fsf@mail.lhotse>
To: Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On May 2, 2024, at 7:03=E2=80=AFPM, Michael Ellerman =
<mpe@ellerman.id.au> wrote:
>=20
> Allen Pais <apais@linux.microsoft.com> writes:
>> The only generic interface to execute asynchronously in the BH =
context is
>> tasklet; however, it's marked deprecated and has some design flaws. =
To
>> replace tasklets, BH workqueue support was recently added. A BH =
workqueue
>> behaves similarly to regular workqueues except that the queued work =
items
>> are executed in the BH context.
>>=20
>> This patch converts drivers/scsi/* from tasklet to BH workqueue.
>>=20
>> Based on the work done by Tejun Heo <tj@kernel.org>
>> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git =
for-6.10
>>=20
>> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>> ---
>> drivers/scsi/aic7xxx/aic7xxx_osm.c          |  2 +-
>> drivers/scsi/aic94xx/aic94xx_hwi.c          | 14 ++--
>> drivers/scsi/aic94xx/aic94xx_hwi.h          |  5 +-
>> drivers/scsi/aic94xx/aic94xx_scb.c          | 36 +++++-----
>> drivers/scsi/aic94xx/aic94xx_task.c         | 14 ++--
>> drivers/scsi/aic94xx/aic94xx_tmf.c          | 34 ++++-----
>> drivers/scsi/esas2r/esas2r.h                | 12 ++--
>> drivers/scsi/esas2r/esas2r_init.c           | 14 ++--
>> drivers/scsi/esas2r/esas2r_int.c            | 18 ++---
>> drivers/scsi/esas2r/esas2r_io.c             |  2 +-
>> drivers/scsi/esas2r/esas2r_main.c           | 16 ++---
>> drivers/scsi/ibmvscsi/ibmvfc.c              | 16 ++---
>> drivers/scsi/ibmvscsi/ibmvfc.h              |  3 +-
>> drivers/scsi/ibmvscsi/ibmvscsi.c            | 16 ++---
>> drivers/scsi/ibmvscsi/ibmvscsi.h            |  3 +-
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c    | 15 ++--
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.h    |  3 +-
>=20
> Something there is giving me a build failure =
(ppc64le_guest_defconfig):
>=20
>  + make -s 'CC=3Dccache powerpc64le-linux-gnu-gcc' -j 4
>  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c: In function =
'ibmvscsi_init_crq_queue':
>  Error: /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:370:331: error: =
'ibmvscsi_work' undeclared (first use in this function)
>  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:370:331: note: each =
undeclared identifier is reported only once for each function it appears =
in
>  /linux/scripts/Makefile.build:244: recipe for target =
'drivers/scsi/ibmvscsi/ibmvscsi.o' failed
>  /linux/scripts/Makefile.build:485: recipe for target =
'drivers/scsi/ibmvscsi' failed
>  /linux/scripts/Makefile.build:485: recipe for target 'drivers/scsi' =
failed
>  /linux/scripts/Makefile.build:485: recipe for target 'drivers' failed
>  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c: In function =
'ibmvscsi_probe':
>  Error: /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:2255:78: error: =
passing argument 1 of 'kthread_create_on_node' from incompatible pointer =
type [-Werror=3Dincompatible-pointer-types]
>  In file included from /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:56:0:
>  /linux/include/linux/kthread.h:11:21: note: expected 'int (*)(void =
*)' but argument is of type 'int (*)(struct work_struct *)'
>   struct task_struct *kthread_create_on_node(int (*threadfn)(void =
*data),
>                       ^
>  /linux/drivers/scsi/ibmvscsi/ibmvscsi.c: At top level:
>  Warning: /linux/drivers/scsi/ibmvscsi/ibmvscsi.c:212:13: warning: =
'ibmvscsi_task' defined but not used [-Wunused-function]
>   static void ibmvscsi_task(void *data)
>               ^
>  Warning: cc1: warning: unrecognized command line option =
'-Wno-shift-negative-value'
>  Warning: cc1: warning: unrecognized command line option =
'-Wno-stringop-overflow'
>  cc1: some warnings being treated as errors
>  make[6]: *** [drivers/scsi/ibmvscsi/ibmvscsi.o] Error 1
>  make[5]: *** [drivers/scsi/ibmvscsi] Error 2
>  make[4]: *** [drivers/scsi] Error 2
>  make[3]: *** [drivers] Error 2
>  make[3]: *** Waiting for unfinished jobs....
>=20
> Full log here: =
https://github.com/linuxppc/linux-snowpatch/actions/runs/8930174372/job/24=
529645923

 Thank you for testing it out. Unfortunately, I did not cross-compile =
it.
Will fix this in v2.

- Allen

>=20
> Cross compile instructions if you're keen: =
https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels
>=20
> cheers


