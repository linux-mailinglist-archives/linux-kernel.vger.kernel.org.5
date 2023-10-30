Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778087DB868
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjJ3Koa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJ3Ko1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:44:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316293;
        Mon, 30 Oct 2023 03:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698662665; x=1730198665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZxTiS3n9c+dLuwiOxzBYG2XPaKzbhKXIWkl4Mm9Y51c=;
  b=AT7XxsYF2uFiMM5M32v2PwK0sV3n0npEQl0VRZXYH8k4sE/7tv9+QPVW
   hwc5nv2WvAyURB0QlsRf40S04rpUDlAy4KhNMLkLJMtVYdsHMwfNt/aF/
   o1e6BXvKZefh8ypsJLtQO3ho9s0Adgh6Y4iYUbiGA5WQQ2RnSQNjIhJLE
   Pkk8BrE46eAX2loOU3LrPk+iW+nPEtZocdOaSwlayV+GYp+ZBWibKai6r
   gVtByvtZ/Fg9jCLJm/hsdVs0cGjQnqAJnXJKFaKkYnDwF1gedZqI/wQNW
   kx2olk6jIwCm0uitYI99xBasHo5ECbYSHrwQSUBls2nsGZKnsXSTVVRKY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="419160938"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="419160938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 03:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="903951500"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="903951500"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2023 03:44:22 -0700
Message-ID: <aa328f6d-be12-45ef-42dd-2b4dc0821771@linux.intel.com>
Date:   Mon, 30 Oct 2023 12:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/2] usb: xhci: Add timeout argument in address_device
 USB HCD callback
Content-Language: en-US
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, s.shtylyov@omp.ru
References: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2023 18.20, Hardik Gajjar wrote:
> - The HCD address_device callback now accepts a user-defined timeout value
>    in milliseconds, providing better control over command execution times.
> - The default timeout value for the address_device command has been set
>    to 5000 ms, aligning with the USB 3.2 specification. However, this
>    timeout can be adjusted as needed.
> - The xhci_setup_device function has been updated to accept the timeout
>    value, allowing it to specify the maximum wait time for the command
>    operation to complete.
> - The hub driver has also been updated to accommodate the newly added
>    timeout parameter during the SET_ADDRESS request.
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>

For the xhci parts

Reviewed-by: Mathias Nyman <mathias.nyman@linux.intel.com>


