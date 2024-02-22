Return-Path: <linux-kernel+bounces-76856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBC85FDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8C282602
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A98C150992;
	Thu, 22 Feb 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z6b4Tn36"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83891150988
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618176; cv=none; b=qnA6EwMAtFaVYP2s+UcRJmulibgZ7R8ydqHpy/ycuTEg9CB2T2UMR6+CVDexo6HwZogm5ox8mK4vDJDe5kMjSqjDuXQcg2PD04xljf4oUORtmCIPLkEe1vzCN8GdPnjLrvT0ErYDmw7gTKwLKjbnicSYqQmXEJj7AMm/IYxCpy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618176; c=relaxed/simple;
	bh=wQsAwvUGvEvb0Rq3Gdy9IeNtT2rmdXckqbx37y395KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nt0S13kqkioKsYRQ9n2JNHTNlNoihFnvzHWH/QBFkHvlx7+2J5swRTkejbGiKm97b/k+86k89jNK+7qPnEdpcf8BHwx8zOkwo3lhR8SIUuPVrUpbUewyqVKpAm+GY2ICaVM12wzsy+3vPDoxsT4oAEptKzVvYcXOUXIoqR7Qyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z6b4Tn36; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D3F674030F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708618171;
	bh=g5Tl7WvZw/F8/nTdgUDIbCAWrstLxfYABI9EmbXtD98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Z6b4Tn36S8CFpJUBkPrdLev6E661mkbH2Ztlw+srmExCRNt623/9m7hattbbj80HZ
	 /fpyIHkPn9/XM56oPFc5vMwV3jC1F573wPeWEe3Ukoda9tEbt0zLulA+3eT3Js4WdD
	 ZDgrJVeIPj6ekoH1P4iXTpBrqZwWq3fqJ+/yTTWd4ojzRQAH/ckqCPDDfzPOOk/9nh
	 HQDnK4asQlM/FZBH2tDBkzku1ZHq2VhvFkQkTuFfzXnxXRI4DXPcL/2ZfdN3AxYlOg
	 zeX+IRjbA9tgXE9hq2jDbs9OvEQism2xR2Ndk84iVA4g/1TXf89lkLjKNcM45HHowO
	 GoeCdVYVhALcQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-564fec337b1so1147194a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618171; x=1709222971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5Tl7WvZw/F8/nTdgUDIbCAWrstLxfYABI9EmbXtD98=;
        b=NV8euwL5LLcDa8oTL7SXphvETaCmVNc+P0J7G1ebTlkVubkT5yunOat/ZUFIeI8F4i
         t1JF9mX8cFSDT9LFC5ywjOVAThVVho/nqnUntArMhxexcBrYCfFGhxwb5G9lPS3hW0Rh
         imX6CVMDZElSu15dQhRJI8FXgSIJB6EOgJ5vSDtCNjerPx3jzuQYfT57n3xLxmZTBbGl
         fuJGF8UUjjeTEGHqIoXjP1UHZooRON4Skn2V1UBwendDY2Sa5ji6ZZrGYeZWv4LDCgRj
         7jeWtUZQDFZVKxvrerl/Zowato9tiS+6St0D3nRmvjLpusDHEBAM7IKXA773I6nO6cyI
         QBLA==
X-Forwarded-Encrypted: i=1; AJvYcCVKaR4rQn+ZiXcUB4OcA7FfTzPqk8pi5wljvAA8lJu377erdf/WiEpLv979F25m2BqpD1CJpUvp3C33xWuZYDphWTM+wZIPq0+vHOFz
X-Gm-Message-State: AOJu0YzG9O+zAVnj3c7RR1ymbacqACllVQNQMEHRaI0YgwqSnquzQQG8
	SUI4HScX7dou+9eEe5Vv3jghXqzKGu9Zz0kHSojJmcKST/gthSwASnDlk9Cbbe+XO7M08b88RTN
	aEsbuBFI4hx1p0lu3CDDSHgc7b3aTERY7O7p3Nb3QKnHex72stBFXpMdv9FePC9is5wArueyCS/
	mjNx/YBo28NQ==
X-Received: by 2002:a05:6402:3783:b0:561:7832:d35 with SMTP id et3-20020a056402378300b0056178320d35mr2388232edb.15.1708618170946;
        Thu, 22 Feb 2024 08:09:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH/H3lQ1a0U2pCSPaeXI7A9no2ubvQ/DDYxMQbLtHgky04AttWUDTd0w2Ra+lQusCFcsAoeg==
X-Received: by 2002:a05:6402:3783:b0:561:7832:d35 with SMTP id et3-20020a056402378300b0056178320d35mr2388217edb.15.1708618170596;
        Thu, 22 Feb 2024 08:09:30 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id er25-20020a056402449900b00563f8233ba8sm5675001edb.7.2024.02.22.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:09:30 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: stgraber@stgraber.org,
	tycho@tycho.pizza,
	cyphar@cyphar.com,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 0/2] pid_namespace: namespacify sysctl kernel.pid_max
Date: Thu, 22 Feb 2024 17:09:13 +0100
Message-Id: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear friends,

this is just a rebase/small rework of original Christian Brauner's series
from:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pid_max_namespacing

Christian kindly allowed me to take these patches and resend after small modifications.

Current tree:
https://github.com/mihalicyn/linux/commits/pid_max_namespacing

Changelog:
 - rebased from 5.14-rc1
 - a few fixes (missing ns_free_inum on error path, missing initialization, etc)
 - permission check changes in pid_table_root_permissions
 - unsigned int pid_max -> int pid_max (keep pid_max type as it was)
 - add READ_ONCE in alloc_pid() as suggested by Christian

Original description from Christian:

The pid_max sysctl is a global value. For a long time the default value
has been 65535 and during the pidfd dicussions Linus proposed to bump
pid_max by default (cf. [1]). Based on this discussion systemd started
bumping pid_max to 2^22. So all new systems now run with a very high
pid_max limit with some distros having also backported that change.
The decision to bump pid_max is obviously correct. It just doesn't make
a lot of sense nowadays to enforce such a low pid number. There's
sufficient tooling to make selecting specific processes without typing
really large pid numbers available.

In any case, there are workloads that have expections about how large
pid numbers they accept. Either for historical reasons or architectural
reasons. One concreate example is the 32-bit version of Android's bionic
libc which requires pid numbers less than 65536. There are workloads
where it is run in a 32-bit container on a 64-bit kernel. If the host
has a pid_max value greater than 65535 the libc will abort thread
creation because of size assumptions of pthread_mutex_t.

That's a fairly specific use-case however, in general specific workloads
that are moved into containers running on a host with a new kernel and a
new systemd can run into issues with large pid_max values. Obviously
making assumptions about the size of the allocated pid is suboptimal but
we have userspace that does it.

Of course, giving containers the ability to restrict the number of
processes in their respective pid namespace indepent of the global limit
through pid_max is something desirable in itself and comes in handy in
general.

Independent of motivating use-cases the existence of pid namespaces
makes this also a good semantical extension and there have been prior
proposals pushing in a similar direction.
The trick here is to minimize the risk of regressions which I think is
doable. The fact that pid namespaces are hierarchical will help us here.

What we mostly care about is that when the host sets a low pid_max
limit, say (crazy number) 100 that no descendant pid namespace can
allocate a higher pid number in its namespace. Since pid allocation is
hierarchial this can be ensured by checking each pid allocation against
the pid namespace's pid_max limit. This means if the allocation in the
descendant pid namespace succeeds, the ancestor pid namespace can reject
it. If the ancestor pid namespace has a higher limit than the descendant
pid namespace the descendant pid namespace will reject the pid
allocation. The ancestor pid namespace will obviously not care about
this.
All in all this means pid_max continues to enforce a system wide limit
on the number of processes but allows pid namespaces sufficient leeway
in handling workloads with assumptions about pid values and allows
containers to restrict the number of processes in a pid namespace
through the pid_max interface.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Christian Brauner (2):
  pid: allow pid_max to be set per pid namespace
  tests/pid_namespace: add pid_max tests

 include/linux/pid.h                           |   3 -
 include/linux/pid_namespace.h                 |  10 +-
 kernel/pid.c                                  | 126 +++++-
 kernel/pid_namespace.c                        |  43 ++-
 kernel/sysctl.c                               |   9 -
 kernel/trace/pid_list.c                       |   2 +-
 kernel/trace/trace.c                          |   2 +-
 kernel/trace/trace.h                          |   2 -
 .../selftests/pid_namespace/.gitignore        |   1 +
 .../testing/selftests/pid_namespace/Makefile  |   2 +-
 .../testing/selftests/pid_namespace/pid_max.c | 358 ++++++++++++++++++
 11 files changed, 522 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/pid_namespace/pid_max.c

-- 
2.34.1


