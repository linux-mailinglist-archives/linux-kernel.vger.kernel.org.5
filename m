Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8F80AF82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574915AbjLHWNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLHWNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:13:36 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95893118;
        Fri,  8 Dec 2023 14:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RlxG7vjWqKyoHCmskEV8jhRRkavkqsM6KoNtZ7Hn0ss=; b=QsYAKXgxEwdVvic0OVQS2q1njD
        KbrlmARUgUPeNq/fvlFmbLHMefvx8bjUUbb0/76kGmGb/Ar0fFT3VrPBNoMXSXCdIGgPYGf1EHla8
        UJZM7Z2OKSCJJ7SdQP9qJ/8WpI350/ddOdwer1AaZ2eIyhwDV1b2iTrFvBvdzBTmYkA5NPzZySZwX
        +6wF3rS6ZNxBi7538KUuxvMXwgtiZWQIU4Tx/7AsXtGFbd73+y6Y76mi0it7jargk86CbnRIE6jMM
        IRGiP40J7DYEBlBtloTTedq8modobMGa15xzjEpvw9VYbZqFBkgEhXQ7TLOgqdRXwJYyxMHEbsYbF
        +E6oPSYg==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1rBj6G-007BDR-9G; Fri, 08 Dec 2023 23:13:36 +0100
Date:   Fri, 8 Dec 2023 23:13:32 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20231208231332.20f0b647@aktux>
In-Reply-To: <ZXNDd57ImXjelBf4@hovoldconsulting.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
        <20231127135424.GO5169@atomide.com>
        <20231127215108.6e985819@aktux>
        <ZXNDd57ImXjelBf4@hovoldconsulting.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 17:25:27 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Mon, Nov 27, 2023 at 09:51:08PM +0100, Andreas Kemnade wrote:
> > On Mon, 27 Nov 2023 15:54:24 +0200
> > Tony Lindgren <tony@atomide.com> wrote:  
> 
> > > > - Output at /dev/gnssX:
> > > >   AI2 vs. NMEA
> > > >   The chip can be configured into sending AI2-encapsulated NMEA,
> > > >   or proving data in a binary format.
> > > >   Some research has to be done yet for the details.
> > > >   A pile of logs is waiting for further analysis...  
> 
> Can you say something more about what the protocol looks like? Is there
> some common framing that can/should be stripped by the driver in both
> modes?
>
The frames (which can be fragmented into multiple gnss_recv_frame() calls)
consist of:
- some kind of start marker
- one or more tlv structures (start marker is escaped here)
- checksum
- end marker

In case of NMEA reporting we have with this patchset at /dev/gnssX or at /dev/tigps
found in the bt200 vendor kernel e.g.

1000 d3 1800 82050000 244750474c4c2c2c2c2c2c2c562c4e2a36340d0a 9f05 1003

which is:
1000 = start marker, d3 = NMEA report
1800 = length (LE)
82050000 = ms from turning on GPS (LE).
244750474c4c2c2c2c2c2c2c562c4e2a36340d0a = NMEA sentence
9f05 = checksum
1003 = end marker.

That is one report among others depending on what is enabled. So it
is not like the situtation with Sirf where you send some magic to turn
it into binary mode and some other magic turning it into NMEA mode
and have no other stuff on the line.

> > > > 
> > > >   Arguments for/against NMEA:
> > > >   + Userspace is prepared to handle it
> > > >   + Power management can be easily done by the kernel
> > > >   - Less functionality can be used.    
> > > 
> > > I'd go with NMEA format as the default setting :)
> > >   
> > yes, that would also be my preference.
> >   
> > > >   Arguments for/against AI2:
> > > >   + Full functionality can be accessed from userspace (incl. A-GPS,
> > > >     maybe raw satellite data)
> > > >   - Userspace has to behave to have proper power management
> > > >   - No freely (not even as in beer) tool available to fully use AI2,
> > > >     so there will be only a real advantage after long "French Cafe"
> > > >     sessions.    
> > > 
> > > Seems AI2 could be optionally enabled as needed with some writes
> > > to /dev/gnss0 to change the mode?  
> > 
> > Hmm, we have
> > /sys/class/gnss/gnss0/type to get the mode, maybe we add some file
> > to change the mode? Or having it hidden behing a module parameter
> > and implement something better accessible if any need arrives?  
> 
> The 'type' attribute is intended to reveal the GNSS receiver type
> (class) as a hint to user space to avoid having to detect it at runtime
> using heuristics.
> 
> It does not reflect which mode is currently active for receivers that
> provide both a vendor specific protocol and NMEA (e.g. u-blox
> receivers).
> 
> User space can currently switch modes at will by writing to /dev/gnss0
> as Tony mentioned.
> 
Well, switching mode would in this case also mean configuring something
in the driver to do something different as it would mean sending commands
to enable NMEA reports and strip away the AI2 encapsulation in the driver.
You usually do not configure drivers through write() but through some
out-of-band means like ioctl(), sysfs, kernel compile options,
module parameters.

> It may or may not make sense to make sure a particular mode is set
> during probe, for example, if there's no real use for the proprietary
> protocol and everyone would just switch away from it immediately.
> 
I would probably not do anything at probe time but turning on GPS and enable
NMEA reports at open() time.

With a lot of effort you can probably do interesting things with the
proprietary mode. But given the fact that apparently nobody has done 
publicly so in the past years, I would not expect that anything arises
suddenly.

So in practice only NMEA would IMHO be useful and having raw AI2
might be something behind a module option or compile option to avoid
introducing some new API before a real need is seen.
Also as not everybody is using gpsd anymore, implementing any support
for AI2 in userspace would not be at a single place.

Regards,
Andreas
