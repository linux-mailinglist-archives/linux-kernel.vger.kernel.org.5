Return-Path: <linux-kernel+bounces-63043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66238529AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7025C1F221FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34A1179AE;
	Tue, 13 Feb 2024 07:22:43 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67E17998;
	Tue, 13 Feb 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808963; cv=none; b=NeTklPDbXHRPw8zEN2ZT3MwCxf/Hb6V0HHsfXyyOH0pojd3pZ6FOHVDEh8MnmUKNe3QBFQW9kx83lBPMb9l2QCt9Q5Gqk3N1D+83QqBiBxsYsn+OUfebdoD8TTsJGLIWBCBzIMp8f9dhBOybgqW2KVLlaMxnlemxJXhC0HEwnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808963; c=relaxed/simple;
	bh=q2/wWV0cG4bqeLz1hLZCxS1bX1xLeiDQn9NLNf8iJow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6TDxAsbkdWy92FJo9gzBhBCMgY8GJWIeLlOUoV6b2c7CJy5/IFpPtj3Np+8iZSv4p+Ypuo6R9lCSYJXdw7GoEh/vPRpPY70UjheWSmMfMy6jTxwAtzjY94R0U8K9ZP60ZEi9efA5jDu+mXUQpr+nXzjLmo47z6aNPgPfYVMv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70692227A87; Tue, 13 Feb 2024 08:22:37 +0100 (CET)
Date: Tue, 13 Feb 2024 08:22:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <20240213072237.GA24218@lst.de>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

From reading the series and the discussions with Darrick and Dave
I'm coming more and more back to my initial position that tying this
user visible feature to hardware limits is wrong and will just keep
on creating ever more painpoints in the future.

Based on that I suspect that doing proper software only atomic writes
using the swapext log item and selective always COW mode and making that
work should be the first step.  We can then avoid that overhead for
properly aligned writs if the hardware supports it.  For your Oracle
DB loads you'll set the alignment hints and maybe even check with
fiemap that everything is fine and will get the offload, but we also
provide a nice and useful API for less performance critical applications
that don't have to care about all these details.

