Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D057E77681A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjHITMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjHITL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD572697;
        Wed,  9 Aug 2023 12:11:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317c3ac7339so190161f8f.0;
        Wed, 09 Aug 2023 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608312; x=1692213112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PqilpSUTkskM+irx4vldFIwieHe/2PupeTH8Per9To=;
        b=F2XvfTVMThkpml7GfTzYiNS5SwGN2I3hdtDs/xhBN+cNW50SAhKj3XK9W0JRnKbbQ5
         L185/XbGhDAz+kmkf8vV71gU+X00S+3gJAyDgGREGiLu/l8Fw9wGz/EUS+WS595z9wk+
         pxDAMbogfabBJLZZ2uQdvfX2rg+7jWoHNRVn7EhV7NpY7IIS0y62Y7wbBXrUXwQ7Jtw2
         uAI3pneGm+EKxCjTc9xBJKDCpGJJ2bV+n3y3vb+Rh+1wG6JMfK4vljyEHEDzqyBxOi8s
         GROvmK2t/ETeli6wParrzol2jb55LTviB9fwFto8SHqqmPWRiwnCk8YxNHR1kL+emJkt
         t9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608312; x=1692213112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PqilpSUTkskM+irx4vldFIwieHe/2PupeTH8Per9To=;
        b=S32ASy43v9wobYDoZoPQl8mUr83yp1G6aGtMVsga5xbrd1nMkPZ4NyYnVZgCfvzkzA
         hL2GhPy9+BrtUwElUSRm8NjaFmwi3Zc9M/QGlyBsz88V7IFbsxCw/YWgbnwcQK5dEn+D
         InZ97Ie8jMTLNqivq0ZdsonfJoh1qm6zw156aerG5cjsP7ZZAkblcc4vSZDGgi6Beo9V
         RgBccwqL8wbOEsspP++h2MLtHZmYSwVXU4CoAHDKC6ALnLjgBjZLqlAVJCNRnB6syoVW
         pTksycNAzbeCqJlmb7aQ87OUzl2ttpucFigLT1G9KCfRNBqpx/sh2WsmCbbjJrcQ4DzX
         u81Q==
X-Gm-Message-State: AOJu0YynXRWdnGerq3XwT148lVp65vogiKo47VJeDXFMwcBXVy4wxWS3
        uUFThgk9s62Bzg6PU/dGmM8UzW7O5JNtZQ==
X-Google-Smtp-Source: AGHT+IF60UqYUJQiDa1LYNGiLIpJQT1XrwAaXQSG1bpsQB+7a8mMB3/G4+9TvAoe12CD8DRD4VXgHg==
X-Received: by 2002:adf:fd44:0:b0:315:a91c:1a8c with SMTP id h4-20020adffd44000000b00315a91c1a8cmr223155wrs.22.1691608312341;
        Wed, 09 Aug 2023 12:11:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:52 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v7 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Wed,  9 Aug 2023 21:11:33 +0200
Message-Id: <b1809c807b0638c9a171ac56e99e9773531610be.1691607526.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1691607526.git.mehdi.djait.k@gmail.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank lines pointed out by the checkpatch script

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v7:
v6:
v5:
v4:
- no changes

v3:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f98393d74666..ff8aa7b9568e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -341,7 +341,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
 	return ret;
-
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
@@ -1121,7 +1120,6 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-- 
2.30.2

