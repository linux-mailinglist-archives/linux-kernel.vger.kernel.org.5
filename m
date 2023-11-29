Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA67FD347
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjK2JxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjK2JxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B106B5;
        Wed, 29 Nov 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701251578; x=1701856378; i=wahrenst@gmx.net;
        bh=SNH6xHQWrsdVQ+VdgPcOUcLoGDMghtrBq+lLBnwzxno=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JtnLqLey3Y1QUJj36oEx2Fbtx/X+L8xM9gR99mXtkTRYe50rLcOmKYYHtoZMeBeF
         /3OOA/sriD/+miFU7IAjv56l4rVVmchB4FIrmQnuTHBM7DLJGLGlNn2Cala6htFDd
         UsemVG7pq9ugDV8hnBD1D8eLuPIHyIMsmivO/iSlZIW0XO2NWLgzsSJC6Zz6VsRn4
         LqpIVuWOsYNq3O7EkFptPoqXcEpHVys9ftjQNrZXmk2z5WWTAt5ZR8jZqbcBXyB0A
         dyc762VHtU7ejcK0oCiLmXXq1NnuspoDxc/fpYztCscy8L0kmPWipq2tS16f1feQG
         9x8o4yb+14ISl5nmkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1r0saH1QWB-00BvA1; Wed, 29
 Nov 2023 10:52:58 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 0/3] qca_spi: collection of major fixes
Date:   Wed, 29 Nov 2023 10:52:38 +0100
Message-Id: <20231129095241.31302-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/0ezHVdpzgHEk3B+U7fLc9/ksehu50e9rREgkJDGyq8eXmZze7q
 ez3NioMUcEwd0HXspVyn37F9C5Sq/xZHf1t7Jrc7K/DrbTfqYqBYBfKdwh8W+TyWWyaB1jh
 hZFoTpxqzuiuzh/zhR+s5iudJ2HIomzvpGiDRIyw+RgkI7cbeK04w/rYVYh1Kd/rit37V0P
 hYzslzRK7nfTZMiGHYFRA==
UI-OutboundReport: notjunk:1;M01:P0:YOZIfcCJ440=;s5H+E5PGRbxGBfB9RYdE1gDs984
 dp2bRAFQzjUpzXVwzxjukyHP1+uq8BRHk99uYV4JBxipxU4fR8Pm4J7Tbv+EWZhopFbbdKo01
 NDk4AB//7aeAGK6owTrkg8AZUYTFQwgBGR9I7c9eyhheyw7NYwOfLYMMZin6fPweEpEy0x48H
 rKK8A0s3JIhpmcCU5CaD/MtvzoB8DSlBDxVrONhW7IUXojpBehVxyXVdkE20pPdkDsCbBUZl3
 pxYkFmkSGc7cg/rWBPxDDhB3RFh66kLSl5gwKz+ISdV8Y2YTNHi5SPxHG2qd1+L1Odi//U0uq
 RBkvOlq4C+CpdeC56Xw31rsGAaGMwhXfAIHZRx07A1wZILW4/u8fft8RvrgLsJyfaW55qvjWh
 QRhILuFjmwY1o8ORGSPgThObz8jKWuXqktVbTQdMIVCjysUwLLgUVcQxfBDxZo6veWnSFsedM
 SsMWdVOnlpd6vMX89ch7zqReg9+ksNFtmK52iWbz9+UDP8ynXIiRRA/ENHcwS2h4JRvwJXU7i
 ldWRZsJUS838C4aIprJ7ikNugUxRoHuemex84dBudC1TM1HOz5YQU8QuWCY0HsZOXBpUILw4w
 JGorK1M5xOZcIyRFuiwrWJyEdeSFtbxa1ThIf/FliBL7MHc42Tnskx8WE05lzNZczPoQkeagi
 T2CIxziPY7vEql9lUBgX8gqENKmaW26QUS01TRCegr6oAX+aIfbILSIiPX85pyBMRYL+/uyPl
 nTyLTjXZFZ4Wz48LPPBg/Vy6htEnJvhFfXdDSYgEG2STrX6hw/a5ZPL1ME13pBVJF4PX/yM5S
 IuVcxaw/+nWMo+w+Lpm+ZIiTxLX5J9ouTCP9EYHv027XcRMkC8xlpR93QzSLF8BEBVCIPOIaB
 lEEJr7jP+pZJX+8zHaA+EzOWFIUmMXd7mE7wXlmbFWad9/G2nHf/UbV0NDp9DkVRBsbIydi7R
 JgTUmg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a collection of major fixes for the qca_spi driver,
which has been recently discovered.

Changes in V2:
- Address the crashes caused by TX ring changes in a single patch
  instead of two separate ones ( resource allocation rework will
  be send in a separate series ). As suggested by Paolo the kthread
  is parked during ring parameter changes instead changing the device
  state
- As suggested by Paolo keep the ethtool get_ringparam behavior
  and just fix set_ringparam
- improve commit message in patch #2

Stefan Wahren (3):
  qca_debug: Prevent crash on TX ring changes
  qca_debug: Fix ethtool -G iface tx behavior
  qca_spi: Fix reset behavior

 drivers/net/ethernet/qualcomm/qca_debug.c | 25 +++++++++++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.c   | 15 ++++++++++++--
 drivers/net/ethernet/qualcomm/qca_spi.h   |  2 ++
 3 files changed, 32 insertions(+), 10 deletions(-)

=2D-
2.34.1

