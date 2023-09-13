Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9E79F1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjIMTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIMTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:07:06 -0400
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2A3170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:07:01 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id ADD0E300218;
        Thu, 14 Sep 2023 04:06:48 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info ADD0E300218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1694632009; bh=kVJeE+icuAC+Qx1WZYGwspbwRiRiM4tiNYeXnybUMW4=;
        h=Date:To:Cc:From:Subject:From;
        b=aghtpZ+GcwzcQCa0teVomRA0GAW5AuMu1YXGovCvm79xRlUPpzQ7a0Gx9IdNXzP/7
         JB+gPNIsH5sYDQLfm8JS44MHVXsT+FJ1P+a0KqNP6MCbYSZYsWxE9RLOHIaYrma3uB
         IItLUlrlvuMOlGX5fJalmnA8RLLYLB/H7/4n2OXc=
Message-ID: <1e783efe-8659-8be1-82b7-15186302e88c@soulik.info>
Date:   Thu, 14 Sep 2023 03:06:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
From:   Randy Li <ayaka@soulik.info>
Subject: USB: DMA: mapping existing buffer is not supported?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I was trying to understand why USB webcams (UVC) have to copy video data 
through the CPU (uvc_video_complete() schedules 
uvc_video_copy_data_work() for this purpose). During my investigation, I 
noticed that functions like|usb_sg_*() and |usb_buffer_*() are not 
available since kernel version 2.6.12.

I can comprehend that USB host controllers such as xHCI, commonly found 
in embedded implementations like dwc3, do not support IOMMU. However, 
this should not prevent them from operating on a contiguous buffer.

If the USB subsystem can no longer work with existing buffers, I propose 
that we consider removing the remaining documentation in the "Working 
with existing buffers" section of Documentation/driver-api/usb/dma.rst.

Sincerely

Randy

