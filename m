Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5C79DBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjILWXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILWXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:23:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C963810E6;
        Tue, 12 Sep 2023 15:23:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso7937159a12.3;
        Tue, 12 Sep 2023 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694557385; x=1695162185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FL9z8xf3gSxSE5MtV355yS3vcK6eRahCEwpG0o67ud8=;
        b=X0ZWXS7YcjVlT7ItlCiPs0iCdAtWo04dxE7SRtfdf2RDvz5vpOzNd6QbFd8ZLvMx26
         gFd+aXtGxx2Aipa0qdDGRhL9ahiOpoLYU/gf7N1+Tr7UjKE4IHytkQk3n0MafVE56T1R
         CADuLoIbCDXgZLq5g1hZFfkjFKFA92uCY6FNuuqULWwxiIfNKJtL+O93OfMgP/kymBKb
         FLXEytZgwIdaQfC+bpt94v3564T2PzygnZ6WIhQUVbXHRnECi9aDtOjOwySia7KchcEi
         Wh4FhtdnnrGD7vhd8VEBDoZRLpysPaIC+mgGE4YDQEajcyV0zj5NgQxLThOHaysVux+g
         Yy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557385; x=1695162185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL9z8xf3gSxSE5MtV355yS3vcK6eRahCEwpG0o67ud8=;
        b=nJtXF5q6ERFC/NCHy1b+S6wkROUpeN2/jrsYEZBBlyYPYqFHFCS5WkS8QUBa0Y2dCO
         9TmiiUzeSJC075PFSbL8zrtm00Zgk//HoMgdIUF4Qboyhyc8uxGk+fmbXHmtR4N5s96X
         GgJq5tryCmNZ3Y68wU8ktnQa/VZYGIKfJjADG/BBkWaH1c4XXAYqr93oot7IiyItjsH1
         MLfrhz8L7GeoAp/QMk3NdMODt7phZaEx3snANehC/kuL5FtSZ3cIovlCDfq6Ntm/X49o
         +CzqNZTHOyEcI9XPLj1IyIHcJBX4uTrTZm4T4KZFd2DqU58ra+WVf25QZXyGuo4Lk+cJ
         QCHw==
X-Gm-Message-State: AOJu0YyY9ncRDmmN7Wgo+lurvZsMR+r5mC8Qc0o8fsPJrwjfdV2AUVuB
        YKpP7rb2REZkS4bqyOO/Xo0=
X-Google-Smtp-Source: AGHT+IH/WQiedIfPOq2mCL7puezc84DhJ8gmimrWY8YF84EfM/IffUf2ZWll8QkF9UF2tAlIWR5EZQ==
X-Received: by 2002:a17:906:5398:b0:9a1:be50:ae61 with SMTP id g24-20020a170906539800b009a1be50ae61mr431077ejo.69.1694557385098;
        Tue, 12 Sep 2023 15:23:05 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709062e9800b009a19701e7b5sm7367014eji.96.2023.09.12.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:23:04 -0700 (PDT)
Date:   Wed, 13 Sep 2023 01:23:02 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/8] net: dsa: vsc73xx: Add bridge support
Message-ID: <20230912222302.jxolk3t74vbgr35s@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-9-paweldembicki@gmail.com>
 <20230912122201.3752918-9-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912122201.3752918-9-paweldembicki@gmail.com>
 <20230912122201.3752918-9-paweldembicki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:22:02PM +0200, Pawel Dembicki wrote:
> This patch adds bridge support for vsc73xx driver.
> It introduce two functions for port_bridge_join and
> vsc73xx_port_bridge_leave handling.
> 
> Those functions implement forwarding adjust and use
> dsa_tag_8021q_bridge_* api for adjust VLAN configuration.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v3:
>   - All vlan commits was reworked
>   - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
>   - drop vlan table upgrade
> v2:
>   - no changes done
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 72 ++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index bf903502bac1..9d0367c2c52c 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -600,6 +600,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  
>  	dev_info(vsc->dev, "set up the switch\n");
>  
> +	ds->untag_bridge_pvid = true;
> +	ds->max_num_bridges = 7;

Can you please refactor this into DSA_TAG_8021Q_MAX_NUM_BRIDGES and use
it in sja1105 too?

> +
>  	/* Issue RESET */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
>  		      VSC73XX_GLORESET_MASTER_RESET);
> @@ -1456,6 +1459,73 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
>  	return vsc73xx_update_vlan_table(vsc, port, vid, 0);
>  }
>  
> +static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
> +{
> +	int i;
> +
> +	for (i = 0; i < vsc->ds->num_ports; i++) {
> +		u32 val;
> +
> +		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +			     VSC73XX_SRCMASKS + i, &val);
> +		/* update only if port is in forwarding state */
> +		if (val & VSC73XX_SRCMASKS_PORTS_MASK)
> +			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +					    VSC73XX_SRCMASKS + i,
> +					    VSC73XX_SRCMASKS_PORTS_MASK,
> +					    vsc->forward_map[i]);
> +	}
> +}

I suspect you'll have to rethink this. If you look at del_nbp() and dsa_port_bridge_leave(),
you'll see it goes through a few phases. First the bridge calls br_stp_disable_port(p),
then netdev_upper_dev_unlink(dev, br->dev) which invokes dsa_port_bridge_leave().
So at this stage, the port is in BR_STATE_DISABLED and ds->ops->port_stp_state_set()
duly notifies the driver of that.

Then, ds->ops->port_bridge_leave() gets called, and then, ds->ops->port_stp_state_set()
again, for the standalone port, in BR_STATE_FORWARDING.

So actually, the last to take effect upon the forwarding map is port_stp_state_set(),
not port_bridge_leave().

I suspect you can remove the vsc73xx_update_forwarding_map() and just
rely on the STP implementation, and fix that while you're at it.

On the other switch ports except the one on which the STP state is changing,
you can look at dp->stp_state. There needs to be an "administrative" forwarding
mask (determined by port_bridge_join and port_bridge_leave), and an "operational"
one (determined by STP states).

> +
> +static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
> +				    struct dsa_bridge bridge,
> +				    bool *tx_fwd_offload,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	int i;
> +
> +	*tx_fwd_offload = true;
> +
> +	for (i = 0; i < ds->num_ports; i++) {
> +		/* Add this port to the forwarding matrix of the
> +		 * other ports in the same bridge, and viceversa.
> +		 */
> +		if (!dsa_is_user_port(ds, i))
> +			continue;

	dsa_switch_for_each_user_port(other_dp, ds) please

it is a lower-complexity iteration over the port list, which should be
preferred over a for loop + any dsa_to_port() wrapper like dsa_is_user_port().

> +
> +		if (i == port)
> +			continue;
> +
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))

and "other_dp" here

> +			continue;
> +
> +		vsc->forward_map[port] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(i);
> +		vsc->forward_map[i] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(port);
> +	}
> +	vsc73xx_update_forwarding_map(vsc);
> +
> +	return dsa_tag_8021q_bridge_join(ds, port, bridge);
> +}
> +
> +static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
> +				      struct dsa_bridge bridge)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	int i;
> +
> +	/* configure forward map to CPU <-> port only */
> +	for (i = 0; i < vsc->ds->num_ports; i++) {
> +		if (i == CPU_PORT)
> +			continue;
> +		vsc->forward_map[i] &= VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(port);
> +	}
> +	vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
> +
> +	vsc73xx_update_forwarding_map(vsc);
> +	dsa_tag_8021q_bridge_leave(ds, port, bridge);
> +}
> +
>  static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
>  {
>  	struct vsc73xx *vsc = ds->priv;
> @@ -1557,6 +1627,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_sset_count = vsc73xx_get_sset_count,
>  	.port_enable = vsc73xx_port_enable,
>  	.port_disable = vsc73xx_port_disable,
> +	.port_bridge_join = vsc73xx_port_bridge_join,
> +	.port_bridge_leave = vsc73xx_port_bridge_leave,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
> -- 
> 2.34.1
> 

