Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88D7BED4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378694AbjJIVYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjJIVY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:24:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECCAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:24:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F99C433C8;
        Mon,  9 Oct 2023 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886667;
        bh=WDmw1Lkn0054EpRVmv+kdxletOsKLERQEoDJyoxjqdU=;
        h=Date:From:To:Cc:Subject:From;
        b=BiPv9zXmszOBPcmG48Mh6TvipxEcahZxzlDRsWXYqdepL9wT7+Vn8qAY5HJ7EjURU
         Qln+pgHxDCTi2UPs4OET/5c7iJUUFCiRHO9JGLHWFpXYeO5YDncD9yWizhmwYXue9h
         nv1dAFqV9lXnXi/h4ohvwqR4qqVOtG6G374XjNxV8VpxEECu5li51qs8W1IzE9gpR6
         E0Gksfg2Bm2vezhEWB4DcWlumpOW4kh5lq2tdYpBu0CQipPowOJtsU2v83LznaUWVe
         tWcDxfnoLtKHEtcaYW2Q3uimxCCZ5mwulbBSf0j4vWVnkisSiIP2YHWmc9JWBe1U5m
         /QHaWN9cUcofg==
Date:   Mon, 9 Oct 2023 15:24:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Message-ID: <ZSRvh1j2MVVhuOUv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() and size_sub() helpers, instead of the
open-coded version, to calculate the size for the allocation of the
whole flexible structure, including of course, the flexible-array
member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/codecs/sigmadsp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index b93c078a8040..56546e2394ab 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -43,7 +43,7 @@ struct sigmadsp_data {
 	uint32_t samplerates;
 	unsigned int addr;
 	unsigned int length;
-	uint8_t data[];
+	uint8_t data[] __counted_by(length);
 };
 
 struct sigma_fw_chunk {
@@ -270,7 +270,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
 
 	length -= sizeof(*data_chunk);
 
-	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
+	data = kzalloc(struct_size(data, data, length), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -413,7 +413,8 @@ static int process_sigma_action(struct sigmadsp *sigmadsp,
 		if (len < 3)
 			return -EINVAL;
 
-		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
+		data = kzalloc(struct_size(data, data, size_sub(len, 2)),
+			       GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
-- 
2.34.1

