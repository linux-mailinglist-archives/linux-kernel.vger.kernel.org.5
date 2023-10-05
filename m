Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE97B9FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjJEOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjJEO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73CF1F757;
        Thu,  5 Oct 2023 02:59:35 -0700 (PDT)
From:   Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696499973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Yg/WhHpaQNIRqvSGsa5f/WE6yXRFzSVBafLf2ZRuh8=;
        b=WUTzOHOsOUGPF+kaPiD4pPQ0Yxr+DHHn0124BSw+j3ykiDvmrS2iMxSNnoy6/pG3TJOvvJ
        6/IRDtVFFNYAzIJU0o0WJNHW5tcBUJEW4S8C/fhRa88K2r6OGtYEV1w2s9VjdJjPSWMd9B
        EeDrUa+5+jFCqFsw/gtKpPrPJCQcWoNIpyYS8oRY/GYhk8Zf+hWOnRg7O77c+97+EjlApg
        D8qNR0dOCczitxaR2OIBK1tu6ws/78awFm1e9pVzJW6dgbejp5+sKNMWtx88Pl7Sl3Gr7u
        TNUf/5OWFmPKF8J9MupE5Ek7B0VJjbw2VaJjYqupMCEVEhAJB8RoR4ksp7JtGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696499973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Yg/WhHpaQNIRqvSGsa5f/WE6yXRFzSVBafLf2ZRuh8=;
        b=FrVErenItllRBa/Uhu5rymcSxkX7LwQ4Gt7U1rYiYckHVblupsFWLPbKWRVBJgWne0FXao
        FR/GCqHqk5eIl9BA==
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 0/1] Broken serial console on Altera Cyclon V board
Date:   Thu,  5 Oct 2023 11:59:26 +0200
Message-ID: <20231005095927.12398-1-b.spranger@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to boot e recent Kernel on a Altera Cyclone V based board I
faced a broken serial console. The "real" baudrate is half of the set
baudrate i.e. 57600 instead of configured 115200. Traking down the issue
let to commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate hook").

Change the determine_rate hook to fix the issue.

Regards
    Benedikt Spranger

Benedikt Spranger (1):
  clk: socfpga: gate: Fix of by factor 2 for serial console

 drivers/clk/socfpga/clk-gate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.42.0

