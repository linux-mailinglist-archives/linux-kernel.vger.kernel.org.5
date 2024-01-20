Return-Path: <linux-kernel+bounces-31922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B0833666
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769EA2829F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CA41401B;
	Sat, 20 Jan 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="glBUkyZG"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5212E69
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705785639; cv=none; b=i04TuJzU4EP3QxvUQUzop1n78d0nbSFuGwKO3pzej90viGZDUUo6jolnqxv4Ux/yRmav3jp2KTStrmu2azosmRlMtZJDOTtqb3fESK3N57Nfk0HavliM2UtgAgPIrcKoYlKqlYnD7f5RnLuMvlzHEdxJHI2yebeMeJGAKvPM8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705785639; c=relaxed/simple;
	bh=ZGkailrca/i8oHMh0IRF8KnrjV+IcsO0DQlFP38qjSM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MY3jytDePh5Gt68vkgyrRbnG5/Ne2e6qAzZ9GmitHvsqjqSKc/7+4YrQ59KJFDnF5+qaxGgjEHu0zbzF81gSjGB+xOqrAUu3CH+UzfIEBtzJWwbv/UIlFmJvkgwCFjPX7ZuR5Dzk22R+k2oA9tm9NMQbQL8BuQu/SzzFx/l04DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=glBUkyZG; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aLyOhQr3iN/L4ULpUgDrbX9u1EDxEeONAWsqwCNe/IY=;
  b=glBUkyZGQwPfjO/e2MF/Bb9T7i7TeWW10fRFH98M70+pyvgRzxTRlojP
   wnwOetgYbFRlrH+MAtSIeEB4ShXqBfQQrW1zzifIMF4+uIZv5D+LXoZft
   yM6E94v35xubzr8nF/PHhnCsEalUtMNa4wfdxSQ/xd9tRrrdSCUJTThj5
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,208,1701126000"; 
   d="scan'208";a="77364056"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 22:20:27 +0100
Date: Sat, 20 Jan 2024 22:20:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
Subject: Re: [PATCH v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
In-Reply-To: <20240119062057.4026888-1-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 19 Jan 2024, Li Zhijian wrote:

> Adapt description, warning message and MODE=patch according to the latest
> Documentation/filesystems/sysfs.rst:
> > show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> > the value to be returned to user space.
>
> After this patch:
> When MODE=report,
>  $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=report
>  <...snip...>
>  drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
>  drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: please use sysfs_emit or sysfs_emit_at
>
> When MODE=patch,
>  $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=patch
>  <...snip...>
>  diff -u -p a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
>  --- a/drivers/hid/hid-picolcd_core.c
>  +++ b/drivers/hid/hid-picolcd_core.c
>  @@ -255,10 +255,12 @@ static ssize_t picolcd_operation_mode_sh
>   {
>          struct picolcd_data *data = dev_get_drvdata(dev);
>
>  -       if (data->status & PICOLCD_BOOTLOADER)
>  -               return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
>  -       else
>  -               return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
>  +       if (data->status & PICOLCD_BOOTLOADER) {
>  +               return sysfs_emit(buf, "[bootloader] lcd\n");
>  +       }
>  +       else {
>  +               return sysfs_emit(buf, "bootloader [lcd]\n");
>  +       }
>   }
>
>   static ssize_t picolcd_operation_mode_store(struct device *dev,
>  @@ -301,7 +303,7 @@ static ssize_t picolcd_operation_mode_de
>   {
>          struct picolcd_data *data = dev_get_drvdata(dev);
>
>  -       return snprintf(buf, PAGE_SIZE, "hello world\n");
>  +       return sysfs_emit(buf, "hello world\n");
>   }
>
>   static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2:
> - changed title from coccinelle: device_attr_show.cocci: update description and warning message
> - Fix MODE=patch
> - Extract patch from the patch set[1] so that maintainer can accept it separately.

Applied.

I subsequently simplified the patch case to contain the following:

-              snprintf(BUF, SZ, FORMAT
+              sysfs_emit(BUF, FORMAT
                               ,...);

This also works for the case where there are only three arguments.
It has the benefit that the change is recognized as a line replacement, so
no extra {} are added when the call is in an if branch.

julia



> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> index a28dc061653a..634514937e63 100644
> --- a/scripts/coccinelle/api/device_attr_show.cocci
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -1,10 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// From Documentation/filesystems/sysfs.rst:
> -///  show() must not use snprintf() when formatting the value to be
> -///  returned to user space. If you can guarantee that an overflow
> -///  will never happen you can use sprintf() otherwise you must use
> -///  scnprintf().
> +///  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> +///  the value to be returned to user space.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
> @@ -30,15 +28,21 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>
>  @rp depends on patch@
>  identifier show, dev, attr, buf;
> +expression BUF, SZ, FORMAT, STR;
>  @@
>
>  ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	<...
> +(
>  	return
> --		snprintf
> -+		scnprintf
> -			(...);
> +-		snprintf(BUF, SZ, FORMAT, STR);
> ++		sysfs_emit(BUF, FORMAT, STR);
> +|
> +	return
> +-		snprintf(BUF, SZ, STR);
> ++		sysfs_emit(BUF, STR);
> +)
>  	...>
>  }
>
> @@ -46,10 +50,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
>
>  @script: python depends on org@
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
> --
> 2.29.2
>
>

