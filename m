Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72CC797011
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjIGF1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIGF1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:27:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447821BC7;
        Wed,  6 Sep 2023 22:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694064404; x=1694669204; i=w_armin@gmx.de;
 bh=x5Ku9JcDb0QJRjqEhEbb7lYtuC+gMEmAhRzuV6k+xDo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=AfEv2bx8Vq5hlDSgTCkthc8eNOBgVcoc3H0hWnX1oTDEWcnYlV4HkYLHK+4TZ+q//d6h69e
 +Ll5y2J75j7RqkgnL4Vinj7cpmGsqjHOTN33eHye/q3BG47oyIn1ntlen+ahCkTJFCuhcmxKl
 rsd4L+xGpnzc2EJ3CfxVKx/Ti3qH/y/bl0AMTkujtV2LaZAdUKcDO4pXO9Pxq7ubf41v8hqW1
 yC2YbyOTtykkwuozlLWpPZMTaP5Dtcbh6s+KPlLAdoJvFFyILpmy4fi588GA/RJvvhTmlAbgq
 mHui0KqgSSDWy8THryLPFcNYZFdu0u01az0r4t7GTBYWN9FDywbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MV63g-1qFKdB3Yf8-00S3h4; Thu, 07 Sep 2023 07:26:43 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] hwmon: (sch5627) Make limit registers writable
Date:   Thu,  7 Sep 2023 07:26:34 +0200
Message-Id: <20230907052639.16491-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A8o6UuKhglRizwqqz37TSygnLJ+qQcMRbA4ekWiXpMyxglQTc7f
 /E0bkHg/z3QFVGIvM1Bqy5RrJ9zVLsRUeiu6yYRlagq3C6T16wFeJfSd46BvE32MZM03lBM
 vkUrg2TwwJFTKJQvF+sqysvLqGY1xaMUFWmp8LqRgce1rwr1X7IuNt+JItCIsf+Tr1LBeZ2
 PE1FHSC2dh+b+wDq3krGw==
UI-OutboundReport: notjunk:1;M01:P0:yN0yzQUs5ow=;02W4aoVXVfcm31e2vrVQgDEHIbD
 cYQA6/J0P4/4WbiY7cB6aeyEJYEA3aVBG55S3SaiW3FG0PJC+LjPk4pgAWq4YtkYbr2lGqtCN
 AShTvTMT8qGVT4J4eCaOik0rupzJ5RixdFrnXrUxQuQoEups4AoiIyZvK1c+FpH9wVJmft5Rb
 snorLah9WrLVWoOcPko/7X8Ce1CpmqWdKz/jbQeMR+o/0Tcf3vUpQsqKyyDNL0QLk9Ie2r6Ia
 CPfNnaOXhd5lNb/VDd0i35gNHQ6/piFQuB1qDIOQFD2BVl39aEnJcyDr67EmFQV1Fdbkc9/1o
 q3UemakW+eDHvY8L3kglV4ViCQDfHHVx4jKug6GHsK78P0KX/udnrN5Yr6Zsa9JuebkRCzAAi
 aDbmaRDKzXLdg4dMfz3GAGeV9tDqS+kqDTitIUUtg/NhblEvmgOg/LJjssvEM3EMKIp+SABaw
 4nlXrLrYddQxpjbg5m9a7HYSbj8iEMdU4qNVYSvyXuCb8qzpacLr/WhKbuIkP9MKBDQG1ZuCX
 PMvH3oEM15uYXn9nPb+vyoZwRwt8820dPGz68xYibzrDn7xoxAi7hjOah4+8O77nvvJG5bsQO
 3ZK764nY13wyZH1rM2aM1fXlJa9S2Ldpwws069MAZVWWXwD5QcjH120Sq/vZK318FKq8c8iCh
 i7Iq/YJhxGR1eYilzdqKJyfUY5pwOtF5zj1oJYuRoMMjv73/tx6RNB9mdQHGjTWIiAVGvswxr
 QbIsr1XTrBJ+2WmGB+Nz9hpqqcHlHSklwJkwd7iYeCh3D6LBP4YicXhWut2wE5DLk/5pxb9+4
 /jWY365RQEZFOGWfmiBBrLIizTqt4QLJdFYZ3HNWI6tNlONuiaEdtYLDE3dHBoS1SiycA14FY
 HC5U/XxQ/a+9r9rRFwCIAGVe1qDzE9Xvgr3uHkYxZfi8eEXoy9Pe2BPkKMoSBab/JOc43IWah
 cF6ulL4iXVBVwKfrUrJgHKSSk1A=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for writing the limit registers on
the sch5627. The first two patches fix the handling of the LOCK bit
inside the sch5627 control registers. The following two patches
introduce regmap support in order to use regcache for caching the
register values. The last patch updates the documentation regarding
the behaviour of the limit registers.

All patches have been tested on a Fujitsu Esprimo P720.
=2D--
Changes since v2:
- split patches into separate changes
- update documentation

Armin Wolf (5):
  hwmon: (sch5627) Use bit macros when accessing the control register
  hwmon: (sch5627) Disallow write access if virtual registers are locked
  hwmon: (sch5627) Use regmap for pwm map register caching
  hwmon: (sch5627) Add support for writing limit registers
  hwmon: (sch5627) Document behaviour of limit registers

 Documentation/hwmon/sch5627.rst |  10 ++
 drivers/hwmon/Kconfig           |   1 +
 drivers/hwmon/sch5627.c         | 267 +++++++++++++++++++++++---------
 drivers/hwmon/sch56xx-common.c  | 107 +++++++++++++
 drivers/hwmon/sch56xx-common.h  |   6 +
 5 files changed, 318 insertions(+), 73 deletions(-)

=2D-
2.39.2

