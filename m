Return-Path: <linux-kernel+bounces-51712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99B848E83
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538B21C215CD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE622EF4;
	Sun,  4 Feb 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XRokyKIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619E22EE3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057512; cv=none; b=R1nTEdH67OSKW1lc5UPfOFXppTwDu2NNaCqZpcVt7bZaM//+YapE5ujv0ww7NBOWaOke7VAAI2M2Pcqxwb/+kGsETSNY0hVwOso7Dh4LBzkESBnDN/MM774asjPL/A6ICOKiv750D6KwaiWs5awE3WtK5FtYQPfkdr+eM6F3NxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057512; c=relaxed/simple;
	bh=nt/QMLw6lg1n1+RHbp6/VU6M7m38l4egTNOdCoMZaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpB+KUp3E+Cy9pwM3F1T8VbhgIytN1wrUaJPAvhQrFPAA/LdhbitFohb1hYZpj4YEtGbGUsvwSrEHR1orqBuMtgr8JvSVYS0zP94TBceXNf8Sz8XYpz9naJjH+nnjFnwnGxP/Ex0ZB45V+9HeY4Nu+fb826Bky2xNWSkZQYRb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XRokyKIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1925AC433C7;
	Sun,  4 Feb 2024 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707057512;
	bh=nt/QMLw6lg1n1+RHbp6/VU6M7m38l4egTNOdCoMZaiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRokyKIJHDKNPPt+r8mNyoSlH/xAc/vrIvluI4CiVkz9WAwG1G6amr7yogFjuWBi8
	 9sIP571fk9+ecybV7YDSlZ7D5qutbEaL64pyThdUv1GKamQZ4lUkfBv1V4DZnJnmg1
	 +HXCX9CWd9/SNU8Vu8ysT7DNDHV3tyPg5fgi5He0=
Date: Sun, 4 Feb 2024 06:38:31 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] powerpc: struct bus_type cleanup
Message-ID: <2024020426-abrasion-boozy-78d4@gregkh>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>

On Sun, Feb 04, 2024 at 11:21:54AM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

