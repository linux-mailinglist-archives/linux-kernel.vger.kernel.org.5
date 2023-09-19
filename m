Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C247A5CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjISIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:45:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6EE6;
        Tue, 19 Sep 2023 01:45:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BA5B66057B6;
        Tue, 19 Sep 2023 09:45:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695113152;
        bh=I9ktfih0sa6jgd7LQe4oO4cl3jZWiRbZxvF64WAFJ64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnSgsG0+DeUNMB3HhUK/2fjxJJ/to9uV0+mEMUbGxMgn5t2b+Jh3bS9wdQkSguM8l
         ohclYn0BDKntkCsksU5VNp/OCyBcOUlJ2MPDv7MBUMD16oIKBPwNrILw+uvt444RH3
         XQRnP47sg5J8VHIFkFttZycmSSIpx72Y8evt9ijx6gU3lg7EKxSXWKIFzNDCtYe+H1
         ehb8qIyrmYO+LdfigxTeLaMFEHmVtBfmwx/TOx2mT66QKZ9depLeU79TUt7TqYkJ46
         652Es9yZyca6ibAYkQSY6Gl/QyqyDdv/QUxJne9hUM77KVxC1o36VWQjpW7e/VvZmK
         qMZJ1H6JNd23g==
From:   Laura Nao <laura.nao@collabora.com>
To:     mathieu.poirier@linaro.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        andersson@kernel.org, angelogioacchino.delregno@collabora.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        laura.nao@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, tinghan.shen@mediatek.com
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
Date:   Tue, 19 Sep 2023 10:45:52 +0200
Message-Id: <20230919084552.260918-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZQj16b1NvkDlij+H@p14s>
References: <ZQj16b1NvkDlij+H@p14s>
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

On 9/19/23 03:14, Mathieu Poirier wrote:
> On Mon, Sep 18, 2023 at 12:31:41PM +0200, Laura Nao wrote:
>>> Other than patch 2 and 14, I have applied this set.  The remaining patches will
>>> have to be resent to Matthias.
>>
>>> Thanks,
>>> Mathieu
>>
>> Hello,
>>
>> With patch 2 missing, the SCP is not probed correctly anymore on asurada (MT8192) and kukui (MT8183). The mtk-scp driver relies on the existence of the `cros-ec-rpmsg` node in the dt to determine if the SCP is single or multicore. Without patch 2 the driver wrongly assumes the SCP on MT8192 and MT8183 are multicore, leading to the following errors during initialization:
>>
>> 10696 04:33:59.126671  <3>[   15.465714] platform 10500000.scp:cros-ec: invalid resource (null)
>> 10697 04:33:59.142855  <3>[   15.478560] platform 10500000.scp:cros-ec: Failed to parse and map sram memory
>> 10698 04:33:59.149650  <3>[   15.486121] mtk-scp 10500000.scp: Failed to initialize core 0 rproc
>>
>> The issue was caught by KernelCI, complete logs can be found here:
>> - asurada: https://storage.kernelci.org/next/master/next-20230914/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8192-asurada-spherion-r0.html
>> - kukui: https://storage.kernelci.org/next/master/next-20230914/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8183-kukui-jacuzzi-juniper-sku16.html
>>
>> Reporting the issue so that patch 2 and 14 can be resent and merged soon.
>>
> 
> Apologies for the trouble here, the error is mine.
> 
> I have applied and pushed patch 02 - please confirm that things are working as
> expected now.  Matthias will need to either ack patch 14 or pick it up himself.
> 
> 

I confirm SCP is probed correctly on MT8192 (spherion) and MT8183 (juniper) on the remoteproc tree (for-next branch) now.
Thank you!

