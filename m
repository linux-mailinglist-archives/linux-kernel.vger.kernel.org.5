Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3B769360
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGaKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaKrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A84E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68FF260D32
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0ECC433C7;
        Mon, 31 Jul 2023 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800429;
        bh=ItT7al2kLjWBYdbBXx0GhyFJpTHNsPm5yEH1Oa3IPGA=;
        h=From:Subject:Date:To:Cc:From;
        b=k1qORWVJ72bX6Z5XRWBae/S3rzJChNbP/1e6RpNV4KWMsqT3LJc4gvmFSBI9cPuxN
         IwpoaO+DqWGsNEnle9kojh8J4YGlV0L0XE5F/61iBtHxU2fk/0M0mEYw9Ah+Cb3dra
         665yWUl2pwvefNQKgrM0WywDKxNtGwsm/Rp2r991w/Sv/HHABN6bXyIPlcp2xHjCeI
         SFgBu9kqPJZD/itEwWFSZ/IGZ/pkpgCS6qgtsQqbpcX3fVq3yzBNjYSIw+CMfDNNmr
         UOFv6Ck1YhD/V5MDJoVKHfd+okeMNvVU+rxJNbYPMU5OUwIzA7k4P7/vKT0Kwww7rX
         hMPYxdjIIS/tw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] ASoC: wm8960: Clocking tweaks
Date:   Mon, 31 Jul 2023 11:47:01 +0100
Message-Id: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWRx2QC/x3MQQ5AMBBA0as0szZJFS2uIhbUYIKSNkEi7q6xf
 Iv/HwjkmQLU4gFPJwfeXUSaCLBz5yZCHqJBSZVJk0nswm7x2spKS7TrgtqaPC2IlOpziNXhaeT
 7Pzbt+35vJYT0YQAAAA==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=598; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ItT7al2kLjWBYdbBXx0GhyFJpTHNsPm5yEH1Oa3IPGA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx5EpgWXWV98NW60roVRK8eWTgIbE5ZqLI0sVf
 AkX38Rxmx2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMeRKQAKCRAk1otyXVSH
 0H7dB/4zEuAuIb7XTusuLQ2NskvHRq2v3Eh+FmYBsn2pailwlv7SCdchAwds1R1J04lXtmPEgy8
 V874V+MzK7fCcoR9MW7pfK5SdL0LLM9JMVAST7CaEtyBbPYiG8UCsJZzmM2N948Hp48Q5YZ8XvF
 wa7AZM12qtd0xSsFu3TcW5Hm4QY2Z/0mH3O7uVCuQ+IMHYXUv3A7H8hF4FH1A8EnN1pWWO4I2XP
 pQIft9ph9DruV63Lw1QDgHqlEq1bMZLRFfvZyXEpgysPFve678GRknGmh0ZXFVLSCeHnZT5807u
 ApETXMpmH/4zhetCviznbAvmtwKsKFa36aPmW1dTRF8w+mUF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of minor clocking improvements that make the wm8960 driver work
a bit better with generic cards.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      ASoC: wm8960: Read initial MCLK rate from clock API
      ASoC: wm8960: Make automatic the default clocking mode

 sound/soc/codecs/wm8960.c | 8 ++++++++
 sound/soc/codecs/wm8960.h | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230730-asoc-wm8960-clk-6c7415ee22b4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

