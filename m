Return-Path: <linux-kernel+bounces-89657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A719F86F3B8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 06:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D2C1F2228F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB6847E;
	Sun,  3 Mar 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUbyNXba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E11C2E;
	Sun,  3 Mar 2024 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443577; cv=none; b=PG3SivbG9KMZlUuPQ0BXtiVhnetxAlYMRe4cdlrpDXhBXsK6TH8CZJIICE7hspOsMzfAjGpK74YmCgCvjk/I62x/U5POhWjNqgnnZVGl1yeG6WCGnZIfmN+i+C+Vb2kOUY03OAjp4uKa0nQRcqgjyFSdQOhyFzAUeOEDX17CdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443577; c=relaxed/simple;
	bh=pDTqr75VrTenhrZ7T1mxLvCoeWHL+hc6thSbvXACcuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDJnwF7J39WE2xK+7XSFyEIkSpYjnZD8oBguYAFOEEhw5Yzn5XIp5fX5brv+VkaM0Rg5EDkm06HHIe7GATEyLqTQO9kdL4iQC+Ajd7EFgr16fWFsAqiZgy0gvHHophwGEswet9wmT/BrrJ466WuOKRm8rzvfvV5nnCNWCkQq6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUbyNXba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7FDC433F1;
	Sun,  3 Mar 2024 05:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443576;
	bh=pDTqr75VrTenhrZ7T1mxLvCoeWHL+hc6thSbvXACcuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUbyNXbaTyYF1KDMsPa4TbrSyBOX0xx/gnZUZi4SuDKF5r7E9EV97lYwRkpXYaF1L
	 pADr96LkXEmMKKNx88n/AD0Y3wKlqgUOOTsfka8xTD6G3wP4F8ru0YepbIC6OUfC41
	 eOhVxeo3NPCjU3K+6ioUBuakT34fPX0HZH/FzIv65Wo/dIbAfi484xB8/p7Jo+nYgR
	 pmOWKavyMJ9KNPhRCv3r+9gg03PoZcyKaG1SESzVkighvnzv+hiFJql10Fimy1ALMC
	 5+0C4jMZcLLtn6ko3i/3Ut9QwU1eGfhLe83RKDWEErP8O3U1H/2hwd9qPmv+l0y86g
	 ivSE9pe/955+Q==
Date: Sat, 2 Mar 2024 21:26:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 13/21] rxrpc: Use rxrpc_txbuf::kvec[0] instead
 of rxrpc_txbuf::wire
Message-ID: <20240302212615.310678df@kernel.org>
In-Reply-To: <20240301163807.385573-14-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
	<20240301163807.385573-14-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Mar 2024 16:37:45 +0000 David Howells wrote:
> Use rxrpc_txbuf::kvec[0] instead of rxrpc_txbuf::wire to gain access to the
> Rx protocol header.  In future, the wire header will be stored in a page
> frag, not in the rxrpc_txbuf struct making it possible to use
> MSG_SPLICE_PAGES when sending it.
> 
> Similarly, access the ack header as being immediately after the wire header
> when filling out an ACK packet.

net/rxrpc/output.c:263:28: warning: unused variable 'whdr' [-Wunused-variable]
  263 |         struct rxrpc_wire_header *whdr;
      |                                   ^~~~

