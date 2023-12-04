Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FD803296
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjLDM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:27:59 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070ACD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:28:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rA837-0006eT-9Q; Mon, 04 Dec 2023 13:27:45 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rA836-00DVyo-Lo; Mon, 04 Dec 2023 13:27:44 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rA836-005Du1-Ih; Mon, 04 Dec 2023 13:27:44 +0100
Date:   Mon, 4 Dec 2023 13:27:44 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 2/8] ethtool: Expand Ethernet Power Equipment
 with c33 (PoE) alongside PoDL
Message-ID: <20231204122744.GC981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 06:10:24PM +0100, Kory Maincent wrote:
> In the current PSE interface for Ethernet Power Equipment, support is
> limited to PoDL. This patch extends the interface to accommodate the
> objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> Equipment (PSE).
> 
> The following objects are now supported and considered mandatory:
> - IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus
> - IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> - IEEE 802.3-2022 30.9.1.2.1 aPSEAdminControl
> 
> To avoid confusion between "PoDL PSE" and "PoE PSE", which have similar
> names but distinct values, we have followed the suggestion of Oleksij
> Rempel and Andrew Lunn to maintain separate naming schemes for each,
> using c33 (clause 33) prefix for "PoE PSE".
> You can find more details in the discussion threads here:
> https://lore.kernel.org/netdev/20230912110637.GI780075@pengutronix.de/
> https://lore.kernel.org/netdev/2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch/
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thx!

> ---
> 
> Changes in v2:
> - Rename all the PoE variables and enum with a c33 prefix.
> - Add documentation, thanks to Oleksij for having written one.
> ---
>  Documentation/networking/pse-pd/introduction.rst | 73 ++++++++++++++++++++++++
>  include/linux/pse-pd/pse.h                       |  9 +++
>  include/uapi/linux/ethtool.h                     | 43 ++++++++++++++
>  include/uapi/linux/ethtool_netlink.h             |  3 +
>  4 files changed, 128 insertions(+)
> 
> diff --git a/Documentation/networking/pse-pd/introduction.rst b/Documentation/networking/pse-pd/introduction.rst
> new file mode 100644
> index 000000000000..e213083b9aff
> --- /dev/null
> +++ b/Documentation/networking/pse-pd/introduction.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Power Sourcing Equipment (PSE) in IEEE 802.3 Standard
> +=====================================================
> +
> +Overview
> +--------
> +
> +Power Sourcing Equipment (PSE) is essential in networks for delivering power
> +along with data over Ethernet cables. It usually refers to devices like
> +switches and hubs that supply power to Powered Devices (PDs) such as IP
> +cameras, VoIP phones, and wireless access points.
> +
> +PSE vs. PoDL PSE
> +----------------
> +
> +PSE in the IEEE 802.3 standard generally refers to equipment that provides
> +power alongside data over Ethernet cables, typically associated with Power over
> +Ethernet (PoE).
> +
> +PoDL PSE, or Power over Data Lines PSE, specifically denotes PSEs operating
> +with single balanced twisted-pair PHYs, as per Clause 104 of IEEE 802.3. PoDL
> +is significant in contexts like automotive and industrial controls where power
> +and data delivery over a single pair is advantageous.
> +
> +IEEE 802.3-2018 Addendums and Related Clauses
> +----------------------------------------------
> +
> +Key addenda to the IEEE 802.3-2018 standard relevant to power delivery over
> +Ethernet are as follows:
> +
> +- **802.3af (Approved in 2003-06-12)**: Known as PoE in the market, detailed in
> +  Clause 33, delivering up to 15.4W of power.
> +- **802.3at (Approved in 2009-09-11)**: Marketed as PoE+, enhancing PoE as
> +  covered in Clause 33, increasing power delivery to up to 30W.
> +- **802.3bt (Approved in 2018-09-27)**: Known as 4PPoE in the market, outlined
> +  in Clause 33. Type 3 delivers up to 60W, and Type 4 up to 100W.
> +- **802.3bu (Approved in 2016-12-07)**: Formerly referred to as PoDL, detailed
> +  in Clause 104. Introduces Classes 0 - 9. Class 9 PoDL PSE delivers up to ~65W
> +
> +Kernel Naming Convention Recommendations
> +----------------------------------------
> +
> +For clarity and consistency within the Linux kernel's networking subsystem, the
> +following naming conventions are recommended:
> +
> +- For general PSE (PoE) code, use "c33_pse" key words. For example:
> +  ``enum ethtool_c33_pse_admin_state c33_admin_control;``.
> +  This aligns with Clause 33, encompassing various PoE forms.
> +
> +- For PoDL PSE - specific code, use "podl_pse". For example:
> +  ``enum ethtool_podl_pse_admin_state podl_admin_control;`` to differentiate
> +  PoDL PSE settings according to Clause 104.
> +
> +Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Dependent Interface (MDI)
> +-------------------------------------------------------------------------------------------
> +
> +Clause 33 of the IEEE 802.3 standard defines the functional and electrical
> +characteristics of Powered Device (PD) and Power Sourcing Equipment (PSE).
> +These entities enable power delivery using the same generic cabling as for data
> +transmission, integrating power with data communication for devices such as
> +10BASE-T, 100BASE-TX, or 1000BASE-T.
> +
> +Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twisted-Pair Ethernet
> +-------------------------------------------------------------------------------------------
> +
> +Clause 104 of the IEEE 802.3 standard delineates the functional and electrical
> +characteristics of PoDL Powered Devices (PDs) and PoDL Power Sourcing Equipment
> +(PSEs). These are designed for use with single balanced twisted-pair Ethernet
> +Physical Layers. In this clause, 'PSE' refers specifically to PoDL PSE, and
> +'PD' to PoDL PD. The key intent is to provide devices with a unified interface
> +for both data and the power required to process this data over a single
> +balanced twisted-pair Ethernet connection.
> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> index 199cf4ae3cf2..be4e5754eb24 100644
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h
> @@ -17,9 +17,12 @@ struct pse_controller_dev;
>   *
>   * @podl_admin_control: set PoDL PSE admin control as described in
>   *	IEEE 802.3-2018 30.15.1.2.1 acPoDLPSEAdminControl
> + * @c33_admin_control: set PSE admin control as described in
> + *	IEEE 802.3-2022 30.9.1.2.1 acPSEAdminControl
>   */
>  struct pse_control_config {
>  	enum ethtool_podl_pse_admin_state podl_admin_control;
> +	enum ethtool_c33_pse_admin_state c33_admin_control;
>  };
>  
>  /**
> @@ -29,10 +32,16 @@ struct pse_control_config {
>   *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
>   * @podl_pw_status: power detection status of the PoDL PSE.
>   *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
> + * @c33_admin_state: operational state of the PSE
> + *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> + * @c33_pw_status: power detection status of the PSE.
> + *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
>   */
>  struct pse_control_status {
>  	enum ethtool_podl_pse_admin_state podl_admin_state;
>  	enum ethtool_podl_pse_pw_d_status podl_pw_status;
> +	enum ethtool_c33_pse_admin_state c33_admin_state;
> +	enum ethtool_c33_pse_pw_d_status c33_pw_status;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..1d1631f009fa 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -752,6 +752,49 @@ enum ethtool_module_power_mode {
>  	ETHTOOL_MODULE_POWER_MODE_HIGH,
>  };
>  
> +/**
> + * enum ethtool_c33_pse_admin_state - operational state of the PoDL PSE
> + *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> + * @ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN: state of PSE functions is unknown
> + * @ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED: PSE functions are disabled
> + * @ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED: PSE functions are enabled
> + */
> +enum ethtool_c33_pse_admin_state {
> +	ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN = 1,
> +	ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
> +	ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_pw_d_status - power detection status of the PSE.
> + *	IEEE 802.3-2022 30.9.1.1.3 aPoDLPSEPowerDetectionStatus:
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN: PSE status is unknown
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED: "The enumeration “disabled”
> + *	indicates that the PSE State diagram is in the state DISABLED."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING: "The enumeration “searching”
> + *	indicates the PSE State diagram is in a state other than those
> + *	listed."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING: "The enumeration
> + *	“deliveringPower” indicates that the PSE State diagram is in the
> + *	state POWER_ON."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_TEST: "The enumeration “test” indicates that
> + *	the PSE State diagram is in the state TEST_MODE."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_FAULT: "The enumeration “fault” indicates that
> + *	the PSE State diagram is in the state TEST_ERROR."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT: "The enumeration “otherFault”
> + *	indicates that the PSE State diagram is in the state IDLE due to
> + *	the variable error_condition = true."
> + */
> +enum ethtool_c33_pse_pw_d_status {
> +	ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN = 1,
> +	ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED,
> +	ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING,
> +	ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING,
> +	ETHTOOL_C33_PSE_PW_D_STATUS_TEST,
> +	ETHTOOL_C33_PSE_PW_D_STATUS_FAULT,
> +	ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT,
> +};
> +
>  /**
>   * enum ethtool_podl_pse_admin_state - operational state of the PoDL PSE
>   *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index 73e2c10dc2cc..ba805285e408 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -895,6 +895,9 @@ enum {
>  	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
>  	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
>  	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
> +	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
> +	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
>  
>  	/* add new constants above here */
>  	__ETHTOOL_A_PSE_CNT,
> 
> -- 
> 2.25.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
