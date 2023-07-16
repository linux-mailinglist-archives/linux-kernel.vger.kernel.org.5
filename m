Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771B754FAA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGPQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14543E67;
        Sun, 16 Jul 2023 09:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D5760D42;
        Sun, 16 Jul 2023 16:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3103C433C7;
        Sun, 16 Jul 2023 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689524688;
        bh=c3PDNjaAmn7fUDUN3J87bGusnUVeCJEj80Th7o+O8UA=;
        h=Date:From:To:Subject:From;
        b=HpcK3FvZBXaSxDw5VeiUeOeoPU2g5aAPyJRIvmAAQe82E1Qa9N+ymQxGTkad0pG6b
         LwB+80EYeQfXuzCGb/r3wqJezfU7+9MCGGY2YiVXWnUsU19u6J/dWHlLC228qg71O9
         x2z5QUEWL910PtdVEECNRhvjyWgjLKGiUk+ofeBKIOBOzitr6A814RTACdMfrlT2R9
         wpVG4nwTG0u/cmExiGkeC3lqPQZElFpQxlpd5SxtF4B8b2yOXlFMji20rV87OS5xqr
         jZGdZBcLVYCnhpLVaSUtaB3l5ek7mHQowY4Zo+79Kjjplyd1D04ZnWlcxMCj9yhsbr
         wBC6aAgATmlPg==
Received: by pali.im (Postfix)
        id 86AEE70C; Sun, 16 Jul 2023 18:24:44 +0200 (CEST)
Date:   Sun, 16 Jul 2023 18:24:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Backporting commits for generating rpi dtb symbols to stable
Message-ID: <20230716162444.zzvkm4rh7s7lu37x@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see that raspberry pi bootloader throws ton of warnings when supplied
DTB file does not contain /__symbols__/ node.

On RPI 1B rev1 it looks like this:

dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found
dterror: no symbols found

Bootloader also propagates these warnings to kernel via dtb property
chosen/user-warnings and they can be read by simple command:

$ cat /sys/firmware/devicetree/base/chosen/user-warnings
...

Upstream Linux kernel build process by default does not generate
/__symbols__/ node for DTB files, but DTB files provided by raspberrypi
foundation have them for a longer time.

I wanted to look at this issue, but I figured out that it is already
solved by just recent Aurelien's patches:

e925743edc0d ("arm: dts: bcm: Enable device-tree overlay support for RPi devices")
3cdba279c5e9 ("arm64: dts: broadcom: Enable device-tree overlay support for RPi devices")

My testing showed that /__symbols__/ node is required by rpi bootloader
for overlay support even when overlayed DTB file does not use any DTB
symbol (and reference everything via full node path). So seems that
/__symbols__/ node is crucial for rpi bootloader even when symbols from
them are not used at all.

So I would like to ask, would you consider backporting these two
raspberry pi specific patches to stable kernel trees? Upstream kernel
would get rid of those bootloader warnings and also allow users to use
overlayed dtbs...

(Btw, do you know if raspberry pi foundation or broadcom provides source
code of that bootloader? It would be interesting to understand it or
maybe also fix it...)
