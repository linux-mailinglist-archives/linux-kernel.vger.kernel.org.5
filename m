Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E728012C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379328AbjLASb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjLASbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:31:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE312A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:31:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so1979018b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455490; x=1702060290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5Q+AM+DhOXR89Ju18vzTGC3wrGXus7g2e66yEQ6u/o=;
        b=bqnAI4pbt/2JXEGzsxEb82qCt80IXSahvoeovzNLUMK3RKJ0eZpYZpeeMkPrTFuYHw
         wkzmYMAFMBigaGHIToD8H1Mzq0zB/CkB/TVRC16pPdJv/mCV8h9Q5OlsfYWx5L71pKKL
         4yBrFGesWjwRfQAOW6UCMTq29cHFFT1JMtw7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455490; x=1702060290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5Q+AM+DhOXR89Ju18vzTGC3wrGXus7g2e66yEQ6u/o=;
        b=oe5k/BSSdfZSX46DuJY1PPQglscX9HdM4OA2fq6TiFJYGL1U5WiNO9I92nUXWtizEY
         yF8O2EXqFpeN88SD1xrhJsPe5vP9Vxa8Kw8OvXBHomDmbkGOsQaIMOxMcpNAVLOKmIg5
         EU4OnqJxLGsemQnRtu74o/9kACGUl3mx8+qNkRyQ0V5kqQwY+c0A4iDwy5mOQyW4/LmI
         TxEeAqW0qCm2eTJnVu2EXuDnZksArD31JUi305Bcm0Z3v2lOu8jnvoddVxsSMDk2L97o
         YkgiB9owuwS/w/Xkp7AOwOV0Zo0Za3IBQ55vaDruBkF//vG4+601REEUDh+vknxKiX5v
         9EeA==
X-Gm-Message-State: AOJu0Yy0Tje+4+LtaiIOIcQ5KCv1ff/g6HJaAhgA1nT3UmbjnUpnaMca
        D3naoz1CEceuVa0c7blzpSSaYg==
X-Google-Smtp-Source: AGHT+IHAuOQjIDX2waOHWW3Fi2purVTSJ192L6IErkIR7DpoPp8Bdvp+y5ic6UoUqwLOExUhrlIMsA==
X-Received: by 2002:a05:6a00:23c4:b0:6cb:cd66:2102 with SMTP id g4-20020a056a0023c400b006cbcd662102mr35720154pfc.4.1701455490601;
        Fri, 01 Dec 2023 10:31:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11eb:92ac:94e:c791])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a00078b00b006cdda10bdafsm3306926pfu.183.2023.12.01.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:31:30 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: core: Don't force USB generic_subclass drivers to define probe()
Date:   Fri,  1 Dec 2023 10:29:50 -0800
Message-ID: <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201183113.343256-1-dianders@chromium.org>
References: <20231201183113.343256-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no real reason that subclassed USB drivers _need_ to define
probe() since they might want to subclass for some other reason. Make
it optional to define probe() if we're a generic_subclass.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Don't force USB generic_subclass drivers to define ...") new for v2.

 drivers/usb/core/driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f58a0299fb3b..1dc0c0413043 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -290,7 +290,10 @@ static int usb_probe_device(struct device *dev)
 	 * specialised device drivers prior to setting the
 	 * use_generic_driver bit.
 	 */
-	error = udriver->probe(udev);
+	if (udriver->probe)
+		error = udriver->probe(udev);
+	else if (!udriver->generic_subclass)
+		error = -EINVAL;
 	if (error == -ENODEV && udriver != &usb_generic_driver &&
 	    (udriver->id_table || udriver->match)) {
 		udev->use_generic_driver = 1;
-- 
2.43.0.rc2.451.g8631bc7472-goog

