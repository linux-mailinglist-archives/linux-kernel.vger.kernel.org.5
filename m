Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A27F3A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjKUXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUXOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:14:00 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A585210C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:13:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507bd19eac8so8084995e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1700608434; x=1701213234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2L9dMn1KKZ1/ioo/PFLD/+csdsIYO11PXlZaQcONvA=;
        b=UrhZivy+aWLPCYn01YylneFCyNnCmHQPFU3Z+FE5NdzJIlzsy4NFY7CjA+mL9DN+x3
         cwi2EjoSus+VqH/lJqQEBW1Q6rVkR7jpmO2a4+B2wNkIGTZ+nj1cxzKxgLgFZBYUh1q4
         WrV4TPKzIO71hTBGdN9OeMSAAIq/ChucF+EUsBqn05OOITFu54Y7/exkbeyNS9IFoMMA
         CNGGCURT1HlL6e7GO6miO0IlJZ+OFwXtIkhsRM7jmg/mEocCa6bvV6beTsldmK6Kj65L
         EgikIh2OzrdJFqsrBJNrovBlZgUaQ1Ay1mFa3WXg6jiiJwQ5xDVYthIk8oZXy5R4wLLL
         4+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700608434; x=1701213234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2L9dMn1KKZ1/ioo/PFLD/+csdsIYO11PXlZaQcONvA=;
        b=L7FRvhbb6OiJ9FJ8B0UqATo/8ZKtXvsMXAgEQDMB7L0NEriZwMo916TiQ66e99THz+
         RmXeG4q6b8iW41HIP42/lnladWiph5bvvNprapftF2V2ZEU0RA2GTvkBfFQEFUjaq+jP
         lzxn72KQi6I/91YL5F178hAa9C5uinNkEK76eecLHdu0vX+xHrJG4bsX0JFnzjhTBKKr
         N4l15iRJ6kTUKoO7psd9PqkJTbm2umLx369X0RDfM6s601d5s3SGW3flBjtsignb3lNb
         JEAk8mEzYA4kzk/U5kkyDfyfRdFZu02P7aL9DJiEZa/3dKnwnCASer/WXrwHUcsTwug6
         V+mw==
X-Gm-Message-State: AOJu0YxKvuUOjvETMEItQQsHbo9ikdljtH+s13qjOsJ7BEXcSz6LdIsR
        WDGbY4mVt06wsOcOrOW/xO9dJYzHMmqMiA8D/I/A4Q==
X-Google-Smtp-Source: AGHT+IGzoE9Xi3DNYnZmDz9A9quolYK8vYTtGs8wEdYPIG/XZ9fpu3ISkdssMCsgH1AREisL0bn9gg==
X-Received: by 2002:a05:6512:10cd:b0:500:b2f6:592 with SMTP id k13-20020a05651210cd00b00500b2f60592mr526356lfg.50.1700608433760;
        Tue, 21 Nov 2023 15:13:53 -0800 (PST)
Received: from ntb.lan ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id f7-20020a056402160700b00548b6175881sm2964840edv.77.2023.11.21.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:13:53 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
        oss@malat.biz
Subject: [PATCH 0/2] bootconfig: Support early options in embedded config
Date:   Wed, 22 Nov 2023 00:13:40 +0100
Message-Id: <20231121231342.193646-1-oss@malat.biz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 patches add a support for specifying early options in embedded
bootconfig and merging embedded and initrd bootconfig into one.

To allow handling of early options, it's necessary to eliminate allocations
from embedded bootconfig handling, which can be done by parsing the config
data in place and allocating xbc_nodes array statically.

Later, when initrd is available, it either replaces embedded data or is
appended to them. To append initrd data, it's necessary to relocate already
parsed data to a bigger memory chunk, but that's not a problem, because
xbc_node structure uses offsets and not absolute pointers.

Also, update the documentation to make users aware early options can't be
configured in the initrd.


