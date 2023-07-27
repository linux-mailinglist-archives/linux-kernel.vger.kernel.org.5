Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F901765838
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjG0QCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjG0QCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2E30E8;
        Thu, 27 Jul 2023 09:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D65AE61EBA;
        Thu, 27 Jul 2023 16:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E97BC433C8;
        Thu, 27 Jul 2023 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690473755;
        bh=q5mETferSRGLwrNdOWNUESPMpdTdxLeCdKKRjZZCd+M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h1il80scsWCuQ64co6z4Ep9iBudgtmt8tkWPPLDS4ViHeaVpGiJi7OCd+xBOWef8w
         7PW50yrHVRCdSsXPJDxpX6XsF3KhZdnh8Nq+YDbKfLGxtXxuuriJ9Zth30iETDEVsU
         9DTSgksTiDLMkAzIm9uSbcWB4YkeQYhQPPM2+CpDVDZAMmG9xP39YYfTfDPkZ5Gwu7
         pUXPjqkPMsta2gBkR3zokTpPFj6q+SgTlnMBgV9i3ONnQc5vWM2Vihq/CCZMtkJi1R
         sdEOK8yVhhjOWue6K4qHTn7wx4N56KJPlIxuXNYebnPx8AFIPdyycV2dLeA44Kf0yn
         +3wGO5c38EQHQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
        <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
Date:   Thu, 27 Jul 2023 19:02:31 +0300
In-Reply-To: <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
        (Kees Cook's message of "Thu, 27 Jul 2023 08:52:56 -0700")
Message-ID: <87pm4dz6js.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, 10 Jul 2023 03:06:25 +0000, Azeem Shaikh wrote:
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy() here with strscpy().
>> 
>> [...]
>
> Applied, thanks!
>
> [1/1] wifi: mwifiex: Replace strlcpy with strscpy
>       https://git.kernel.org/kees/c/5469fb73e96d

And the same question here, why are you taking wifi patches without
acks? And this already fixed differently in wireless-next so our trees
conflict now:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=caf9ead2c7d06fd7aa4cb48bd569ad61db9a0b4a

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
