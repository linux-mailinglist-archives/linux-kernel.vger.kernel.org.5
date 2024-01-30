Return-Path: <linux-kernel+bounces-44958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3884296D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1592293EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B386AF1;
	Tue, 30 Jan 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmV1osKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F62128378;
	Tue, 30 Jan 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632532; cv=none; b=EPs+nGYY1Qqc67HQlv6NExB+xcaByHQkuIM6ERTH52SoiAVFFEFSYdOWNunqrjk7KNR2iLZyaqFjsfQvEEFW4cLIHPuTfrBxPAX7XJitXfDAqtzZp1IUw/dSaaXtxer9Knyf9CT5oJv8hTHo1c7ZLMKfKtNZ153ATXu6V128Krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632532; c=relaxed/simple;
	bh=VzF6pgl3cBvoSdippxVco5i9J4H7GF91CCbu75befoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csQwYw2S9a9RV6fyfbXasXTv5W40V4nIkGxoFnOZtdxKDOGiWLaK1524HROLdTLzCUea6+oFM490thr9OlOW11NZ8zBbUgcRY4sRR0NZ7KvGa4n6YFeAHIyWkRsVyG4u3AIv8NoXcFpSM2pBAT41IbeTg+wWwg2NlRQUL3joG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmV1osKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18707C433C7;
	Tue, 30 Jan 2024 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632532;
	bh=VzF6pgl3cBvoSdippxVco5i9J4H7GF91CCbu75befoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmV1osKlts6fNfbt2Gqcb87x/cxVsBDXDLihZNSueL4wrvx6U10lWgZaJDAe3Z6VZ
	 xFeX6auKGBkN4J2tRse+GFUfLGhaO84V4KpPSR2bUKEuN3wRWF/f6qMgLrXJc2WL7D
	 OAGX7o6Jzj9GNAm1/L2xMT5w6Ce7EuQWwjdUv7FA=
Date: Tue, 30 Jan 2024 06:04:17 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: arnd@arndb.de, fancer.lancer@gmail.com, lkp@intel.com,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: Convert data structures to LE
 explicitly
Message-ID: <2024013039-asleep-rally-39c0@gregkh>
References: <20240130040632.3039911-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130040632.3039911-1-dawei.li@shingroup.cn>

On Tue, Jan 30, 2024 at 12:06:32PM +0800, Dawei Li wrote:
> For data structures needs cpu_to_le* conversion, its prototype needs to
> be declared with __le* explicitly.
> 
> Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index d807d08e2614..327afb866b21 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -129,7 +129,7 @@ struct idt_smb_seq {
>  struct idt_eeprom_seq {
>  	u8 cmd;
>  	u8 eeaddr;
> -	u16 memaddr;
> +	__le16 memaddr;
>  	u8 data;
>  } __packed;
>  
> @@ -141,8 +141,8 @@ struct idt_eeprom_seq {
>   */
>  struct idt_csr_seq {
>  	u8 cmd;
> -	u16 csraddr;
> -	u32 data;
> +	__le16 csraddr;
> +	__le32 data;
>  } __packed;
>  
>  /*

Declaring them this way is nice, but this doesn't actually "fix"
anything at all as no code is actually changed.

So how is ths a bugfix?  How does this patch do anything?

confused,

greg k-h

