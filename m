Return-Path: <linux-kernel+bounces-51297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C48488F1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE792852CD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEC1757A;
	Sat,  3 Feb 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0zT/dmAG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5DF17551
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995424; cv=none; b=f6qGY/J7xmm8JIslsMPX/9HTjeZsqZJVILbh3pFJwaKeV5HbnSmfvQBEkhWoeH2PrRpKUq5IEuVwWZxT3RJbC37LzCwKlDeGFQLC/U852OMW9lGbJ1kmNyLvYMq0AdFzjKqSgdKr8kODHonfl836ilGo1TJ+UzZJy5VP03dFpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995424; c=relaxed/simple;
	bh=2cUK20HpkF3Qs4l/910Mfk2HuHRlZed/HuN6ZaSpsas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqF12ip6xq6hAymncpBBW3cFr7mIFcgR96vv97EvIpW8RpMU9fy9WHYbNrkd0Es519P/sZd6BcqlABuX63LT1wcDC46P8M3SyvlpeloGmeFwd8qxwh1i+rS/t7k7Z4+S05Sv9YjBF+xE13dl6lgKDa/8UvrXWfNrTxFgHs3YQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0zT/dmAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0292C433C7;
	Sat,  3 Feb 2024 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706995424;
	bh=2cUK20HpkF3Qs4l/910Mfk2HuHRlZed/HuN6ZaSpsas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0zT/dmAGOhDbo3w43Gct1tLu57+LlgLX3XUWVqC6PWSzPvrxVSZHuEL2aVbj6HY7R
	 Gk2B6RlHxh9fIyJKccTMvL/ATtanY+uTuyVh4MHCMLcVAdrCAwNth3otAnQlgM7R/Z
	 odVM+yiI8gwrS2cguP889Ixo+vlsXtfRO1/D/uBQ=
Date: Sat, 3 Feb 2024 13:23:43 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: xen: struct bus_type cleanup
Message-ID: <2024020333-unwatched-provolone-dc3c@gregkh>
References: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>

On Sat, Feb 03, 2024 at 03:53:36PM -0300, Ricardo B. Marliere wrote:
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

