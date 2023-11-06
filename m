Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0A7E2D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjKFUGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFUGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:06:44 -0500
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A62D51;
        Mon,  6 Nov 2023 12:06:39 -0800 (PST)
Received: from [10.23.33.142] (mmsrv.sra.uni-hannover.de [130.75.33.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 2975F10E;
        Mon,  6 Nov 2023 21:06:37 +0100 (CET)
Message-ID: <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
Date:   Mon, 6 Nov 2023 21:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel
 issue
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        David Revoy <davidrevoy@protonmail.com>
Cc:     jkosina@suse.cz, jason.gerecke@wacom.com,
        jose.exposito89@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, nils@nilsfuhler.de,
        peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
 <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
Content-Language: en-US
From:   Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
In-Reply-To: <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 17:59, Benjamin Tissoires wrote:

> If the pen has 2 buttons, and an eraser side, it would be a serious
> design flow for XPPEN to report both as eraser.
> 
> Could you please use sudo hid-recorder from hid-tools[1] on any kernel
> version and send us the logs here?
> I'll be able to replay the events locally, and understand why the
> kernel doesn't work properly.
> 
> And if there is a design flaw that can be fixed, we might even be able
> to use hid-bpf to change it :)

My wild guess is that XP-Pen 16 Artist Pro reports an Eraser usage 
without Invert for the upper button and Eraser with Invert for the 
eraser tip.  A device-specific driver could work with that, but there 
seems to be no way to incorporate two different erasers (thus, allowing 
userspace to map them to different actions arbitrarily) in the generic 
driver currently.

> Generally speaking, relying on X to fix your hardware is going to be a
> dead end. When you switch to wayland, you'll lose all of your fixes,
> which isn't great.

> AFAIU, the kernel now "merges" both buttons, which is a problem. It
> seems to be a serious regression. This case is also worrying because I
> added regression tests on hid, but I don't have access to all of the
> various tablets, so I implemented them from the Microsoft
> specification[0]. We need a special case for you here.

The issue preventing David from mapping HID_DG_ERASER to BTN_STYLUS2 is 
that the hidinput_hid_event is not compatible with hidinput_setkeycode. 
If usage->code is no longer BTN_TOUCH after remapping, it won't be 
released when Eraser reports 0.  A simple fix is:

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1589,7 +1589,7 @@ void hidinput_hid_event(struct hid_device *hid, 
struct hid_field *field, struct
  			/* value is off, tool is not rubber, ignore */
  			return;
  		else if (*quirks & HID_QUIRK_NOINVERT &&
-			 !test_bit(BTN_TOUCH, input->key)) {
+			 !test_bit(usage->code, input->key)) {
  			/*
  			 * There is no invert to release the tool, let hid_input
  			 * send BTN_TOUCH with scancode and release the tool after.

This change alone fixes David's problem and the right-click mapping in 
hwdb works again.  However, the tool switches to rubber for the remapped 
eraser (here BTN_STYLUS2) events, both for devices with and without 
Invert.  This does no harm but is not useful either.  A cleaner solution 
for devices without Invert would be to omit the whole tool switching 
logic in this case:

@@ -1577,6 +1577,9 @@ void hidinput_hid_event(struct hid_device *hid, 
struct hid_field *field, struct

  	switch (usage->hid) {
  	case HID_DG_ERASER:
+		if (*quirks & HID_QUIRK_NOINVERT && usage->code != BTN_TOUCH)
+			break;
+
  		report->tool_active |= !!value;

Remapping Invert does not work anyway as the Invert tool is hardcoded in 
hidinput_hid_event.  Even worse, I guess (not tested) trying to do so 
would mask BTN_TOOL_RUBBER from dev->keybit and could cause weird 
behavior similar to one between 87562fcd1342 and 276e14e6c3.  This 
raises the question: should users be able to remap Invert after all?
