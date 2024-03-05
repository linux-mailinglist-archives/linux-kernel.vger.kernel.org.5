Return-Path: <linux-kernel+bounces-93118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8D872B47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38282289EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0B512DDB1;
	Tue,  5 Mar 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhMz0r7j"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8941EA74;
	Tue,  5 Mar 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682679; cv=none; b=EdkjzKFDd1n9n9/oYqyt2XEGOJuFSnDeSSVtgNgQ2mNw+pHEiWcr1ix/y7/ymsrqMRyWQ3s9gf0FhsunkW6lPyyBXKm8rpO5K4PeuK93ox2gPwXfytBxD/v3+54CyYsMrY+FhHwsnSCG57f7C0Up2VThGKazKpSTyFA4S+djYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682679; c=relaxed/simple;
	bh=IMhMdXwkFMCOeEanoT3+CPNZVWBZ30MRdahAPoSWoSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYstFX+xlqXs7aI4YmZct/cusOlge5Nwz0PrIg0tIsVBQeYHCp9sQNhEhmjYRCC38uSyEOgdTpdQR2+xOuJXwL0Na/MfP/TeIy2xmmQGVt9lLKDKxu17C+kKW72Ma8G4F+MZfxjxd6O0Ps6sTOV8u1h8f7IfcS++P1TG23bEUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhMz0r7j; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2995fa850ddso229348a91.0;
        Tue, 05 Mar 2024 15:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709682677; x=1710287477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y00i9tEWvP8noYyCmA3iSFWknDYUO6IOTKvbT4q8GQA=;
        b=jhMz0r7jfrnabc/gBsNMjQIZjI3u1d2n/HW8R5RqE0CjmTALScPyIvNNiMsiykId1W
         WJ4eY91WiokfY+4mRoUJrQfzkfXbeKJQtxyzS3vmnXXuT9Px/aNauzCO22BwYKdLcQBf
         Dv71sWln5rv7nGt84tlDP0qy49izthucE3ZvyOsO5MkwtpYKTdM3CO0ZglDDV9IbyO1r
         cxL57xD9nmbsFgvwFC/aFUfHERtK30So9Fhlwygu8bNdmsI3lR7dAnTXtFMj8JBXXYY3
         G1Wi382gKkjEXWDJigzD57OFrlRffuIxL8AKBCgHsbtvSMXwxqV3eDVpBWFNVH5GFMHD
         286A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709682677; x=1710287477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y00i9tEWvP8noYyCmA3iSFWknDYUO6IOTKvbT4q8GQA=;
        b=Ny0FdQF17vS9+BNirf5A4YMlh6ey0NIYAlI36m4y2mfLPTZRKe4dMQKkFdniz2Xlfd
         IxiJ8V2U9oV4AmFPDPsVkjzxwvGGL1S35dHG+Hiin3aHv7fZBkQoVi6oNVwHtSS2ag+I
         n7VHagoAfszEQOWqoR7HY3tf+6ysZh4oyUm4YWXol/MuHSpb7agnxuVRsz8fWarD/cTr
         z7DCdCnxvCr4rIZRMkO9g20aDb/G/gxf22MMa7oY1VjeJjbshaybcYgVfk+Hfv47Y6Yp
         583ZmRxvuVsumz+RtWmqLhj4e6kTtDE0Hx4koxSXnTnhcfVaaeqPZhjPH5ka8nNGso40
         hJJw==
X-Forwarded-Encrypted: i=1; AJvYcCUB3enth6aMf4o/aBmxKdhmi4/QkkPr2dYkslBjVHValtJLS9wFt80lIxF4opyY+Dudjo2GrjEGmCXQg4i8FF6SvtA1Vg79zYqQx9OW2EbYNdGtSN+7RgM8JVs0N0KnYf0zEdf1
X-Gm-Message-State: AOJu0YwvcY3uLWhm5UQXTiqo2/LASLXNK/F4aoEfsgMHm7V39D5wiSTV
	or37q55qdthf5Xsnbj7drINeaVL5EAVAgP8UsYZAbpgtw329vDgi
X-Google-Smtp-Source: AGHT+IEQA+OMqhbvrckikI6bBbkJ80fydnUXwNfORrFEt8GLd+Lg9FOvgAvmWCu/XLJGb4HFH3aKdA==
X-Received: by 2002:a17:90b:794:b0:299:63bd:c17d with SMTP id l20-20020a17090b079400b0029963bdc17dmr5139870pjz.2.1709682676791;
        Tue, 05 Mar 2024 15:51:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l16-20020a17090aec1000b0029b69d136b5sm568461pjy.1.2024.03.05.15.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:51:16 -0800 (PST)
Message-ID: <20e792ad-33ce-43a6-8ed0-8db6e1a25c27@gmail.com>
Date: Tue, 5 Mar 2024 15:51:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/16] net: dsa: vsc73xx: Add vlan filtering
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-8-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-8-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This patch implements VLAN filtering for the vsc73xx driver.
> 
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

[snip]

> +static size_t
> +vsc73xx_bridge_vlan_num_untagged(struct vsc73xx *vsc, int port, u16 ignored_vid)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +	size_t num_untagged = 0;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    (vlan->untagged & BIT(port)) &&
> +		    vlan->vid != ignored_vid)
> +			num_untagged++;
> +
> +	return num_untagged;
> +}

You always use both helpers at the same time, so I would suggest 
returning num_tagged and num_untagged by reference to have a single 
linked list lookup.

> +
> +static u16 vsc73xx_find_first_vlan_untagged(struct vsc73xx *vsc, int port)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    (vlan->untagged & BIT(port)))
> +			return vlan->vid;
> +
> +	return VLAN_N_VID;
> +}
> +
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool store_untagged = false;
> +	bool store_pvid = false;
> +	u16 vid, vlan_untagged;
> +
> +	/* The swap processed below is required because vsc73xx is using
> +	 * tag_8021q. When vlan_filtering is disabled, tag_8021q uses
> +	 * pvid/untagged vlans for port recognition. The values configured for
> +	 * vlans < 3072 are stored in storage table. When vlan_filtering is
> +	 * enabled, we need to restore pvid/untagged from storage and keep
> +	 * values used for tag_8021q.
> +	 */
> +	if (vlan_filtering) {
> +		/* Use VLAN_N_VID to count all vlans */
> +		size_t num_untagged =
> +			vsc73xx_bridge_vlan_num_untagged(vsc, port, VLAN_N_VID);
> +
> +		port_vlan_conf = (num_untagged > 1) ?
> +				 VSC73XX_VLAN_FILTER_UNTAG_ALL :
> +				 VSC73XX_VLAN_FILTER;
> +
> +		vlan_untagged = vsc73xx_find_first_vlan_untagged(vsc, port);
> +		if (vlan_untagged < VLAN_N_VID) {
> +			store_untagged  = vsc73xx_port_get_untagged(vsc, port,
> +								    &vid,
> +								    false);
> +			vsc73xx_vlan_change_untagged(vsc, port, vlan_untagged,
> +						     true, false);
> +			vsc->untagged_storage[port] = store_untagged ?
> +						      vid : VLAN_N_VID;
> +		}
> +	} else {
> +		vsc73xx_vlan_change_untagged(vsc, port,
> +					     vsc->untagged_storage[port],
> +					     vsc->untagged_storage[port] <
> +					     VLAN_N_VID, false);
> +	}
> +
> +	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +	store_pvid = vsc73xx_port_get_pvid(vsc, port, &vid, false);
> +	vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
> +				 vsc->pvid_storage[port] < VLAN_N_VID, false);
> +	vsc->pvid_storage[port] = store_pvid ? vid : VLAN_N_VID;
> +
> +	return 0;
> +}
> +
> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	size_t num_tagged, num_untagged;
> +	struct vsc73xx *vsc = ds->priv;
> +	int ret;
> +	u16 vid;
> +
> +	/* Be sure to deny alterations to the configuration done by tag_8021q.
> +	 */
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}
> +
> +	/* The processed vlan->vid is excluded from the search because the VLAN
> +	 * can be re-added with a different set of flags, so it's easiest to
> +	 * ignore its old flags from the VLAN database software copy.
> +	 */
> +	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
> +	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);
> +
> +	/* VSC73XX allow only three untagged states: none, one or all */
> +	if ((untagged && num_tagged > 0 && num_untagged > 0) ||
> +	    (!untagged && num_untagged > 1)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port can have only none, one or all untagged vlan");
> +		return -EBUSY;
> +	}
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid = vlan->vid;
> +		vsc73xx_vlan->portmask = BIT(port);
> +		vsc73xx_vlan->untagged = untagged ? BIT(port) : 0;
> +
> +		INIT_LIST_HEAD(&vsc73xx_vlan->list);
> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	} else {
> +		vsc73xx_vlan->portmask |= BIT(port);
> +
> +		if (untagged)
> +			vsc73xx_vlan->untagged |= BIT(port);
> +		else
> +			vsc73xx_vlan->untagged &= ~BIT(port);

These assignments should be working even when you have a freshly 
allocated VLAN entry, so you can just re-factor this a bit and have a 
common set of assignments applying to an existing or freshly allocated 
VLAN entry?

> +	}
> +
> +	/* CPU port must be always tagged because port separation is based on
> +	 * tag_8021q.
> +	 */
> +	if (port != CPU_PORT) {

Please reduce indentation here.

Have to admit the logic is a bit hard to follow, but that is also 
because of my lack of understanding of the requirements surrounding the 
use of tag_8021q.
-- 
Florian


