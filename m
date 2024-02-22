Return-Path: <linux-kernel+bounces-77143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA586019D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18737288342
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA813BAF7;
	Thu, 22 Feb 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXh++oq4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8513BAE2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626555; cv=none; b=qyEDC3aEAtvZ5nptMtTfCFbRqvg2ID52buvMSM7PbdxKOBaXD1J/Rx67Oy8p0FfXhgg+3WFUDD2d4ndd7UKWB+dTShVun/u7KcAfdolUuPACk0HFp+RZfqvaVSxtM5VHHRKnwpgod7B5lIAd3u9Rg+sa2IYY6GnoNgCEZ2gn1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626555; c=relaxed/simple;
	bh=eLoDaQ5497vWFnwGoufOSzIwFNqonoZsFTnjZb28mwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3wMShyJZuZrVkJ54YuWWIeN3OyGo5Q9+jJruQqBS9Psm2uVcB3bEm4jTGtvnnw0755FkciAc5ttiW0GoGQzkGZ/Fo/8PwPe7YHCrGtBUK6FrSeVZQIdtnClgQ+MUZu+m6PieXiCncXHZj+9QbESSABbYh98tNFrGwj5nGNPgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXh++oq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708626552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr8Yn1Cpu8PQZblyo7wqABSOEVcJb2+/02KvtI4t3EE=;
	b=eXh++oq4/Te0G6UJlSqbhECU4UC+OF7NTb+CQiYmwMTjlPR0+Rm28RF3szhiJ/H/JfLWa5
	awH3lc9/bYWL1/clR3GGSLM50KRC+L1vsAs+dzzTcACXzHcsKZa/IZNIsOhUW/TTJvc9W5
	0Vt6+s5jBWxEUPQb3G87d7sC6WhvPzQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-GzxCAY4_N0yjQ7_gGkJu6Q-1; Thu,
 22 Feb 2024 13:29:09 -0500
X-MC-Unique: GzxCAY4_N0yjQ7_gGkJu6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29FE828EA6F8;
	Thu, 22 Feb 2024 18:29:09 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E5355200B436;
	Thu, 22 Feb 2024 18:29:08 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 2D740400E4EBE; Thu, 22 Feb 2024 14:52:11 -0300 (-03)
Date: Thu, 22 Feb 2024 14:52:11 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] net/core/dev.c: enable timestamp static key if CPU
 isolation is configured
Message-ID: <ZdeJyxiTSKtkpHMO@tpad>
References: <ZdSAWAwUxc5R46NH@tpad>
 <65d7640c7983b_2bd671294c3@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d7640c7983b_2bd671294c3@willemb.c.googlers.com.notmuch>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Feb 22, 2024 at 10:11:08AM -0500, Willem de Bruijn wrote:
> Marcelo Tosatti wrote:
> > For systems that use CPU isolation (via nohz_full), creating or destroying
> > a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> > static key to be enabled/disabled. This in turn causes undesired 
> > IPIs to isolated CPUs.
> 
> This refers to SOF_TIMESTAMPING_RX_SOFTWARE, not SOF_TIMESTAMPING_OPT_TX_SWHW.
> See also sock_set_timestamping.

Willem,

This test program does trigger the static key change:

int main (void)
{
        int option = SOF_TIMESTAMPING_OPT_TX_SWHW;
        int sock_fd;
        int ret;
        int pid_fd;
        pid_t pid;
        char buf[50];

..

        /* set the timestamping option
         * this is to trigger the IPIs that notify all cpus of the change
         */
        if (setsockopt(sock_fd, SOL_SOCKET, SO_TIMESTAMP, &option, sizeof (option)) < 0) {
                printf("Could not enable timestamping option %x", (unsigned int)option);
                close(sock_fd);
                return 0;
        }
..


