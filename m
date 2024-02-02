Return-Path: <linux-kernel+bounces-49885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACE08470EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDCE290470
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD6F45C06;
	Fri,  2 Feb 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQh8y9jM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A946558
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879664; cv=none; b=mgLDuuKnrZFEFVHt5ScUkfLULDFAMEvWV69W6osusFzrekX0JHc3ucGO92eXbQqf5U/uLZ1DDbS8JvKSYWmZdIgdVK7TAseWNCBNdgI+HO5jPqsU8IElB9x49cG5m8+HFs7Okim5jdxCL2En5Q63cBbp/jmeWgI5uvuqTuITSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879664; c=relaxed/simple;
	bh=+4rrO1QV60it1fu/bNaIuzNzFnEVuH5GK9jcRGMYtQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V/5c/3ZYJlQMLWlEFiwFBeyu1588Lfu7liCJj4TQNvRZj8csMJYdThJV2AoZbEMJkiAYOIwxJssEf3YE6HnfEb7xi/sJ5un4zO/kukTZurNC5orGEehinbDf1kPGKQ1gXelRziPpsRC+eKpqguRTEhPvGkyGQERsgUhkyiErdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQh8y9jM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=SUcW1YhSjDQX7WeyM3q0JdmdY1LiP8oScsXALyNsO5g=;
	b=IQh8y9jMFqNWCqGxzKcyIPOOWp+OzmEdOZCfzr697KU+izMYYRu330zCFPAPWx7ZOkJv9G
	8rLWJgwwsCFCRzHSphMuPIFsWV51h/eLb8+Srezt0xSOqn9gevZXB4t59qLvvdNxPov9Nv
	gvj4TuN3cOs0W3aep0I6j4Vo/6Jac1s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-1uvxbfj6Oq2VwfEIFpopTA-1; Fri,
 02 Feb 2024 08:14:17 -0500
X-MC-Unique: 1uvxbfj6Oq2VwfEIFpopTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE193383CCE0;
	Fri,  2 Feb 2024 13:14:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8A8C6111F9;
	Fri,  2 Feb 2024 13:14:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 14:13:01 +0100 (CET)
Date: Fri, 2 Feb 2024 14:12:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pid: kill the obsolete PIDTYPE_PID code in transfer_pid()
Message-ID: <20240202131255.GA26025@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202131147.GA25988@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

transfer_pid() must be never called with pid == PIDTYPE_PID,
new_leader->thread_pid should be changed by exchange_tids().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 62461c7c82b8..de0bf2f8d18b 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -396,8 +396,7 @@ void exchange_tids(struct task_struct *left, struct task_struct *right)
 void transfer_pid(struct task_struct *old, struct task_struct *new,
 			   enum pid_type type)
 {
-	if (type == PIDTYPE_PID)
-		new->thread_pid = old->thread_pid;
+	WARN_ON_ONCE(type == PIDTYPE_PID);
 	hlist_replace_rcu(&old->pid_links[type], &new->pid_links[type]);
 }
 
-- 
2.25.1.362.g51ebf55


