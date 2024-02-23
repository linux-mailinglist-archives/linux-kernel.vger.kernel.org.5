Return-Path: <linux-kernel+bounces-78205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D56861039
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508371F25A89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CAF633E9;
	Fri, 23 Feb 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="02XPD7lT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED691758D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687268; cv=none; b=CNA/if11Fn1RV3yy0YPs/d0LGTDMRzMiVG4SPdjtwwRc0JSl+/LY0WPVpo9QPykCzIzNaSiJI/eetxvmxegbdGRLHLn7KZGmD34h7kqaSViUikcI+/oXNonxNCJQGaL77FrHP1gIdJGOGKitChLhwvhAqNRNQIkBXJpOzyF7whY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687268; c=relaxed/simple;
	bh=SCw7DbOtRwkI5zg0APjb7jb8/0IT16RWzCP/jwP9gMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZUIu3a2tGPui8js6whmfsUF7ck3S8lnDVmWUPcAsskL7tuQIfQUAg57CN7ofyf8KtAH1lS+at7kVXdCbIClj48bofmbBbjwXXbetJVoILjl2WTRQ0bn1IfcDcL/fobiv0c8L8HzK5iRbFXusjEl2uiTAnnC4ktbpbfMiwfb8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=02XPD7lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D2DC433F1;
	Fri, 23 Feb 2024 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708687267;
	bh=SCw7DbOtRwkI5zg0APjb7jb8/0IT16RWzCP/jwP9gMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=02XPD7lTz0v4zkUv1rUuRaHJIFKVkZXZp54disUn6r794KZZ9iXiPMxSEeiwBy4wW
	 F2bKuE6gdKeDcF8Q32DTtXAKB1p7rdS08PUWa1fdMahYwMfctSxU+s3Sj1e5PQmZIM
	 572i37G1CEUfP1g6eN3Vq1BI4KFkcJAwDeE2VUAk=
Date: Fri, 23 Feb 2024 12:21:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
	pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
	michal.simek@amd.com, abhijit.gangurde@amd.com,
	srivatsa@csail.mit.edu
Subject: Re: [PATCH v8 2/2] add wrapper msi allocation API and export msi
 functions
Message-ID: <2024022340-reversion-detonator-f229@gregkh>
References: <20240223092447.65564-1-nipun.gupta@amd.com>
 <20240223092447.65564-2-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223092447.65564-2-nipun.gupta@amd.com>

On Fri, Feb 23, 2024 at 02:54:47PM +0530, Nipun Gupta wrote:
> MSI functions can be for allocation and free can be directly
> used by the device drivers without any wrapper provided by
> bus drivers. So export these MSI functions.
> 
> Also, add a wrapper API to allocate MSIs providing only the
> number of IRQ's rather than range for simpler driver usage.

Why is this patch 2/2?  Don't add wrappers that no one uses, otherwise
we will just delete them again :(

thanks,

greg k-h

