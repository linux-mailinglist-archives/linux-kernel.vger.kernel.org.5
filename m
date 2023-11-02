Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17307DF4D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376766AbjKBOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKBOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:20:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3BB7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:20:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so927705b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934846; x=1699539646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWSAdgZhLm/VpkaLPNWSl5I2A+mxc5fGaXPBtJq2zJw=;
        b=cHffYPzOBiRqBiI6QvaNCGQmVHENAvjNnd1AeNW4uVJwyKNsE+F00Q3jyH2bxWma4U
         4aQM7QHtRhAV9sOK8uO16w0FO7IUjG21iCzJpKy6HrHQj7Jy5QRAXYWztkRsYJGffFEy
         p4w9ddN9k+KNv3hBuKbWmNQbfhlpDBfmxZFXsiY4m5OeGmofeGkMcxcVi5PDdeO49b4I
         QUPdT3Lv+KRJdpURMz4aUBT9ZYYNzrZu03njN56UpjFly0mTts3HZdZ/yqMpxmgBXYac
         ECtTLW4QDgGRzCZVdBpME6/aqkmq/BRDc8s+2U0Go3C1YV+LCKTU5uhFinrqwIGh+lg+
         5Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934846; x=1699539646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWSAdgZhLm/VpkaLPNWSl5I2A+mxc5fGaXPBtJq2zJw=;
        b=hee7WSG3jaEJLMxPwJemDWbcjhJ3uuMerXgeCzEbYuWYNgcA3X51VGEFN258OVtulC
         6vZOOrKpFmFC0RD4ZrlpmaGwnNAd4PBKzvdqBuDAUUy/LjJvttKiZTGw+eGGMxG44vKy
         +4IZL7En6KkneavlAFhBO5QbBaI05yl2AuFAHGboNtlOlYuejH7utLHmXB5FjTGi5Jh4
         x9buBAjzgSeVBPEomGdAAXy1tMAIvkV48Mfec46LnQdli4wiw9t3grZRlSPWqMm4El1p
         1RngXMMEoiFS/ocuo/tZLsyc06NSgC4P6R+6eyOUlDiPf+jh9kHnIzb792k7v+y8GC/t
         JT/A==
X-Gm-Message-State: AOJu0Yx8W0waCQgTpajP3KOA4dsEepFZsMcoEfPykU7WKqyDD621fked
        OzOFlLRgaFIGHChnUjXkE2U=
X-Google-Smtp-Source: AGHT+IFDmoZ9qPh8kDSWCQK5LIbaoD2myce+S2cqa7ami0StAuVgAu/+LRrTRK2XIuScm4g38SBp0g==
X-Received: by 2002:a05:6a21:328c:b0:159:b4ba:a5bf with SMTP id yt12-20020a056a21328c00b00159b4baa5bfmr19315537pzb.13.1698934846361;
        Thu, 02 Nov 2023 07:20:46 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id p24-20020a637f58000000b005b83bc255fbsm1546789pgn.71.2023.11.02.07.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:20:46 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975628@gmail.com
Subject: [PATCH v2 0/1] sched/fair: Track current se's EEVDF parameters
Date:   Thu,  2 Nov 2023 22:20:21 +0800
Message-Id: <20231102142022.19302-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v1 -> v2:
    Consider the contribution to avg_vruntime for 'curr'

 kernel/sched/fair.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

-- 
2.34.1

