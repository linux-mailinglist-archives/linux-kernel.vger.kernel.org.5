Return-Path: <linux-kernel+bounces-141878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E928A248C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A6BB21640
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBA17C7C;
	Fri, 12 Apr 2024 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dOfhEEQ9"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670617BBF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894166; cv=none; b=XAnez24Ck3wc2N8OmneC8TcQc5w7HpdhS0jZPKRydWPezUYFsxf4FqFxREUwr0Xi2ZvBlTs0+htfenefBIrn24mfziaE5HF6Otqu5fQUGkkbGpY/lccV6D3NUhtxa2gbobwtSg6sEDfxJ4TFZXK1LAX/ZUq6IplK7DsmHhKilnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894166; c=relaxed/simple;
	bh=jgsySEBfBr2yKswNUwikz+FITKjJFHnZo959lH69wCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5pW54PSRuj5l+0T70MEIcz/53ntB/B5ThLMx/6Pb+TzaQRk5shAXkjrWlQWVJpmy0DZfu7mDmkJpGHgyq0/2hE0+IQNMM5Xughwk0KAKlmfcqtVFBB5qi6JzcnKt1nruu83LcAUPnVqKvahhIgujRKiMWaSWx7q63dfCxkAAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dOfhEEQ9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-60.bstnma.fios.verizon.net [173.48.113.60])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43C3taCf022568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712894139; bh=3y/worbB/UJgc5iThuhYF+NXbVCCGkZo3/cJ22BJobY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dOfhEEQ9qq2eBitbPxPjKxnkbJWSMYIq1Rs9v8s7FZrm/N+xrL/FeLtG4Xhco4aa+
	 9KjnG+3c+QEho2i8qjlsc0/V877gOB3E8JgjYiqA57Y2vbPvf49slCx5MILUZxHBmx
	 M/uyW4qTo6mLzYZ6Rbl+m/tuv6ctdgKrStE5y97R99R2NZ4FMnpyVdqs+OENXLL/Xs
	 2upBA/iKiGG6BwvhxfYFaA9uZbibTNfkoMhR55UJhrrzdpJGr5FIqVbuICSZAgZaXd
	 4K5o0QgrJuXwth+ijJ0iMDwdxYa/OUnBU04kgq6AtFtWJDfbwpyKwI4SCxTPujQcUW
	 5Gk1v01opiBUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7761F15C00DE; Thu, 11 Apr 2024 23:55:36 -0400 (EDT)
Date: Thu, 11 Apr 2024 23:55:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240412035536.GD187181@mit.edu>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3>
 <20240403033742.GE1189142@mit.edu>
 <20240403101122.rmffivvvf4a33qis@quack3>
 <6611F8D5.3030403@huawei.com>
 <20240411133718.tq74yorf6odpla4r@quack3>
 <20240411145559.GB187181@mit.edu>
 <66188E1B.6070209@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66188E1B.6070209@huawei.com>

On Fri, Apr 12, 2024 at 09:27:55AM +0800, yebin (H) wrote:
> I thought of a solution that when the commit block checksum is
> incorrect, retain the first 512 bytes of data, clear the subsequent
> data, and then calculate the checksum to see if it is correct. This
> solution can distinguish whether the commit is complete for
> components that can ensure the atomicity of 512 bytes or more. But
> for HDD, it may not be able to distinguish, but it should be
> alleviated to some extent.

Yeah, we discussed something similar at the weekly ext4 call; the idea
was to change the kernel to zero out the jbd2 block before we fill in
any jbd2 tags (including in the commit block) when writing the
journal.  Then in the journal replay path, if the checksum doesn't
match, we can try zeroing out everything beyond the size in the header
struct, and then retry the the checksum and see if it matches.

This also has the benefit of making sure that we aren't leaking stale
(uninitialized) kernel memory to disk, which could be considered a
security vulnerability in some cases --- although the likelihood that
something truly sensitive could be leaked is quite low; the attack
requires raw access to the storate device; and exposure similar to
what gets written to the swap device.  Still there are people who do
worry about such things.

						- Ted

