Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6D80A16D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjLHKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjLHKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:47:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37214115
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:47:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1db6c63028so218070366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702032471; x=1702637271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbYClq4FcbeZMcHFn0kwMhdGOFeMgZTEvuPsGyoaMAc=;
        b=NK7ny4V8whb6Wb37ow7DlaXJmjpViN7s55MkMi4OqNXPByLDwrU9TweNC+Be6N3THq
         PgpFi5SSmXwonstoDxWzG8sU8IuGScfs5fLsC37xV34NtJ8IQ7cVOiCepiCZNdN5mLDT
         7aHoYQHMR6UxWNVLy9PBkPfY0lzsXF3IoIz0Xc4dRgpITK3hx8G2o6rf14x8l5uUv+ny
         FbbF3pWrFGjYd1D4ENCooFSzHsT7REa7wdIHpKOPnQo/C0PzLyk57v+apI1iiunO7nCB
         ociu5BboX50XiQKs580yxUCen7JvRKEaBP5GMjdRad5zMCecNgHBcRNHVo3P7bCPcutJ
         cMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032471; x=1702637271;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbYClq4FcbeZMcHFn0kwMhdGOFeMgZTEvuPsGyoaMAc=;
        b=cMKdCD1+QGxTVr/rgLd4FMUpmOBJSj+UXa2DfluGowxaCgoOJtqzjg1wy5IoSo3d54
         7cFYJ1hW+lKFJdpqAvKexhcg91WnD2+4M3hRy4BOn8VAhIgdjv6kP5uhcJLfGmejAEdS
         0A5xxSLmLzvX3Lt5/k/kQpdsPzFSP+L6i+u3cqLYzoMJKDXIUsoEkYBBlHCjyIqloQIP
         /SZKfI2U7ujKq28GJGaxUppkL8JJyOyeJKnoEvxtjYuK2HCb/Yw38O6X5jzBu7Pid8wO
         MKK1TmUa0iVzsM9uiv4/8ysj5a2cW0Gc47ynnyvaz3FwryNfKLt9mI8Rrq1cwOOP0JGX
         8ddw==
X-Gm-Message-State: AOJu0YxEQ7+22+ndwu1GuC2Lq8X5MSyhnBxNpZvnZks1j7ZK674JvfFk
        xO8LUCo18eZHN99rWy/w9MVUfw==
X-Google-Smtp-Source: AGHT+IGSCrTzRV8IkVolIcaOtPb48G1BqiXuhcE4aKZo5GC5CLRz1fMqONJ7Hf0tNgL5FrWP1fQiJg==
X-Received: by 2002:a17:906:2206:b0:a19:a19a:ea96 with SMTP id s6-20020a170906220600b00a19a19aea96mr2444079ejs.79.1702032471577;
        Fri, 08 Dec 2023 02:47:51 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ub26-20020a170907c81a00b00a1c96e987c4sm858867ejc.101.2023.12.08.02.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:47:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v14 0/8] NVMEM cells in sysfs
Message-Id: <170203247041.19230.6088380778885293722.b4-ty@linaro.org>
Date:   Fri, 08 Dec 2023 10:47:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2023 17:37:29 +0100, Miquel Raynal wrote:
> As part of a previous effort, support for dynamic NVMEM layouts was
> brought into mainline, helping a lot in getting information from NVMEM
> devices at non-static locations. One common example of NVMEM cell is the
> MAC address that must be used. Sometimes the cell content is mainly (or
> only) useful to the kernel, and sometimes it is not. Users might also
> want to know the content of cells such as: the manufacturing place and
> date, the hardware version, the unique ID, etc. Two possibilities in
> this case: either the users re-implement their own parser to go through
> the whole device and search for the information they want, or the kernel
> can expose the content of the cells if deemed relevant. This second
> approach sounds way more relevant than the first one to avoid useless
> code duplication, so here is a series bringing NVMEM cells content to
> the user through sysfs.
> 
> [...]

Applied, thanks!

[1/8] of: device: Export of_device_make_bus_id()
      commit: fae8c6013cea005d46b289177719b4f8169fad0f
[2/8] nvmem: Move of_nvmem_layout_get_container() in another header
      commit: cb46a339758f2692f7914dc5a71eda5828acac42
[3/8] nvmem: Create a header for internal sharing
      commit: c385b30e4c1dd5e24e3ed5b54eac96866f39c769
[4/8] nvmem: Simplify the ->add_cells() hook
      commit: e82d626e5acc5c352f29b9eab6fe833b367383be
[5/8] nvmem: Move and rename ->fixup_cell_info()
      commit: b596f5059da097bbc823cd93c89e807291c0fec3
[6/8] nvmem: core: Rework layouts to become regular devices
      commit: ed7778e43271c55d78ff458b826f4e989da72444
[7/8] ABI: sysfs-nvmem-cells: Expose cells through sysfs
      commit: eef7e7b605a90255622e253e092ef6da5a44405c
[8/8] nvmem: core: Expose cells through sysfs
      commit: 7e5d6434bbf3df3fae0e3d25a187be196928b663

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

