Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD87AD908
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjIYN02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjIYN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:26:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835310C;
        Mon, 25 Sep 2023 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695648360; x=1696253160; i=w_armin@gmx.de;
 bh=CWO8T4kiHhHdhar2QuYz55rr18W5ysgSFVePDmC1eZ8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=aBfYQ1zpfObwLt+5ekrDOvB/Dv27w9AVbx2zo2W/wXbMUM246hJ6PMDoqBbZqshDHEA+VD7H40q
 TjaBbFrYidlBQK9bpO8KZ1MzMD5TZgDNzd1iZPwpixM+Tjh4oSZA5ERMi1Aw8PGN+U2k0IJ20Bcj4
 wsNi32eAlD1H+/1w85NEoRdu6xgoNiLg+z7qlMQIsUTrhGCXSzp8FLMSG+m0owaVZsqq1J+BhVUCS
 Q1Ob1ur2w7CZw0jzX7gRt0JJI3fLDeqqE9vYDQZ7TPaqnuW4kuDdlrzwSZKS7YZdpLcpuXPdX3sZg
 kruyXMNUtYQvEbHM8qI5kku9tyG3zvoRmQUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYNJq-1r7Qug31hS-00VSiI; Mon, 25 Sep 2023 15:26:00 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] platform/x86: Fix reference leaks
Date:   Mon, 25 Sep 2023 15:25:55 +0200
Message-Id: <20230925132557.72138-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7FmSj3nS+XlU+rDvkBXxainT36sX+Ho08oJaa0Wq6xDY6/6br84
 u0J5WUC4TCk/vP6Rl9lNeQbhP2rDi2QgzzrbI4m5MZuSAGX/Ujar9F7pGNOFNtwSCgjM30a
 4c2qUfRwOciRilNOTZEbNpE2iYp3LtDOsw3vQSdiwsmrIc5rhZsYSDRqxhf28MbXpjpkiIe
 LIiswUzi/sJ2mqSFoHObg==
UI-OutboundReport: notjunk:1;M01:P0:ZUpRUpSbieA=;TbYe6f7OzcniIxKI0D41j4KjZDz
 V0mZBDxzFNiObY2lY1wyke6KokUeO9mIDXEAOFTkGdNCmEUjE2SE4+ND/Jnw+OQkucIyM5YAZ
 CS2zkPs2TonyFRPRPDrWXIlxg/gqMfD1uD21v9kDV7S706LzHb8UBxc2n+qBOKIT603Q6K2Fd
 5haxl+NtLXRFgaKTvXqIT4HJfWZVsCEz3CYXoEKczUnd3SmvpIq7fzQ2Euz4+mAWdii9rNmTD
 313hGRYufQTGSaC+m4d1jFZ6MilLcvW4ubew+l3g1DLDf4aojn4POIev1Nt4plqMWLVOqYblQ
 +uEN7Z/ghHzbvG1a+6dG34c2D0h0aTCoelgg4TaalfBbwOgx92vKuGOxX/r72WbrfhbAqmZ0l
 jZfldeti57HJUFXwPQaVwVuwRRbJWkiBxbBNgsGrMrfo/gWi0yfwUV9ujbvTPiIShkK6yYDGV
 bxyUol18uSJWy6D+UA0ib+VYqldDz/3jekpvHM0hPsU3wl6nNJgWBXfBTelF5mvVonFv68OLY
 jdwfp4tzIsSozSDKpBKEh5T+TVqKCZsJIIvBv346WolaLT3vQGyi6aftVACfdrCCyNeLPR5/l
 ILz2STHiqpe7w9bcfjgDITFIHXrBka4ONozT+OPzjjVUL6VsA1oj4XfrDpBPBF5eQnBgmR1fw
 FR5/7PROR/iFojz1VBNCdUvbPaq3nnAhYiSehlTHdRbtOe832iG1I1ZPmDi8vj+YIQTZxe05T
 e7wEVnqbR5F/XUAVeJGTV44KitdQ4fjPmlk2Pg0bcP3GliLz95wDUae5Sh17Hd3xdxM8vwHwN
 /92xNZurZQbPcaPk6+1fy/PHcy27Lp5K56TKLAZ/UjrP8157kG2OLueOXr2xZQwI4VPPRYarA
 dFZtKi7fDswWscp6q2zwfW03eYXCS5PVRVVeQdWEF4NzJZLVFq0ah7Gkp00RNq9ZBz7+l2Icc
 1BvfJC1NyhUUFY38pg0LTnG/mMY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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

