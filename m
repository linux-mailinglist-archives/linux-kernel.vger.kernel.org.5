Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4626B7FDA91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjK2O5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjK2O5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:57:03 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 06:57:09 PST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F6DBE;
        Wed, 29 Nov 2023 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701269830; x=1732805830;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=xjxoK83vet1mIKAXJBVjtUZAKs/CZNfXjuPi3R8lz6w=;
  b=KFVbs5fqwmLRtSFk2L7MFewkygL26Lt/M+I+bxr2CxiAjyg6wrS/fesp
   ezojIklD0gT5x+2BUwhB6z/QL2pOYP1O3wExF9HvjsEARiSa6YDuWTlGZ
   172RDxUWHChhhgx+1x/+MeGWOa4DSGPRI40/+iFTnAQobInvEgb4+JeZx
   Aw8gWuP2jBkKEHtTLqQ/UKW9HkriGll+iiRz80s132Kh/iXRbPVZsUPpy
   jBVTIube067fdhGzm5B2xHTefdWQ0qRg7doWa3jajDMJwV42/DYNLUuJo
   sIwwqSq1tc0NjY0v2ed+1c5F3/C6cG/Z0fU4PZ54Bja06HBfTqNzis8JZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="159742"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="159742"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="912879560"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="912879560"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2023 06:56:05 -0800
Message-ID: <0d6880a5-0cf4-9961-97ab-04777cccd9ed@linux.intel.com>
Date:   Wed, 29 Nov 2023 16:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Kuen-Han Tsai <khtsai@google.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
References: <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com>
 <20231128140141.1161490-1-mathias.nyman@linux.intel.com>
 <CAKzKK0psOFJdBsPkqdRi4_5V=5z9XMnFPCYbcE1Nj6A1zj8Gmw@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFT PATCH 1/2] xhci: Reconfigure endpoint 0 max packet size only
 during endpoint reset
In-Reply-To: <CAKzKK0psOFJdBsPkqdRi4_5V=5z9XMnFPCYbcE1Nj6A1zj8Gmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +       ep_index = xhci_get_endpoint_index(&host_ep->desc);
>> +
>> +       /*
>> +        * Usb core assumes a max packet value for ep0 on FS devices until the
>> +        * real value is read from the descriptor. Core resets Ep0 if values
>> +        * mismatch. Reconfigure the xhci ep0 endpoint context here in that case
>> +        */
>> +       if (usb_endpoint_xfer_control(&host_ep->desc) && ep_index == 0) {
>> +               udev = container_of(host_ep, struct usb_device, ep0);
>> +               if (udev->speed == USB_SPEED_FULL)
>> +                       xhci_check_ep0_maxpacket(xhci, xhci->devs[udev->slot_id]);
>> +               /* Nothing else should be done here for ep0 during ep reset */
>> +               return;
>> +       }
>> +
> 
> Could there be a race condition between the xhci_endpoint_reset() and
> xhci_free_dev() functions, resulting in the xhci->devs[udev->slot_id]
> becoming null?
> If so, a null pointer dereference will happen in
> xhci_check_ep0_maxpacket() when accessing vdev->out_ctx.

should not race. xhci_free_dev() and xhci_endpoint_reset() for endpoint 0 should only
be called by hub driver hub_free_dev() and usb_ep0_reinit() respectively.

Hub driver takes care of concurrency for these

Thanks
Mathias

