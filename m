Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059378DED5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbjH3TWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbjH3JkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:40:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DEC3137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:40:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2F52F4;
        Wed, 30 Aug 2023 02:40:40 -0700 (PDT)
Received: from bogus (unknown [10.57.36.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C39DF3F64C;
        Wed, 30 Aug 2023 02:39:59 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:39:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: arm_scmi: Fix NULL pointer dereference in
 mailbox_clear_channel
Message-ID: <20230830093902.duvvjimgwddh7qbt@bogus>
References: <ED5DC8DB-AE81-4380-8AE5-588F370CD4B0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED5DC8DB-AE81-4380-8AE5-588F370CD4B0@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:07:47AM +0800, Qiujun Huang wrote:
> There is a race between the failure of probe and rx_callback (due to a
> delayed response).
> 
> scmi_probe
> scmi_acquire_protocal
> do_xfer
>  timeout
> mailbox_chan_free
>                                                     <--- delay response
>                                                            rx_callback
> mbox_free_channel
> cinfo->transport_info = NULL
>                                                           mailbox_clear_channel
>                                                          dereference cinfo->transport_info

It is always good to provide the kernel stacktrace which you get when a
NULL pointer is dereference. It helps for review and also to document it.

-- 
Regards,
Sudeep
