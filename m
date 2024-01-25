Return-Path: <linux-kernel+bounces-38976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9398483C941
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A47728E4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48389634FE;
	Thu, 25 Jan 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHjDWJpg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90473130E49
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201813; cv=none; b=j2bY/1YCBH3slPKrGywx3tywHCBT0dI6fe//6+sM3/CJ0MYMT1br68bCkOXM5Cppcmkt3WZh7u0Empgx23GYUA651HcVBWkPDRWBOaIU5zlOTXOKSEuXGHHjC6MAphXLkARpg9Ve5tSvF0JvaqSV4CaP9xbnglgEQFlJ6QiLCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201813; c=relaxed/simple;
	bh=1sTZ+zEkcv7X14oQBE4UTL4RsqGxbU7PMBa+rtxrLAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8CVBEBWQaRZrViWrGvxrHnbxvNQNZFmdYroSlEt3kDcHClUyFr+bjXrucFmyUbXcMV5rwJ4ckl3D+A3gB+CuFcZBW1tEufJl9Oe+o5AH+IqNZ775t4UfQJ/StvRqJHtzbZzn3uuJTQGpaTOYVtydce5rQT3swdRq0mq7voCaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHjDWJpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F978C43390;
	Thu, 25 Jan 2024 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201813;
	bh=1sTZ+zEkcv7X14oQBE4UTL4RsqGxbU7PMBa+rtxrLAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHjDWJpgDAN5cfyyU0T7hSSZ14cA32xnalq9bCY98hCe6UmEf1tPhtME6VaWgJqp6
	 katTSVQktQcY3qw2sw/7JIEwgnRtMOBZq0Jc2sAXrp6BE94WBcV8TT6otOG5PNRlum
	 4DZkTorTVUiB+2iKh7AFFV9XVHXOd59/PO3RKYXHaILY2l8RmZCqQPep5+8J33HuTJ
	 qPbeOlURmxqmmHpxYEc6FBnteTNkqP1AiIM16x0Nvip2yW/3Nxn0vYOGMyKVpL83Qc
	 IfvrPhdxTNspN52YuFQ7uWzK9+Btj7Qbgz3xlBz16xsqAQkJEse3jpY7CgNe7UzRpI
	 IIErfRODUFovw==
Date: Thu, 25 Jan 2024 17:56:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tandersen@netflix.com>, Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pidfd: cleanup the usage of __pidfd_prepare's flags
Message-ID: <20240125-gefeuert-sorgenfrei-0debf1b4a2e6@brauner>
References: <20240125161734.GA778@redhat.com>
 <20240125-kilometer-erwischen-9077030e4326@brauner>
 <20240125165322.GB5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125165322.GB5513@redhat.com>

On Thu, Jan 25, 2024 at 05:53:22PM +0100, Oleg Nesterov wrote:
> On 01/25, Christian Brauner wrote:
> >
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> 
> OK, thanks.
> 
> This can also simplify the possible PIDFD_THREAD change we discuss.

Sounds good. Thanks for cleaning the flags bit up.

