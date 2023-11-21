Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965107F31FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKUPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjKUPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:09:41 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F1D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:09:36 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A56061E5FE01;
        Tue, 21 Nov 2023 16:08:56 +0100 (CET)
Message-ID: <c9e3a8f1-d053-4203-a364-0d0703fafd19@molgen.mpg.de>
Date:   Tue, 21 Nov 2023 16:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Powered off Philips TV sends corrupt EDID causing flickering
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Connecting a USB Type-C port replicator [1] to the only USB Type-C port 
of the Dell XPS 13 9360 with Debian sid/unstable and Debian’s Linux 
kernel 6.10.5, and then connecting a Philips 40PFL5206H/12 TV device, 
that is powered off or in standby, to the HDMI port, Linux logs:

```
[    0.000000] Linux version 6.5.0-4-amd64 
(debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU 
ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 
6.5.10-1 (2023-11-03)
[…]
[    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
[…]
[  160.004836] EDID has corrupt header
[  160.004866] 	[00] BAD  00 00 00 00 00 00 00 00 00 7f ff ff ff ff ff ff
[  160.004875] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.004881] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.004886] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.004905] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.004911] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.004917] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.004921] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  160.013662] Registered IR keymap rc-cec
[  160.014001] rc rc0: DP-1 as /devices/pci0000:00/0000:00:02.0/rc/rc0
[  160.014305] input: DP-1 as 
/devices/pci0000:00/0000:00:02.0/rc/rc0/input33
[  160.228342] EDID has corrupt header
[  160.408917] EDID has corrupt header
```

The internal display of the laptop also switches off shortly, but comes 
back after two or three seconds. This is very likely due to me 
configuring the internal display to turn off once an external display is 
used.

No idea, why the TV is able to transmit anything at all, when it is 
turned/powered off. To avoid the flickering, would it be possible to 
ignore events from displays sending such incorrect EDID?


Kind regards,

Paul
