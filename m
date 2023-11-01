Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73997DE717
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348060AbjKAUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:34:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7484DB;
        Wed,  1 Nov 2023 13:34:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso322058a12.1;
        Wed, 01 Nov 2023 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698870839; x=1699475639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/a1Dk27cCdhkJjwH5P/iX9LeZl5g3ELoZUoq2vgHjw=;
        b=THqfzTFIQXST8KN1Qevu0qqMG0xN9nm498MWAOau59stbmUE6bvXE/qYQxwtaX94wC
         7zEgO21JDS2fnClDbhER8uAEPutBIvvXxA0WwJ2URf+2xz4fYgy1dIsomfYVCVowYs7e
         ZTO52Jpz2BRl+fR5VC+c6P0TS3UiZJr3dwL4I8GVPqHRUomtc4mz3SosPtNL5gqgv4lU
         4/5Jij2dZQw2zm7MVmzButIAA5KFziqHy4dADMbwg1fiqOm2kD1d0LspqWgOS7KP8m2N
         BxEfr3RZIlPh+cnw72GoKA7T3lI5aQ9qLZnE+SubW+2GnBybs3+/hPzAYN6Qvtu34WWN
         yvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698870839; x=1699475639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/a1Dk27cCdhkJjwH5P/iX9LeZl5g3ELoZUoq2vgHjw=;
        b=phYkgQHfez6f7EDUpiFTyt6nX6etQjw1ucB5GVkxpOYT+XkA+5ML+/RzJLwbBQ2PRr
         AF3eI1/f9MYpidlCTNWVXaLvErRjDlJKPwyRhueQhvlSNFuFfe3HyozJ4TUth3k54wXD
         Z6r7KQFZ9NvpmC4xTH/lrWkrS0r7iJJafCTflKIS6BArXtD41F9rauTXfdtyO3z3eaNX
         GEc/whfoxq2lyzeRdqTbZjW1+DIwQg/wtJIoH889z3QQvXpQMRmAoSsVXk2sAArI7Qde
         M/wIC6Io2F0lmg22uW027cIhDlrgmgX3DILgfMyVYzAeHY7W08N9qJtNpYyB15xxqPNc
         oC8g==
X-Gm-Message-State: AOJu0Yxj7vAV5mF0ZPjjbl0g+HqeXI4QAFfVpZWthvpscuvtICQwo/MS
        gGsgJMvS5CpoWisofYYsY/w=
X-Google-Smtp-Source: AGHT+IGl05mGU709qsGrgcg8DzSoxstuVYnl9cTRAuXmjsuQM12ju0jFTR+gw/k7DrlOFYguTjwqLw==
X-Received: by 2002:a05:6402:74c:b0:53f:b964:ddb1 with SMTP id p12-20020a056402074c00b0053fb964ddb1mr14653343edy.37.1698870839174;
        Wed, 01 Nov 2023 13:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:f152:da56:1dc5:79c])
        by smtp.gmail.com with ESMTPSA id v17-20020a056402185100b005407ac82f4csm1427471edy.97.2023.11.01.13.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:33:58 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     n2h9z4@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, skhan@linuxfoundation.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: qca,ar7130-wdt: convert txt to yaml
Date:   Wed,  1 Nov 2023 21:33:57 +0100
Message-Id: <20231101203357.48478-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101202722.48056-1-n2h9z4@gmail.com>
References: <20231101202722.48056-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2: updated commit message. 

v1 patch: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231031201602.28827-1-n2h9z4@gmail.com/
