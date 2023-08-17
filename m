Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7C77F840
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351652AbjHQODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351682AbjHQOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:03:28 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8F4E030DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:19 -0700 (PDT)
Received: (qmail 475129 invoked by uid 1000); 17 Aug 2023 10:03:18 -0400
Date:   Thu, 17 Aug 2023 10:03:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>, mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current
 wakeup on system suspend
Message-ID: <cc190b72-03cc-400b-9dc4-abef21562eff@rowland.harvard.edu>
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cc271e17-6204-b610-b40e-5c882ad6be36@suse.com>
 <ef189a18-98ba-52c9-13a3-ce8531fc18cf@linux.intel.com>
 <CAAd53p67m3o1nz3cKjiSJWDMWnsoB-4=pFWwBhpaoZ+ns22-tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p67m3o1nz3cKjiSJWDMWnsoB-4=pFWwBhpaoZ+ns22-tw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:13:55PM +0800, Kai-Heng Feng wrote:
> On Thu, Aug 17, 2023 at 8:52 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
> >
> > On 17.8.2023 14.18, Oliver Neukum wrote:
> > > On 17.08.23 11:33, Kai-Heng Feng wrote:
> > >
> > > Hi,
> > >
> > >> So for system-wide suspend, also disable connect, disconnect and
> > >> over-current wakeup to prevent spurious wakeup.
> > >
> > > isn't this breaking the ability to effectively use your root hub
> > > as a source of system wakeups? That is, even if you want the
> > > system to wake up if somebody attaches a new device, it no longer works?
> > >
> >
> > I got the same concern about this.
> 
> Per my test, it doesn't work with or without this change. This applies
> to disconnection too, disconnecting USB devices doesn't wake the
> system up.
> Furthermore, if the newly attached device is a USB keyboard, pressing
> it doesn't wake the system up either. Probably because remote wakeup
> isn't configured when the system is suspended.

If remote wakeup isn't enabled then the do_wakeup variable will be 0, 
so your patch wouldn't make any difference.  The question is what 
happens when remote wakeup _is_ enabled.

Did you check the settings in the controller's and root hub's 
power/wakeup sysfs files?

Alan Stern
