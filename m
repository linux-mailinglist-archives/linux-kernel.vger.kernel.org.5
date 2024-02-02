Return-Path: <linux-kernel+bounces-50003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF388472DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C860292BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6A145B13;
	Fri,  2 Feb 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihbB+xyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2A60249;
	Fri,  2 Feb 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886993; cv=none; b=t7KoeDRMb4Sx9BEQC6DGw2ta135ZDvDolvDWCt5zPEG9iZDz3d/qzu3+ZVm8h9jWAgGSJzQ2PGHI80eoZp24dW4Ms2aTE6r6X6n/kX4XHb676PhDnYU2z+CFhUFzmn8jYwiv7ZqCYW/xKtpaxdiNILlXofnBDlnte1LVTnstFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886993; c=relaxed/simple;
	bh=k9lEDuNDOKpvdVgrMMoR0W65Ok1r48Zfp3KRXHj8EUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMm46Ha3C4KQjQ5nokbWapOKz7CVMd9TWa05tXusfZkcYWf7VLaH8KiKBrIQqWetZ82QsePArthsTYLTCEFpE+/qerDLBKaJ93qNyYVda6GKkhC8OvVRiSMELy4DMVTmM3kypxrBGHitZ0oIT2ACX60uDOP4/yhxTx7qccl6Its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihbB+xyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33412C433C7;
	Fri,  2 Feb 2024 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886993;
	bh=k9lEDuNDOKpvdVgrMMoR0W65Ok1r48Zfp3KRXHj8EUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihbB+xyL8G2K+o0Mk0vZNrydSSxvIrGX/Z14R5H27aJMIUq3mfZWGbVh6jMu1HO1C
	 iJshUybT65HqKSZOoKxUFEp6muDzQc4UHPSN/UiqRQQsuZ5T6gTHmjPgu1htGx6f31
	 GiK6VEsq+3KC+Lw95oB0srFW+zAR9BZKd3uW6P0K+vwmsyiRAu8RXCl5D+kvJSWfnG
	 th1od8jtEyE1i0a8nYIzokhYlPOlcQBpq7yer4JX5cnz/G4RkHXDNB15f/qD0Az2CZ
	 TtUuT2AEZ96Z7XYen/r6xT5XSB0OZ0wwRvbqJqJe+43yUKo3eQM2tfc6clWOPsrSEE
	 mfcCZCMYcEDRA==
Date: Fri, 2 Feb 2024 16:16:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202-ideell-allmacht-2b536e5d7637@brauner>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202-arbeit-fruchtig-26880564a21a@brauner>

On Fri, Feb 02, 2024 at 03:44:45PM +0100, Christian Brauner wrote:
> > TODO: change do_notify_pidfd() to use the keyed wakeups.
> 
> How does the following appended patch look?

I missed the conversion in detach_pid() which should also just become:

diff --git a/kernel/pid.c b/kernel/pid.c
index de0bf2f8d18b..1bfcfa195226 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -351,7 +351,8 @@ static void __change_pid(struct task_struct *task, enum pid_type type,

        if (type == PIDTYPE_PID) {
                WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
-               wake_up_all(&pid->wait_pidfd);
+               pidfd_wake_up_poll(&pid->wait_pidfd,
+                                  EPOLLIN | EPOLLRDNORM | EPOLLHUP);
        }

        for (tmp = PIDTYPE_MAX; --tmp >= 0; )

