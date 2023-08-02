Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8220776D468
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHBQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A31706;
        Wed,  2 Aug 2023 09:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D3F61A0D;
        Wed,  2 Aug 2023 16:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD5C433C8;
        Wed,  2 Aug 2023 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995365;
        bh=p1sOEq/Q5nf8WlIzq4mgPmomVrjieac3zXBR6jgM+OU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OvN2f/YWa13qB7U/C1Y1ULILB3AHOJkcW25odca03FJ/yyeEdSMQ6A7kl/s80T1qZ
         kwCbLAgLc9moV6NqBoANm0Np/D9q5JlFycmREfmKm0AjcyF924bAsJyQiJWz/h06H1
         YzzkcYNIu3g+po5M7REs+zOGgNlxZtfBwk0pVScvpr2K6Kji4WFtyJvWxDmVL7EglQ
         LR9UTNKTWxdZF3U7PCWVUxzLH4hl0c3+Esh6gVM+8ys34z2zs13Y6tu3x6ogQX03QA
         /Q75UwbQanIYD5BelieZVmojpHi5XCrPbw5NbOmOyTleOYyF8MvrSSW5LqNwpaP5OP
         u5Nwz/NX3n9rA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath12k: fix memcpy array overflow in
 ath12k_peer_assoc_h_he
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230703123737.3420464-1-arnd@kernel.org>
References: <20230703123737.3420464-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Karthik M <quic_karm@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Aishwarya R <quic_aisr@quicinc.com>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099536007.463701.11948665209748140465.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 16:56:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> Two memory copies in this function copy from a short array into a longer one,
> using the wrong size, which leads to an out-of-bounds access:
> 
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
>                         ^
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> 2 errors generated.
> 
> Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

603cf6c2fcdc wifi: ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230703123737.3420464-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

