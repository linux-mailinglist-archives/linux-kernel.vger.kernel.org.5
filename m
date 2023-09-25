Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A37ADA17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjIYO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjIYO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:28:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB410E;
        Mon, 25 Sep 2023 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695652103; x=1696256903; i=w_armin@gmx.de;
 bh=CWO8T4kiHhHdhar2QuYz55rr18W5ysgSFVePDmC1eZ8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=iE7msq3LGeEFPXbFBZfp09mOJOFfvsE+9+HFggjMWFqU42n/9KVRE4nmTXB+4eh8b2w0pQ8H+8N
 JAbaOb3/NBxENicnoJrL4Ans8x+B7M3Z4Vic+zDlqA1ktngt1YLCcoAG5MYa+DAWG/asBr+ox8M3F
 SAVTmk955PhM4eNEGeYUAKqE5o3OwF0jQKhNaMPnx9rNAurWnYAgdZDrUP/HvLVbqJJ9qblRAShoq
 o9eJ6R0YPjqefb/P6iLxNmbkAeiMDfm77GyppLs50osjaLXP6yAWYSI1xxX3eL1t2G3b28NuX1eDV
 7eb8AZUGELVqv6StJBH89E6VgHq+1riJ2xLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MhU9Z-1rFhbw2VH9-00eeyy; Mon, 25 Sep 2023 16:28:23 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] platform/x86: Fix reference leaks
Date:   Mon, 25 Sep 2023 16:28:17 +0200
Message-Id: <20230925142819.74525-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HQPXnywH2xZZbhsTK890/raUxJkTkUb7Fv39TFUAFG73wFE1oxS
 iw175gaQnMRrREeeOOhLy65ORORNqWnWqifE9c0gMcrE2bSGkB2FVcwZ6u7aGwcxd2zmM6H
 tdeKKRNFPLmUt3RvVcW9ExkuOm79qp/9LmakfZy8BR7+agaMGPJBL1PPh3q1axgB9DPhrxD
 fFpg00Rtv6m5jmmjhco9g==
UI-OutboundReport: notjunk:1;M01:P0:iZ542rEmHXA=;e+TNDwZ5hRC0vlET3hTVp6gKna2
 s9/vbFZBY5k0Nm3DZgnrHOAdt88aH5INE5uwM+hmhc12EFe5sJXiapSeiwIEaA6DdYTKrxw2q
 o01ZzFEJK5lvjoEjCmr0I5E1vnjX+srpiDwn5qYzNvciAF/wvQ7KQVffzsjrL0oYqkoFzb8zO
 KU7yWdCIxTNusDAOFuEhIfEXtYOO1DEdPLrSHL4xbiZqGf2ek8fpwQ1dEjIVs+j3NeHsy5w6V
 ihzyvisJs0G4ceDqwPWu0xTuy/PRseqLfBQqaYMrCoVl1qxlV3ECt6sgOOpRegjdxw6U0dSQg
 FsJDBliAopAR/Epp7qnmiTNrTp0U0wF43blKoi/EawiGshNmdItOohH4XZ7SA7UgUWwX0y6Tj
 3QyBjTYQKuBg303/UzXDMzH14csw+5HzOyfml8TaW6np6lWWr0xg/YiMSDTHFa7FEZerif+7k
 Uc4+UJkVPk5F+Kpuam/YdYSFQPKgaxiNXALkmNLQV86aGNZaj1macH4MsiOFjdj5B0mhY/TWD
 nSO96mm0yBK91zIXuG7n7fkqrmu6dyEbwW9izOinmNZRlKQMYdcm/bVxkvnoWM/34aKUOFCxQ
 A4KmQhxbgScHvzugG0nTZQFID0a6OLfElRci6hpyKmy1FdgnLu9hF31YKQmqSE2SlxMIJlpWX
 fjfH2Y8kDa80bmDOg8kWk33ylQ5o18vS3SisNE0Q/s3bEfFWWxZ9yKk14wir620tBtSgLqy+e
 nE+qctvQG4pRDHOgEEOFrqZifhOjddNeh2XPPtfwp0Tbs1xbF9N0cXihG1Ms/Nc1CttK2sCV+
 zZJsd4oEP/2Pfn98BCLGzyS/4Nd48QYQdCTTu5hkIFB/jMyfRqTDPMhE4uwl0FsUzH6wsCx4u
 yUWEHy85oAE2gCtWk++Z5dBiCYG/0S2Xlt2aF97BuQf1mfbT8lAnKdcSSYAvOVzfPTYvU5jeZ
 UOwA31aApfnqntWe0TDE+4/UAbU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a duplicate attribute is found using kset_find_obj(), a reference
to that attribute is returned which needs to be disposed accordingly
using kobject_put(). This issue likely first appeared inside the
dell-wmi-sysman driver, see
commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak").
However, it also seems that the bug was copied from this driver into
the think-lmi and hp-bioscfg drivers. Maybe a more abstract
fw_attr_class could prevent such issues in the future by abstracting
away the kobject handling?

Armin Wolf (2):
  platform/x86: think-lmi: Fix reference leak
  platform/x86: hp-bioscfg: Fix reference leak

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++++----
 drivers/platform/x86/think-lmi.c             | 24 ++++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

=2D-
2.39.2

