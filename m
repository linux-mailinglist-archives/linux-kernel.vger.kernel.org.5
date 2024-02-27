Return-Path: <linux-kernel+bounces-82993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEACE868CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43332833BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC7137C26;
	Tue, 27 Feb 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyFtZ/c4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DF136991
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027623; cv=none; b=TgvkouZLeDXqjpQr0Hq2OVqipLYrGFO6rgV5zxPNURHtj/eb00oOvJrong14MXxxZ5ciBkP2NeE1MItgtp5u/WNx8MyABeJENODw6ZuF71moiQ5l1zcX/uVvopW7LJtGSpnkA+zVOu1DZD2CfNU65W+u1E2AcN1C9k4zJ2sPrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027623; c=relaxed/simple;
	bh=plLoL4DD0A3QHlueOZrtS4jcTTEZWoft2yMb6MuRcG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b++mrZ1HzYmLTeZxFH5MAy+s2UwElqSE2lLX3Mie0XiKagPjoHuZ+5ay+EJWl3jBn/rLhzkUXqlAsnrSCAk6mTJsG8cE9Z78SxA8Cq2Yue8EIgGZO304qsEeZN1B5nlrVFN4zv34/iznLMP1vopa7qk00IFZgYaSOYbL33aOvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyFtZ/c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71499C433C7;
	Tue, 27 Feb 2024 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709027622;
	bh=plLoL4DD0A3QHlueOZrtS4jcTTEZWoft2yMb6MuRcG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eyFtZ/c43QHHcti+MXlW1VXNf9SyXfR2Sl1dERwQLydHkKO4JuL+2MsKvhhdC+g8r
	 q/YRnSdsexwVkZP5Tr6tu/Hsdj5H6O5vzlhPEqGqg72QlqbJaXSFMrTVgvh4gxaCs7
	 O75N6QNfxqFCy25mZArjUbW3JTCyISoYKc/GdHU1vm4pu6VKZz5YYJNPAIkWDP8ou7
	 4WWu1ZNbvJBMrE95XBsc90CZ8wYzyjTx4TM9ZxSYWMv1hdSPXaZHCoL8jikBLXEGLY
	 vegJ6tzZ0uBNkP7yMT0Q6KtKBUflFJ8Glg+1mzEIUSAjywJL5z6xvVNoRMlzbG/UW0
	 6SbbN0hRP2aDQ==
Date: Tue, 27 Feb 2024 10:53:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
In-Reply-To: <2024022750-treble-wish-b009@gregkh>
Message-ID: <nycvar.YFH.7.76.2402271051480.21798@cbobk.fhfr.pm>
References: <2024022257-CVE-2023-52451-7bdb@gregkh> <Zdylmz28rZ-mCeiN@tiehlicka> <2024022639-wronged-grafted-6777@gregkh> <ZdytVTOgfvKBBvtn@tiehlicka> <2024022652-defective-fretful-3d13@gregkh> <Zdy-KbmSt0egNV3c@tiehlicka>
 <2024022750-treble-wish-b009@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Feb 2024, Greg Kroah-Hartman wrote:

> Ok, I traced this call back, and here is the callpath, starting with a
> write to the the 'dlpar' sysfs file (conviently NOT documented in
> Documentation/ABI, and it looks like it violates the "one value per
> file" rule...)
> 	dlpar_store()
> 	handle_dlpar_errorlog()
> 	dlpar_memory()
> 	dlpar_memory_remove_by_index()
> 
> Yes, the kernel by default sets 'dlpar' to 0644, BUT that means that
> root in a container can cause this use-after-free to happen, or if the
> permissions are changed by userspace, or if you are in "lockdown mode",
> or if you want to attempt the crazy "confidential computing" model, or
> if you have a system which root is possible for some things by normal
> users (there are lots of different security models out there...)

Whatever the security threat model, whoever can offline memory by writing 
to this file can kill the machine already. So there is no *additional*
security issue fixed by this that'd justify a CVE.

-- 
Jiri Kosina
SUSE Labs


