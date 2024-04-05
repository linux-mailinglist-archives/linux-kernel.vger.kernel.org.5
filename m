Return-Path: <linux-kernel+bounces-133310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56089A213
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC9DB2523C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D8171078;
	Fri,  5 Apr 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMiRTSns"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE57171066;
	Fri,  5 Apr 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333240; cv=none; b=VJWEHMj6WEeJ+nsD1HaLJhPpb2NRqqH5uXttrd0bD6TXxeVx8hmh348G63xJIvEN5PGiubyDeU5P2D3+Cw54EOQ5AN1L5bZkkZjG5Y/XIheMAqUDNgdle3XYGhoucL/b1Hn0D79AGP3/CGW2D+ALvEy2EsJ0OymR2Q8NnjDK0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333240; c=relaxed/simple;
	bh=5AXlut9OGYv3DSXu2yDWsFFCKzEKKIb9A8Q/EEtoh/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YETzB/zANq56STkiaZlz4FCt9uCQYnVubUuekziCDxw6jpTPg/CLDdqu9PohzyitRydRrGILs9on/yca3/TknHmsZb9lagPeTKYOK3RypevHXrSvCNZaEsIGswxfguNXKh9uZ1j9MQmRqdoDIQROhB03oc9k1j+Sdik0zBOhyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMiRTSns; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56dfb52d10cso2625050a12.2;
        Fri, 05 Apr 2024 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333237; x=1712938037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWxWCR4jW+IXngpqL70YJDP0T6vuTGV5ymV1PXN5QL0=;
        b=cMiRTSnsHBrCufZ7PqWqY0r5YATSlyeoGvjUWLgT+qmCF9R//smFJG3I22+1blGplF
         DgnOEpEtMF1kyrl3QKMSWPQbS6cfIu9Kr31OY10wCRLdf1CD7+zQCsnqasf7W//XjsHL
         h1jTVaFn0qdhvt+c+v1a7ir18sCmok7kznxPEePmvnpKLm3vUv0IUYCGHBzWrDa9h8lR
         zxPcMWkWga5vBoB3oT8/jTrkMBef1FsdFI5I1F7wnfimTYo0WUwRUup0cI6wstZIAcLm
         oz0WXIyNVyBKUfx9gwzN6Fs0veNb+WNk098tYDFwvnZ6apQKV9tmhjxv+ELTQ8CaWjXq
         BMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333237; x=1712938037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWxWCR4jW+IXngpqL70YJDP0T6vuTGV5ymV1PXN5QL0=;
        b=w6xT/ppm3TqufyKfyc4xMXjpwSSoZfOd+R5WVhBxvXgqQX0FjkjVci57fYzkaNn0U5
         SXYhktqZ5E/awW4GI7mgJB29RBN2R3iA9MNIf2Icyul0GplNP7hNwDEv35MAeLiYTozV
         KBc/N52Z+bAB7ZkJzgUC4rwZskNn+TvBGSLEVBCyhaoDzm1OolQzTQDgj+K7HQzgpTli
         K2idIrcBzBJ0WUVKqVCBttQK0MW5R1iP/80N3Wz9gdC8oGdh+zeERUF8Y/40nZsdVYNi
         q8GBDkmzxO0/fZNJfIJ/hDfp9pRw8oCHZ3l/xPzBezro/RKSDtuUZFw+B3lFaAuykRSb
         l+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDsJSbIFAzivI9WHheLUgwNZ7A9Hd6LB8wVuE0plF/S7YNBU00SirhcKJtYcBzNJxu29VlSkL4Nkzy5b41FXxGLARy1Qi9QMBcQjd/
X-Gm-Message-State: AOJu0YyLWzsN3EPphM04oFdyxZv5+qX9kEv1E/lE3XlN2ok62erXbbP7
	21hxeuWtndJh+f8apAZxXdZpAAoghqaoOt0C6trOO3nG4yUKNKCB
X-Google-Smtp-Source: AGHT+IF7dy/kq+AATCpv8CUEDkIB1LId8J+Lr4m6BkQtDRqyyk/K+83e4aN/TATArwjdHUCfM1GzUg==
X-Received: by 2002:a17:906:a86:b0:a51:a4fc:4baf with SMTP id y6-20020a1709060a8600b00a51a4fc4bafmr1217253ejf.25.1712333236356;
        Fri, 05 Apr 2024 09:07:16 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906048800b00a4e4de1892fsm979376eja.58.2024.04.05.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:07:15 -0700 (PDT)
Date: Fri, 5 Apr 2024 19:07:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 07/16] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240405160712.pfgt7lnutsqvxfob@skbuf>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403103734.3033398-8-paweldembicki@gmail.com>

On Wed, Apr 03, 2024 at 12:37:23PM +0200, Pawel Dembicki wrote:
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
> +	u16 vid_pvid = 0, vid_untagged = 0;
> +	struct vsc73xx_portinfo *portinfo;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool set_untagged = false;
> +	bool set_pvid = false;
> +
> +	portinfo = &vsc->portinfo[port];
> +
> +	/* The swap processed below is required because vsc73xx is using
> +	 * tag_8021q. When vlan_filtering is disabled, tag_8021q uses
> +	 * pvid/untagged vlans for port recognition. The values configured for
> +	 * vlans and pvid/untagged states are stored in portinfo structure.
> +	 * When vlan_filtering is enabled, we need to restore pvid/untagged from
> +	 * portinfo structure. Analogic routine is processed when vlan_filtering

Analogous

> +	 * is disabled, but values used for tag_8021q are restored.
> +	 */
> +	if (vlan_filtering) {
> +		struct vsc73xx_vlan_summary summary;
> +
> +		/* Use VLAN_N_VID to count all vlans */
> +		vsc73xx_bridge_vlan_summary(vsc, port, &summary, VLAN_N_VID);
> +
> +		port_vlan_conf = (summary.num_untagged > 1) ?
> +				 VSC73XX_VLAN_FILTER_UNTAG_ALL :
> +				 VSC73XX_VLAN_FILTER;
> +
> +		if (summary.num_untagged == 1) {
> +			vid_untagged = vsc73xx_find_first_vlan_untagged(vsc,
> +									port);
> +			set_untagged = true;
> +		}

Is there really any functional difference between the above, vs this in
port_vlan_add():

	port_vlan_conf = VSC73XX_VLAN_FILTER;

	if (summary.num_tagged == 0 && untagged)
		port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);

	if (port_vlan_conf == VSC73XX_VLAN_FILTER_UNTAG_ALL)
		goto update_vlan_table;

vs this in port_vlan_del():

		enum vsc73xx_port_vlan_conf port_vlan_conf =
							VSC73XX_VLAN_FILTER;

		if (summary.num_tagged == 0)
			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);

		if (summary.num_untagged <= 1) {
			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
			vsc73xx_vlan_change_untagged_hw(vsc, port, vid,
							summary.num_untagged);
		}

?

If not, I have to agree with Florian that it's dizzying to follow the
vsc73xx_set_vlan_conf() calls, all with slightly different input.
Even worse now than before, I think.

I see you've changed the storage variable names, so maybe you are open
to some more refactoring, to make the code more maintainable.

I would suggest calling a single vsc73xx_update_vlan_conf() from all
places, which figures out what to do by itself, based on the current
(updated) state. All ifs and buts are on the inside, not on the outside.

Also, the operate_on_storage variable is not a great name now. Because
you always operate on storage. It means "operate _just_ on storage", aka
"don't commit to hardware".

I wanted to avoid requesting you to make more changes to the
implementation, but you started it, and now it's a confusing mix of
concepts from old and new patch sets.

I would like to also see the "operate_on_storage" logic rewritten and
embedded into those functions which must update shared resources (port
PVID, port untagged VID, etc).

Basically, in the end I would like the driver to be written in the style
of every other similar function: ocelot_port_manage_port_tag(),
sja1105_commit_pvid(), mv88e6xxx_commit_pvid() etc. No arguments, except
the port on which to run. Figure out what to do from the current state,
and make sure it is called from all places that change that state.
It also serves very well as self-documenting code, because "how register
X should be set" is centralized into a single function.

Sorry for making this request so late in the development process. I hope
it's not discouraging.

