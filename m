Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA6760A34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGYGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:22:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF6CF;
        Mon, 24 Jul 2023 23:22:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BD8622489;
        Tue, 25 Jul 2023 06:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690266131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QaBNnA/8gpFgghYhdk/w9mp+r6Zv7/AG4oLP8HE40AM=;
        b=Ic5ArVRfMJt9KorJR2SkOWpNNCrHNKFoYKaScO9d6EfjxaUkX72WbT49kFKNRBR0XRHsMp
        66/It/FuaFUz7L3A3lEChgTyN3Y277znunXyiwzOU5H9syyxzUXjMr4k3kNBQtDD0D61Ef
        5z+TarS7jEU63qeULLNxd5rc9LxLTS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690266131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QaBNnA/8gpFgghYhdk/w9mp+r6Zv7/AG4oLP8HE40AM=;
        b=ms3T9/AYc+/7B94Yh1vrliH7UzeI2zke2rTBcTkHYIlA9pdVzgapaaK8x+UhR5zy+KpHWm
        5np1l1KXJpyIpSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4997213342;
        Tue, 25 Jul 2023 06:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NiT2EBNqv2S0dQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:22:11 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] usb: Add USB MIDI 2.0 Gadget Function Driver
Date:   Tue, 25 Jul 2023 08:21:59 +0200
Message-Id: <20230725062206.9674-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a patch set for adding a USB gadget function driver for USB
MIDI 2.0 interface.  The MIDI 2.0 support in the host side was already
enabled since 6.5 kernel in snd-usb-audio driver.  Now, this provides
a similar gadget functionality using the existing ALSA UMP helper
functions.

The gadget driver provides both MIDI 2.0 and MIDI 1.0 fallback
interfaces with one or more loopback UMP rawmidi devices.  The
configfs implementation is flexible enough to allow users to set up
multiple UMP Endpoints and Function Blocks.

The first patch adds the bare f_midi2 driver without configfs support,
followed by the configfs support, MIDI 1.0 interface support and a few
other extensions and documentation.


Takashi

===

Takashi Iwai (7):
  usb: gadget: Add support for USB MIDI 2.0 function driver
  usb: gadget: midi2: Add configfs support
  usb: gadget: midi2: Dynamically create MIDI 1.0 altset descriptors
  usb: gadget: midi2: MIDI 1.0 interface (altset 0) support
  usb: gadget: midi2: Add testing documentation
  usb: gadget: midi2: Add "Operation Mode" control
  usb: gadget: midi2: More flexible MIDI 1.0 configuration

 .../ABI/testing/configfs-usb-gadget-midi2     |   54 +
 Documentation/usb/gadget-testing.rst          |  154 +
 drivers/usb/gadget/Kconfig                    |   18 +
 drivers/usb/gadget/function/Makefile          |    2 +
 drivers/usb/gadget/function/f_midi2.c         | 2883 +++++++++++++++++
 drivers/usb/gadget/function/u_midi2.h         |   81 +
 6 files changed, 3192 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-usb-gadget-midi2
 create mode 100644 drivers/usb/gadget/function/f_midi2.c
 create mode 100644 drivers/usb/gadget/function/u_midi2.h

-- 
2.35.3

