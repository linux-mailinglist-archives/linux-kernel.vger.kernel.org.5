Return-Path: <linux-kernel+bounces-49882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DA8470E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF66B2445B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5A3F8DF;
	Fri,  2 Feb 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkFD1+DU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ADC20F7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879597; cv=none; b=FEBdXsM1g5yq6RRsBGhZTJfyG3Lqp+8NgufjqcAYe3L7J77S968NjL/tupaLYUPrxCygG8jncUikVCLyFmCrLncVAdN2XNPpJSKLqGzuR9Sf4xtHlU6MTAB8yS+KHOzDwJB0iM2UpRovJhMH+5jo1hyzyxSGye7BHz+wE1pFSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879597; c=relaxed/simple;
	bh=7S/SO1o8R2uNszq4h2vmFZrLGrDuPvYiEA1NZDU/cp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hsbg0OGuARD+TER2Qp6vvIKOUgsbHaJ5mRMlbBnO8qRQu2Mp087zdfxnVPfX1kwS1A8iqtw4/+3mhtqolp1v4NHybeN5yi+ufR+M7jTMauxUV5zo5O/xAVtxxxjECU40TJWwwQQwS0oJ3aDVG+OYa+xgY0jqbnf+LbvmljyrHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkFD1+DU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7S/SO1o8R2uNszq4h2vmFZrLGrDuPvYiEA1NZDU/cp4=;
	b=PkFD1+DUGUyCO4oAivDNScxb1jCIwUJ4NE19VTmnlCQhKOhv6949X+ITFpvXCeYVVojS1a
	R5mCyAzg7pr6Hx3tNNbYAEtMWuqFvDe6Itr+GgsP7r8j8dH1nCpabuorW9tfFrbKbd6dX8
	HPsU03y24KpDhgQ+7pZzZlQci8UWA94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-xkv9_n6TP1uDBHEEG6A2qw-1; Fri, 02 Feb 2024 08:13:09 -0500
X-MC-Unique: xkv9_n6TP1uDBHEEG6A2qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C765C85A58E;
	Fri,  2 Feb 2024 13:13:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id EC1581121306;
	Fri,  2 Feb 2024 13:13:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 14:11:53 +0100 (CET)
Date: Fri, 2 Feb 2024 14:11:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202131147.GA25988@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

3/3 is the unrelated "while at it" change.

Oleg.


