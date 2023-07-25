Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4676254B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGYWBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGYWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:00:59 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30DE0;
        Tue, 25 Jul 2023 15:00:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9e478e122so5536861a34.1;
        Tue, 25 Jul 2023 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322458; x=1690927258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxN5Cc7Zc72irm/qgq/pZDW5Q0BP09uehHsPOp/dI4Y=;
        b=Wk7Z50ipI0jvX7dwPWATsewRqjTx7b9TNpWXfSxGVv2VCvJA9Fhj93WGGmCFJbbMWT
         svx3lYre22SYZ0yqwThUw3+YVKkamXkJR3a4EuP49CkIfsPfHjhJsq9gjt5uZhcGCpyk
         xecVB05BBJy3CPdL3nyRra1qnenwvmK6h5zZV/b1yYSz2z7TPJjp622LFtyqXSrmL+/Y
         Gvk2uB+T27BMo4Qblt4BEqSqKZ9IMoxz1gha2T/keuOSd46L56MT73taX97uvj3LFdBj
         /F9GnugZQIozksen6U4lHVUPe+08LWTx1IwBx+x8pdllRwtr5X620mc81f/x9HGqy9DL
         1c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322458; x=1690927258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxN5Cc7Zc72irm/qgq/pZDW5Q0BP09uehHsPOp/dI4Y=;
        b=TACE8w4w5Cy1pGnSFtw3VSgdM5BIFviRxEaIWmvrhSFF1km9ddGn+ASsHxA/+TYXh/
         SFJkyBsmmad6pETh1yNMtLnusqo+FBLDTWawk/CRzrT5rADHbyei4sM00IODjez5KPA4
         UIg56o6FV9oUirsp3usUJC26dSt1+TyFRTBzaGlNzNbTi+cbVjtWqPgNAQM6oo+ljh5q
         7EkY3Vuo0sxODw3clL5Mab13fawGaFqEle/Qa2q840u9IV+sDQC2+irSq22gm/Lu3lNh
         RkgVgb+DunGpEb1qcGJW7ntXizZUQP5hsOO5NtnWqJL5JXVJgArhiGKPIaISqqwWAnVt
         Df1g==
X-Gm-Message-State: ABy/qLbL8SmHMiNT6TE2jVWQsPMqtyw+tvU2RPZFIZXxQEfGynp+bkj9
        5j5W0+G2xqGcu5+5bn4hRJ0=
X-Google-Smtp-Source: APBJJlGhLgoGB+6MrON/H7WEp+vL3vdnSgIQQgTRSBWuhtndGLU3upZAWkb5SJnppSJbhOYPSvsiXg==
X-Received: by 2002:a05:6870:d183:b0:1b0:7661:dd18 with SMTP id a3-20020a056870d18300b001b07661dd18mr457536oac.23.1690322457836;
        Tue, 25 Jul 2023 15:00:57 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:871d:ebb3:c6e2:8ac3])
        by smtp.gmail.com with ESMTPSA id v40-20020a4a8c6b000000b0056688eea98csm5870026ooj.27.2023.07.25.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:00:57 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH 0/5]  hp-bioscfg: Address memory leaks and uninitialized variable errors
Date:   Tue, 25 Jul 2023 17:00:51 -0500
Message-Id: <20230725220056.25560-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submit individual patches to address memory leaks and uninitialized 
variable errors for each source file listed below.

- hp_populate_string_elements_from_package()
drivers/platform/x86/hp/hp-bioscfg/string-attributes.c

- hp_populate_ordered_list_elements_from_package()
drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c

- hp_populate_integer_elements_from_package()
drivers/platform/x86/hp/hp-bioscfg/int-attributes.c

- hp_populate_enumeration_elements_from_package()
drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c

- hp_populate_password_elements_from_package()
drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c

Changes were tested with a HP EliteBook x360 1030 G3


Jorge Lopez (5):
  hp-bioscfg: Fix memory leaks in string_elements_from_package()
  hp-bioscfg: Fix memory leaks in ordered_list_elements_from_package
  hp-bioscfg: Fix memory leaks in integer_elements_from_package
  hp-bioscfg: Fix memory leaks in enumeration_elements_from_package()
  hp-bioscfg: Fix memory leaks in password_elements_from_package()

 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c   |  8 +++++++-
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c    |  7 ++++++-
 .../platform/x86/hp/hp-bioscfg/order-list-attributes.c | 10 ++++++++--
 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 +++++++++-
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c |  5 ++++-
 5 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.34.1

