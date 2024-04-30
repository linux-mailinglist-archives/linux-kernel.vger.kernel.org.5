Return-Path: <linux-kernel+bounces-163260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4668B67DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38E51F22BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149EC13C;
	Tue, 30 Apr 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThGrP9rU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A38BF0;
	Tue, 30 Apr 2024 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443283; cv=none; b=qO7euT9+O7QEX3eptwfHzebYFfGB8ouJlzulwHMdLrMC1ETrg+Ax968XgW4OMhVWuCqdCLTAo7jjWNX9FjjrEQanfs1shdrtAgL0NqXSDIPt8jWwMd+wBbyg4gPkKuun3xiDOZ6mV/rQgTnyhl6o5oNnKjv1/1Mg4mP5D0Eq0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443283; c=relaxed/simple;
	bh=FIilMgaRdUPaNn6QCuAfAl8l87+fZoiLcPoheYgRtVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aee7LMsvYj6cNlKeeXBbWTQ6m1+H7Qq9vobE/rMxXJ0j76X2fXSOG5sDoGT40qF7oDrXlCwuc86nzhOm5WXI8g6B4GoXG/LKpgXVazfOuTDRQJ5fM/sqPTaslNzU0qC0/l7I0qHPnuy4zSn7oRenWXKeum/UbesV28trY6qAN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThGrP9rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E1C116B1;
	Tue, 30 Apr 2024 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443282;
	bh=FIilMgaRdUPaNn6QCuAfAl8l87+fZoiLcPoheYgRtVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ThGrP9rUlZFkmUR02Uk4y9M16GQIf03bOK47sqbPD2tFiN4nnUwl8Ig+nhkubj3I0
	 e2I6nKpZKkqv+dI6ksjBOZ4BHSy2RKfRTf0snQ03B7flnVFuDnSj3HRUfwJnMsJQ2A
	 WGKXnVDPb7Y02XlQAjdjoMgXh5THdeOfsZHZXmrOAs6OXZs6YjEGU9bch8fb9MZmzC
	 i46M5R+5PWVGKgBfrWBFz3Q6G4NBLsGkapZKQssx0BjMLaBJD0+OPHEwbNC7Ph3He7
	 mQuHuvmcB1ADxhEEbBrS14NKYHLgfk6K0rhqrPYWIvBnrdIEjoJateGOiaMU9EnV9c
	 aaFhI7Q2ZVQgw==
Date: Mon, 29 Apr 2024 19:14:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [PATCH net-next v5 03/10] ethtool: Add an interface for
 flashing transceiver modules' firmware
Message-ID: <20240429191440.7b1182c3@kernel.org>
In-Reply-To: <20240424133023.4150624-4-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-4-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 16:30:16 +0300 Danielle Ratson wrote:
> +MODULE_FW_FLASH_ACT
> +===================
> +
> +Flashes transceiver module firmware.
> +
> +Request contents:
> +
> +  =======================================  ======  ===========================
> +  ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``     nested  request header
> +  ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME``  string  firmware image file name
> +  ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD``   u32     transceiver module password
> +  =======================================  ======  ===========================
> +
> +The firmware update process consists of three logical steps:
> +
> +1. Downloading a firmware image to the transceiver module and validating it.
> +2. Running the firmware image.
> +3. Committing the firmware image so that it is run upon reset.
> +
> +When flash command is given, those three steps are taken in that order.
> +
> +The ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME`` attribute encodes the firmware
> +image file name. The firmware image is downloaded to the transceiver module,
> +validated, run and committed.
> +
> +The optional ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD`` attribute encodes a password
> +that might be required as part of the transceiver module firmware update
> +process.
> +
> +The firmware update process can take several minutes to complete. Therefore,
> +during the update process notifications are emitted from the kernel to user
> +space updating it about the status and progress.

We should spell out that the request only kicks off the process.
devlink flashing blocks the netlink socket send() until it's completed,
and the notifications have to be received on another socket.
So someone who has devlink experience may expect the same behavior here.

> +Notification contents:
> +
> + +---------------------------------------------------+--------+----------------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``              | nested | reply header   |
> + +---------------------------------------------------+--------+----------------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS``              | u32    | status         |
> + +---------------------------------------------------+--------+----------------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG``          | string | status message |
> + +---------------------------------------------------+--------+----------------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_DONE``                | uint   | progress       |
> + +---------------------------------------------------+--------+----------------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``               | uint   | total          |
> + +---------------------------------------------------+--------+----------------+

> +enum {
> +	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
> +	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
> +	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
> +	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
> +	ETHTOOL_A_MODULE_FW_FLASH_PAD,

uint doesn't need pad, and pad is not specified in YAML, so 
the following attribute IDs will be all off by one in YNL.

> +	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u32 */
> +	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
> +	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* uint */
> +	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* uint */
> +
> +	/* add new constants above here */
> +	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
> +	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)

