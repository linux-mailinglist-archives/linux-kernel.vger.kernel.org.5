Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF95975CA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjGUOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGUOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:37:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13852E68;
        Fri, 21 Jul 2023 07:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6AF61B41;
        Fri, 21 Jul 2023 14:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7671FC433C7;
        Fri, 21 Jul 2023 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950223;
        bh=TAtVRatQJl7dp+O8SxA2iZNWmvzPDyQDzJ+19l+YMPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jr1bpJYXgtl6kH7UuJx2WoWg4zRlM14AAfNfU40kal/bQWfMfCoNDOwcS8vuCiNb4
         wLu8gn+dumG1/je/9W115PNjpPz/I3SzSOYR6kS/hRv7m/LU2a4ALWVB4EYu8GUiXq
         sRgBPMfHvuavOl3TzThwDlwMjR3RpfGF7Pvl+8hj5k9yxDwD7m8B1nESPns4rQ2E3q
         qiZg/TJo/YYQL+hf+3r2OecLWy2DkX0ad/o/IOIbKnbWNIxGUbSDtJ/IESBENNO1oj
         pRuPeiqEV4TAie6sd8rSCDLMIgi5y5L0fVoXmVVlFiUGcaGfyq5ISw1jbPbcfRpsX1
         3zY0iA6uS851w==
Date:   Fri, 21 Jul 2023 07:37:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Paul Fertser <fercerpav@gmail.com>, linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
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
Message-ID: <20230721073701.38f8479c@kernel.org>
In-Reply-To: <00a2f5ba-7f46-641c-2c0e-e8ecb1356df8@nbd.name>
References: <20230605073408.8699-1-fercerpav@gmail.com>
        <00a2f5ba-7f46-641c-2c0e-e8ecb1356df8@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 10:03:49 +0200 Felix Fietkau wrote:
> On 05.06.23 09:34, Paul Fertser wrote:
> > On DBDC devices the first (internal) phy is only capable of using
> > 2.4 GHz band, and the 5 GHz band is exposed via a separate phy object,
> > so avoid the false advertising.
> > 
> > Reported-by: Rani Hod <rani.hod@gmail.com>
> > Closes: https://github.com/openwrt/openwrt/pull/12361
> > Fixes: 7660a1bd0c22 ("mt76: mt7615: register ext_phy if DBDC is detected")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>  
> Acked-by: Felix Fietkau <nbd@nbd.name>
> 
> Jakub, could you please pick this one up for 6.5?

Kalle reported that he's back to wireless duties a few hours after you
posted so just to avoid any confusion - I'll leave this one to Kalle
unless told otherwise.
