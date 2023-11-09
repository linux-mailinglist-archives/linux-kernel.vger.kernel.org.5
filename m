Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5B7E71C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbjKISyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKISys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:54:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A02D57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:54:46 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51f64817809so139813a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556086; x=1700160886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZigjSCaiZW35pzbGAtzzxAweyaYy7ML3+66Q8mfqx8=;
        b=Es1R3uTnJQHoZua5GPXhbaKC8t8yiIfiK3XZOGorE0fm21xDG4GRNKlXqsFO/E/TTQ
         RotPN9V7NuroLE9FVvs08+IAlWFMeoV3DqtiVJnUTJdKJG/JTBvcrUQINGjdyRA0Qn3d
         SMBJud5poj6M24cCvw4mp1FVWxBQpSgZetn06uBaEKfbwQ+Y6UUs2cXs6jRKzeUidLGH
         vXQtgS8cOQP8vX/jXHyK3OdMcMZmGkdeoeL/mAqF5zKjo2iOJzte7kyoRREGTdxsABNq
         pQLLB/ZoLxy5c8bT2tj67dic7DjaQfR1EvgSU0nr+kUeGRnNvCfGNxdq7YuTlZmZYm6A
         rTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556086; x=1700160886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZigjSCaiZW35pzbGAtzzxAweyaYy7ML3+66Q8mfqx8=;
        b=P9HXzdUMhE4mXipYM8H913Thf0DKcb1nuvDLqVTtX1LjfeyHFOI2Jzrd6fL684rr1S
         8UD9J2wF01AK4Ln94R9kH8xFL8Dn92GiVsKG5db4nis6RLsgq0eB77mZenW4+3opkE+P
         VonSVw62RlxhQNthru99FJSoHrE1nmyB586JSqubUW/pNKW2AFTgk6SuvfUfhC6C3WdI
         2tfwWHtCqeJ293G7ly61qJt8vBcRtqKrW/CydVWvbVbOwxVHX8Z1oxNVr6+LVZa59V/i
         LOm2fAwldCr011xOFMV4p7MWdRgFP7C04ocaxDgCgq+s5ePORkE20QEpuFkgkQDfDXDT
         /HmA==
X-Gm-Message-State: AOJu0YzZJ1oy4HwQ5e+lK+J02ye9O9XC+mFK+Nw4qatTuVKpYlN4z2/k
        lOo5t1fgoH/HhDHej/jeLuc=
X-Google-Smtp-Source: AGHT+IHeqLbyCgXBVVLAULQWHO8Gl2fCm8y0X90Y6EAOlAh9qbtosKyPKoy482opmxo8aw486o1s3Q==
X-Received: by 2002:a05:6a21:9996:b0:182:2282:f3d3 with SMTP id ve22-20020a056a21999600b001822282f3d3mr6213666pzb.1.1699556086143;
        Thu, 09 Nov 2023 10:54:46 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:54:45 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/7] platform/chrome: Implement quickselect for median calculation
Date:   Fri, 10 Nov 2023 02:54:32 +0800
Message-Id: <20231109185439.1535962-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the performance of the
cros_ec_sensor_ring_median function. Currently, an inefficient sorting
algorithm (> O(n)) is used to find the median of an array. This series
replaces the sorting approach with the quickselect algorithm, achieving
an average time complexity of O(n).

The correctness and performance improvement have been verified through
a simple unit testing, including a micro-benchmark [1].

In addition to the algorithmic improvement, this series includes
several typo fixes to enhance the overall code quality and maintain
consistency.

--
[1]:
static void init_array(s64 *arr, size_t length, s64 seed)
{
	for (int i = 0; i < length; i++) {
		seed = (seed * 725861) % 6599;
		arr[i] = seed;
	}
}

static int quickselect_test(void)
{
	s64 *arr;
	s64 median_old, median_new;
	ktime_t start, end;
	s64 delta;
	const size_t array_length = 1000;
	const s64 seed = 1;

	arr = kmalloc(array_length * sizeof(s64), GFP_KERNEL);
	if (!arr)
		return -ENOMEM;

	init_array(arr, array_length, seed);
	start = ktime_get();
	median_old = cros_ec_sensor_ring_median(arr, array_length);
	end = ktime_get();
	delta = ktime_us_delta(end, start);
	printk(KERN_ALERT "time of original function: %lld\n", delta);

	init_array(arr, array_length, seed);
	start = ktime_get();
	median_new = cros_ec_sensor_ring_median_new(arr, array_length);
	end = ktime_get();
	delta = ktime_us_delta(end, start);
	printk(KERN_ALERT "time of new function: %lld\n", delta);

	kfree(arr);

	/* return 0 on success */
	return median_old != median_new;
}

/* Result:
 * time of original function: 897
 * time of new function: 16
 */

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

--

Kuan-Wei Chiu (7):
  platform/chrome: Fix typo 'preceeds' in comment
  platform/chrome: Fix typo 'perod' in comment
  platform/chrome: Fix typo 'noone' in comment
  platform/chrome: Fix typo 'lantency' in comment
  platform/chrome: Fix typo 'kifo' in commet
  platform/chrome: Fix typo 'change' in comment
  platform/chrome: Implement quickselect for median calculation

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 83 ++++++++++++++-----
 1 file changed, 60 insertions(+), 23 deletions(-)

-- 
2.25.1

