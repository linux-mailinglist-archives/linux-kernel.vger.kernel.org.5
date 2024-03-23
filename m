Return-Path: <linux-kernel+bounces-112415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C633A88798C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FF428265B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1D4D9ED;
	Sat, 23 Mar 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JVXhiSvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D547A6F;
	Sat, 23 Mar 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711212645; cv=none; b=n2qdVrnLknZ/muoIxr+x/7SExLVVVzJ1rYSkCCOdojm7kG8uBX/wwdAywJCWSR4O4pEkHvgvEVZAxX8WWlsSTvCHrqCMcuLdYhm6CJk9C/FAOxcBnwdkjd0Sbw6bajjvVvDwdCp8d2jGW8XQ1UpywcFwHhOc2z4Eq+9UiGrMnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711212645; c=relaxed/simple;
	bh=SnyQepQR9oeCnlhqBe2g7z3psoo2RmxgxTXormlnxsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr67sgq/e2oFHf5wxhsYvYRbsFTG7Ry0wQ2juS3G+zNt6gR1iiFtHNnFcH3s+bOpQIKf/PZupjUjaZlUwFxUiN08/KEiPZZtEBmF7cGFXziKbaEbZvglgvISOGTQmIguKkwEeD3ABWPpXmH1es0dbtITmDVUgDCOlvO4+7DSM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JVXhiSvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A2C433C7;
	Sat, 23 Mar 2024 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711212644;
	bh=SnyQepQR9oeCnlhqBe2g7z3psoo2RmxgxTXormlnxsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVXhiSvP3kl0/4KeH4t8mmHVD7HB0XV1WBgSPFcSRJx15+swNaxFbNU9Fvw+/jMyW
	 fqC5D//+HDAlBY3IWsxVCmn/76Ail2OH5zJQ5vL8h4YVWXknFf61Z9h5XNd9XH7d8N
	 gy3aY0YHGhWZCI3+c2B+YJiqtl5ySUUUsYLNKi4g=
Date: Sat, 23 Mar 2024 17:50:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] module: don't ignore sysfs_create_link() failures
Message-ID: <2024032349-corporate-detached-0dc9@gregkh>
References: <20240322173930.947963-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322173930.947963-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 06:39:11PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sysfs_create_link() return code is marked as __must_check, but the
> module_add_driver() function tries hard to not care, by assigning the
> return code to a variable. When building with 'make W=1', gcc still
> warns because this variable is only assigned but not used:
> 
> drivers/base/module.c: In function 'module_add_driver':
> drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
> 
> Rework the code to properly unwind and return the error code to the
> caller. My reading of the original code was that it tries to
> not fail when the links already exist, so keep ignoring -EEXIST
> errors.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
> See-also: 4a7fb6363f2d ("add __must_check to device management code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rework to actually handle the error. I have not tested the
>     error handling beyond build testing, so please review carefully.
> ---
>  drivers/base/base.h   |  2 +-
>  drivers/base/bus.c    |  7 ++++++-
>  drivers/base/module.c | 42 +++++++++++++++++++++++++++++++-----------
>  3 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 0738ccad08b2..0e04bfe02943 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -192,7 +192,7 @@ extern struct kset *devices_kset;
>  void devices_kset_move_last(struct device *dev);
>  
>  #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
> -void module_add_driver(struct module *mod, struct device_driver *drv);
> +int module_add_driver(struct module *mod, struct device_driver *drv);
>  void module_remove_driver(struct device_driver *drv);
>  #else
>  static inline void module_add_driver(struct module *mod,
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index daee55c9b2d9..7ef75b60d331 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -674,7 +674,12 @@ int bus_add_driver(struct device_driver *drv)
>  		if (error)
>  			goto out_del_list;
>  	}
> -	module_add_driver(drv->owner, drv);
> +	error = module_add_driver(drv->owner, drv);
> +	if (error) {
> +		printk(KERN_ERR "%s: failed to create module links for %s\n",
> +			__func__, drv->name);
> +		goto out_del_list;

Don't we need to walk back the driver_attach() call here if this fails?

> +	}
>  
>  	error = driver_create_file(drv, &driver_attr_uevent);
>  	if (error) {
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 46ad4d636731..61282eaed670 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -30,14 +30,14 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>  	mutex_unlock(&drivers_dir_mutex);
>  }
>  
> -void module_add_driver(struct module *mod, struct device_driver *drv)
> +int module_add_driver(struct module *mod, struct device_driver *drv)
>  {
>  	char *driver_name;
> -	int no_warn;
> +	int ret;
>  	struct module_kobject *mk = NULL;
>  
>  	if (!drv)
> -		return;
> +		return 0;
>  
>  	if (mod)
>  		mk = &mod->mkobj;
> @@ -56,17 +56,37 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
>  	}
>  
>  	if (!mk)
> -		return;
> +		return 0;
> +
> +	ret = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
> +	if (ret && ret != -EEXIST)

Why would EEXIST happen here?  How can this be called twice?

> +		return ret;
>  
> -	/* Don't check return codes; these calls are idempotent */
> -	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
>  	driver_name = make_driver_name(drv);
> -	if (driver_name) {
> -		module_create_drivers_dir(mk);
> -		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
> -					    driver_name);
> -		kfree(driver_name);
> +	if (!driver_name) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	module_create_drivers_dir(mk);
> +	if (!mk->drivers_dir) {
> +		ret = -EINVAL;
> +		goto out;
>  	}
> +
> +	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
> +	if (ret && ret != -EEXIST)
> +		goto out;

Same EEXIST question here.

thanks,

greg k-h

