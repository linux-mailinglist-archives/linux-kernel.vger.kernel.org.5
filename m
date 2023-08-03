Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E976E809
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjHCMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHCMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:16:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B8FB1;
        Thu,  3 Aug 2023 05:16:21 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E390EB53;
        Thu,  3 Aug 2023 14:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691064916;
        bh=71aqxrcVkXQAOaFJNfaGFMYvmEYrEkll2SO6PnN81qw=;
        h=From:Subject:Date:To:Cc:From;
        b=qNrnqRG32ZrgKEM0IwQ4Uncxu2w9Q4CL3cezcLNP/ImtwmmPSsz0XifskBI3q6WQJ
         RJ9eZ7P3tOVVZaWq1rwtFcyHTtYVDZDYGtccUd0njl0fgU5MeqKoZJzpeyMuBsC+WE
         qvGEAtHt23daOIHIhvXjXkYMOKmsSsFj7oIvawxk=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/3] media: i2c: ds90ubxxx: Fix uninitialized variable
 uses
Date:   Thu, 03 Aug 2023 15:15:44 +0300
Message-Id: <20230803-ub9xx-uninit-vars-v2-0-512570ecb798@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGay2QC/32NQQ7CIBREr9L8td8ALba68h6mCyjU/oVgoCWYh
 ruLPYCze5PMmx2iDWQj3Jodgk0UybsK4tTAtCj3tEimMggmWjawFjd9zRk3R45WTCpE7NuaXiv
 OJIe6ewc7Uz6cj7HyQnH14XNcJP5r/9kSR4Zi6JTspBQXNt/JWBW9014Fc578C8ZSyhdo3mXou
 QAAAA==
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=869;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=71aqxrcVkXQAOaFJNfaGFMYvmEYrEkll2SO6PnN81qw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky5qPnVpDYhH9WqTIMhsd/w2JSvjAUZzuCarXE
 MEOOHM4W9OJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMuajwAKCRD6PaqMvJYe
 9bwID/9gNtA09oAZfPpBmzbB7zB6bYeb06hSjWkg5HVyB0CLQ8oUmMRrrWdajAffDuzlmiFACyA
 oE7VrjYVONdYV/TqEs5kUiWVqMSXTAq4kxxcG74Sk0WNEtJQMW6j1G5uXPFHmLx3Y5gIlCmvC4i
 6zjs+NnaoIEhVmpJlNht3HWjzaXPw4aEuWr55mTJ/hAJmNZ6/U/eFuB7XN7ZMOSdrbUgJYEPyd1
 q2uOKN0Pxuy5Aug6nx7DS8Wa+r7PHa8TTt9zIR3w6El2dD9cuVGRZCCyEgJsCmVo1TWRfvabYof
 LGEADfV43ulRUTpPqx5zB/1ENF/mx11+JsiD5Fk+kTpfaArPzY5zxCNwRyXdSLWbTodMj7eK9Q2
 AtXn7oS8O+VqaIe/TtydrqrtlbTmPtoUfapAYaQthJK14p+C6dqflCij1ven0e1+vUSclWDXCZ+
 seE/8rlk7bPwWtNhMmI8NR1JvnaUW6CsgAzXjHqzHYK66tOfZvXDyvN4Vt42LysVECQi5VAHF5K
 kJLjTL1+dHn4xMYybNK3GOLRo/JlAP4jpIlD6dV9B/MGUfwwNM8nGG6OkY2gLQ7fMs9lqvuTiTY
 95sseO9nl6BS2W5WAtHVToEJVdLoBQsMsVmOa3eKQIitECqHsTWjGe28SOrfiIrb5vGYID7CYKn
 WiInBgPATGiUqmw==
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
Changes in v2:
- Split the ds90ub9x3 patch into two
- Link to v1: https://lore.kernel.org/r/20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com

---
Tomi Valkeinen (3):
      media: i2c: ds90ub913: Fix use of uninitialized variables
      media: i2c: ds90ub953: Fix use of uninitialized variables
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

