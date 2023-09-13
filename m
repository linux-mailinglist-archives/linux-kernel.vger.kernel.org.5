Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6780879F185
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjIMS6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjIMS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:58:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B341999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:58:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5029ace4a28so1553689e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1694631487; x=1695236287; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zBj6p++Qh8jXWGI/WFi0CSgU27ebTJ4j3bK1DZUl5Kw=;
        b=Se/tZ84Q0N0eL+xp/i7O6m19c1QPQO+FBK2xyuRgJUPjoOy541XaQwOkkVRe0StyXo
         AoFOc9Ugy/ESlpabLNH3tXLwnMTJnCUlJNRokWLl47mLLmgTNtqCrdyK0/s3F4BGXE3n
         uqFbWteCM0sRE69O4SZeZ8ayQY89DcIJYnOL8yLojnOj61dXhqISnA4VDdYesfdQ+irq
         dWfkMcj3bbwGT364k46daIC9S8p8Z6IMe7T6SqO4u/mQ+8OAj/x4pIxpM9UisWpzBcHx
         nStXlRO/iELaAiryJsrQEGuobKj7TfsdhiszdIfVZ59Dr+2rOpylQ+qV07ALtsWtnT85
         GWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631487; x=1695236287;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBj6p++Qh8jXWGI/WFi0CSgU27ebTJ4j3bK1DZUl5Kw=;
        b=qH9jC1ivDwE9We1BZt2BZmql17MXNehn4sRs4ZFF/M/3wv/+4DiLSkgKvNI225oZln
         n/JuJl0AY2uF4r79QjQcDtZ2RB2pPIVF4DZWh6o5vioFyAXLzXpfZpnZ7tbGKHJRCm/K
         xBin/JQRr5ii8mLKfUJWJ9JoUJ9rvwZYaQvTu5ZTbyWi+I1e3IXT/d827x3FCF481eUo
         JylfHOQZD+7EDEA1jXYfck959ZsiljE956CbdueS66pDwA3p7vC1b2ltIoCO1g0b6Ygv
         COogUgXkX2sZS5c+Y/Aog4kPeZ9Hp4VgPjQm/ZhTfBx4/huajqrgwrzK779YHa0pK/lY
         bLpQ==
X-Gm-Message-State: AOJu0Yynwy8+05uybxqhjrGc0qi3fptsNkBSAFENpvf5iBSDmt24VuB9
        Qx4l+5twzr+AfhppHMca8Omd099bTLP59Yxa1jEy
X-Google-Smtp-Source: AGHT+IGZ+D5kl00YHI2JJ6DcumX3Ia4Gk29qvxttKtG/Wae63pJv2LYrUq6RpLrHoCOwUoT3JNfEYF4H7ja4ubEBAAU=
X-Received: by 2002:a05:6512:159e:b0:500:af82:7ddc with SMTP id
 bp30-20020a056512159e00b00500af827ddcmr2618766lfb.28.1694631487079; Wed, 13
 Sep 2023 11:58:07 -0700 (PDT)
MIME-Version: 1.0
From:   Da Xue <da@libre.computer>
Date:   Wed, 13 Sep 2023 14:57:55 -0400
Message-ID: <CACqvRUb_X14pjaxA0Q7bQf53TAFmk5rjQOSWqx3Tvi4g+vcNMw@mail.gmail.com>
Subject: linux-stable 6.1.53 kernel crash on COLOR_ID_MULTI handling change
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

We have running systems that use COLOR_ID_MULTI. The GPIO toggles
between two colors and we have used the identifier. RGB is not a good
fit since it is not a RGB LED. Please provide guidance.

This patch causes the system to not start: f741121a2251 leds: Fix
BUG_ON check for LED_COLOR_ID_MULTI that is always false

It was also backported to stable causing previously booting systems to
no longer boot.

Best,
Da Xue
