Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31CE79F176
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjIMSzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIMSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:55:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9B1985;
        Wed, 13 Sep 2023 11:55:44 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B713B1;
        Wed, 13 Sep 2023 20:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694631249;
        bh=chNJdd1zcolnNrSINJke77grPOMpV8+bsyYop+wOaRo=;
        h=From:To:Cc:Subject:Date:From;
        b=HpkUBWIYpxt7jQtUdojaA1KRCB349FRTR7OA4RZpSB9d5yegO54mBmOi+9xxpykCe
         G75dWHjGhbbNHgjxU0ZYaDrqpubxyzh3u+88NJ5NlD+SB6BBaV/uoocmRXHh52OkqK
         hwmYDctllIyyvRwk4Z4EdbjdeKeEHH5bFxMjoqCA=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [RFC PATCH v2 0/4] staging: vc04: Drop custom logging
Date:   Thu, 14 Sep 2023 00:25:24 +0530
Message-Id: <20230913185528.770634-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series attempts to restart the discussion on custom logging used
in VC04. In the last feedback gathered in [1] it seems that the logging
would rather be moved to use dynamic debug. The series tries to move
in that direction.

The elephant in the room is the ability of turning on/off log levels,
which this series just drops. Compensated by a crude strings
("error", "warning", "info"... etc) for easier grepping.

The log category are also just strings (which probably can be transformed
to dynamic debug class names moving forwards?).

To move forwards, I would like feedback on the broader direction.
There are couple of TODOs in each of the patch (summarised in commit
messages) which require case-by-case discussion.

Additional high-level questions to move forwards:
1. Is loss of log levels by moving to dynamic debug, is actually a
   concern? Is dynamic debug a valid replacement?
2. Whether debugfs should be dropped as well, found vestigial in [2]
3. whether vchiq_log_trace() should actually be tracing support for VC04

All this is done to elimiate the TODO item in:
drivers/staging/vc04_services/interface/TODO
* Cleanup logging mechanism 

Addtional comments/questions are welcome.

Thank you.

Tested over media-tree master with dynamic debug configs enabled and
drivers/staging/vc04_services/interface/TESTING.

[1] https://lore.kernel.org/lkml/20230118115810.21979-1-umang.jain@ideasonboard.com/
[2] https://lore.kernel.org/lkml/Y8lHqd9FlxiXTLuW@kroah.com/

Umang Jain (4):
  staging: vc04: Convert vchiq_log_error() to use dynamic debug
  staging: vc04: Convert vchiq_log_warning() to use dynamic debug
  staging: vc04: Convert vchiq_log_info() to use dynamic debug
  staging: vc04: Convert vchiq_log_trace() to use dynamic debug

 .../interface/vchiq_arm/vchiq_arm.c           | 127 +++++-----
 .../interface/vchiq_arm/vchiq_connected.c     |   6 +-
 .../interface/vchiq_arm/vchiq_core.c          | 225 ++++++++----------
 .../interface/vchiq_arm/vchiq_core.h          |  46 ++--
 .../interface/vchiq_arm/vchiq_dev.c           |  41 ++--
 5 files changed, 232 insertions(+), 213 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

