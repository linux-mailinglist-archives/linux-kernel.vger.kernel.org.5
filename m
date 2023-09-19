Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7F7A5DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjISJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:26:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136EC18D;
        Tue, 19 Sep 2023 02:26:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D88376607079;
        Tue, 19 Sep 2023 10:26:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695115572;
        bh=Tf/Prg/AWcVMPn6dgYGWrU1QgYEEKFn1/Ywarvh6ym4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HDUhaWZt8TuD3XKxH/iiRo4TzTt4G/JlQsAcpK4cSv/F9wbyi/Y/8/4hS+fH8t9B/
         mfO4hvMtfhKGUPKxDQzFZAdKt3v00q9EuHvZcTs9fDOcYeCRpMJOf77AaraQgtjQ0z
         eQlV/c28MwSvr5zk9nbt7mAZZIgg6pyC6bdbZBisigrClo+ZMDtUrOnEUlwkoGjBfk
         GXsOgg4VUSEO5SE1NE2G/mACTqYwzqG9Cl0W8A75yHHBWNtJoR9ZUxnH8yVUNUBQmy
         30gV8II1kz2JAnzuw7uDINiucKXaKW4A6PMEBGSla0VM9YsDNrMpy4V/IhHthw3PQn
         lKB82uA+cxEFw==
Message-ID: <13843095-0906-804e-ffbe-36625ebe05cf@collabora.com>
Date:   Tue, 19 Sep 2023 11:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] remoteproc: mediatek: Detect single/multi core SCP with
 rpmsg-name property
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>
References: <20230919050305.3817347-1-wenst@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919050305.3817347-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/23 07:03, Chen-Yu Tsai ha scritto:
> In the just landed multi-core SCP work, detection of single/multi core
> SCP is done by checking the immediate child node of the SCP complex
> device node. In the original work this was done by matching the child
> node's name. However the name wasn't previously standardized. This
> resulted in breakage on MT8183 and MT8192 Chromebooks while the driver
> side changes were picked up and the device tree changes were not picked
> up.
> 
> Instead, match against the "mediatek,rpmsg-name" property, which is
> required to be present in the rpmsg sub-node. This makes the
> aforementioned devices running old device trees working again.
> 
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> The patch is based on next-20230918 with a whole bunch of local patches
> stacked on top. None of my local patches are related to remoteproc, so
> it should be fine.
> 
> I tested on both MT8183 Juniper and MT8192 Hayato and on both systems
> the SCP successfully probed again.

Instead of checking "mediatek,rpmsg-name", I think that a better way of checking if
this is single or multi core is to count the number of cores...

I've sent my own version of this, please check [1].

[1]: 
https://lore.kernel.org/linux-remoteproc/20230919092336.51007-1-angelogioacchino.delregno@collabora.com/

Cheers,
Angelo

