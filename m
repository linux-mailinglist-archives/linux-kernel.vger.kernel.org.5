Return-Path: <linux-kernel+bounces-154209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1548AD952
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B1B20B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967E46525;
	Mon, 22 Apr 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce/o/vYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72345BFD;
	Mon, 22 Apr 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829861; cv=none; b=Nn6ztvruXsl8efgIqxwJ30k/Nwi6Jlz7qgYHJkJq+kLo3+MHxaUjt7N5koQzr0Kbn9gHYi2WPK4OBbXemxUzPMb9qWEr2RN2ysOyCHgufMqSbfu31gzB59Yp/RJqz0A9jKbQhaAdkC/1JPuZ8PyatxxkPK3PkwqCGe3/JyyT+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829861; c=relaxed/simple;
	bh=tFEFgMWQs6y1aDNqZ35H+2qCl1i2+BCPQTT7FTmshb0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LPP0jPHBiMuqIkJ4kBFdWrlFUNGmsvlD7dpmr/zNfMiDhzRlTWhOEL97LKa3eRONZ9iXcNAxg7A0LYPGAXrZWg4IgVW70eV50WTlG0QHjNNasT2K+bxQLCanjBjUTTg1Wd+VsWuhmAX3TZu/+USySf1rEogE7NsXtjPoBsS3wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce/o/vYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EECDC113CC;
	Mon, 22 Apr 2024 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713829861;
	bh=tFEFgMWQs6y1aDNqZ35H+2qCl1i2+BCPQTT7FTmshb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ce/o/vYwPazRINVizV7YNQ6a6u7lRlRxCTBOypp5iGMswAFX1jAFDdZLTFCL1TENd
	 bNiWh5E+ofBfqyDgd2Q8zWXPXHB1ITv0LC2ugkCJhj+d/HS3vwCcOiTD4qrmEJ06oP
	 sPSLrD8QOimVVPaLQafO04Tq4eFaxv1NIwpxZzrrMDAVX6GVq10d9RNL1641IKAyx1
	 og82EvcLz9nC31zcfsHQmts1HKWoJOdrWDlvda0YLIgz4YHzjQVNPFiCFd9z2/XfF0
	 guq+Q+DA4DHuCbvTqWCrmzq/GAsxzm0dljWC809ubNoiNHHdTDFetLd4yGYSEJWsn+
	 +WUtDnGHcZRDg==
Date: Tue, 23 Apr 2024 08:50:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 dcook@linux.microsoft.com
Subject: Re: [PATCH 1/2] tracing/user_events: Fix non-spaced field matching
Message-Id: <20240423085056.5deb4c21122c5b66e17b21c0@kernel.org>
In-Reply-To: <20240422215525.GA414-beaub@linux.microsoft.com>
References: <20240416224102.734-1-beaub@linux.microsoft.com>
	<20240416224102.734-2-beaub@linux.microsoft.com>
	<20240419113305.7b0ae2b11395eec16b5c15b6@kernel.org>
	<20240419211334.GA7774-beaub@linux.microsoft.com>
	<20240420215052.1f806c8acb5f99ec2f63945c@kernel.org>
	<20240422215525.GA414-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 14:55:25 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Sat, Apr 20, 2024 at 09:50:52PM +0900, Masami Hiramatsu wrote:
> > On Fri, 19 Apr 2024 14:13:34 -0700
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > On Fri, Apr 19, 2024 at 11:33:05AM +0900, Masami Hiramatsu wrote:
> > > > On Tue, 16 Apr 2024 22:41:01 +0000
> > > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> *SNIP*
> 
> > > > nit: This loop can be simpler, because we are sure fixed has enough length;
> > > > 
> > > > /* insert a space after ';' if there is no space. */
> > > > while(*args) {
> > > > 	*pos = *args++;
> > > > 	if (*pos++ == ';' && !isspace(*args))
> > > > 		*pos++ = ' ';
> > > > }
> > > > 
> > > 
> > > I was worried that if count_semis_no_space() ever had different logic
> > > (maybe after this commit) that it could cause an overflow if the count
> > > was wrong, etc.
> > > 
> > > I don't have an issue making it shorter, but I was trying to be more on
> > > the safe side, since this isn't a fast path (event register).
> > 
> > OK, anyway current code looks correct. But note that I don't think
> > "pos++; len--;" is safer, since it is not atomic. This pattern
> > easily loose "len--;" in my experience. So please carefully use it ;)
> > 
> 
> I'll stick with your loop. Perhaps others will chime in on the v2 and
> state a stronger opinion.
> 
> You scared me with the atomic comment, I went back and looked at all the
> paths for this. In the user_events IOCTL the buffer is copied from user
> to kernel, so it cannot change (and no other threads access it). I also
> checked trace_parse_run_command() which is the same. So at least in this
> context the non-atomic part is OK.

Oh, sorry if I scared you. I've seen bugs get introduced into loops like
this many times (while updating the code), so I try to keep it simple.
I'm sure that your code has no bugs.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

