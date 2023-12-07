Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F708086CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjLGLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjLGLet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:34:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022110C0;
        Thu,  7 Dec 2023 03:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701948895; x=1733484895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0e0ecIPjielu3IMg9w9+57qtFRSlZw6k9A5nrmNNudM=;
  b=E13MIFBYMQFsL8EYCwz269U++62FbhdUIjXWg5DLTZHmYQ8cSnyIsA5G
   eNupv8wyXNnMwBTh4vcavzWGZaUTeNUjEseq7WNjF2GrcHHANrKZ96Wj4
   vOt2l8HkIVkSy8vXaMAxVxyeYa6m5PQfiskSCHYxU9/pJINK0eWihXoXx
   nAICDwUJGk0WbnF5cjuGEod2cbq7fJayBQyanIMhMCIj90NW/H62dgEI/
   8swkn9vdjO06uL7QCyN49jegE4SYMFlr41DNvBb8K1mPY0jmihMkAYYJP
   6q+YEPQ3fRA0rMysLZxUhZYtH96Y7QsBTjrxyaQIBWtyGEznH0F+UQCeK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1098277"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1098277"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 03:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="775371126"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="775371126"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 07 Dec 2023 03:34:50 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Dec 2023 13:34:49 +0200
Date:   Thu, 7 Dec 2023 13:34:49 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        pmalani@chromium.org, bleung@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, badhri@google.com, tzungbi@kernel.org,
        utkarsh.h.patel@intel.com, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v1 01/10] usb: typec: bus: provide transmit type for
 alternate mode drivers
Message-ID: <ZXGt2drhV/K+qtTG@kuha.fi.intel.com>
References: <20231207090738.15721-12-rdbabiera@google.com>
 <20231207090738.15721-13-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207090738.15721-13-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 07, 2023 at 09:07:32AM +0000, RD Babiera wrote:
> Add enum tcpm_altmode_transmit_type that Alternate Mode drivers can use
> to communicate which SOP type to send a SVDM on to the tcpm, and that the
> tcpm can use to communicate a received SVDM' SOP type to the Alternate Mode
> drivers.
> 
> Update all typec_altmode_ops users to use tcpm_altmode_transmit_type, and
> drop all messages that are not TYPEC_ALTMODE_SOP. Default all calls that
> require sop_type as input to TYPEC_ALTMODE_SOP.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/platform/chrome/cros_typec_vdm.c | 12 +++++++++--
>  drivers/usb/typec/altmodes/displayport.c | 15 +++++++-------
>  drivers/usb/typec/bus.c                  | 17 ++++++++++------
>  drivers/usb/typec/class.c                |  2 +-
>  drivers/usb/typec/tcpm/tcpm.c            | 15 ++++++++------
>  drivers/usb/typec/ucsi/displayport.c     | 18 +++++++++++++---
>  include/linux/usb/typec_altmode.h        | 26 ++++++++++++++++++------
>  7 files changed, 74 insertions(+), 31 deletions(-)

<snip>

> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 28aeef8f9e7b..4d527d92457d 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -34,6 +34,16 @@ struct typec_altmode {
>  
>  #define to_typec_altmode(d) container_of(d, struct typec_altmode, dev)
>  
> +/**
> + * These are used by the Alternate Mode drivers to tell the tcpm to transmit
> + * over the selected SOP type, and are used by the tcpm to communicate the
> + * received VDM SOP type to the Alternate Mode drivers.
> + */
> +enum typec_altmode_transmit_type {
> +	TYPEC_ALTMODE_SOP,
> +	TYPEC_ALTMODE_SOP_PRIME,
> +};
> +
>  static inline void typec_altmode_set_drvdata(struct typec_altmode *altmode,
>  					     void *data)
>  {
> @@ -55,21 +65,25 @@ static inline void *typec_altmode_get_drvdata(struct typec_altmode *altmode)
>   * @activate: User callback for Enter/Exit Mode
>   */
>  struct typec_altmode_ops {
> -	int (*enter)(struct typec_altmode *altmode, u32 *vdo);
> -	int (*exit)(struct typec_altmode *altmode);
> +	int (*enter)(struct typec_altmode *altmode, u32 *vdo,
> +		     enum typec_altmode_transmit_type sop_type);
> +	int (*exit)(struct typec_altmode *altmode,
> +		    enum typec_altmode_transmit_type sop_type);
>  	void (*attention)(struct typec_altmode *altmode, u32 vdo);
>  	int (*vdm)(struct typec_altmode *altmode, const u32 hdr,
> -		   const u32 *vdo, int cnt);
> +		   const u32 *vdo, int cnt, enum typec_altmode_transmit_type sop_type);
>  	int (*notify)(struct typec_altmode *altmode, unsigned long conf,
>  		      void *data);
>  	int (*activate)(struct typec_altmode *altmode, int activate);
>  };
>  
> -int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
> -int typec_altmode_exit(struct typec_altmode *altmode);
> +int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo,
> +			enum typec_altmode_transmit_type sop_type);
> +int typec_altmode_exit(struct typec_altmode *altmode, enum typec_altmode_transmit_type sop_type);
>  int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
>  int typec_altmode_vdm(struct typec_altmode *altmode,
> -		      const u32 header, const u32 *vdo, int count);
> +		      const u32 header, const u32 *vdo, int count,
> +		      enum typec_altmode_transmit_type sop_type);
>  int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
>  			 void *data);
>  const struct typec_altmode *

Instead of forcing this change immediately on every existing user of
that API, why not supply separate API for the cable alt modes?

Although the SOP* communication is the same in most parts, at least
Attention (and probable some other messages too) is not valid with
cable plugs. So maybe it would be more clear to just separate SOP
communication from SOP Prime/Double Prime in the API?

So it would look something like this:

diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index bd41bc362ab0..2f7ae50585b1 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -75,6 +75,24 @@ int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
 const struct typec_altmode *
 typec_altmode_get_partner(struct typec_altmode *altmode);
 
+/**
+ * struct typec_cable_ops - Cable alternate mode operations vector
+ * @enter: Operations to be executed with Enter Mode Command
+ * @exit: Operations to be executed with Exit Mode Command
+ * @vdm: Callback for SVID specific commands
+ */
+struct typec_cable_ops {
+       int (*enter)(struct typec_altmode *altmode, enum typec_plug_index sop, u32 *vdo);
+       int (*exit)(struct typec_altmode *altmode, enum typec_plug_index sop);
+       int (*vdm)(struct typec_altmode *altmode, enum typec_plug_index sop,
+                  const u32 hdr, const u32 *vdo, int cnt);
+};
+
+int typec_cable_altmode_enter(struct typec_altmode *altmode, enum typec_plug_index sop, u32 *vdo);
+int typec_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop);
+int typec_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
+                           const u32 header, const u32 *vdo, int count);
+
 /*
  * These are the connector states (USB, Safe and Alt Mode) defined in USB Type-C
  * Specification. SVID specific connector states are expected to follow and


thanks,

-- 
heikki
