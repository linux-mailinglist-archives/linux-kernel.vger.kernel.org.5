Return-Path: <linux-kernel+bounces-125470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5539892687
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E56283A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E713D252;
	Fri, 29 Mar 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdOZwwPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF513AA38;
	Fri, 29 Mar 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749546; cv=none; b=pENnmQjVRahfScdLLETphQVIho7PJDX43gfdFJ/7Qwih3/hDrgLdT0Z9ihMncI6iS4BJk1qp4Z1zWuYrNnF8ynvepu5p1uuUYKR9jhP1FRROfilqci3dhA9ff0ITHsaXMm0y3VaE6fYTx5rWPVlvWt6ZEQ+e64oEqTcHcPL8Rkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749546; c=relaxed/simple;
	bh=9NJceUn3bR+/SFWEcn+7DCazzJ7XbN4byL3bzmGxgUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaTiLGhakmrEp6vtDCTOpgunbbtgvLxraFtADPAsu3XLNSgig5ZNENzoPh+Z7dqVpjJcnhwWo0qeRbjNmzytnd/m024NwA/a+C1Gw7YC0WeVbU/G1cgkz8qTkCLxoTozmNgtyFwxqR0m0H9xjeidOxlGKBv2BiC5dvV7BLhOXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdOZwwPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9F0C433F1;
	Fri, 29 Mar 2024 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749546;
	bh=9NJceUn3bR+/SFWEcn+7DCazzJ7XbN4byL3bzmGxgUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PdOZwwPBQZkF3Fbxs7p8SnUH6Y/YPF6/Ef7JkVwtarfNDgmaSAULVdIm+4keF0fRc
	 MkJuWeQ1Qxq6oaTdGWmf2wL/Bh4S7FnK/1bmQVbQhqIXA5b3SD34OnOIkoHDMFlTuM
	 N8zi0XNBbxPBHeIK/mawmLFGFLr1EJvq0JwFlY6qz1b1/IFWba+SlhcFtXrH/orscA
	 PXPQ6rXdKOZiqQrgcrfnKXq2P+AYDjMsiBNESyhKbAfbIw7pNuiGoKTeJOPE8fAhJ7
	 riyM6HNtjzT4boCWKJoRNHNRp24R0nTlLi7GQczMY4I1gJWfG1pQHWGtbyHN+FnDDS
	 UBMz/LqRLMs/g==
Date: Fri, 29 Mar 2024 14:59:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/3] net: ethernet: ti: am65-cpsw: Enable RX
 HW timestamp only for PTP packets
Message-ID: <20240329145904.0b7cb60f@kernel.org>
In-Reply-To: <20240327054234.1906957-2-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
	<20240327054234.1906957-2-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 11:12:33 +0530 Chintan Vankar wrote:
> To prevent port lock up, disable TSTAMP_EN bit in CPTS_CONTROL
> register. The workaround for timestamping received packets is to
> utilize the CPTS Event FIFO that records timestamps corresponding to
> certain events, with one such event being the reception of an
> Ethernet packet with the EtherType field set to Precision Time
> Protocol (PTP).

You mention EtherType here but the drive retains L4 support,
which is somewhat confusing. Perhaps mention L4 / UDP ports
here, too.

