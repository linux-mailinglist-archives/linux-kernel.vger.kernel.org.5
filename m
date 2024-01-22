Return-Path: <linux-kernel+bounces-34281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE17837762
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C39282F89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A37495F1;
	Mon, 22 Jan 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rj3ezUeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B985495D0;
	Mon, 22 Jan 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964675; cv=none; b=B2oLIQTzKe9RZaT03tSayU/sIkaGp93URd+jU/ycn9Hmj9NOaQ0R3DZBi52As5pB3JEVqplUPBEnHRKR2i0Zm26U/EuITMZvlEifjcu200rdD4lw7B/ydxkDc7T3DOsMrEugJjnmRMXzCrflkY0xL6K1AjEmOrL83l5Om5/3afI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964675; c=relaxed/simple;
	bh=0WtBFrKbQ+ipOh3xWeUTAfnGIGSgexddLuxNCH/vWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3x94JYKWCq+07xoe8pxpMwCFG4BIRj5TKWxTUYD8ZKY9ZZ3A31Cbs3qxXDUNqvhhBxspfe4w+mDsW55A6IqDTwytHs8qGJ+SmtdekqT3kstiO7we3Nv9+GOZgTqU5wndlLQ2vteDBE3Qvm4TX9fZCKKKoN9aj3R8OfEMOby76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rj3ezUeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95113C43390;
	Mon, 22 Jan 2024 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705964675;
	bh=0WtBFrKbQ+ipOh3xWeUTAfnGIGSgexddLuxNCH/vWcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rj3ezUequMXxmACTz6uTOy5MSeztBwQYkUA9QcmiyOskbQZffb4yBIjyYGfVlnYqn
	 LL1TLLkmOPHcYlp12jln+Khzjt71kn6jhJFGWN4fmm7IEwiIGHS/m6UBM9WlJLbYxl
	 +yDgTVdz0hlCkFe8vw8fYVRT06IFqocJqso0N1Qw=
Date: Mon, 22 Jan 2024 15:04:30 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"david@redhat.com" <david@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Message-ID: <2024012210-outshoot-dragonish-fe8e@gregkh>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
 <2024012205-undrilled-those-2435@gregkh>
 <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Jan 22, 2024 at 10:49:32PM +0000, Joakim Tjernlund wrote:
> Seems like I pasted the wrong commit(sorry), should be: ac3f3b0a55518056bc80ed32a41931c99e1f7d81
> I only see that one in master.

And what kernels have you tested this on?  How far back should it go?

For mm patches like this, that are not explicitly tagged by the
maintainers to be included in the stable tree, we need their ack to be
able to apply them based on their requests.  So can you get that for
this change and provide tested patches, we will be glad to queue them
up.

thanks,

greg k-h

