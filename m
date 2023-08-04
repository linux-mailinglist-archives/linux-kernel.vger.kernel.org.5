Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC7770288
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHDOGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjHDOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3825B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFDE62035
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50939C433C8;
        Fri,  4 Aug 2023 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691157969;
        bh=qtHfogqBy9GvhnaH42/BQBKi+pwaYr3MS+Z9Tn7YIlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emi4QO1UrYynPLegRJ3BGKoSmmEN5ciHG7N0mKLHs4ZtkbG3+OfLQtFPimuSy0avR
         BlvyGDASPx6Ej/3967Czj2YLukxsaZU/5Xre6KhILJJpKX5yXwk0EkfxkPAMXL5KiP
         ly8iyan170HQ2tode1Q495t9Xa7hYz+BMV0Fx1+U=
Date:   Fri, 4 Aug 2023 16:06:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
Message-ID: <2023080434-verbose-value-1200@gregkh>
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-9-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623145358.568971-9-yesshedi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:23:58PM +0530, Shreenidhi Shedi wrote:
> Currently Makefile.modinst does three tasks on each module built:
> - Install modules
> - Sign modules
> - Compress modules
> 
> All the above tasks happen from a single place.
> 
> This patch divides this task further and uses a different makefile for
> each task.
> Signing module logic is completely refactored and everything happens
> from a shell script now.
> 
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> ---
>  scripts/Makefile.compress |  53 ++++++++++++++++++
>  scripts/Makefile.install  |  66 +++++++++++++++++++++++
>  scripts/Makefile.modinst  | 111 +++-----------------------------------
>  scripts/Makefile.sign     |  37 +++++++++++++
>  scripts/signfile.sh       |  24 +++++++++
>  5 files changed, 186 insertions(+), 105 deletions(-)
>  create mode 100644 scripts/Makefile.compress
>  create mode 100644 scripts/Makefile.install
>  create mode 100644 scripts/Makefile.sign
>  create mode 100755 scripts/signfile.sh

As you are touching the build process, you should always cc: the proper
mailing list, and the KBUILD maintainer.  Please do so for this series,
as that is the proper tree for this to go through.

thanks,

greg k-h
