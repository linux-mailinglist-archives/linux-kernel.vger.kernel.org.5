Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF77D56D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbjJXPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbjJXPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:44:22 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 688F9DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:44:20 -0700 (PDT)
Received: (qmail 461325 invoked by uid 1000); 24 Oct 2023 11:44:19 -0400
Date:   Tue, 24 Oct 2023 11:44:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
        yangyingliang@huawei.com, jinpu.wang@ionos.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
Subject: Re: [PATCH v4] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <de2ed64a-363a-464c-95be-584ce1a7a4ad@rowland.harvard.edu>
References: <2023101155-unframed-satirical-f7ec@gregkh>
 <20231011164525.97616-1-hgajjar@de.adit-jv.com>
 <2023101620-shaky-sensitize-9708@gregkh>
 <20231017161021.GA62775@vmlxhi-118.adit-jv.com>
 <2023101750-bless-humorous-45c7@gregkh>
 <6c25beed-06fe-4be0-b51a-18e159d25072@rowland.harvard.edu>
 <2023102105-attribute-pajamas-a0dc@gregkh>
 <20231023161348.GA55951@vmlxhi-118.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023161348.GA55951@vmlxhi-118.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 06:13:48PM +0200, Hardik Gajjar wrote:
> On Sat, Oct 21, 2023 at 12:15:35PM +0200, Greg KH wrote:
> > On Tue, Oct 17, 2023 at 02:59:54PM -0400, Alan Stern wrote:
> > > On Tue, Oct 17, 2023 at 06:53:44PM +0200, Greg KH wrote:
> > > > On Tue, Oct 17, 2023 at 06:10:21PM +0200, Hardik Gajjar wrote:
> > > > > More logs and detailed in patch V1:
> > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dusb_20230818092353.124658-2D1-2Dhgajjar-40de.adit-2Djv.com_T_-23m452ec9dad94e8181fdb050cd29483dd89437f7c1&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=P0HXZTx6ta7v5M4y2Y7WZkPrY-dpKkxBq8tAzuX8cI9aj9tE2NuVvJjLl3Uvojpw&s=N_HwnQeZb_gHMmgz53uTGDUZVi28EXb1l9Pg6PdbvVI&e=
> > > > > > 
> > > > > > > Achieving this is impossible in scenarios where the set_address is
> > > > > > > not successful and waits for a timeout.
> > > > > > 
> > > > > > Agreed, broken hardware is a pain, but if your device is allowed to take
> > > > > > longer, it can, and will, so you have to support that.
> > > > > > 
> > > > > The problem is not caused by the device taking an extended amount of time to
> > > > > process the 'set_address' request. Instead, the issue lies in the absence of
> > > > > any activity on the upstream bus until a timeout occurs.
> > > > 
> > > > So, a broken device.  Why are you then adding the hub to the quirk list
> > > > and not the broken device?  We are used to adding broken devices to
> > > > qurik lists all the time, this shouldn't be new.
> > > 
> > > Adding a quirk for the device isn't feasible, because the problem occurs 
> > > before the device has been initialized and enumerated.  The kernel 
> > > doesn't know anything about the device at this point; only that it has 
> > > just connected.
> > 
> > Ah, ick, you are right, but we do know the "broken hub" id, so that
> > makes a bit more sense.  Should this be a hub-only type quirk?
> 
> In addition to the earlier comment, it appears that the issue is most likely
> related to the hub. While we have identified one specific phone that triggers
> this problem, we cannot determine how many other devices might encounter a
> similar issue, where they enumerate as full speed initially and then switch
> to high speed. To address this, we are proposing to use a 500 ms timeout for
> all devices connected via the hub. This change aims to prevent potential
> timeout-related problems with various devices

So it sounds like the best approach is to make this a hub-specific 
quirk.

> It does appear that the issue is related to the hub, and the ideal solution would involve
> modifying the hub's firmware. However, implementing such a firmware fix is currently not
> a straightforward task. As a result, we have implemented this quirk-based solution to
> mitigate the issue to some extent
> 
> Following is the LeCroy analyzer logs:
> 
> 1. logs between Hub and phone with broken hub.
> 
> In packet 58, there is a Full-speed J (suspend) event that lasted for 5.347 seconds.
> It's suspected that the hub was suspended due to incorrect chirp parsing.
> This anomaly in chirp parsing may be a contributing factor to the issue we're facing.

Yes, that's probably true.  It's another indication that the hub is 
somehow at fault.

Alan Stern
