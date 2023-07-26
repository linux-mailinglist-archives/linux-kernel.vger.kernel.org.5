Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DD76328E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjGZJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGZJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:41:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0DDD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:41:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso53986495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690364489; x=1690969289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSuNg53H/eRmqu9mEiw63xexfk54mFabzvALVb5yShE=;
        b=S0iS+CY+pouZAcxIqo+d89jksUNc4fWf73fEJYRib6djRv72Oh51C/8jQ7RAut+VkF
         iq5Bxz83bzX/KO48YYb8tz2dy4xADrw1+itvPwSEcobI9kef+Fupjnf8JCC2X7U2e/dX
         t+sGxp/5CGuRmJ6hpUhGO3hPyfhOvEgfzcscoTRs6t6v8OsN0r9Hfl74E9Uu4cPIQyty
         +dFHUtw6cBnQ6hYMosO9zgDb9UGJWdmaskz9bfaiJDyBx0uDYrh5iqVX2sbusDTiClh9
         33GJUHQfBYprCfAdR7k8It5vVT0ZaVoHYFgsYngAQMMqdT3d1cz8zv1QSth8qbeaklSA
         bIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364489; x=1690969289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSuNg53H/eRmqu9mEiw63xexfk54mFabzvALVb5yShE=;
        b=QGlCPup+J6iiy8ZldwG8rxt9jR1APp0G59aM3rMuQy3CQwnKssHg/jMidUNF3W2HP7
         5n7uE9mjIB0g3NzOtrvo7e4saKePEeNkdENn507Zh8UlrZ1P8bTajlafvv9RpqHT812m
         FVB652rcs03CuRj01/96AoGWcqbWi7yMkCd+v7sMEk2jRPIujw3kLQ9d6WZP1ZARSgPS
         dfOqSV/5yh1hZ6uk51evkoQ7COz1W6qsb3p6fD6pNwsvId1tkzVR+Y7+vnWUGX3/tPkj
         RcyPj460rHSZ7bvNS/95lImoZfjp01vVuNWqkACnz6cgnIJOsJHiItWJwtZNjGDczFRp
         j/XQ==
X-Gm-Message-State: ABy/qLYUryET5CyOxtTUyiqWz15uBDQXn8LuSpozgUytuERZGh/RWwoY
        0IYrt0kJIgJrK9kd9Bj7KywuE4NiRe1Axuk03W8=
X-Google-Smtp-Source: APBJJlGRJt9iE6by5+r9JGU4yXGFwaxVzc3NGMwzAmPoj5/gcjzSnz3j5vCQ6TfkZHC03JCcSW5I3A==
X-Received: by 2002:a05:600c:2248:b0:3fc:500:db7c with SMTP id a8-20020a05600c224800b003fc0500db7cmr1032792wmm.21.1690364488671;
        Wed, 26 Jul 2023 02:41:28 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm1533964wmc.0.2023.07.26.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:41:28 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v4 00/11] mtd: spi-nor: spansion: Add support for Infineon S28HS02GT
Date:   Wed, 26 Jul 2023 12:41:25 +0300
Message-Id: <169036447855.16855.4782783762090892713.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=aVo6HXgzfBrWxmaR4b1LsmgS74bqiWlppyZxfX+Kpxs=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwOpDf/lTojLk8cVCknrG9ctqt9OLeiBYkIh/9 zcMsXgK3HKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDqQwAKCRBLVU9HpY0U 6fJMB/4+S1Jxsil9roPq0xcR28ApZzatZlmcxw6A5t4JR35sUGlrfpl7aA0F0X1N8X9cp/LCFqR xtRAo65Vlsk7+sakmjyS3A+BXDNsBneLqUND15J2D9zkm2c6IRf42c6gph8Ze2U1sivcSiv91Sd itNziotvW/2S2zaB9OPFn6j6t9rLGqBAkg36tJ81KYUhnan3nRi414PGn1mOsy7iyWFRljvlKzP /k8mrrtLOsjVLpyOUoQeR6LsNoikB0CbxDJOgTXGdctIZG5wrw/LARDOsoj41sYvnEZ2d06iZmx 9de1X5OCaLj6LOl++z/qdBIzm9WMk2fhzmVEvVtxvkJpgw3V
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 10:52:46 +0300, Tudor Ambarus wrote:
> v4:
> - define vreg_offset for S25FS256T in the post_sfdp hook. The goal
> is to use the same code base for both single and multi chip package
> flashes.
> - get rid of SPINOR_REG_CYPRESS_CFR{1,3,5}V as they are no longer used
> 

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[01/11] mtd: spi-nor: spansion: use CLPEF as an alternative to CLSR
        https://git.kernel.org/mtd/c/d534fd9787d5
[02/11] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
        https://git.kernel.org/mtd/c/1e611e104b9a
[03/11] mtd: spi-nor: spansion: prepare octal dtr methods for multi chip support
        https://git.kernel.org/mtd/c/c0aa05123f11
[04/11] mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
        https://git.kernel.org/mtd/c/362f786ea00a
[05/11] mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
        https://git.kernel.org/mtd/c/463d7cfd08d8
[06/11] mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
        https://git.kernel.org/mtd/c/7d896a94bf74
[07/11] mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
        https://git.kernel.org/mtd/c/eff9604390d6
[08/11] mtd: spi-nor: spansion: add support for S28HS02GT
        https://git.kernel.org/mtd/c/68a86d183390
[09/11] mtd: spi-nor: spansion: let SFDP determine the flash and sector size
        https://git.kernel.org/mtd/c/39133e5f559e
[10/11] mtd: spi-nor: spansion: switch s25hx_t to use vreg_offset for quad_enable()
        https://git.kernel.org/mtd/c/fb63bfad1e8f
[11/11] mtd: spi-nor: spansion: switch cypress_nor_get_page_size() to use vreg_offset
        https://git.kernel.org/mtd/c/aa517a29d645

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
