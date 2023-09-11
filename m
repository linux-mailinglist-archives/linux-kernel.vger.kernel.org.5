Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0579BC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbjIKVdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbjIKPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:20:16 -0400
X-Greylist: delayed 81684 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 08:20:11 PDT
Received: from MTA-06-4.privateemail.com (mta-06-4.privateemail.com [198.54.122.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50689FA;
        Mon, 11 Sep 2023 08:20:11 -0700 (PDT)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id 2A7EB18000A4;
        Mon, 11 Sep 2023 11:20:10 -0400 (EDT)
Received: from [192.168.2.177] (bras-base-toroon4332w-grc-39-74-12-11-94.dsl.bell.ca [74.12.11.94])
        by mta-06.privateemail.com (Postfix) with ESMTPA;
        Mon, 11 Sep 2023 11:19:55 -0400 (EDT)
Date:   Mon, 11 Sep 2023 11:19:47 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH] USB: add ignore remote wakeup quirk for one of Logitech's
 receivers
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        =?iso-8859-2?q?=A3ukasz?= Bartosik <lb@semihalf.com>,
        Nicolas Dumazet <ndumazet@google.com>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hannu Hartikainen <hannu@hrtk.in>, linux-kernel@vger.kernel.org
Message-Id: <ZKUT0S.QB90NRXC7O1R1@effective-light.com>
In-Reply-To: <9d2dff10-5a3b-b24a-c3d8-3c843891966d@redhat.com>
References: <20230910163751.4210-1-someguy@effective-light.com>
        <9d2dff10-5a3b-b24a-c3d8-3c843891966d@redhat.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hans,

On Mon, Sep 11 2023 at 09:32:42 AM +02:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Hamza,
> 
> On 9/10/23 18:37, Hamza Mahfooz wrote:
>>  This device causes the system to wake up from suspend, as soon as it
>>  enters it (even if the device attached to the receiver is powered 
>> off).
>>  So, ignore remote wakeup events from it.
>> 
>>  Cc: stable@vger.kernel.org
>>  Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
>>  ---
>>   drivers/usb/core/quirks.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>>  diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>>  index 15e9bd180a1d..d2e2a2873f34 100644
>>  --- a/drivers/usb/core/quirks.c
>>  +++ b/drivers/usb/core/quirks.c
>>  @@ -264,6 +264,10 @@ static const struct usb_device_id 
>> usb_quirk_list[] = {
>>   	/* Logitech Harmony 700-series */
>>   	{ USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT 
>> },
>> 
>>  +	/* Logitech lightspeed receiver (0xc547) */
>>  +	{ USB_DEVICE(0x046d, 0xc547), .driver_info =
>>  +			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>>  +
>>   	/* Philips PSC805 audio device */
>>   	{ USB_DEVICE(0x0471, 0x0155), .driver_info = 
>> USB_QUIRK_RESET_RESUME },
>> 
> 
> If this is a lightspeed receiver then it really should be handled by
> hid-logitech-dj.c unless this new receiver is using a new protocol ?
> 
> I wonder if adding it there also fixes the remote
> wakeup issue (I doubt it fixes it but worth a try) ?


Seems like the following series does indeed fix this issue:
https://lore.kernel.org/linux-input/20230716182320.85483-1-mavchatz@protonmail.com/T/#u

> 
> Regards,
> 
> Hans
> 
> 
> 


