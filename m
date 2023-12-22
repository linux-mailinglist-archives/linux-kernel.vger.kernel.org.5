Return-Path: <linux-kernel+bounces-9287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BD81C36C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94F81F259EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE266184C;
	Fri, 22 Dec 2023 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbeAXqnK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E23DF55;
	Fri, 22 Dec 2023 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28be52a85b9so982943a91.1;
        Thu, 21 Dec 2023 19:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703215430; x=1703820230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ooIBrF7TXq97Qb8qaHZw9wvGRh1S7hvjqM2SjhWdjs=;
        b=IbeAXqnKoqf+sPgQYdd8FbpczDNjfHe50hHyqQLw5smMP6SOH6kh6mREclUTuFLOWo
         I/xxu0oU5SYMIQLBHM/HSkdvdd0ELCPzWE6cPy/Zl3hq32z/iacl+ZxJQOzYm2NSnPbw
         ILiVDlMZwSg6PwlpaUane6dCq77m3SsGNeuswojbziXo9W1BeSOuUM3/umY2kQiamzOA
         HmPrJ6iCZsy6SoG/EreJaMbO0pFxEZyJovzyAKEqEkqc/oQKOiOlWPez7HBmVREl2/17
         M8UEbBb5qpszP2ZK8Lsim+kjHzIo8bWFcxWkjqySFUZq+4+vZZDxRMD9Ex5MfJ06tPFD
         fiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703215430; x=1703820230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ooIBrF7TXq97Qb8qaHZw9wvGRh1S7hvjqM2SjhWdjs=;
        b=oiwlRuF3YOH185F2ghp8YsJD0XiwLEdT63vvU8hOZeFc7vctAkRkcII8Fyya9u/wsk
         YXZPmUCEdyIMLjzBdxPzPlMqMXyc6qgsc72aFbQ4G4dxrKXCFYYajqOpmiaNtfhkNd+6
         wQGkZuu898HOD4aRc7GmrlRfFlxShjppShhlPbqI+qAqQfSuPlG+O5oebp0RPvOhnU1t
         ilR9MWRjp0iPUs4tIg6ELmZSp9Ei1kGxWOoNshR+m4HLz9Okt99cUKk9RatUYpqG0GgP
         jgHNd/wcvGupKDSjLCnI7c6NKe8zzhvyyuV0E354DYQlXkeqZ+eHL8ek+iujybHTXcIC
         930A==
X-Gm-Message-State: AOJu0Yx1o685tWlrRbkVSJex/K64uhts8g0iC6Ns9mOQ06sgd+fRVLG+
	sLcMyFZKJFuAfq/Wg/aPl8A=
X-Google-Smtp-Source: AGHT+IFPBmjMj/leMpU6TCWkkBb/ZdQtftoQm6JR7s+KRB5yQSQewKj/hhHew6mkyDnkR7QWaRiogA==
X-Received: by 2002:a17:90b:4b46:b0:28b:9618:5f04 with SMTP id mi6-20020a17090b4b4600b0028b96185f04mr514230pjb.20.1703215429793;
        Thu, 21 Dec 2023 19:23:49 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q61-20020a17090a754300b0028b41108ed9sm2789833pjk.50.2023.12.21.19.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:23:48 -0800 (PST)
Date: Fri, 22 Dec 2023 11:23:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Aahil Awatramani <aahila@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to
 include a Collecting State.
Message-ID: <ZYUBP6h3H6U5T8HG@Laptop-X1>
References: <20231221023650.3208767-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221023650.3208767-1-aahila@google.com>

Hi Aahil,

On Thu, Dec 21, 2023 at 02:36:50AM +0000, Aahil Awatramani wrote:
> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> the LACP MUX state machine for separated handling of an initial
> Collecting state before the Collecting and Distributing state. This
> enables a port to be in a state where it can receive incoming packets
> while not still distributing. This is useful for reducing packet loss when
> a port begins distributing before its partner is able to collect.
> Additionally this also brings the 802.3ad bonding driver's implementation
> closer to the LACP specification which already predefined this behaviour.
> 
> Note that the regular flow process in the kernel's bonding driver remains
> unaffected by this patch. The extension requires explicit opt-in by the
> user (in order to ensure no disruptions for existing setups) via netlink
> or sysfs support using the new bonding parameter lacp_extended_mux. The

Sysfs is deprecated. We should only use netlink API.

> default value for lacp_extended_mux is set to 0 so as to preserve existing
> behaviour.

As Jay said, please update the document for new parameter. It also would be
good to add a selftest in tools/testing/selftests/drivers/net/bonding to make
sure the Mux machine changes correctly. You can use scapy to send the partner
state. This could be used for both bonding/teaming testing, which is valuable.

> 
> Signed-off-by: Aahil Awatramani <aahila@google.com>
> ---
>  drivers/net/bonding/bond_3ad.c     | 155 +++++++++++++++++++++++++++--
>  drivers/net/bonding/bond_main.c    |  22 ++--
>  drivers/net/bonding/bond_netlink.c |  16 +++
>  drivers/net/bonding/bond_options.c |  26 ++++-
>  drivers/net/bonding/bond_sysfs.c   |  12 +++
>  include/net/bond_3ad.h             |   2 +
>  include/net/bond_options.h         |   1 +
>  include/net/bonding.h              |  33 ++++++
>  include/uapi/linux/if_link.h       |   1 +
>  tools/include/uapi/linux/if_link.h |   1 +
>  10 files changed, 254 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c99ffe6c683a..38a7aa6e4edd 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator *aggregator,
>  static void ad_clear_agg(struct aggregator *aggregator);
>  static void ad_initialize_agg(struct aggregator *aggregator);
>  static void ad_initialize_port(struct port *port, int lacp_fast);
> +static void ad_enable_collecting(struct port *port);
> +static void ad_disable_distributing(struct port *port,
> +				    bool *update_slave_arr);
>  static void ad_enable_collecting_distributing(struct port *port,
>  					      bool *update_slave_arr);
>  static void ad_disable_collecting_distributing(struct port *port,
> @@ -171,32 +174,64 @@ static inline int __agg_has_partner(struct aggregator *agg)
>  	return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
>  }
>  
> +/**
> + * __disable_distributing_port - disable the port's slave for distributing.
> + * Port will still be able to collect.
> + * @port: the port we're looking at
> + *
> + * This will disable only distributing on the port's slave.
> + */
> +static inline void __disable_distributing_port(struct port *port)
> +{
> +	bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
> +}
> +
> +/**
> + * __enable_collecting_port - enable the port's slave for collecting,
> + * if it's up
> + * @port: the port we're looking at
> + *
> + * This will enable only collecting on the port's slave.
> + */
> +static inline void __enable_collecting_port(struct port *port)
> +{
> +	struct slave *slave = port->slave;
> +
> +	if (slave->link == BOND_LINK_UP && bond_slave_is_up(slave))
> +		bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
> +}
> +
>  /**
>   * __disable_port - disable the port's slave
>   * @port: the port we're looking at
> + *
> + * This will disable both collecting and distributing on the port's slave.
>   */
>  static inline void __disable_port(struct port *port)
>  {
> -	bond_set_slave_inactive_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
> +	bond_set_slave_txrx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
>  }

Can we replace bond_set_slave_inactive_flags() directly?
bond_set_slave_inactive_flags() also checks the all_slaves_active parameter.
Please see more comments under bond_set_slave_txrx_disabled_flags() function.

>  
>  /**
>   * __enable_port - enable the port's slave, if it's up
>   * @port: the port we're looking at
> + *
> + * This will enable both collecting and distributing on the port's slave.
>   */
>  static inline void __enable_port(struct port *port)
>  {
>  	struct slave *slave = port->slave;
>  
>  	if ((slave->link == BOND_LINK_UP) && bond_slave_is_up(slave))
> -		bond_set_slave_active_flags(slave, BOND_SLAVE_NOTIFY_LATER);
> +		bond_set_slave_txrx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
>  }
>  
>  /**
> - * __port_is_enabled - check if the port's slave is in active state
> + * __port_is_collecting_distributing - check if the port's slave is in the
> + * combined collecting/distributing state
>   * @port: the port we're looking at
>   */
> -static inline int __port_is_enabled(struct port *port)
> +static inline int __port_is_collecting_distributing(struct port *port)
>  {
>  	return bond_is_active_slave(port->slave);
>  }
> @@ -942,6 +977,7 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
>   */
>  static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  {
> +	struct bonding *bond = __get_bond_by_port(port);
>  	mux_states_t last_state;
>  
>  	/* keep current State Machine state to compare later if it was
> @@ -999,9 +1035,13 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  			if ((port->sm_vars & AD_PORT_SELECTED) &&
>  			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
>  			    !__check_agg_selection_timer(port)) {
> -				if (port->aggregator->is_active)
> -					port->sm_mux_state =
> -					    AD_MUX_COLLECTING_DISTRIBUTING;
> +				if (port->aggregator->is_active) {
> +					int state = AD_MUX_COLLECTING_DISTRIBUTING;
> +
> +					if (bond->params.lacp_extended_mux)
> +						state = AD_MUX_COLLECTING;
> +					port->sm_mux_state = state;
> +				}
>  			} else if (!(port->sm_vars & AD_PORT_SELECTED) ||
>  				   (port->sm_vars & AD_PORT_STANDBY)) {
>  				/* if UNSELECTED or STANDBY */
> @@ -1031,7 +1071,52 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  				 */
>  				if (port->aggregator &&
>  				    port->aggregator->is_active &&
> -				    !__port_is_enabled(port)) {
> +				    !__port_is_collecting_distributing(port)) {
> +					__enable_port(port);
> +					*update_slave_arr = true;
> +				}
> +			}
> +			break;
> +		case AD_MUX_COLLECTING:
> +			if (!(port->sm_vars & AD_PORT_SELECTED) ||
> +			    (port->sm_vars & AD_PORT_STANDBY) ||
> +			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
> +			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {

Both AD_MUX_COLLECTING_DISTRIBUTING and AD_MUX_COLLECTING check these, maybe
we can add a function like port_should_mux_attached() to do the checks.

> +				port->sm_mux_state = AD_MUX_ATTACHED;
> +			} else if ((port->sm_vars & AD_PORT_SELECTED) &&
> +			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
> +			    (port->partner_oper.port_state & LACP_STATE_COLLECTING)) {
> +				port->sm_mux_state = AD_MUX_DISTRIBUTING;
> +			} else {
> +				/* If port state hasn't changed, make sure that a collecting
> +				 * port is enabled for an active aggregator.
> +				 */
> +				if (port->aggregator &&
> +				    port->aggregator->is_active) {
> +					struct slave *slave = port->slave;
> +
> +					if (bond_is_slave_rx_disabled(slave) != 0) {
> +						ad_enable_collecting(port);
> +						*update_slave_arr = true;
> +					}
> +				}
> +			}
> +			break;
> +		case AD_MUX_DISTRIBUTING:
> +			if (!(port->sm_vars & AD_PORT_SELECTED) ||
> +			    (port->sm_vars & AD_PORT_STANDBY) ||
> +			    !(port->partner_oper.port_state & LACP_STATE_COLLECTING) ||
> +			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
> +			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {

Is it possible that a port in DISTRIBUTING state while no LACP_STATE_SYNCHRONIZATION flag?
It should has this flag since COLLECTING.

> +				port->sm_mux_state = AD_MUX_COLLECTING;
> +			} else {
> +				/* if port state hasn't changed make
> +				 * sure that a collecting distributing
> +				 * port in an active aggregator is enabled
> +				 */
> +				if (port->aggregator &&
> +				    port->aggregator->is_active &&
> +				    !__port_is_collecting_distributing(port)) {
>  					__enable_port(port);
>  					*update_slave_arr = true;
>  				}
> @@ -1082,6 +1167,20 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  							  update_slave_arr);

...

> @@ -2763,11 +2766,14 @@ static void bond_miimon_commit(struct bonding *bond)
>  			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
>  						  BOND_SLAVE_NOTIFY_NOW);
>  
> -			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
> -			    BOND_MODE(bond) == BOND_MODE_8023AD)
> +			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP)
>  				bond_set_slave_inactive_flags(slave,
>  							      BOND_SLAVE_NOTIFY_NOW);
>  
> +			if (BOND_MODE(bond) == BOND_MODE_8023AD)
> +				bond_set_slave_txrx_disabled_flags(slave,
> +								   BOND_SLAVE_NOTIFY_NOW);
> +
>  			slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
>  
>  			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
> @@ -4276,8 +4282,12 @@ static int bond_open(struct net_device *bond_dev)
>  		bond_for_each_slave(bond, slave, iter) {
>  			if (bond_uses_primary(bond) &&
>  			    slave != rcu_access_pointer(bond->curr_active_slave)) {
> -				bond_set_slave_inactive_flags(slave,
> -							      BOND_SLAVE_NOTIFY_NOW);
> +				if (BOND_MODE(bond) == BOND_MODE_8023AD)

The bond_uses_primary() only returns true for ab/tlb/alb mode, there won't be
8023ad mode.

> +					bond_set_slave_txrx_disabled_flags(slave,
> +									   BOND_SLAVE_NOTIFY_NOW);
> +				else
> +					bond_set_slave_inactive_flags(slave,
> +								      BOND_SLAVE_NOTIFY_NOW);
>  			} else if (BOND_MODE(bond) != BOND_MODE_8023AD) {
>  				bond_set_slave_active_flags(slave,
>  							    BOND_SLAVE_NOTIFY_NOW);

...

>  
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 5b8b1b644a2d..b31880d53d76 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -148,6 +148,7 @@ struct bond_params {
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>  #endif
> +	int lacp_extended_mux;
>  
>  	/* 2 bytes of padding : see ether_addr_equal_64bits() */
>  	u8 ad_actor_system[ETH_ALEN + 2];
> @@ -167,6 +168,7 @@ struct slave {
>  	u8     backup:1,   /* indicates backup slave. Value corresponds with
>  			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
>  	       inactive:1, /* indicates inactive slave */
> +	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
>  	       should_notify:1, /* indicates whether the state changed */
>  	       should_notify_link:1; /* indicates whether the link changed */
>  	u8     duplex;
> @@ -570,6 +572,19 @@ static inline void bond_set_slave_inactive_flags(struct slave *slave,
>  		slave->inactive = 1;
>  }
>  
> +static inline void bond_set_slave_txrx_disabled_flags(struct slave *slave,
> +						 bool notify)
> +{
> +	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> +	slave->rx_disabled = 1;
> +}

The bond_set_slave_inactive_flags() also has all_slaves_active() checks.
I don't think you can replace all the bond_set_slave_inactive_flags() to this one directly.
How about update the bond_set_slave_inactive_flags() with a 8023ad check, e.g.

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..ab70c46119a0 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -568,6 +568,8 @@ static inline void bond_set_slave_inactive_flags(struct slave *slave,
                bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
        if (!slave->bond->params.all_slaves_active)
                slave->inactive = 1;
+       if (BOND_MODE(slave->bond) == BOND_MODE_8023AD)
+               slave->rx_disabled = 1;
 }

Thanks
Hangbin

