Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875CB7C4E65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJKJVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjJKJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:21:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EA691;
        Wed, 11 Oct 2023 02:21:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB7C433C8;
        Wed, 11 Oct 2023 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697016079;
        bh=3pErmMLXBZsb29R9HnOmK6xrUTNWs9hBhZaadCT77w8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fdM2wih+iuPvtBZe0BJvHVwvgUAopMOVwNYxPZOlg8MpaBPkMUtpJVjQtQ3Lsun4y
         UVz9KZ+8oYkNSgQIGqgooWUV1Az/SFWjilFP2Z/AtXCS19tIGBIo+a/hA9jIWiW49K
         I9/lXmL2HQ+mlH6i+eJG/jpbY0YAk4cPbC1/gpT1jlJ1mtb4oVkq19RV/thThyc/Av
         wu9zaieb2XZPXwxup6xAUNlzaryW7Fv+DxGKIX2LQ8le16etfIMogRb6QWfgyBzBts
         BZwmpglnHtC7ZUIDYJr2jD5iYAGbyd6QlQDma88y4PlC2ihzUTS/sVi2xTQIqB8JKT
         t3Ga2NLjlWsfA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: brcmfmac: fweh: Add __counted_by for struct
 brcmf_fweh_queue_item and use struct_size()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZSRzrIe0345eymk2@work>
References: <ZSRzrIe0345eymk2@work>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169701607495.2760941.7574229474626886892.kvalo@kernel.org>
Date:   Wed, 11 Oct 2023 09:21:16 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `event->datalen = datalen;` to before calling
> `memcpy(event->data, data, datalen);`, so that the __counted_by
> annotation has effect, and flex-array member `data` can be properly
> bounds-checked at run-time.
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

62d19b358088 wifi: brcmfmac: fweh: Add __counted_by for struct brcmf_fweh_queue_item and use struct_size()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZSRzrIe0345eymk2@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

