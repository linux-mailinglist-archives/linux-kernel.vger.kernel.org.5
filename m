Return-Path: <linux-kernel+bounces-60415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE931850494
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D22838A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2F53E14;
	Sat, 10 Feb 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXwhu+Dm"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB3C53E0E
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574248; cv=none; b=F6isd0Hp6ibXugxb5DKoUvyGzVWGO5IPmN9wT6PyjoINBaZEPU0WyNz43a6YKr0UoXuzS9h7nuEHk+wr9yj1rZTOjFWstfemto7EJpd+LgqjFO63AbTv/GoHzU+yqhqRVwhaJY7yvZq6ISfgPmOYAwqSRO7Js0y1lk90ACvAbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574248; c=relaxed/simple;
	bh=JH2l/F47E+Shk45U5CPuHOdYmrRlrIxIp2DDNWAmuo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgS94XytJRx61oqpcJu/rOwGPdiJRUJpHs03RuLEiLHnFfXKRO+dnP6UsvfkWbtTzyqZjw2j+s9RtoFDGHZBeCH5n6zLlETGi2nUzlzJmL/TUqKXS1YIU3yCe1aNpZ6SIDpivA2cghzLkZ3sG4FvLtUYfMJAX2eyD6rtTMyDx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXwhu+Dm; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1756290276.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707574244; x=1708179044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/j1nrgyUuRkpp75x3KBXMusSKHdoxymJpmPHYvTa44=;
        b=BXwhu+DmFwkCe9KMlLmMN37gB0zMnU+SB5/IJ6ZNswXxY+z5H5aJlQp+BkSYP5oFLn
         TPB//WVAi9bZTswpyiAiIfvH0OyVTwKwxh1t3AUEn+DQiVK81CrI4+HbBKb+lzV7Dokc
         dXAOA/hi7eh7qNHu1KoMOW6LUjA4+9jKUu78l5P9KVcrDv+TOrYxIm/kJ6KNRX3h6E7I
         3i8JLHgV+2Zrm4cFNyuAY6SnEM9jugemW/dJlKaqsevNQYbI1Tfv+gc6Ftzr5oq6xYEn
         6LQjeBjn8wNbYthyeS0yeqHeo6jBglpORsiCCuBXe10JiEBzZueexhikOo11656i8gXg
         9tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707574244; x=1708179044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/j1nrgyUuRkpp75x3KBXMusSKHdoxymJpmPHYvTa44=;
        b=hhTvTviH6tUYm+fSRTM+C8BfgGQix0FcEf+qjN2RdbeGe0ZvrcZHKiBk/2JDgcUXED
         SoM8ftYgqFQu4Q2bjTHAUoNsNEccDu3+YvmbWwcjCUASceoqzVbTrTkP0ovwbFcOCbLE
         jI+4OI+BcxPfP+zpBauy6aSiu3komqyMiyROEMh0LVeWrvqv6/1XFlDWCC/MpVH07A2S
         eKadm59LJ2xr5DBd1I5PSBDifnz2ym3whinkYmWukTweK53/OTgjrIOPVcfntbWeN1AY
         TqxxTYcNpyWYtOHRwYudyKKY9We83MTCH5umoFNT9nVCOw39LKsYFG2CVm9ex/k+Zwr2
         Hw7g==
X-Gm-Message-State: AOJu0YzRekHpnNta+A0wVZsFBFGLIERy77r+h6mEFGOjDS+uoH68W+Im
	ECXpU4gdr9jNdP+gHlLYnPHp3tJPXyF5/udN3FnFQP+iKfwDn6tkTWE1RgXJVidfHIewlpJ6pym
	7IB6SqqnfYW0C6HoGhEV9yDqFEswqfzyBGEz80A==
X-Google-Smtp-Source: AGHT+IGUFCUpZYFmT0nhN7Y2aAsAAJ4oh/v1ASKOupC/USl3HtOdHYOhex2CdX6Rc/ro39U5yRXM1iuAbnP0BYN7PEw=
X-Received: by 2002:a05:6902:230c:b0:dc7:483c:7e64 with SMTP id
 do12-20020a056902230c00b00dc7483c7e64mr2207839ybb.54.1707574242451; Sat, 10
 Feb 2024 06:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-15-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-15-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 10 Feb 2024 16:10:31 +0200
Message-ID: <CAA8EJpo1g9QKq1skibqSj9yc3mNSfkcts9oVf_vGjVjDzVZwiA@mail.gmail.com>
Subject: Re: [PATCH 14/22] platform/chrome: cros_typec_switch: Add support for
 signaling HPD to drm_bridge
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 09:14, Stephen Boyd <swboyd@chromium.org> wrote:
>
> We can imagine that logically the EC is a device that has some number of
> DisplayPort (DP) connector inputs, some number of USB3 connector inputs,
> and some number of USB type-c connector outputs. If you squint enough it
> looks like a USB type-c dock. Logically there's a crossbar pin
> assignment capability within the EC that can assign USB and DP lanes to
> USB type-c lanes in the connector (i.e. USB type-c pin configurations).
> In reality, the EC is a microcontroller that has some TCPCs and
> redrivers connected to it over something like i2c and DP/USB from the AP
> is wired directly to those ICs, not the EC.
>
> This design allows the EC to abstract many possible USB and DP hardware
> configurations away from the AP (kernel) so that the AP can largely deal
> with USB and DP without thinking about USB Type-C much at all. The DP
> and USB data originate in the AP, not the EC, so it helps to think that
> the EC takes the DP and USB data as input to mux onto USB type-c ports
> even if it really doesn't do that. With this split design, the EC
> forwards the DP HPD state to the AP via a GPIO that's connected to the
> DP phy.
>
> Having that HPD state signaled directly to the DP phy uses precious
> hardware resources, a GPIO or two and a wire, and it also forces the
> TCPM to live on the EC. If we want to save costs and move more control
> of USB type-c to the kernel it's in our interest to get rid of the HPD
> GPIO entirely and signal HPD to the DP phy some other way. Luckily, the
> EC already exposes information about the USB Type-C stack to the kernel
> via the host command interface in the "google,cros-ec-typec" compatible
> driver, which parses EC messages related to USB type-c and effectively
> "replays" those messages to the kernel's USB typec subsystem. This
> includes the state of HPD, which can be interrogated and acted upon by
> registering a 'struct typec_mux_dev' with the typec subsystem.
>
> On DT based systems, the DP display pipeline is abstracted via a 'struct
> drm_bridge'. If we want to signal HPD state within the kernel we need to
> hook into the drm_bridge framework somehow to call
> drm_bridge_hpd_notify() when HPD state changes in the typec framework.
> Make a drm_bridge in the EC that attaches onto the end of the DP bridge
> chain and logically moves the display data onto a usb-c-connector.
> Signal HPD when the typec HPD state changes, as long as this new
> drm_bridge is the one that's supposed to signal HPD. Do that by
> registering a 'struct typec_mux_dev' with the typec framework and
> associating that struct with a usb-c-connector node and a drm_bridge.
>
> To keep this patch minimal, just signal HPD state to the drm_bridge
> chain. Later patches will add more features. Eventually we'll be able to
> inform userspace about which usb-c-connector node is displaying DP and
> what USB devices are connected to a connector. Note that this code is
> placed in the cros_typec_switch driver because that's where mode-switch
> devices on the EC are controlled by the AP. Logically this drm_bridge
> sits in front of the mode-switch on the EC, and if there is anything to
> control on the EC the 'EC_FEATURE_TYPEC_AP_MUX_SET' feature will be set.
>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/Kconfig             |   3 +-
>  drivers/platform/chrome/cros_typec_switch.c | 218 ++++++++++++++++++--
>  2 files changed, 204 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 7a83346bfa53..910aa8be9c84 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -287,7 +287,8 @@ config CHROMEOS_PRIVACY_SCREEN
>
>  config CROS_TYPEC_SWITCH
>         tristate "ChromeOS EC Type-C Switch Control"
> -       depends on MFD_CROS_EC_DEV && TYPEC && ACPI
> +       depends on MFD_CROS_EC_DEV
> +       depends on TYPEC
>         default MFD_CROS_EC_DEV
>         help
>           If you say Y here, you get support for configuring the ChromeOS EC Type-C
> diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> index 769de2889f2f..d8fb6662cf8d 100644
> --- a/drivers/platform/chrome/cros_typec_switch.c
> +++ b/drivers/platform/chrome/cros_typec_switch.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
> @@ -18,6 +19,15 @@
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_retimer.h>
>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_print.h>
> +
> +struct cros_typec_dp_bridge {
> +       struct cros_typec_switch_data *sdata;
> +       bool hpd_enabled;
> +       struct drm_bridge bridge;
> +};

Is there any chance that you can use drm_dp_hpd_bridge_register() /
drm_aux_hpd_bridge_notify() instead of implementing another
drm_bridge?
If something is missing from the existing implementation we can
probably work that out.

> +
>  /* Handles and other relevant data required for each port's switches. */
>  struct cros_typec_port {
>         int port_num;
> @@ -30,7 +40,9 @@ struct cros_typec_port {
>  struct cros_typec_switch_data {
>         struct device *dev;
>         struct cros_ec_device *ec;
> +       bool typec_cmd_supported;
>         struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
> +       struct cros_typec_dp_bridge *typec_dp_bridge;
>  };
>
>  static int cros_typec_cmd_mux_set(struct cros_typec_switch_data *sdata, int port_num, u8 index,
> @@ -143,13 +155,60 @@ static int cros_typec_configure_mux(struct cros_typec_switch_data *sdata, int po
>         return 0;
>  }
>
> +static int cros_typec_dp_port_switch_set(struct typec_mux_dev *mode_switch,
> +                                        struct typec_mux_state *state)
> +{
> +       struct cros_typec_port *port;
> +       const struct typec_displayport_data *dp_data;
> +       struct cros_typec_dp_bridge *typec_dp_bridge;
> +       struct drm_bridge *bridge;
> +       bool hpd_asserted;
> +
> +       port = typec_mux_get_drvdata(mode_switch);
> +       typec_dp_bridge = port->sdata->typec_dp_bridge;
> +       if (!typec_dp_bridge)
> +               return 0;
> +
> +       bridge = &typec_dp_bridge->bridge;
> +
> +       if (state->mode == TYPEC_STATE_SAFE || state->mode == TYPEC_STATE_USB) {
> +               if (typec_dp_bridge->hpd_enabled)
> +                       drm_bridge_hpd_notify(bridge, connector_status_disconnected);
> +
> +               return 0;
> +       }
> +
> +       if (state->alt && state->alt->svid == USB_TYPEC_DP_SID) {
> +               if (typec_dp_bridge->hpd_enabled) {
> +                       dp_data = state->data;
> +                       hpd_asserted = dp_data->status & DP_STATUS_HPD_STATE;
> +
> +                       if (hpd_asserted)
> +                               drm_bridge_hpd_notify(bridge, connector_status_connected);
> +                       else
> +                               drm_bridge_hpd_notify(bridge, connector_status_disconnected);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int cros_typec_mode_switch_set(struct typec_mux_dev *mode_switch,
>                                       struct typec_mux_state *state)
>  {
>         struct cros_typec_port *port = typec_mux_get_drvdata(mode_switch);
> +       struct cros_typec_switch_data *sdata = port->sdata;
> +       int ret;
> +
> +       ret = cros_typec_dp_port_switch_set(mode_switch, state);
> +       if (ret)
> +               return ret;
>
>         /* Mode switches have index 0. */
> -       return cros_typec_configure_mux(port->sdata, port->port_num, 0, state->mode, state->alt);
> +       if (sdata->typec_cmd_supported)
> +               return cros_typec_configure_mux(port->sdata, port->port_num, 0, state->mode, state->alt);
> +
> +       return 0;
>  }
>
>  static int cros_typec_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
> @@ -201,12 +260,77 @@ static int cros_typec_register_retimer(struct cros_typec_port *port, struct fwno
>         return PTR_ERR_OR_ZERO(port->retimer);
>  }
>
> +static int
> +cros_typec_dp_bridge_attach(struct drm_bridge *bridge,
> +                           enum drm_bridge_attach_flags flags)
> +{
> +       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +               DRM_ERROR("Fix bridge driver to make connector optional!\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct cros_typec_dp_bridge *
> +bridge_to_cros_typec_dp_bridge(struct drm_bridge *bridge)
> +{
> +       return container_of(bridge, struct cros_typec_dp_bridge, bridge);
> +}
> +
> +static void cros_typec_dp_bridge_hpd_enable(struct drm_bridge *bridge)
> +{
> +       struct cros_typec_dp_bridge *typec_dp_bridge;
> +
> +       typec_dp_bridge = bridge_to_cros_typec_dp_bridge(bridge);
> +       typec_dp_bridge->hpd_enabled = true;
> +}
> +
> +static void cros_typec_dp_bridge_hpd_disable(struct drm_bridge *bridge)
> +{
> +       struct cros_typec_dp_bridge *typec_dp_bridge;
> +
> +       typec_dp_bridge = bridge_to_cros_typec_dp_bridge(bridge);
> +       typec_dp_bridge->hpd_enabled = false;
> +}
> +
> +static const struct drm_bridge_funcs cros_typec_dp_bridge_funcs = {
> +       .attach = cros_typec_dp_bridge_attach,
> +       .hpd_enable = cros_typec_dp_bridge_hpd_enable,
> +       .hpd_disable = cros_typec_dp_bridge_hpd_disable,
> +};
> +
> +static int cros_typec_register_dp_bridge(struct cros_typec_switch_data *sdata,
> +                                        struct fwnode_handle *fwnode)
> +{
> +       struct cros_typec_dp_bridge *typec_dp_bridge;
> +       struct drm_bridge *bridge;
> +       struct device *dev = sdata->dev;
> +
> +       typec_dp_bridge = devm_kzalloc(dev, sizeof(*typec_dp_bridge), GFP_KERNEL);
> +       if (!typec_dp_bridge)
> +               return -ENOMEM;
> +
> +       typec_dp_bridge->sdata = sdata;
> +       sdata->typec_dp_bridge = typec_dp_bridge;
> +       bridge = &typec_dp_bridge->bridge;
> +
> +       bridge->funcs = &cros_typec_dp_bridge_funcs;
> +       bridge->of_node = dev->of_node;
> +       bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
> +       bridge->ops |= DRM_BRIDGE_OP_HPD;
> +
> +       return devm_drm_bridge_add(dev, bridge);
> +}
> +
>  static int cros_typec_register_port(struct cros_typec_switch_data *sdata,
>                                     struct fwnode_handle *fwnode)
>  {
>         struct cros_typec_port *port;
>         struct device *dev = sdata->dev;
>         struct acpi_device *adev;
> +       struct device_node *np;
> +       struct fwnode_handle *port_node;
>         u32 index;
>         int ret;
>         const char *prop_name;
> @@ -218,9 +342,12 @@ static int cros_typec_register_port(struct cros_typec_switch_data *sdata,
>         adev = to_acpi_device_node(fwnode);
>         if (adev)
>                 prop_name = "_ADR";
> +       np = to_of_node(fwnode);
> +       if (np)
> +               prop_name = "reg";
>
> -       if (!adev)
> -               return dev_err_probe(fwnode->dev, -ENODEV, "Couldn't get ACPI handle\n");
> +       if (!adev && !np)
> +               return dev_err_probe(fwnode->dev, -ENODEV, "Couldn't get ACPI/OF device handle\n");
>
>         ret = fwnode_property_read_u32(fwnode, prop_name, &index);
>         if (ret)
> @@ -232,41 +359,84 @@ static int cros_typec_register_port(struct cros_typec_switch_data *sdata,
>         port->port_num = index;
>         sdata->ports[index] = port;
>
> +       port_node = fwnode;
> +       if (np)
> +               fwnode = fwnode_graph_get_port_parent(fwnode);
> +
>         if (fwnode_property_present(fwnode, "retimer-switch")) {
> -               ret = cros_typec_register_retimer(port, fwnode);
> -               if (ret)
> -                       return dev_err_probe(dev, ret, "Retimer switch register failed\n");
> +               ret = cros_typec_register_retimer(port, port_node);
> +               if (ret) {
> +                       dev_err_probe(dev, ret, "Retimer switch register failed\n");
> +                       goto out;
> +               }
>
>                 dev_dbg(dev, "Retimer switch registered for index %u\n", index);
>         }
>
> -       if (!fwnode_property_present(fwnode, "mode-switch"))
> -               return 0;
> +       if (fwnode_property_present(fwnode, "mode-switch")) {
> +               ret = cros_typec_register_mode_switch(port, port_node);
> +               if (ret) {
> +                       dev_err_probe(dev, ret, "Mode switch register failed\n");
> +                       goto out;
> +               }
>
> -       ret = cros_typec_register_mode_switch(port, fwnode);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "Mode switch register failed\n");
> +               dev_dbg(dev, "Mode switch registered for index %u\n", index);
> +       }
>
> -       dev_dbg(dev, "Mode switch registered for index %u\n", index);
>
> +out:
> +       if (np)
> +               fwnode_handle_put(fwnode);
>         return ret;
>  }
>
>  static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
>  {
>         struct device *dev = sdata->dev;
> +       struct fwnode_handle *devnode;
>         struct fwnode_handle *fwnode;
> +       struct fwnode_endpoint endpoint;
>         int nports, ret;
>
>         nports = device_get_child_node_count(dev);
>         if (nports == 0)
>                 return dev_err_probe(dev, -ENODEV, "No switch devices found\n");
>
> -       device_for_each_child_node(dev, fwnode) {
> -               ret = cros_typec_register_port(sdata, fwnode);
> -               if (ret) {
> +       devnode = dev_fwnode(dev);
> +       if (fwnode_graph_get_endpoint_count(devnode, 0)) {
> +               fwnode_graph_for_each_endpoint(devnode, fwnode) {
> +                       ret = fwnode_graph_parse_endpoint(fwnode, &endpoint);
> +                       if (ret) {
> +                               fwnode_handle_put(fwnode);
> +                               goto err;
> +                       }
> +                       /* Skip if not a type-c output port */
> +                       if (endpoint.port != 2)
> +                               continue;
> +
> +                       ret = cros_typec_register_port(sdata, fwnode);
> +                       if (ret) {
> +                               fwnode_handle_put(fwnode);
> +                               goto err;
> +                       }
> +               }
> +       } else {
> +               device_for_each_child_node(dev, fwnode) {
> +                       ret = cros_typec_register_port(sdata, fwnode);
> +                       if (ret) {
> +                               fwnode_handle_put(fwnode);
> +                               goto err;
> +                       }
> +               }
> +       }
> +
> +       if (fwnode_property_present(devnode, "mode-switch")) {
> +               fwnode = fwnode_graph_get_endpoint_by_id(devnode, 0, 0, 0);
> +               if (fwnode) {
> +                       ret = cros_typec_register_dp_bridge(sdata, fwnode);
>                         fwnode_handle_put(fwnode);
> -                       goto err;
> +                       if (ret)
> +                               goto err;
>                 }
>         }
>
> @@ -280,6 +450,7 @@ static int cros_typec_switch_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct cros_typec_switch_data *sdata;
> +       struct cros_ec_dev *ec_dev;
>
>         sdata = devm_kzalloc(dev, sizeof(*sdata), GFP_KERNEL);
>         if (!sdata)
> @@ -288,6 +459,12 @@ static int cros_typec_switch_probe(struct platform_device *pdev)
>         sdata->dev = dev;
>         sdata->ec = dev_get_drvdata(pdev->dev.parent);
>
> +       ec_dev = dev_get_drvdata(&sdata->ec->ec->dev);
> +       if (!ec_dev)
> +               return -EPROBE_DEFER;
> +
> +       sdata->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_AP_MUX_SET);
> +
>         platform_set_drvdata(pdev, sdata);
>
>         return cros_typec_register_switches(sdata);
> @@ -308,10 +485,19 @@ static const struct acpi_device_id cros_typec_switch_acpi_id[] = {
>  MODULE_DEVICE_TABLE(acpi, cros_typec_switch_acpi_id);
>  #endif
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_typec_switch_of_match_table[] = {
> +       { .compatible = "google,cros-ec-typec-switch" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, cros_typec_switch_of_match_table);
> +#endif
> +
>  static struct platform_driver cros_typec_switch_driver = {
>         .driver = {
>                 .name = "cros-typec-switch",
>                 .acpi_match_table = ACPI_PTR(cros_typec_switch_acpi_id),
> +               .of_match_table = of_match_ptr(cros_typec_switch_of_match_table),
>         },
>         .probe = cros_typec_switch_probe,
>         .remove_new = cros_typec_switch_remove,
> --
> https://chromeos.dev
>
>


-- 
With best wishes
Dmitry

