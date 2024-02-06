Return-Path: <linux-kernel+bounces-55521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E800F84BDA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02C629288A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AB118EBB;
	Tue,  6 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLDz5s2K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15513FE0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246035; cv=none; b=nXjPESWwIsBwob4gD8ycajACwf4If1N5UYyEBNHcGywlN47G/RMTesvfQMkNbLYvIWl4OEkokVnsMibHpp+0/vOYcL6ovDwBZY1sa5EEMKnOSc97agP5d0LJMyUWgrIjMMSkoJW48k0pMDWkEtTlb0B6VeHR6gVn7rN2PC83tQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246035; c=relaxed/simple;
	bh=DKAkQDTSg60TJCBb7/xeVF50KxZPmafeQUrQ3jGuS8Y=;
	h=Message-ID:Date:From:To:Cc:Subject; b=HOU3giUeGth4GZ2l5StJY6K8tMX+2aEUyEcPu2I6DxmKc3TgdXiX5yEJp+kv9KTlq82oTIO0531yQo0TtsU6idLyYALQJYLt/wdjDfp1AcnxCQnH0IT8qPj1Foxg76qx3oTzwKJUNX/Ixid9/ojDkTZbajjYsjiMdNZ1vikhbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLDz5s2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Ibm5FqB46GymEmUuHimuEYngo5bIcjN77O9q5HhCPbY=;
	b=RLDz5s2KNfMJaaezLfTH6++8Tv9dzvK5OqFWACUUMJCMaYipbn37T47cW8yJMHvnhKNwsc
	j60ui5gIx+BXlWMi7FMTg2Xs86GA60cf/Sbjm2Pbx7hyUTzwqXiqgjuDghE7GcmhvQ9tVO
	iCp624ixizKLtDKsUkNPbtIhI68RfoI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-Sc0B_racPByvimcSv3ex5Q-1; Tue,
 06 Feb 2024 14:00:26 -0500
X-MC-Unique: Sc0B_racPByvimcSv3ex5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3399D1C0BA46;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EF0861121312;
	Tue,  6 Feb 2024 19:00:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 11B764011A2A0; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206184911.248214633@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:11 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 00/12] cpu isolation: infra to block interference to select CPUs
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There are a number of codepaths in the kernel that interrupt
code execution in remote CPUs. A subset of such codepaths are
triggered from userspace and can therefore return errors.

Introduce a cpumask named "block interference", writable from userspace.

This cpumask (and associated helpers) can be used by code that executes
code on remote CPUs to optionally return an error.

Note: the word "interference" has been chosen since "interruption" is
often confused with "device interrupt".

To protect readers VS writers of this cpumask, SRCU protection is used.

What is proposed is to incrementally modify code that can return errors
in two ways:

1) Introduction of fail variants of the functions that generate
code execution on remote CPUs. This way the modified code should
look like:

idx = block_interf_srcu_read_lock();
ret = smp_call_function_single_fail(cpu, remote_fn, ...);  (or stop_machine_fail)
block_interf_srcu_read_unlock(idx);

This is grep friendly (so one can search for smp_call_function_* variants)
and re-uses code.

2) Usage of block interference CPU mask helpers. For certain
users of smp_call_func_*, stop_machine_* functions it
is natural to check for block interference CPUs before
calling the functions for remote code execution.

For example if its not desirable to perform error handling at
smp_call_func_* time, or if performing the error handling requires
unjustified complexity. Then:

idx = block_interf_srcu_read_lock();

if target cpumask intersects with block interference cpumask {
block_interf_read_unlock();
return error
}

..
ret = smp_call_function_single / stop_machine() / ...
..

block_interf_srcu_read_unlock(idx);

Regarding housekeeping flags, it is usually the case that initialization might
require code execution on interference blocked CPUs (for example MTRR
initialization, resctrlfs initialization, MSR writes, ...). Therefore
tagging the CPUs after system initialization is necessary, which
is not possible with current housekeeping flags infrastructure.

This patchset converts a few callers for demonstration purposes.

Sending the second RFC to know whether folks have objections
(there were no objections to the first release), or have
better ideas.




