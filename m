Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D07D3BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjJWQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:13:59 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46657103;
        Mon, 23 Oct 2023 09:13:55 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 2D9B95201FF;
        Mon, 23 Oct 2023 18:13:53 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Mon, 23 Oct
 2023 18:13:52 +0200
Date:   Mon, 23 Oct 2023 18:13:48 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <mathias.nyman@intel.com>, <yangyingliang@huawei.com>,
        <jinpu.wang@ionos.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <20231023161348.GA55951@vmlxhi-118.adit-jv.com>
References: <2023101155-unframed-satirical-f7ec@gregkh>
 <20231011164525.97616-1-hgajjar@de.adit-jv.com>
 <2023101620-shaky-sensitize-9708@gregkh>
 <20231017161021.GA62775@vmlxhi-118.adit-jv.com>
 <2023101750-bless-humorous-45c7@gregkh>
 <6c25beed-06fe-4be0-b51a-18e159d25072@rowland.harvard.edu>
 <2023102105-attribute-pajamas-a0dc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023102105-attribute-pajamas-a0dc@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 12:15:35PM +0200, Greg KH wrote:
> On Tue, Oct 17, 2023 at 02:59:54PM -0400, Alan Stern wrote:
> > On Tue, Oct 17, 2023 at 06:53:44PM +0200, Greg KH wrote:
> > > On Tue, Oct 17, 2023 at 06:10:21PM +0200, Hardik Gajjar wrote:
> > > > More logs and detailed in patch V1:
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dusb_20230818092353.124658-2D1-2Dhgajjar-40de.adit-2Djv.com_T_-23m452ec9dad94e8181fdb050cd29483dd89437f7c1&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=P0HXZTx6ta7v5M4y2Y7WZkPrY-dpKkxBq8tAzuX8cI9aj9tE2NuVvJjLl3Uvojpw&s=N_HwnQeZb_gHMmgz53uTGDUZVi28EXb1l9Pg6PdbvVI&e=
> > > > > 
> > > > > > Achieving this is impossible in scenarios where the set_address is
> > > > > > not successful and waits for a timeout.
> > > > > 
> > > > > Agreed, broken hardware is a pain, but if your device is allowed to take
> > > > > longer, it can, and will, so you have to support that.
> > > > > 
> > > > The problem is not caused by the device taking an extended amount of time to
> > > > process the 'set_address' request. Instead, the issue lies in the absence of
> > > > any activity on the upstream bus until a timeout occurs.
> > > 
> > > So, a broken device.  Why are you then adding the hub to the quirk list
> > > and not the broken device?  We are used to adding broken devices to
> > > qurik lists all the time, this shouldn't be new.
> > 
> > Adding a quirk for the device isn't feasible, because the problem occurs 
> > before the device has been initialized and enumerated.  The kernel 
> > doesn't know anything about the device at this point; only that it has 
> > just connected.
> 
> Ah, ick, you are right, but we do know the "broken hub" id, so that
> makes a bit more sense.  Should this be a hub-only type quirk?

In addition to the earlier comment, it appears that the issue is most likely
related to the hub. While we have identified one specific phone that triggers
this problem, we cannot determine how many other devices might encounter a
similar issue, where they enumerate as full speed initially and then switch
to high speed. To address this, we are proposing to use a 500 ms timeout for
all devices connected via the hub. This change aims to prevent potential
timeout-related problems with various devices
> 
> > > > This situation arises when the host has already transmitted the 'set_address' command to the hub,
> > > > assuming that the device operates at full speed. However, the device connected
> > > > to the hub undergoes a state change from full speed to high-speed during this process.
> > > 
> > > During which process?  While the set-address happens?  That feels like a
> > > hub bug then.
> > > 
> > > > > > The shortened address device timeout quirks provide the flexibility
> > > > > > to align with a 3-second time limit in the event of errors.
> > > > > > By swiftly triggering a failure response and swiftly initiating
> > > > > > retry procedures, these quirks ensure efficient and rapid recovery,
> > > > > > particularly in automotive contexts where rapid smartphone enumeration
> > > > > > and screen projection are vital.
> > > > > 
> > > > > Screen projection is a requirement that you should not be relying on USB
> > > > > for as USB has a different set of required timeouts, right?  This sounds
> > > > > like a bad hardware design, if not an impossible one.
> > > > > 
> > > > 
> > > > Screen projection for us means displaying the connected phone on the screen and
> > > > launching Carplay and Android Auto for the user. This works perfectly in nearly all
> > > > cases, except in scenarios like this one where a combination of a special hub and
> > > > a specific phone model is causing the issue
> > > 
> > > So which is broken, the hub or phone?
> > 
> > It sounds like both of them are broken to some extent, although we can't 
> > tell for sure without seeing what's actually happening on the USB bus 
> > (i.e., bus analyzer output):
> > 
> > 	The phone seems to take too long to activate its high-speed
> > 	terminations and deactivate the full-speed terminations.
> > 
> > 	The hub doesn't seem to realize that the phone has disconnected 
> > 	its full-speed connection and switched to high-speed.0
> > 
> > But without real data, these are just best guesses.
> 
> Agreed, Hardik, can you look at some bus traces to figure out where the
> root problem here is?

It does appear that the issue is related to the hub, and the ideal solution would involve
modifying the hub's firmware. However, implementing such a firmware fix is currently not
a straightforward task. As a result, we have implemented this quirk-based solution to
mitigate the issue to some extent

Following is the LeCroy analyzer logs:

1. logs between Hub and phone with broken hub.

In packet 58, there is a Full-speed J (suspend) event that lasted for 5.347 seconds.
It's suspected that the hub was suspended due to incorrect chirp parsing.
This anomaly in chirp parsing may be a contributing factor to the issue we're facing.

Packet(0)
_______| Dir SE0?(?????)-BAD Idle(0.000 ns) Time Stamp(44 . 964 254 882)
_______|_______________________________________________________________________Ch0
10 Packets(1-10) Dir Chirp J(27.233 sec) Chirp J Chirp K
_______| Time( 27.905 sec) Time Stamp(0 . 000 001 050)
_______|_______________________________________________________________________Ch0
Packet(11) Dir(?) Full Speed J (Suspend)(151.614 ms) Idle(50.000 ns)
_______| Time Stamp(27 . 905 210 900)
_______|_______________________________________________________________________Ch0
Packet(12) Dir Chirp J( 10.923 ms) Idle( 11.866 us)
_______| Time Stamp(28 . 056 825 150)
_______|_______________________________________________________________________Ch0
Packet(13) Dir(?) Full Speed J(  2.167 us) Idle( 11.401 us)
_______| Time Stamp(28 . 067 759 916)
_______|_______________________________________________________________________Ch0
Packet(14) Dir(?) Full Speed J(  2.167 us) Idle( 11.399 us)
_______| Time Stamp(28 . 067 773 484)
_______|_______________________________________________________________________Ch0
Packet(15) Dir(?) Full Speed J(122.082 us) Idle(  2.834 us)
_______| Time Stamp(28 . 067 787 050)
_______|_______________________________________________________________________Ch0
Packet(16) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 067 911 966)
_______|_______________________________________________________________________Ch0
Packet(17) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 068 911 916)
_______|_______________________________________________________________________Ch0
Packet(18) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(28 . 069 911 866)
_______|_______________________________________________________________________Ch0
Packet(19) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 070 911 850)
_______|_______________________________________________________________________Ch0
Packet(20) Dir(?) Full Speed J(997.132 us) Idle(  2.850 us)
_______| Time Stamp(28 . 071 911 800)
_______|_______________________________________________________________________Ch0
Packet(21) Dir(?) Full Speed J(997.068 us) Idle(  2.850 us)
_______| Time Stamp(28 . 072 911 782)
_______|_______________________________________________________________________Ch0
Packet(22) Dir(?) Full Speed J(997.200 us) Idle(  2.832 us)
_______| Time Stamp(28 . 073 911 700)
_______|_______________________________________________________________________Ch0
Packet(23) Dir(?) Full Speed J(997.118 us) Idle(  2.832 us)
_______| Time Stamp(28 . 074 911 732)
_______|_______________________________________________________________________Ch0
Packet(24) Dir(?) Full Speed J(997.134 us) Idle(  2.834 us)
_______| Time Stamp(28 . 075 911 682)
_______|_______________________________________________________________________Ch0
Packet(25) Dir(?) Full Speed J(997.132 us) Idle(  2.834 us)
_______| Time Stamp(28 . 076 911 650)
_______|_______________________________________________________________________Ch0
Packet(26) Dir(?) Full Speed J(997.134 us) Idle(  2.832 us)
_______| Time Stamp(28 . 077 911 616)
_______|_______________________________________________________________________Ch0
Packet(27) Dir(?) Full Speed J(997.134 us) Idle(  2.834 us)
_______| Time Stamp(28 . 078 911 582)
_______|_______________________________________________________________________Ch0
Packet(28) Dir(?) Full Speed J(997.116 us) Idle(  2.834 us)
_______| Time Stamp(28 . 079 911 550)
_______|_______________________________________________________________________Ch0
Packet(29) Dir(?) Full Speed J(997.150 us) Idle(  2.832 us)
_______| Time Stamp(28 . 080 911 500)
_______|_______________________________________________________________________Ch0
Packet(30) Dir(?) Full Speed J(997.118 us) Idle(  2.832 us)
_______| Time Stamp(28 . 081 911 482)
_______|_______________________________________________________________________Ch0
Packet(31) Dir(?) Full Speed J(997.150 us) Idle(  2.834 us)
_______| Time Stamp(28 . 082 911 432)
_______|_______________________________________________________________________Ch0
Packet(32) Dir(?) Full Speed J(997.116 us) Idle(  2.918 us)
_______| Time Stamp(28 . 083 911 416)
_______|_______________________________________________________________________Ch0
Packet(33) Dir(?) Full Speed J(997.032 us) Idle(  2.918 us)
_______| Time Stamp(28 . 084 911 450)
_______|_______________________________________________________________________Ch0
Packet(34) Dir(?) Full Speed J(997.066 us) Idle(  2.834 us)
_______| Time Stamp(28 . 085 911 400)
_______|_______________________________________________________________________Ch0
Packet(35) Dir(?) Full Speed J(997.082 us) Idle(  2.850 us)
_______| Time Stamp(28 . 086 911 300)
_______|_______________________________________________________________________Ch0
Packet(36) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
_______| Time Stamp(28 . 087 911 232)
_______|_______________________________________________________________________Ch0
Packet(37) Dir(?) Full Speed J(997.182 us) Idle(  2.850 us)
_______| Time Stamp(28 . 088 911 200)
_______|_______________________________________________________________________Ch0
Packet(38) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
_______| Time Stamp(28 . 089 911 232)
_______|_______________________________________________________________________Ch0
Packet(39) Dir(?) Full Speed J(997.100 us) Idle(  2.832 us)
_______| Time Stamp(28 . 090 911 200)
_______|_______________________________________________________________________Ch0
Packet(40) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(28 . 091 911 132)
_______|_______________________________________________________________________Ch0
Packet(41) Dir(?) Full Speed J(997.116 us) Idle(  2.850 us)
_______| Time Stamp(28 . 092 911 116)
_______|_______________________________________________________________________Ch0
Packet(42) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
_______| Time Stamp(28 . 093 911 082)
_______|_______________________________________________________________________Ch0
Packet(43) Dir(?) Full Speed J(997.116 us) Idle(  2.850 us)
_______| Time Stamp(28 . 094 911 050)
_______|_______________________________________________________________________Ch0
Packet(44) Dir(?) Full Speed J(997.100 us) Idle(  2.834 us)
_______| Time Stamp(28 . 095 911 016)
_______|_______________________________________________________________________Ch0
Packet(45) Dir(?) Full Speed J(997.150 us) Idle(  2.850 us)
_______| Time Stamp(28 . 096 910 950)
_______|_______________________________________________________________________Ch0
Packet(46) Dir(?) Full Speed J(997.100 us) Idle(  2.832 us)
_______| Time Stamp(28 . 097 910 950)
_______|_______________________________________________________________________Ch0
Packet(47) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(28 . 098 910 882)
_______|_______________________________________________________________________Ch0
Packet(48) Dir(?) Full Speed J(997.116 us) Idle(  2.834 us)
_______| Time Stamp(28 . 099 910 866)
_______|_______________________________________________________________________Ch0
Packet(49) Dir(?) Full Speed J(997.116 us) Idle(  2.834 us)
_______| Time Stamp(28 . 100 910 816)
_______|_______________________________________________________________________Ch0
Packet(50) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 101 910 766)
_______|_______________________________________________________________________Ch0
Packet(51) Dir(?) Full Speed J(997.116 us) Idle(  2.850 us)
_______| Time Stamp(28 . 102 910 716)
_______|_______________________________________________________________________Ch0
Packet(52) Dir(?) Full Speed J(997.184 us) Idle(  2.850 us)
_______| Time Stamp(28 . 103 910 682)
_______|_______________________________________________________________________Ch0
Packet(53) Dir(?) Full Speed J(997.116 us) Idle(  2.850 us)
_______| Time Stamp(28 . 104 910 716)
_______|_______________________________________________________________________Ch0
Packet(54) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 105 910 682)
_______|_______________________________________________________________________Ch0
Packet(55) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
_______| Time Stamp(28 . 106 910 632)
_______|_______________________________________________________________________Ch0
Packet(56) Dir(?) Full Speed J(399.650 us) Idle(222.582 us)
_______| Time Stamp(28 . 107 910 600)
_______|_______________________________________________________________________Ch0
Packet(57) Dir Chirp J( 23.955 ms) Idle(115.169 ms)
_______| Time Stamp(28 . 108 532 832)
_______|_______________________________________________________________________Ch0
Packet(58) Dir(?) Full Speed J (Suspend)( 5.347 sec) Idle(  5.366 us)
_______| Time Stamp(28 . 247 657 600)
_______|_______________________________________________________________________Ch0
173 Packets(59-231) Dir(?) Chirp K(  2.000 ms) Chirp J Chirp K
_______| Time( 10.918 ms) Time Stamp(33 . 594 605 882)
_______|_______________________________________________________________________Ch0
Packet(232) Dir H(S) SPLIT(0x1E) SC(1) Hub Addr(1) Port(3) S(0) U(0)
_______| ET(Ctrl) CRC5(0x01) Pkt Len(9) Duration(150.000 ns) Idle(200.000 ns)
_______| Time Stamp(33 . 605 524 366)
_______|_______________________________________________________________________Ch0

2. Following is the logs between Host and Hub:

In transfer 12, the Full-Speed (FS) SET Address request commenced at
8.995 seconds, following an SSPLIT request. Unfortunately, it eventually
failed in Transaction 2866864 at 14.784 seconds with a Timeout error,
which is nearly a 5-second duration.

It appears that the timeout occurred due to a suspension in the upstream
logs.

Transfer(12) F(H) Control(SET) ADDR(0) ENDP(0) bRequest(SET_ADDRESS)
_______| wValue(New address 4) wIndex(0x0000) wLength(0) STALL(0x08)
_______| Time Stamp(8 . 955 781 832)
_______|_______________________________________________________________________
Split Trans(0) F(H) SETUP(0xB4) ADDR(0) ENDP(0) T(0) D(H->D) Tp(S) R(D)
_______| bRequest(0x05) wValue(0x0004) wIndex(0x0000) wLength(0) STALL(0x78)
_______| Time Stamp(8 . 955 781 832)
_______|_______________________________________________________________________
Transaction(307) H(S) SSplit(Ctrl) Hub Addr(1) Port(2) Speed(Full) SETUP(0xB4)
_______| ADDR(0) ENDP(0) T(0) D(H->D) Tp(S) R(D) bRequest(0x05) wValue(0x0004)
_______| wIndex(0x0000) wLength(0) ACK(0x4B) Time Stamp(8 . 955 781 832)
_______|_______________________________________________________________________Ch0
Packet(72291) Dir H(S) SPLIT(0x1E) SC(0) Hub Addr(1) Port(2) S(0) E(0)
_______| ET(Ctrl) CRC5(0x05) Pkt Len(9) Duration(150.000 ns) Idle(200.000 ns)
_______| Time Stamp(8 . 955 781 832)
_______|_______________________________________________________________________Ch0
Packet(72292) Dir H(S) SETUP(0xB4) ADDR(0) ENDP(0) CRC5(0x08) Pkt Len(8)
_______| Duration(133.330 ns) Idle(200.660 ns) Time Stamp(8 . 955 782 182)
_______|_______________________________________________________________________Ch0
Packet(72293) Dir H(S) DATA0(0xC3) Data(8 bytes) CRC16(0xD70E)
_______| Pkt Len(16) Duration(266.660 ns) Idle(299.330 ns)
_______| Time Stamp(8 . 955 782 516)
_______|_______________________________________________________________________Ch0
Packet(72294) Dir H(S) ACK(0x4B) Pkt Len(6) Duration(100.000 ns)
_______| Time(984.000 ns) Time Stamp(8 . 955 783 082)
_______|_______________________________________________________________________
Transaction(308) H(S) CSplit(Ctrl) Hub Addr(1) Port(2) Speed(Full) SETUP(0xB4)
_______| ADDR(0) ENDP(0) STALL(0x78) Time Stamp(8 . 955 784 066)
_______|_______________________________________________________________________Ch0
Packet(72295) Dir H(S) SPLIT(0x1E) SC(1) Hub Addr(1) Port(2) S(0) U(0)
_______| ET(Ctrl) CRC5(0x1E) Pkt Len(9) Duration(150.000 ns) Idle(200.000 ns)
_______| Time Stamp(8 . 955 784 066)
_______|_______________________________________________________________________Ch0
Packet(72296) Dir H(S) SETUP(0xB4) ADDR(0) ENDP(0) CRC5(0x08) Pkt Len(8)
_______| Duration(133.330 ns) Idle(300.660 ns) Time Stamp(8 . 955 784 416)
_______|_______________________________________________________________________Ch0
Packet(72297) Dir H(S) STALL(0x78) Pkt Len(6) Duration(100.000 ns)
_______| Time(  5.829 sec) Time Stamp(8 . 955 784 850)
_______|_______________________________________________________________________
Transaction(2866864) H(S) SETUP(0xB4) ADDR(0) ENDP(0) Cplt(NO) T(0) D(H->D)
_______| Tp(S) R(D) bRequest(0x05) wValue(0x0000) wIndex(0x0000) wLength(0)
_______| !! Propagated Error !!(Turnaround/Timeout Error)
_______| Time Stamp(14 . 784 876 232)

3. Following is the logs between Hub and phone using normal hub

As you can see, the suspend timeout is only ~300 ms (packet 65) compare to 5 sec in
broken hub logs in point 1.

_______| Time Stamp(5 . 247 278 566)
_______|_______________________________________________________________________Ch0
Packet(54) Dir(?) Full Speed J(997.082 us) Idle(  2.850 us)
_______| Time Stamp(5 . 248 278 550)
_______|_______________________________________________________________________Ch0
Packet(55) Dir(?) Full Speed J(997.118 us) Idle(  2.832 us)
_______| Time Stamp(5 . 249 278 482)
_______|_______________________________________________________________________Ch0
Packet(56) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(5 . 250 278 432)
_______|_______________________________________________________________________Ch0
Packet(57) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(5 . 251 278 416)
_______|_______________________________________________________________________Ch0
Packet(58) Dir(?) Full Speed J(997.132 us) Idle(  2.834 us)
_______| Time Stamp(5 . 252 278 400)
_______|_______________________________________________________________________Ch0
Packet(59) Dir(?) Full Speed J(997.116 us) Idle(  2.850 us)
_______| Time Stamp(5 . 253 278 366)
_______|_______________________________________________________________________Ch0
Packet(60) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(5 . 254 278 332)
_______|_______________________________________________________________________Ch0
Packet(61) Dir(?) Full Speed J(997.116 us) Idle(  2.834 us)
_______| Time Stamp(5 . 255 278 316)
_______|_______________________________________________________________________Ch0
Packet(62) Dir(?) Full Speed J(997.134 us) Idle(  2.850 us)
_______| Time Stamp(5 . 256 278 266)
_______|_______________________________________________________________________Ch0
Packet(63) Dir(?) Full Speed J(997.116 us) Idle(  2.850 us)
_______| Time Stamp(5 . 257 278 250)
_______|_______________________________________________________________________Ch0
Packet(64) Dir(?) Full Speed J(466.516 us) Idle(130.706 ms)
_______| Time Stamp(5 . 258 278 216)
_______|_______________________________________________________________________Ch0
Packet(65) Dir(?) Full Speed J (Suspend)(311.252 ms) Idle(  5.384 us)
_______| Time Stamp(5 . 389 451 066)
_______|_______________________________________________________________________Ch0
256 Packets(66-321) Dir(?) Chirp K(  2.000 ms) Chirp J Chirp K
_______| Time( 15.979 ms) Time Stamp(5 . 700 708 316)
_______|_______________________________________________________________________Ch0
Packet(330) Dir H(S) SETUP(0xB4) ADDR(1) ENDP(0) CRC5(0x17) Pkt Len(8)
_______| Duration(133.330 ns) Idle(198.660 ns) Time Stamp(5 . 716 687 650)
_______|_______________________________________________________________________Ch0

I uploaded the detailed logs on gdrive

https://drive.google.com/file/d/1sbitUOIQTZ4XwbrcB0gAUucGq4ReSroW/view?usp=share_link

> 
> thanks,
> 
> greg k-h
