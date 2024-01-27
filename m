Return-Path: <linux-kernel+bounces-41197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B983ED42
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D437928357E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964364A;
	Sat, 27 Jan 2024 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXuTrN4o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756B1EB35
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361727; cv=none; b=PAwETV+NrI5hHHebs9NFquop4CTlzqV6ph79mrfJnBr30PJcm1+MD42b5fcMhbWmNSPP/LY92ZXBqlzWOKfix3P8eg6X5TsNByICxYkcmYTWICdtWupMG8iP2qvV7Ua6PILirv/98ZLfAaaVx3Tg3Zn3F9rw+xm3epkYbHIlQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361727; c=relaxed/simple;
	bh=X1CLxQKeaSb1l/96Z5lNrZ6auc6d5+v9GZ9hezleqQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cO+gioipweWfL5qj4HPl5IIkJeHOVCt+B7HPyOSUtmzKIOXHKSDQVJK1TRxSUmcPWQclJgQwF49i2Jt6YsawnsEjOgBQUkZRqXpPYQurX09a6oKZk+lCmGkJokVz+pGqT5NYqrQBi+/tPP5AQtZHw8zDC0cW8+FlnMZ7QmFpkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXuTrN4o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706361724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=X1CLxQKeaSb1l/96Z5lNrZ6auc6d5+v9GZ9hezleqQY=;
	b=NXuTrN4ofrNellS5g3YB8QRCULBPirsmVV6j/JEwPsx9eCQDc3yXGZdS/DgnlTGU5fvQe8
	2ukfgEUOO5UUuRn+nlQO9NorrGA15q1jBl8L/MX7uIJz0gpJMQO4chCLghb9fZvz5NcRjR
	JI1Hjl5WquK/Zqin8I1A195UBsOG5FE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-gLbFMwudP2SX68C3YKodWg-1; Sat,
 27 Jan 2024 08:22:00 -0500
X-MC-Unique: gLbFMwudP2SX68C3YKodWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C21C7383CD79;
	Sat, 27 Jan 2024 13:21:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by smtp.corp.redhat.com (Postfix) with SMTP id 6F3FF492BC6;
	Sat, 27 Jan 2024 13:21:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 14:20:45 +0100 (CET)
Date: Sat, 27 Jan 2024 14:20:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] pidfd: don't do_notify_pidfd() if !thread_group_empty()
Message-ID: <20240127132043.GA29080@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

To me this patch makes sense regardless, but also this is another
preparation for PIDFD_THREAD change we discuss.

Oleg.


