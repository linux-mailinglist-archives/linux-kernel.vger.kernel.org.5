Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C812F75DA50
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 08:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGVGXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 02:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGVGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 02:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DB10E;
        Fri, 21 Jul 2023 23:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6476F60B99;
        Sat, 22 Jul 2023 06:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23582C433C8;
        Sat, 22 Jul 2023 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690006987;
        bh=ATt0mJH63hD11NsGO1CXJNXu6h7gACVARO144Twht50=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lrpv8S0y1i61UKW0kJN2SmXvdtQ/2eVs6CPM3ouaiY6RVD+ZLeJxE7aP/2isQU2GF
         YFGYStBGddsuVfDatpCqMKzbx0QNXobSYPnlKMs3Bg0FbOdh11jVqsIPsxioIoZuSa
         /BgqmsVhNXiPa+8l8kp8ZT1Ly0zvuy1OKFun3kLtTYwfVXlSr3jbghQKfpR704HR8V
         WnWQWjZs/0uTSBPcM7ABIoPTX9KDnJDcAVfXE3dnnw8IYLecATEUgsG4rEw2EcJqyt
         4BIXlDOb3YMbp1CDz9t6AvjVpangT9xN/jPvz1EqkRxyf4Ef3Wbud7I3agYId9YiSe
         rLvvNZqdHkbMQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, Paul Fertser <fercerpav@gmail.com>,
        linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Rani Hod <rani.hod@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7615: do not advertise 5 GHz on first phy of
 MT7615D (DBDC)
References: <20230605073408.8699-1-fercerpav@gmail.com>
        <00a2f5ba-7f46-641c-2c0e-e8ecb1356df8@nbd.name>
        <20230721073701.38f8479c@kernel.org>
Date:   Sat, 22 Jul 2023 09:23:03 +0300
In-Reply-To: <20230721073701.38f8479c@kernel.org> (Jakub Kicinski's message of
        "Fri, 21 Jul 2023 07:37:01 -0700")
Message-ID: <87jzus1n3s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 21 Jul 2023 10:03:49 +0200 Felix Fietkau wrote:
>> On 05.06.23 09:34, Paul Fertser wrote:
>> > On DBDC devices the first (internal) phy is only capable of using
>> > 2.4 GHz band, and the 5 GHz band is exposed via a separate phy object,
>> > so avoid the false advertising.
>> > 
>> > Reported-by: Rani Hod <rani.hod@gmail.com>
>> > Closes: https://github.com/openwrt/openwrt/pull/12361
>> > Fixes: 7660a1bd0c22 ("mt76: mt7615: register ext_phy if DBDC is detected")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>  
>> Acked-by: Felix Fietkau <nbd@nbd.name>
>> 
>> Jakub, could you please pick this one up for 6.5?
>
> Kalle reported that he's back to wireless duties a few hours after you
> posted so just to avoid any confusion - I'll leave this one to Kalle
> unless told otherwise.

Yup, I'm back. I assigned this to me on patchwork and planning to queue
for v6.5.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
