Return-Path: <linux-kernel+bounces-166901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548AC8BA197
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E1E1F22906
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAC17334F;
	Thu,  2 May 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R1Az1bhb"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906C25753;
	Thu,  2 May 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714682081; cv=none; b=Vzvk7O6L0tnqSp1qxBljXH2P23K+Hm4TDsu0SgExcN+E7tmnwXvFHq//ASfhX8MFM1D7Nnb3ufSepl4JkHhejP2f02G2vXhm8EgJnChfM5BE0m4HpakQwEIW4DBrQqrsv9MQskmpihglarb+A0PYViIfOFaqKmBfOHtWIywFkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714682081; c=relaxed/simple;
	bh=ttXSEqgNaGYlbpHkS2ay2w+BGg6nbkrWQ/iPHovZYb8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Nf8UYrVA/6K6uQGmSg3rgyOh0Mlm/IfaXNdIoYR1gkFRIfy6Hg+ZFcCvFCuL173igQFQKxhdrio/cJqA2vXtke/rUr+tR2otAYPj/GUuQVDLSLlfKGEFRPMkvyDrs8T/le7PQT30lXZeOR/5MakFOGCdI++MXaxcAK7aaQZLUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R1Az1bhb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 74FF9206B4F6;
	Thu,  2 May 2024 13:34:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74FF9206B4F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714682078;
	bh=+lQIkPk/QRwGLvJaABVHpfk2bsKn+OK5GGtbW+NWBq4=;
	h=From:To:Cc:Subject:Date:From;
	b=R1Az1bhbZ1U2kukMUltUxFXqjNQs5oqcLebOvX2J+TwfYcx8ex6Pa/3lD1SFfvyzF
	 gMPhr48V7XMiAp50rN6k+ip0/k71dY1VVjcNEUNkC1FzobY1A7jEdLnBmFC0t3EHrl
	 3ClkqKrgfg1QAvwKmn1v7IZ3aVQJFD6N2lqMO0zs=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	target-devel@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	jejb@linux.ibm.com,
	hare@suse.com,
	martin.petersen@oracle.com,
	linuxdrivers@attotech.com,
	tyreld@linux.ibm.com,
	mpe@ellerman.id.au,
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
Subject: [PATCH 0/1] Convert tasklets to bottom half workqueues
Date: Thu,  2 May 2024 20:34:32 +0000
Message-Id: <20240502203433.15811-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I am submitting this patch which converts instances of tasklets
in drivers/scsi/* to bottom half workqueues. I appreciate your
feedback and suggestion on the changes.

Note: The patch is only compile tested.

In the patcheset, you will notice *FIXME* in two places:
1. pm8001/pm8001_init.c @ pm8001_work(struct work_struct *t)
2. pmcraid.c @ pmcraid_work_function(struct work_struct *t)

The current implementation limits context-aware processing
within work functions due to the lack of a mechanism to identify
the source work_struct in the array. The proposed solution wraps
each work_struct with a struct work_wrapper, adding crucial context
like the array index and a reference to the parent data structure.

Ex:

#define SOME_CONSTANT 10
struct xxx_data {

....
struct work_struct work[SOME_CONSTANT]:
....
};

The xxx_data module currently uses an array of work_structs
for scheduling work, but it lacks the ability to identify which
array element is associated with a specific invocation of the work
function. This limitation prevents the execution of context-specific
actions based on the source of the work request.

The proposed solution is to introduce a struct work_wrapper that
encapsulates each work_struct along with additional metadata,
including an index and a pointer to the parent xxx_data structure.
This enhancement allows the work function to access necessary
context information.

Changes:

1. Definition of struct work_wrapper:

struct work_wrapper {
    struct work_struct work;
    struct xxx_data *data;
    int index;
};

struct xxx_data {
    struct work_wrapper work[SOME_CONSTANT];
};

During initialization:

for (int i = 0; i < SOME_CONSTANT; i++) {
    p->work[i].data = p;
    p->work[i].index = i;
    INIT_WORK(&p->work[i].work, work_func);
}

And it's usage in the handler:

void work_func(struct work_struct *t)
{
    struct work_wrapper *wrapper = from_work(wrapper, t, work);
    struct xxx_data *a = wrapper->data;
    int index = wrapper->index;

    ....
}

If the above is solution is acceptable, I can have the same
incorporated in version 2.

Thanks.

Allen Pais (1):
  [RFC] scsi: Convert from tasklet to BH workqueue

 drivers/scsi/aic7xxx/aic7xxx_osm.c          |  2 +-
 drivers/scsi/aic94xx/aic94xx_hwi.c          | 14 ++--
 drivers/scsi/aic94xx/aic94xx_hwi.h          |  5 +-
 drivers/scsi/aic94xx/aic94xx_scb.c          | 36 +++++-----
 drivers/scsi/aic94xx/aic94xx_task.c         | 14 ++--
 drivers/scsi/aic94xx/aic94xx_tmf.c          | 34 +++++-----
 drivers/scsi/esas2r/esas2r.h                | 12 ++--
 drivers/scsi/esas2r/esas2r_init.c           | 14 ++--
 drivers/scsi/esas2r/esas2r_int.c            | 18 ++---
 drivers/scsi/esas2r/esas2r_io.c             |  2 +-
 drivers/scsi/esas2r/esas2r_main.c           | 16 ++---
 drivers/scsi/ibmvscsi/ibmvfc.c              | 16 ++---
 drivers/scsi/ibmvscsi/ibmvfc.h              |  3 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c            | 16 ++---
 drivers/scsi/ibmvscsi/ibmvscsi.h            |  3 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c    | 15 ++---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.h    |  3 +-
 drivers/scsi/isci/host.c                    | 12 ++--
 drivers/scsi/isci/host.h                    |  8 +--
 drivers/scsi/isci/init.c                    |  4 +-
 drivers/scsi/megaraid/mega_common.h         |  5 +-
 drivers/scsi/megaraid/megaraid_mbox.c       | 21 +++---
 drivers/scsi/megaraid/megaraid_sas.h        |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 32 +++++----
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 16 ++---
 drivers/scsi/mvsas/mv_init.c                | 27 ++++----
 drivers/scsi/mvsas/mv_sas.h                 |  9 +--
 drivers/scsi/pm8001/pm8001_init.c           | 57 ++++++++--------
 drivers/scsi/pm8001/pm8001_sas.h            |  2 +-
 drivers/scsi/pmcraid.c                      | 75 ++++++++++-----------
 drivers/scsi/pmcraid.h                      |  5 +-
 31 files changed, 249 insertions(+), 251 deletions(-)

-- 
2.17.1


