Return-Path: <linux-kernel+bounces-142172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A68A2870
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC75B22522
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683454CE0F;
	Fri, 12 Apr 2024 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqYRwcMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2344CDEC;
	Fri, 12 Apr 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907931; cv=none; b=LLUJbG/j5R9fnjHv9bBqYpLE8aYX9hA9b/QxRAaXujUBtMfhYOV4qpT/RZiwtNxSFU1OHqkRYwLeElK+JFVHm+zVH54o3OqoZk8ffNKh7UMTyDdwZWGN0HSR0ArhgkOuL3FuSvSZmI85N5XyHJbjQRoOvZh/1C0fdaBGjHJRbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907931; c=relaxed/simple;
	bh=O48522UDx5+yp77SGAqqDH7H2dnzmPLlJYJEYS3z8ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMMrac9ggaJBI9jBngmGedlcUECrvar3RBZfFnstVtJi7YoQbgq0Tk76t/mYulyZXoksQyZCr4crTx+GpdEERaaSVkHgvL1tF1vOjgOjAdAuyqXD5CW25yovgCpcftsBh0MoVC0FN5MSbbLLz23RbwS8Pd4R2SMTTjg0ewouLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqYRwcMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE0DC113CC;
	Fri, 12 Apr 2024 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712907931;
	bh=O48522UDx5+yp77SGAqqDH7H2dnzmPLlJYJEYS3z8ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqYRwcMzFGSj5E3dQSV8A1RVXCPxjC9XQ5cTkwt5Wy++whu83KgEmq/V36BXjs0Ry
	 XXDMqXTrgNmNGxN8YP7S6mw3flN5paXIgiicAzv1a9WRY7HHt8qI26CEU0SsFxL2AD
	 nn819PuhHpIW7eYpT/jqqU3wljEUtjUuc58tLDMU=
Date: Fri, 12 Apr 2024 09:45:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Mihai Carabas <mihai.carabas@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic-pci: register attributes via pci_driver
Message-ID: <2024041228-maximum-aware-f078@gregkh>
References: <20240411-pvpanic-pci-dev-groups-v1-1-db8cb69f1b09@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411-pvpanic-pci-dev-groups-v1-1-db8cb69f1b09@weissschuh.net>

On Thu, Apr 11, 2024 at 11:33:51PM +0200, Thomas Weiﬂschuh wrote:
> In __pci_register_driver(), the pci core overwrites the dev_groups field of
> the embedded struct device_driver with the dev_groups from the outer
> struct pci_driver unconditionally.
> 
> Set dev_groups in the pci_driver to make sure it is used.
> 
> This was broken since the introduction of pvpanic-pci.
> 
> Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Greg,
> 
> does it make sense to duplicate fields between struct pci_driver and
> struct device_driver?
> The fields "name", "groups" and "dev_groups" are duplicated.
> 
> pci_driver::dev_groups was introduced in
> commit ded13b9cfd59 ("PCI: Add support for dev_groups to struct pci_driver")
> because "this helps converting PCI drivers sysfs attributes to static"
> 
> I don't understand the reasoning. The embedded device_driver shares the
> same storage lifetime and the fields have the exact same type.

It's "simpler" to have the fields be in the pci_driver structure as then
you don't need to do the crazy:
	.driver = {
		.field = FOO,
	},

type of declaration just for simplicity.

And as the number overall of these structures is very very small,
duplication on the driver level is not really an issue.

Duplication on a device level is another story, there should not be any
duplication at all if possible there, as that is where it really
matters.

> ---
>  drivers/misc/pvpanic/pvpanic-pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 9ad20e82785b..b21598a18f6d 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -44,8 +44,6 @@ static struct pci_driver pvpanic_pci_driver = {
>  	.name =         "pvpanic-pci",
>  	.id_table =     pvpanic_pci_id_tbl,
>  	.probe =        pvpanic_pci_probe,
> -	.driver = {
> -		.dev_groups = pvpanic_dev_groups,
> -	},
> +	.dev_groups =   pvpanic_dev_groups,

Maybe we should throw a trace in the pci core if we find that dev_groups
is set to something before we override it to catch this type of mistake
in the future?

Although, given that this never worked in the first place, it seems odd
that the original developer never noticed it, so perhaps that's not
really an issue here.

Oh wait, it originally did, but the pci change caused it to break,
nevermind, it is relevent, thanks.

thanks,

greg k-h

