Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0D7A4721
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbjIRKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbjIRKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:32:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22C191;
        Mon, 18 Sep 2023 03:32:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9038D6607079;
        Mon, 18 Sep 2023 11:32:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695033148;
        bh=Uc7V1QnED3jqO7q91bCXab1gBM9VqY9HU30Ul0mVYpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzoSEqsNwon3ssPk59x0nv4g1mS0wowA87TrL3zpgUt5sR/z4pW+qKcP3YEAQ2N9B
         oLPelEgZ/EonnxadFgXEwzAoS/sCA1C3sT+vpR/mgqB/FyjsNHA9M3XOH8WiEaOu+H
         pwBA7rc7hDe8CKTTqloT2LUtAP59Mc1EEzncYp3tkSP0IH34ttzLDFOyo7nrNUf+ir
         8nAToLSw9zfHPQ+Lr3cn2rrEBHzohp0KeIqwtGHhLjrlWvyQzrZMcZPAKJZzJHGbgo
         +JLWocaKSPU7V1h52+BxdugDC8bw8WJ+MTEQEGem2v5A3yDWGaEMD33q57oOIMYYW7
         K6xx4Hb5u4sEw==
From:   Laura Nao <laura.nao@collabora.com>
To:     mathieu.poirier@linaro.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        andersson@kernel.org, angelogioacchino.delregno@collabora.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, tinghan.shen@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
Date:   Mon, 18 Sep 2023 12:31:41 +0200
Message-Id: <20230918103141.126271-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZQH2dG+l/dONUsyi@p14s>
References: <ZQH2dG+l/dONUsyi@p14s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Other than patch 2 and 14, I have applied this set.  The remaining patches will
> have to be resent to Matthias.

> Thanks,
> Mathieu

Hello,

With patch 2 missing, the SCP is not probed correctly anymore on asurada (MT8192) and kukui (MT8183). The mtk-scp driver relies on the existence of the `cros-ec-rpmsg` node in the dt to determine if the SCP is single or multicore. Without patch 2 the driver wrongly assumes the SCP on MT8192 and MT8183 are multicore, leading to the following errors during initialization:   

10696 04:33:59.126671  <3>[   15.465714] platform 10500000.scp:cros-ec: invalid resource (null)
10697 04:33:59.142855  <3>[   15.478560] platform 10500000.scp:cros-ec: Failed to parse and map sram memory
10698 04:33:59.149650  <3>[   15.486121] mtk-scp 10500000.scp: Failed to initialize core 0 rproc

The issue was caught by KernelCI, complete logs can be found here:
- asurada: https://storage.kernelci.org/next/master/next-20230914/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8192-asurada-spherion-r0.html
- kukui: https://storage.kernelci.org/next/master/next-20230914/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8183-kukui-jacuzzi-juniper-sku16.html

Reporting the issue so that patch 2 and 14 can be resent and merged soon.

Best,

Laura

