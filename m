Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF447C6F79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbjJLNnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJLNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:43:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63894C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so11565955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697118198; x=1697722998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4IeBCo/H0Pkii9DyOhPHwFBC4JKR2N0oGI8kzrNC/Q=;
        b=AtvsKXrpLeKfPXHMjuujqjiGCr3UQQoBD+eAOsEnarrSDfBEvXAq67w2S+yreeMz6s
         j378W3nA3kROdKzqsmngPyKQy0/mXhPbybEVrbfeGjWxyt8U/BCLl+bJQnE5i2RTZv7x
         DgTxn+gKAhvGtrNkne/R8ZVnj7EZR9rlU+MWc32LJGIqJSJBP9fE5CTPb+1dJx85L96t
         t1LRvsGekSeD71iqTiVgxCEAtwE/kRJGteRNUc7+yBbggWK6N2Z/PGVMHielGVinhhso
         oI4UGNzJhsbN3TtqTrT+ac5IIVbsXmVITgQJvPD/eFI8itWK6dOCK6+WoIINJw+jjn3Z
         3cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118198; x=1697722998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4IeBCo/H0Pkii9DyOhPHwFBC4JKR2N0oGI8kzrNC/Q=;
        b=Ae9gV7KcSxntE88Gvi3UjfDwO3CjdwSJbK95t4uVKWTXVkzscjDWSIhvsWJ366y99x
         EzqxXu18wz1ZuwkUdl0xQ/xltPYJzwoSWmDwHR2iKmpFUOkP6zcdrJqZTf3iA4maU9Kf
         ZJ04EowLQF9RVWC2gOVy8TAQwHZwL51KexnhsHELLj6WlZJPURvnB2pTtOYwSc+H8OZk
         rnTMuJmeSSv+kjJZTBZPkjvx8bYHdg/BEtV+OzDUNbIlQiy1c/jCtNRGRb2raNxcM88S
         04sR1eiZh1hdEqWjfyT/4Owfd+k4JPPJJVc34UGv2nm8rC2DswiKhusb8ps1G3CLK1qW
         8NxQ==
X-Gm-Message-State: AOJu0YwfpEP1gV6hTu6zFeA/nShjOfjUk+GQOLHGb/T2fdGTsh2RHMp8
        T6Qil/HDt1QnC5elZwxCeiI9iA==
X-Google-Smtp-Source: AGHT+IHnRzeuBKH8ol++7BbrPtoIURuqIfw9VZZQIVVZiihXznuL1m4t1pel6YyqMJtEfqs+QX4oug==
X-Received: by 2002:a05:600c:2a4e:b0:405:7b92:4558 with SMTP id x14-20020a05600c2a4e00b004057b924558mr21413073wme.38.1697118197746;
        Thu, 12 Oct 2023 06:43:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000180800b00321773bb933sm18479932wrh.77.2023.10.12.06.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:43:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: Use device_get_match_data()
Date:   Thu, 12 Oct 2023 15:43:15 +0200
Message-Id: <169711819279.89425.3243909355897642178.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006224402.442078-1-robh@kernel.org>
References: <20231006224402.442078-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 17:44:01 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] memory: Use device_get_match_data()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/09de3691daab15ae125cbf32f9f72fc90eada49d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
