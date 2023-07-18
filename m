Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F576758566
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGRTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGRTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F89F4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0638661523
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A735C433C7;
        Tue, 18 Jul 2023 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689707477;
        bh=+HkpbelCVxn3hOwtOAxEdmpD4XslKX+FgXDJ+ENvVgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KCMkYmrQJpNZM04XeQ6zBXZEf2AK/rMj/xkiSERCQyaEgIElHFzB07LxBiVPm1tzc
         3kc103duv7hL8yjHjr4grD7j15LznrGfsNl0gcw+6mWpQpISYnTiUgRAnLg7XGFNWX
         Kp8aI2EHhnYlGJT+G3skxQ/YfSwVM3soBuMzXx1XzKBtWKFwvwF/0/q5Nm5Tzwth0g
         cQvUwunVeBs1zDKSPnSLGns27WtjxXhx4BlenPBoJaUQl78mJScCN0ENPfL4oz5D1+
         o8za7tOeubfIJm+eiVhzFUSliDpJ+N3lfG/WoF9PqKDH20DcTpjMfi9T54yur4I5x7
         ojCK/S1bdMwUA==
Date:   Tue, 18 Jul 2023 12:11:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <kees@kernel.org>
Cc:     justinstitt@google.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
Message-ID: <20230718121116.72267fff@kernel.org>
In-Reply-To: <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
        <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
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

On Tue, 18 Jul 2023 11:05:23 -0700 Kees Cook wrote:
> Honestly I find the entire get_strings API to be very fragile given
> the lack of passing the length of the buffer, instead depending on
> the string set length lookups in each callback, but refactoring that
> looks like a ton of work for an uncertain benefit.

We have been adding better APIs for long term, and a print helper short
term - ethtool_sprintf(). Should we use ethtool_sprintf() here?
