Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25827CD690
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjJRIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbjJRIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3087101;
        Wed, 18 Oct 2023 01:31:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83B7C433C9;
        Wed, 18 Oct 2023 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617915;
        bh=7LzgGeipT9Qy5v1sgxiku72SEYU7sxO5+0HO8M6l8bQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qKt5ZdvwyBDhTdY/Carhf2QcB/N5BdLhJRXjIQrVpairy5npomajJthuzXG/OqMh2
         C1kfrrdgDAjJymrPiYciajAwXdHNovsfJ7E7dPk/SjXOiqANBCqssOV7JHUMt/Hr+m
         8uorOQF5OsYMl+g3YQLYWCeO3bRmfncZXtU9GJNc0sB8jwdvOSmJMibKZil+8bvLlM
         J8AX267eQ1RvwrJej9JPWj0POYBwQO6qzBRfEwzQc/99jITsmW1cqXrwCnQpeXMGUB
         cDz+et2TLAtyAJkhUoLSAkjeTcOku+n6c/FUc4TyLFzYrq23NR8vHMSxkIiGAX4bxP
         MdCNpOie3W88g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: replace deprecated strncpy with strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231013-strncpy-drivers-net-wireless-ath-ath5k-led-c-v1-1-3acb0b5a21f2@google.com>
References: <20231013-strncpy-drivers-net-wireless-ath-ath5k-led-c-v1-1-3acb0b5a21f2@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761791192.48072.4820317724523709074.kvalo@kernel.org>
Date:   Wed, 18 Oct 2023 08:31:53 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect led->name to be NUL-terminated based on the presence of a
> manual NUL-byte assignment.
> 
> This NUL-byte assignment was added in Commit daf9669bea30aa22 ("ath5k:
> ensure led name is null terminated"). If strscpy() had existed and had
> been used back when this code was written then potential bugs and the
> need to manually NUL-terminate could have been avoided. Since we now
> have the technology, let's use it :)
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding. If NUL-padding is required let's opt
> for strscpy_pad().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

24709752bfe8 wifi: ath5k: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013-strncpy-drivers-net-wireless-ath-ath5k-led-c-v1-1-3acb0b5a21f2@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

