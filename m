Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714376CA84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjHBKJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjHBKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:09:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D22127;
        Wed,  2 Aug 2023 03:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3155261901;
        Wed,  2 Aug 2023 10:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC9FC433C7;
        Wed,  2 Aug 2023 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690970993;
        bh=UMEoQRgUVPsC3BWx0IHQ6DCuzr/VvMwJzcj3pFtnNDY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ckJG3usI3aMMkX3aNcnX762E4cPBrlRxfoXuMdksMne9WCeFgTPXshhFwBVxJg4hI
         bZeaFwTzONlhw5JdQYEtq8Hn9Pby/dGr3QWHgDnU+cHepjF/AAmNUI/PJF7ZR5XoZO
         px7pl/WNWxbl0t1m66w38i2MBhG7NkjvogxkajzCic813Pg6aow6D4pI7ir2w65XX4
         f8qx/tPR7cFmr+ExSJPWlvBBnxKVyIUJhNLNRHgHMrVPUGgq2RtjKBj6h/eG38FNWC
         xj+Wo+dJRycHmvaCsNqA2mO/mBui56EdFPOeZbajrjJsodp+lskGmhRiLWEfyFoYEO
         z/8etGaGCHlUg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mt76: Replace strlcpy() with strscpy()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169097098854.265879.2537978394359079455.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 10:09:50 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Azeem Shaikh <azeemshaikh38@gmail.com> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since DEV_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

d6b484b5cb2a wifi: mt76: Replace strlcpy() with strscpy()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230703181256.3712079-1-azeemshaikh38@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

