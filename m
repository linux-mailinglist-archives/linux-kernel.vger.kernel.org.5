Return-Path: <linux-kernel+bounces-104798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1587D3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92C028373F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363341DA26;
	Fri, 15 Mar 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyT4NJ7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE01773A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528187; cv=none; b=GRI1R5aJrnWcCWTNrvh240aeMj95hcla9NWxKxrXc42qHuH7AsLexJI0z9GriWhhJNER9o3JV8Eop7SCd4u5fqZ7saiq5KCwDmrZ1pQSyIaHxjdTJhMRML/w+4Yqyt72fOIbcp5syLPXP4b3zhR32XM3f74XM0hMxxrU6xEDbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528187; c=relaxed/simple;
	bh=98MTCnh6TECtUmXxeS5Lwt+fSihK/4r/o1UN5fsD114=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL3nr5+sGqvLV2A1SDW00qOgUTEJ6HZUfHoUJYrvib4b1dLxjPd/cLQnar0strrD05adB6zg93OdtRsWYdzlGXmGv6kO2Xc7DkYZRfLfud3ZU6OoDUDqiqmj7en4yFCuAJQPQSXtaJluRKKKA1nDK03fXu1cdwXRT54rExQnubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyT4NJ7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710528184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZH9r4p0GtIqMoZLiNXBZTSG5yeJKfeoz7ghLeMWCPQ=;
	b=WyT4NJ7K5gBM67jPyrg1FNQ5r4VjwPxU3ICNXv8NZlHcOKZNfDQznLOmQZ2hJFTcKVNoQN
	OsMzOfE83PehlWuJvhN8s9Rbfo3rc9pWc3bknRA2NwJXWk/epuF45Jxu2oMnxiTpC3hCOa
	34tWAxEAKrprX6UzvFYJvKHv/Ofz4Dc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-ewXAzk3MOUq9i9D13ZZQyQ-1; Fri,
 15 Mar 2024 14:42:56 -0400
X-MC-Unique: ewXAzk3MOUq9i9D13ZZQyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AED393CBDF76;
	Fri, 15 Mar 2024 18:42:55 +0000 (UTC)
Received: from redhat.com (unknown [10.22.34.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 72AD1111E406;
	Fri, 15 Mar 2024 18:42:55 +0000 (UTC)
Date: Fri, 15 Mar 2024 13:42:49 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [GIT PULL] dlm fixes for 6.9
Message-ID: <ZfSWqXKWnalm9wE5@redhat.com>
References: <ZfNFRg-KxTCTPf92@redhat.com>
 <CAHk-=wh4qK+zHrrYehidKRp4Fi6e4qUD6Tv6Ed8USxUC+H+HrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4qK+zHrrYehidKRp4Fi6e4qUD6Tv6Ed8USxUC+H+HrQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Fri, Mar 15, 2024 at 10:10:00AM -0700, Linus Torvalds wrote:
> Now, if the issue is that you want to clean up something that is never
> getting cleaned up by anybody else, and this is a fatal error, and
> you're just trying to fix things up (badly), and you know that this is
> all racy but the code is trying to kill a dead data structure, then
> you should
> 
>  (a) need a damn big comment (bigger than the comment is already)
> 
>  (b) should *NOT* pretend to do some stupid "atomic decrement and test" loop

Yes, that looks pretty messed up, the counter should not be an atomic_t.  I was
a bit wary of making that atomic when it wasn't necessary, but didn't push back
enough on that change:

    commit 75a7d60134ce84209f2c61ec4619ee543aa8f466
    Author: Alexander Aring <aahringo@redhat.com>
    Date:   Mon May 29 17:44:38 2023 -0400

    Currently the lkb_wait_count is locked by the rsb lock and it should be
    fine to handle lkb_wait_count as non atomic_t value. However for the
    overall process of reducing locking this patch converts it to an
    atomic_t value.

.. and the result is the primitives get abused, and the code becomes crazy.
My initial plan is to go back to a non-atomic counter there.  It is indeed a
recovery situation that involves a forced reset of state, but I'll need to go
back and study that case further before I can say what it should finally look
like.  Whatever that looks like, it'll have a very good comment :)  Dropping
the pull is fine, there's a chance I may resend with the other patch and a new
fix, we'll see.

Thanks,
Dave




