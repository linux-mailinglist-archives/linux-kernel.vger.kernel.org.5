Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFA803BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjLDRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjLDRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:36:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35D1717
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d04c097e34so24462445ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701711346; x=1702316146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofNrjZqbKMOVnmci8uctOTDXsqzPBvmrXiOqZFSctgY=;
        b=jlRpU7qam2QUc7N3KZeiuT9eiIKmYooSDY12c9reV1WNTmHM8WKShHexiL8G7XBVm1
         fk0Bs7wQF5WgOqjCDQ6NcthFxuIyseZvQ84Uqy6bgqUSAVn3X0SzOZKRisDOnNN8AI7H
         QF7EBfHAYnINg6dz9hwKXkQywSG3TOOWWD+HMjWhtQjLZ7JosEFEft6+a/ejdf907CqC
         6xZwbCWSp3TtgxPFOhrT8b8U7Q0c+Lix9xohsbj9oLieQ6ezAXFTY11JszD67m9jD4Md
         6vkVRmnIzrmMVWG9kiyEbaIzbkrxSyXzMxHI6xsp8IQ1OB4AkTFbJNo6/NskkkpPYv1f
         TJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711346; x=1702316146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofNrjZqbKMOVnmci8uctOTDXsqzPBvmrXiOqZFSctgY=;
        b=FQakSHXzL3Cl+2WpZnIn69366vyt854JgVZkwVOCPY6qIbVbpuEAi74x9jjwEsaPm9
         i1OlV4ZUucdr9eJRY9Gpo8lrAHN6Oy3xhCnp5C3xC5YyBe9T/rYp2BDxzAw7WJD//Wqz
         9RS7LR430P5FoY+AyLPWd5WMxMYpTbUn+QK9sfHbLisxZp7dToNGyE39bT/Q707IZFaa
         wjxbkpdPA+MKC0wlHzYi/OusW+kxtXJf9vZV4w8Fj15Vg5mXGJAcbzUrWSMR2/xqIAOX
         Vpy94zNWm8SqIcvcSfgZcxt/oXCaHSEOksxlG87u86nELvrTD07XK5kfk8c4DspQ+Dx/
         ZfEg==
X-Gm-Message-State: AOJu0YwBCToDHRZH5TTpjpquSvUjh+8QW9XYdTFh8gnzrzkP/PfOYadh
        tYVrwZyjRhzEsRZq/Hnd4CVPnidO3F4dLC0ixaM=
X-Google-Smtp-Source: AGHT+IEFHtYXgG3ANA6S87z4mS1TnTTSNbzZz31P7Zo8VAzT91DzqXTxCAQrqq2siuGJuzmN43gm4Q==
X-Received: by 2002:a17:903:41d1:b0:1d0:a9fa:58e8 with SMTP id u17-20020a17090341d100b001d0a9fa58e8mr53404ple.63.1701711345942;
        Mon, 04 Dec 2023 09:35:45 -0800 (PST)
Received: from localhost.localdomain ([124.123.164.183])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b001d076ebf328sm4613847plg.8.2023.12.04.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:45 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev
Cc:     davidgow@google.com, mripard@kernel.org, dan.carpenter@linaro.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Kunit drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
Date:   Mon,  4 Dec 2023 23:05:36 +0530
Message-Id: <20231204173536.51003-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kunit drm_plane_helper failed on all devices running Linux next-20231204

## Test Regressions (compared to next-20231201)
* qemu-armv7, kunit and
* x86, kunit
  - drm_test_check_invalid_plane_state_downscaling_invalid
  - drm_test_check_invalid_plane_state_drm_plane_helper
  - drm_test_check_invalid_plane_state_drm_test_check_invalid_plane_state
  - drm_test_check_invalid_plane_state_positioning_invalid
  - drm_test_check_invalid_plane_state_upscaling_invalid
  - drm_test_check_plane_state_clipping_rotate_reflect
  - drm_test_check_plane_state_clipping_simple
  - drm_test_check_plane_state_downscaling
  - drm_test_check_plane_state_drm_test_check_plane_state
  - drm_test_check_plane_state_positioning_simple
  - drm_test_check_plane_state_rounding1
  - drm_test_check_plane_state_rounding2
  - drm_test_check_plane_state_rounding3
  - drm_test_check_plane_state_rounding4
  - drm_test_check_plane_state_upscaling


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

  
Test log:
-------  
[   91.955019]     # Subtest: drm_plane_helper
[   91.959248]     # module: drm_plane_helper_test
[   91.959271]     1..2
[   91.966042]         KTAP version 1
[   91.969494]         # Subtest: drm_test_check_plane_state
[   91.969707]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   91.969707]     Expected plane_state->visible to be true, but is false
[   91.992346]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:96
[   91.992346]     Expected drm_rect_equals(&plane_state->src, &expected) to be true, but is false
[   91.992346] 
[   91.992346] dst: 2048.000000x2048.000000+0.000000+0.000000, expected: 1024.000000x768.000000+0.000000+0.000000
[   91.992392]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:107
[   91.992392]     Expected drm_rect_equals(&plane_state->dst, &expected) to be true, but is false
[   91.992392] 
[   91.992392] dst: 2048x2048+0+0, expected: 1024x768+0+0
[   92.023394]         not ok 1 clipping_simple
[   92.049526]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.049526]     Expected plane_state->visible to be true, but is false
[   92.071041]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:96
[   92.071041]     Expected drm_rect_equals(&plane_state->src, &expected) to be true, but is false
[   92.071041] 
[   92.071041] dst: 2048.000000x2048.000000+0.000000+0.000000, expected: 768.000000x1024.000000+0.000000+0.000000
[   92.071084]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:107
[   92.071084]     Expected drm_rect_equals(&plane_state->dst, &expected) to be true, but is false
[   92.071084] 
[   92.071084] dst: 2048x2048+0+0, expected: 1024x768+0+0
[   92.102010]         not ok 2 clipping_rotate_reflect
[   92.128099]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.128099]     Expected plane_state->visible to be true, but is false
[   92.150558]         not ok 3 positioning_simple
[   92.150768]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.150768]     Expected plane_state->visible to be true, but is false
[   92.173083]         not ok 4 upscaling
[   92.173209]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.173209]     Expected plane_state->visible to be true, but is false
[   92.194443]         not ok 5 downscaling
[   92.194656]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.194656]     Expected plane_state->visible to be true, but is false
[   92.215819]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:96
[   92.215819]     Expected drm_rect_equals(&plane_state->src, &expected) to be true, but is false
[   92.215819] 
[   92.215819] dst: 4.000015x4.000015+0.000000+0.000000, expected: 2.000000x2.000000+0.000000+0.000000
[   92.215863]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:107
[   92.215863]     Expected drm_rect_equals(&plane_state->dst, &expected) to be true, but is false
[   92.215863] 
[   92.215863] dst: 4x4+1022+766, expected: 2x2+1022+766
[   92.245779]         not ok 6 rounding1
[   92.271735]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.271735]     Expected plane_state->visible to be true, but is false
[   92.292739]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:96
[   92.292739]     Expected drm_rect_equals(&plane_state->src, &expected) to be true, but is false
[   92.292739] 
[   92.292739] dst: 1028.000015x772.000015+2.000015+2.000015, expected: 1024.000000x768.000000+4.000030+4.000030
[   92.292782]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:107
[   92.292782]     Expected drm_rect_equals(&plane_state->dst, &expected) to be true, but is false
[   92.292782] 
[   92.292782] dst: 1028x772-2-2, expected: 1024x768+0+0
[   92.323632]         not ok 7 rounding2
[   92.349649]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.349649]     Expected plane_state->visible to be true, but is false
[   92.370603]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:96
[   92.370603]     Expected drm_rect_equals(&plane_state->src, &expected) to be true, but is false
[   92.370603] 
[   92.370603] dst: 3.999984x3.999984+0.000000+0.000000, expected: 2.000000x2.000000+0.000000+0.000000
[   92.370647]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:107
[   92.370647]     Expected drm_rect_equals(&plane_state->dst, &expected) to be true, but is false
[   92.370647] 
[   92.370647] dst: 4x4+1022+766, expected: 2x2+1022+766
[   92.400634]         not ok 8 rounding3
[   92.426701]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:123
[   92.426701]     Expected plane_state->visible to be true, but is false
[   92.447667]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:96
[   92.447667]     Expected drm_rect_equals(&plane_state->src, &expected) to be true, but is false
[   92.447667] 
[   92.447667] dst: 1027.999984x771.999984+1.999984+1.999984, expected: 1024.000000x768.000000+3.999969+3.999969
[   92.447709]     # drm_test_check_plane_state: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:107
[   92.447709]     Expected drm_rect_equals(&plane_state->dst, &expected) to be true, but is false
[   92.447709] 
[   92.447709] dst: 1028x772-2-2, expected: 1024x768+0+0
[   92.478561]         not ok 9 rounding4
[   92.504392]     # drm_test_check_plane_state: pass:0 fail:9 skip:0 total:9
[   92.508212]     not ok 1 drm_test_check_plane_state
[   92.515148]         KTAP version 1
[   92.523484]         # Subtest: drm_test_check_invalid_plane_state
[   92.523712]     # drm_test_check_invalid_plane_state: ASSERTION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:259
[   92.523712]     Expected drm_atomic_helper_check_plane_state(plane_state, &crtc_state, params->min_scale, params->max_scale, params->can_position, false) < 0, but
[   92.523712]         drm_atomic_helper_check_plane_state(plane_state, &crtc_state, params->min_scale, params->max_scale, params->can_position, false) == 0 (0x0)
[   92.523712] 
[   92.523712] Should not be able to position on the crtc with can_position=false
[   92.530089]         not ok 1 positioning_invalid
[   92.578773]     # drm_test_check_invalid_plane_state: ASSERTION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:259
[   92.578773]     Expected drm_atomic_helper_check_plane_state(plane_state, &crtc_state, params->min_scale, params->max_scale, params->can_position, false) < 0, but
[   92.578773]         drm_atomic_helper_check_plane_state(plane_state, &crtc_state, params->min_scale, params->max_scale, params->can_position, false) == 0 (0x0)
[   92.578773] 
[   92.578773] Upscaling out of range should fail
[   92.583722]         not ok 2 upscaling_invalid
[   92.629677]     # drm_test_check_invalid_plane_state: ASSERTION FAILED at drivers/gpu/drm/tests/drm_plane_helper_test.c:259
[   92.629677]     Expected drm_atomic_helper_check_plane_state(plane_state, &crtc_state, params->min_scale, params->max_scale, params->can_position, false) < 0, but
[   92.629677]         drm_atomic_helper_check_plane_state(plane_state, &crtc_state, params->min_scale, params->max_scale, params->can_position, false) == 0 (0x0)
[   92.629677] 
[   92.629677] Downscaling out of range should fail
[   92.634441]         not ok 3 downscaling_invalid
[   92.680376]     # drm_test_check_invalid_plane_state: pass:0 fail:3 skip:0 total:3
[   92.685049]     not ok 2 drm_test_check_invalid_plane_state
[   92.692648] # drm_plane_helper: pass:0 fail:2 skip:0 total:2
[   92.698267] # Totals: pass:0 fail:12 skip:0 total:12
[   92.703959] not ok 56 drm_plane_helper


Links:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2YvL7zTlX7SMNCR0LXO6TfXnf2X
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21473821/suite/kunit/test/drm_test_check_invalid_plane_state_drm_plane_helper/history/


--
Linaro LKFT
https://lkft.linaro.org


