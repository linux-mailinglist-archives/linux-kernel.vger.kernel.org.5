Return-Path: <linux-kernel+bounces-59222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5684F369
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2601C212DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647669950;
	Fri,  9 Feb 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws005v4F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F569941
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474584; cv=none; b=GFKu3eWrMt24EP/35Fbnm/X7CioCDgJ0xQjYq6UZ2xgFkoQMQhzl0ZqnSvniKab796aitFB/kKlh9/yQVLUTSmAZ2p+UwaDWRH+J5AkEQN+AfkFKCAPu3ZF0Neh721FlOraMSooQV2DlFAqV7M1dL2y3sN3Iep3aLChigFoRwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474584; c=relaxed/simple;
	bh=HHUvxWEQeOWIogeQUKI+8xGetAxWcmQWvB4EKQ6xgDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ2PRbVdGwZbNArKTbJPI6bCeNaM9sSe7/TFVnWnAatdY11HgAgzTyTHB68kGvnSVbok3xBGNR3XAqAOuD3l06A4exuyVwbmqpt2+MpiBUzbn3rjUAUDRLxrc5rGATIIxBzJk4lsvbfDQYVd/kn7FUzIjdPICAL6ZFoiUBAPXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws005v4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707474581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHUvxWEQeOWIogeQUKI+8xGetAxWcmQWvB4EKQ6xgDY=;
	b=Ws005v4FCME7kK0Q9VpFg5YJaMxfb8u56SlUKy/5oBOVV41aLqAHBhjfpyBfbTsXc8/1QW
	BsaJSsUMnfquZ00xMp36VPmYLyTK4Z1RQRIvDZ4aKQb8I45mKW5C64JMxewopYGW2PMHCq
	hG3WoeRXKHM6t53m0MtvGcAj+5NVPRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-EERUOpjmM0WcW_tGN8tCrg-1; Fri, 09 Feb 2024 05:29:36 -0500
X-MC-Unique: EERUOpjmM0WcW_tGN8tCrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F5E5185A781;
	Fri,  9 Feb 2024 10:29:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 509E82026D06;
	Fri,  9 Feb 2024 10:29:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 11:28:19 +0100 (CET)
Date: Fri, 9 Feb 2024 11:28:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240209102816.GA3282@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
 <20240208143407.GF19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208143407.GF19801@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/08, Oleg Nesterov wrote:
>
> Is prepare_kill_siginfo() correct when we send a signal to the child
> pid namespace? si_pid = task_tgid_vnr(current) doesn't look right

Yes, but iiuc send_signal_locked() should fixup si_pid/si_uid, so it
is not buggy.

> And why do we need it at all? Can't sys_kill() and pidfd_send_signal()
> just use SEND_SIG_NOINFO?

Probably yes. And even do_tkill() can use SEND_SIG_NOINFO if we change
__send_signal_locked() to check the type before ".si_code = SI_USER".
but then TP_STORE_SIGINFO() needs some changes...

I'll try to do this later, I do not want to mix this change with the
PIDFD_THREAD changes.

Oleg.


