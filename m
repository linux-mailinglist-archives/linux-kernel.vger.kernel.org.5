Return-Path: <linux-kernel+bounces-64023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E41D853913
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EB31C236F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013960BB0;
	Tue, 13 Feb 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixVwc+ww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23F60B90;
	Tue, 13 Feb 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846877; cv=none; b=Fsf+vBKtaFUwq5ADiZDNqonEIu30teRuhKrgSiqANHi5offjZGWwcNlJahKCEZtoc6qJqt0C9jjpofjOrdCFI7UzOi5Hng5ZJVf4yjrv8RX+1j05nPx044/NslLyA2+HBop5mUS4pZIfs8GNtechyiDL2qJptTTL7qeygABojGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846877; c=relaxed/simple;
	bh=TyYR1wFHM9t1f7ZKSarVpyG8GlNWTfY2NT0WiOxCXX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE0MxrKQYMyvzCS0BZO8hUPZz+IdaQKRlVZMJbcj7Lpy3WOirekZW4lgv236kMTf240VQTKChB6sLTB9MVBTsKfyBu68PPC8vJbY8gaGQBht6+eM9a/KDIKMqLqJaLNWKZW22ISbxJCt8RQazvCj9gV0p4f3nUBGMo9sG6WRtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixVwc+ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0F7C433C7;
	Tue, 13 Feb 2024 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846877;
	bh=TyYR1wFHM9t1f7ZKSarVpyG8GlNWTfY2NT0WiOxCXX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixVwc+wwH2L0A+4AzVwfY9x2y3PVLZQtQvi1tqyA7VYSRzOnB6b9tH6lSD3RP1qNC
	 4l6rBoD0iNfVxLT2DrCNr/RA/OQX91Fq610ZGzI4tLc2CmWU+w2oXAbJxZXxmcf2eP
	 yeL3hP5FJ5YK9trD4Gga63SFW6KptUuKhWKaWZ4s=
Date: Tue, 13 Feb 2024 18:28:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tc: make tc_bus_type const
Message-ID: <2024021322-proofs-arrange-578f@gregkh>
References: <20240213-bus_cleanup-tc-v1-1-5ed32393a73a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-tc-v1-1-5ed32393a73a@marliere.net>

On Tue, Feb 13, 2024 at 11:45:25AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tc_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

