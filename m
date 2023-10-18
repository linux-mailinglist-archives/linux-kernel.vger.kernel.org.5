Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B57CD3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjJRGHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRGH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:07:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A0C4;
        Tue, 17 Oct 2023 23:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DEBC433C8;
        Wed, 18 Oct 2023 06:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697609248;
        bh=h/auq6HpOSLO/N4BVvzPRBs8wFljerSgSeyenywRUl4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=k14kdHnxqZ97agAIFMyDjHuczUDMuqPTAoLnzIWFM/jPbjraO7DPPFJFC4bivqoYY
         JUrGrG3gf2H1E5+HjEQyhA/kUpvKYZDW1vX1/mfoLEz36vdzWRBb9cuzmjwm7HDdBz
         ErG81JZoUVatTvvMWFjw4PVEXH9ux8VZ9/FVi7xx1VWYv3lEdqFRqjEQqyPMyqiymI
         zotak707hUoVBhZoqA7uDfLuGoarDlAd/657b3Fggk8958IssNB6Al2XRFLWx+XKIt
         Vr4VJCltmeYRZv6QYuHCPYLPLqVISx0UJRvMfqNhO8Lg81W4CHb6YqQeASv5wmx6EO
         ihCvlCrWBobyQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Simon Horman <horms@kernel.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] wifi: mt76: fix broken precal loading
 from MTD for mt7915
References: <20231017190510.27163-1-ansuelsmth@gmail.com>
Date:   Wed, 18 Oct 2023 09:10:07 +0300
In-Reply-To: <20231017190510.27163-1-ansuelsmth@gmail.com> (Christian
        Marangi's message of "Tue, 17 Oct 2023 21:05:05 +0200")
Message-ID: <87a5sgea0w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Marangi <ansuelsmth@gmail.com> writes:

> Commit 495184ac91bb ("mt76: mt7915: add support for applying
> pre-calibration data") was fundamentally broken and never worked.
>
> The idea (before NVMEM support) was to expand the MTD function and pass
> an additional offset. For normal EEPROM load the offset would always be
> 0. For the purpose of precal loading, an offset was passed that was
> internally the size of EEPROM, since precal data is right after the
> EEPROM.
>
> Problem is that the offset value passed is never handled and is actually
> overwrite by
>
> 	offset = be32_to_cpup(list);
> 	ret = mtd_read(mtd, offset, len, &retlen, eep);
>
> resulting in the passed offset value always ingnored. (and even passing
> garbage data as precal as the start of the EEPROM is getting read)
>
> Fix this by adding to the current offset value, the offset from DT to
> correctly read the piece of data at the requested location.
>
> Cc: stable@vger.kernel.org
> Fixes: 495184ac91bb ("mt76: mt7915: add support for applying pre-calibration data")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

mt76 patches go to Felix's tree, not net-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
