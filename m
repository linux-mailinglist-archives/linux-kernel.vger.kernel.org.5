Return-Path: <linux-kernel+bounces-112530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A20887B39
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5821C21319
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708017C8;
	Sun, 24 Mar 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="QW4czith"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16A399
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241179; cv=none; b=X3fjgtOOD+3NmRNEpnszrkAcjxxyzEtEXYdUYSA+ZpZAujzRL5ugAhXtaLABfrZQ22YA4+Zhsh6Jy0V2601G7WrjI2WiyWn5+wpPbJ2ioVvn/gQLe2pOzHj86mtnLYuuQ5/GhGpo++v12AXduyTsQLLIiNFYwzGHyOJGYxKE0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241179; c=relaxed/simple;
	bh=rsaEMbubzoOuIZLaG5s19kcH9GHqdvorlTfg3Yq4rVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEMtg5skE+GXUs0xnY14J3oFjyF6fpf23myC4F7n86BTf+q8T3Dvd8KQhIWtdhzf6YevchgFGUHke9z0Es3JGag5u0HKtp+JrvIho0vnm4H0FhZnDCv1e3dzMsab+NEO+EGTnZ9SlahXYRLD60gVv3BSQTxWhXhPz4T8jszF0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=QW4czith; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4148849e542so122225e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711241175; x=1711845975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8BHX/8fg885NecQs4n5GQbSgtL+2x64iisM5vfLVN4=;
        b=QW4czithIxvybzWJWMGuOohzv96bo3Qfh9ghVdEJC+rpS266gPMY1CG9OVsDFkCLKk
         /SFyiNx3My/dkz4MceOfwpBunNprd6WUnHVP3j8n9WlRTipvId+STc2nndwTFJcWEN/P
         KI9uM6BH0cd6zAnKpvxLjDTUbm+AtlhKLWsFNGDg4CbCv9W0l1uYZjR+SCbxK4tq0bHi
         5OwPuAdX7UQV5QwDCsPoQJxEXbgYvZ0jkq4z8irRIUAWkflcEcD0AjiwD1BOxsceyLIH
         xRaqtl7nkiLctO7oWDcdLUhSrL7gC3xb8Ai5sMs/5n4UmCCPyT5B1lw0QvPcrN/8aDMC
         K3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241175; x=1711845975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8BHX/8fg885NecQs4n5GQbSgtL+2x64iisM5vfLVN4=;
        b=VNrdvkyF4QIgbxiAQ0ejupT6zy74m+MNtVT4RVZ2BkVv7C2qMiinuzPallR+0WnVA4
         srtEEAmrwCzGIFkDXDETbsxcCU9lm4yh9kZDIZ9Zn8vB3cVL91fv3vKC4dKHHErvD99U
         C+de3TijfLS74DaRnQ1dzPsYmOPEoiSiecmtlDM4zOWFWmWnjZX+XURJvdshs479OGk9
         /TeeflueiLmR7zTkG4TgjQ+eDQVdAz+cLV1enj6QjE35o/ICbk0ggsC7CeF2WJDeMCVb
         jucTXl6nIorX0aivDHO/y3OEeIsCbKJEPsL9JBHTBpIfRGF9lMUxAzpP23vpq0Ck7WJb
         ys4A==
X-Gm-Message-State: AOJu0Yy5PtU99jV23e1dt0Rdu0nIK1lb5PVtyAPKRA02dlevDB221SJ/
	Ri6xeHFhuUeopu8YXHYbSpowaCDrNpfSOIxnvc6HOa65btq2fBy/kAGvjzukX+U=
X-Google-Smtp-Source: AGHT+IG3D4aWpwcKDMd82RbFJIvm784hTDl2PWXtC6VLO9s/2294dxCT/mF4pKXg/fr+iBFqTJ+8Hg==
X-Received: by 2002:a05:600c:3b14:b0:414:6c34:9ba0 with SMTP id m20-20020a05600c3b1400b004146c349ba0mr1965541wms.16.1711241175225;
        Sat, 23 Mar 2024 17:46:15 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b00414674a1a40sm3778179wmq.45.2024.03.23.17.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 17:46:14 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v8 0/4] sched: Don't trigger misfit if affinity is restricted
Date: Sun, 24 Mar 2024 00:45:48 +0000
Message-Id: <20240324004552.999936-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a discussion on handling hotplug operation removing a capacity level
and lead to unnecessary misfit lb to trigger again. I opted not to handle it
now, but a working patch is available in [1]. I don't feel strongly about it
and would leave it up to the maintainers to push which direction they prefer.
Patch 4 will make sure that balance interval and nr_failed won't grow
unnecessarily due to bad unnecessary misfit lb. It will lead to some
sub-optimality, but no incorrect behavior.

After 6.9 merge window, dynamic Energy Model series would be merged and it can
lead to the capacities of the CPUs being changed at runtime. This means I need
to post follow up patch to handle this situation to ensure max_allowed_capacity
is correct after an EM update. It might make then handling of hotplug operation
attractive too as there would be some common shared ground.

[1] https://lore.kernel.org/lkml/20240321122039.7gk2mc3syvkrvhjz@airbuntu/

Changes since v7:

	* Remove sd arg from check_misfit_status()
	* Update typo in commit message in patch 2.
	* Add Reviewed-by from Vincent

Changes since v6:

	* Simplify update_misfit_status

Changes since v5:

	* Remove redundant check to rq->rd->max_cpu_capacity
	* Simplify check_misfit_status() further by removing unnecessary checks.
	* Add new patch to remove no longer used rd->max_cpu_capacity
	* Add new patch to prevent misfit lb from polluting balance_interval
	  and nr_balance_failed

Changes since v4:

	* Store max_allowed_capacity in task_struct and populate it when
	  affinity changes to avoid iterating through the capacities list in the
	  fast path (Vincent)
	* Use rq->rd->max_cpu_capacity which is updated after hotplug
	  operations to check biggest allowed capacity in the system.
	* Undo the change to check_misfit_status() and improve the function to
	  avoid similar confusion in the future.
	* Split the patches differently. Export the capacity list and sort it
	  is now patch 1, handling of affinity for misfit detection is patch 2.

Changes since v3:

	* Update commit message of patch 2 to be less verbose

Changes since v2:

	* Convert access of asym_cap_list to be rcu protected
	* Add new patch to sort the list in descending order
	* Move some declarations inside affinity check block
	* Remove now redundant check against max_cpu_capacity in check_misfit_status()

Changes since v1:

	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
	  through every cpu which Vincent was concerned about.
	* Use uclamped util to compare with capacity instead of util_fits_cpu()
	  when iterating through capcities (Dietmar).
	* Update commit log with test results to better demonstrate the problem

v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20231231175218.510721-1-qyousef@layalina.io/
v4 discussion: https://lore.kernel.org/lkml/20240105222014.1025040-1-qyousef@layalina.io/
v5 discussion: https://lore.kernel.org/lkml/20240205021123.2225933-1-qyousef@layalina.io/
v6, v7 discussion: https://lore.kernel.org/lkml/20240220225622.2626569-1-qyousef@layalina.io/

Thanks!

--
Qais Yousef

Qais Yousef (4):
  sched/topology: Export asym_capacity_list
  sched/fair: Check a task has a fitting cpu when updating misfit
  sched/topology: Remove max_cpu_capacity from root_domain
  sched/fair: Don't double balance_interval for migrate_misfit

 include/linux/sched.h   |  1 +
 init/init_task.c        |  1 +
 kernel/sched/fair.c     | 79 +++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h    | 16 +++++++--
 kernel/sched/topology.c | 56 ++++++++++++++---------------
 5 files changed, 104 insertions(+), 49 deletions(-)

-- 
2.34.1


