Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B47FDBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjK2Pks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjK2Pkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:40:40 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2829FD46
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:40:44 -0800 (PST)
Received: (qmail 206768 invoked by uid 1000); 29 Nov 2023 10:40:43 -0500
Date:   Wed, 29 Nov 2023 10:40:43 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <51cb747a-21fe-4b3b-9567-01b9cc9d8873@rowland.harvard.edu>
References: <20231129151618.455618-1-jtornosm@redhat.com>
 <f684feac-2941-4407-846b-2d984daca733@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f684feac-2941-4407-846b-2d984daca733@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:33:58PM +0100, Oliver Neukum wrote:
> On 29.11.23 16:16, Jose Ignacio Tornos Martinez wrote:
> 
> Hi,
> 
> > The reason is that although the device is detached, normal stop and
> > unbind operations are commanded. Avoid these unnecessary operations
> > when the device is detached (state is USB_STATE_NOTATTACHED) so as
> > not to get the error messages.
> 
> I am sorry, but this is a layering violation. You are looking
> at an internal state of the USB layer to surpress logging
> -ENODEV. If you think these messages should go away, filter
> for ENODEV where they are generated.

Indeed.

In addition, you should be more careful about the distinction between 
"unbound" and "disconnected".  It's possible for the driver to be 
unbound from the device even while the device is still plugged in.  In 
this situation, submitting URBs will fail with an error even though the 
device state isn't USB_STATE_NOTATTACHED.

Alan Stern
