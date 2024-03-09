Return-Path: <linux-kernel+bounces-97794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67712876F7A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BF61C20D24
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FCB37147;
	Sat,  9 Mar 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18L9XkYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B836249F5;
	Sat,  9 Mar 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709968497; cv=none; b=npgD8Uln8+vTVpHyFfvWDkqHV4nPbAygrbANCkH4OiFT1HTX75sJq8d8jazsV5mZEVXnxsXZ1QP3vTU1RFTWrQhndkhdU9xTru+7J1jVHMZhPA6VIbZz1/rLe1vWFsnsQHc3UryHlFUqbw1Tn3SefnMs8k2cM4D2RgokZYlw7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709968497; c=relaxed/simple;
	bh=PwI5R2vM7donkPrkZefO+Qimv4iRpNjz1gHWr3VgWhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqUTPvIyJabPf2DqwXxfFd9Aw3Xbvqi1jKCzfi7lgy07nSAjiAVBJKa8N8x+bkObNq58jkUdu7/IvmyBtADqMOQVqaAHJL0bWcz6jtI/sqUEoq6zxI7Zzp+Y5n0/mDeI1EPc4oEG0h2YOt2fw68lxVpZGa8n4lRQWGWBLOk2qNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18L9XkYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8C3C433F1;
	Sat,  9 Mar 2024 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709968496;
	bh=PwI5R2vM7donkPrkZefO+Qimv4iRpNjz1gHWr3VgWhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=18L9XkYHVg4UtJU+bFoBNsnhmzRc+ekCdd/kKZOX+AGf6ijVyHRGsDd7RBmADRpyC
	 csjAEVT7HR0v52eCjSU29R2/aLBLDKwK8RywKgDQ/V12ZFIenLWKmhIkg/YJg+XD6y
	 a1MWg7j2sn+Z6KL8rL3KfORYCF3LNPkvqevj1VtQ=
Date: Sat, 9 Mar 2024 07:14:48 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Dingyan Li <18500469033@163.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Use EHCI control transfer pid macros instead of
 constant values.
Message-ID: <2024030910-hurled-ibuprofen-1b52@gregkh>
References: <37bdd932-07a4-4514-a5cc-b70d48c962a6@rowland.harvard.edu>
 <20240309033709.14604-1-18500469033@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309033709.14604-1-18500469033@163.com>

On Sat, Mar 09, 2024 at 11:37:09AM +0800, Dingyan Li wrote:
> Macros with good names offer better readability. Besides, also move
> the definition to ehci.h.
> 
> Signed-off-by: Dingyan Li <18500469033@163.com>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> V1 -> V2: Replacement in more places where Alan pointed out.
> 

This should be v3, as you have added Alan's reviewed-by, and added the
proper versioning information.  Please resend it as such as our tools
can't dig it out from the end of the thread like this :(

thanks,

greg k-h

