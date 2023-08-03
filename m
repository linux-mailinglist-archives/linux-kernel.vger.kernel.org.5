Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA276E35E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjHCImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjHCImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:42:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202ADF;
        Thu,  3 Aug 2023 01:42:00 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 166465A4;
        Thu,  3 Aug 2023 10:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691052054;
        bh=OTzk0Qm0yo8Zu9ycksYQ0HDa3rKtirpqqjtreK1RHmw=;
        h=From:Subject:Date:To:Cc:From;
        b=ngbOXOZ0Ut+y0nDlT53Uzp5fWlSuRVsPkonFOuErLzbRDmzQ0E5tg2IyHdLie/P6N
         gax893VaPCdQ4EvNCtuOQ4JDHNVRStP2NKT83FEpoHapiok27vodovQ3Qy4sUuZJU/
         /+2tER0Uxa+l8uEcWzPDUNXVbAe0cB0v0awsWyO8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] media: i2c: ds90ubxxx: Fix uninitialized variable uses
Date:   Thu, 03 Aug 2023 11:41:37 +0300
Message-Id: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFoy2QC/x2MywqAIBAAfyX23IIm0eNXooPWVnuxWEuE8N+T5
 jaHmRcCCVOAsXpBKHLg0xfRdQXLYf1OyGtxaFRjVK8MPm5ICR/Pnm+MVgJ2ptA5q1WroXSX0Mb
 pf05zzh+OtEJ8YwAAAA==
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=640;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=OTzk0Qm0yo8Zu9ycksYQ0HDa3rKtirpqqjtreK1RHmw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky2hPU5xDVk4BMoArrKn8iq34dXcKZhfxWAbMA
 vzhhjU8NHSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMtoTwAKCRD6PaqMvJYe
 9TPtEACgPvWhrDLw8E4QMxTGU9bKXNKw/ycRSdXqAseFVfYOsrG8gCGVR5KvnGIawfLbW1JciDE
 fCHxrH/uIEGiKbmaobIiNYRFlfn6Tj92EqOwZkz5Gg1zHLmpLM51ooXysUYkvBeWbL1uRMDqCci
 Lhb1gHgfqMF61C+EtzjNgyaKy7GBKoMxH3Geuq0QAXTFE2UeUrB0gq2F+X4npPW6oPgkUaBMSVr
 tQS05q9Gdxg/QiKoRGfAiuWZ8+lR/sXSRfALwhF4PyC/t9VSsiQDrHc9SYO30uYVrwX5inq0UEy
 sqmSO1x0oxELPG066t1buqTDIs34RjPjNb5YFl6LcTerw/MeptRy0zHBxoH/UJlZKxf4NxGjS/f
 Moico6FBWzJ0HhIAhCoO9buvuowEHw2wK1+Djm6R/KOgboznrEGetg5JSA/MlWjKT8cUZvAnzxS
 rLsDbcuLdb1Dcwk8OqiSO1FE6wCN4xPFdpGdKm+jKRIUw+qmowJfe5Y1yyKLZ81N1RtU38ULwq6
 zKi75FNsjC+jeqvgph9aOkpQSqgbS/+HX9sp4EqKBW4Bw/1lUp7i+n8llXHKYFneOZB0VmkHnmY
 LQ+nzfHzln2wTqH1ywxUIY/R0phN5j+g3N8kF0nQUmZyEP7vkozWYmX9E1IYY/mVQSQNWjdcfH+
 MJyciyZIqCvC3PQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix uses of uninitialized variables, reported by smatch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      media: i2c: ds90ub9x3: Fix use of uninitialized variables
      media: i2c: ds90ub960: Fix PLL config for 1200 MHz CSI rate

 drivers/media/i2c/ds90ub913.c | 2 +-
 drivers/media/i2c/ds90ub953.c | 6 +++---
 drivers/media/i2c/ds90ub960.c | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: a0e657a03ffbd26332f316f13c3e5dbc98cb1fca
change-id: 20230803-ub9xx-uninit-vars-733337ba1051

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

