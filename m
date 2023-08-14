Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1C77B91E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjHNM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjHNM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:57:00 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D494
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:57:00 -0700 (PDT)
Date:   Mon, 14 Aug 2023 12:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1692017816; x=1692277016;
        bh=3N+l2NZRGlQb/R0/dlIDoRug+/pgm9kbFpsypbJwJkA=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=QqKPyHG4RAwO/Q8/IAFOtwNgHHNyvTLNVBE4Asy/2Mii0YsDoX8fHFuD+DRLX/m7b
         X5DW4cXL8C/7YlrvCnt2GxrwuKUs+CSgex1WA7thDPrvAzv0vU8rEIpBt2d0htocuH
         qqSxPbJj84yBHyGVUHftudPsFrSmbaJCKf0fbvuL6QtVOAV1vG8oyhIVZa6xsTGRe7
         8P5caQvlLukoxzBs9Y55nsoFsoQrwZhQkf5zgxC1lS9yKaKMXsnKihurVw7nvsmeNJ
         h+3kI6X8Ra1UKGyFXV1rhZ7TGWMgru2sYnKP0KYNoLSxhUIv+fnt7vLC7EszP2npPE
         EKULO6rLStVCQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Blair Strater <strater@protonmail.com>
Subject: 5.10.189 and 5.10.190 breaks nested virtualization
Message-ID: <RyxwdfAZ2mHvlqqVVbFdCK5cQnWoOE_qz1LwSFfuXyoj0EvkDn1-TacV_C0GezxY901qUnRersvHSni9sewNZT7sGe8rKQ8OOCdAA5Bi940=@protonmail.com>
Feedback-ID: 2450188:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the request at https://lwn.net/Articles/940798/, I'm reaching out to le=
t you know that this patch breaks nested virtualization on AMD processors.

I've tested 5.10.189 and 5.10.190 on the "outer" virtual host, and both Deb=
ian 12 running libvirt, and Proxmox 7 as "inner" hosts. For Debian, the nes=
ted VM fails to start at all, and consumes the entirety of one CPU core. Fo=
r Proxmox, 100-200MB/second of memory is allocated and never released, and =
also the guest fails to start. The problems go away when taking the outer h=
ost back to 5.10.188.

The processor in question is a Ryzen 7 2700. The kernel revision for Proxmo=
x is 5.15.108-1-pve, and the kernel revision for Debian 12 is 6.1.0-11-amd6=
4. I've run into another person who can confirm that this bug also occurs i=
n the 6.4 series, "somewhere between 6.4.3 and 6.4.9", 6.4.9 being the like=
ly culprit.

Please let me know if you need any other information.=20

I apologize for bothering an entire mailing list, Greg's email bot told me =
to. 
