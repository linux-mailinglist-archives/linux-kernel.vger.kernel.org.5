Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468177E09ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378018AbjKCULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKCULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:11:04 -0400
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 13:11:00 PDT
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A61D63;
        Fri,  3 Nov 2023 13:10:59 -0700 (PDT)
Received: from seminarraum.sra.uni-hannover.de (mmsrv.sra.uni-hannover.de [130.75.33.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id CC8161BA9;
        Fri,  3 Nov 2023 21:05:46 +0100 (CET)
From:   Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
To:     jkosina@suse.cz
Cc:     benjamin.tissoires@redhat.com, davidrevoy@protonmail.com,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Date:   Fri,  3 Nov 2023 21:05:25 +0100
Message-Id: <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello David, Hello Jiri,

The XP-Pen hardware reports the Eraser usage for the upper stylus button.
Generally, styli report Invert usages when erasing, as described in [1].
XP-Pen digitizers, however, tend to omit them.

The generic driver maps the Eraser usage to BTN_TOUCH and the Invert
usage to BTN_TOOL_RUBBER.  Pens conforming to [1] send the Invert usage
first (switching the tool to BTN_TOOL_RUBBER) followed by Eraser, which
appears in userspace as a BTN_TOUCH event with the rubber tool set.

Due to an oversight, devices not reporting Invert had the BTN_TOOL_RUBBER
event masked.  This has caused the kernel to send only BTN_TOUCH events
without the tool switch when erasing.

The situation got worse with refactoring done in 87562fcd1342.  An eraser
without Invert caused the hidinput_hid_event state machine to get stuck
with BTN_TOOL_RUBBER internally (due to it being masked).  For the
userspace, this looked as if the pen was never hovering again, rendering
it unusable until the next reset.  276e14e6c3 fixes this by adding
support for digitizers that do not report Invert usages when erasing.

---

David, we are sorry that our patch broke your workflow.  However,
forwarding hardware events *as-is* to the userspace has always been the
intended behavior, with a kernel bug preventing it so far.  You can still
remap the eraser button to a right click using xsetwacom:

xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"

Replace the device name with the corresponding *eraser* device from
"xsetwacom list devices".  You can also do this with "xinput set-button-map",
which works for libinput as well.  We have tested this with several
XP-Pen devices, including Artist 24.

[1] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
