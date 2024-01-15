Return-Path: <linux-kernel+bounces-26191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BFE82DC96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD5282890
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7317755;
	Mon, 15 Jan 2024 15:48:30 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3B17753
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-mu28odDXNe6GqZItmyk1Zg-1; Mon, 15 Jan 2024 10:47:11 -0500
X-MC-Unique: mu28odDXNe6GqZItmyk1Zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34DB5863012;
	Mon, 15 Jan 2024 15:47:11 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B45B13C25;
	Mon, 15 Jan 2024 15:47:09 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux Containers <containers@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Joel Granados <joel.granados@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
Subject: [RESEND PATCH v3 0/3]  Allow to change ipc/mq sysctls inside ipc namespace
Date: Mon, 15 Jan 2024 15:46:40 +0000
Message-ID: <cover.1705333426.git.legion@kernel.org>
In-Reply-To: <cover.1663756794.git.legion@kernel.org>
References: <cover.1663756794.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Right now ipc and mq limits count as per ipc namespace, but only real
root can change them. By default, the current values of these limits are
such that it can only be reduced. Since only root can change the values,
it is impossible to reduce these limits in the rootless container.

We can allow limit changes within ipc namespace because mq parameters
are limited by RLIMIT_MSGQUEUE and ipc parameters are not limited to
anything other than cgroups.

This is just a rebase of patches on v6.7-6264-g70d201a40823.

---

Alexey Gladkov (3):
  sysctl: Allow change system v ipc sysctls inside ipc namespace
  docs: Add information about ipc sysctls limitations
  sysctl: Allow to change limits for posix messages queues

 Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++--
 ipc/ipc_sysctl.c                            | 37 +++++++++++++++++++--
 ipc/mq_sysctl.c                             | 36 ++++++++++++++++++++
 3 files changed, 82 insertions(+), 5 deletions(-)

-- 
2.43.0


