Return-Path: <linux-kernel+bounces-163539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0C8B6CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E735628452B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E71524D4;
	Tue, 30 Apr 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TlYh8MCE"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B64E1C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465668; cv=none; b=BdRWHQ4XhNapBt+kStS8cm50YGnrz0nIe3J9NiNma8D6OL0rWUrnK9yom+8zcjyAOlUfE7pkYSnBCWjDogd7pJpbzwQ130DmknGKrrfAxEzfBjyK7QkVyTJiyX+7eEb55XeLy3a3LHYaPR89EtRuGBZfltoCidpkocB1j1dwbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465668; c=relaxed/simple;
	bh=dFVSlKYakpFaxMQvaB97JEOvn2CtzUpcqfagv68ZZXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX7edvLGd5zGRRev/C6AMd/PHvV7Og6mPrgyuvQzIC8B2Z36S3kzhRk/OONbOww71DqIUmXRg7DUBMfuJ9F/L0QFrvzSsb+pzd3xsOpFPg9qPKD1PoSclx1YQCz5+N/uDClGLAQ+TJ68DVLchYpWeVnqWR4R92Z7lb/bNaczlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=TlYh8MCE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1173361f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714465664; x=1715070464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtN6I/MrZsMh+QWZjvEHDZGUZNYY+VAe2iTynwNvttw=;
        b=TlYh8MCEpqe530m/V/WD5MrLnfHrTmzk5FGp1ECcDgI6yc/xzMmORB6bRzmxIfTjoA
         8Xt/c78Fk3bvzagpm47ofQ91Hj+W4eNvSEye5vDeqQy7jkqiudMwAdA8B9MWzC1+yatM
         7jdC0muCFNe7YK8OaGmIYwMkX4C0mO0S54M3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714465664; x=1715070464;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtN6I/MrZsMh+QWZjvEHDZGUZNYY+VAe2iTynwNvttw=;
        b=bSPsOAfOVI+KWaxpVatvQRwPDYcgIERYiHxKRXPaUqZsr8y7juskd2b9mnbSsffrdH
         UmlmyfpueGx4L4kO2dku7xW9odEAV+mZuijk7goUduqI9nah4eqgqVe7vmHVrwwms3tJ
         uyrxtQCsdhEdHuOTq9l2+l6cnErsYbXM5Vcd89WNUT4opUgf+2XJEeh1eMQQ/ZXVGEe0
         rMRpzkrsjBz7xD10Ivk11Mdf964hTP5qbaVl1P026M3A/iCbjCyHkKv8QtaiAfNh2/rv
         7mT+rYMyzO4X1iekM0ROirkM8mLC02CmLUcLWnaA+dGhv4BBmIvVU90mumukEKTW66bp
         L8jg==
X-Forwarded-Encrypted: i=1; AJvYcCWx2kiMiDcBPHPiQ3o6CX4oftIZ5yKwt+d6PZpuZK688VHNV6Qb43nHdse5rgHrToN/1KtOnl7wbIxB9OiwpvSl8BWARHvp7ExgXGdJ
X-Gm-Message-State: AOJu0YzDQknrCbXzOyZyLevwmO4hTHfQYmVPzy0o5r5r1FGSTFvGjWd6
	IQxRVl3EU+GbMnM1TEUFjWwLU4Q3AN9eeRJAL1nV203QGYlHMzWKG8viFbEW9eI=
X-Google-Smtp-Source: AGHT+IHs7cYblukbyZbSslQ8/O/ZkVp0cDxSQ7bb6390JIb5JGmBs1IYANfhgq83FyicefsxwyNe8Q==
X-Received: by 2002:a05:600c:4f05:b0:419:f241:6336 with SMTP id l5-20020a05600c4f0500b00419f2416336mr9058364wmq.1.1714465663958;
        Tue, 30 Apr 2024 01:27:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d6383000000b00341b451a31asm31373126wru.36.2024.04.30.01.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:27:42 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:27:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Brandon Pollack <brpol@chromium.org>
Cc: marius.vlad@collabora.com, mairacanal@riseup.net, jshargo@chromium.org,
	hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
	linux-doc@vger.kernel.org, hirono@chromium.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	melissa.srw@gmail.com, mduggan@chromium.org, mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH v6 7/7] drm/vkms Add hotplug support via configfs to VKMS.
Message-ID: <ZjCrfAELoSV3d4BH@phenom.ffwll.local>
Mail-Followup-To: Brandon Pollack <brpol@chromium.org>,
	marius.vlad@collabora.com, mairacanal@riseup.net,
	jshargo@chromium.org, hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com, linux-doc@vger.kernel.org,
	hirono@chromium.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
	mduggan@chromium.org, mripard@kernel.org, tzimmermann@suse.de
References: <20230829053201.423261-1-brpol@chromium.org>
 <20230829053201.423261-8-brpol@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829053201.423261-8-brpol@chromium.org>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, Aug 29, 2023 at 05:30:59AM +0000, Brandon Pollack wrote:
> This change adds the ability to read or write a "1" or a "0" to the
> newly added "connected" attribute of a connector in the vkms entry in
> configfs.
> 
> A write will trigger a call to drm_kms_helper_hotplug_event, causing a
> hotplug uevent.
> 
> With this we can write virtualized multidisplay tests that involve
> hotplugging displays (eg recompositing windows when a monitor is turned
> off).
> 
> Signed-off-by: Brandon Pollack <brpol@chromium.org>
> ---
>  Documentation/gpu/vkms.rst           |  2 +-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 68 ++++++++++++++++++++++++++--
>  drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++
>  drivers/gpu/drm/vkms/vkms_output.c   | 47 ++++++++++++++++++-
>  4 files changed, 123 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index c3875bf66dba..7f715097539c 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -145,7 +145,7 @@ We want to be able to manipulate vkms instances without having to reload the
>  module. Such configuration can be added as extensions to vkms's ConfigFS
>  support. Use-cases:
>  
> -- Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
> +- Hotremove connectors on the fly (to be able to test DP MST handling
>    of compositors).
>  
>  - Change output configuration: Plug/unplug screens, change EDID, allow changing
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index bc35dcc47585..d231e28101ae 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
> +#include "drm/drm_probe_helper.h"
>  #include <linux/configfs.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> @@ -40,6 +41,7 @@
>   *   `-- vkms
>   *       `-- test
>   *           |-- connectors
> + *                `-- connected
>   *           |-- crtcs
>   *           |-- encoders
>   *           |-- planes
> @@ -89,6 +91,14 @@
>   *
>   *   echo 1 > /config/vkms/test/enabled
>   *
> + * By default no display is "connected" so to connect a connector you'll also
> + * have to write 1 to a connectors "connected" attribute::
> + *
> + *   echo 1 > /config/vkms/test/connectors/connector/connected

I think it'd be really good if we allow all connector status values,
including unknown. It's not very common, which is why most compositors
utterly fail at handling it in a reasonable way.

> + *
> + * One can verify that this is worked using the `modetest` utility or the
> + * equivalent for your platform.
> + *
>   * When you're done with the virtual device, you can clean up the device like
>   * so::
>   *
> @@ -236,7 +246,58 @@ static void add_possible_encoders(struct config_group *parent,
>  
>  /*  Connector item, e.g. /config/vkms/device/connectors/ID */
>  
> +static ssize_t connector_connected_show(struct config_item *item, char *buf)
> +{
> +	struct vkms_config_connector *connector =
> +		item_to_config_connector(item);
> +	struct vkms_configfs *configfs = connector_item_to_configfs(item);
> +	bool connected = false;
> +
> +	mutex_lock(&configfs->lock);
> +	connected = connector->connected;
> +	mutex_unlock(&configfs->lock);
> +
> +	return sprintf(buf, "%d\n", connected);
> +}
> +
> +static ssize_t connector_connected_store(struct config_item *item,
> +					 const char *buf, size_t len)
> +{
> +	struct vkms_config_connector *connector =
> +		item_to_config_connector(item);
> +	struct vkms_configfs *configfs = connector_item_to_configfs(item);
> +	int val, ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 1 && val != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&configfs->lock);
> +	connector->connected = val;
> +	if (!connector->connector) {
> +		pr_info("VKMS Device %s is not yet enabled, connector will be enabled on start",
> +			configfs->device_group.cg_item.ci_name);
> +	}
> +	mutex_unlock(&configfs->lock);
> +
> +	if (connector->connector)
> +		drm_kms_helper_hotplug_event(connector->connector->dev);

Ok a few lifetime bugs here:

- Calling drm_kms_helper_hotplug_event after you unluck means all the drm
  stuff might have disappeared meanwhile. Oops.

- It is worse, because switching to configfs_subsystem.su_mutex will not
  prevent the race, because the vkms_device can disappear independently
  (by manually unbinding the driver in sysfs) at least with the real
  platform driver approach. This is another reason why I'm not sure having
  a real platform driver with probe/remove hooks is a good idea.

- Furthermore the drm_connector might also disappear.

I think the way to properly fix this is:

- configfs needs to hold a reference of it's on to the drm_device in
  vkms_device.

- it needs to call a vkms function to update the connector hotplug status
  with only the configfs obj idx.  That function then needs to find the
  right drm_connector using the drm_connector_iter functions (which will
  sort out any lifetime/locking issues) until is has the right one, and
  then update the connector status.

No matter what, we cannot have a backpointer from any drm object to
configfs, that doesn't work correctly.
-Sima

> +
> +	return len;
> +}
> +
> +CONFIGFS_ATTR(connector_, connected);
> +
> +static struct configfs_attribute *connector_attrs[] = {
> +	&connector_attr_connected,
> +	NULL,
> +};
> +
>  static struct config_item_type connector_type = {
> +	.ct_attrs = connector_attrs,
>  	.ct_owner = THIS_MODULE,
>  };
>  
> @@ -264,7 +325,7 @@ static ssize_t plane_type_show(struct config_item *item, char *buf)
>  	plane_type = plane->type;
>  	mutex_unlock(&configfs->lock);
>  
> -	return sprintf(buf, "%u", plane_type);
> +	return sprintf(buf, "%u\n", plane_type);
>  }
>  
>  static ssize_t plane_type_store(struct config_item *item, const char *buf,
> @@ -319,6 +380,7 @@ static struct config_group *connectors_group_make(struct config_group *group,
>  				    &connector_type);
>  	add_possible_encoders(&connector->config_group,
>  			      &connector->possible_encoders.group);
> +	connector->connected = false;
>  
>  	return &connector->config_group;
>  }
> @@ -500,7 +562,7 @@ static ssize_t device_enabled_show(struct config_item *item, char *buf)
>  	is_enabled = configfs->vkms_device != NULL;
>  	mutex_unlock(&configfs->lock);
>  
> -	return sprintf(buf, "%d", is_enabled);
> +	return sprintf(buf, "%d\n", is_enabled);
>  }
>  
>  static ssize_t device_enabled_store(struct config_item *item, const char *buf,
> @@ -557,7 +619,7 @@ static ssize_t device_id_show(struct config_item *item, char *buf)
>  
>  	mutex_unlock(&configfs->lock);
>  
> -	return sprintf(buf, "%d", id);
> +	return sprintf(buf, "%d\n", id);
>  }
>  
>  CONFIGFS_ATTR_RO(device_, id);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 2b9545ada9c2..5336281f397e 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -3,6 +3,7 @@
>  #ifndef _VKMS_DRV_H_
>  #define _VKMS_DRV_H_
>  
> +#include "drm/drm_connector.h"
>  #include <linux/configfs.h>
>  #include <linux/hrtimer.h>
>  
> @@ -147,7 +148,9 @@ struct vkms_config_links {
>  
>  struct vkms_config_connector {
>  	struct config_group config_group;
> +	struct drm_connector *connector;
>  	struct vkms_config_links possible_encoders;
> +	bool connected;
>  };
>  
>  struct vkms_config_crtc {
> @@ -220,6 +223,10 @@ struct vkms_device {
>  #define item_to_configfs(item) \
>  	container_of(to_config_group(item), struct vkms_configfs, device_group)
>  
> +#define connector_item_to_configfs(item)                                     \
> +	container_of(to_config_group(item->ci_parent), struct vkms_configfs, \
> +		     connectors_group)
> +
>  #define item_to_config_connector(item)                                    \
>  	container_of(to_config_group(item), struct vkms_config_connector, \
>  		     config_group)
> @@ -279,4 +286,8 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>  int vkms_init_configfs(void);
>  void vkms_unregister_configfs(void);
>  
> +/* Connector hotplugging */
> +enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
> +						bool force);
> +
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 0ee1f3f4a305..1a1cd0202c5f 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
> +#include <drm/drm_print.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_crtc.h>
> @@ -8,10 +9,12 @@
>  #include <drm/drm_plane.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> +#include <linux/printk.h>
>  
>  #include "vkms_drv.h"
>  
>  static const struct drm_connector_funcs vkms_connector_funcs = {
> +	.detect = vkms_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
>  	.reset = drm_atomic_helper_connector_reset,
> @@ -19,6 +22,48 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> +static const struct vkms_config_connector *
> +find_config_for_connector(struct drm_connector *connector)
> +{
> +	struct vkms_device *vkms = drm_device_to_vkms_device(connector->dev);
> +	struct vkms_configfs *configfs = vkms->configfs;
> +	struct config_item *item;
> +
> +	if (!configfs) {
> +		pr_info("Default connector has no configfs entry");
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(item, &configfs->connectors_group.cg_children,
> +			    ci_entry) {
> +		struct vkms_config_connector *config_connector =
> +			item_to_config_connector(item);
> +		if (config_connector->connector == connector)
> +			return config_connector;
> +	}
> +
> +	pr_warn("Could not find config to match connector %s, but configfs was initialized",
> +		connector->name);
> +
> +	return NULL;
> +}
> +
> +enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
> +						bool force)
> +{
> +	enum drm_connector_status status = connector_status_connected;
> +	const struct vkms_config_connector *config_connector =
> +		find_config_for_connector(connector);
> +
> +	if (!config_connector)
> +		return connector_status_connected;
> +
> +	if (!config_connector->connected)
> +		status = connector_status_disconnected;
> +
> +	return status;
> +}
> +
>  static const struct drm_encoder_funcs vkms_encoder_funcs = {
>  	.destroy = drm_encoder_cleanup,
>  };
> @@ -280,12 +325,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		struct vkms_config_connector *config_connector =
>  			item_to_config_connector(item);
>  		struct drm_connector *connector = vkms_connector_init(vkmsdev);
> -
>  		if (IS_ERR(connector)) {
>  			DRM_ERROR("Failed to init connector from config: %s",
>  				  item->ci_name);
>  			return PTR_ERR(connector);
>  		}
> +		config_connector->connector = connector;
>  
>  		for (int j = 0; j < output->num_encoders; j++) {
>  			struct encoder_map *encoder = &encoder_map[j];
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

