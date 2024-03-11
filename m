Return-Path: <linux-kernel+bounces-98963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F38781A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A2828AB11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0D405D8;
	Mon, 11 Mar 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3I8PSNC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m/X9FrW4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h7P/JRPL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GdoZvGeh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCB2AEFA;
	Mon, 11 Mar 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167437; cv=none; b=lEB7o8p/6x81Dv2tBY7QMPcMfcVURQNeUsJiG4eYf0hIIAF67HtpoEkP5i8jKxqQGEdylD+BfRf53QGO7WBzkEWZCPQaUqJvymWUXNKzMqZXfV62E708MtJV/nxmfnIk/HpCWPuKODXJopgAvPUgNQv/6mbdTeVmA8kYm66CDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167437; c=relaxed/simple;
	bh=0T5pD3BoyrBhhkpaZHMx5I5i33glsJxmRqTm5YAj5ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SFscrY25+x9ro7TzCsekmSTcD57hYHFIO1AGwOpXBVvnUBZlOqOfAC3fqys4FaS9xlMMCbm9rhO05occDydTTK/TWlBew4JShRMlW6nx4zkraJSfpGJy1l8ut0Bs1Yl3AogKo/hhhOIPwcZsdx6glzxYNdBOhSOzoJSkDv/3s9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3I8PSNC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m/X9FrW4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h7P/JRPL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GdoZvGeh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D038734D40;
	Mon, 11 Mar 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710167432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WirrEh476Xt2ACesbhO1dQ1v2HIjjv+mDSb1ujrv7Y4=;
	b=N3I8PSNCjACrIQH43FSQta0Lm5/U//fGNY55hH4UHtzDlQNmwffvqmDOySBPgRFIHsfi6Q
	i3S7J83tkQZQkqcMYgzxrSTqV8MfucRU1pea8GgDkcDn0vwlKwRCkEH2bIC3uKQFQlPCDx
	TQBQj65gMCLB7wQ3UqxKzzOyMFuL1t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710167432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WirrEh476Xt2ACesbhO1dQ1v2HIjjv+mDSb1ujrv7Y4=;
	b=m/X9FrW4Rk56mGlDfIbDR6izUwRugpP8JKBMeaGa7Lcxo9voyePaCtMTzQg1FDZdy8XQyk
	oTNzNBeZgK4MDOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710167431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WirrEh476Xt2ACesbhO1dQ1v2HIjjv+mDSb1ujrv7Y4=;
	b=h7P/JRPLCOeiFdX+/zpp49E4smD4US3wLIRkjAQXjuQrEdhgqeHOXrS1FT2NA8+6h5PCKF
	bJtuvsFHHJtRsoESgH6y+v6qMj95yFTXvpY0QCuhmO1xBgVVH9NPwFG2mbr2iDvEdXr/x6
	tfUBATdL6Bmflz66PKtxxPIBvBRxd+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710167431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WirrEh476Xt2ACesbhO1dQ1v2HIjjv+mDSb1ujrv7Y4=;
	b=GdoZvGehJMzKjBz80XiAB20s7CcEX83cvrEJV58C37otoleaLi5m1gUgYmwTpThWzgQG4t
	NAunRnmGxucft5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED47A136BA;
	Mon, 11 Mar 2024 14:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /BDlNYYV72XebAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Mon, 11 Mar 2024 14:30:30 +0000
Message-ID: <48eb38be-41ea-4ce7-99b2-f26b328cdf19@suse.de>
Date: Mon, 11 Mar 2024 17:30:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: marvell: prestera: fix driver reload
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, taras.chornyi@plvision.eu,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, kory.maincent@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240311135112.2642491-1-enachman@marvell.com>
 <20240311135112.2642491-2-enachman@marvell.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240311135112.2642491-2-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="h7P/JRPL";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GdoZvGeh
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.de:dkim,bootlin.com:email,marvell.com:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,bootlin.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.30
X-Rspamd-Queue-Id: D038734D40
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org



On 3/11/24 16:51, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Driver rmmod after insmod would fail because of
> the following issues:
> 
> 1. API call to reset the switch HW and restart the
>    firmware CPU firmware code loading was missing in
>    driver removal code handler.
> 2. Timeout waiting for the firmware CPU firmware
>    loader code to start was too small.
> 
> Fix by adding API call to reset the switch HW and
> restart the firmware CPU firmware code loading when
> handling the driver removal procedure,
> increase the timeout waiting for this restart operation
> from 5 to 30 seconds.
> 
> Reported-by: Köry Maincent <kory.maincent@bootlin.com>
> Closes: https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7390/T/
> Signed-off-by: Elad Nachman <enachman@marvell.com>
Please add Fixes tag
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_hw.c   | 8 ++++++++
>  drivers/net/ethernet/marvell/prestera/prestera_hw.h   | 1 +
>  drivers/net/ethernet/marvell/prestera/prestera_main.c | 3 ++-
>  drivers/net/ethernet/marvell/prestera/prestera_pci.c  | 7 ++++++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> index fc6f7d2746e8..08de8b498e0a 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> @@ -21,6 +21,7 @@
>  enum prestera_cmd_type_t {
>  	PRESTERA_CMD_TYPE_SWITCH_INIT = 0x1,
>  	PRESTERA_CMD_TYPE_SWITCH_ATTR_SET = 0x2,
> +	PRESTERA_CMD_TYPE_SWITCH_RESET = 0x4,
>  
>  	PRESTERA_CMD_TYPE_PORT_ATTR_SET = 0x100,
>  	PRESTERA_CMD_TYPE_PORT_ATTR_GET = 0x101,
> @@ -1087,6 +1088,13 @@ void prestera_hw_switch_fini(struct prestera_switch *sw)
>  	WARN_ON(!list_empty(&sw->event_handlers));
>  }
>  
> +int prestera_hw_switch_reset(struct prestera_switch *sw)
> +{
> +	struct prestera_msg_common_req req;
> +
> +	return prestera_cmd(sw, PRESTERA_CMD_TYPE_SWITCH_RESET, &req.cmd, sizeof(req));
> +}
> +
>  int prestera_hw_switch_ageing_set(struct prestera_switch *sw, u32 ageing_ms)
>  {
>  	struct prestera_msg_switch_attr_req req = {
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.h b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
> index 0a929279e1ce..86217bea2ca0 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_hw.h
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
> @@ -150,6 +150,7 @@ struct prestera_neigh_info;
>  
>  /* Switch API */
>  int prestera_hw_switch_init(struct prestera_switch *sw);
> +int prestera_hw_switch_reset(struct prestera_switch *sw);
>  void prestera_hw_switch_fini(struct prestera_switch *sw);
>  int prestera_hw_switch_ageing_set(struct prestera_switch *sw, u32 ageing_ms);
>  int prestera_hw_switch_mac_set(struct prestera_switch *sw, const char *mac);
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> index 4fb886c57cd7..bcaa8ea27b49 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> @@ -1444,7 +1444,7 @@ static int prestera_switch_init(struct prestera_switch *sw)
>  err_router_init:
>  	prestera_netdev_event_handler_unregister(sw);
>  	prestera_hw_switch_fini(sw);
> -
> +	prestera_hw_switch_reset(sw);
>  	return err;
>  }
>  
> @@ -1463,6 +1463,7 @@ static void prestera_switch_fini(struct prestera_switch *sw)
>  	prestera_router_fini(sw);
>  	prestera_netdev_event_handler_unregister(sw);
>  	prestera_hw_switch_fini(sw);
> +	prestera_hw_switch_reset(sw);
>  	of_node_put(sw->np);
>  }
>  
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> index 35857dc19542..b75a263ad8cb 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> @@ -24,6 +24,11 @@
>  #define PRESTERA_FW_ARM64_PATH_FMT "mrvl/prestera/mvsw_prestera_fw_arm64-v%u.%u.img"
>  
>  #define PRESTERA_FW_HDR_MAGIC		0x351D9D06
> +/* Timeout waiting for prestera firmware CPU to reboot and
> + * restart the firmware loading software layer, hence becoming
> + * ready for the next firmware downloading phase:
> + */
> +#define PRESTERA_FW_READY_TIMEOUT_SECS	30
>  #define PRESTERA_FW_DL_TIMEOUT_MS	50000
>  #define PRESTERA_FW_BLK_SZ		1024
>  
> @@ -765,7 +770,7 @@ static int prestera_fw_load(struct prestera_fw *fw)
>  
>  	err = prestera_ldr_wait_reg32(fw, PRESTERA_LDR_READY_REG,
>  				      PRESTERA_LDR_READY_MAGIC,
> -				      5 * MSEC_PER_SEC);
> +				      PRESTERA_FW_READY_TIMEOUT_SECS * MSEC_PER_SEC);
>  	if (err) {
>  		dev_err(fw->dev.dev, "waiting for FW loader is timed out");
>  		return err;

