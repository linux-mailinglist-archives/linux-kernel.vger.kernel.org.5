Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBADC7D3FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjJWTLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjJWTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:11:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB23C5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:11:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507d7b73b74so5363408e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698088274; x=1698693074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yaMn2Inorx6J5jbXWZ4lv04z9p9knuEMsnSJqco5r8=;
        b=DiVG3+MTinPixJ5etuTwX59EaRSw7bNfGjB24Yoc4GImRexnuDlL5TgL6j1E069fln
         Zy5dcDXiKxerD496iliAeT0IucQhsnbK/XCKq4VrEAw9ISjwnI6ZybQ24Izt85gFvjYP
         6Yux8CO8g7YdydhZZPDiMpgrCmG0UfPwfCv0LCQJviD0bHtIQiO34wafsjb/KsU8F696
         ZW6W7lyEoq0xwqs1sOuYin1pFw8ZZQRf8i5dWUKGXtm1qoZdfkL8HKC3B4wAaJ5eC1l+
         U3mwX4pRUMwGCtdNPxTY/01rQKqZcAt3o8cDOR/sMrbSaTCjlpJ6SmBCzrTW5eOURkGJ
         dqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088274; x=1698693074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yaMn2Inorx6J5jbXWZ4lv04z9p9knuEMsnSJqco5r8=;
        b=uXXV+tJ2COaenKNHvDgGJuSuPwBdV0nJd3koeZHMEOh5wusSG9q0sSZIr1/KeiT4FN
         LiLZG5bxWnTznJppWVCsVxdppM9r7cRcWZufgr/uLzuOx41jjq1UeBRwEzs8xp+cwqBA
         Wf92jN+B1BwmQixaRU4uyH4RsmMFNLSs1nCeTZ8ViparIDnWpLyR4/DcCu8Zu45sqlmm
         UZMMsRkcJTuOiO87LxfmILl18FZb6Sb6En3Bnbsi2ZZ9HwFN6T6cGd7xHpF2AjD68xfZ
         DqBSUvIp3wcCwB0EgQ9P9PtraspavjKgURXklK7GRbf0Yf3+L4aO4gUi+H9IpYr66024
         PQUQ==
X-Gm-Message-State: AOJu0Yw70Dysra+qbOFbloQo7HfNQHZMFulvqoymVlMr+bn0hWvpu2CB
        N52K2kM3vM2t/D2++pvN3Yw=
X-Google-Smtp-Source: AGHT+IH/VRae6vvptiMFKgnC3z1o87r9hlnXcuSZlWMHjOAtD9ZiXBE1YB6xzvTDdLl2gJnHOnKvBA==
X-Received: by 2002:a19:5014:0:b0:507:a40e:d8c6 with SMTP id e20-20020a195014000000b00507a40ed8c6mr6757867lfb.11.1698088273600;
        Mon, 23 Oct 2023 12:11:13 -0700 (PDT)
Received: from Slimbook.. (181-251-201-31.ftth.glasoperator.nl. [31.201.251.181])
        by smtp.gmail.com with ESMTPSA id vg18-20020a170907d31200b009adc77fe164sm7062459ejc.66.2023.10.23.12.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:11:13 -0700 (PDT)
From:   Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     boukehaarsma23@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] drm: panel-orientation-quirks: Add quirks for AYN loki zero/max
Date:   Mon, 23 Oct 2023 21:10:57 +0200
Message-ID: <20231023191059.19915-1-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add orientation quirks for AYN loki devices:
- Ayn Loki Zero
- Ayn Loki Max

The quirks have been tested by the JELOS team and ChimeraOS
who have been patching their own kernel. This has been
confirmed working by users in the ChimeraOS discord
servers.

Since there are additional Ayn Loki devices I have
made separate matches for the devices.

Bouke Sybren Haarsma (2):
  drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
  drm: panel-orientation-quirks: Add quirk for Ayn Loki Max

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.41.0

