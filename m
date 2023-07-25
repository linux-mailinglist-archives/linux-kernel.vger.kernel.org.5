Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0911D761D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjGYPPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjGYPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE1122;
        Tue, 25 Jul 2023 08:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACDB61772;
        Tue, 25 Jul 2023 15:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100FDC433C9;
        Tue, 25 Jul 2023 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690298121;
        bh=RmvXJQniU+i7HLbl6dRhfiZKgENABktX8gkiV4f0q8M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=przga2CDcnEzmCs2onvYBl9Ymr//YH/E9uKlgiASNYO56KWZThCdFzgPcnjY4Cm7W
         B/uh2aQaQNrhd57Cr8voAQAUWuI7h1yhvSiQlcLckPpwIuF4G6FghvlbDhzoJlc77q
         eoO3cxrviTG5Qzzqopx9IHdn3h98gvv1R8OiOrvp+5ma5Fty9BRbdDFxaMrpQP6ZHM
         nZm8+l9WsIN3fVW3EP/1JPJxXp03gAKSmPI9RQjW0b/D6MPllMJew5gZBnvsbJ6vR+
         gcUUdSdueA7z6RsZprEW2r5iGzN+LMgoyQoMTcG3UWaNNC4jq1Ca44TAFQRbNJxM+8
         B8daq1v+etd5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: mwifiex: Set WIPHY_FLAG_NETNS_OK flag
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230706093437.3380526-1-johannes.wiesboeck@aisec.fraunhofer.de>
References: <20230706093437.3380526-1-johannes.wiesboeck@aisec.fraunhofer.de>
To:     Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de>
Cc:     Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de>,
        =?utf-8?q?M?= =?utf-8?q?ichael_Wei=C3=9F?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029811729.3309254.16459474870595238976.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 15:15:18 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de> wrote:

> Allow moving the wiphy device for mwififex to a non-inital network
> namespace. Many wireless drivers enable this flag implicitly by
> initializing through the generic ieee80211_alloc_hw_nm function. As
> mwifiex does not utilize this function WIPHY_FLAG_NETNS_OK must be set
> explicitly.
> 
> Moving to network namespace and working connection tested using
> wpa_supplicant from a network namespace as well as from a container on
> GyroidOS. The hardware was the Toradex Apalis i.MX8QM Board using the
> Azurewave AW-CM276NF wireless module.
> 
> Signed-off-by: Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de>
> Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>

Patch applied to wireless-next.git, thanks.

7ee92f6b4160 wifi: mwifiex: Set WIPHY_FLAG_NETNS_OK flag

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230706093437.3380526-1-johannes.wiesboeck@aisec.fraunhofer.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

