Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245577D03CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbjJSVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346613AbjJSVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:22:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8A10E4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:21:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9fa869a63so959655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697750513; x=1698355313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UYTqG/6/51k2TLUFfCOqmPLkctnDDkEac11ETWHXAA=;
        b=YrffcQSHbfkv3wYDSF1qbiJVDuHrzrAys4OEFHbULpiMWn9WW1blRL7KLyUT+xA95b
         sP3jLTFXmh4ZzqQ4B41h775SEd/eOxLfQTTve+hiUw+JwpXgOQG9SiyT/KobnOFma7jZ
         4Y8ZcJ6O05NMhTmR56DtCLyQAoY6z35vDQGec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697750513; x=1698355313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UYTqG/6/51k2TLUFfCOqmPLkctnDDkEac11ETWHXAA=;
        b=q1X5eHzqte7zCcpaK/hcIqBVmdN18qCpI25OS4ef4aWwLAF5BxpdMmIMjxAPntNOM6
         hkzivPKfTi1ZQit/3URcjrkyYHJfV+jEoXi5DzI1byKWmQoZK7sbi0t7AscLJ/Oi2/HY
         HwB60RNjYC0i886ztUDjYlxdG87UIue7hsQ4qEYpJNo8icIbEFGa0N459q7Z2HAPw8Dc
         ePjdilM9i9f3pvpijs+gNLIwJpgp+fxcT80LmSawVj2zi12WWrbmHxuAjedLyFhm5CIS
         8FntxsAg6p2EI5oewQVnBMysDY04oMpvVHYeO8ruyppptiGVByjZwnNiuB+OT+jUBb0x
         B+Tw==
X-Gm-Message-State: AOJu0YxzTL0FMZLbG4UxxgkTAjGy7LCrMjcjfopr9oXGcVb9KaVf9TqH
        /9v/244bcEcNnwjyIiWNFEeMjw==
X-Google-Smtp-Source: AGHT+IHzJlRpUB2nDTKRU0As3Y1nSrMCYGEvG2M7Fp+2hxAvFzahD9zX1yznGS7gMsBiVFN81ofEHA==
X-Received: by 2002:a17:903:27cd:b0:1ca:25e:3c32 with SMTP id km13-20020a17090327cd00b001ca025e3c32mr107647plb.19.1697750512876;
        Thu, 19 Oct 2023 14:21:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a6da:6f08:412:e04b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm154100plk.136.2023.10.19.14.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:21:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v4 0/5] r8152: Avoid writing garbage to the adapter's registers
Date:   Thu, 19 Oct 2023 14:20:19 -0700
Message-ID: <20231019212130.3146151-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the result of a cooperative debug effort between
Realtek and the ChromeOS team. On ChromeOS, we've noticed that Realtek
Ethernet adapters can sometimes get so wedged that even a reboot of
the host can't get them to enumerate again, assuming that the adapter
was on a powered hub and din't lose power when the host rebooted. This
is sometimes seen in the ChromeOS automated testing lab. The only way
to recover adapters in this state is to manually power cycle them.

I managed to reproduce one instance of this wedging (unknown if this
is truly related to what the test lab sees) by doing this:
1. Start a flood ping from a host to the device.
2. Drop the device into kdb.
3. Wait 90 seconds.
4. Resume from kdb (the "g" command).
5. Wait another 45 seconds.

Upon analysis, Realtek realized this was happening:

1. The Linux driver was getting a "Tx timeout" after resuming from kdb
   and then trying to reset itself.
2. As part of the reset, the Linux driver was attempting to do a
   read-modify-write of the adapter's registers.
3. The read would fail (due to a timeout) and the driver pretended
   that the register contained all 0xFFs. See commit f53a7ad18959
   ("r8152: Set memory to all 0xFFs on failed reg reads")
4. The driver would take this value of all 0xFFs, modify it, and
   attempt to write it back to the adapter.
5. By this time the USB channel seemed to recover and thus we'd
   successfully write a value that was mostly 0xFFs to the adpater.
6. The adapter didn't like this and would wedge itself.

Another Engineer also managed to reproduce wedging of the Realtek
Ethernet adpater during a reboot test on an AMD Chromebook. In that
case he was sometimes seeing -EPIPE returned from the control
transfers.

This patch series fixes both issues.

Changes in v4:
- Took out some unnecessary locks/unlocks of the control mutex.
- Added comment about reading version causing probe fail if 3 fails.
- Added text to commit msg about the potential unbind/bind loop.

Changes in v3:
- Fixed v2 changelog ending up in the commit message.
- farmework -> framework in comments.

Changes in v2:
- ("Check for unplug in rtl_phy_patch_request()") new for v2.
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.
- ("Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE") new for v2.
- Reset patch no longer based on retry patch, since that was dropped.
- Reset patch should be robust even if failures happen in probe.
- Switched booleans to bits in the "flags" variable.
- Check for -ENODEV instead of "udev->state == USB_STATE_NOTATTACHED"

Douglas Anderson (5):
  r8152: Increase USB control msg timeout to 5000ms as per spec
  r8152: Check for unplug in rtl_phy_patch_request()
  r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
  r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
  r8152: Block future register access if register access fails

 drivers/net/usb/r8152.c | 269 +++++++++++++++++++++++++++++++---------
 1 file changed, 210 insertions(+), 59 deletions(-)

-- 
2.42.0.758.gaed0368e0e-goog

