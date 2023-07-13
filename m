Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421A751685
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjGMCzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjGMCzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:55:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599AF172C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:55:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9922d6f003cso41194366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689216941; x=1691808941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqHNrvvkveMwsMIqHlQIoLwl5eBjuqONVWnhr/JLhn4=;
        b=eN3jdarnvR4nznoLzK5zUTHii6qCOqiXtRfjVHaIKMWuDMIfKvXB9YAaZN0nPQZHS2
         jmRUIHLQkhWW9BGmgZtsOQHcveti4AuVEW/S9uGGT+wOUTQjND5SbxcxYKfB6RmcaLXs
         nFyTSF2nebvS9+s1Mtpn5L4RxA/a7tQkd5CKYm7feh2z4QFSNczwcLbKK2VtNoMSKWMb
         LtDwQ6cDPK/7p39M+mmIm66zaa85bP7YagJQaoj4rWoh9eRqYoLx8l4rn/G0fmDzF4KF
         VusrS4GtDL5ZTsRL3EUP2R/sgV+Ra/+IBIZI7NjrgpLI1mpU1T1XOKWpgwunTN9EURO3
         JImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689216941; x=1691808941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqHNrvvkveMwsMIqHlQIoLwl5eBjuqONVWnhr/JLhn4=;
        b=UIMWDSkQtTWV/MOmKeXmyz7MXKlzWaWkxfXOnZxScUukgO4Ge1rThRJrzx1iTFcHb3
         MXOda8PbbJ0R2SeQlG048AQ45TcGmrJKZbZHovq0VOiMT90n9I2WxFSmN/a5aGZ0YITk
         G6M4uD+LfeivKBvRXzyTOZpQf8TwuHpqiUGhBEzQyPKyG9lrWrrR68wHPr1frsPYeoZn
         UzXS07al/Sl8A4Ns4OWHaqrRWyp4JE7IjRcxZfjUcvnFZcnMbb9JTx7uJK/Xfpy3Xpvt
         PN0DlM2aeTueTuUzGYuF29OPo46cAWctu3X8Tj23SX8P+KfIgIaR5X4365wr7tA3sfi4
         6MFg==
X-Gm-Message-State: ABy/qLZIwZfgxKLnyhhUAT6k2uYqyu+xBGTZ9uETbRAJeE/m53l+fgC9
        5Q4uGxjPAA69WVDRm1WdC9e+DA==
X-Google-Smtp-Source: APBJJlGDnMuzqlM3S/oG7hu9iHGq/oNkTsE/4WQGNO7n9X4+zCDTU3xH98c4a1bZOahAZ8hZSg4SVQ==
X-Received: by 2002:a17:906:2da:b0:994:30bf:5d4f with SMTP id 26-20020a17090602da00b0099430bf5d4fmr191988ejk.43.1689216940902;
        Wed, 12 Jul 2023 19:55:40 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0098e2eaec394sm3370236ejb.101.2023.07.12.19.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:55:40 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, git@amd.com,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
Subject: Re: [PATCH v4 0/2] mtd: spi-nor: Avoid setting SRWD bit in SR
Date:   Thu, 13 Jul 2023 05:55:34 +0300
Message-Id: <168921680625.27728.7198640017398565535.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630142233.63585-1-amit.kumar-mahapatra@amd.com>
References: <20230630142233.63585-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=TL4ydUNHMhdqUWLxKqFd7lLy6/tNy8U5gmeJJs96hZs=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkr2egmxlAykkZMsiy/cyeajbB6rZFaKpesMTmh Yq2b4bhul6JATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZK9noAAKCRBLVU9HpY0U 6cOvB/0e7UhW/YHvOwuKHQAjeP+VIVQrp+/QzlBBOeTrIbgqWMgMrMM/n5s5McDRv4JpX494XxJ 8TnIk2PifJVaM+qLC3p5UgQsvujGUsFoROBrpKfMxyrGeh4M5Vvg4Xqua1/D+6YDNVfGtEpHptZ 0V2UYr746KcBaa+ckfEtM4dvAm3Ij9Wn3t7UKpE/pTF5XtMQ7keQZ5vz133/vTv2oUp2rr6Q9FU 1Ke7UZ9/9Bno2Ha83CtRqUnOGxGQPoNYKf/kKd88NWp+JYJWq5/TlYd1pUMIztkKH98WP0Llrgv yxPiCp98V49f6xiBvlhnt9us6YmSm8hfwgbJCMc/YWhT5hia
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 19:52:31 +0530, Amit Kumar Mahapatra wrote:
> Setting the status register write disable (SRWD) bit in the status
> register (SR) with WP# signal of the flash not connected or wrongly tied to
> GND (that includes internal pull-downs), will configure the SR permanently
> as read-only. To avoid this a boolean type DT property "no-wp" is
> introduced. If this property is defined, the spi-nor doesn't set the SRWD
> bit in SR while performing flash protection operation.
> 
> [...]

Moved the of_property_read_bool() as suggested by Michael.
Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting SRWD bit in status register
      https://git.kernel.org/mtd/c/cfc2928cb213
[2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP# signal not connected
      https://git.kernel.org/mtd/c/18d7d01a0a0e

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
