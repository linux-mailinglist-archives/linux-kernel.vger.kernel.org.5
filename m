Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D3777487
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHJJcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjHJJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E04D1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3763838a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659924; x=1692264724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx1EWsadjrbhivxUbU4pbbJ5OAeuz16OhPt1XfCI85U=;
        b=zeRwl+OJFXE6wnEfKEsHYxFsO8UGhC+4XW8LW4eq/yyAeHw1Iuc98jVrGHcrmP4S5i
         9ciWZWBl8kgGzdbucogdv9hbYa3qi8+3p9WcgmBu7zSn9SP32DWsS2m5TmO/0bCUl4Ze
         IdQB4akDzKYazUzjfAAO0jOuMYrtWlx+hJTcAOOXiy1uA6sx/r+u9WbTAPmWsY0Dlop3
         weyQf7IpkGMs2vx85xsU5ivMHEBropH7TDsLsFhHS8fGnkHtBT/We0U2gZMFvA/gux+x
         jTxgBvnngxzaUr9DiihuF6l8ZFcm+JAhVgPZglvI1Cdy3CT7z36XPmJlehHdm/RZQk2B
         HDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659924; x=1692264724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx1EWsadjrbhivxUbU4pbbJ5OAeuz16OhPt1XfCI85U=;
        b=M6xKjhM46fYACk4KfOjN7N5oBKmO91jfLEZWhD4nthCtlcQ6UN7N+MRhoZN72L+D8w
         WJ/AzTs2lwzP/mdzh8G4GJp4AAv+OVVDIGdbdXCUFKblim65qgHTzyZasr8/IFN9VkTi
         QjTDS/iKnvu5ElTQMRUV1Pl192T5ppV5fckD31tDHxwy3FaL7Tfy9s+NeXS/u1BMCNKl
         ovIQSJTn2jEqdkj59NmSdKDO8DHRG2Xekt6LAChYON3NUN1cTFSB+HD1p+SohI1+gGg+
         rcwtABqCwv9xYX8zFBwR8SawTtHk1QYTjzdFbF1f6jOwYF7eS7mSn4zVy4DRyY30VEER
         FAeA==
X-Gm-Message-State: AOJu0YyHQmkVm7R6fereUnvvq1ghjIk6RiTIkKNYpY21oVCrF1oAeBx4
        rrjACIxpOMW8gNdG3xm0Um/DDMNKWYPJBqQb2yqmkg==
X-Google-Smtp-Source: AGHT+IFbUyMP8o7JoUvDmuJ/hCd8KB+GUsO3M9ncRAcyh+Vpoxpz2CZUzT5NAFYQlFuMg+AyXMg6Pw==
X-Received: by 2002:a17:907:6e2a:b0:995:3c9e:a629 with SMTP id sd42-20020a1709076e2a00b009953c9ea629mr1769873ejc.31.1691659924482;
        Thu, 10 Aug 2023 02:32:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/15] hwmon: (ads7828) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:45 +0200
Message-Id: <20230810093157.94244-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  ads7828.c:142:10: error: cast to smaller integer type 'enum ads7828_chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/ads7828.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index e86894e35639..809e830f52a6 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -139,8 +139,7 @@ static int ads7828_probe(struct i2c_client *client)
 	}
 
 	if (client->dev.of_node)
-		chip = (enum ads7828_chips)
-			of_device_get_match_data(&client->dev);
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		chip = i2c_match_id(ads7828_device_ids, client)->driver_data;
 
-- 
2.34.1

