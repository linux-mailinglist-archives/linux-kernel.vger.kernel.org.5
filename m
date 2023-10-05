Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C77BA641
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjJEQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjJEQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA9020E43
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:25:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso681890b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696501518; x=1697106318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWho0skhSMaRa5vCqQiBImFsTWWtuPWOPJgKv2q/8Qk=;
        b=hA/xL0iIrvnt1RXTv9JK4ZdJMFI6RgChT6ejXg3G9b60q1J+YKdAXGNxRXUBVp2AVo
         em2EW8vY2lmNS7y9/TTh3rMf4pgX56mxHx1pSSjGhVszv9ahzpYPCWIASXuQBThJGF1d
         63/4EP+1XG5v6AkUeS8esOukhGJLTYA+8DBN+KuInN0frNzetk2Hc08Dnu9bQ19fmzYq
         CoLDmG5qbT0RuTMD2ite8F/3BsUQoer8C+M/oTwcMMVhf63XhBasUpq+T7+hpME6qQMG
         5q50qE/U7MNiPZC5WBcd3TodQS+ot10kohjx0erimOP3gtRgg+MOoYSTJ6mH57QhoQ2p
         kL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696501518; x=1697106318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWho0skhSMaRa5vCqQiBImFsTWWtuPWOPJgKv2q/8Qk=;
        b=AOzGtuGcAidd48Rap9HLhg+URotO8WMSDzQA3U3e6AOd58BbbgpFkSugxn4VQserik
         YBmgcbRd1HDA/+1DLxnB46HbtAI0Qhe8fTVJVcV8RYuNhoenc0fPHUppEZmvb+gxcMND
         Zsbi4++LcI2pKtHPTYMroyhf6ZJS7cW/913B7/p66BjhXqzv4w/x1q9TGi6k2i6Pho3g
         QspBnlJx8RXqe0kK1QCMlZM82uIhXlZ+DP1IggESAQHDGXqtdk3qPvSR0a79UA4Ty2o3
         S/sj4emRf5F2EmEhnBLBYhf915SWtjAmA9HuTaIU/IeQDn/ioNKKbwRjsAAfsHKQFe6i
         zK7A==
X-Gm-Message-State: AOJu0YxNeqSjLHip4PZnXdYuWtNvPKubSP3jRIcWaxPIQm+2X3pQQztA
        vhXyqeFmGvXz/UZs3ghdhwuLAg==
X-Google-Smtp-Source: AGHT+IFlvWBBJ3Zh3r7swaT7Jp7XiXCsFpaOJuViBtve0Y9fYaexTcbODWL0r8ZJ90UPDzLaoMipNA==
X-Received: by 2002:a05:6a20:3d1b:b0:12e:4d86:c017 with SMTP id y27-20020a056a203d1b00b0012e4d86c017mr5640315pzi.10.1696501517838;
        Thu, 05 Oct 2023 03:25:17 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001c61bde04a7sm1269088plj.276.2023.10.05.03.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:25:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH V2 0/2] xen: privcmd: Add ioeventfd support
Date:   Thu,  5 Oct 2023 15:55:10 +0530
Message-Id: <cover.1696500578.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that irqfd support (backend to guest interrupt) is already merged, this
series solves the other part of the problem, i.e. ioeventfd (guest to backend
interrupt).

More details inside the commits.

--
Viresh

V1->V2:
- Increment irq_info refcnt only for valid info.
- Use u64 type for addr.
- Add comments for use of barriers.
- Use spin lock instead of mutex as we need to use them in irq handler.
- Add a warning when kioreq is getting freed and ioeventfds list isn't empty.
- Use struct_size().
- Validate number of vcpus as well.

Viresh Kumar (2):
  xen: evtchn: Allow shared registration of IRQ handers
  xen: privcmd: Add support for ioeventfd

 drivers/xen/Kconfig               |   8 +-
 drivers/xen/events/events_base.c  |   3 +-
 drivers/xen/evtchn.c              |   2 +-
 drivers/xen/privcmd.c             | 398 +++++++++++++++++++++++++++++-
 include/uapi/xen/privcmd.h        |  18 ++
 include/xen/interface/hvm/ioreq.h |  51 ++++
 6 files changed, 472 insertions(+), 8 deletions(-)
 create mode 100644 include/xen/interface/hvm/ioreq.h

-- 
2.31.1.272.g89b43f80a514

