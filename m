Return-Path: <linux-kernel+bounces-39120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D583CB15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023A91C23405
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A5137C5C;
	Thu, 25 Jan 2024 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IX+HgYcT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93879C7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207201; cv=none; b=eBzheF7XAFcjgmvPpF/UwXCUi+nLrdK3V6ZVUzbjio64TbcrjZaRwbg0C57wtVW4Ro+wsqHku980GOMQTqhtjVDAgm5QDT0Sf57MiJdrvlmJpmeTS9VxGoxxPLgevWVGES4bo3Znwh57l/cYz0d4+6FUAXDxrH39yb9KXMg1FG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207201; c=relaxed/simple;
	bh=p53X8di65S3zmcAB+leeB/kf78sYPEDljz8OXoCEywA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHEanEe1/Sis4/5PvFL7vM+mU8Yd4iz0/cRxO8/qmyhlO3f3FH7O1UdiC49ci6Po6Nbl1f+bNNNaSCEJTLOc4dO3odfgGUau/TeWPr+GR7BSkaLbx5JUlrmvic+bhNyBE6Hw+Moa+jtWPrwPEwjL2o1CNyKQSlZ2/3jEie7OVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IX+HgYcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706207198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p53X8di65S3zmcAB+leeB/kf78sYPEDljz8OXoCEywA=;
	b=IX+HgYcT9ztAL2RsLZXwC9wvlMWfIXv6Q6i44/VfUcTHX0pQRrgyb33lmshs0R+R4OYuLY
	D9ICWKxAUkWtOgTJlPJWWE468BhLIueXQhZeV3nQrcM04II6EP73hAokCpSPiq7UAW+Am5
	P3GPUIr6zZsl7bnJSI0unuUfo1BXjeo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-vM6f3SOxPyiC3_8HDtQbiA-1; Thu,
 25 Jan 2024 13:26:28 -0500
X-MC-Unique: vM6f3SOxPyiC3_8HDtQbiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C0C3C1E9C5;
	Thu, 25 Jan 2024 18:26:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 092A53C2E;
	Thu, 25 Jan 2024 18:26:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jan 2024 19:25:08 +0100 (CET)
Date: Thu, 25 Jan 2024 19:25:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240125182505.GD5513@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
 <20240125175113.GC5513@redhat.com>
 <ZbKigMNQM0Yklc/5@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbKigMNQM0Yklc/5@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/25, Tycho Andersen wrote:
>
> One of the things I don't like about PIDFD_THREAD is that it's hard to
> tell whether an arbitrary thread is a leader or not. Right now we do
> it by parsing /proc/pid/status, which shows all the stuff from
> do_task_stat() that we don't care about but which is quite expensive
> to compute. (Maybe there's a better way?)
>
> With PIDFD_THREAD we could could do it twice, once with the flag, get
> EINVAL, and then do it again. But ideally we wouldn't have to.

Too late for me, most probably I misunderstood.

If you want the PIDFD_THREAD behaviour, you can always use this flag
without any check...

Could you spell?

Oleg.


