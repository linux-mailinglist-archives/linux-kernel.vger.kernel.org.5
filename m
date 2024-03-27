Return-Path: <linux-kernel+bounces-120745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B128488DC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690E01F2D145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE35D498;
	Wed, 27 Mar 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtI81To/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECC29CF8;
	Wed, 27 Mar 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538531; cv=none; b=pNj0KCK3CYYI8K28aXLlxH/dV5L3dAGEyoCauHxUg69foVigdAg5Kv5qzL5Qr7LPk49kKdtJL/n1H4zz4hK7nU7swoG35W3lK/duZBdufU1QsVO7dwZQ0GRCPJrgmgOdYUX6Duca415nGkOyFumkDE01KMVuihLfik0KoC6MgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538531; c=relaxed/simple;
	bh=J7zAHuGREnCdBItMrYt7Dp5Z+38Lf4Gu8Jhy9frF4P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb3G10UqDpHde7d646buLMqhgg7+gV5w6OUReVpwLNeM8EotwBKqlyRcrWbjqOOcCgbMou+cAsDPl5i+QrhmCarPIbjEpgmFTwyBc5A0eP1DNBZr7jG9z7eM3UF3yMIovJDQAg1DKgrTM4FlcHuU9R6bqEm3jPZ1mVpji1cBRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtI81To/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711538529; x=1743074529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J7zAHuGREnCdBItMrYt7Dp5Z+38Lf4Gu8Jhy9frF4P4=;
  b=jtI81To/3Js3GMJZvuBSs/taLJz/t2cRUhaI+QznGDjoiIPrRlgb/QFY
   fPuX31iG5gU8+B6j10yPFTEeufVqsZpas92cFKZYtfhuIT1Yww2St7cwJ
   gnxrC+Le3xpcoyyHX790j2kNYGnj68GyOeRQ97To0Q78leHGyZiAN9tBB
   NLs8Ac++4ikUkyy0JuVjg+g48nh0l44qGNeymRjfjEbQ+nBW0n6S7+4X0
   O7gdm0Z5nFP//RIz26QzJ+A3je8oZ2yKcK3FIR297saJxjLKRmgqK+rsv
   x/IIyD/E/9j+k5v0HziLfD9Ud9RJ2uDa6Opz+4rog9J8HCZEQE7L3WrRB
   g==;
X-CSE-ConnectionGUID: LzhkCbZiSLWIqoufyptVtg==
X-CSE-MsgGUID: I5fP53PpREOCAoV5JOIiwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17361966"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17361966"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 04:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937074467"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="937074467"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Mar 2024 04:22:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Mar 2024 13:22:04 +0200
Date: Wed, 27 Mar 2024 13:22:04 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Import interface for UCSI
 transport
Message-ID: <ZgQBXFzuZLJcmH4h@kuha.fi.intel.com>
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
 <20240325-public-ucsi-h-v2-2-a6d716968bb1@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-public-ucsi-h-v2-2-a6d716968bb1@chromium.org>

On Mon, Mar 25, 2024 at 11:42:26PM +0000, Pavan Holla wrote:
> Import include/linux/usb/ucsi.h and remove any duplicate declarations.
> 
> Signed-off-by: Pavan Holla <pholla@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.h | 54 +------------------------------------------
>  1 file changed, 1 insertion(+), 53 deletions(-)

I'm pretty sure somebody already told you to merge this into 1/3, so
why haven't you done that?


> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 32daf5f58650..167951538030 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -10,22 +10,13 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/pd.h>
>  #include <linux/usb/role.h>
> +#include <linux/usb/ucsi.h>
>  #include <asm/unaligned.h>
>  
>  /* -------------------------------------------------------------------------- */
>  
> -struct ucsi;
> -struct ucsi_altmode;
>  struct dentry;
>  
> -/* UCSI offsets (Bytes) */
> -#define UCSI_VERSION			0
> -#define UCSI_CCI			4
> -#define UCSI_CONTROL			8
> -#define UCSI_MESSAGE_IN			16
> -#define UCSI_MESSAGE_OUT		32
> -#define UCSIv2_MESSAGE_OUT		272
> -
>  /* UCSI versions */
>  #define UCSI_VERSION_1_2	0x0120
>  #define UCSI_VERSION_2_0	0x0200
> @@ -42,48 +33,6 @@ struct dentry;
>   */
>  #define UCSI_SPEC_REVISION_TO_BCD(_v_)  (((_v_) + 1) << 8)
>  
> -/* Command Status and Connector Change Indication (CCI) bits */
> -#define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
> -#define UCSI_CCI_LENGTH(_c_)		(((_c_) & GENMASK(15, 8)) >> 8)
> -#define UCSI_CCI_NOT_SUPPORTED		BIT(25)
> -#define UCSI_CCI_CANCEL_COMPLETE	BIT(26)
> -#define UCSI_CCI_RESET_COMPLETE		BIT(27)
> -#define UCSI_CCI_BUSY			BIT(28)
> -#define UCSI_CCI_ACK_COMPLETE		BIT(29)
> -#define UCSI_CCI_ERROR			BIT(30)
> -#define UCSI_CCI_COMMAND_COMPLETE	BIT(31)
> -
> -/**
> - * struct ucsi_operations - UCSI I/O operations
> - * @read: Read operation
> - * @sync_write: Blocking write operation
> - * @async_write: Non-blocking write operation
> - * @update_altmodes: Squashes duplicate DP altmodes
> - *
> - * Read and write routines for UCSI interface. @sync_write must wait for the
> - * Command Completion Event from the PPM before returning, and @async_write must
> - * return immediately after sending the data to the PPM.
> - */
> -struct ucsi_operations {
> -	int (*read)(struct ucsi *ucsi, unsigned int offset,
> -		    void *val, size_t val_len);
> -	int (*sync_write)(struct ucsi *ucsi, unsigned int offset,
> -			  const void *val, size_t val_len);
> -	int (*async_write)(struct ucsi *ucsi, unsigned int offset,
> -			   const void *val, size_t val_len);
> -	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
> -				struct ucsi_altmode *updated);
> -};
> -
> -struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);
> -void ucsi_destroy(struct ucsi *ucsi);
> -int ucsi_register(struct ucsi *ucsi);
> -void ucsi_unregister(struct ucsi *ucsi);
> -void *ucsi_get_drvdata(struct ucsi *ucsi);
> -void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
> -
> -void ucsi_connector_change(struct ucsi *ucsi, u8 num);
> -
>  /* -------------------------------------------------------------------------- */
>  
>  /* Commands */
> @@ -465,7 +414,6 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
>  		      void *retval, size_t size);
>  
>  void ucsi_altmode_update_active(struct ucsi_connector *con);
> -int ucsi_resume(struct ucsi *ucsi);
>  
>  #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  int ucsi_register_port_psy(struct ucsi_connector *con);
> 
> -- 
> 2.44.0.396.g6e790dbe36-goog

-- 
heikki

