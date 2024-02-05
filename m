Return-Path: <linux-kernel+bounces-52629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1251849AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999102839EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C81CA9B;
	Mon,  5 Feb 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDom9yJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57081CA88;
	Mon,  5 Feb 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137082; cv=none; b=aV9cp4siAcFA8H00+pCbKsJxJZWEij0Y3eKg2filf39rHoUFGDBvGPn+vkXGWr6QOuD6xTdR9varjPp60TwcVdlKpb6irxxZRlDXFsvKbrxfGWc0k0ukz69YIdnWl0azXsXmzrJZK8fKwDCX2/VT/DLy5W9Y7xbnfa5D9T9M2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137082; c=relaxed/simple;
	bh=VGPtN2KbBfIUQbupdreTH/1SJvHEpCpDxktYTeE50vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG6xXpHn474BHGmwQckq9D9eUB0lr9KSMCjhWzhcjgKSHyfcTwS0r5vMt3SQ5YBSVUn46eoRaH3Vkxzfvf12qCJOaTUWN84a4fVQk86cyChKQmKFQwtwLR4CHnG06UYjwdzNSf/MV06KsC5K3/jSymOTRr97ZT4iFrIUVpIUZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDom9yJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B60C43390;
	Mon,  5 Feb 2024 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707137082;
	bh=VGPtN2KbBfIUQbupdreTH/1SJvHEpCpDxktYTeE50vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDom9yJO3ssMcuq9BK3bxlzg82QVBdSMCYnsbA12BDLh2B+NBxk881JGi2IpxeZaa
	 YVsUdciplI24NGtO3IcDQc4vd9GvC2Q2lD9BpYlm+doXk8IAbhRks0GNQsI2RDp66p
	 rP4sl4nluYKLzIbqHdOc7qbwr29G0/w3/CIob1Kmcgu8xydd1Lxr/rixifpjEFIQBy
	 4/H5ShwqyJablHFX6HSqPcnBDpKTdipxtVztGFWEtqcdyPDURMg11Bcv8UOw7WrNrs
	 nI//ZIneF25RhGx37ZccxCXo9riX9klU4nUF61TMmSrvWZ5kCgyON91mUA+z+Z30Qs
	 iPMZ50I454jmw==
Date: Mon, 5 Feb 2024 13:44:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the vfs-brauner tree
Message-ID: <20240205-krapfen-maulwurf-e7ebebdf9583@brauner>
References: <20240205161515.598ae7f6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205161515.598ae7f6@canb.auug.org.au>

On Mon, Feb 05, 2024 at 04:15:15PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs-brauner tree, today's linux-next build (powerpc
> pseries_le_defconfig) failed like this:

Bah, sorry about this. Should be fixed now!

