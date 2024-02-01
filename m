Return-Path: <linux-kernel+bounces-48673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB5845FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8DFB28663
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3828564B;
	Thu,  1 Feb 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR3YlcXz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88412FB0F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811092; cv=none; b=px3TetNRrLiwFUDR/BsmYE0neGme3ZApQx2S+0aAuTohgCxFfWzenAsqKzXj5fMvrEUBOsgR2zCOoqeLxXHapNacnx7pB4Mzve69OM2PmbRvYuDSLmV71fPi6/kVidxyEq9c2aQPNrEzLKDLENX+H1Wl1KfFLMFhjLKH1YYGVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811092; c=relaxed/simple;
	bh=zmHNqS7S/GuQeB3Mbfvj7+e3lNP8Cq+acww9J2gr/8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kizop4cmDMljDqm6DvlfYJcw2F1ELrc3vTe+uvA7T0YA3uk9Y+acbh6SpIxYKWNM2j2suS4zq62PJkKxNvgZH1nfxwe8DATIB9zNDT1S0SFcjajgCqPegZfGo+yyr9St2sipRAYWBuwgWaTkdujCPKhZdqFazI3pSsx5FRSBoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR3YlcXz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706811089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmHNqS7S/GuQeB3Mbfvj7+e3lNP8Cq+acww9J2gr/8A=;
	b=LR3YlcXzmWxAo9VRC60NXWlFDz1PuTR/z8StdkyUs1E2NJHft3ZFl+0gCPOFlVzam+7S9N
	FGSuhSD0qdCyc7GKjfgsN1lItR94gexvCZM1dGiGhs2vvDDJ9kt3WbmTPHhW/w5yQz5hot
	vIQAIhJiaCtf9jx+TLSIw2rqr351e3A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-PIa3wvWaOmKyz-OWa5qEGA-1; Thu,
 01 Feb 2024 13:11:27 -0500
X-MC-Unique: PIa3wvWaOmKyz-OWa5qEGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82D493C0F189;
	Thu,  1 Feb 2024 18:11:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.96])
	by smtp.corp.redhat.com (Postfix) with SMTP id 48FAE1C060AF;
	Thu,  1 Feb 2024 18:11:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Feb 2024 19:10:13 +0100 (CET)
Date: Thu, 1 Feb 2024 19:10:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240201181006.GA31459@redhat.com>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
 <20240201-dokumentieren-holen-bc44288345b5@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-dokumentieren-holen-bc44288345b5@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/01, Christian Brauner wrote:
>
> One more thing that came to my mind. We also support waitid(P_PIDFD,
> pidfd). And I just looked through the code and I think it does the right
> thing when we pass it a PIDFD_THREAD pidfd

Yes, I too looked into kernel_waitid_prepare(P_PIDFD) and didn't notice
anything wrong,

> because wait_consider_task()

Even simpler, I think. waitid(P_PIDFD, pidfd_with_PIDFD_THREAD) doesn't
really differ from waitid(P_PID, pidfd_pid(pidfd_with_PIDFD_THREAD)), so
it should work "as expected".

Oleg.


