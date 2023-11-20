Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F17F175E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjKTPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjKTPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:32:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495DC8;
        Mon, 20 Nov 2023 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700494330; x=1732030330;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=yzidrUEMCUcbFArGAxx+rdrshE4gppTFAhlR8SrrLjA=;
  b=WuYOW1vF4qVKdsSZjGzkvpRblDOvmfnXcqQ+1UkGPpqkyEByuConDx+0
   TF3oDQmGijhPLKd15tejBVH8cIV7F1LgPmjLZ8rnNkqD5QlkjTD0jvpnI
   XYMOa8w9jQMf2Jrbuh8NgcgxLcEK56660NY+sL55twSBqgg9tkUoOeua1
   DjdiSonQV52VCzbpLw1VeNlaUlTNCYujoVnOVk2VG5ETSLHL+fGO4Yjbd
   pR+aGNxLau5AEKZktP7cbHS1foZMIvPq/ssZZ6BcQW/6/sG9t9I0kZ7Uh
   q1woaSffJhe4R4x6eEqxmluuWWrub+mXvb8MKuJN+wvJYMzGQPdxhMD8A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371815232"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371815232"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836760404"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="836760404"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 07:32:08 -0800
Message-ID: <a970f296-da67-9a80-ab2f-a94fd16e0fd9@linux.intel.com>
Date:   Mon, 20 Nov 2023 17:33:23 +0200
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
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
In-Reply-To: <CAKzKK0rnx+tSFAj6N-U_vcAZ_5P=Hx_Kb97NFkdPMHs8dR3Ukw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2023 12.19, Kuen-Han Tsai wrote:
> Hi Mathias
> 
>>>        if (usb_endpoint_xfer_isoc(&urb->ep->desc))
>>> @@ -1552,8 +1561,10 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>>                num_tds = 1;
>>>
>>>        urb_priv = kzalloc(struct_size(urb_priv, td, num_tds), mem_flags);
>> kzalloc with spinlock held, should preferably be moved outside lock, otherwise should use GFP_ATOMIC
> 
> Thanks for pointing this out. I realize this patch is incorrect and it
> is non-ideal to include many codes unrelated to xhci->devs[slot_id]
> within the lock.
> 
>> xhci_check_maxpacket() called here can't be called with spinlock held
> 
> It appears that xhci_check_maxpacket() might potentially lead to a
> deadlock later if a spinlock is held. Is this the concern you were
> referring to? If not, please let me know if there are any other
> potential issues that I may have missed, thanks!

xhci_check_maxpacket() will allocate memory, wait for completion, and use the same lock,
so there are several issues here.

I actually think we shouldn't call xhci_check_maxpacket() at all while queuing urbs.

usb core knows when there was max packet size mismatch during enumeration.
I think we should add a hook to the hcd that usb core can call in these cases

Thanks
Mathias

