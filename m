Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36387CC96D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343860AbjJQREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjJQREl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:04:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD06A4;
        Tue, 17 Oct 2023 10:04:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso53198395e9.0;
        Tue, 17 Oct 2023 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697562278; x=1698167078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYhVgVukknKnttKNru5mCHTZ6wmo6E2zfS+vFjWMe7o=;
        b=QO/ZDkK3EhPj4DZHs+NlLly2/TBT43VjH3Ea4JTW9Vm6FFvyEPdAGBGibbzir80brh
         nurxejzCPnP8qj5CLFnqkK1rOTWzx+6Y9z7XtRSaXCpIdYHpAQE2mL0Hj8z5t6DBZr3s
         p1cLBTHW0FzYLjXpcUjplLwwZ7Xh+1jCa1LktH+Rr1jxbLcQ59xfgySgTtbjyooM9tkM
         efeVcnH3KkJKZPcSWYQvQDZklHMXpmZJnVnrBbflPpf661pDpZE6clAhkh12Z8oLmTRH
         Ngaj1cnW1Ol2T3LUTlwhnPx0a1iUN+9TU1L5SJv/AYeCx02IDfajwpAQz07Af0oFJzZQ
         sC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562278; x=1698167078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYhVgVukknKnttKNru5mCHTZ6wmo6E2zfS+vFjWMe7o=;
        b=pUgcO6BMl2tXC9CYp1diNQkx1Xdv1KD64Jjx4s0eoknKf7DV/kWL/TnREAfOHWQ0T/
         WJ/etwB/gnctiUBRZfUp9NxBSVex4KsVu2kEXZ+KolRq0iMlG3Eut525Vx9SX/RJ6K9d
         PCHRhsN/1FvW7I8GSSJHxjLX7u5Wy1oetJR/6SvA9rnrrfTnBji5hVef7A5xYnZDISgu
         uenDqPTjQIPGj4IYbx2wkO6y0EN1oqevb/G+QtZoK2neps4bhsVKwsNKyZMAVxXMIPJr
         ZNtdVEBl+JSKgS2J5RL0wyHSbh6dC6wOmYF1ge0xu9RkuWazEH4aMsBkviVT3cZXavU4
         nCXQ==
X-Gm-Message-State: AOJu0YzViKu8cxW5Bimu0OdC1HM+sahGSibQOg4Ig5nwDKFJ7vYfKSal
        Cyaq7bl7UpRjJtyUlTzhJfTxB/A/nxLesA==
X-Google-Smtp-Source: AGHT+IFtNy7l3EGxYkZCWkiAhFWEYsg/TRqDQWID7CtM3pnURtITPTRRkvuHyQUSXKuBI5Nf0blqLQ==
X-Received: by 2002:a5d:4e47:0:b0:32d:65ab:2228 with SMTP id r7-20020a5d4e47000000b0032d65ab2228mr2287392wrt.11.1697562278015;
        Tue, 17 Oct 2023 10:04:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z9-20020adff749000000b00323287186aasm191730wrp.32.2023.10.17.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:04:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: tas2781: make const read-only array magic_number static
Date:   Tue, 17 Oct 2023 18:04:36 +0100
Message-Id: <20231017170436.176615-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the const read-only array magic_number on the stack,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/tas2781-fmwlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index e27775d834e9..4efe95b60aaa 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1757,7 +1757,7 @@ static int fw_parse_header(struct tasdevice_priv *tas_priv,
 {
 	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
 	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
-	const unsigned char magic_number[] = { 0x35, 0x35, 0x35, 0x32 };
+	static const unsigned char magic_number[] = { 0x35, 0x35, 0x35, 0x32 };
 	const unsigned char *buf = (unsigned char *)fmw->data;
 
 	if (offset + 92 > fmw->size) {
-- 
2.39.2

