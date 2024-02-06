Return-Path: <linux-kernel+bounces-55283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DA84BA34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750E41F27000
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A0134CC0;
	Tue,  6 Feb 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2St3c+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521861339B7;
	Tue,  6 Feb 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234878; cv=none; b=NwHzn4VJKbW/yhTRxNnaRZTWxpmNb9wUXwvyGlNZ+N96byJq/9extR7wQ/DO2Va2RLOlvXYckzFij3i0pUkU4z/vl6qFVEv2cg14F9csuqkKmUfSHqAdYCV4VKTT84O+ZuDh4p24C8NuyVVSSPB6ab9N1m2K3C3wnzcG9JLpr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234878; c=relaxed/simple;
	bh=PGnuKKWEWzzrIfbwSkuoOKaDHSFtv5AI7lSG+jfDHTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNoKYUC3+4PeB6mhclL6UCGS0yKzBhXUaIq+dbayvs6NraNaQRYIKkYV+Je11EEmHg0k5RYoi7w4SrXrf71faIVpkkwAl9nwfg6XyhUuX6HfUOwzPDO+QphooWIoV9/NF6hDcH1ZcNrgCgXQwZ9dzOY5EThtPeDOph7Dlc/Ufgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2St3c+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEBFC433C7;
	Tue,  6 Feb 2024 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234878;
	bh=PGnuKKWEWzzrIfbwSkuoOKaDHSFtv5AI7lSG+jfDHTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D2St3c+Wuqn/MF8B7OljPVU42v1jdF7nDOsoAI0odCSmO/k9ilOvxiGVUOmkvdiEH
	 yyd+rsO5pRPq9jKqc8irkeQhxbvzB1g6zT00R9kTabtWdEvmzqy3RNoA3NMXjW15lQ
	 bfxnBKobR18SLMe8Ky1pd7fc8LpELmZXaDdPlS6kZHmMVy5D3vybpFVCMkFhTAnFx+
	 z3EDuHC4mm/3D97wdg3PiA3vR1BMNeOQBI/l8zTtJUi/9Sb5oLcZ8+UCsggkiwb096
	 h1GC1PvjVLNJE2PiuAg8yv+JTeSLkqVKZECpaiGE7vALtjrsid2dH1JdWuieJh6miX
	 1RXpcn8mEfLiQ==
Date: Tue, 6 Feb 2024 07:54:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Chris Leech <cleech@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nilesh Javali <njavali@marvell.com>,
 Christoph Hellwig <hch@lst.de>, John Meneghini <jmeneghi@redhat.com>, Lee
 Duncan <lduncan@suse.com>, Mike Christie <michael.christie@oracle.com>,
 Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
Message-ID: <20240206075436.4d6b11f2@kernel.org>
In-Reply-To: <ZcE8JC0o9swkNzmr@rhel-developer-toolbox-latest>
References: <20240201233400.3394996-1-cleech@redhat.com>
	<5228a235-69f4-4a9b-8142-96d9b4a5a1c8@intel.com>
	<ZcE8JC0o9swkNzmr@rhel-developer-toolbox-latest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 11:51:00 -0800 Chris Leech wrote:
> > IIRC Jakub mentioned some time ago that he doesn't want to see
> > third-party userspace <-> kernel space communication in the networking
> > drivers, to me this looks exactly like that :z  
> 
> This isn't something anyone likes, but it's an interface that's been in
> the kernel and in use since 2009.  I'm trying to see if it can be fixed
> "enough" to keep existing users functioning.  If not, maybe the cnic
> interface and the stacking protocol drivers (bnx2i/bnx2fc) should be
> marked as broken.

Yeah, is this one of the "converged Ethernet" monstrosities from
the 2000s. All the companies which went deep into this stuff are
now defunct AFAIK, and we're left holding the bag.

Yay.

