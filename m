Return-Path: <linux-kernel+bounces-59230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F289C84F37D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D0E1F21478
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E122075;
	Fri,  9 Feb 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vz53mCgE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0620332;
	Fri,  9 Feb 2024 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474741; cv=none; b=IHDrulWTsK+JTdqf6qSp4bUdDaHjkX0JKxgzV6snEkFhjKzeV+6n8h8rCDq85r9UYQIzYTn0LnVm6f5cFaRkh4ACLmUCSLbRvPOqD9/X3Tbb/r6C6xnDVN8Q0VGHBfv4+cJ9uIAnTl5DVIsPmffOyUKR8LgKdfQWkyIRovJDDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474741; c=relaxed/simple;
	bh=m7qJHeaqUpAXfJ3AHCc2vRIqJiMuEGLJftOsiKwbc4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRE3S/uo7izcmHS++aR0n5MCnYiHsGBeUm06MP2UIRB35C2qUyVe3KtkFkK9JG6rb8Y4/jrW/OvFkPMbnKQy5e22JaGR7q8oIdfIsyVOKMsCusbgMhM/DrzSLbxzKoRZjN7wA57pMN9UWV8YOpke+KTRr28cLZOUomXBA+dS438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vz53mCgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033D3C433F1;
	Fri,  9 Feb 2024 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474740;
	bh=m7qJHeaqUpAXfJ3AHCc2vRIqJiMuEGLJftOsiKwbc4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz53mCgE5/4961S80SSjiTWW56NKzIIaa7DS8GiI4dZhGTbuo8ILpMoRr7XpT39lg
	 eajHfRKG81OesuvhLSO2hc5g0uy8qkUgpGw9+fbBr+EGkvoBc4hU5FH5Opm0oPC5Eu
	 BmMqXZuncrKAbrdwINNy8PxboH7lBmH/D+P2oUds=
Date: Fri, 9 Feb 2024 10:32:17 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Christian Brauner <brauner@kernel.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: intc: make intc_subsys const
Message-ID: <2024020913-washbowl-old-a71d@gregkh>
References: <20240208-bus_cleanup-sh2-v1-1-729277400893@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-bus_cleanup-sh2-v1-1-729277400893@marliere.net>

On Thu, Feb 08, 2024 at 04:56:52PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the make intc_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

