Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223DE7FC192
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjK1N4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbjK1N4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:56:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D6E4;
        Tue, 28 Nov 2023 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701179796; x=1732715796;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=eKZ+oHzdq5IQfs4rf63+PspJWcdVwCcylQSqi2BI0ZU=;
  b=IbbUREWs5B0ZVr5HJXHTkTy7xqRR3vljPBah0jG3aMMkm9aM7O2mIkpH
   c1Zp8x2EBwyd/EOzGTGhJRa+v5CK6+E2BwuifSbyvJ7XEKxO3e/1pih2F
   18sk9dhOaFCWjA2+x1XjBV8RIpXQ823Ud9lyZDTVJrkeuUt0fHH632Y3X
   xtTfeddk+13k/QH5e5C/K75bZlRdpbHP/IM4k1kBhqxgTBX1MH/1JzsPB
   0P1ybvVkR/QKbKq8VIZg7HSiS4CDsbBWwWyy1Pm6WtjwWACXHe1FRMgjb
   gb+APc9gfZ7Oy/c7UZcP1KGMVAxGYB0w18RiSOEceSRMeoApeVIAev9CU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="479124872"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479124872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="797596580"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797596580"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2023 05:56:34 -0800
Message-ID: <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com>
Date:   Tue, 28 Nov 2023 15:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Kuen-Han Tsai <khtsai@google.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan Stern <stern@rowland.harvard.edu>
References: <20231117072131.2886406-1-khtsai@google.com>
 <a4a129a3-e271-acbb-949c-534a8e1627ee@linux.intel.com>
 <CAKzKK0rnx+tSFAj6N-U_vcAZ_5P=Hx_Kb97NFkdPMHs8dR3Ukw@mail.gmail.com>
 <a970f296-da67-9a80-ab2f-a94fd16e0fd9@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
In-Reply-To: <a970f296-da67-9a80-ab2f-a94fd16e0fd9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2023 17.33, Mathias Nyman wrote:
> On 18.11.2023 12.19, Kuen-Han Tsai wrote:
>> Hi Mathias
>>
>>>>        if (usb_endpoint_xfer_isoc(&urb->ep->desc))
>>>> @@ -1552,8 +1561,10 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>>>                num_tds = 1;
>>>>
>>>>        urb_priv = kzalloc(struct_size(urb_priv, td, num_tds), mem_flags);
>>> kzalloc with spinlock held, should preferably be moved outside lock, otherwise should use GFP_ATOMIC
>>
>> Thanks for pointing this out. I realize this patch is incorrect and it
>> is non-ideal to include many codes unrelated to xhci->devs[slot_id]
>> within the lock.
>>
>>> xhci_check_maxpacket() called here can't be called with spinlock held
>>
>> It appears that xhci_check_maxpacket() might potentially lead to a
>> deadlock later if a spinlock is held. Is this the concern you were
>> referring to? If not, please let me know if there are any other
>> potential issues that I may have missed, thanks!
> 
> xhci_check_maxpacket() will allocate memory, wait for completion, and use the same lock,
> so there are several issues here.
> 
> I actually think we shouldn't call xhci_check_maxpacket() at all while queuing urbs.
> 
> usb core knows when there was max packet size mismatch during enumeration.
> I think we should add a hook to the hcd that usb core can call in these cases

I moved the max packet checks away from xhci_urb_enqueue() and fixed up the locking.

I can't trigger the original issue, but I tested it by setting incorrect initial max packet
size values.

If you have the chance to test this with your setup I'd appreciate it.

patches found here:
git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_urb_enqueue_locking
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=fix_urb_enqueue_locking

I'll add them to this thread as well

thanks
Mathias

