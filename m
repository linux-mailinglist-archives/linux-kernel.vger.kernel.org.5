Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F757C76C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442158AbjJLTaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441868AbjJLTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:30:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3ABB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b1df4ebd52so72139b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697139016; x=1697743816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIPGKLqX4lqtP5rqVW/Z8WpP9n2U6+vzX9cu74+l4o8=;
        b=ClwdjZhHqjwVWio4JhMuQOREFoSrMk1z46czHsayyHLj3fLWFYQ282jFfOtwAl0BVe
         n0FSgg1bBaRBtHKQUvGzhpJgEQs2gaBawGQNHBDZ/ypg2HTnPKFfn8gd8h+OpG/r0l7n
         M89PgIVrMXRZ5/pBOcFhp0wCwuuR0SuXMaD2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139016; x=1697743816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIPGKLqX4lqtP5rqVW/Z8WpP9n2U6+vzX9cu74+l4o8=;
        b=EpVuMdidtWeUeNBs2Ek+Is5Zklrq+xgvLD0/9WmQsVY6J0LOyRbk5Po3NmDcZ1xnIm
         9kEK0ml8uEl472S1kp9YiDt9UZl3VosWGYQsGLMY6DvaiGAJ8rSAWPJABGH/61kGXaCS
         EGyh4JfsVxyxyJBVmtAOpXwmY9IZynBiKMjV3ytpO1+azXlbwB5t4yIECwbdI24PNbal
         r4W4wmvuQlSHH7KT+m3Kg5eys9vPtzPiK72VAMctaTnne/H0LR5PFqr3Bfw8wK1hiAJt
         i40mpVZvA/6XrC6SaOmxA+jlguggxucEwcEZR+FoaXrxAGlX1PcNp2xTqhl8yqMsb2TM
         UwcQ==
X-Gm-Message-State: AOJu0YyYAAcXW1fDlukq5ZhdZyV2h4QO23uf/8EVFac5HS6QW5DA/RD4
        dbbxb5We78ASZG3LpoWy1CBoqQ==
X-Google-Smtp-Source: AGHT+IERPTwnRrLuIcrF/qVItuc/Etf9Gx8qoNlfYGw4E40pryplJea9aQ7RybHzVk/5huQZcu4ZiQ==
X-Received: by 2002:a05:6a20:7286:b0:15e:7323:5c0f with SMTP id o6-20020a056a20728600b0015e73235c0fmr30788570pzk.16.1697139015932;
        Thu, 12 Oct 2023 12:30:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7c85:4a99:f03e:6f30])
        by smtp.gmail.com with ESMTPSA id b3-20020a639303000000b0057c25885fcfsm2075720pge.10.2023.10.12.12.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:30:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 0/5] r8152: Avoid writing garbage to the adapter's registers
Date:   Thu, 12 Oct 2023 12:24:59 -0700
Message-ID: <20231012192552.3900360-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

 drivers/net/usb/r8152.c | 268 +++++++++++++++++++++++++++++++---------
 1 file changed, 209 insertions(+), 59 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

