Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E47D960E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0LL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0LL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:11:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7079C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:11:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2443C433C7;
        Fri, 27 Oct 2023 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698405114;
        bh=JQLXJ4o35od5EHLfavT645Y6xMQ3NmPP91bkAvMHzkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1TGYd9oavUJt+N4a5gBeGcpL3pQW2QEUG4TdutySzLtnoXuhLf2W4D3I6H5YLRx2L
         YLRIYUKBV0msC4U01P4NbrzAUrCVJHEsVOLv49jWJM24tcPc43sJKwEPu2v6e1rNqU
         DFZBnek4PMMoe+xeA3V23jHIDwD5+dUSAXor9Cuk=
Date:   Fri, 27 Oct 2023 13:11:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Wang <quic_yyuwang@quicinc.com>
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Message-ID: <2023102730-twins-thieving-d04e@gregkh>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:55:21PM -0700, Yu Wang wrote:
> With sample code as below, it may hit use-after-free issue when
> releasing devcd device.
> 
>     struct my_coredump_state {
>         struct completion dump_done;
>         ...
>     };
> 
>     static void my_coredump_free(void *data)
>     {
>         struct my_coredump_state *dump_state = data;
>         ...
>         complete(&dump_state->dump_done);
>     }
> 
>     static void my_dev_release(struct device *dev)
>     {
>         kfree(dev);
>     }
> 
>     static void my_coredump()
>     {
>         struct my_coredump_state dump_state;
>         struct device *new_device =
>             kzalloc(sizeof(*new_device), GFP_KERNEL);
> 
>         ...
>         new_device->release = my_dev_release;
>         device_initialize(new_device);
>         ...
>         device_add(new_device);
>         ...
>         init_completion(&dump_state.dump_done);
>         dev_coredumpm(new_device, NULL, &dump_state, datalen, GFP_KERNEL,
>                       my_coredump_read, my_coredump_free);
>         wait_for_completion(&dump_state.dump_done);
>         device_del(new_device);
>         put_device(new_device);
>     }

Is there any in-kernel user like this?  If so, why not fix them up to
not do this?

thanks,

greg k-h
