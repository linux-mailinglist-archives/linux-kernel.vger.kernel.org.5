Return-Path: <linux-kernel+bounces-159156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61B8B2A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754AB285255
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF38153BC7;
	Thu, 25 Apr 2024 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Lt2kjDsz"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F8153809;
	Thu, 25 Apr 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077855; cv=none; b=f+Qqn1A7nqtO8V5FCeN10nOAR09IlaJGMfL7wxLqqg77QcwaoS6SGIhMBMGoprE7TQVXpF6JrX4w8MqEPxJYR+K8pIVZxW2zlXXFJp0yaAZTcWxhF9PNIoijRFkgmS1rPARHQC4AfiG17Bz7A5faNazyok9i6+LKfIWoplylxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077855; c=relaxed/simple;
	bh=WyRKRpDdDWspxjCjUuscQqnxFO2RBD2WTOpPg6Fwpw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JsJ5XX2g1gaF6Sfm8GtzGBOW5m800H5/mv7cRY18G9xx8uMpj493ZCuVH9W3Ub1cihZ15nhyovGPQZ6AgGEz6upWrDv7v6S1UnXJD1GsQHjlw8nYqJ8VLq/vaUfgUn/wfH6kgOh6AhM8tKP1vqFTD+zoy0olRUb1BopOF+SEav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Lt2kjDsz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tq5X8zmN+3k5A79fjsOahtoee5I5v66qJtvAbIOuA/0=; b=Lt2kjDszrhUtpDwANofp1SHp1c
	Tdsdb8Mbw2ACXHtyZvmIRF2ickkBKO0xNEKrwZiflhZQNJS4JkvSEvt+GRGkh+jfzdN6G22QEyX2T
	1YfaIyTpjgZ+nh7tkY8ZpI+jOXcO8OvLb53EpbaiDrkbp1nix/fMCmmBisSQ9S1LuCo5EXvRv3iJ0
	XfxyUt6lRoVwRlTa0gqDxKUlW97ExfduqAePjzuVTvYOk4iTOaiqXYlniMQZvXXJ7GFOhP4Pa0xcL
	eQzSdrcgb+TlND+gC3Qz9tF5iMwZqZE8qIAT2QX2pCKweoCimN1CrgsK5ydJq1qvbSFgvwaskPJSQ
	uFjrzW7Q==;
Received: from 201-42-129-95.dsl.telesp.net.br ([201.42.129.95] helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s05wW-008iV5-LF; Thu, 25 Apr 2024 22:43:45 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Paul Turner" <pjt@google.com>,
	linux-api@vger.kernel.org,
	"Christian Brauner" <brauner@kernel.org>,
	"Florian Weimer" <fw@deneb.enyo.de>,
	David.Laight@ACULAB.COM,
	carlos@redhat.com,
	"Peter Oskolkov" <posk@posk.io>,
	"Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
	"Chris Kennelly" <ckennelly@google.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Darren Hart" <dvhart@infradead.org>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	libc-alpha@sourceware.org,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Noah Goldstein" <goldstein.w.n@gmail.com>,
	"Daniel Colascione" <dancol@google.com>,
	longman@redhat.com,
	kernel-dev@igalia.com
Subject: [RFC PATCH 0/1] Add FUTEX_SPIN operation
Date: Thu, 25 Apr 2024 17:43:31 -0300
Message-ID: <20240425204332.221162-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

In the last LPC, Mathieu Desnoyers and I presented[0] a proposal to extend the
rseq interface to be able to implement spin locks in userspace correctly. Thomas
Gleixner agreed that this is something that Linux could improve, but asked for
an alternative proposal first: a futex operation that allows to spin a user
lock inside the kernel. This patchset implements a prototype of this idea for
further discussion.

With FUTEX2_SPIN flag set during a futex_wait(), the futex value is expected to
be the PID of the lock owner. Then, the kernel gets the task_struct of the
corresponding PID, and checks if it's running. It spins until the futex
is awaken, the task is scheduled out or if a timeout happens.  If the lock owner
is scheduled out at any time, then the syscall follows the normal path of
sleeping as usual.

If the futex is awaken and we are spinning, we can return to userspace quickly,
avoid the scheduling out and in again to wake from a futex_wait(), thus
speeding up the wait operation.

I didn't manage to find a good mechanism to prevent race conditions between
setting *futex = PID in userspace and doing find_get_task_by_vpid(PID) in kernel
space, giving that there's enough room for the original PID owner exit and such
PID to be relocated to another unrelated task in the system. I didn't performed
benchmarks so far, as I hope to clarify if this interface makes sense prior to
doing measurements on it.

This implementation has some debug prints to make it easy to inspect what the
kernel is doing, so you can check if the futex woke during spinning or if
just slept as the normal path:

[ 6331] futex_spin: spinned 64738 times, sleeping
[ 6331] futex_spin: woke after 1864606 spins
[ 6332] futex_spin: woke after 1820906 spins
[ 6351] futex_spin: spinned 1603293 times, sleeping
[ 6352] futex_spin: woke after 1848199 spins

[0] https://lpc.events/event/17/contributions/1481/

You can find a small snippet to play with this interface here:

---

/*
 * futex2_spin example, by André Almeida <andrealmeid@igalia.com>
 *
 * gcc spin.c -o spin
 */

#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <linux/futex.h>
#include <linux/sched.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

#define __NR_futex_wake 454
#define __NR_futex_wait 455

#define WAKE_WAIT_US	10000
#define FUTEX2_SPIN	0x08
#define STACK_SIZE	(1024 * 1024)

#define FUTEX2_SIZE_U32	0x02
#define FUTEX2_PRIVATE	FUTEX_PRIVATE_FLAG

#define timeout_ns  30000000

void *futex;

static inline int futex2_wake(volatile void *uaddr, unsigned long mask, int nr, unsigned int flags)
{
	return syscall(__NR_futex_wake, uaddr, mask, nr, flags);
}

static inline int futex2_wait(volatile void *uaddr, unsigned long val, unsigned long mask,
			      unsigned int flags, struct timespec *timo, clockid_t clockid)
{
	return syscall(__NR_futex_wait, uaddr, val, mask, flags, timo, clockid);
}

void waiter_fn()
{
	struct timespec to;
	unsigned int flags = FUTEX2_PRIVATE | FUTEX2_SIZE_U32 | FUTEX2_SPIN;

	uint32_t child_pid = *(uint32_t *) futex;

	clock_gettime(CLOCK_MONOTONIC, &to);
	to.tv_nsec += timeout_ns;
	if (to.tv_nsec >= 1000000000) {
		to.tv_sec++;
		to.tv_nsec -= 1000000000;
	}

	printf("waiting on PID %d...\n", child_pid);
	if (futex2_wait(futex, child_pid, ~0U, flags, &to, CLOCK_MONOTONIC))
		printf("waiter failed errno %d\n", errno);

	puts("waiting done");
}

int function(int n)
{
	return n + n;
}

#define CHILD_LOOPS 500000

static int child_fn(void *arg)
{
	int i, n = 2;

	for (i = 0; i < CHILD_LOOPS; i++)
		n = function(n);

	futex2_wake(futex, ~0U, 1, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG);

	puts("child thread is done");

	return 0;
}

int main() {
	uint32_t child_pid = 0;
	char *stack;

	futex = &child_pid;

	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);

	if (stack == MAP_FAILED)
		err(EXIT_FAILURE, "mmap");

	child_pid = clone(child_fn, stack + STACK_SIZE, CLONE_VM, NULL);

	waiter_fn();

	usleep(WAKE_WAIT_US * 10);

	return 0;
}

---

André Almeida (1):
  futex: Add FUTEX_SPIN operation

 include/uapi/linux/futex.h |  2 +-
 kernel/futex/futex.h       |  6 ++-
 kernel/futex/waitwake.c    | 79 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.44.0


